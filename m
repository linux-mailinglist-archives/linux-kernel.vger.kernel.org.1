Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3874E2A360E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKBVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:36:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:41714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBVgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:36:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3ED69AD09;
        Mon,  2 Nov 2020 21:36:40 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Date:   Mon,  2 Nov 2020 13:14:50 -0800
Message-Id: <20201102211450.5722-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the
system by running in irq context - and this is not a performance
critical path. If a higher priority process wants to run, it
must wait for the tasklet to finish before doing so. In addition,
mutex_trylock() is not supposed to be used in irq context because
it can confuse priority boosting in PREEMPT_RT, although in this
case the lock is held and released in the same context.

This conversion from tasklet to workqueue allows to avoid
playing games with the disconnect mutex, having to re-reschedule
in the callback, now just take the mutex normally. There is
also no need anymore for atomic allocations.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
Compile tested only.

 drivers/usb/serial/mos7720.c | 38 ++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 5eed1078fac8..6982800e61d4 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -101,7 +101,7 @@ struct mos7715_parport {
 	spinlock_t              listlock;      /* protects list access */
 	bool                    msg_pending;   /* usb sync call pending */
 	struct completion       syncmsg_compl; /* usb sync call completed */
-	struct tasklet_struct   urb_tasklet;   /* for sending deferred urbs */
+	struct work_struct      urb_wq;        /* for sending deferred urbs */
 	struct usb_serial       *serial;       /* back to containing struct */
 	__u8	                shadowECR;     /* parallel port regs... */
 	__u8	                shadowDCR;
@@ -278,32 +278,28 @@ static void destroy_urbtracker(struct kref *kref)
 }
 
 /*
- * This runs as a tasklet when sending an urb in a non-blocking parallel
- * port callback had to be deferred because the disconnect mutex could not be
- * obtained at the time.
+ * This runs as a workqueue (process context) when sending a urb from a
+ * non-blocking parallel port callback which had to be deferred because
+ * the disconnect mutex could not be obtained at the time.
  */
-static void send_deferred_urbs(struct tasklet_struct *t)
+static void send_deferred_urbs(struct work_struct *work)
 {
 	int ret_val;
 	unsigned long flags;
-	struct mos7715_parport *mos_parport = from_tasklet(mos_parport, t,
-							   urb_tasklet);
+	struct mos7715_parport *mos_parport;
 	struct urbtracker *urbtrack, *tmp;
 	struct list_head *cursor, *next;
 	struct device *dev;
 
+	mos_parport = container_of(work, struct mos7715_parport, urb_wq);
+
 	/* if release function ran, game over */
 	if (unlikely(mos_parport->serial == NULL))
 		return;
 
 	dev = &mos_parport->serial->dev->dev;
 
-	/* try again to get the mutex */
-	if (!mutex_trylock(&mos_parport->serial->disc_mutex)) {
-		dev_dbg(dev, "%s: rescheduling tasklet\n", __func__);
-		tasklet_schedule(&mos_parport->urb_tasklet);
-		return;
-	}
+	mutex_lock(&mos_parport->serial->disc_mutex);
 
 	/* if device disconnected, game over */
 	if (unlikely(mos_parport->serial->disconnected)) {
@@ -324,7 +320,7 @@ static void send_deferred_urbs(struct tasklet_struct *t)
 		list_move_tail(cursor, &mos_parport->active_urbs);
 	list_for_each_entry_safe(urbtrack, tmp, &mos_parport->active_urbs,
 			    urblist_entry) {
-		ret_val = usb_submit_urb(urbtrack->urb, GFP_ATOMIC);
+		ret_val = usb_submit_urb(urbtrack->urb, GFP_KERNEL);
 		dev_dbg(dev, "%s: urb submitted\n", __func__);
 		if (ret_val) {
 			dev_err(dev, "usb_submit_urb() failed: %d\n", ret_val);
@@ -394,15 +390,15 @@ static int write_parport_reg_nonblock(struct mos7715_parport *mos_parport,
 
 	/*
 	 * get the disconnect mutex, or add tracker to the deferred_urbs list
-	 * and schedule a tasklet to try again later
+	 * and schedule a workqueue to process it later
 	 */
 	if (!mutex_trylock(&serial->disc_mutex)) {
 		spin_lock_irqsave(&mos_parport->listlock, flags);
 		list_add_tail(&urbtrack->urblist_entry,
 			      &mos_parport->deferred_urbs);
 		spin_unlock_irqrestore(&mos_parport->listlock, flags);
-		tasklet_schedule(&mos_parport->urb_tasklet);
-		dev_dbg(&usbdev->dev, "tasklet scheduled\n");
+		schedule_work(&mos_parport->urb_wq);
+		dev_dbg(&usbdev->dev, "workqueue scheduled\n");
 		return 0;
 	}
 
@@ -717,7 +713,7 @@ static int mos7715_parport_init(struct usb_serial *serial)
 	INIT_LIST_HEAD(&mos_parport->deferred_urbs);
 	usb_set_serial_data(serial, mos_parport); /* hijack private pointer */
 	mos_parport->serial = serial;
-	tasklet_setup(&mos_parport->urb_tasklet, send_deferred_urbs);
+	INIT_WORK(&mos_parport->urb_wq, send_deferred_urbs);
 	init_completion(&mos_parport->syncmsg_compl);
 
 	/* cycle parallel port reset bit */
@@ -1886,10 +1882,10 @@ static void mos7720_release(struct usb_serial *serial)
 		usb_set_serial_data(serial, NULL);
 		mos_parport->serial = NULL;
 
-		/* if tasklet currently scheduled, wait for it to complete */
-		tasklet_kill(&mos_parport->urb_tasklet);
+		/* if work is currently scheduled, wait for it to complete */
+		cancel_work_sync(&mos_parport->urb_wq);
 
-		/* unlink any urbs sent by the tasklet  */
+		/* unlink any urbs sent by the workqueue */
 		spin_lock_irqsave(&mos_parport->listlock, flags);
 		list_for_each_entry(urbtrack,
 				    &mos_parport->active_urbs,
-- 
2.26.2

