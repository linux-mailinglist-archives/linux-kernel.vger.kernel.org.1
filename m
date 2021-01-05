Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45262EA38E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbhAEC7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:41794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbhAEC7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:23 -0500
IronPort-SDR: LtBfAEHlqS8t1ZLXfOrSVZlvljIBZCGOGSH64ezohdO6C7do5Bu4SGgodA0e/k7laHmrC+U6n/
 bzXgMhdzKckQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827519"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:16 -0800
IronPort-SDR: 4V7IBqj9zQRhGfUibhvr47pDSF45ENPnPJIL3bSzXBfnQl3vfEEjy8VwZDLWpnvguxhUS8uml2
 +nc0HbnIrUTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632143"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:15 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 08/20] dlb: add runtime power-management support
Date:   Mon,  4 Jan 2021 20:58:27 -0600
Message-Id: <20210105025839.23169-9-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented a power-management policy of putting the device in D0 when in
use (when there are any open device files or memory mappings, or there are
any virtual devices), and D3Hot otherwise.

Add resume/suspend callbacks; when the device resumes, reset the hardware
to a known good state.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/dlb_main.c   | 90 ++++++++++++++++++++++++++++++++++-
 drivers/misc/dlb/dlb_pf_ops.c |  8 ++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index 05cc02ff9e4a..67dc4d0319b0 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
 
 #include "dlb_ioctl.h"
@@ -84,6 +85,12 @@ static int dlb_open(struct inode *i, struct file *f)
 
 	f->private_data = dlb;
 
+	/*
+	 * Increment the device's usage count and immediately wake it
+	 * if it was suspended.
+	 */
+	pm_runtime_get_sync(&dlb->pdev->dev);
+
 	return 0;
 }
 
@@ -92,6 +99,12 @@ static int dlb_close(struct inode *i, struct file *f)
 	struct dlb *dlb = f->private_data;
 
 	mutex_lock(&dlb->resource_mutex);
+	/*
+	 * Decrement the device's usage count and suspend it when
+	 * the application stops using it.
+	 */
+	pm_runtime_put_sync_suspend(&dlb->pdev->dev);
+
 	f->private_data = NULL;
 	mutex_unlock(&dlb->resource_mutex);
 
@@ -121,6 +134,12 @@ int dlb_init_domain(struct dlb *dlb, u32 domain_id)
 
 	dlb->sched_domains[domain_id] = domain;
 
+	/*
+	 * The matching put is in dlb_free_domain, executed when the domain's
+	 * refcnt reaches zero.
+	 */
+	pm_runtime_get_sync(&dlb->pdev->dev);
+
 	return 0;
 }
 
@@ -145,7 +164,21 @@ static int __dlb_free_domain(struct dlb_domain *domain)
 
 void dlb_free_domain(struct kref *kref)
 {
-	__dlb_free_domain(container_of(kref, struct dlb_domain, refcnt));
+	struct dlb_domain *domain;
+	struct dlb *dlb;
+
+	domain = container_of(kref, struct dlb_domain, refcnt);
+
+	dlb = domain->dlb;
+
+	__dlb_free_domain(domain);
+
+	/*
+	 * Decrement the device's usage count and suspend it when
+	 * the last application stops using it. The matching get is in
+	 * dlb_init_domain.
+	 */
+	pm_runtime_put_sync_suspend(&dlb->pdev->dev);
 }
 
 static int dlb_domain_close(struct inode *i, struct file *f)
@@ -258,6 +291,14 @@ static int dlb_probe(struct pci_dev *pdev,
 	if (ret)
 		goto init_driver_state_fail;
 
+	/*
+	 * Undo the 'get' operation by the PCI layer during probe and
+	 * (if PF) immediately suspend the device. Since the device is only
+	 * enabled when an application requests it, an autosuspend delay is
+	 * likely not beneficial.
+	 */
+	pm_runtime_put_sync_suspend(&pdev->dev);
+
 	return 0;
 
 init_driver_state_fail:
@@ -281,6 +322,9 @@ static void dlb_remove(struct pci_dev *pdev)
 {
 	struct dlb *dlb = pci_get_drvdata(pdev);
 
+	/* Undo the PM operation in dlb_probe(). */
+	pm_runtime_get_noresume(&pdev->dev);
+
 	dlb_resource_free(&dlb->hw);
 
 	device_destroy(dlb_class, dlb->dev_number);
@@ -292,17 +336,61 @@ static void dlb_remove(struct pci_dev *pdev)
 	spin_unlock(&dlb_ids_lock);
 }
 
+#ifdef CONFIG_PM
+static void dlb_reset_hardware_state(struct dlb *dlb)
+{
+	dlb_reset_device(dlb->pdev);
+}
+
+static int dlb_runtime_suspend(struct device *dev)
+{
+	/* Return and let the PCI subsystem put the device in D3hot. */
+
+	return 0;
+}
+
+static int dlb_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dlb *dlb = pci_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * The PCI subsystem put the device in D0, but the device may not have
+	 * completed powering up. Wait until the device is ready before
+	 * proceeding.
+	 */
+	ret = dlb->ops->wait_for_device_ready(dlb, pdev);
+	if (ret)
+		return ret;
+
+	/* Now reinitialize the device state. */
+	dlb_reset_hardware_state(dlb);
+
+	return 0;
+}
+#endif
+
 static struct pci_device_id dlb_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, DLB_PF, DLB_PF) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, dlb_id_table);
 
+#ifdef CONFIG_PM
+static const struct dev_pm_ops dlb_pm_ops = {
+	SET_RUNTIME_PM_OPS(dlb_runtime_suspend, dlb_runtime_resume, NULL)
+};
+#endif
+
 static struct pci_driver dlb_pci_driver = {
 	.name		 = "dlb",
 	.id_table	 = dlb_id_table,
 	.probe		 = dlb_probe,
 	.remove		 = dlb_remove,
+#ifdef CONFIG_PM
+	.driver.pm	 = &dlb_pm_ops,
+#endif
 };
 
 static int __init dlb_init_module(void)
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
index 7822290ce8a6..e989bc8f2c97 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -2,6 +2,7 @@
 /* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
 
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "dlb_main.h"
 #include "dlb_regs.h"
@@ -53,6 +54,13 @@ dlb_pf_init_driver_state(struct dlb *dlb)
 {
 	mutex_init(&dlb->resource_mutex);
 
+	/*
+	 * Allow PF runtime power-management (forbidden by default by the PCI
+	 * layer during scan). The driver puts the device into D3hot while
+	 * there are no scheduling domains to service.
+	 */
+	pm_runtime_allow(&dlb->pdev->dev);
+
 	return 0;
 }
 
-- 
2.17.1

