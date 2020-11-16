Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F82B4C31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbgKPRJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:09:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42260 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgKPRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:09:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so26120996lfd.9;
        Mon, 16 Nov 2020 09:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SE0OPagdf6KijD+ImF7Q3nAg2ysSbSjYwts5q8UUaGE=;
        b=dIWerr/lD8YSzI1Y9lRQvNHsPL0G8ifpvv8LVdU8du5oQ3Sy1mDTL4HIgxniu83XWM
         J7kowXIJznATAzvnST3gcgZYfGX/+kQ4opv+o8OMKSkl8NG8FDdFisHD0JlS0q+9AHEf
         yZP+XgnaX1ARP6L/+dcOqibXv6nHhOUzItxRmklVMvs5+E34xuPJc6h0bjRUmgrLAqtW
         E1WemfGyvM+ppSFzsl7zKsr+H/EfBXdQqvE+1+jRTzexPzKutoVn8AOC+3YgnDa/CmCY
         XM7dazc4oOj6ZynBnEUeH9QmiqKlVFExfMG5fNGGNaYJp1Z4+LD7wCh7cg7Bxmy6YKFq
         aGyQ==
X-Gm-Message-State: AOAM533KByipAEoDcyPhNsJaWIzMS2yZpSU65ocKU6IJxabOjBGbFyf5
        r5Laph08AG0p1kSryCIXYc2gOXd3HW+k+Q==
X-Google-Smtp-Source: ABdhPJzlonyyGNw39tvDMZsOp/wIClapTdRq2hUGtIKoXFit0H5q5l/4utQ79aJ2zOyNXkLdCpPK4Q==
X-Received: by 2002:ac2:5441:: with SMTP id d1mr150671lfn.120.1605546556608;
        Mon, 16 Nov 2020 09:09:16 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i5sm2808004lfl.53.2020.11.16.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:09:15 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kei0E-0007zz-AL; Mon, 16 Nov 2020 18:09:19 +0100
Date:   Mon, 16 Nov 2020 18:09:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] USB: serial: mos7720: defer state restore to a workqueue
Message-ID: <X7KyPrY8FDH4C/gm@localhost>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
 <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
 <20201113091443.GI4085@localhost>
 <20201114042725.ofs7zbzmxg32tbbi@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114042725.ofs7zbzmxg32tbbi@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 08:27:25PM -0800, Davidlohr Bueso wrote:
> The parallel port restore operation currently defers writes
> to a tasklet, if it sees a locked disconnect mutex. The
> driver goes to a lot of trouble to ensure writes happen
> in a non-blocking context, but things can be greatly
> simplified if it's done in regular process context and
> this is not a system performance critical path. As such,
> instead of doing the async state restore writes in irq
> context, use a workqueue and just do regular synchronous
> writes.
> 
> In addition to the cleanup, this also imposes less on the
> overall system as tasklets have been deprecated because
> of it's BH implications, potentially blocking a higher
> priority task from running. We also get rid of hacks
> such as trylocking a mutex in irq, something which does
> not play nice with priority boosting in PREEMPT_RT.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

> -/*
> - * This is the the common top part of all parallel port callback operations that
> + * This is the common top part of all parallel port callback operations that
>   * send synchronous messages to the device.  This implements convoluted locking
>   * that avoids two scenarios: (1) a port operation is called after usbserial
>   * has called our release function, at which point struct mos7715_parport has

This is an unrelated change, but ok.

> @@ -641,10 +488,9 @@ static void parport_mos7715_restore_state(struct parport *pp,
> 	}
> 	mos_parport->shadowDCR = s->u.pc.ctr;
> 	mos_parport->shadowECR = s->u.pc.ecr;
> -	write_parport_reg_nonblock(mos_parport, MOS7720_DCR,
> -				   mos_parport->shadowDCR);
> -	write_parport_reg_nonblock(mos_parport, MOS7720_ECR,
> -				   mos_parport->shadowECR);
> +
> +	/* defer synchronous writes outside of irq */

This one isn't called in interrupt context, but with interrupts
disabled and a spin lock held.

> +	schedule_work(&mos_parport->work);
> 	spin_unlock(&release_lock);
>  }

> @@ -1869,8 +1712,6 @@ static void mos7720_release(struct usb_serial *serial)
> 
> 	if (le16_to_cpu(serial->dev->descriptor.idProduct)
> 	    == MOSCHIP_DEVICE_ID_7715) {
> -		struct urbtracker *urbtrack;
> -		unsigned long flags;
> 		struct mos7715_parport *mos_parport =
> 			usb_get_serial_data(serial);
> 
> @@ -1883,21 +1724,17 @@ static void mos7720_release(struct usb_serial *serial)
> 		if (mos_parport->msg_pending)
> 			wait_for_completion_timeout(&mos_parport->syncmsg_compl,
> 					    msecs_to_jiffies(MOS_WDR_TIMEOUT));
> +		/*
> +		 * If delayed work is currently scheduled, wait for it to
> +		 * complete. This also implies barriers that ensure the
> +		 * below serial clearing is not hoisted above the ->work.
> +		 */
> +		cancel_work_sync(&mos_parport->work);

As I mentioned, this needs to be done *after* deregistering the port or
you could theoretically end up with the work item being requeued.

Yes, the same applies for the "synchronous" requests, but that's a
preexisting issue.

> 		parport_remove_port(mos_parport->pp);
> 		usb_set_serial_data(serial, NULL);
> 		mos_parport->serial = NULL;

Johan
