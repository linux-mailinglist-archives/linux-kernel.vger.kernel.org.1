Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2332A908C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKFHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:40:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37025 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKFHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:40:36 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kawML-0001wJ-A1
        for linux-kernel@vger.kernel.org; Fri, 06 Nov 2020 07:40:33 +0000
Received: by mail-wr1-f70.google.com with SMTP id v5so160734wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jrhr5yRQnyadQWkzdbR4ykR1Uwe+WNfv5BZIIbHimF4=;
        b=Td7Zvifu7ELBkQrRgm/hLnB7WCVKUwcD8plocRbLVF693ZlVrA9mo6gK1PpmrMse+3
         clGkyPt89GCsqj7Qx0HAQCdqMQ1DBlLllC2tycyh8GtCwsU8AylN+gUfOH1My2CwzAyZ
         r4w7HFLpPU7hNVWq6b9BNLilYshbmwhBQgZ4e0o7vuUVyX/+prF508g8usu7xJij/+/s
         NOrbWWKsGazIRfOTnKSffOm5P4XeWb4yMpNT2wYyBC8mTlWJi84ijRiCBjfa60Hd4124
         KzfwzgZ5wEK2gwS8p7tHguqCnE7i/Rx3imBE8unQnBgQ0X9QcDokszHKiZkk65pp7K/q
         OH5A==
X-Gm-Message-State: AOAM531Znf7JEPL/sKJt5+MdTY14zGNRnVr3dvkhoYvT/ac6Qfr9Xd7N
        +lCXOygvl4u3niVrqUj04jlZadMGH7O6JmNchNQ0QIlZwPehzagDZQXp67akdT57vu20am+Qf1i
        dId1ExeQk5uT8OkslZqb0BH/svu2r4k+1BaXMdIJKRw==
X-Received: by 2002:a05:6000:1249:: with SMTP id j9mr1108931wrx.218.1604648432778;
        Thu, 05 Nov 2020 23:40:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGoDem6P6wG417cQBINFKFKBadNGOUjnkpzIHC7/oG7bKqccFFvM+0Ov/7tkrXLPp+0mnm+w==
X-Received: by 2002:a05:6000:1249:: with SMTP id j9mr1108911wrx.218.1604648432496;
        Thu, 05 Nov 2020 23:40:32 -0800 (PST)
Received: from localhost (host-87-3-180-232.retail.telecomitalia.it. [87.3.180.232])
        by smtp.gmail.com with ESMTPSA id n14sm750005wrt.8.2020.11.05.23.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:40:31 -0800 (PST)
Date:   Fri, 6 Nov 2020 08:40:30 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201106074030.GG1041241@xps-13-7390>
References: <20201101092614.GB3989@xps-13-7390>
 <20201031101740.GA1875@boqun-laptop.fareast.corp.microsoft.com>
 <20201102073328.GA9930@xps-13-7390>
 <20201102085658.GA5506@amd>
 <20201102090927.GC9930@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102090927.GC9930@xps-13-7390>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:09:28AM +0100, Andrea Righi wrote:
> On Mon, Nov 02, 2020 at 09:56:58AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > > I'm getting the following lockdep splat (see below).
> > > > > 
> > > > > Apparently this warning starts to be reported after applying:
> > > > > 
> > > > >  e918188611f0 ("locking: More accurate annotations for read_lock()")
> > > > > 
> > > > > It looks like a false positive to me, but it made me think a bit and
> > > > > IIUC there can be still a potential deadlock, even if the deadlock
> > > > > scenario is a bit different than what lockdep is showing.
> > > > > 
> > > > > In the assumption that read-locks are recursive only in_interrupt()
> > > > > context (as stated in e918188611f0), the following scenario can still
> > > > > happen:
> > > > > 
> > > > >  CPU0                                     CPU1
> > > > >  ----                                     ----
> > > > >  read_lock(&trig->leddev_list_lock);
> > > > >                                           write_lock(&trig->leddev_list_lock);
> > > > >  <soft-irq>
> > > > >  kbd_bh()
> > > > >    -> read_lock(&trig->leddev_list_lock);
> > > > > 
> > > > >  *** DEADLOCK ***
> > > > > 
> > > > > The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> > > > > would be blocked by the write-lock *waiter* on CPU1 => deadlock.
> > > > > 
> > > > 
> > > > No, this is not a deadlock, as a write-lock waiter only blocks
> > > > *non-recursive* readers, so since the read_lock() in kbd_bh() is called
> > > > in soft-irq (which in_interrupt() returns true), so it's a recursive
> > > > reader and won't get blocked by the write-lock waiter.
> > > 
> > > That's right, I was missing that in_interrupt() returns true also from
> > > soft-irq context.
> > > 
> > > > > In that case we could prevent this deadlock condition using a workqueue
> > > > > to call kbd_propagate_led_state() instead of calling it directly from
> > > > > kbd_bh() (even if lockdep would still report the false positive).
> > > > > 
> > > > 
> > > > The deadlock senario reported by the following splat is:
> > > > 
> > > > 	
> > > > 	CPU 0:				CPU 1:					CPU 2:
> > > > 	-----				-----					-----
> > > > 	led_trigger_event():
> > > > 	  read_lock(&trig->leddev_list_lock);
> > > > 					<work queue processing>
> > > > 	  				ata_hsm_qs_complete():
> > > > 					  spin_lock_irqsave(&host->lock);
> > > > 					  					write_lock(&trig->leddev_list_lock);
> > > > 					  ata_port_freeze():
> > > > 					    ata_do_link_abort():
> > > > 					      ata_qc_complete():
> > > > 					        ledtrig_disk_activity():
> > > > 						  led_trigger_blink_oneshot():
> > > > 						    read_lock(&trig->leddev_list_lock);
> > > > 						    // ^ not in in_interrupt() context, so could get blocked by CPU 2
> > > > 	<interrupt>
> > > > 	  ata_bmdma_interrupt():
> > > > 	    spin_lock_irqsave(&host->lock);
> > > > 	  
> > > > , where CPU 0 is blocked by CPU 1 because of the spin_lock_irqsave() in
> > > > ata_bmdma_interrupt() and CPU 1 is blocked by CPU 2 because of the
> > > > read_lock() in led_trigger_blink_oneshot() and CPU 2 is blocked by CPU 0
> > > > because of an arbitrary writer on &trig->leddev_list_lock.
> > > > 
> > > > So I don't think it's false positive, but I might miss something
> > > > obvious, because I don't know what the code here actually does ;-)
> > > 
> > > With the CPU2 part it all makes sense now and lockdep was right. :)
> > > 
> > > At this point I think we could just schedule a separate work to do the
> > > led trigger and avoid calling it with host->lock held and that should
> > > prevent the deadlock. I'll send a patch to do that.
> > 
> > Let's... not do that, unless we have no choice.
> > 
> > Would it help if leddev_list_lock used _irqsave() locking?
> 
> Using read_lock_irqsave/irqrestore() in led_trigger_event() would be
> enough to prevent the deadlock. If it's an acceptable solution I can
> send a patch (already tested it and lockdep doesn't complain :)).

Any comment on
https://lore.kernel.org/lkml/20201102104152.GG9930@xps-13-7390/?

Thanks,
-Andrea
