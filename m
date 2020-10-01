Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8527F760
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgJAB24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgJAB2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:28:49 -0400
Received: from mail-ua1-x963.google.com (mail-ua1-x963.google.com [IPv6:2607:f8b0:4864:20::963])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C278DC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:49 -0700 (PDT)
Received: by mail-ua1-x963.google.com with SMTP id v5so999020uau.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MljkgjooAMeAJ9jp32JbeXo3ZuNj29YW0p4n/9lGSg=;
        b=G/qsGaMHps1tW9VJt1JgVieb2H9AML20kVlPew/c/WQJXs/YfyX3oFrdes3puA5Ttq
         HR7eHhUQkL1gh1sX30R7zGdovskFtEuxeKof8s0eVPNhGIdUJQEB9p5Ozx/5hny6fWOp
         KEGppfsMgXB9o1BGqCgMF8jevchcOem2tDOu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MljkgjooAMeAJ9jp32JbeXo3ZuNj29YW0p4n/9lGSg=;
        b=qfL3imRZqFXjvCw3aEu0qJtBhX0sOQzqg2KLc8yBFAPkaJfNBZpOxnzIR5Byko6s2V
         t/YqIemnC3JirWo0vO+SX5epE6GVJYZDLrNzQDxd1o2xe4FXl3VlmOMiplnIGHZYsRCG
         PhKuKLIVlBWBpV3If5NC1NUCvtmFMtzjg70HA9X9nmXcjS/ioyNR9dQoYgV5VtUncwLq
         YOz/5MlUW/xKyAWmdM/76ovVXwTuijS5zY0lwBykwXhVYcuEGgZjrdpJMXRc4lTRol1L
         EjVsdEpcqna6wtFtoWaP06kJE6im/NPyREZJrwBX9djXpnXIdj32jq9/zGwWR2cyeIaV
         XSSg==
X-Gm-Message-State: AOAM531CJ947Gg1hi9pzuh3ClmwKOammjenHi556vN00EqNh5lPhfPWW
        kCJZCniVTCL8LyPwLyhQJ5e1leC3s5UI3Goyde/7ODNlKH2s
X-Google-Smtp-Source: ABdhPJyPlXo7Jxv2wi1iKxJvukXban8+z46duHmMUkcC+Eh1IhNWUyoe7J6MmM75wDnfszxz3Ul8TU6S9qHL
X-Received: by 2002:ab0:2e85:: with SMTP id f5mr3425804uaa.89.1601515728941;
        Wed, 30 Sep 2020 18:28:48 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:28:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v5 06/15] misc: bcm-vk: add open/release
Date:   Wed, 30 Sep 2020 18:28:01 -0700
Message-Id: <20201001012810.4172-7-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
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
 drivers/misc/bcm-vk/bcm_vk_msg.c | 126 +++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  31 ++++++++
 5 files changed, 198 insertions(+), 1 deletion(-)
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
index 7ff43d406950..4bcbd507803d 100644
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
@@ -630,6 +631,12 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
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
@@ -652,10 +659,13 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -732,6 +742,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENOMEM;
 		goto err_ida_remove;
 	}
+	misc_device->fops = &bcm_vk_fops,
 
 	err = misc_register(misc_device);
 	if (err) {
@@ -820,6 +831,16 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -863,6 +884,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_free_irq_vectors(pdev);
 	pci_disable_device(pdev);
+
+	kref_put(&vk->kref, bcm_vk_release_data);
 }
 
 static void bcm_vk_shutdown(struct pci_dev *pdev)
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
new file mode 100644
index 000000000000..eb261fb87c9d
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -0,0 +1,126 @@
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
+int bcm_vk_open(struct inode *inode, struct file *p_file)
+{
+	struct bcm_vk_ctx *ctx;
+	struct miscdevice *miscdev = (struct miscdevice *)p_file->private_data;
+	struct bcm_vk *vk = container_of(miscdev, struct bcm_vk, miscdev);
+	struct device *dev = &vk->pdev->dev;
+	int rc = 0;
+
+	/* get a context and set it up for file */
+	ctx = bcm_vk_get_ctx(vk, task_pid_nr(current));
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

