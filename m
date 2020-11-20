Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F192BA1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgKTFQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:16:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:57262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgKTFQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:16:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCD1BAC23;
        Fri, 20 Nov 2020 05:16:16 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     johan@kernel.org
Cc:     dave@stgolabs.net, dbueso@suse.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3] USB: serial: mos7720: defer state restore to a workqueue
Date:   Thu, 19 Nov 2020 20:53:00 -0800
Message-Id: <20201120045300.28804-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <X7TzUr+nl+P4SL6c@localhost>
References: <X7TzUr+nl+P4SL6c@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parallel port restore operation currently defers writes
to a tasklet, if it sees a locked disconnect mutex. The
driver goes to a lot of trouble to ensure writes happen
in a non-blocking context, but things can be greatly
simplified if it's done in regular process context and
this is not a system performance critical path. As such,
instead of doing the state restore writes in irq context,
use a workqueue and just do regular synchronous writes.

In addition to the cleanup, this also imposes less on the
overall system as tasklets have been deprecated because
of it's softirq implications, potentially blocking a higher
priority task from running.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

 drivers/usb/serial/mos7720.c | 234 ++++++-----------------------------
 1 file changed, 35 insertions(+), 199 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 5a5d2a95070e..41ee2984a0df 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -79,14 +79,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define DCR_INIT_VAL       0x0c	/* SLCTIN, nINIT */
 #define ECR_INIT_VAL       0x00	/* SPP mode */
 
-struct urbtracker {
-	struct mos7715_parport  *mos_parport;
-	struct list_head        urblist_entry;
-	struct kref             ref_count;
-	struct urb              *urb;
-	struct usb_ctrlrequest	*setup;
-};
-
 enum mos7715_pp_modes {
 	SPP = 0<<5,
 	PS2 = 1<<5,      /* moschip calls this 'NIBBLE' mode */
@@ -96,12 +88,9 @@ enum mos7715_pp_modes {
 struct mos7715_parport {
 	struct parport          *pp;	       /* back to containing struct */
 	struct kref             ref_count;     /* to instance of this struct */
-	struct list_head        deferred_urbs; /* list deferred async urbs */
-	struct list_head        active_urbs;   /* list async urbs in flight */
-	spinlock_t              listlock;      /* protects list access */
 	bool                    msg_pending;   /* usb sync call pending */
 	struct completion       syncmsg_compl; /* usb sync call completed */
-	struct tasklet_struct   urb_tasklet;   /* for sending deferred urbs */
+	struct work_struct      work;          /* restore deferred writes */
 	struct usb_serial       *serial;       /* back to containing struct */
 	__u8	                shadowECR;     /* parallel port regs... */
 	__u8	                shadowDCR;
@@ -265,174 +254,8 @@ static void destroy_mos_parport(struct kref *kref)
 	kfree(mos_parport);
 }
 
-static void destroy_urbtracker(struct kref *kref)
-{
-	struct urbtracker *urbtrack =
-		container_of(kref, struct urbtracker, ref_count);
-	struct mos7715_parport *mos_parport = urbtrack->mos_parport;
-
-	usb_free_urb(urbtrack->urb);
-	kfree(urbtrack->setup);
-	kfree(urbtrack);
-	kref_put(&mos_parport->ref_count, destroy_mos_parport);
-}
-
 /*
- * This runs as a tasklet when sending an urb in a non-blocking parallel
- * port callback had to be deferred because the disconnect mutex could not be
- * obtained at the time.
- */
-static void send_deferred_urbs(struct tasklet_struct *t)
-{
-	int ret_val;
-	unsigned long flags;
-	struct mos7715_parport *mos_parport = from_tasklet(mos_parport, t,
-							   urb_tasklet);
-	struct urbtracker *urbtrack, *tmp;
-	struct list_head *cursor, *next;
-	struct device *dev;
-
-	/* if release function ran, game over */
-	if (unlikely(mos_parport->serial == NULL))
-		return;
-
-	dev = &mos_parport->serial->dev->dev;
-
-	/* try again to get the mutex */
-	if (!mutex_trylock(&mos_parport->serial->disc_mutex)) {
-		dev_dbg(dev, "%s: rescheduling tasklet\n", __func__);
-		tasklet_schedule(&mos_parport->urb_tasklet);
-		return;
-	}
-
-	/* if device disconnected, game over */
-	if (unlikely(mos_parport->serial->disconnected)) {
-		mutex_unlock(&mos_parport->serial->disc_mutex);
-		return;
-	}
-
-	spin_lock_irqsave(&mos_parport->listlock, flags);
-	if (list_empty(&mos_parport->deferred_urbs)) {
-		spin_unlock_irqrestore(&mos_parport->listlock, flags);
-		mutex_unlock(&mos_parport->serial->disc_mutex);
-		dev_dbg(dev, "%s: deferred_urbs list empty\n", __func__);
-		return;
-	}
-
-	/* move contents of deferred_urbs list to active_urbs list and submit */
-	list_for_each_safe(cursor, next, &mos_parport->deferred_urbs)
-		list_move_tail(cursor, &mos_parport->active_urbs);
-	list_for_each_entry_safe(urbtrack, tmp, &mos_parport->active_urbs,
-			    urblist_entry) {
-		ret_val = usb_submit_urb(urbtrack->urb, GFP_ATOMIC);
-		dev_dbg(dev, "%s: urb submitted\n", __func__);
-		if (ret_val) {
-			dev_err(dev, "usb_submit_urb() failed: %d\n", ret_val);
-			list_del(&urbtrack->urblist_entry);
-			kref_put(&urbtrack->ref_count, destroy_urbtracker);
-		}
-	}
-	spin_unlock_irqrestore(&mos_parport->listlock, flags);
-	mutex_unlock(&mos_parport->serial->disc_mutex);
-}
-
-/* callback for parallel port control urbs submitted asynchronously */
-static void async_complete(struct urb *urb)
-{
-	struct urbtracker *urbtrack = urb->context;
-	int status = urb->status;
-	unsigned long flags;
-
-	if (unlikely(status))
-		dev_dbg(&urb->dev->dev, "%s - nonzero urb status received: %d\n", __func__, status);
-
-	/* remove the urbtracker from the active_urbs list */
-	spin_lock_irqsave(&urbtrack->mos_parport->listlock, flags);
-	list_del(&urbtrack->urblist_entry);
-	spin_unlock_irqrestore(&urbtrack->mos_parport->listlock, flags);
-	kref_put(&urbtrack->ref_count, destroy_urbtracker);
-}
-
-static int write_parport_reg_nonblock(struct mos7715_parport *mos_parport,
-				      enum mos_regs reg, __u8 data)
-{
-	struct urbtracker *urbtrack;
-	int ret_val;
-	unsigned long flags;
-	struct usb_serial *serial = mos_parport->serial;
-	struct usb_device *usbdev = serial->dev;
-
-	/* create and initialize the control urb and containing urbtracker */
-	urbtrack = kmalloc(sizeof(struct urbtracker), GFP_ATOMIC);
-	if (!urbtrack)
-		return -ENOMEM;
-
-	urbtrack->urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!urbtrack->urb) {
-		kfree(urbtrack);
-		return -ENOMEM;
-	}
-	urbtrack->setup = kmalloc(sizeof(*urbtrack->setup), GFP_ATOMIC);
-	if (!urbtrack->setup) {
-		usb_free_urb(urbtrack->urb);
-		kfree(urbtrack);
-		return -ENOMEM;
-	}
-	urbtrack->setup->bRequestType = (__u8)0x40;
-	urbtrack->setup->bRequest = (__u8)0x0e;
-	urbtrack->setup->wValue = cpu_to_le16(get_reg_value(reg, dummy));
-	urbtrack->setup->wIndex = cpu_to_le16(get_reg_index(reg));
-	urbtrack->setup->wLength = 0;
-	usb_fill_control_urb(urbtrack->urb, usbdev,
-			     usb_sndctrlpipe(usbdev, 0),
-			     (unsigned char *)urbtrack->setup,
-			     NULL, 0, async_complete, urbtrack);
-	kref_get(&mos_parport->ref_count);
-	urbtrack->mos_parport = mos_parport;
-	kref_init(&urbtrack->ref_count);
-	INIT_LIST_HEAD(&urbtrack->urblist_entry);
-
-	/*
-	 * get the disconnect mutex, or add tracker to the deferred_urbs list
-	 * and schedule a tasklet to try again later
-	 */
-	if (!mutex_trylock(&serial->disc_mutex)) {
-		spin_lock_irqsave(&mos_parport->listlock, flags);
-		list_add_tail(&urbtrack->urblist_entry,
-			      &mos_parport->deferred_urbs);
-		spin_unlock_irqrestore(&mos_parport->listlock, flags);
-		tasklet_schedule(&mos_parport->urb_tasklet);
-		dev_dbg(&usbdev->dev, "tasklet scheduled\n");
-		return 0;
-	}
-
-	/* bail if device disconnected */
-	if (serial->disconnected) {
-		kref_put(&urbtrack->ref_count, destroy_urbtracker);
-		mutex_unlock(&serial->disc_mutex);
-		return -ENODEV;
-	}
-
-	/* add the tracker to the active_urbs list and submit */
-	spin_lock_irqsave(&mos_parport->listlock, flags);
-	list_add_tail(&urbtrack->urblist_entry, &mos_parport->active_urbs);
-	spin_unlock_irqrestore(&mos_parport->listlock, flags);
-	ret_val = usb_submit_urb(urbtrack->urb, GFP_ATOMIC);
-	mutex_unlock(&serial->disc_mutex);
-	if (ret_val) {
-		dev_err(&usbdev->dev,
-			"%s: submit_urb() failed: %d\n", __func__, ret_val);
-		spin_lock_irqsave(&mos_parport->listlock, flags);
-		list_del(&urbtrack->urblist_entry);
-		spin_unlock_irqrestore(&mos_parport->listlock, flags);
-		kref_put(&urbtrack->ref_count, destroy_urbtracker);
-		return ret_val;
-	}
-	return 0;
-}
-
-/*
- * This is the the common top part of all parallel port callback operations that
+ * This is the common top part of all parallel port callback operations that
  * send synchronous messages to the device.  This implements convoluted locking
  * that avoids two scenarios: (1) a port operation is called after usbserial
  * has called our release function, at which point struct mos7715_parport has
@@ -458,6 +281,10 @@ static int parport_prologue(struct parport *pp)
 	reinit_completion(&mos_parport->syncmsg_compl);
 	spin_unlock(&release_lock);
 
+	/* ensure writes from restore are submitted before new requests */
+	if (work_pending(&mos_parport->work))
+		flush_work(&mos_parport->work);
+
 	mutex_lock(&mos_parport->serial->disc_mutex);
 	if (mos_parport->serial->disconnected) {
 		/* device disconnected */
@@ -482,6 +309,26 @@ static inline void parport_epilogue(struct parport *pp)
 	complete(&mos_parport->syncmsg_compl);
 }
 
+static void deferred_restore_writes(struct work_struct *work)
+{
+	struct mos7715_parport *mos_parport;
+
+	mos_parport = container_of(work, struct mos7715_parport, work);
+
+	mutex_lock(&mos_parport->serial->disc_mutex);
+
+	/* if device disconnected, game over */
+	if (mos_parport->serial->disconnected)
+		goto done;
+
+	write_mos_reg(mos_parport->serial, dummy, MOS7720_DCR,
+		      mos_parport->shadowDCR);
+	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
+		      mos_parport->shadowECR);
+done:
+	mutex_unlock(&mos_parport->serial->disc_mutex);
+}
+
 static void parport_mos7715_write_data(struct parport *pp, unsigned char d)
 {
 	struct mos7715_parport *mos_parport = pp->private_data;
@@ -641,10 +488,8 @@ static void parport_mos7715_restore_state(struct parport *pp,
 	}
 	mos_parport->shadowDCR = s->u.pc.ctr;
 	mos_parport->shadowECR = s->u.pc.ecr;
-	write_parport_reg_nonblock(mos_parport, MOS7720_DCR,
-				   mos_parport->shadowDCR);
-	write_parport_reg_nonblock(mos_parport, MOS7720_ECR,
-				   mos_parport->shadowECR);
+
+	schedule_work(&mos_parport->work);
 	spin_unlock(&release_lock);
 }
 
@@ -714,12 +559,9 @@ static int mos7715_parport_init(struct usb_serial *serial)
 
 	mos_parport->msg_pending = false;
 	kref_init(&mos_parport->ref_count);
-	spin_lock_init(&mos_parport->listlock);
-	INIT_LIST_HEAD(&mos_parport->active_urbs);
-	INIT_LIST_HEAD(&mos_parport->deferred_urbs);
 	usb_set_serial_data(serial, mos_parport); /* hijack private pointer */
 	mos_parport->serial = serial;
-	tasklet_setup(&mos_parport->urb_tasklet, send_deferred_urbs);
+	INIT_WORK(&mos_parport->work, deferred_restore_writes);
 	init_completion(&mos_parport->syncmsg_compl);
 
 	/* cycle parallel port reset bit */
@@ -1869,8 +1711,6 @@ static void mos7720_release(struct usb_serial *serial)
 
 	if (le16_to_cpu(serial->dev->descriptor.idProduct)
 	    == MOSCHIP_DEVICE_ID_7715) {
-		struct urbtracker *urbtrack;
-		unsigned long flags;
 		struct mos7715_parport *mos_parport =
 			usb_get_serial_data(serial);
 
@@ -1883,21 +1723,17 @@ static void mos7720_release(struct usb_serial *serial)
 		if (mos_parport->msg_pending)
 			wait_for_completion_timeout(&mos_parport->syncmsg_compl,
 					    msecs_to_jiffies(MOS_WDR_TIMEOUT));
+		/*
+		 * If delayed work is currently scheduled, wait for it to
+		 * complete. This also implies barriers that ensure the
+		 * below serial clearing is not hoisted above the ->work.
+		 */
+		cancel_work_sync(&mos_parport->work);
 
 		parport_remove_port(mos_parport->pp);
 		usb_set_serial_data(serial, NULL);
 		mos_parport->serial = NULL;
 
-		/* if tasklet currently scheduled, wait for it to complete */
-		tasklet_kill(&mos_parport->urb_tasklet);
-
-		/* unlink any urbs sent by the tasklet  */
-		spin_lock_irqsave(&mos_parport->listlock, flags);
-		list_for_each_entry(urbtrack,
-				    &mos_parport->active_urbs,
-				    urblist_entry)
-			usb_unlink_urb(urbtrack->urb);
-		spin_unlock_irqrestore(&mos_parport->listlock, flags);
 		parport_del_port(mos_parport->pp);
 
 		kref_put(&mos_parport->ref_count, destroy_mos_parport);
-- 
2.26.2

