Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49529226C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgJSGTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:19:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:40604 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgJSGTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:19:07 -0400
IronPort-SDR: aQ+XwwJk4mk4d3GlmNQaMwg6OGyUfyMZGSmSgt8HYu4gzSOCR/jIw+j/1cn0KcoL6yNl/LvHsK
 49FHrKOKO2mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154766738"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="154766738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:19:06 -0700
IronPort-SDR: rRCNIpNung5Bf/gc5e1fWzCzW+y+UDn0yoXuPvZc0KMD0lrwK3cfHmpRAuee6+CSaWpMGQ08wQ
 NKqn7EoIkvRw==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="358049852"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:19:00 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v5 07/17] virt: acrn: Introduce an ioctl to set vCPU registers state
Date:   Mon, 19 Oct 2020 14:17:53 +0800
Message-Id: <20201019061803.13298-8-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019061803.13298-1-shuo.a.liu@intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
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
 drivers/virt/acrn/hsm.c       | 15 ++++++++
 drivers/virt/acrn/hypercall.h | 13 +++++++
 include/uapi/linux/acrn.h     | 71 +++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index cbda67d4eb89..58ceb02e82db 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -9,6 +9,7 @@
  *	Yakui Zhao <yakui.zhao@intel.com>
  */
 
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -46,6 +47,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 {
 	struct acrn_vm *vm = filp->private_data;
 	struct acrn_vm_creation *vm_param;
+	struct acrn_vcpu_regs *cpu_regs;
 	int ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -97,6 +99,19 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	case ACRN_IOCTL_DESTROY_VM:
 		ret = acrn_vm_destroy(vm);
 		break;
+	case ACRN_IOCTL_SET_VCPU_REGS:
+		cpu_regs = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_vcpu_regs));
+		if (IS_ERR(cpu_regs))
+			return PTR_ERR(cpu_regs);
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
index 364b1a783074..1d5b82e154fb 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -36,6 +36,75 @@ struct acrn_vm_creation {
 	__u8	reserved2[8];
 } __attribute__((aligned(8)));
 
+struct acrn_gp_regs {
+	__u64	rax;
+	__u64	rcx;
+	__u64	rdx;
+	__u64	rbx;
+	__u64	rsp;
+	__u64	rbp;
+	__u64	rsi;
+	__u64	rdi;
+	__u64	r8;
+	__u64	r9;
+	__u64	r10;
+	__u64	r11;
+	__u64	r12;
+	__u64	r13;
+	__u64	r14;
+	__u64	r15;
+};
+
+struct acrn_descriptor_ptr {
+	__u16	limit;
+	__u64	base;
+	__u16	reserved[3];
+} __attribute__ ((__packed__));
+
+struct acrn_regs {
+	struct acrn_gp_regs		gprs;
+	struct acrn_descriptor_ptr	gdt;
+	struct acrn_descriptor_ptr	idt;
+
+	__u64				rip;
+	__u64				cs_base;
+	__u64				cr0;
+	__u64				cr4;
+	__u64				cr3;
+	__u64				ia32_efer;
+	__u64				rflags;
+	__u64				reserved_64[4];
+
+	__u32				cs_ar;
+	__u32				cs_limit;
+	__u32				reserved_32[3];
+
+	__u16				cs_sel;
+	__u16				ss_sel;
+	__u16				ds_sel;
+	__u16				es_sel;
+	__u16				fs_sel;
+	__u16				gs_sel;
+	__u16				ldt_sel;
+	__u16				tr_sel;
+
+	__u16				reserved_16[4];
+};
+
+/**
+ * struct acrn_vcpu_regs - Info of vCPU registers state
+ * @vcpu_id:	vCPU ID
+ * @reserved0:	Reserved
+ * @vcpu_regs:	vCPU registers state
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_vcpu_regs {
+	__u16			vcpu_id;
+	__u16			reserved0[3];
+	struct acrn_regs	vcpu_regs;
+} __attribute__((aligned(8)));
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -52,5 +121,7 @@ struct acrn_vm_creation {
 	_IO(ACRN_IOCTL_TYPE, 0x13)
 #define ACRN_IOCTL_RESET_VM		\
 	_IO(ACRN_IOCTL_TYPE, 0x15)
+#define ACRN_IOCTL_SET_VCPU_REGS	\
+	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

