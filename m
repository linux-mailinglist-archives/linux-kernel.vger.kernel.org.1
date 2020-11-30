Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C42C8D27
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgK3Snh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbgK3Sng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:36 -0500
Received: from mail-ot1-x361.google.com (mail-ot1-x361.google.com [IPv6:2607:f8b0:4864:20::361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E9C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:55 -0800 (PST)
Received: by mail-ot1-x361.google.com with SMTP id 11so12284731oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YGKZ09M+PFh33Tlfbmu2QNhXg+Jaj/JQ7iD93oFaUC8=;
        b=DLcYxvjISDDeTzEovgSxKhYOeNDECQY7qAbhSwv5OSk2lVu++TmY5zY5u2ruQ6hNhi
         dmcx4/RcIqiLKF6HYewmAdbP3VcVmP+yX59kvOA/YMGSec16iDOsrxa6/c3030g+k+CC
         174rQkAQV5Ti+mmIkZSqjXT8PguZpmlI9yAxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YGKZ09M+PFh33Tlfbmu2QNhXg+Jaj/JQ7iD93oFaUC8=;
        b=OHWHdXpZgdRDkHVVFco2ae/0ga66w1UWFfLlPG/ox2Nmytl5c0jDbFoa+RLq9bevTt
         0We0OFKK3SR/HSQjOUw1x0t9gVVjq8HuGeL/ILN2Gocbzh5VOiiHl2k7YMXLRSJezrCS
         lsoZqHRYKHnCzEA34SP3drbURLZk4xDGoiPLuHenhHSpkHxv4qL++CqD1uMkPk2JAF8i
         vh6jvY6CZNkN1Dk3qI85z8opMRHgBzo7/3BTZd1Nh+So3SSKLVpqe9nQCTVu305GiNND
         c5YRC7xwvdFX4BcDKRVEnsLJTTS2adDbik1cFRyvNMWRu3vMfGGArWXQTlfJp628i11m
         uZsw==
X-Gm-Message-State: AOAM533gkndJ2tDFusQTpV/44LDRy/j4YiSsMILKEm1D95ry61lnYXoI
        qlORif+0JrSm71Kj/b37WSfXKmQOxhUCbfNUq6MNLeEN+KUB
X-Google-Smtp-Source: ABdhPJxD+Lr2z7yKRSK49vnUYGOROo1Rjpb0mujo7/GrmOkozJUQRHbINzSYPFVQ4Zs4Eom5FvljAS2dy86l
X-Received: by 2002:a9d:6854:: with SMTP id c20mr18364873oto.319.1606761774986;
        Mon, 30 Nov 2020 10:42:54 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:42:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 06/13] misc: bcm-vk: add open/release
Date:   Mon, 30 Nov 2020 10:41:53 -0800
Message-Id: <20201130184200.5095-7-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add open/release to replace private data with context for other methods
to use.  Reason for the context is because it is allowed for multiple
sessions to open sysfs.  For each file open, when upper layer queries the
response, only those that are tied to a specified open should be returned.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/Makefile     |   4 +-
 drivers/misc/bcm-vk/bcm_vk.h     |  15 ++++
 drivers/misc/bcm-vk/bcm_vk_dev.c |  23 ++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 127 +++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  31 ++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h

diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
index f8a7ac4c242f..a2ae79858409 100644
--- a/drivers/misc/bcm-vk/Makefile
+++ b/drivers/misc/bcm-vk/Makefile
@@ -5,4 +5,6 @@
 
 obj-$(CONFIG_BCM_VK) += bcm_vk.o
 bcm_vk-objs := \
-	bcm_vk_dev.o
+	bcm_vk_dev.o \
+	bcm_vk_msg.o
+
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index f428ad9a0c3d..5f0fcfdaf265 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -7,9 +7,14 @@
 #define BCM_VK_H
 
 #include <linux/firmware.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/sched/signal.h>
+#include <uapi/linux/misc/bcm_vk.h>
+
+#include "bcm_vk_msg.h"
 
 #define DRV_MODULE_NAME		"bcm-vk"
 
@@ -218,6 +223,13 @@ struct bcm_vk {
 	struct miscdevice miscdev;
 	int devid; /* dev id allocated */
 
+	/* Reference-counting to handle file operations */
+	struct kref kref;
+
+	spinlock_t ctx_lock; /* Spinlock for component context */
+	struct bcm_vk_ctx ctx[VK_CMPT_CTX_MAX];
+	struct bcm_vk_ht_entry pid_ht[VK_PID_HT_SZ];
+
 	struct workqueue_struct *wq_thread;
 	struct work_struct wq_work; /* work queue for deferred job */
 	unsigned long wq_offload[1]; /* various flags on wq requested */
@@ -278,6 +290,9 @@ static inline bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
 	return (rdy_marker == VK_BAR1_MSGQ_RDY_MARKER);
 }
 
+int bcm_vk_open(struct inode *inode, struct file *p_file);
+int bcm_vk_release(struct inode *inode, struct file *p_file);
+void bcm_vk_release_data(struct kref *kref);
 int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
 
 #endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 09d99bd36e8a..79fffb1e6f84 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -8,6 +8,7 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
@@ -635,6 +636,12 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	return 0;
 }
 
+static const struct file_operations bcm_vk_fops = {
+	.owner = THIS_MODULE,
+	.open = bcm_vk_open,
+	.release = bcm_vk_release,
+};
+
 static int bcm_vk_on_panic(struct notifier_block *nb,
 			   unsigned long e, void *p)
 {
@@ -657,10 +664,13 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct miscdevice *misc_device;
 	u32 boot_status;
 
+	/* allocate vk structure which is tied to kref for freeing */
 	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
 	if (!vk)
 		return -ENOMEM;
 
+	kref_init(&vk->kref);
+
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(dev, "Cannot enable PCI device\n");
@@ -738,6 +748,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENOMEM;
 		goto err_ida_remove;
 	}
+	misc_device->fops = &bcm_vk_fops,
 
 	err = misc_register(misc_device);
 	if (err) {
@@ -826,6 +837,16 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+void bcm_vk_release_data(struct kref *kref)
+{
+	struct bcm_vk *vk = container_of(kref, struct bcm_vk, kref);
+	struct pci_dev *pdev = vk->pdev;
+
+	dev_dbg(&pdev->dev, "BCM-VK:%d release data 0x%p\n", vk->devid, vk);
+	pci_dev_put(pdev);
+	kfree(vk);
+}
+
 static void bcm_vk_remove(struct pci_dev *pdev)
 {
 	int i;
@@ -869,6 +890,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
+
+	kref_put(&vk->kref, bcm_vk_release_data);
 }
 
 static void bcm_vk_shutdown(struct pci_dev *pdev)
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
new file mode 100644
index 000000000000..2d9a6b4e5f61
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#include "bcm_vk.h"
+#include "bcm_vk_msg.h"
+
+/*
+ * allocate a ctx per file struct
+ */
+static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
+{
+	u32 i;
+	struct bcm_vk_ctx *ctx = NULL;
+	u32 hash_idx = hash_32(pid, VK_PID_HT_SHIFT_BIT);
+
+	spin_lock(&vk->ctx_lock);
+
+	for (i = 0; i < ARRAY_SIZE(vk->ctx); i++) {
+		if (!vk->ctx[i].in_use) {
+			vk->ctx[i].in_use = true;
+			ctx = &vk->ctx[i];
+			break;
+		}
+	}
+
+	if (!ctx) {
+		dev_err(&vk->pdev->dev, "All context in use\n");
+
+		goto all_in_use_exit;
+	}
+
+	/* set the pid and insert it to hash table */
+	ctx->pid = pid;
+	ctx->hash_idx = hash_idx;
+	list_add_tail(&ctx->node, &vk->pid_ht[hash_idx].head);
+
+	/* increase kref */
+	kref_get(&vk->kref);
+
+all_in_use_exit:
+	spin_unlock(&vk->ctx_lock);
+
+	return ctx;
+}
+
+static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
+{
+	u32 idx;
+	u32 hash_idx;
+	pid_t pid;
+	struct bcm_vk_ctx *entry;
+	int count = 0;
+
+	if (!ctx) {
+		dev_err(&vk->pdev->dev, "NULL context detected\n");
+		return -EINVAL;
+	}
+	idx = ctx->idx;
+	pid = ctx->pid;
+
+	spin_lock(&vk->ctx_lock);
+
+	if (!vk->ctx[idx].in_use) {
+		dev_err(&vk->pdev->dev, "context[%d] not in use!\n", idx);
+	} else {
+		vk->ctx[idx].in_use = false;
+		vk->ctx[idx].miscdev = NULL;
+
+		/* Remove it from hash list and see if it is the last one. */
+		list_del(&ctx->node);
+		hash_idx = ctx->hash_idx;
+		list_for_each_entry(entry, &vk->pid_ht[hash_idx].head, node) {
+			if (entry->pid == pid)
+				count++;
+		}
+	}
+
+	spin_unlock(&vk->ctx_lock);
+
+	return count;
+}
+
+int bcm_vk_open(struct inode *inode, struct file *p_file)
+{
+	struct bcm_vk_ctx *ctx;
+	struct miscdevice *miscdev = (struct miscdevice *)p_file->private_data;
+	struct bcm_vk *vk = container_of(miscdev, struct bcm_vk, miscdev);
+	struct device *dev = &vk->pdev->dev;
+	int rc = 0;
+
+	/* get a context and set it up for file */
+	ctx = bcm_vk_get_ctx(vk, task_tgid_nr(current));
+	if (!ctx) {
+		dev_err(dev, "Error allocating context\n");
+		rc = -ENOMEM;
+	} else {
+		/*
+		 * set up context and replace private data with context for
+		 * other methods to use.  Reason for the context is because
+		 * it is allowed for multiple sessions to open the sysfs, and
+		 * for each file open, when upper layer query the response,
+		 * only those that are tied to a specific open should be
+		 * returned.  The context->idx will be used for such binding
+		 */
+		ctx->miscdev = miscdev;
+		p_file->private_data = ctx;
+		dev_dbg(dev, "ctx_returned with idx %d, pid %d\n",
+			ctx->idx, ctx->pid);
+	}
+	return rc;
+}
+
+int bcm_vk_release(struct inode *inode, struct file *p_file)
+{
+	int ret;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+
+	ret = bcm_vk_free_ctx(vk, ctx);
+
+	kref_put(&vk->kref, bcm_vk_release_data);
+
+	return ret;
+}
+
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
new file mode 100644
index 000000000000..32516abcaf89
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef BCM_VK_MSG_H
+#define BCM_VK_MSG_H
+
+/* context per session opening of sysfs */
+struct bcm_vk_ctx {
+	struct list_head node; /* use for linkage in Hash Table */
+	unsigned int idx;
+	bool in_use;
+	pid_t pid;
+	u32 hash_idx;
+	struct miscdevice *miscdev;
+};
+
+/* pid hash table entry */
+struct bcm_vk_ht_entry {
+	struct list_head head;
+};
+
+/* total number of supported ctx, 32 ctx each for 5 components */
+#define VK_CMPT_CTX_MAX		(32 * 5)
+
+/* hash table defines to store the opened FDs */
+#define VK_PID_HT_SHIFT_BIT	7 /* 128 */
+#define VK_PID_HT_SZ		BIT(VK_PID_HT_SHIFT_BIT)
+
+#endif
-- 
2.17.1

