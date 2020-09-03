Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D9E25C1DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgICNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 09:50:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:23450 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgICMpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:45:51 -0400
IronPort-SDR: aPkZPPaRK/gJMV1ZHC8lVl/83gc0nVxHANJ7NtfgkLee0ULaFM/AhfZ/CFPlNFx9kCcAcqnIXj
 ppr4BHAykJAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137083370"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="137083370"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:43:36 -0700
IronPort-SDR: bHnKcX3DKRoPvX9csV1Z0byDW8W0N9rw6RVfLuor/RpZIZnekVcPzZXuul6zdSPZsqXuxuF0FR
 B6ULpeBloX9Q==
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="375862787"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:43:32 -0700
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
Subject: [PATCH v2 13/17] virt: acrn: Introduce interfaces to query C-states and P-states allowed by hypervisor
Date:   Thu,  3 Sep 2020 20:41:57 +0800
Message-Id: <20200903124201.17275-14-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903124201.17275-1-shuo.a.liu@intel.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

The C-states and P-states data are used to support CPU power management.
The hypervisor controls C-states and P-states for a User VM.

ACRN userspace need to query the data from the hypervisor to build ACPI
tables for a User VM.

HSM provides ioctls for ACRN userspace to query C-states and P-states
data obtained from the hypervisor.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
CC: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/acrn/hsm.c       | 69 +++++++++++++++++++++++++++++++++++
 drivers/virt/acrn/hypercall.h | 12 ++++++
 include/uapi/linux/acrn.h     | 35 ++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 9546193456b9..ea9c73e6e8a5 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -45,6 +45,67 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int pmcmd_ioctl(u64 cmd, void __user *uptr)
+{
+	struct acrn_pstate_data *px_data;
+	struct acrn_cstate_data *cx_data;
+	u64 *pm_info;
+	int ret = 0;
+
+	switch (cmd & PMCMD_TYPE_MASK) {
+	case ACRN_PMCMD_GET_PX_CNT:
+	case ACRN_PMCMD_GET_CX_CNT:
+		pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+		if (!pm_info)
+			return -ENOMEM;
+
+		ret = hcall_get_cpu_state(cmd, virt_to_phys(pm_info));
+		if (ret < 0) {
+			kfree(pm_info);
+			break;
+		}
+
+		if (copy_to_user(uptr, pm_info, sizeof(u64)))
+			ret = -EFAULT;
+		kfree(pm_info);
+		break;
+	case ACRN_PMCMD_GET_PX_DATA:
+		px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+		if (!px_data)
+			return -ENOMEM;
+
+		ret = hcall_get_cpu_state(cmd, virt_to_phys(px_data));
+		if (ret < 0) {
+			kfree(px_data);
+			break;
+		}
+
+		if (copy_to_user(uptr, px_data, sizeof(*px_data)))
+			ret = -EFAULT;
+		kfree(px_data);
+		break;
+	case ACRN_PMCMD_GET_CX_DATA:
+		cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+		if (!cx_data)
+			return -ENOMEM;
+
+		ret = hcall_get_cpu_state(cmd, virt_to_phys(cx_data));
+		if (ret < 0) {
+			kfree(cx_data);
+			break;
+		}
+
+		if (copy_to_user(uptr, cx_data, sizeof(*cx_data)))
+			ret = -EFAULT;
+		kfree(cx_data);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long ioctl_param)
 {
@@ -57,6 +118,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	struct acrn_msi_entry *msi;
 	struct acrn_pcidev *pcidev;
 	struct page *page;
+	u64 cstate_cmd;
 	int ret = 0;
 
 	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
@@ -230,6 +292,13 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 	case ACRN_IOCTL_CLEAR_VM_IOREQ:
 		acrn_ioreq_request_clear(vm);
 		break;
+	case ACRN_IOCTL_PM_GET_CPU_STATE:
+		if (copy_from_user(&cstate_cmd, (void *)ioctl_param,
+				   sizeof(cstate_cmd)))
+			return -EFAULT;
+
+		ret = pmcmd_ioctl(cstate_cmd, (void __user *)ioctl_param);
+		break;
 	default:
 		dev_warn(dev, "Unknown IOCTL 0x%x!\n", cmd);
 		ret = -ENOTTY;
diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
index a8813397a3fe..e640632366f0 100644
--- a/drivers/virt/acrn/hypercall.h
+++ b/drivers/virt/acrn/hypercall.h
@@ -39,6 +39,9 @@
 #define HC_ASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x05)
 #define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
 
+#define HC_ID_PM_BASE			0x80UL
+#define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
+
 /**
  * hcall_create_vm() - Create a User VM
  * @vminfo:	Service VM GPA of info of User VM creation
@@ -225,4 +228,13 @@ static inline long hcall_reset_ptdev_intr(u64 vmid, u64 irq)
 	return acrn_hypercall2(HC_RESET_PTDEV_INTR, vmid, irq);
 }
 
+/*
+ * hcall_get_cpu_state() - Get P-states and C-states info from the hypervisor
+ * @state:	Service VM GPA of buffer of P-states and C-states
+ */
+static inline long hcall_get_cpu_state(u64 cmd, u64 state)
+{
+	return acrn_hypercall2(HC_PM_GET_CPU_STATE, cmd, state);
+}
+
 #endif /* __ACRN_HSM_HYPERCALL_H */
diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 7764459e130c..9fed7209a8ef 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -353,6 +353,38 @@ struct acrn_msi_entry {
 	__u64	msi_data;
 };
 
+struct acrn_acpi_generic_address {
+	__u8	space_id;
+	__u8	bit_width;
+	__u8	bit_offset;
+	__u8	access_size;
+	__u64	address;
+} __attribute__ ((__packed__));
+
+struct acrn_cstate_data {
+	struct acrn_acpi_generic_address	cx_reg;
+	__u8					type;
+	__u32					latency;
+	__u64					power;
+} __attribute__((aligned(8)));
+
+struct acrn_pstate_data {
+	__u64	core_frequency;
+	__u64	power;
+	__u64	transition_latency;
+	__u64	bus_master_latency;
+	__u64	control;
+	__u64	status;
+} __attribute__((aligned(8)));
+
+#define PMCMD_TYPE_MASK		0x000000ff
+enum acrn_pm_cmd_type {
+	ACRN_PMCMD_GET_PX_CNT,
+	ACRN_PMCMD_GET_PX_DATA,
+	ACRN_PMCMD_GET_CX_CNT,
+	ACRN_PMCMD_GET_CX_DATA,
+};
+
 /* The ioctl type, documented in ioctl-number.rst */
 #define ACRN_IOCTL_TYPE			0xA2
 
@@ -404,4 +436,7 @@ struct acrn_msi_entry {
 #define ACRN_IOCTL_DEASSIGN_PCIDEV	\
 	_IOW(ACRN_IOCTL_TYPE, 0x56, struct acrn_pcidev)
 
+#define ACRN_IOCTL_PM_GET_CPU_STATE	\
+	_IOWR(ACRN_IOCTL_TYPE, 0x60, __u64)
+
 #endif /* _UAPI_ACRN_H */
-- 
2.28.0

