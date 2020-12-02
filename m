Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A992CC861
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgLBUzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgLBUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:55:01 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3B6C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:54:20 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so2113779qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJ26q0n10bl+7oiAlsJxQE/h29ZkG7NqJxeeT+DRUvg=;
        b=d3Ero40D15RLJlIIy6qIO+xEB3IrtJb9QhUFwMJG3mpVZsiPbQAVqBnr+YgeoWLGZ7
         aFjjB1mjdP76e4ahLe85Orspkqyfy5R2OZSogrqj5LPIMBHytOQN0KeVFDAPl3gh2CE2
         gZxvRf8epSA5wFwfbLaxG+nMZ6J3AaLbq7mHbcx0gWbway39qJsr3ndJiFykUk3keKf7
         5wdme6rhMyXyfk7sajyOxAyHfSm/suyigiQRTf1sRb1e7ZJqXaJ9tUBlEGkVFh4oNV1Y
         bYuyPe9azu91sfPWQH6FWQ7Klsrj6R7E2/TDyZl2n27MDQAmJtP/3v9cHDAL+lwzc1RZ
         Hj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJ26q0n10bl+7oiAlsJxQE/h29ZkG7NqJxeeT+DRUvg=;
        b=gIDvvFyq/27XV0YinYo94dXpywEKGc5xoo4ZeLoWALaE69MlY6vKH4lkTpJyVuE6ue
         vBwNmqDI20dLAEo3150whRAJ1Rqb6OM/RiGP/GlwC+FEpTOi8/cprdhxirITrZqeEQtw
         FzU2r1a6LCUSpaTmu/7Z3Pq/9KTC0zi1bKit01loJUFKs67+qBObO/9ZbxR5mEPKqiP8
         RhGbbfjXunR43MuQdKIDrXmlp+tz1oha0EXfL7FnMfln+grBrDSSbR+mij/GKgW5uuTg
         nx0cz3IkZUdBLNoUATj2W2iIJkOg16ylAy3fQkTAV9LsEgj6Mi9OE9ULMIwDd0wJqAK+
         botQ==
X-Gm-Message-State: AOAM533lrZsHvy0RNeTZLTzMAeZ1vrpcle2ONxtXUpjqDLNe/nISRlCY
        hEQePFNNLRZpcvBaapVY8X/oGA==
X-Google-Smtp-Source: ABdhPJwWPrIlE8G+pEcFlsPtdh9GPf202UtddfGPSQ819+PVbQlQHTf5Puz/SUv5YDUzO9xTnmh26Q==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr4537800qte.385.1606942460006;
        Wed, 02 Dec 2020 12:54:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u15sm2791457qkj.122.2020.12.02.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:54:19 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkZ8k-005Chy-RC; Wed, 02 Dec 2020 16:54:18 -0400
Date:   Wed, 2 Dec 2020 16:54:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201202205418.GN5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
 <20201202162723.GJ5487@ziepe.ca>
 <87a6uwdnfn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6uwdnfn.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:21:00PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 02 2020 at 12:27, Jason Gunthorpe wrote:
> > On Wed, Dec 02, 2020 at 02:44:53PM +0100, Thomas Gleixner wrote:
> >>  	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
> >>  	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
> >> -		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
> >> +		queue_work(system_power_efficient_wq, &sync_work);
> >
> > As Miroslav noted, probably the right thing to do here is to reset the
> > hrtimer and remove the sync_work? I think this code was to expedite an
> > RTC sync when NTP fixes the clock on boot.
> 
> This has two purposes:
> 
>      1) Initiating the update on boot once ntp is synced.
> 
>      2) Reinitiating the sync after ntp lost sync and the work did not
>         reschedule itself because it observed !ntp_synced().
> 
> In both cases it's highly unlikely that the write actually happens when
> the work is queued because do_adjtimex() would have to be exactly around
> the valid update window.

Yes

> So it will not write immediately. It will run through at least one
> retry.

Right, bascially this is scheduling a WQ to do sched_sync_hw_clock()
which will only call hrtimer_start() - seems like jsut calling
hrtimer_start instead of queue_work above would be equivilant

> I don't think the timer should be canceled if the ntp_synced() state did
> not change. Otherwise every do_adtimex() call will cancel/restart
> it, which does not make sense. Lemme stare at it some more.

That makes sense, being conditional on the STA_UNSYNC prior to doing
any hrtimer_start seems OK?
 
> > Also x86 needs a touch, it already has RTC lib, no idea why it also
> > provides this old path too
> 
> Because nobody had the stomach and/or cycles to touch it :)

Hahaha yes.. I vaugely remember looking at this once..

Lets see:

arch/x86/kernel/kvmclock.c:     x86_platform.set_wallclock = kvm_set_wallclock;
arch/x86/kernel/x86_init.c:             x86_platform.set_wallclock = set_rtc_noop;
arch/x86/xen/time.c:            x86_platform.set_wallclock = xen_set_wallclock;
arch/x86/xen/time.c:    x86_platform.set_wallclock = xen_set_wallclock;
  All returns -ENODEV/EINVAL

arch/x86/kernel/x86_init.c:     .set_wallclock                  = mach_set_rtc_mmss,
  This is already rtclib under drivers/rtc/rtc-mc146818-lib.c
 
  I suppose the issue here is the rtclib driver only binds via PNP and
  very old x86 systems won't have the PNP tables? It seems doable to
  check for a PNP device after late init and manually create a
  platform_device for the RTC

arch/x86/platform/intel-mid/intel_mid_vrtc.c:   x86_platform.set_wallclock = vrtc_set_mmss;
  This is also already in rtclib under rtc-mrst.c, and this is already
  wired to create the rtc platform device during init

So it is very close now to be able to delete all this for x86. Do you
know of something I've missed?

> > I wonder if the cmos path could be killed off under the dead HW
> > principle?
> 
> Unfortunately that code path is not that dead on x86. You need to fix
> all the (ab)users first. :)

Assuming x86 can be resolved as above, that leaves two 20 year old MIPS
platforms and the PPC list from before. ARM is gone compared to last
time I looked! Progress :)

Thanks,
Jason
