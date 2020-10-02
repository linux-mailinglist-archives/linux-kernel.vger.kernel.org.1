Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39891281D9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgJBVYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:24:21 -0400
Received: from mail-vk1-xa64.google.com (mail-vk1-xa64.google.com [IPv6:2607:f8b0:4864:20::a64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86741C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:24:21 -0700 (PDT)
Received: by mail-vk1-xa64.google.com with SMTP id n193so561098vkf.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfe3d8pKQFPTBS6QVux16fxAvOtkU7zBCrM6EkdW2PU=;
        b=aKq6s7kX7xFx1G+TKNnKAjjvh0eLcCceTikuczuncxmdb/C9002/odS6WZ/JoonNNP
         n42O3V4mp2pNCAynytq73Jfyzq5SvT0cCDK62fCx3TIvyFOx1TR9a2btI4iG3bXjAve+
         fJ1unGB/Wd+h/EIuirAWrjfENSJq10eKvJE2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfe3d8pKQFPTBS6QVux16fxAvOtkU7zBCrM6EkdW2PU=;
        b=E4V2+P0HxojOQqi9ObSLo2uC2YyRBkAMi1sNsRYMFCyfqL8d7PzQD8KHTSeAq2yEuh
         FURz5gWgNjXomPkNGXofdygraMTA1DrekgC6FCkNAvet4PgHlagwfc9yKN6EZlPZVgV7
         HtubqnMj78RgjiFEOVLo2n/fFP/bW6bwgwhBP4u6WRDD6Y/A/qCHT6SlSv9tmyGSota5
         +Ei5x+8EAYKM65CLHD6J8SwYB1YOG1J+ADdLXUgyrV9FIVGZ47KiZ9emS8E08ew+6rQA
         TWF2Yh++oicdofEfDyMalGE5PvnVmyJAEn8Mj8TtKuKPk6kAJmEFolqrKIyuq5K6u1oQ
         Hwpw==
X-Gm-Message-State: AOAM532PDG8wnu659LSZ6xhRdvyFWc7SD+UL5qknnaJB2cFYbpxZ5iuL
        9WdbT8hruF7J2ohsVJQzDUJszTwhIDAI8Oa+noWJhKj0uAXp
X-Google-Smtp-Source: ABdhPJzKk5Bcjmq4UblXnfWNR6Zmbeutqq4KnDIQf/jtw/WprwejLI9qL2Zt5NvH9klQteGXcj+3TEDou0cj
X-Received: by 2002:ac5:ccd3:: with SMTP id j19mr2418324vkn.8.1601673860701;
        Fri, 02 Oct 2020 14:24:20 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:24:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 04/14] misc: bcm-vk: add misc device to Broadcom VK driver
Date:   Fri,  2 Oct 2020 14:23:17 -0700
Message-Id: <20201002212327.18393-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002212327.18393-1-scott.branden@broadcom.com>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
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
index 3fbfcd9b9de8..c7bedd975609 100644
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
@@ -638,6 +639,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	char name[20];
 	struct bcm_vk *vk;
 	struct device *dev = &pdev->dev;
+	struct miscdevice *misc_device;
 	u32 boot_status;
 
 	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
@@ -714,6 +716,19 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
 
@@ -722,7 +737,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!vk->wq_thread) {
 		dev_err(dev, "Fail to create workqueue thread\n");
 		err = -ENOMEM;
-		goto err_ida_remove;
+		goto err_misc_deregister;
 	}
 
 	/* sync other info */
@@ -744,11 +759,20 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -778,6 +802,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	struct miscdevice *misc_device = &vk->miscdev;
 
 	/*
 	 * Trigger a reset to card and wait enough time for UCODE to rerun,
@@ -792,6 +817,13 @@ static void bcm_vk_remove(struct pci_dev *pdev)
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
 
@@ -800,6 +832,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, vk->bar[i]);
 	}
 
+	dev_dbg(&pdev->dev, "BCM-VK:%d released\n", vk->devid);
+
 	pci_release_regions(pdev);
 	pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1

