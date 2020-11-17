Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07092B7264
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgKQXZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgKQXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:25:09 -0500
Received: from mail-ot1-x361.google.com (mail-ot1-x361.google.com [IPv6:2607:f8b0:4864:20::361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E9FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:25:09 -0800 (PST)
Received: by mail-ot1-x361.google.com with SMTP id o3so10689264ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27qcdclEsn8xhcFuF/gKpBwwGYzUGYeyg031xUtmQcs=;
        b=bmwSExFE1cQhi/dCorg4UiR2T5Il8LEPtHbfSHBzoA+8dlB4Z20Yu7+md0VWswUZLa
         DDh9UlIp/mMrdF3tatTEkHJnC8yge1N7e00qX9PQ09p2NenmSHEvqIOQC52ewiSN1oKi
         Br0c/be2pbLQ5auSSdwY3jDXe75WsBTaPoG58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27qcdclEsn8xhcFuF/gKpBwwGYzUGYeyg031xUtmQcs=;
        b=EdCISkiLf33HyFzIY+sqaSiC5N6Ey7fwOBLly71NPYwiF20OzPxjnCBX/ssVxRzzRD
         022bv2Q3IVLCdKsiP2DqvxIYiYevIDPOzEC5R1Laa5Saz6KPA9MRsSHGtrUMzTo53M6j
         msbXAwECsBigiYVk0HgKBLM6gVgn7vxmcjgMB4zVkQefYVu7qqnycg1Dt/vw9CQGmXBj
         CMrkHZt5JsgKoaroagMITjQ6z4LRgM96o34cU9e1NhQjyE8zb2Qn8UPJVfFkoKgXuxqM
         +8M0qhJqv7fV3pAQicMRAw2+GODGdoH3LpyzYbtA7WSFmZ1senIzrMxJ5Kep9bIlfQqs
         kZRQ==
X-Gm-Message-State: AOAM531mvPtaGZ8d8LPjm0OidT+2Zh+pmi5HpwWFSUVQ+2QYueCNOmUv
        Md1n3zPyjlBtdivaU862Q7hOKtIoW7prXpd2VIqnQdNtsiOu
X-Google-Smtp-Source: ABdhPJxIKITGTf4d/K7suD4JHxL/28z3Mmy+avCcaSQC0Bl09uGUsA4GcgmlVzqwfB5r3t0ljzGPc1o8opvf
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr4846167otk.191.1605655509008;
        Tue, 17 Nov 2020 15:25:09 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id q22sm5867076otg.13.2020.11.17.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:25:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v7 13/13] misc: bcm-vk: add ttyVK support
Date:   Tue, 17 Nov 2020 15:23:20 -0800
Message-Id: <20201117232320.4958-14-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117232320.4958-1-scott.branden@broadcom.com>
References: <20201117232320.4958-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ttyVK support to driver to allow console access to VK card from host.

Device node will be in the follow form /dev/bcm-vk.x_ttyVKy where:
x is the instance of the VK card
y is the tty device number on the VK card

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/Makefile     |   3 +-
 drivers/misc/bcm-vk/bcm_vk.h     |  28 +++
 drivers/misc/bcm-vk/bcm_vk_dev.c |  30 ++-
 drivers/misc/bcm-vk/bcm_vk_tty.c | 333 +++++++++++++++++++++++++++++++
 4 files changed, 392 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c

diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
index 79b4e365c9e6..e4a1486f7209 100644
--- a/drivers/misc/bcm-vk/Makefile
+++ b/drivers/misc/bcm-vk/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_BCM_VK) += bcm_vk.o
 bcm_vk-objs := \
 	bcm_vk_dev.o \
 	bcm_vk_msg.o \
-	bcm_vk_sg.o
+	bcm_vk_sg.o \
+	bcm_vk_tty.o
 
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index a1d0bf6e694c..3f37c640a814 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -8,12 +8,14 @@
 
 #include <linux/atomic.h>
 #include <linux/firmware.h>
+#include <linux/irq.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
+#include <linux/tty.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/misc/bcm_vk.h>
 
@@ -84,6 +86,9 @@
 #define CODEPUSH_BOOT2_ENTRY		0x60000000
 
 #define BAR_CARD_STATUS			0x410
+/* CARD_STATUS definitions */
+#define CARD_STATUS_TTYVK0_READY	BIT(0)
+#define CARD_STATUS_TTYVK1_READY	BIT(1)
 
 #define BAR_BOOT1_STDALONE_PROGRESS	0x420
 #define BOOT1_STDALONE_SUCCESS		(BIT(13) | BIT(14))
@@ -255,6 +260,19 @@ enum pci_barno {
 
 #define BCM_VK_NUM_TTY 2
 
+struct bcm_vk_tty {
+	struct tty_port port;
+	u32 to_offset;	/* bar offset to use */
+	u32 to_size;	/* to VK buffer size */
+	u32 wr;		/* write offset shadow */
+	u32 from_offset;	/* bar offset to use */
+	u32 from_size;	/* from VK buffer size */
+	u32 rd;		/* read offset shadow */
+	pid_t pid;
+	bool irq_enabled;
+	bool is_opened;		/* tracks tty open/close */
+};
+
 /* VK device max power state, supports 3, full, reduced and low */
 #define MAX_OPP 3
 #define MAX_CARD_INFO_TAG_SIZE 64
@@ -348,6 +366,12 @@ struct bcm_vk {
 	struct miscdevice miscdev;
 	int devid; /* dev id allocated */
 
+	struct tty_driver *tty_drv;
+	struct timer_list serial_timer;
+	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
+	struct workqueue_struct *tty_wq_thread;
+	struct work_struct tty_wq_work;
+
 	/* Reference-counting to handle file operations */
 	struct kref kref;
 
@@ -466,6 +490,7 @@ int bcm_vk_release(struct inode *inode, struct file *p_file);
 void bcm_vk_release_data(struct kref *kref);
 irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
 irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
+irqreturn_t bcm_vk_tty_irqhandler(int irq, void *dev_id);
 int bcm_vk_msg_init(struct bcm_vk *vk);
 void bcm_vk_msg_remove(struct bcm_vk *vk);
 void bcm_vk_drain_msg_on_reset(struct bcm_vk *vk);
@@ -476,6 +501,9 @@ int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
 			     const pid_t pid, const u32 q_num);
 void bcm_to_v_q_doorbell(struct bcm_vk *vk, u32 q_num, u32 db_val);
 int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
+int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
+void bcm_vk_tty_exit(struct bcm_vk *vk);
+void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
 void bcm_vk_hb_init(struct bcm_vk *vk);
 void bcm_vk_hb_deinit(struct bcm_vk *vk);
 void bcm_vk_handle_notf(struct bcm_vk *vk);
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index cac07419f041..c3d2bba68ef1 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -525,6 +525,7 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 			}
 		}
 	}
+	bcm_vk_tty_terminate_tty_user(vk);
 	spin_unlock(&vk->ctx_lock);
 }
 
@@ -1384,6 +1385,20 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	vk->num_irqs++;
 
+	for (i = 0;
+	     (i < VK_MSIX_TTY_MAX) && (vk->num_irqs < irq);
+	     i++, vk->num_irqs++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
+				       bcm_vk_tty_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, vk);
+		if (err) {
+			dev_err(dev, "failed request tty IRQ %d for MSIX %d\n",
+				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
+			goto err_irq;
+		}
+		vk->tty[i].irq_enabled = true;
+	}
+
 	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
@@ -1436,6 +1451,11 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_destroy_workqueue;
 	}
 
+	snprintf(name, sizeof(name), KBUILD_MODNAME ".%d_ttyVK", id);
+	err = bcm_vk_tty_init(vk, name);
+	if (err)
+		goto err_unregister_panic_notifier;
+
 	/*
 	 * lets trigger an auto download.  We don't want to do it serially here
 	 * because at probing time, it is not supposed to block for a long time.
@@ -1444,7 +1464,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (auto_load) {
 		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
 			if (bcm_vk_trigger_autoload(vk))
-				goto err_unregister_panic_notifier;
+				goto err_bcm_vk_tty_exit;
 		} else {
 			dev_err(dev,
 				"Auto-load skipped - BROM not in proper state (0x%x)\n",
@@ -1459,6 +1479,9 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+err_bcm_vk_tty_exit:
+	bcm_vk_tty_exit(vk);
+
 err_unregister_panic_notifier:
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &vk->panic_nb);
@@ -1536,6 +1559,9 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &vk->panic_nb);
 
+	bcm_vk_msg_remove(vk);
+	bcm_vk_tty_exit(vk);
+
 	if (vk->tdma_vaddr)
 		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
 				  vk->tdma_vaddr, vk->tdma_addr);
@@ -1554,6 +1580,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&vk->wq_work);
 	destroy_workqueue(vk->wq_thread);
+	cancel_work_sync(&vk->tty_wq_work);
+	destroy_workqueue(vk->tty_wq_thread);
 
 	for (i = 0; i < MAX_BAR; i++) {
 		if (vk->bar[i])
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
new file mode 100644
index 000000000000..be3964949b63
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+
+#include "bcm_vk.h"
+
+/* TTYVK base offset is 0x30000 into BAR1 */
+#define BAR1_TTYVK_BASE_OFFSET	0x300000
+/* Each TTYVK channel (TO or FROM) is 0x10000 */
+#define BAR1_TTYVK_CHAN_OFFSET	0x100000
+/* Each TTYVK channel has TO and FROM, hence the * 2 */
+#define BAR1_TTYVK_BASE(index)	(BAR1_TTYVK_BASE_OFFSET + \
+				 ((index) * BAR1_TTYVK_CHAN_OFFSET * 2))
+/* TO TTYVK channel base comes before FROM for each index */
+#define TO_TTYK_BASE(index)	BAR1_TTYVK_BASE(index)
+#define FROM_TTYK_BASE(index)	(BAR1_TTYVK_BASE(index) + \
+				 BAR1_TTYVK_CHAN_OFFSET)
+
+struct bcm_vk_tty_chan {
+	u32 reserved;
+	u32 size;
+	u32 wr;
+	u32 rd;
+	u32 *data;
+};
+
+#define VK_BAR_CHAN(v, DIR, e)	((v)->DIR##_offset \
+				 + offsetof(struct bcm_vk_tty_chan, e))
+#define VK_BAR_CHAN_SIZE(v, DIR)	VK_BAR_CHAN(v, DIR, size)
+#define VK_BAR_CHAN_WR(v, DIR)		VK_BAR_CHAN(v, DIR, wr)
+#define VK_BAR_CHAN_RD(v, DIR)		VK_BAR_CHAN(v, DIR, rd)
+#define VK_BAR_CHAN_DATA(v, DIR, off)	(VK_BAR_CHAN(v, DIR, data) + (off))
+
+#define VK_BAR0_REGSEG_TTY_DB_OFFSET	0x86c
+
+/* Poll every 1/10 of second - temp hack till we use MSI interrupt */
+#define SERIAL_TIMER_VALUE (HZ / 10)
+
+static void bcm_vk_tty_poll(struct timer_list *t)
+{
+	struct bcm_vk *vk = from_timer(vk, t, serial_timer);
+
+	queue_work(vk->tty_wq_thread, &vk->tty_wq_work);
+	mod_timer(&vk->serial_timer, jiffies + SERIAL_TIMER_VALUE);
+}
+
+irqreturn_t bcm_vk_tty_irqhandler(int irq, void *dev_id)
+{
+	struct bcm_vk *vk = dev_id;
+
+	queue_work(vk->tty_wq_thread, &vk->tty_wq_work);
+
+	return IRQ_HANDLED;
+}
+
+static void bcm_vk_tty_wq_handler(struct work_struct *work)
+{
+	struct bcm_vk *vk = container_of(work, struct bcm_vk, tty_wq_work);
+	struct bcm_vk_tty *vktty;
+	int card_status;
+	int count;
+	unsigned char c;
+	int i;
+	int wr;
+
+	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
+	if (BCM_VK_INTF_IS_DOWN(card_status))
+		return;
+
+	for (i = 0; i < BCM_VK_NUM_TTY; i++) {
+		count = 0;
+		/* Check the card status that the tty channel is ready */
+		if ((card_status & BIT(i)) == 0)
+			continue;
+
+		vktty = &vk->tty[i];
+
+		/* Don't increment read index if tty app is closed */
+		if (!vktty->is_opened)
+			continue;
+
+		/* Fetch the wr offset in buffer from VK */
+		wr = vkread32(vk, BAR_1, VK_BAR_CHAN_WR(vktty, from));
+
+		/* safe to ignore until bar read gives proper size */
+		if (vktty->from_size == 0)
+			continue;
+
+		if (wr >= vktty->from_size) {
+			dev_err(&vk->pdev->dev,
+				"ERROR: wq handler ttyVK%d wr:0x%x > 0x%x\n",
+				i, wr, vktty->from_size);
+			/* Need to signal and close device in this case */
+			continue;
+		}
+
+		/*
+		 * Simple read of circular buffer and
+		 * insert into tty flip buffer
+		 */
+		while (vk->tty[i].rd != wr) {
+			c = vkread8(vk, BAR_1,
+				    VK_BAR_CHAN_DATA(vktty, from, vktty->rd));
+			vktty->rd++;
+			if (vktty->rd >= vktty->from_size)
+				vktty->rd = 0;
+			tty_insert_flip_char(&vktty->port, c, TTY_NORMAL);
+			count++;
+		}
+
+		if (count) {
+			tty_flip_buffer_push(&vktty->port);
+
+			/* Update read offset from shadow register to card */
+			vkwrite32(vk, vktty->rd, BAR_1,
+				  VK_BAR_CHAN_RD(vktty, from));
+		}
+	}
+}
+
+static int bcm_vk_tty_open(struct tty_struct *tty, struct file *file)
+{
+	int card_status;
+	struct bcm_vk *vk;
+	struct bcm_vk_tty *vktty;
+	int index;
+
+	/* initialize the pointer in case something fails */
+	tty->driver_data = NULL;
+
+	vk = (struct bcm_vk *)dev_get_drvdata(tty->dev);
+	index = tty->index;
+
+	if (index >= BCM_VK_NUM_TTY)
+		return -EINVAL;
+
+	vktty = &vk->tty[index];
+
+	vktty->pid = task_pid_nr(current);
+	vktty->to_offset = TO_TTYK_BASE(index);
+	vktty->from_offset = FROM_TTYK_BASE(index);
+
+	/* Do not allow tty device to be opened if tty on card not ready */
+	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
+	if (BCM_VK_INTF_IS_DOWN(card_status) || ((card_status & BIT(index)) == 0))
+		return -EBUSY;
+
+	/*
+	 * Get shadow registers of the buffer sizes and the "to" write offset
+	 * and "from" read offset
+	 */
+	vktty->to_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, to));
+	vktty->wr = vkread32(vk, BAR_1,  VK_BAR_CHAN_WR(vktty, to));
+	vktty->from_size = vkread32(vk, BAR_1, VK_BAR_CHAN_SIZE(vktty, from));
+	vktty->rd = vkread32(vk, BAR_1,  VK_BAR_CHAN_RD(vktty, from));
+	vktty->is_opened = true;
+
+	if (tty->count == 1 && !vktty->irq_enabled) {
+		timer_setup(&vk->serial_timer, bcm_vk_tty_poll, 0);
+		mod_timer(&vk->serial_timer, jiffies + SERIAL_TIMER_VALUE);
+	}
+	return 0;
+}
+
+static void bcm_vk_tty_close(struct tty_struct *tty, struct file *file)
+{
+	struct bcm_vk *vk = dev_get_drvdata(tty->dev);
+
+	if (tty->index >= BCM_VK_NUM_TTY)
+		return;
+
+	vk->tty[tty->index].is_opened = false;
+
+	if (tty->count == 1)
+		del_timer_sync(&vk->serial_timer);
+}
+
+static void bcm_vk_tty_doorbell(struct bcm_vk *vk, u32 db_val)
+{
+	vkwrite32(vk, db_val, BAR_0,
+		  VK_BAR0_REGSEG_DB_BASE + VK_BAR0_REGSEG_TTY_DB_OFFSET);
+}
+
+static int bcm_vk_tty_write(struct tty_struct *tty,
+			    const unsigned char *buffer,
+			    int count)
+{
+	int index;
+	struct bcm_vk *vk;
+	struct bcm_vk_tty *vktty;
+	int i;
+
+	index = tty->index;
+	vk = dev_get_drvdata(tty->dev);
+	vktty = &vk->tty[index];
+
+	/* Simple write each byte to circular buffer */
+	for (i = 0; i < count; i++) {
+		vkwrite8(vk, buffer[i], BAR_1,
+			 VK_BAR_CHAN_DATA(vktty, to, vktty->wr));
+		vktty->wr++;
+		if (vktty->wr >= vktty->to_size)
+			vktty->wr = 0;
+	}
+	/* Update write offset from shadow register to card */
+	vkwrite32(vk, vktty->wr, BAR_1, VK_BAR_CHAN_WR(vktty, to));
+	bcm_vk_tty_doorbell(vk, 0);
+
+	return count;
+}
+
+static int bcm_vk_tty_write_room(struct tty_struct *tty)
+{
+	struct bcm_vk *vk = dev_get_drvdata(tty->dev);
+
+	return vk->tty[tty->index].to_size - 1;
+}
+
+static const struct tty_operations serial_ops = {
+	.open = bcm_vk_tty_open,
+	.close = bcm_vk_tty_close,
+	.write = bcm_vk_tty_write,
+	.write_room = bcm_vk_tty_write_room,
+};
+
+int bcm_vk_tty_init(struct bcm_vk *vk, char *name)
+{
+	int i;
+	int err;
+	struct tty_driver *tty_drv;
+	struct device *dev = &vk->pdev->dev;
+
+	tty_drv = tty_alloc_driver
+				(BCM_VK_NUM_TTY,
+				 TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(tty_drv))
+		return PTR_ERR(tty_drv);
+
+	/* Save struct tty_driver for uninstalling the device */
+	vk->tty_drv = tty_drv;
+
+	/* initialize the tty driver */
+	tty_drv->driver_name = KBUILD_MODNAME;
+	tty_drv->name = kstrdup(name, GFP_KERNEL);
+	if (!tty_drv->name) {
+		err = -ENOMEM;
+		goto err_put_tty_driver;
+	}
+	tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
+	tty_drv->subtype = SERIAL_TYPE_NORMAL;
+	tty_drv->init_termios = tty_std_termios;
+	tty_set_operations(tty_drv, &serial_ops);
+
+	/* register the tty driver */
+	err = tty_register_driver(tty_drv);
+	if (err) {
+		dev_err(dev, "tty_register_driver failed\n");
+		goto err_kfree_tty_name;
+	}
+
+	for (i = 0; i < BCM_VK_NUM_TTY; i++) {
+		struct device *tty_dev;
+
+		tty_port_init(&vk->tty[i].port);
+		tty_dev = tty_port_register_device(&vk->tty[i].port, tty_drv,
+						   i, dev);
+		if (IS_ERR(tty_dev)) {
+			err = PTR_ERR(tty_dev);
+			goto unwind;
+		}
+		dev_set_drvdata(tty_dev, vk);
+		vk->tty[i].is_opened = false;
+	}
+
+	INIT_WORK(&vk->tty_wq_work, bcm_vk_tty_wq_handler);
+	vk->tty_wq_thread = create_singlethread_workqueue("tty");
+	if (!vk->tty_wq_thread) {
+		dev_err(dev, "Fail to create tty workqueue thread\n");
+		err = -ENOMEM;
+		goto unwind;
+	}
+	return 0;
+
+unwind:
+	while (--i >= 0)
+		tty_port_unregister_device(&vk->tty[i].port, tty_drv, i);
+	tty_unregister_driver(tty_drv);
+
+err_kfree_tty_name:
+	kfree(tty_drv->name);
+	tty_drv->name = NULL;
+
+err_put_tty_driver:
+	put_tty_driver(tty_drv);
+
+	return err;
+}
+
+void bcm_vk_tty_exit(struct bcm_vk *vk)
+{
+	int i;
+
+	del_timer_sync(&vk->serial_timer);
+	for (i = 0; i < BCM_VK_NUM_TTY; ++i) {
+		tty_port_unregister_device(&vk->tty[i].port,
+					   vk->tty_drv,
+					   i);
+		tty_port_destroy(&vk->tty[i].port);
+	}
+	tty_unregister_driver(vk->tty_drv);
+
+	kfree(vk->tty_drv->name);
+	vk->tty_drv->name = NULL;
+
+	put_tty_driver(vk->tty_drv);
+}
+
+void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk)
+{
+	struct bcm_vk_tty *vktty;
+	int i;
+
+	for (i = 0; i < BCM_VK_NUM_TTY; ++i) {
+		vktty = &vk->tty[i];
+		if (vktty->pid)
+			kill_pid(find_vpid(vktty->pid), SIGKILL, 1);
+	}
+}
-- 
2.17.1

