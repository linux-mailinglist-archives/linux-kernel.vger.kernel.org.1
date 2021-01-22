Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22929300C68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbhAVTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:22:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:50694 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbhAVTHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:07:14 -0500
IronPort-SDR: b7pVH4DY7l4yY9RLKJZz1gyXM4szufpnsdJLvkSN4R2HrPir/310iHtgFfWx4k5d2WgA65yRs7
 XJUaZonILZSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="159266125"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="159266125"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 11:02:26 -0800
IronPort-SDR: RyHJyChnbDvDb+o5vVtX6yUoXB23IuSWiBjvq4+u50r6YfAnZK67sJX3TWkBqYRRiCXLS3rZ95
 enX7jFt1PUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="407935893"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2021 11:02:25 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v9 08/20] dlb: add runtime power-management support
Date:   Fri, 22 Jan 2021 13:01:26 -0600
Message-Id: <20210122190138.7414-9-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210122190138.7414-1-mike.ximing.chen@intel.com>
References: <20210122190138.7414-1-mike.ximing.chen@intel.com>
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
 drivers/misc/dlb/dlb_main.c   | 101 +++++++++++++++++++++++++++++++++-
 drivers/misc/dlb/dlb_pf_ops.c |   8 +++
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index 70030d779033..5484d9aee02c 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
 
 #include "dlb_main.h"
@@ -73,12 +74,35 @@ static int dlb_open(struct inode *i, struct file *f)
 	f->private_data = dlb;
 	dlb->f = f;
 
+	/*
+	 * Increment the device's usage count and immediately wake it
+	 * if it was suspended.
+	 */
+	pm_runtime_get_sync(&dlb->pdev->dev);
+
+	return 0;
+}
+
+static int dlb_close(struct inode *i, struct file *f)
+{
+	struct dlb *dlb = f->private_data;
+
+	mutex_lock(&dlb->resource_mutex);
+	/*
+	 * Decrement the device's usage count and suspend it when
+	 * the application stops using it.
+	 */
+	pm_runtime_put_sync_suspend(&dlb->pdev->dev);
+
+	mutex_unlock(&dlb->resource_mutex);
+
 	return 0;
 }
 
 static const struct file_operations dlb_fops = {
 	.owner   = THIS_MODULE,
 	.open    = dlb_open,
+	.release = dlb_close,
 	.unlocked_ioctl = dlb_ioctl,
 };
 
@@ -97,6 +121,12 @@ int dlb_init_domain(struct dlb *dlb, u32 domain_id)
 
 	dlb->sched_domains[domain_id] = domain;
 
+	/*
+	 * The matching put is in dlb_free_domain, executed when the domain's
+	 * refcnt reaches zero.
+	 */
+	pm_runtime_get_sync(&dlb->pdev->dev);
+
 	return 0;
 }
 
@@ -121,7 +151,21 @@ static int __dlb_free_domain(struct dlb_domain *domain)
 
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
@@ -230,6 +274,14 @@ static int dlb_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
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
@@ -253,6 +305,9 @@ static void dlb_remove(struct pci_dev *pdev)
 {
 	struct dlb *dlb = pci_get_drvdata(pdev);
 
+	/* Undo the PM operation in dlb_probe(). */
+	pm_runtime_get_noresume(&pdev->dev);
+
 	dlb_resource_free(&dlb->hw);
 
 	device_destroy(dlb_class, dlb->dev_number);
@@ -264,17 +319,61 @@ static void dlb_remove(struct pci_dev *pdev)
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
index 5dea0037d14b..494a482368f6 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -2,6 +2,7 @@
 /* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
 
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "dlb_main.h"
 #include "dlb_regs.h"
@@ -50,6 +51,13 @@ static int dlb_pf_init_driver_state(struct dlb *dlb)
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

