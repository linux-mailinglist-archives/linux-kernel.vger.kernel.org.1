Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209AE27B8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgI2AMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgI2AMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:12:48 -0400
Received: from mail-pf1-x463.google.com (mail-pf1-x463.google.com [IPv6:2607:f8b0:4864:20::463])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD856C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:47 -0700 (PDT)
Received: by mail-pf1-x463.google.com with SMTP id b124so2746793pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e01dV72PhVXckVmmseLxTWhtW5vQVL68iuUA5f0aj7c=;
        b=TbdGNplAh2RLlDUFKbenetNEA1JUmz0IuK7oh8p2eAEaRbPAmunTGe1UeaufPTi/be
         RQp5YnfL18G2ylmjFpFIxCaDmX/f592U6NctFr3qs6YueEhZay6VOtmPeyA6QHWsOJDZ
         qPnc7UfZx4dI2mtfeJ643qZwF4WEJqEClfBcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e01dV72PhVXckVmmseLxTWhtW5vQVL68iuUA5f0aj7c=;
        b=dAn+NeFK56AgAVVo7L5qF/xE/iwHdFUzkIV5u+8x7J449/fSjhcqRqNrMqOWpE0bc8
         u+VHZ6s7gTlyP0b62lZFs4IOo38Jhk6je0gj+Jc0QkvO7fSlZKl7gcvUwKtbC2gu/uOE
         DiJGiZOnVtaMeYNe2UJDJBCENNp3TkpMZB/KSnNryrWZ1D/bmVc2A7tW19MPMW2Pdnpm
         1kLP8t7MnBg/oF+0atL4pQfR+6Sn1LOYxOisAXPyV9QDADan8fBE76QUoEXI6n/xX/YQ
         YIVY8lwO9Lp1V2mH2a9h3dsVWvfKr5o1LpbYKJ/hYB9lFi+qEzWQEr+eGhR0YVxoSWLr
         JUPw==
X-Gm-Message-State: AOAM531XqW/Q+e8CTztfYIvOUo/2MyGYPI/jVOEyyrnNQ/ObUId2rl2y
        6ZhzFYxcIE+VJnWifgkhZ/Gl9TrBdlRHFcRQPKyNiWMoIW2c
X-Google-Smtp-Source: ABdhPJyM9B6InzQN9eJhhQyWMf0sXSoFwxUj7At7+9GRKl8UE8Mea1x8+O5wnC1prjyGF9LVy8e29Mu0VedK
X-Received: by 2002:a65:498a:: with SMTP id r10mr1089352pgs.400.1601338367292;
        Mon, 28 Sep 2020 17:12:47 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:12:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v4 04/16] misc: bcm-vk: add misc device to Broadcom VK driver
Date:   Mon, 28 Sep 2020 17:11:57 -0700
Message-Id: <20200929001209.16393-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
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
index 36f04fd0a54e..cb2e315881d6 100644
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
 
@@ -774,6 +798,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct bcm_vk *vk = pci_get_drvdata(pdev);
+	struct miscdevice *misc_device = &vk->miscdev;
 
 	/*
 	 * Trigger a reset to card and wait enough time for UCODE to rerun,
@@ -788,6 +813,13 @@ static void bcm_vk_remove(struct pci_dev *pdev)
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
 
@@ -796,6 +828,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, vk->bar[i]);
 	}
 
+	dev_dbg(&pdev->dev, "BCM-VK:%d released\n", vk->devid);
+
 	pci_release_regions(pdev);
 	pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1

