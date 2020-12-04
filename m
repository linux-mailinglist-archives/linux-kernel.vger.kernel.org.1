Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF52CE84E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgLDGsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:48:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgLDGsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:48:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8C58AB63;
        Fri,  4 Dec 2020 06:47:55 +0000 (UTC)
Date:   Thu, 3 Dec 2020 22:22:57 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
Message-ID: <20201204062257.GA13304@linux-p48b.lan>
References: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
 <20180227143934.2aa847ac@vento.lan>
 <20180308095739.okdn7ghvlpy4oiy5@linutronix.de>
 <20180416140103.33s2xarrxxeecttk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180416140103.33s2xarrxxeecttk@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Sebastian Andrzej Siewior wrote:

>On 2018-03-08 10:57:39 [+0100], To Mauro Carvalho Chehab wrote:
>> On 2018-02-27 14:39:34 [-0300], Mauro Carvalho Chehab wrote:
>> > Hi Sebastian,
>> Hi Mauro,
>>
>> > Sorry for taking some time to test it, has been busy those days...
>> :)
>>
>> > Anyway, I tested it today. Didn't work. It keep losing data.
>>
>> Okay, this was unexpected. What I learned from the thread is that you
>> use the dwc2 controller and once upgrade to a kernel which completes the
>> URBs in BH context then you starting losing data from your DVB-s USB
>> device. And it was assumed that this is because BH/ksoftirq is getting
>> "paused" if it is running for too long. If that is the case then a
>> revert of "let us complete the URB in BH context" should get it working
>> again. Is that so?
>
>ping

I ran into this while looking at getting rid of tasklets in drivers/usb.

Mauro, were you ever able to try reverting 8add17cf8e4 like Sebastian suggested?
If not would you mind trying the below, please? Considering this thread is from
over two years ago, it's a rebase of Sebastian's patch to complete urbs in process
context + the dwc2 changes not to use defer urb into bh.

Thanks,
Davidlohr

----8<---------------------------------------------------------------------------
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 60886a7464c3..4952a8fc1719 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1665,33 +1665,76 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
	usb_put_urb(urb);
 }

-static void usb_giveback_urb_bh(struct tasklet_struct *t)
+static void usb_hcd_rh_gb_urb(struct work_struct *work)
 {
-	struct giveback_urb_bh *bh = from_tasklet(bh, t, bh);
-	struct list_head local_list;
+	struct giveback_urb *bh;
+	struct list_head urb_list;
+
+	bh = container_of(work, struct giveback_urb, rh_compl);

	spin_lock_irq(&bh->lock);
-	bh->running = true;
- restart:
-	list_replace_init(&bh->head, &local_list);
+	list_replace_init(&bh->rh_head, &urb_list);
	spin_unlock_irq(&bh->lock);

-	while (!list_empty(&local_list)) {
+	while (!list_empty(&urb_list)) {
		struct urb *urb;

-		urb = list_entry(local_list.next, struct urb, urb_list);
+		urb = list_first_entry(&urb_list, struct urb, urb_list);
		list_del_init(&urb->urb_list);
-		bh->completing_ep = urb->ep;
		__usb_hcd_giveback_urb(urb);
-		bh->completing_ep = NULL;
+	}
+}
+
+#define URB_PRIO_HIGH	0
+#define URB_PRIO_LOW	1
+
+static irqreturn_t usb_hcd_gb_urb(int irq, void *__hcd)
+{
+	struct usb_hcd *hcd = __hcd;
+	struct giveback_urb *bh = &hcd->gb_urb;
+	struct list_head urb_list[2];
+	int i;
+
+	INIT_LIST_HEAD(&urb_list[URB_PRIO_HIGH]);
+	INIT_LIST_HEAD(&urb_list[URB_PRIO_LOW]);
+
+	spin_lock_irq(&bh->lock);
+ restart:
+	list_splice_tail_init(&bh->prio_hi_head, &urb_list[URB_PRIO_HIGH]);
+	list_splice_tail_init(&bh->prio_lo_head, &urb_list[URB_PRIO_LOW]);
+	spin_unlock_irq(&bh->lock);
+
+	for (i = 0; i < ARRAY_SIZE(urb_list); i++) {
+		while (!list_empty(&urb_list[i])) {
+			struct urb *urb;
+
+			urb = list_first_entry(&urb_list[i],
+					       struct urb, urb_list);
+			list_del_init(&urb->urb_list);
+			if (i == URB_PRIO_HIGH)
+				bh->completing_ep = urb->ep;
+
+			__usb_hcd_giveback_urb(urb);
+
+			if (i == URB_PRIO_HIGH)
+				bh->completing_ep = NULL;
+
+			if (i == URB_PRIO_LOW &&
+			    !list_empty_careful(&urb_list[URB_PRIO_HIGH])) {
+				spin_lock_irq(&bh->lock);
+				goto restart;
+			}
+		}
	}

	/* check if there are new URBs to giveback */
	spin_lock_irq(&bh->lock);
-	if (!list_empty(&bh->head))
+	if (!list_empty(&bh->prio_hi_head) ||
+	    !list_empty(&bh->prio_lo_head))
		goto restart;
-	bh->running = false;
	spin_unlock_irq(&bh->lock);
+
+	return IRQ_HANDLED;
 }

 /**
@@ -1717,37 +1760,34 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
  */
 void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 {
-	struct giveback_urb_bh *bh;
-	bool running, high_prio_bh;
+	struct giveback_urb	*bh = &hcd->gb_urb;
+	struct list_head	*lh;

	/* pass status to tasklet via unlinked */
	if (likely(!urb->unlinked))
		urb->unlinked = status;

-	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
-		__usb_hcd_giveback_urb(urb);
+	if (is_root_hub(urb->dev)) {
+		spin_lock(&bh->lock);
+		list_add_tail(&urb->urb_list, &bh->rh_head);
+		spin_unlock(&bh->lock);
+		queue_work(system_highpri_wq, &bh->rh_compl);
		return;
	}

-	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)) {
-		bh = &hcd->high_prio_bh;
-		high_prio_bh = true;
-	} else {
-		bh = &hcd->low_prio_bh;
-		high_prio_bh = false;
+	if (!hcd_giveback_urb_in_bh(hcd)) {
+		__usb_hcd_giveback_urb(urb);
+		return;
	}

+	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe))
+		lh = &bh->prio_hi_head;
+	else
+		lh = &bh->prio_lo_head;
+
	spin_lock(&bh->lock);
-	list_add_tail(&urb->urb_list, &bh->head);
-	running = bh->running;
+	list_add_tail(&urb->urb_list, lh);
	spin_unlock(&bh->lock);
-
-	if (running)
-		;
-	else if (high_prio_bh)
-		tasklet_hi_schedule(&bh->bh);
-	else
-		tasklet_schedule(&bh->bh);
 }
 EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);

@@ -2334,8 +2374,17 @@ irqreturn_t usb_hcd_irq (int irq, void *__hcd)
		rc = IRQ_NONE;
	else if (hcd->driver->irq(hcd) == IRQ_NONE)
		rc = IRQ_NONE;
-	else
-		rc = IRQ_HANDLED;
+	else {
+		struct giveback_urb	*bh = &hcd->gb_urb;
+
+		spin_lock(&bh->lock);
+		if (!list_empty(&bh->prio_hi_head) ||
+		    !list_empty(&bh->prio_lo_head))
+			rc = IRQ_WAKE_THREAD;
+		else
+			rc = IRQ_HANDLED;
+		spin_unlock(&bh->lock);
+	}

	return rc;
 }
@@ -2410,12 +2459,12 @@ EXPORT_SYMBOL_GPL (usb_hc_died);

 /*-------------------------------------------------------------------------*/

-static void init_giveback_urb_bh(struct giveback_urb_bh *bh)
+static void init_giveback_urb(struct giveback_urb *bh)
 {
-
-	spin_lock_init(&bh->lock);
-	INIT_LIST_HEAD(&bh->head);
-	tasklet_setup(&bh->bh, usb_giveback_urb_bh);
+	INIT_LIST_HEAD(&bh->prio_lo_head);
+	INIT_LIST_HEAD(&bh->prio_hi_head);
+	INIT_LIST_HEAD(&bh->rh_head);
+	INIT_WORK(&bh->rh_compl, usb_hcd_rh_gb_urb);
 }

 struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
@@ -2593,8 +2642,9 @@ static int usb_hcd_request_irqs(struct usb_hcd *hcd,

		snprintf(hcd->irq_descr, sizeof(hcd->irq_descr), "%s:usb%d",
				hcd->driver->description, hcd->self.busnum);
-		retval = request_irq(irqnum, &usb_hcd_irq, irqflags,
-				hcd->irq_descr, hcd);
+		retval = request_threaded_irq(irqnum, &usb_hcd_irq,
+					      usb_hcd_gb_urb, irqflags,
+					      hcd->irq_descr, hcd);
		if (retval != 0) {
			dev_err(hcd->self.controller,
					"request interrupt %d failed\n",
@@ -2783,9 +2833,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
			&& device_can_wakeup(&hcd->self.root_hub->dev))
		dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");

-	/* initialize tasklets */
-	init_giveback_urb_bh(&hcd->high_prio_bh);
-	init_giveback_urb_bh(&hcd->low_prio_bh);
+	init_giveback_urb(&hcd->gb_urb);

	/* enable irqs just before we start the controller,
	 * if the BIOS provides legacy PCI irqs.
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index e9ac215b9663..fa6a0e7eb899 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4162,7 +4162,9 @@ void dwc2_host_complete(struct dwc2_hsotg *hsotg, struct dwc2_qtd *qtd,
	kfree(qtd->urb);
	qtd->urb = NULL;

+	spin_unlock(&hsotg->lock);
	usb_hcd_giveback_urb(dwc2_hsotg_to_hcd(hsotg), urb, status);
+	spin_lock(&hsotg->lock);
 }

 /*
@@ -4902,7 +4904,7 @@ static struct hc_driver dwc2_hc_driver = {
	.hcd_priv_size = sizeof(struct wrapper_priv_data),

	.irq = _dwc2_hcd_irq,
-	.flags = HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags = HCD_MEMORY | HCD_USB2,

	.start = _dwc2_hcd_start,
	.stop = _dwc2_hcd_stop,
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 96281cd50ff6..15a55aaa0e9c 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -64,11 +64,12 @@

 /*-------------------------------------------------------------------------*/

-struct giveback_urb_bh {
-	bool running;
+struct giveback_urb {
	spinlock_t lock;
-	struct list_head  head;
-	struct tasklet_struct bh;
+	struct list_head	prio_lo_head;
+	struct list_head	prio_hi_head;
+	struct list_head	rh_head;
+	struct work_struct	rh_compl;
	struct usb_host_endpoint *completing_ep;
 };

@@ -179,8 +180,7 @@ struct usb_hcd {
	resource_size_t		rsrc_len;	/* memory/io resource length */
	unsigned		power_budget;	/* in mA, 0 = no limit */

-	struct giveback_urb_bh  high_prio_bh;
-	struct giveback_urb_bh  low_prio_bh;
+	struct giveback_urb     gb_urb;

	/* bandwidth_mutex should be taken before adding or removing
	 * any new bus bandwidth constraints:
@@ -420,7 +420,7 @@ static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
 static inline bool hcd_periodic_completion_in_progress(struct usb_hcd *hcd,
		struct usb_host_endpoint *ep)
 {
-	return hcd->high_prio_bh.completing_ep == ep;
+	return hcd->gb_urb.completing_ep == ep;
 }

 static inline bool hcd_uses_dma(struct usb_hcd *hcd)
