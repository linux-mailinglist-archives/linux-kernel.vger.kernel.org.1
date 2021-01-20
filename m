Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9412E2FD823
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391989AbhATSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:19:06 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:41054 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391909AbhATSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:09:59 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3ECAF2E5EF;
        Wed, 20 Jan 2021 09:58:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3ECAF2E5EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611165515;
        bh=G0JtokNm+NFuFyX3E5lg6X/oWOr8kduycb4M3eR02lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvniM4axQTxKXQgdrRBF+MJGQqXSDuno2ZDRglQiYrgWjtJpcyPrfIA+86fgzg1T7
         3QykBn5I8/2CDfKtpRtpNLp93vrW5XG/SkcwV11FBbfVsGNRRmddsnLPKyB4+78Fa8
         l3vH9aw2jfTLXkXEf/PRvnguVWulqDLBkT+2E9l0=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v9 04/13] misc: bcm-vk: add misc device to Broadcom VK driver
Date:   Wed, 20 Jan 2021 09:58:18 -0800
Message-Id: <20210120175827.14820-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210120175827.14820-1-scott.branden@broadcom.com>
References: <20210120175827.14820-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add misc device base support to create and remove devnode.
Additional misc functions for open/read/write/release/ioctl/sysfs, etc
will be added in follow on commits to allow for individual review.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  2 ++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 36 +++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index c4fb61a84e41..0a366db693c8 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -7,6 +7,7 @@
 #define BCM_VK_H
 
 #include <linux/firmware.h>
+#include <linux/miscdevice.h>
 #include <linux/pci.h>
 #include <linux/sched/signal.h>
 
@@ -214,6 +215,7 @@ struct bcm_vk {
 
 	struct bcm_vk_dauth_info dauth_info;
 
+	struct miscdevice miscdev;
 	int devid; /* dev id allocated */
 
 	struct workqueue_struct *wq_thread;
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index adc3103c7012..4ecd5b5f80d3 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
@@ -643,6 +644,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	char name[20];
 	struct bcm_vk *vk;
 	struct device *dev = &pdev->dev;
+	struct miscdevice *misc_device;
 	u32 boot_status;
 
 	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
@@ -719,6 +721,19 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	vk->devid = id;
 	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
+	misc_device = &vk->miscdev;
+	misc_device->minor = MISC_DYNAMIC_MINOR;
+	misc_device->name = kstrdup(name, GFP_KERNEL);
+	if (!misc_device->name) {
+		err = -ENOMEM;
+		goto err_ida_remove;
+	}
+
+	err = misc_register(misc_device);
+	if (err) {
+		dev_err(dev, "failed to register device\n");
+		goto err_kfree_name;
+	}
 
 	INIT_WORK(&vk->wq_work, bcm_vk_wq_handler);
 
@@ -727,7 +742,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!vk->wq_thread) {
 		dev_err(dev, "Fail to create workqueue thread\n");
 		err = -ENOMEM;
-		goto err_ida_remove;
+		goto err_misc_deregister;
 	}
 
 	/* sync other info */
@@ -749,11 +764,20 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	dev_dbg(dev, "BCM-VK:%u created\n", id);
+
 	return 0;
 
 err_destroy_workqueue:
 	destroy_workqueue(vk->wq_thread);
 
+err_misc_deregister:
+	misc_deregister(misc_device);
+
+err_kfree_name:
+	kfree(misc_device->name);
+	misc_device->name = NULL;
+
 err_ida_remove:
 	ida_simple_remove(&bcm_vk_ida, id);
 
@@ -783,6 +807,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	struct miscdevice *misc_device = &vk->miscdev;
 
 	/*
 	 * Trigger a reset to card and wait enough time for UCODE to rerun,
@@ -797,6 +822,13 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
 				  vk->tdma_vaddr, vk->tdma_addr);
 
+	/* remove if name is set which means misc dev registered */
+	if (misc_device->name) {
+		misc_deregister(misc_device);
+		kfree(misc_device->name);
+		ida_simple_remove(&bcm_vk_ida, vk->devid);
+	}
+
 	cancel_work_sync(&vk->wq_work);
 	destroy_workqueue(vk->wq_thread);
 
@@ -805,6 +837,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, vk->bar[i]);
 	}
 
+	dev_dbg(&pdev->dev, "BCM-VK:%d released\n", vk->devid);
+
 	pci_release_regions(pdev);
 	pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1

