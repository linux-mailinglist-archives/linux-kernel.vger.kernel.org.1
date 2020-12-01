Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1408D2C9E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgLAJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:40:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:9118 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387547AbgLAJkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:40:51 -0500
IronPort-SDR: A3Vd7yygkDuv+Y5OyyjHQtP9ieE0YDEOZqzTbP4rKACVUbZ/ySYZAZ9HEksjqMl8+li3/hvTZ8
 X/E19kAv2Zng==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="152629096"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="152629096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:34 -0800
IronPort-SDR: YNGKax+sGADNMV5VkG6bqA70j/VZJ85hY9yLFh3iRCOpOT6883+T3TTTn4nUhFcW9ZbFkSykxi
 Mz3OvmH0s93A==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="538953776"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:23 -0800
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
Subject: [PATCH v6 07/18] virt: acrn: Introduce an ioctl to set vCPU registers state
Date:   Tue,  1 Dec 2020 17:38:42 +0800
Message-Id: <20201201093853.12070-8-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201093853.12070-1-shuo.a.liu@intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
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
 drivers/virt/acrn/hsm.c       | 16 ++++++++
 drivers/virt/acrn/hypercall.h | 13 +++++++
 include/uapi/linux/acrn.h     | 69 +++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index e618ac6aadaf..77c749fe1fc2 100644
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
@@ -99,6 +101,20 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	case ACRN_IOCTL_DESTROY_VM:
 		ret = acrn_vm_destroy(vm);
 		break;
+	case ACRN_IOCTL_SET_VCPU_REGS:
+		cpu_regs = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_vcpu_regs));
+		if (IS_ERR(cpu_regs))
+			return PTR_ERR(cpu_regs);
+
+		memset(cpu_regs->reserved, 0, sizeof(cpu_regs->reserved));
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
index e1608b8a50a2..d5d66b93586e 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -35,6 +35,73 @@ struct acrn_vm_creation {
 	__u64	cpu_affinity;
 };
 
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
+struct acrn_descriptor_ptr {
+	__le16	limit;
+	__le64	base;
+	__le16	reserved[3];
+} __attribute__ ((__packed__));
+
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
 
@@ -51,5 +118,7 @@ struct acrn_vm_creation {
 	_IO(ACRN_IOCTL_TYPE, 0x13)
 #define ACRN_IOCTL_RESET_VM		\
 	_IO(ACRN_IOCTL_TYPE, 0x15)
+#define ACRN_IOCTL_SET_VCPU_REGS	\
+	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

