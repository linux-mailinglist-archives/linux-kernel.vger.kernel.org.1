Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F422A26AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgKBJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:09:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39236 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBJJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:09:32 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kZVqD-0003Dv-8C
        for linux-kernel@vger.kernel.org; Mon, 02 Nov 2020 09:09:29 +0000
Received: by mail-wr1-f71.google.com with SMTP id t17so6187682wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 01:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQMKBcXp2eZ9AT0PGM2yxAWX5qPqVtcgTKTo8TS7k6U=;
        b=KlYTMt7fkDwAIGHU6kNO+Zffdv/BPscVdE04FFaWaYs19Hq6B5Y3A5x8klntG6zNFS
         llbZ/cL4Y7lWLAbaxzdWDLL/Myu9s85uAzN0HB87nam0hhmo6OGqiZ08jzPR0QpKAoL9
         Jb7TIgnvZsQTwQ8Th371W4YdPbK6zAJpMMiUfnTdWCLesNCYJoBEBqY5IC1QwZ5BwThs
         MS1k64otWlU8Ovelns9/D2t14aI5pHmYEiA2cNUYnTNWUrnfLsLOvytGo052zKWHnmhn
         G0WHlAjgRSfv8XO8SFnZDGD7KzLkA/1P3fCTp9uXzN75Xp3sdoajBObmUFCjTwLhBHPA
         6R5g==
X-Gm-Message-State: AOAM533nnIEmfzB2l7UV3yX4d3LcnSngUEU188G6GqaHz9aI0skM+tXe
        EKgOuS7am5po8rhDcnv6L421yF0EZg3D2wF98WcPE2czq1FDW4FwvujT4tA6aMDpEp1oBiRnzQx
        BvUY+A5KTskt4fyUhqpFixPh7JDgHLraHeTn4NNaRcQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr16992830wmd.147.1604308168909;
        Mon, 02 Nov 2020 01:09:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+xtOFQaw7ajhnbyWjEXQUwCztboqe2+/S9rajf5CJ8nYEbk1Er6Lz9P8P16bcQ3RR+6RMnA==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr16992806wmd.147.1604308168618;
        Mon, 02 Nov 2020 01:09:28 -0800 (PST)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id r10sm5171413wmg.16.2020.11.02.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:09:28 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:09:27 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201102090927.GC9930@xps-13-7390>
References: <20201101092614.GB3989@xps-13-7390>
 <20201031101740.GA1875@boqun-laptop.fareast.corp.microsoft.com>
 <20201102073328.GA9930@xps-13-7390>
 <20201102085658.GA5506@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102085658.GA5506@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:56:58AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > I'm getting the following lockdep splat (see below).
> > > > 
> > > > Apparently this warning starts to be reported after applying:
> > > > 
> > > >  e918188611f0 ("locking: More accurate annotations for read_lock()")
> > > > 
> > > > It looks like a false positive to me, but it made me think a bit and
> > > > IIUC there can be still a potential deadlock, even if the deadlock
> > > > scenario is a bit different than what lockdep is showing.
> > > > 
> > > > In the assumption that read-locks are recursive only in_interrupt()
> > > > context (as stated in e918188611f0), the following scenario can still
> > > > happen:
> > > > 
> > > >  CPU0                                     CPU1
> > > >  ----                                     ----
> > > >  read_lock(&trig->leddev_list_lock);
> > > >                                           write_lock(&trig->leddev_list_lock);
> > > >  <soft-irq>
> > > >  kbd_bh()
> > > >    -> read_lock(&trig->leddev_list_lock);
> > > > 
> > > >  *** DEADLOCK ***
> > > > 
> > > > The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> > > > would be blocked by the write-lock *waiter* on CPU1 => deadlock.
> > > > 
> > > 
> > > No, this is not a deadlock, as a write-lock waiter only blocks
> > > *non-recursive* readers, so since the read_lock() in kbd_bh() is called
> > > in soft-irq (which in_interrupt() returns true), so it's a recursive
> > > reader and won't get blocked by the write-lock waiter.
> > 
> > That's right, I was missing that in_interrupt() returns true also from
> > soft-irq context.
> > 
> > > > In that case we could prevent this deadlock condition using a workqueue
> > > > to call kbd_propagate_led_state() instead of calling it directly from
> > > > kbd_bh() (even if lockdep would still report the false positive).
> > > > 
> > > 
> > > The deadlock senario reported by the following splat is:
> > > 
> > > 	
> > > 	CPU 0:				CPU 1:					CPU 2:
> > > 	-----				-----					-----
> > > 	led_trigger_event():
> > > 	  read_lock(&trig->leddev_list_lock);
> > > 					<work queue processing>
> > > 	  				ata_hsm_qs_complete():
> > > 					  spin_lock_irqsave(&host->lock);
> > > 					  					write_lock(&trig->leddev_list_lock);
> > > 					  ata_port_freeze():
> > > 					    ata_do_link_abort():
> > > 					      ata_qc_complete():
> > > 					        ledtrig_disk_activity():
> > > 						  led_trigger_blink_oneshot():
> > > 						    read_lock(&trig->leddev_list_lock);
> > > 						    // ^ not in in_interrupt() context, so could get blocked by CPU 2
> > > 	<interrupt>
> > > 	  ata_bmdma_interrupt():
> > > 	    spin_lock_irqsave(&host->lock);
> > > 	  
> > > , where CPU 0 is blocked by CPU 1 because of the spin_lock_irqsave() in
> > > ata_bmdma_interrupt() and CPU 1 is blocked by CPU 2 because of the
> > > read_lock() in led_trigger_blink_oneshot() and CPU 2 is blocked by CPU 0
> > > because of an arbitrary writer on &trig->leddev_list_lock.
> > > 
> > > So I don't think it's false positive, but I might miss something
> > > obvious, because I don't know what the code here actually does ;-)
> > 
> > With the CPU2 part it all makes sense now and lockdep was right. :)
> > 
> > At this point I think we could just schedule a separate work to do the
> > led trigger and avoid calling it with host->lock held and that should
> > prevent the deadlock. I'll send a patch to do that.
> 
> Let's... not do that, unless we have no choice.
> 
> Would it help if leddev_list_lock used _irqsave() locking?

Using read_lock_irqsave/irqrestore() in led_trigger_event() would be
enough to prevent the deadlock. If it's an acceptable solution I can
send a patch (already tested it and lockdep doesn't complain :)).

Thanks,
-Andrea
