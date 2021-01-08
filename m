Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41BE2EFA97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbhAHVaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:30:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:22448 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbhAHV3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:29:22 -0500
IronPort-SDR: 6hl74/zhcXwYDfwKzZfW0A5tiKTgzVnCEH1HMtmCTl80GqovGbI/65oLxs1RV6v46SonUd9O9L
 fSAWhjXzsHRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="241732871"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="241732871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:04 -0800
IronPort-SDR: zXXycP+sHqZvWgfx4HCb3qcdhp+8eeVZOLkZDqH/iqMtdTsZs+8jqRX+3OIdRBAiCsVyegzevm
 UChvZA1Z0m9g==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="423078107"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:04 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id C9ABE636A;
        Fri,  8 Jan 2021 13:26:04 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGm-0009cQ-MO; Fri, 08 Jan 2021 13:26:04 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH v2 16/34] misc: xlink-pcie: Add asynchronous event notification support for XLink
Date:   Fri,  8 Jan 2021 13:25:42 -0800
Message-Id: <20210108212600.36850-17-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Add support to notify XLink layer upon PCIe link UP/DOWN events

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/common/core.h      |  3 ++
 drivers/misc/xlink-pcie/common/interface.c | 17 ++++++++++
 drivers/misc/xlink-pcie/local_host/core.c  | 11 +++++++
 drivers/misc/xlink-pcie/remote_host/main.c |  3 ++
 drivers/misc/xlink-pcie/remote_host/pci.c  | 36 ++++++++++++++++++++++
 drivers/misc/xlink-pcie/remote_host/pci.h  |  3 ++
 include/linux/xlink_drv_inf.h              | 12 ++++++++
 7 files changed, 85 insertions(+)

diff --git a/drivers/misc/xlink-pcie/common/core.h b/drivers/misc/xlink-pcie/common/core.h
index eec8566c19d9..34b6c268aac5 100644
--- a/drivers/misc/xlink-pcie/common/core.h
+++ b/drivers/misc/xlink-pcie/common/core.h
@@ -241,4 +241,7 @@ int intel_xpcie_pci_connect_device(u32 id);
 int intel_xpcie_pci_read(u32 id, void *data, size_t *size, u32 timeout);
 int intel_xpcie_pci_write(u32 id, void *data, size_t *size, u32 timeout);
 int intel_xpcie_pci_reset_device(u32 id);
+int intel_xpcie_pci_register_device_event(u32 sw_device_id,
+					  xlink_device_event event_notif_fn);
+int intel_xpcie_pci_unregister_device_event(u32 sw_device_id);
 #endif /* XPCIE_CORE_HEADER_ */
diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
index 56c1d9ed9d8f..4ad291ff97c8 100644
--- a/drivers/misc/xlink-pcie/common/interface.c
+++ b/drivers/misc/xlink-pcie/common/interface.c
@@ -107,3 +107,20 @@ int xlink_pcie_reset_device(u32 sw_device_id)
 	return intel_xpcie_pci_reset_device(sw_device_id);
 }
 EXPORT_SYMBOL(xlink_pcie_reset_device);
+
+int xlink_pcie_register_device_event(u32 sw_device_id,
+				     xlink_device_event event_notif_fn)
+{
+	if (!event_notif_fn)
+		return -EINVAL;
+
+	return intel_xpcie_pci_register_device_event(sw_device_id,
+						     event_notif_fn);
+}
+EXPORT_SYMBOL(xlink_pcie_register_device_event);
+
+int xlink_pcie_unregister_device_event(u32 sw_device_id)
+{
+	return intel_xpcie_pci_unregister_device_event(sw_device_id);
+}
+EXPORT_SYMBOL(xlink_pcie_unregister_device_event);
diff --git a/drivers/misc/xlink-pcie/local_host/core.c b/drivers/misc/xlink-pcie/local_host/core.c
index 51fa25259515..a343e30d8b45 100644
--- a/drivers/misc/xlink-pcie/local_host/core.c
+++ b/drivers/misc/xlink-pcie/local_host/core.c
@@ -806,3 +806,14 @@ int intel_xpcie_pci_reset_device(u32 id)
 {
 	return 0;
 }
+
+int intel_xpcie_pci_register_device_event(u32 sw_device_id,
+					  xlink_device_event event_notif_fn)
+{
+	return 0;
+}
+
+int intel_xpcie_pci_unregister_device_event(u32 sw_device_id)
+{
+	return 0;
+}
diff --git a/drivers/misc/xlink-pcie/remote_host/main.c b/drivers/misc/xlink-pcie/remote_host/main.c
index d88257dd2585..fd31ee3c153b 100644
--- a/drivers/misc/xlink-pcie/remote_host/main.c
+++ b/drivers/misc/xlink-pcie/remote_host/main.c
@@ -55,6 +55,8 @@ static int intel_xpcie_probe(struct pci_dev *pdev,
 	if (new_device)
 		intel_xpcie_list_add_device(xdev);
 
+	intel_xpcie_pci_notify_event(xdev, NOTIFY_DEVICE_CONNECTED);
+
 	return ret;
 }
 
@@ -64,6 +66,7 @@ static void intel_xpcie_remove(struct pci_dev *pdev)
 
 	if (xdev) {
 		intel_xpcie_pci_cleanup(xdev);
+		intel_xpcie_pci_notify_event(xdev, NOTIFY_DEVICE_DISCONNECTED);
 		intel_xpcie_remove_device(xdev);
 	}
 }
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.c b/drivers/misc/xlink-pcie/remote_host/pci.c
index f92a78f41324..0046bff5f604 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.c
+++ b/drivers/misc/xlink-pcie/remote_host/pci.c
@@ -8,6 +8,7 @@
  ****************************************************************************/
 
 #include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -487,3 +488,38 @@ int intel_xpcie_pci_reset_device(u32 id)
 
 	return intel_xpcie_pci_prepare_dev_reset(xdev, true);
 }
+
+int intel_xpcie_pci_register_device_event(u32 sw_device_id,
+					  xlink_device_event event_notif_fn)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(sw_device_id);
+
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->event_fn = event_notif_fn;
+
+	return 0;
+}
+
+int intel_xpcie_pci_unregister_device_event(u32 sw_device_id)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(sw_device_id);
+
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->event_fn = NULL;
+
+	return 0;
+}
+
+void intel_xpcie_pci_notify_event(struct xpcie_dev *xdev,
+				  enum xlink_device_event_type event_type)
+{
+	if (event_type >= NUM_EVENT_TYPE)
+		return;
+
+	if (xdev->event_fn)
+		xdev->event_fn(xdev->devid, event_type);
+}
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.h b/drivers/misc/xlink-pcie/remote_host/pci.h
index 72de3701f83a..a05dedf36a12 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.h
+++ b/drivers/misc/xlink-pcie/remote_host/pci.h
@@ -38,6 +38,7 @@ struct xpcie_dev {
 	irq_handler_t core_irq_callback;
 
 	struct xpcie xpcie;
+	xlink_device_event event_fn;
 };
 
 static inline struct device *xpcie_to_dev(struct xpcie *xpcie)
@@ -60,5 +61,7 @@ struct xpcie_dev *intel_xpcie_create_device(u32 sw_device_id,
 void intel_xpcie_remove_device(struct xpcie_dev *xdev);
 void intel_xpcie_list_add_device(struct xpcie_dev *xdev);
 void intel_xpcie_list_del_device(struct xpcie_dev *xdev);
+void intel_xpcie_pci_notify_event(struct xpcie_dev *xdev,
+				  enum xlink_device_event_type event_type);
 
 #endif /* XPCIE_PCI_HEADER_ */
diff --git a/include/linux/xlink_drv_inf.h b/include/linux/xlink_drv_inf.h
index ffe8f4c253e6..5ca0ae1ae2e3 100644
--- a/include/linux/xlink_drv_inf.h
+++ b/include/linux/xlink_drv_inf.h
@@ -44,6 +44,15 @@ enum _xlink_device_status {
 	_XLINK_DEV_READY
 };
 
+enum xlink_device_event_type {
+	NOTIFY_DEVICE_DISCONNECTED,
+	NOTIFY_DEVICE_CONNECTED,
+	NUM_EVENT_TYPE
+};
+
+typedef int (*xlink_device_event)(u32 sw_device_id,
+				  enum xlink_device_event_type event_type);
+
 int xlink_pcie_get_device_list(u32 *sw_device_id_list,
 			       u32 *num_devices);
 int xlink_pcie_get_device_name(u32 sw_device_id, char *device_name,
@@ -57,4 +66,7 @@ int xlink_pcie_read(u32 sw_device_id, void *data, size_t *const size,
 int xlink_pcie_write(u32 sw_device_id, void *data, size_t *const size,
 		     u32 timeout);
 int xlink_pcie_reset_device(u32 sw_device_id);
+int xlink_pcie_register_device_event(u32 sw_device_id,
+				     xlink_device_event event_notif_fn);
+int xlink_pcie_unregister_device_event(u32 sw_device_id);
 #endif
-- 
2.17.1

