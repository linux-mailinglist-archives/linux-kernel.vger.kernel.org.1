Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F238B2F6F68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbhAOAWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:22:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbhAOAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:22:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C0B9AD26;
        Fri, 15 Jan 2021 00:21:41 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] mailbox: bcm: Replace tasklet with threaded irq
Date:   Thu, 14 Jan 2021 16:21:34 -0800
Message-Id: <20210115002134.117637-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

Use a more suitable alternative such as threaded irqs and do the
async work in process context.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 5b375985f7b8..4718722c3c67 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -294,9 +294,6 @@ struct pdc_state {
 
 	unsigned int pdc_irq;
 
-	/* tasklet for deferred processing after DMA rx interrupt */
-	struct tasklet_struct rx_tasklet;
-
 	/* Number of bytes of receive status prior to each rx frame */
 	u32 rx_status_len;
 	/* Whether a BCM header is prepended to each frame */
@@ -953,23 +950,23 @@ static irqreturn_t pdc_irq_handler(int irq, void *data)
 	iowrite32(intstatus, pdcs->pdc_reg_vbase + PDC_INTSTATUS_OFFSET);
 
 	/* Wakeup IRQ thread */
-	tasklet_schedule(&pdcs->rx_tasklet);
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 /**
- * pdc_tasklet_cb() - Tasklet callback that runs the deferred processing after
+ * pdc_task_cb() - Threaded IRQ that runs the deferred processing after
  * a DMA receive interrupt. Reenables the receive interrupt.
  * @data: PDC state structure
  */
-static void pdc_tasklet_cb(struct tasklet_struct *t)
+static irqreturn_t pdc_task_cb(int irq, void *data)
 {
-	struct pdc_state *pdcs = from_tasklet(pdcs, t, rx_tasklet);
+	struct pdc_state *pdcs = data;
 
 	pdc_receive(pdcs);
 
 	/* reenable interrupts */
 	iowrite32(PDC_INTMASK, pdcs->pdc_reg_vbase + PDC_INTMASK_OFFSET);
+	return IRQ_HANDLED;
 }
 
 /**
@@ -1405,8 +1402,8 @@ static int pdc_interrupts_init(struct pdc_state *pdcs)
 	dev_dbg(dev, "pdc device %s irq %u for pdcs %p",
 		dev_name(dev), pdcs->pdc_irq, pdcs);
 
-	err = devm_request_irq(dev, pdcs->pdc_irq, pdc_irq_handler, 0,
-			       dev_name(dev), dev);
+	err = devm_request_threaded_irq(dev, pdcs->pdc_irq, pdc_irq_handler,
+					pdc_task_cb, 0, dev_name(dev), dev);
 	if (err) {
 		dev_err(dev, "IRQ %u request failed with err %d\n",
 			pdcs->pdc_irq, err);
@@ -1588,9 +1585,6 @@ static int pdc_probe(struct platform_device *pdev)
 
 	pdc_hw_init(pdcs);
 
-	/* Init tasklet for deferred DMA rx processing */
-	tasklet_setup(&pdcs->rx_tasklet, pdc_tasklet_cb);
-
 	err = pdc_interrupts_init(pdcs);
 	if (err)
 		goto cleanup_buf_pool;
@@ -1606,7 +1600,6 @@ static int pdc_probe(struct platform_device *pdev)
 	return PDC_SUCCESS;
 
 cleanup_buf_pool:
-	tasklet_kill(&pdcs->rx_tasklet);
 	dma_pool_destroy(pdcs->rx_buf_pool);
 
 cleanup_ring_pool:
@@ -1622,8 +1615,6 @@ static int pdc_remove(struct platform_device *pdev)
 
 	pdc_free_debugfs();
 
-	tasklet_kill(&pdcs->rx_tasklet);
-
 	pdc_hw_disable(pdcs);
 
 	dma_pool_destroy(pdcs->rx_buf_pool);
-- 
2.26.2

