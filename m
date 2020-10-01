Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC427F75E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgJAB2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbgJAB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:28:46 -0400
Received: from mail-ua1-x964.google.com (mail-ua1-x964.google.com [IPv6:2607:f8b0:4864:20::964])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A0C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:45 -0700 (PDT)
Received: by mail-ua1-x964.google.com with SMTP id f15so1000929uaq.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTwMbH4nejbbSRKAyfUPGrgJ3xVqC3r+G++e8N26mw4=;
        b=NQQT78V1k2DNmDhDtX78jFHibNaG4blysqgGJBIUpttpjM6eFzT/8a9pPzUhkngDxS
         KdlgvgnHdeQXjp8eDDx/IOR4FYIIpDrVEPkej2XwjzSKPU+08TYIWasES1tdZaRG76oo
         t701zFSdhwUu74pyYcl3SzG8cy18kkcuJJOBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTwMbH4nejbbSRKAyfUPGrgJ3xVqC3r+G++e8N26mw4=;
        b=cfYE6CxW8GdOVBuzHW2TYoWi5qy5o8ZX+MOa/ZBk0a2+ZxX/c2M8tGJVzyGfigKb9Z
         W3hO++C8HV/GOHByFhHl/APROpT04QX1E/BeT2KKrw23VD3t1qaLKs/07CU5ZHUW6K7M
         MjdGtLIbYXLUfHyznpFT7PkNPm72Tsv1TeHXyQvhfN0nlj7EQHa74tLd57++VHqfkTil
         rJiMo3KIcluG00YBBPUNzhcNfXsKwaHor9Cva2tAAxjR7NH2Af30iylMONXq5sIjA2ea
         6R8814AHc+KyZcBnaAb3oGxnUK3ztEqZFQZVN7vlEFnrBBYa5B/zjmUXHudeeuVRqD+9
         y/Kw==
X-Gm-Message-State: AOAM5322KfFIEbF/HYQbj1i3DKL1asp1U9TBAgufxb0yJUZ1oPpepg4I
        e9JSldoLxFByDKaouLco52kNUOKo//sstIHGfhCL6wS+jcbm
X-Google-Smtp-Source: ABdhPJwW43cnEEVNqhXX6pr0JCcmppfEp32xqzGojmD6SmSnBT1hhPz7LFs7T9jfkLksCulhKalqZnYufMTj
X-Received: by 2002:ab0:2ea1:: with SMTP id y1mr3522918uay.104.1601515724986;
        Wed, 30 Sep 2020 18:28:44 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:28:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v5 04/15] misc: bcm-vk: add misc device to Broadcom VK driver
Date:   Wed, 30 Sep 2020 18:27:59 -0700
Message-Id: <20201001012810.4172-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
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
index 50a65f6f290b..c46591124eb4 100644
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
@@ -713,6 +715,19 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
 
@@ -721,7 +736,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!vk->wq_thread) {
 		dev_err(dev, "Fail to create workqueue thread\n");
 		err = -ENOMEM;
-		goto err_ida_remove;
+		goto err_misc_deregister;
 	}
 
 	/* sync other info */
@@ -743,11 +758,20 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	dev_dbg(dev, "BCM-VK:%u created, 0x%p\n", id, vk);
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
 
@@ -777,6 +801,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	struct miscdevice *misc_device = &vk->miscdev;
 
 	/*
 	 * Trigger a reset to card and wait enough time for UCODE to rerun,
@@ -791,6 +816,13 @@ static void bcm_vk_remove(struct pci_dev *pdev)
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
 
@@ -799,6 +831,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, vk->bar[i]);
 	}
 
+	dev_dbg(&pdev->dev, "BCM-VK:%d released\n", vk->devid);
+
 	pci_release_regions(pdev);
 	pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1

