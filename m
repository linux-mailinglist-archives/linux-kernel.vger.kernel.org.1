Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5575F2CC95A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLBWJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLBWJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:09:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B56C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:08:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606946919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9vsGnXZHSsqnozJcVzbytQfXTloykF6F8eHtLCSwhB4=;
        b=N2nrecLWoE/4c1n3QkQUY+uzlVEomufm+LavWwaNKkbpaOOVAEg+QIcxQ8E1y9gNzJ3B/G
        DX1n/LLpbu91reYT9cRbCRb8A+FtvSyHRDv1DDfbxJ/72fCruVNAch7RBxY7ytCD6nOgzx
        6YPcMdNEwz5R2omhBmbmGMIXIl2FqHtz/FP4TvfoS70ay1bccztu3zXepPa509PTBoica6
        dFH9jVkwRQTvOB/yfYb3apK9h2rPJiUCYTSbgN3JreEBdL9jTDGYxrWDIw/VUSJr5SttqR
        sbVbayBIdnDstBZnHUITmKAQerLUHqkshdH8FJn/QmyDOf6MnBrucKwhAfY4qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606946919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9vsGnXZHSsqnozJcVzbytQfXTloykF6F8eHtLCSwhB4=;
        b=VNza5/Vh42evsqqLunpxL9319CgLvqs8XzgHg9do7RPvOkBZoosd/aHgLh3xcYPgtGMoN2
        SGvQa7W/RDoP3rDw==
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
In-Reply-To: <20201202205418.GN5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com> <20201201161224.GF5487@ziepe.ca> <20201201171420.GN1900232@localhost> <20201201173540.GH5487@ziepe.ca> <87mtywe2zu.fsf@nanos.tec.linutronix.de> <20201202162723.GJ5487@ziepe.ca> <87a6uwdnfn.fsf@nanos.tec.linutronix.de> <20201202205418.GN5487@ziepe.ca>
Date:   Wed, 02 Dec 2020 23:08:38 +0100
Message-ID: <874kl3eu8p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02 2020 at 16:54, Jason Gunthorpe wrote:
> On Wed, Dec 02, 2020 at 08:21:00PM +0100, Thomas Gleixner wrote:
>> So it will not write immediately. It will run through at least one
>> retry.
>
> Right, bascially this is scheduling a WQ to do sched_sync_hw_clock()
> which will only call hrtimer_start() - seems like jsut calling
> hrtimer_start instead of queue_work above would be equivilant

Something like that.

>> I don't think the timer should be canceled if the ntp_synced() state did
>> not change. Otherwise every do_adtimex() call will cancel/restart
>> it, which does not make sense. Lemme stare at it some more.
>
> That makes sense, being conditional on the STA_UNSYNC prior to doing
> any hrtimer_start seems OK?

Yeah.
  
>> > Also x86 needs a touch, it already has RTC lib, no idea why it also
>> > provides this old path too
>> 
>> Because nobody had the stomach and/or cycles to touch it :)
>
> Hahaha yes.. I vaugely remember looking at this once..
>
> Lets see:
>
> arch/x86/kernel/kvmclock.c:     x86_platform.set_wallclock = kvm_set_wallclock;
> arch/x86/kernel/x86_init.c:             x86_platform.set_wallclock = set_rtc_noop;
> arch/x86/xen/time.c:            x86_platform.set_wallclock = xen_set_wallclock;
> arch/x86/xen/time.c:    x86_platform.set_wallclock = xen_set_wallclock;
>   All returns -ENODEV/EINVAL

You forgot to stare at the .get_wallclock() functions. That's the more
interesting part, i.e. what's behind read_persistent_clock64().

> arch/x86/kernel/x86_init.c:     .set_wallclock                  = mach_set_rtc_mmss,
>   This is already rtclib under drivers/rtc/rtc-mc146818-lib.c

That's the shared library function for setting the darn thing.
  
>   I suppose the issue here is the rtclib driver only binds via PNP and
>   very old x86 systems won't have the PNP tables? It seems doable to
>   check for a PNP device after late init and manually create a
>   platform_device for the RTC

old crap, broken BIOSes and virt. Welcome to my wonderful world :)

> arch/x86/platform/intel-mid/intel_mid_vrtc.c:   x86_platform.set_wallclock = vrtc_set_mmss;
>   This is also already in rtclib under rtc-mrst.c, and this is already
>   wired to create the rtc platform device during init
>
> So it is very close now to be able to delete all this for x86. Do you
> know of something I've missed?

Just the above :)

>> > I wonder if the cmos path could be killed off under the dead HW
>> > principle?
>> 
>> Unfortunately that code path is not that dead on x86. You need to fix
>> all the (ab)users first. :)
>
> Assuming x86 can be resolved as above, that leaves two 20 year old MIPS
> platforms and the PPC list from before. ARM is gone compared to last
> time I looked! Progress :)

Yeah. We're zooming in ....

Thanks,

        tglx
