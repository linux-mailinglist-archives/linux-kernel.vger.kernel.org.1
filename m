Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27946300151
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbhAVLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:18:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:6231 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbhAVLDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:03:03 -0500
IronPort-SDR: xhyhGR9XWQYhN4jjEvxMiFdRVzoB6osyoLMRIzD+9rjoXYfELK5UrxJ3+sqkNHQnmrXQylVYJs
 6qmLfB6XyK+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="158610189"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="158610189"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:02:14 -0800
IronPort-SDR: bLVEFnVOzRcA+YKa9bYVvciAGK4hoo8+BLUTe8p4Bo96bPhyCRTuDncjhBi9upYRQ58AbO9Mhi
 TQ8gh97Hv++g==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="355210034"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:02:10 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v8 07/18] virt: acrn: Introduce an ioctl to set vCPU registers state
Date:   Fri, 22 Jan 2021 19:01:11 +0800
Message-Id: <20210122110122.45800-8-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210122110122.45800-1-shuo.a.liu@intel.com>
References: <20210122110122.45800-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

A virtual CPU of User VM has different context due to the different
registers state. ACRN userspace needs to set the virtual CPU
registers state (e.g. giving a initial registers state to a virtual
BSP of a User VM).

HSM provides an ioctl ACRN_IOCTL_SET_VCPU_REGS to do the virtual CPU
registers state setting. The ioctl passes the registers state from ACRN
userspace to the hypervisor directly.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/hsm.c       |  34 +++++++++-
 drivers/virt/acrn/hypercall.h |  13 ++++
 include/uapi/linux/acrn.h     | 119 ++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 5fd933471683..ee5cc7413239 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -9,6 +9,7 @@
  *	Yakui Zhao <yakui.zhao@intel.com>
  */
 
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -46,7 +47,8 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 {
 	struct acrn_vm *vm = filp->private_data;
 	struct acrn_vm_creation *vm_param;
-	int ret = 0;
+	struct acrn_vcpu_regs *cpu_regs;
+	int i, ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
 		dev_dbg(acrn_dev.this_device,
@@ -100,6 +102,36 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	case ACRN_IOCTL_DESTROY_VM:
 		ret = acrn_vm_destroy(vm);
 		break;
+	case ACRN_IOCTL_SET_VCPU_REGS:
+		cpu_regs = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_vcpu_regs));
+		if (IS_ERR(cpu_regs))
+			return PTR_ERR(cpu_regs);
+
+		for (i = 0; i < ARRAY_SIZE(cpu_regs->reserved); i++)
+			if (cpu_regs->reserved[i])
+				return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_32); i++)
+			if (cpu_regs->vcpu_regs.reserved_32[i])
+				return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.reserved_64); i++)
+			if (cpu_regs->vcpu_regs.reserved_64[i])
+				return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(cpu_regs->vcpu_regs.gdt.reserved); i++)
+			if (cpu_regs->vcpu_regs.gdt.reserved[i] |
+			    cpu_regs->vcpu_regs.idt.reserved[i])
+				return -EINVAL;
+
+		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to set regs state of VM%u!\n",
+				vm->vmid);
+		kfree(cpu_regs);
+		break;
 	default:
 		dev_dbg(acrn_dev.this_device, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index 426b66cadb1f..f29cfae08862 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -19,6 +19,7 @@
 #define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
 #define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
 #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
+#define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
 
 /**
  * hcall_create_vm() - Create a User VM
@@ -75,4 +76,16 @@ static inline long hcall_reset_vm(u64 vmid)
 	return acrn_hypercall1(HC_RESET_VM, vmid);
 }
 
+/**
+ * hcall_set_vcpu_regs() - Set up registers of virtual CPU of a User VM
+ * @vmid:	User VM ID
+ * @regs_state:	Service VM GPA of registers state
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
+{
+	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 32521168075f..775c58bad026 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -38,6 +38,123 @@ struct acrn_vm_creation {
 	__u64	cpu_affinity;
 };
 
+/**
+ * struct acrn_gp_regs - General registers of a User VM
+ * @rax:	Value of register RAX
+ * @rcx:	Value of register RCX
+ * @rdx:	Value of register RDX
+ * @rbx:	Value of register RBX
+ * @rsp:	Value of register RSP
+ * @rbp:	Value of register RBP
+ * @rsi:	Value of register RSI
+ * @rdi:	Value of register RDI
+ * @r8:		Value of register R8
+ * @r9:		Value of register R9
+ * @r10:	Value of register R10
+ * @r11:	Value of register R11
+ * @r12:	Value of register R12
+ * @r13:	Value of register R13
+ * @r14:	Value of register R14
+ * @r15:	Value of register R15
+ */
+struct acrn_gp_regs {
+	__le64	rax;
+	__le64	rcx;
+	__le64	rdx;
+	__le64	rbx;
+	__le64	rsp;
+	__le64	rbp;
+	__le64	rsi;
+	__le64	rdi;
+	__le64	r8;
+	__le64	r9;
+	__le64	r10;
+	__le64	r11;
+	__le64	r12;
+	__le64	r13;
+	__le64	r14;
+	__le64	r15;
+};
+
+/**
+ * struct acrn_descriptor_ptr - Segment descriptor table of a User VM.
+ * @limit:	Limit field.
+ * @base:	Base field.
+ * @reserved:	Reserved and must be 0.
+ */
+struct acrn_descriptor_ptr {
+	__le16	limit;
+	__le64	base;
+	__le16	reserved[3];
+} __attribute__ ((__packed__));
+
+/**
+ * struct acrn_regs - Registers structure of a User VM
+ * @gprs:		General registers
+ * @gdt:		Global Descriptor Table
+ * @idt:		Interrupt Descriptor Table
+ * @rip:		Value of register RIP
+ * @cs_base:		Base of code segment selector
+ * @cr0:		Value of register CR0
+ * @cr4:		Value of register CR4
+ * @cr3:		Value of register CR3
+ * @ia32_efer:		Value of IA32_EFER MSR
+ * @rflags:		Value of regsiter RFLAGS
+ * @reserved_64:	Reserved and must be 0
+ * @cs_ar:		Attribute field of code segment selector
+ * @cs_limit:		Limit field of code segment selector
+ * @reserved_32:	Reserved and must be 0
+ * @cs_sel:		Value of code segment selector
+ * @ss_sel:		Value of stack segment selector
+ * @ds_sel:		Value of data segment selector
+ * @es_sel:		Value of extra segment selector
+ * @fs_sel:		Value of FS selector
+ * @gs_sel:		Value of GS selector
+ * @ldt_sel:		Value of LDT descriptor selector
+ * @tr_sel:		Value of TSS descriptor selector
+ */
+struct acrn_regs {
+	struct acrn_gp_regs		gprs;
+	struct acrn_descriptor_ptr	gdt;
+	struct acrn_descriptor_ptr	idt;
+
+	__le64				rip;
+	__le64				cs_base;
+	__le64				cr0;
+	__le64				cr4;
+	__le64				cr3;
+	__le64				ia32_efer;
+	__le64				rflags;
+	__le64				reserved_64[4];
+
+	__le32				cs_ar;
+	__le32				cs_limit;
+	__le32				reserved_32[3];
+
+	__le16				cs_sel;
+	__le16				ss_sel;
+	__le16				ds_sel;
+	__le16				es_sel;
+	__le16				fs_sel;
+	__le16				gs_sel;
+	__le16				ldt_sel;
+	__le16				tr_sel;
+};
+
+/**
+ * struct acrn_vcpu_regs - Info of vCPU registers state
+ * @vcpu_id:	vCPU ID
+ * @reserved:	Reserved and must be 0
+ * @vcpu_regs:	vCPU registers state
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_vcpu_regs {
+	__u16			vcpu_id;
+	__u16			reserved[3];
+	struct acrn_regs	vcpu_regs;
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -54,5 +171,7 @@ struct acrn_vm_creation {
 	_IO(ACRN_IOCTL_TYPE, 0x13)
 #define ACRN_IOCTL_RESET_VM		\
 	_IO(ACRN_IOCTL_TYPE, 0x15)
+#define ACRN_IOCTL_SET_VCPU_REGS	\
+	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

