Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667242F6F63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbhAOAVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:21:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:47292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731197AbhAOAVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:21:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D245DB2D0;
        Fri, 15 Jan 2021 00:20:24 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] platform/goldfish: Convert pipe tasklet to threaded irq
Date:   Thu, 14 Jan 2021 16:20:14 -0800
Message-Id: <20210115002014.117528-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so. A more suitable equivalent
is to converted to threaded irq instead and deal with the signaled
pipes in task context.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/platform/goldfish/goldfish_pipe.c | 28 +++++++++--------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 1ab207ec9c94..b67539f9848c 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -212,9 +212,6 @@ struct goldfish_pipe_dev {
 	int version;
 	unsigned char __iomem *base;
 
-	/* an irq tasklet to run goldfish_interrupt_task */
-	struct tasklet_struct irq_tasklet;
-
 	struct miscdevice miscdev;
 };
 
@@ -577,10 +574,10 @@ static struct goldfish_pipe *signalled_pipes_pop_front(
 	return pipe;
 }
 
-static void goldfish_interrupt_task(unsigned long dev_addr)
+static irqreturn_t goldfish_interrupt_task(int irq, void *dev_addr)
 {
 	/* Iterate over the signalled pipes and wake them one by one */
-	struct goldfish_pipe_dev *dev = (struct goldfish_pipe_dev *)dev_addr;
+	struct goldfish_pipe_dev *dev = dev_addr;
 	struct goldfish_pipe *pipe;
 	int wakes;
 
@@ -599,13 +596,14 @@ static void goldfish_interrupt_task(unsigned long dev_addr)
 		 */
 		wake_up_interruptible(&pipe->wake_queue);
 	}
+	return IRQ_HANDLED;
 }
 
 static void goldfish_pipe_device_deinit(struct platform_device *pdev,
 					struct goldfish_pipe_dev *dev);
 
 /*
- * The general idea of the interrupt handling:
+ * The general idea of the (threaded) interrupt handling:
  *
  *  1. device raises an interrupt if there's at least one signalled pipe
  *  2. IRQ handler reads the signalled pipes and their count from the device
@@ -614,8 +612,8 @@ static void goldfish_pipe_device_deinit(struct platform_device *pdev,
  *      otherwise it leaves it raised, so IRQ handler will be called
  *      again for the next chunk
  *  4. IRQ handler adds all returned pipes to the device's signalled pipes list
- *  5. IRQ handler launches a tasklet to process the signalled pipes from the
- *      list in a separate context
+ *  5. IRQ handler defers processing the signalled pipes from the list in a
+ *      separate context
  */
 static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 {
@@ -645,8 +643,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	tasklet_schedule(&dev->irq_tasklet);
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
@@ -811,12 +808,10 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 {
 	int err;
 
-	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
-		     (unsigned long)dev);
-
-	err = devm_request_irq(&pdev->dev, dev->irq,
-			       goldfish_pipe_interrupt,
-			       IRQF_SHARED, "goldfish_pipe", dev);
+	err = devm_request_threaded_irq(&pdev->dev, dev->irq,
+					goldfish_pipe_interrupt,
+					goldfish_interrupt_task,
+					IRQF_SHARED, "goldfish_pipe", dev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to allocate IRQ for v2\n");
 		return err;
@@ -874,7 +869,6 @@ static void goldfish_pipe_device_deinit(struct platform_device *pdev,
 					struct goldfish_pipe_dev *dev)
 {
 	misc_deregister(&dev->miscdev);
-	tasklet_kill(&dev->irq_tasklet);
 	kfree(dev->pipes);
 	free_page((unsigned long)dev->buffers);
 }
-- 
2.26.2

