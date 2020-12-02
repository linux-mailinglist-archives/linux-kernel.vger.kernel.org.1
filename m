Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0A2CC244
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgLBQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLBQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:28:06 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E12C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:27:26 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ec16so967632qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3gltbreYKBIlS9Ge6wtx4Q+7SD7PPTvbQ5ovSIMTdMI=;
        b=YmswynVF9QX1jI3frNpvbk0X8O2AsyxMdsE4qsO9M4vwORfQyjicPjb+1ytiDNESio
         BIDUcqJAmYutyyN2jhIAU0ag6k+uVSocaNZEdAWG1uV5Tc46MyS5tH6iW3q2AHoZ1wzn
         g/gj4kDTTu7YqvPze+sIJyB3kWruJ1vNZPa7pcFlkLSKhy3RT9j4eN2Q0mDGFFREDSVN
         FoKFpsaIjjPy8ElMjV0HZYJExhkEBvmLfKNJbZ68jyM0Ou4YIuvm3wkE4g8sXWpL68ip
         Ai8VV0hDHD41YeONdRkWvkMi5xpvzJuLPpzIvoGRc93Zv5f+zqpkEcCflWt3gBqgWYRA
         NLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gltbreYKBIlS9Ge6wtx4Q+7SD7PPTvbQ5ovSIMTdMI=;
        b=hnlDj+Rl0zth+rveH5bnWpirmKK41Erp/I9cvQr6pTQkG4uctB3wMoCBb6cARt+1i5
         esaG/lvQCDp3482I5NrjLLLSvolI4rcZqer/MZclwVP0/cw+UjGnO9MM1i1h0bj8AF2V
         hXxKBTWo2vEVfD/b4Qc7KNjwdimRpUq08Fu/qU75HG7YYpJ8DZEXmiPQHdCceUe5AOX5
         tKIXDgpCA0XrNm6yZBWycgthyT+HotMNGcLqCZJPABSWIt81f42pGQgXazyrMOZExROy
         qVuBig/Wtqm/v4umazog2ca+anMWCGqtbO5jeY4rv9qRWXUfzv6rPcUo39erGRT3iEBk
         HZ7g==
X-Gm-Message-State: AOAM531po+9bOY8KsXx7bpPramqzij2KN519uAV9Q2eq4MsUTf6QpnJO
        lhQ8g/NesybX9vDdON0Mw3sagg==
X-Google-Smtp-Source: ABdhPJwLFH6taaoXGbOdkGN845TC5mEF4Mollvx/oit6SqLICdAba5TXS4mPtvkNNJuK+aPYB/N17Q==
X-Received: by 2002:a0c:b508:: with SMTP id d8mr3598269qve.8.1606926445581;
        Wed, 02 Dec 2020 08:27:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 14sm2232201qkk.128.2020.12.02.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:27:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkUyR-0056gQ-US; Wed, 02 Dec 2020 12:27:23 -0400
Date:   Wed, 2 Dec 2020 12:27:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201202162723.GJ5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtywe2zu.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 02:44:53PM +0100, Thomas Gleixner wrote:

> So if this ends up in level #1 then again the chance is pretty low that
> the expiry time is aligned to the the level period. If this works then
> it only works by chance.

Yes, I always thought it was timer wheel related, but at least in my
testing long ago it seemed reliable at the short timeout. Maybe I had
a lucky hz value.
 
> > This seems like a more fundamental problem someplace else in the
> > kernel.
> 
> I don't think so. :)
> 
> Something like the completely untested below should make this reliable
> and only needs to retry when the work is running late (busy machine),
> but the wakeup will be on time or at max 1 jiffie off when high
> resolution timers are not available or disabled.

This seems like the right approach

> @@ -629,7 +618,7 @@ void ntp_notify_cmos_timer(void)
>  
>  	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
>  	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
> -		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
> +		queue_work(system_power_efficient_wq, &sync_work);

As Miroslav noted, probably the right thing to do here is to reset the
hrtimer and remove the sync_work? I think this code was to expedite an
RTC sync when NTP fixes the clock on boot.

IIRC this was made somewhat messy due to the dual path with rtclib and
old cmos.

It would be very nice to kill the cmos path, things are better
now.. But PPC still has a long way to go:

arch/powerpc/platforms/52xx/efika.c:    .set_rtc_time           = rtas_set_rtc_time,
arch/powerpc/platforms/8xx/mpc86xads_setup.c:   .set_rtc_time           = mpc8xx_set_rtc_time,
arch/powerpc/platforms/8xx/tqm8xx_setup.c:      .set_rtc_time           = mpc8xx_set_rtc_time,
arch/powerpc/platforms/cell/setup.c:    .set_rtc_time           = rtas_set_rtc_time,
arch/powerpc/platforms/chrp/setup.c:            ppc_md.set_rtc_time     = rtas_set_rtc_time;
arch/powerpc/platforms/chrp/setup.c:    .set_rtc_time           = chrp_set_rtc_time,
arch/powerpc/platforms/maple/setup.c:   .set_rtc_time           = maple_set_rtc_time,
arch/powerpc/platforms/powermac/setup.c:        .set_rtc_time           = pmac_set_rtc_time,
arch/powerpc/platforms/pseries/setup.c: .set_rtc_time           = rtas_set_rtc_time,

Also x86 needs a touch, it already has RTC lib, no idea why it also
provides this old path too

I wonder if the cmos path could be killed off under the dead HW
principle?

Jason
