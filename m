Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A52EBAD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhAFHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:53:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:17573 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbhAFHxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:53:02 -0500
IronPort-SDR: ONNcZXrANYA1YeRJD9vrcfkYsk58TtGgJ1ICfTE5jJzLLuhozbZvZvyz8Cb1SMJqM9vOoNAlbO
 UeStibu0p1Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="177343989"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="177343989"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:52:20 -0800
IronPort-SDR: NfpF2VUh9/WxLHJphB5Z3sQHl2MSam2esjDc2Ichl6lz/c1M7ekCDF8aBj4VQ2TIVngiokK2mh
 sEujCG+eJVrw==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="567342302"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:52:17 -0800
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
Subject: [PATCH v7 11/18] virt: acrn: Introduce interfaces for PCI device passthrough
Date:   Wed,  6 Jan 2021 15:50:48 +0800
Message-Id: <20210106075055.47226-12-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210106075055.47226-1-shuo.a.liu@intel.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

PCI device passthrough enables an OS in a virtual machine to directly
access a PCI device in the host. It promises almost the native
performance, which is required in performance-critical scenarios of
ACRN.

HSM provides the following ioctls:
 - Assign - ACRN_IOCTL_ASSIGN_PCIDEV
   Pass data struct acrn_pcidev from userspace to the hypervisor, and
   inform the hypervisor to assign a PCI device to a User VM.

 - De-assign - ACRN_IOCTL_DEASSIGN_PCIDEV
   Pass data struct acrn_pcidev from userspace to the hypervisor, and
   inform the hypervisor to de-assign a PCI device from a User VM.

 - Set a interrupt of a passthrough device - ACRN_IOCTL_SET_PTDEV_INTR
   Pass data struct acrn_ptdev_irq from userspace to the hypervisor,
   and inform the hypervisor to map a INTx interrupt of passthrough
   device of User VM.

 - Reset passthrough device interrupt - ACRN_IOCTL_RESET_PTDEV_INTR
   Pass data struct acrn_ptdev_irq from userspace to the hypervisor,
   and inform the hypervisor to unmap a INTx interrupt of passthrough
   device of User VM.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/hsm.c       | 50 ++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 54 +++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h     | 61 +++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index ca1181aa6b0a..e5676d0ecbbc 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -49,7 +49,9 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_vm_creation *vm_param;
 	struct acrn_vcpu_regs *cpu_regs;
 	struct acrn_ioreq_notify notify;
+	struct acrn_ptdev_irq *irq_info;
 	struct acrn_vm_memmap memmap;
+	struct acrn_pcidev *pcidev;
 	int i, ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -135,6 +137,54 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 
 		ret = acrn_vm_memseg_unmap(vm, &memmap);
 		break;
+	case ACRN_IOCTL_ASSIGN_PCIDEV:
+		pcidev = memdup_user((void __user *)ioctl_param,
+				     sizeof(struct acrn_pcidev));
+		if (IS_ERR(pcidev))
+			return PTR_ERR(pcidev);
+
+		ret = hcall_assign_pcidev(vm->vmid, virt_to_phys(pcidev));
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to assign pci device!\n");
+		kfree(pcidev);
+		break;
+	case ACRN_IOCTL_DEASSIGN_PCIDEV:
+		pcidev = memdup_user((void __user *)ioctl_param,
+				     sizeof(struct acrn_pcidev));
+		if (IS_ERR(pcidev))
+			return PTR_ERR(pcidev);
+
+		ret = hcall_deassign_pcidev(vm->vmid, virt_to_phys(pcidev));
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to deassign pci device!\n");
+		kfree(pcidev);
+		break;
+	case ACRN_IOCTL_SET_PTDEV_INTR:
+		irq_info = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_ptdev_irq));
+		if (IS_ERR(irq_info))
+			return PTR_ERR(irq_info);
+
+		ret = hcall_set_ptdev_intr(vm->vmid, virt_to_phys(irq_info));
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to configure intr for ptdev!\n");
+		kfree(irq_info);
+		break;
+	case ACRN_IOCTL_RESET_PTDEV_INTR:
+		irq_info = memdup_user((void __user *)ioctl_param,
+				       sizeof(struct acrn_ptdev_irq));
+		if (IS_ERR(irq_info))
+			return PTR_ERR(irq_info);
+
+		ret = hcall_reset_ptdev_intr(vm->vmid, virt_to_phys(irq_info));
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to reset intr for ptdev!\n");
+		kfree(irq_info);
+		break;
 	case ACRN_IOCTL_CREATE_IOREQ_CLIENT:
 		if (vm->default_client)
 			return -EEXIST;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index 5eba29e3ed38..f448301832cf 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -28,6 +28,12 @@
 #define HC_ID_MEM_BASE			0x40UL
 #define HC_VM_SET_MEMORY_REGIONS	_HC_ID(HC_ID, HC_ID_MEM_BASE + 0x02)
 
+#define HC_ID_PCI_BASE			0x50UL
+#define HC_SET_PTDEV_INTR		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x03)
+#define HC_RESET_PTDEV_INTR		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x04)
+#define HC_ASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x05)
+#define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
+
 /**
  * hcall_create_vm() - Create a User VM
  * @vminfo:	Service VM GPA of info of User VM creation
@@ -130,4 +136,52 @@ static inline long hcall_set_memory_regions(u64 regions_pa)
 	return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
 }
 
+/**
+ * hcall_assign_pcidev() - Assign a PCI device to a User VM
+ * @vmid:	User VM ID
+ * @addr:	Service VM GPA of the &struct acrn_pcidev
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_assign_pcidev(u64 vmid, u64 addr)
+{
+	return acrn_hypercall2(HC_ASSIGN_PCIDEV, vmid, addr);
+}
+
+/**
+ * hcall_deassign_pcidev() - De-assign a PCI device from a User VM
+ * @vmid:	User VM ID
+ * @addr:	Service VM GPA of the &struct acrn_pcidev
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_deassign_pcidev(u64 vmid, u64 addr)
+{
+	return acrn_hypercall2(HC_DEASSIGN_PCIDEV, vmid, addr);
+}
+
+/**
+ * hcall_set_ptdev_intr() - Configure an interrupt for an assigned PCI device.
+ * @vmid:	User VM ID
+ * @irq:	Service VM GPA of the &struct acrn_ptdev_irq
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_ptdev_intr(u64 vmid, u64 irq)
+{
+	return acrn_hypercall2(HC_SET_PTDEV_INTR, vmid, irq);
+}
+
+/**
+ * hcall_reset_ptdev_intr() - Reset an interrupt for an assigned PCI device.
+ * @vmid:	User VM ID
+ * @irq:	Service VM GPA of the &struct acrn_ptdev_irq
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_reset_ptdev_intr(u64 vmid, u64 irq)
+{
+	return acrn_hypercall2(HC_RESET_PTDEV_INTR, vmid, irq);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 66c43bd1e1b3..2727f16a7ef4 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -284,6 +284,58 @@ struct acrn_vm_memmap {
 	__u64	len;
 };
 
+/* Type of interrupt of a passthrough device */
+#define ACRN_PTDEV_IRQ_INTX	0
+#define ACRN_PTDEV_IRQ_MSI	1
+#define ACRN_PTDEV_IRQ_MSIX	2
+/**
+ * struct acrn_ptdev_irq - Interrupt data of a passthrough device.
+ * @type:		Type (ACRN_PTDEV_IRQ_*)
+ * @virt_bdf:		Virtual Bus/Device/Function
+ * @phys_bdf:		Physical Bus/Device/Function
+ * @intx:		Info of interrupt
+ * @intx.virt_pin:	Virtual IOAPIC pin
+ * @intx.phys_pin:	Physical IOAPIC pin
+ * @intx.is_pic_pin:	Is PIC pin or not
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_ptdev_irq {
+	__u32	type;
+	__u16	virt_bdf;
+	__u16	phys_bdf;
+
+	struct {
+		__u32	virt_pin;
+		__u32	phys_pin;
+		__u32	is_pic_pin;
+	} intx;
+};
+
+/* Type of PCI device assignment */
+#define ACRN_PTDEV_QUIRK_ASSIGN	(1U << 0)
+
+#define ACRN_PCI_NUM_BARS	6
+/**
+ * struct acrn_pcidev - Info for assigning or de-assigning a PCI device
+ * @type:	Type of the assignment
+ * @virt_bdf:	Virtual Bus/Device/Function
+ * @phys_bdf:	Physical Bus/Device/Function
+ * @intr_line:	PCI interrupt line
+ * @intr_pin:	PCI interrupt pin
+ * @bar:	PCI BARs.
+ *
+ * This structure will be passed to hypervisor directly.
+ */
+struct acrn_pcidev {
+	__u32	type;
+	__u16	virt_bdf;
+	__u16	phys_bdf;
+	__u8	intr_line;
+	__u8	intr_pin;
+	__u32	bar[ACRN_PCI_NUM_BARS];
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -319,4 +371,13 @@ struct acrn_vm_memmap {
 #define ACRN_IOCTL_UNSET_MEMSEG		\
 	_IOW(ACRN_IOCTL_TYPE, 0x42, struct acrn_vm_memmap)
 
+#define ACRN_IOCTL_SET_PTDEV_INTR	\
+	_IOW(ACRN_IOCTL_TYPE, 0x53, struct acrn_ptdev_irq)
+#define ACRN_IOCTL_RESET_PTDEV_INTR	\
+	_IOW(ACRN_IOCTL_TYPE, 0x54, struct acrn_ptdev_irq)
+#define ACRN_IOCTL_ASSIGN_PCIDEV	\
+	_IOW(ACRN_IOCTL_TYPE, 0x55, struct acrn_pcidev)
+#define ACRN_IOCTL_DEASSIGN_PCIDEV	\
+	_IOW(ACRN_IOCTL_TYPE, 0x56, struct acrn_pcidev)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

