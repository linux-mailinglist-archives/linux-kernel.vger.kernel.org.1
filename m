Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441352A254B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgKBHdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:33:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:33:33 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kZULK-0005yT-LE
        for linux-kernel@vger.kernel.org; Mon, 02 Nov 2020 07:33:30 +0000
Received: by mail-wr1-f70.google.com with SMTP id q15so6068679wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PafHRmsQ3BtIV/S1ORyTSL8jAxBpH/xuP8SDhm0jn0A=;
        b=o0W1bbPyfbBfnaCE6CQpZBpXf41+Ea5XbgS+jI38JlSCbSfkDGcYA+i7zXDXTvdCvb
         Deqv2Oi13r+JPv7Ar9/UJaX8j+72gfpnPtlPAL8CJfnTjUDWW/X6azsulJhFephe22zp
         vAHIHAcCkdrhwrFGzdi/iulX31lOPNTQO0hV05feJ0tBHWWJeeQZ2D+6tQhUm/AHbA1u
         yV0Ye+Zp8nj27ybiC2FYMr4Hdc7+5mXDBwZUnmdividLjgxUmjNR3WK9imBIcrs5BPbg
         ZSG1s10fRJPD6PMClHXO6NaRsifsF3w1BqrmvNAZ0Jku0KK4nfuxVnppVlWQpLW/ncxP
         xAwQ==
X-Gm-Message-State: AOAM533a9VFb9lkSEdVkk2EPIHKmZ5/aoWJGKpLEAhCBZel2rYdAen1g
        lthhP5/rPqtJ1YhIiQ28I79wVGObvZrAa+qxa9MTrIWs5RzJ0GnO1wU0CLHyBo0nGVDFNl3F/qw
        s1NwDXP7RDDmippHjaFTE3Ty7ZDcFBU4SqnLqO1nrOg==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr2172250wmh.41.1604302410308;
        Sun, 01 Nov 2020 23:33:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhqkX0PZ6X/jmrSv0iOxiDHC3jWVbIGmReXqzKGy18sX7WhZbOeTBgzfkFq52HzMmwWAfYHg==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr2172231wmh.41.1604302410071;
        Sun, 01 Nov 2020 23:33:30 -0800 (PST)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id 90sm2132912wrl.30.2020.11.01.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 23:33:29 -0800 (PST)
Date:   Mon, 2 Nov 2020 08:33:28 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201102073328.GA9930@xps-13-7390>
References: <20201101092614.GB3989@xps-13-7390>
 <20201031101740.GA1875@boqun-laptop.fareast.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031101740.GA1875@boqun-laptop.fareast.corp.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 06:17:40PM +0800, Boqun Feng wrote:
> Hi Andrea,
> 
> On Sun, Nov 01, 2020 at 10:26:14AM +0100, Andrea Righi wrote:
> > I'm getting the following lockdep splat (see below).
> > 
> > Apparently this warning starts to be reported after applying:
> > 
> >  e918188611f0 ("locking: More accurate annotations for read_lock()")
> > 
> > It looks like a false positive to me, but it made me think a bit and
> > IIUC there can be still a potential deadlock, even if the deadlock
> > scenario is a bit different than what lockdep is showing.
> > 
> > In the assumption that read-locks are recursive only in_interrupt()
> > context (as stated in e918188611f0), the following scenario can still
> > happen:
> > 
> >  CPU0                                     CPU1
> >  ----                                     ----
> >  read_lock(&trig->leddev_list_lock);
> >                                           write_lock(&trig->leddev_list_lock);
> >  <soft-irq>
> >  kbd_bh()
> >    -> read_lock(&trig->leddev_list_lock);
> > 
> >  *** DEADLOCK ***
> > 
> > The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> > would be blocked by the write-lock *waiter* on CPU1 => deadlock.
> > 
> 
> No, this is not a deadlock, as a write-lock waiter only blocks
> *non-recursive* readers, so since the read_lock() in kbd_bh() is called
> in soft-irq (which in_interrupt() returns true), so it's a recursive
> reader and won't get blocked by the write-lock waiter.

That's right, I was missing that in_interrupt() returns true also from
soft-irq context.

> 
> > In that case we could prevent this deadlock condition using a workqueue
> > to call kbd_propagate_led_state() instead of calling it directly from
> > kbd_bh() (even if lockdep would still report the false positive).
> > 
> 
> The deadlock senario reported by the following splat is:
> 
> 	
> 	CPU 0:				CPU 1:					CPU 2:
> 	-----				-----					-----
> 	led_trigger_event():
> 	  read_lock(&trig->leddev_list_lock);
> 					<work queue processing>
> 	  				ata_hsm_qs_complete():
> 					  spin_lock_irqsave(&host->lock);
> 					  					write_lock(&trig->leddev_list_lock);
> 					  ata_port_freeze():
> 					    ata_do_link_abort():
> 					      ata_qc_complete():
> 					        ledtrig_disk_activity():
> 						  led_trigger_blink_oneshot():
> 						    read_lock(&trig->leddev_list_lock);
> 						    // ^ not in in_interrupt() context, so could get blocked by CPU 2
> 	<interrupt>
> 	  ata_bmdma_interrupt():
> 	    spin_lock_irqsave(&host->lock);
> 	  
> , where CPU 0 is blocked by CPU 1 because of the spin_lock_irqsave() in
> ata_bmdma_interrupt() and CPU 1 is blocked by CPU 2 because of the
> read_lock() in led_trigger_blink_oneshot() and CPU 2 is blocked by CPU 0
> because of an arbitrary writer on &trig->leddev_list_lock.
> 
> So I don't think it's false positive, but I might miss something
> obvious, because I don't know what the code here actually does ;-)

With the CPU2 part it all makes sense now and lockdep was right. :)

At this point I think we could just schedule a separate work to do the
led trigger and avoid calling it with host->lock held and that should
prevent the deadlock. I'll send a patch to do that.

Thanks tons for you detailed explanation!

-Andrea
