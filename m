Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC43E2C9E2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbgLAJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:41:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:35935 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387547AbgLAJlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:41:04 -0500
IronPort-SDR: qUfRqiqDQBp7iw/PuIpBi8Df8jEP/G8I0rb6nEdci5G/pMURYlSXbbd6V51MVG7B56VY58IsMZ
 wn0Ezfg39FzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172957401"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="172957401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:21 -0800
IronPort-SDR: 10YX/+iKrTlMsXFbGFogy0KhEP10FT2Q6D/JJ2x2ALAbBVUkG9yfGdavTpoW3Eq7nbJIY1BwHw
 nZA1GkpJ/1XQ==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="537420000"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:16 -0800
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
Subject: [PATCH v6 06/18] virt: acrn: Introduce VM management interfaces
Date:   Tue,  1 Dec 2020 17:38:41 +0800
Message-Id: <20201201093853.12070-7-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201093853.12070-1-shuo.a.liu@intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The VM management interfaces expose several VM operations to ACRN
userspace via ioctls. For example, creating VM, starting VM, destroying
VM and so on.

The ACRN Hypervisor needs to exchange data with the ACRN userspace
during the VM operations. HSM provides VM operation ioctls to the ACRN
userspace and communicates with the ACRN Hypervisor for VM operations
via hypercalls.

HSM maintains a list of User VM. Each User VM will be bound to an
existing file descriptor of /dev/acrn_hsm. The User VM will be
destroyed when the file descriptor is closed.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 MAINTAINERS                                   |  1 +
 drivers/virt/acrn/Makefile                    |  2 +-
 drivers/virt/acrn/acrn_drv.h                  | 21 ++++-
 drivers/virt/acrn/hsm.c                       | 75 +++++++++++++++++-
 drivers/virt/acrn/hypercall.h                 | 78 +++++++++++++++++++
 drivers/virt/acrn/vm.c                        | 68 ++++++++++++++++
 include/uapi/linux/acrn.h                     | 55 +++++++++++++
 8 files changed, 297 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virt/acrn/hypercall.h
 create mode 100644 drivers/virt/acrn/vm.c
 create mode 100644 include/uapi/linux/acrn.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 55a2d9b2ce33..822df5281d72 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -319,6 +319,7 @@ Code  Seq#    Include File                                           Comments
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
+0xA2  all    uapi/linux/acrn.h                                       ACRN hypervisor
 0xA3  80-8F                                                          Port ACL  in development:
                                                                      <mailto:tlewis@mindspring.com>
 0xA3  90-9F  linux/dtlk.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 46eb29ed9c4f..5863e381115f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -443,6 +443,7 @@ S:	Supported
 W:	https://projectacrn.org
 F:	Documentation/virt/acrn/
 F:	drivers/virt/acrn/
+F:	include/uapi/linux/acrn.h
 
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
index 6920ed798aaf..cf8b4ed5e74e 100644
--- a/drivers/virt/acrn/Makefile
+++ b/drivers/virt/acrn/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
-acrn-y := hsm.o
+acrn-y := hsm.o vm.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 29eedd696327..e5aba86cad8c 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -3,16 +3,35 @@
 #ifndef __ACRN_HSM_DRV_H
 #define __ACRN_HSM_DRV_H
 
+#include <linux/acrn.h>
+#include <linux/dev_printk.h>
+#include <linux/miscdevice.h>
 #include <linux/types.h>
 
+#include "hypercall.h"
+
+extern struct miscdevice acrn_dev;
+
 #define ACRN_INVALID_VMID (0xffffU)
 
+#define ACRN_VM_FLAG_DESTROYED		0U
 /**
  * struct acrn_vm - Properties of ACRN User VM.
+ * @list:	Entry within global list of all VMs
  * @vmid:	User VM ID
+ * @vcpu_num:	Number of virtual CPUs in the VM
+ * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
+ *		in HSM which is different from the &acrn_vm_creation.vm_flag.
  */
 struct acrn_vm {
-	u16	vmid;
+	struct list_head	list;
+	u16			vmid;
+	int			vcpu_num;
+	unsigned long		flags;
 };
 
+struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
+			       struct acrn_vm_creation *vm_param);
+int acrn_vm_destroy(struct acrn_vm *vm);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index a8dcb250649d..e618ac6aadaf 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -9,7 +9,6 @@
  *	Yakui Zhao <yakui.zhao@intel.com>
  */
 
-#include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -38,10 +37,81 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * HSM relies on hypercall layer of the ACRN hypervisor to do the
+ * sanity check against the input parameters.
+ */
+static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
+			   unsigned long ioctl_param)
+{
+	struct acrn_vm *vm = filp->private_data;
+	struct acrn_vm_creation *vm_param;
+	int ret = 0;
+
+	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
+		dev_dbg(acrn_dev.this_device,
+			"ioctl 0x%x: Invalid VM state!\n", cmd);
+		return -EINVAL;
+	}
+
+	switch (cmd) {
+	case ACRN_IOCTL_CREATE_VM:
+		vm_param = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_vm_creation));
+		if (IS_ERR(vm_param))
+			return PTR_ERR(vm_param);
+
+		vm_param->reserved0 = 0;
+		vm_param->reserved1 = 0;
+		vm = acrn_vm_create(vm, vm_param);
+		if (!vm) {
+			ret = -EINVAL;
+			kfree(vm_param);
+			break;
+		}
+
+		if (copy_to_user((void __user *)ioctl_param, vm_param,
+				 sizeof(struct acrn_vm_creation))) {
+			acrn_vm_destroy(vm);
+			ret = -EFAULT;
+		}
+
+		kfree(vm_param);
+		break;
+	case ACRN_IOCTL_START_VM:
+		ret = hcall_start_vm(vm->vmid);
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to start VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_PAUSE_VM:
+		ret = hcall_pause_vm(vm->vmid);
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to pause VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_RESET_VM:
+		ret = hcall_reset_vm(vm->vmid);
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to restart VM %u!\n", vm->vmid);
+		break;
+	case ACRN_IOCTL_DESTROY_VM:
+		ret = acrn_vm_destroy(vm);
+		break;
+	default:
+		dev_dbg(acrn_dev.this_device, "Unknown IOCTL 0x%x!\n", cmd);
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
 static int acrn_dev_release(struct inode *inode, struct file *filp)
 {
 	struct acrn_vm *vm = filp->private_data;
 
+	acrn_vm_destroy(vm);
 	kfree(vm);
 	return 0;
 }
@@ -50,9 +120,10 @@ static const struct file_operations acrn_fops = {
 	.owner		= THIS_MODULE,
 	.open		= acrn_dev_open,
 	.release	= acrn_dev_release,
+	.unlocked_ioctl = acrn_dev_ioctl,
 };
 
-static struct miscdevice acrn_dev = {
+struct miscdevice acrn_dev = {
 	.minor	= MISC_DYNAMIC_MINOR,
 	.name	= "acrn_hsm",
 	.fops	= &acrn_fops,
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
new file mode 100644
index 000000000000..426b66cadb1f
--- /dev/null
+++ b/drivers/virt/acrn/hypercall.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ACRN HSM: hypercalls of ACRN Hypervisor
+ */
+#ifndef __ACRN_HSM_HYPERCALL_H
+#define __ACRN_HSM_HYPERCALL_H
+#include <asm/acrn.h>
+
+/*
+ * Hypercall IDs of the ACRN Hypervisor
+ */
+#define _HC_ID(x, y) (((x) << 24) | (y))
+
+#define HC_ID 0x80UL
+
+#define HC_ID_VM_BASE			0x10UL
+#define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
+#define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
+#define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
+#define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
+#define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
+
+/**
+ * hcall_create_vm() - Create a User VM
+ * @vminfo:	Service VM GPA of info of User VM creation
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_create_vm(u64 vminfo)
+{
+	return acrn_hypercall1(HC_CREATE_VM, vminfo);
+}
+
+/**
+ * hcall_start_vm() - Start a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_start_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_START_VM, vmid);
+}
+
+/**
+ * hcall_pause_vm() - Pause a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_pause_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_PAUSE_VM, vmid);
+}
+
+/**
+ * hcall_destroy_vm() - Destroy a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_destroy_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_DESTROY_VM, vmid);
+}
+
+/**
+ * hcall_reset_vm() - Reset a User VM
+ * @vmid:	User VM ID
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_reset_vm(u64 vmid)
+{
+	return acrn_hypercall1(HC_RESET_VM, vmid);
+}
+
+#endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
new file mode 100644
index 000000000000..3f667ac8ac1e
--- /dev/null
+++ b/drivers/virt/acrn/vm.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN_HSM: Virtual Machine management
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Jason Chen CJ <jason.cj.chen@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include "acrn_drv.h"
+
+/* List of VMs */
+static LIST_HEAD(acrn_vm_list);
+/* To protect acrn_vm_list */
+static DEFINE_MUTEX(acrn_vm_list_lock);
+
+struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
+			       struct acrn_vm_creation *vm_param)
+{
+	int ret;
+
+	ret = hcall_create_vm(virt_to_phys(vm_param));
+	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
+		dev_err(acrn_dev.this_device,
+			"Failed to create VM! Error: %d\n", ret);
+		return NULL;
+	}
+
+	vm->vmid = vm_param->vmid;
+	vm->vcpu_num = vm_param->vcpu_num;
+
+	mutex_lock(&acrn_vm_list_lock);
+	list_add(&vm->list, &acrn_vm_list);
+	mutex_unlock(&acrn_vm_list_lock);
+
+	dev_dbg(acrn_dev.this_device, "VM %u created.\n", vm->vmid);
+	return vm;
+}
+
+int acrn_vm_destroy(struct acrn_vm *vm)
+{
+	int ret;
+
+	if (vm->vmid == ACRN_INVALID_VMID ||
+	    test_and_set_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags))
+		return 0;
+
+	/* Remove from global VM list */
+	mutex_lock(&acrn_vm_list_lock);
+	list_del_init(&vm->list);
+	mutex_unlock(&acrn_vm_list_lock);
+
+	ret = hcall_destroy_vm(vm->vmid);
+	if (ret < 0) {
+		dev_err(acrn_dev.this_device,
+			"Failed to destroy VM %u\n", vm->vmid);
+		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
+		return ret;
+	}
+	dev_dbg(acrn_dev.this_device, "VM %u destroyed.\n", vm->vmid);
+	vm->vmid = ACRN_INVALID_VMID;
+	return 0;
+}
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
new file mode 100644
index 000000000000..e1608b8a50a2
--- /dev/null
+++ b/include/uapi/linux/acrn.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
+ *
+ * This file can be used by applications that need to communicate with the HSM
+ * via the ioctl interface.
+ */
+
+#ifndef _UAPI_ACRN_H
+#define _UAPI_ACRN_H
+
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+/**
+ * struct acrn_vm_creation - Info to create a User VM
+ * @vmid:		User VM ID returned from the hypervisor
+ * @reserved0:		Reserved and must be 0
+ * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
+ * @reserved1:		Reserved and must be 0
+ * @uuid:		UUID of the VM. Pass to hypervisor directly.
+ * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
+ * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
+ *			hypervisor directly.
+ * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
+ */
+struct acrn_vm_creation {
+	__u16	vmid;
+	__u16	reserved0;
+	__u16	vcpu_num;
+	__u16	reserved1;
+	guid_t	uuid;
+	__u64	vm_flag;
+	__u64	ioreq_buf;
+	__u64	cpu_affinity;
+};
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define ACRN_IOCTL_TYPE			0xA2
+
+/*
+ * Common IOCTL IDs definition for ACRN userspace
+ */
+#define ACRN_IOCTL_CREATE_VM		\
+	_IOWR(ACRN_IOCTL_TYPE, 0x10, struct acrn_vm_creation)
+#define ACRN_IOCTL_DESTROY_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x11)
+#define ACRN_IOCTL_START_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x12)
+#define ACRN_IOCTL_PAUSE_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x13)
+#define ACRN_IOCTL_RESET_VM		\
+	_IO(ACRN_IOCTL_TYPE, 0x15)
+
+#endif /* _UAPI_ACRN_H */
-- 
2.28.0

