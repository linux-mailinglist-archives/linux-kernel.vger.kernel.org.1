Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD312A8F84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKFGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:39:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFGjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:39:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 524DCABCC;
        Fri,  6 Nov 2020 06:39:06 +0000 (UTC)
Date:   Thu, 5 Nov 2020 22:17:13 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201105082540.GA4085@localhost>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Johan Hovold wrote:
>On Wed, Nov 04, 2020 at 04:13:07PM -0800, Davidlohr Bueso wrote:
>> Also, but not strictly related to this. What do you think of deferring all
>> work in write_parport_reg_nonblock() unconditionally? I'd like to avoid
>> that mutex_trylock() because eventually I'll be re-adding a warn in the
>> locking code, but that would also simplify the code done here in the
>> nonblocking irq write. I'm not at all familiar with parport, but I would
>> think that restore_state context would not care.
>
>Sounds good to me. As long as the state is restored before submitting
>further requests we should be fine. That would even allow getting rid of
>write_parport_reg_nonblock() as you can restore the state using
>synchronous calls from the worker thread. Should simplify things quite a
>bit.

What about something like the below (probably buggy)? I avoided messing with
the completion in the work callback, like what prologue/epilogue does for all
other synchronous calls, because when releasing we sync the work anyway and we
need to account for scenarios where the work is scheduled but yet not running,
so it would not be the best fit. And this also makes the flush_work() always
wait for both writes, otherwise I was having the thread locklessly busy-wait
on a flag that was set until both write_parport_reg_nonblock() calls returned
before the flush such that all potential scheduled work was observed. Unless
I missed something, the cleanup is considerable.

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 5a5d2a95070e..8a9408b94cb0 100644
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
	__u8			shadowECR;     /* parallel port regs... */
	__u8			shadowDCR;
@@ -265,172 +254,6 @@ static void destroy_mos_parport(struct kref *kref)
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
-/*
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
 /*
  * This is the the common top part of all parallel port callback operations that
  * send synchronous messages to the device.  This implements convoluted locking
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
@@ -482,6 +309,28 @@ static inline void parport_epilogue(struct parport *pp)
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
+	if (mos_parport->serial->disconnected) {
+		mutex_unlock(&mos_parport->serial->disc_mutex);
+		return;
+	}
+
+	write_mos_reg(mos_parport->serial, dummy, MOS7720_DCR,
+		      mos_parport->shadowDCR);
+	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
+		      mos_parport->shadowECR);
+	kref_put(&mos_parport->ref_count, destroy_mos_parport);
+	mutex_unlock(&mos_parport->serial->disc_mutex);
+}
+
 static void parport_mos7715_write_data(struct parport *pp, unsigned char d)
 {
	struct mos7715_parport *mos_parport = pp->private_data;
@@ -639,12 +488,12 @@ static void parport_mos7715_restore_state(struct parport *pp,
		spin_unlock(&release_lock);
		return;
	}
+	kref_get(&mos_parport->ref_count);
	mos_parport->shadowDCR = s->u.pc.ctr;
	mos_parport->shadowECR = s->u.pc.ecr;
-	write_parport_reg_nonblock(mos_parport, MOS7720_DCR,
-				   mos_parport->shadowDCR);
-	write_parport_reg_nonblock(mos_parport, MOS7720_ECR,
-				   mos_parport->shadowECR);
+
+	/* defer synchronous writes outside of irq */
+	schedule_work(&mos_parport->work);
	spin_unlock(&release_lock);
 }

@@ -714,12 +563,9 @@ static int mos7715_parport_init(struct usb_serial *serial)

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
@@ -1869,8 +1715,6 @@ static void mos7720_release(struct usb_serial *serial)

	if (le16_to_cpu(serial->dev->descriptor.idProduct)
	    == MOSCHIP_DEVICE_ID_7715) {
-		struct urbtracker *urbtrack;
-		unsigned long flags;
		struct mos7715_parport *mos_parport =
			usb_get_serial_data(serial);

@@ -1888,16 +1732,8 @@ static void mos7720_release(struct usb_serial *serial)
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
+		/* if work is currently scheduled, wait for it to complete */
+		cancel_work_sync(&mos_parport->work);
		parport_del_port(mos_parport->pp);

		kref_put(&mos_parport->ref_count, destroy_mos_parport);
