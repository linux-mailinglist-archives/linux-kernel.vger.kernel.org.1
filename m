Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3A2CC67B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgLBTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgLBTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:21:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58211C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:21:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606936860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DS1dQUKu65T10k3uyvkh4mHjOIbiEK2Ml6h4HqtEr34=;
        b=c238xcBYaofdO6f/LclJtS1MUWKiLa6XUSTYKOz8AKlu7eGbDOyjt3RaHpOp1IR227wKm2
        rNR4d7bTPgBEAktB8jXPBjnEgJkaMgZ7f7AW0+SxRjNjVJj73fCLqQbMi7KySYf57lnNIX
        PSJIQTa9GhuqEB7jb7t9H/HT/DSJTzCYvWLN76HH90h0KHeupd6L7HZPGY9/doe3qBEx/3
        MHwMUt8s/nbFmy/r/j2Rud15XTpDT0xcFShN2vbQgYaYma2qJwcWh8aPQWZ5CYHHE26/fM
        WOZrqsBQgFdgLKGYV3nZEdf5al8UYWJhSCjOd3QVOWtnvmBslUDFaUT5I+Ffjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606936860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DS1dQUKu65T10k3uyvkh4mHjOIbiEK2Ml6h4HqtEr34=;
        b=m3uGKrDf7oAwrell0WyqCGJfGuKjK23M9lPE5ch10epJbPh60K2+MnDtZX5pnk9c38Cko3
        hJisUKvetI/KzDBA==
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
In-Reply-To: <20201202162723.GJ5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com> <20201201161224.GF5487@ziepe.ca> <20201201171420.GN1900232@localhost> <20201201173540.GH5487@ziepe.ca> <87mtywe2zu.fsf@nanos.tec.linutronix.de> <20201202162723.GJ5487@ziepe.ca>
Date:   Wed, 02 Dec 2020 20:21:00 +0100
Message-ID: <87a6uwdnfn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02 2020 at 12:27, Jason Gunthorpe wrote:
> On Wed, Dec 02, 2020 at 02:44:53PM +0100, Thomas Gleixner wrote:
>>  	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
>>  	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
>> -		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
>> +		queue_work(system_power_efficient_wq, &sync_work);
>
> As Miroslav noted, probably the right thing to do here is to reset the
> hrtimer and remove the sync_work? I think this code was to expedite an
> RTC sync when NTP fixes the clock on boot.

This has two purposes:

     1) Initiating the update on boot once ntp is synced.

     2) Reinitiating the sync after ntp lost sync and the work did not
        reschedule itself because it observed !ntp_synced().

In both cases it's highly unlikely that the write actually happens when
the work is queued because do_adjtimex() would have to be exactly around
the valid update window. So it will not write immediately. It will run
through at least one retry.

I don't think the timer should be canceled if the ntp_synced() state did
not change. Otherwise every do_adtimex() call will cancel/restart
it, which does not make sense. Lemme stare at it some more.

> IIRC this was made somewhat messy due to the dual path with rtclib and
> old cmos.

:)

> It would be very nice to kill the cmos path, things are better
> now.. But PPC still has a long way to go:
>
> arch/powerpc/platforms/52xx/efika.c:    .set_rtc_time           = rtas_set_rtc_time,
> arch/powerpc/platforms/8xx/mpc86xads_setup.c:   .set_rtc_time           = mpc8xx_set_rtc_time,
> arch/powerpc/platforms/8xx/tqm8xx_setup.c:      .set_rtc_time           = mpc8xx_set_rtc_time,
> arch/powerpc/platforms/cell/setup.c:    .set_rtc_time           = rtas_set_rtc_time,
> arch/powerpc/platforms/chrp/setup.c:            ppc_md.set_rtc_time     = rtas_set_rtc_time;
> arch/powerpc/platforms/chrp/setup.c:    .set_rtc_time           = chrp_set_rtc_time,
> arch/powerpc/platforms/maple/setup.c:   .set_rtc_time           = maple_set_rtc_time,
> arch/powerpc/platforms/powermac/setup.c:        .set_rtc_time           = pmac_set_rtc_time,
> arch/powerpc/platforms/pseries/setup.c: .set_rtc_time           = rtas_set_rtc_time,
>
> Also x86 needs a touch, it already has RTC lib, no idea why it also
> provides this old path too

Because nobody had the stomach and/or cycles to touch it :)

> I wonder if the cmos path could be killed off under the dead HW
> principle?

Unfortunately that code path is not that dead on x86. You need to fix
all the (ab)users first. :)

Thanks,

        tglx
