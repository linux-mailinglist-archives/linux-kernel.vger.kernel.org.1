Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCEA2B17FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKMJOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:14:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46564 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKMJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:14:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so9785491ljg.13;
        Fri, 13 Nov 2020 01:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i2w2/Ou2JCNs3YSFT/BVsQjj58MQc88VDrIE6nWMPHU=;
        b=QePoGAnPV2XQBFg1uyppSdAnFgxJfGHChMVj/oHITpb0PJqbBitftZLQ9mQx6Yl9Wq
         QGt3wRzE1gl0BFZpKWUyinwUpvPeo7CtNA975Yd8Vdda5x5YvmYoo8JWvqNPZt2uHt/i
         601g5ePL6z99kPYm0OsyY6iHdZywt6WHCTjvJY8EB58Vh7bvvz9zIZEgeOWcv+AicvcQ
         9B/Xpra2RmFonoS20JpTz0BNY6h25ByTMqwGaaLzxsYDTPovJ0jM9Na7ZPmjGmYmtHmD
         jSW+gFwT9k96cEU0pzkZM5cgv110AUwUgyaqWa4gjYKptgF4SmD5rX5cr675UBCOloD8
         Oh2Q==
X-Gm-Message-State: AOAM532XQw7y4YNCRx71fErIL763qLKtE5xl6Ag8ZmHq18Y9Iue+I4v4
        RTO3FMrE53ARiSxicoa/X5SsXX3IL08=
X-Google-Smtp-Source: ABdhPJxQbU7VoYBwntk0kSvfxWbBydYgtlhNduOMrHgB7MnYYJNGHkdIAI8VIlIlp3VKA1//wyDzyw==
X-Received: by 2002:a2e:300a:: with SMTP id w10mr732722ljw.62.1605258876349;
        Fri, 13 Nov 2020 01:14:36 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f1sm1569086ljp.65.2020.11.13.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 01:14:35 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kdVAJ-0001DN-LM; Fri, 13 Nov 2020 10:14:43 +0100
Date:   Fri, 13 Nov 2020 10:14:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201113091443.GI4085@localhost>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
 <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the late reply.

On Thu, Nov 05, 2020 at 10:17:13PM -0800, Davidlohr Bueso wrote:
> On Thu, 05 Nov 2020, Johan Hovold wrote:
> >On Wed, Nov 04, 2020 at 04:13:07PM -0800, Davidlohr Bueso wrote:
> >> Also, but not strictly related to this. What do you think of deferring all
> >> work in write_parport_reg_nonblock() unconditionally? I'd like to avoid
> >> that mutex_trylock() because eventually I'll be re-adding a warn in the
> >> locking code, but that would also simplify the code done here in the
> >> nonblocking irq write. I'm not at all familiar with parport, but I would
> >> think that restore_state context would not care.
> >
> >Sounds good to me. As long as the state is restored before submitting
> >further requests we should be fine. That would even allow getting rid of
> >write_parport_reg_nonblock() as you can restore the state using
> >synchronous calls from the worker thread. Should simplify things quite a
> >bit.
> 
> What about something like the below (probably buggy)? I avoided messing with
> the completion in the work callback, like what prologue/epilogue does for all
> other synchronous calls, because when releasing we sync the work anyway and we
> need to account for scenarios where the work is scheduled but yet not running,
> so it would not be the best fit. And this also makes the flush_work() always
> wait for both writes, otherwise I was having the thread locklessly busy-wait
> on a flag that was set until both write_parport_reg_nonblock() calls returned
> before the flush such that all potential scheduled work was observed. Unless
> I missed something, the cleanup is considerable.

Yeah, I wouldn't bother with the completion, looks broken anyway as
nothing prevent two parport calls from interfering with each other it
seems.

[...]

>  /*
>   * This is the the common top part of all parallel port callback operations that
>   * send synchronous messages to the device.  This implements convoluted locking
> @@ -458,6 +281,10 @@ static int parport_prologue(struct parport *pp)
> 	reinit_completion(&mos_parport->syncmsg_compl);
> 	spin_unlock(&release_lock);
> 
> +	/* ensure writes from restore are submitted before new requests */
> +	if (work_pending(&mos_parport->work))
> +		flush_work(&mos_parport->work);
> +
> 	mutex_lock(&mos_parport->serial->disc_mutex);
> 	if (mos_parport->serial->disconnected) {
> 		/* device disconnected */
> @@ -482,6 +309,28 @@ static inline void parport_epilogue(struct parport *pp)
> 	complete(&mos_parport->syncmsg_compl);
>  }
> 
> +static void deferred_restore_writes(struct work_struct *work)
> +{
> +	struct mos7715_parport *mos_parport;
> +
> +	mos_parport = container_of(work, struct mos7715_parport, work);
> +
> +	mutex_lock(&mos_parport->serial->disc_mutex);
> +
> +	/* if device disconnected, game over */
> +	if (mos_parport->serial->disconnected) {
> +		mutex_unlock(&mos_parport->serial->disc_mutex);
> +		return;
> +	}
> +
> +	write_mos_reg(mos_parport->serial, dummy, MOS7720_DCR,
> +		      mos_parport->shadowDCR);
> +	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
> +		      mos_parport->shadowECR);
> +	kref_put(&mos_parport->ref_count, destroy_mos_parport);
> +	mutex_unlock(&mos_parport->serial->disc_mutex);
> +}
> +
>  static void parport_mos7715_write_data(struct parport *pp, unsigned char d)
>  {
> 	struct mos7715_parport *mos_parport = pp->private_data;
> @@ -639,12 +488,12 @@ static void parport_mos7715_restore_state(struct parport *pp,
> 		spin_unlock(&release_lock);
> 		return;
> 	}
> +	kref_get(&mos_parport->ref_count);

I think can do away with the reference count too as you flush the work
before dropping the final reference in release().

> 	mos_parport->shadowDCR = s->u.pc.ctr;
> 	mos_parport->shadowECR = s->u.pc.ecr;
> -	write_parport_reg_nonblock(mos_parport, MOS7720_DCR,
> -				   mos_parport->shadowDCR);
> -	write_parport_reg_nonblock(mos_parport, MOS7720_ECR,
> -				   mos_parport->shadowECR);
> +
> +	/* defer synchronous writes outside of irq */
> +	schedule_work(&mos_parport->work);
> 	spin_unlock(&release_lock);
>  }
> 
> @@ -714,12 +563,9 @@ static int mos7715_parport_init(struct usb_serial *serial)
> 
> 	mos_parport->msg_pending = false;
> 	kref_init(&mos_parport->ref_count);
> -	spin_lock_init(&mos_parport->listlock);
> -	INIT_LIST_HEAD(&mos_parport->active_urbs);
> -	INIT_LIST_HEAD(&mos_parport->deferred_urbs);
> 	usb_set_serial_data(serial, mos_parport); /* hijack private pointer */
> 	mos_parport->serial = serial;
> -	tasklet_setup(&mos_parport->urb_tasklet, send_deferred_urbs);
> +	INIT_WORK(&mos_parport->work, deferred_restore_writes);
> 	init_completion(&mos_parport->syncmsg_compl);
> 
> 	/* cycle parallel port reset bit */
> @@ -1869,8 +1715,6 @@ static void mos7720_release(struct usb_serial *serial)
> 
> 	if (le16_to_cpu(serial->dev->descriptor.idProduct)
> 	    == MOSCHIP_DEVICE_ID_7715) {
> -		struct urbtracker *urbtrack;
> -		unsigned long flags;
> 		struct mos7715_parport *mos_parport =
> 			usb_get_serial_data(serial);
> 
> @@ -1888,16 +1732,8 @@ static void mos7720_release(struct usb_serial *serial)
> 		usb_set_serial_data(serial, NULL);
> 		mos_parport->serial = NULL;
> 
> -		/* if tasklet currently scheduled, wait for it to complete */
> -		tasklet_kill(&mos_parport->urb_tasklet);
> -
> -		/* unlink any urbs sent by the tasklet  */
> -		spin_lock_irqsave(&mos_parport->listlock, flags);
> -		list_for_each_entry(urbtrack,
> -				    &mos_parport->active_urbs,
> -				    urblist_entry)
> -			usb_unlink_urb(urbtrack->urb);
> -		spin_unlock_irqrestore(&mos_parport->listlock, flags);
> +		/* if work is currently scheduled, wait for it to complete */
> +		cancel_work_sync(&mos_parport->work);

But this must be done before clearing mos_parport->serial above or you
can hit a NULL deref in the worker. Cancel, or flush as Oliver
suggested, after deregistering the port.

> 		parport_del_port(mos_parport->pp);
> 
> 		kref_put(&mos_parport->ref_count, destroy_mos_parport);

Very nice to see this cleaned up.

Johan
