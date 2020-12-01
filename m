Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CEF2C9E31
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgLAJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:41:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:35935 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgLAJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:41:23 -0500
IronPort-SDR: hqtwpEhsf6YT4EVCQ7tgHR/BCCh6e1pCYUYTLWa8fT+NvV+ZVu9jL/pTVPVmG17FAg1owrlgHP
 NDyFvgEZKuRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172957470"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="172957470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:41:07 -0800
IronPort-SDR: a4o3sHHipktjq0eVZGLW+SUNPclU/zvrQLTQTcrMbRrvPbL8iAdRp6TAlrScJVeox0ynZnLWH3
 t0TM6QVcPAtg==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="361000298"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:41:03 -0800
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
Subject: [PATCH v6 12/18] virt: acrn: Introduce interrupt injection interfaces
Date:   Tue,  1 Dec 2020 17:38:47 +0800
Message-Id: <20201201093853.12070-13-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201093853.12070-1-shuo.a.liu@intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

ACRN userspace need to inject virtual interrupts into a User VM in
devices emulation.

HSM needs provide interfaces to do so.

Introduce following interrupt injection interfaces:

ioctl ACRN_IOCTL_SET_IRQLINE:
  Pass data from userspace to the hypervisor, and inform the hypervisor
  to inject a virtual IOAPIC GSI interrupt to a User VM.

ioctl ACRN_IOCTL_INJECT_MSI:
  Pass data struct acrn_msi_entry from userspace to the hypervisor, and
  inform the hypervisor to inject a virtual MSI to a User VM.

ioctl ACRN_IOCTL_VM_INTR_MONITOR:
  Set a 4-Kbyte aligned shared page for statistics information of
  interrupts of a User VM.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/acrn_drv.h  |  4 ++++
 drivers/virt/acrn/hsm.c       | 40 ++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 41 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/vm.c        | 36 ++++++++++++++++++++++++++++++
 include/uapi/linux/acrn.h     | 17 +++++++++++++++
 5 files changed, 138 insertions(+)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 97a7f31cd681..542448c88026 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -155,6 +155,7 @@ extern rwlock_t acrn_vm_list_lock;
  * @ioreq_buf:			I/O request shared buffer
  * @ioreq_page:			The page of the I/O request shared buffer
  * @pci_conf_addr:		Address of a PCI configuration access emulation
+ * @monitor_page:		Page of interrupt statistics of User VM
  */
 struct acrn_vm {
 	struct list_head		list;
@@ -170,6 +171,7 @@ struct acrn_vm {
 	struct acrn_io_request_buffer	*ioreq_buf;
 	struct page			*ioreq_page;
 	u32				pci_conf_addr;
+	struct page			*monitor_page;
 };
 
 struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
@@ -196,4 +198,6 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 						   const char *name);
 void acrn_ioreq_client_destroy(struct acrn_ioreq_client *client);
 
+int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data);
+
 #endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index c1eb1dc62801..43fb2e32108c 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -51,7 +51,9 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_ioreq_notify notify;
 	struct acrn_ptdev_irq *irq_info;
 	struct acrn_vm_memmap memmap;
+	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
+	struct page *page;
 	int ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -181,6 +183,44 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 				"Failed to reset intr for ptdev!\n");
 		kfree(irq_info);
 		break;
+	case ACRN_IOCTL_SET_IRQLINE:
+		ret = hcall_set_irqline(vm->vmid, ioctl_param);
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to set interrupt line!\n");
+		break;
+	case ACRN_IOCTL_INJECT_MSI:
+		msi = memdup_user((void __user *)ioctl_param,
+				  sizeof(struct acrn_msi_entry));
+		if (IS_ERR(msi))
+			return PTR_ERR(msi);
+
+		ret = hcall_inject_msi(vm->vmid, virt_to_phys(msi));
+		if (ret < 0)
+			dev_dbg(acrn_dev.this_device,
+				"Failed to inject MSI!\n");
+		kfree(msi);
+		break;
+	case ACRN_IOCTL_VM_INTR_MONITOR:
+		ret = pin_user_pages_fast(ioctl_param, 1,
+					  FOLL_WRITE | FOLL_LONGTERM, &page);
+		if (unlikely(ret != 1)) {
+			dev_dbg(acrn_dev.this_device,
+				"Failed to pin intr hdr buffer!\n");
+			return -EFAULT;
+		}
+
+		ret = hcall_vm_intr_monitor(vm->vmid, page_to_phys(page));
+		if (ret < 0) {
+			unpin_user_page(page);
+			dev_dbg(acrn_dev.this_device,
+				"Failed to monitor intr data!\n");
+			return ret;
+		}
+		if (vm->monitor_page)
+			unpin_user_page(vm->monitor_page);
+		vm->monitor_page = page;
+		break;
 	case ACRN_IOCTL_CREATE_IOREQ_CLIENT:
 		if (vm->default_client)
 			return -EEXIST;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index f448301832cf..a8813397a3fe 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -21,6 +21,11 @@
 #define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
 #define HC_SET_VCPU_REGS		_HC_ID(HC_ID, HC_ID_VM_BASE + 0x06)
 
+#define HC_ID_IRQ_BASE			0x20UL
+#define HC_INJECT_MSI			_HC_ID(HC_ID, HC_ID_IRQ_BASE + 0x03)
+#define HC_VM_INTR_MONITOR		_HC_ID(HC_ID, HC_ID_IRQ_BASE + 0x04)
+#define HC_SET_IRQLINE			_HC_ID(HC_ID, HC_ID_IRQ_BASE + 0x05)
+
 #define HC_ID_IOREQ_BASE		0x30UL
 #define HC_SET_IOREQ_BUFFER		_HC_ID(HC_ID, HC_ID_IOREQ_BASE + 0x00)
 #define HC_NOTIFY_REQUEST_FINISH	_HC_ID(HC_ID, HC_ID_IOREQ_BASE + 0x01)
@@ -101,6 +106,42 @@ static inline long hcall_set_vcpu_regs(u64 vmid, u64 regs_state)
 	return acrn_hypercall2(HC_SET_VCPU_REGS, vmid, regs_state);
 }
 
+/**
+ * hcall_inject_msi() - Deliver a MSI interrupt to a User VM
+ * @vmid:	User VM ID
+ * @msi:	Service VM GPA of MSI message
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_inject_msi(u64 vmid, u64 msi)
+{
+	return acrn_hypercall2(HC_INJECT_MSI, vmid, msi);
+}
+
+/**
+ * hcall_vm_intr_monitor() - Set a shared page for User VM interrupt statistics
+ * @vmid:	User VM ID
+ * @addr:	Service VM GPA of the shared page
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_vm_intr_monitor(u64 vmid, u64 addr)
+{
+	return acrn_hypercall2(HC_VM_INTR_MONITOR, vmid, addr);
+}
+
+/**
+ * hcall_set_irqline() - Set or clear an interrupt line
+ * @vmid:	User VM ID
+ * @op:		Service VM GPA of interrupt line operations
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static inline long hcall_set_irqline(u64 vmid, u64 op)
+{
+	return acrn_hypercall2(HC_SET_IRQLINE, vmid, op);
+}
+
 /**
  * hcall_set_ioreq_buffer() - Set up the shared buffer for I/O Requests.
  * @vmid:	User VM ID
diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 4ee1a99df4b7..38304aeef181 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -68,6 +68,10 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	write_unlock_bh(&acrn_vm_list_lock);
 
 	acrn_ioreq_deinit(vm);
+	if (vm->monitor_page) {
+		put_page(vm->monitor_page);
+		vm->monitor_page = NULL;
+	}
 
 	ret = hcall_destroy_vm(vm->vmid);
 	if (ret < 0) {
@@ -83,3 +87,35 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	vm->vmid = ACRN_INVALID_VMID;
 	return 0;
 }
+
+/**
+ * acrn_inject_msi() - Inject a MSI interrupt into a User VM
+ * @vm:		User VM
+ * @msi_addr:	The MSI address
+ * @msi_data:	The MSI data
+ *
+ * Return: 0 on success, <0 on error
+ */
+int acrn_msi_inject(struct acrn_vm *vm, u64 msi_addr, u64 msi_data)
+{
+	struct acrn_msi_entry *msi;
+	int ret;
+
+	/* might be used in interrupt context, so use GFP_ATOMIC */
+	msi = kzalloc(sizeof(*msi), GFP_ATOMIC);
+	if (!msi)
+		return -ENOMEM;
+
+	/*
+	 * msi_addr: addr[19:12] with dest vcpu id
+	 * msi_data: data[7:0] with vector
+	 */
+	msi->msi_addr = msi_addr;
+	msi->msi_data = msi_data;
+	ret = hcall_inject_msi(vm->vmid, virt_to_phys(msi));
+	if (ret < 0)
+		dev_err(acrn_dev.this_device,
+			"Failed to inject MSI to VM %u!\n", vm->vmid);
+	kfree(msi);
+	return ret;
+}
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 2727f16a7ef4..959dfbccc6a4 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -336,6 +336,16 @@ struct acrn_pcidev {
 	__u32	bar[ACRN_PCI_NUM_BARS];
 };
 
+/**
+ * struct acrn_msi_entry - Info for injecting a MSI interrupt to a VM
+ * @msi_addr:	MSI addr[19:12] with dest vCPU ID
+ * @msi_data:	MSI data[7:0] with vector
+ */
+struct acrn_msi_entry {
+	__u64	msi_addr;
+	__u64	msi_data;
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -355,6 +365,13 @@ struct acrn_pcidev {
 #define ACRN_IOCTL_SET_VCPU_REGS	\
 	_IOW(ACRN_IOCTL_TYPE, 0x16, struct acrn_vcpu_regs)
 
+#define ACRN_IOCTL_INJECT_MSI		\
+	_IOW(ACRN_IOCTL_TYPE, 0x23, struct acrn_msi_entry)
+#define ACRN_IOCTL_VM_INTR_MONITOR	\
+	_IOW(ACRN_IOCTL_TYPE, 0x24, unsigned long)
+#define ACRN_IOCTL_SET_IRQLINE		\
+	_IOW(ACRN_IOCTL_TYPE, 0x25, __u64)
+
 #define ACRN_IOCTL_NOTIFY_REQUEST_FINISH \
 	_IOW(ACRN_IOCTL_TYPE, 0x31, struct acrn_ioreq_notify)
 #define ACRN_IOCTL_CREATE_IOREQ_CLIENT	\
-- 
2.28.0

