Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A253A2C8D25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgK3Sn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbgK3SnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:25 -0500
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com [IPv6:2607:f8b0:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A3C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:45 -0800 (PST)
Received: by mail-ot1-x362.google.com with SMTP id h19so12352191otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWvC/9lmLXawXRr/E+qLrLVml7D3dbTfUiZKC/xB8fQ=;
        b=Xs98REqn4SfqkG/HY4VXIsIEsc+XwMuefO5YrNCab3MLERohz3GisGPmX8FkgspUfh
         Pf79UMLWFsBqRzggDZ5X1jQQ/LUzvmPrmLYuU881PU/HFy2ZwV8hOkARnOZdZoD5WDQN
         UZfBWXt33xDOjdZx3wtIz3nmeOLPB6rA8QUh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWvC/9lmLXawXRr/E+qLrLVml7D3dbTfUiZKC/xB8fQ=;
        b=aGSYacZto9Gae6CgOremYPKdXFD5fcTPPWLX5rxtWRt4mdFD7uek439UaVLgRFkOU3
         GAlCRZQVscwB2YXxlyIOj8gysY88xWMFdh+movqbszKaJPiXahMz486LSXT+JnL4p7Xf
         cQQGqP+erGhkWeF413Qs8qj2Oa+9d7WL+/muGuWAAV7pwNgpRe2kmKsVZ6SmdktQS8bV
         1CameMs+R4+U9SaiRgpbTH6yXHNR61EKLfonp4T2F70rAfF6yj2H7QCEn0TRXTX4lukv
         qGmbDmoObuUkMG7Tx55N2L90WSIMtrLHYpZSu7CdfKzcSaJNlJISAU82mk5m7AZRmV9s
         /Abw==
X-Gm-Message-State: AOAM533kVW2j5LPsI+suFkATXbnohNs+w/Llkbn34BpTYg7sGcBiwkan
        IN83mYnc3s5kOMyqSt2ubJ2A1LfrsMsBZhWdBTl5LNWh2nR5
X-Google-Smtp-Source: ABdhPJxtxvdhphak9zTeIpQ0FY6yIjLx3WoWYffE14tZPcx3jaYgwq1tdGuEH5r7CGn+pLOF4Wxvr/iOiaUt
X-Received: by 2002:a9d:3461:: with SMTP id v88mr17595684otb.40.1606761764674;
        Mon, 30 Nov 2020 10:42:44 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:42:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 04/13] misc: bcm-vk: add misc device to Broadcom VK driver
Date:   Mon, 30 Nov 2020 10:41:51 -0800
Message-Id: <20201130184200.5095-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add misc device base support to create and remove devnode.
Additional misc functions for open/read/write/release/ioctl/sysfs, etc
will be added in follow on commits to allow for individual review.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
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

