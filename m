Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B782E2A282F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgKBKZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:25:28 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550ADC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:25:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a200so10700321pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNNowZwaId4lL8bkjeaWp8YIiJoynfucYmjjJeQcb8Q=;
        b=fXPm417xFDtOYLRiwNZk9sZ6a1RCzEhyGcNuRuO1BDqFVCO92umeB8TT8u29DDiQvU
         WuQT+AinSRF0hupunZ3j8vMzxIQaKjI/vlJZzb5VWaonDDskx19BqlbsPeq57dITje1J
         f/p73BslS1cauJD5f8PJYOfmyWfTbzd/eWLJM21r5vekCPQxwq3eCYQI7RYJEVEVbEK1
         NIm3hbpveFqRQ16BHLAHKWl9dXUE23vaWObcxNxL+gUBOrupluUzFkIMULktPmcdDtdV
         xH/Zzxcy4uL7/hOFqCLV1MJFkBT4vgEGS857F8x11zaFJphmCSquBY5Dd/if4lFtGl9J
         MJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNNowZwaId4lL8bkjeaWp8YIiJoynfucYmjjJeQcb8Q=;
        b=conA3ZZpQq7QatQr7uGgfh8Bc8XEf74pOcKcaqQhRRQX4HKXzdxcH7a2FQscSbODxU
         0RPXOuqJ6Ju2R1Z+97xM92B86IzriyzE/m0Vy1DNr+nkDGtBIIb3F1tadXlJce1BDs+S
         dqfaceUxwyZuwrDP2aRL3rqaDR5RMbjX7NatBOINepsfT29/tBomrUTa+qqXQGfD1Kvc
         3CmqbjIXcdRO699qEyxVNgSfQwPGTVt9Eov/bSjTtvY1vF0AmSKv63BC6ALQ9nZqs/rS
         VwqQGEljZeZr59unuGqXxyatWoml2XeCJrWqyVrGipKTsVNa1YECvMGhrQFpHNdfkmaS
         jl9Q==
X-Gm-Message-State: AOAM530pxLOYReDAwhJbsPlMfZ0zIGg96luceTU4r+AlN4dxahyAU2gh
        IwDE0Y4jVxUegvzEFJX9My/QHYiHAk8F+dqMtb4=
X-Google-Smtp-Source: ABdhPJxSAwIxQWtSkJvpoTIO96eglrEfyyHAl92jaxnAwvp1LGGHLlDxHNOiCzqmmX2BGiJmX60A07NXztbjGVmWhU0=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr16441470pjs.181.1604312727932;
 Mon, 02 Nov 2020 02:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20201029100647.233361-1-coiby.xu@gmail.com> <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com> <20201029142911.p54mbwbfaeymrqy5@Rk>
 <20201029152719.GC4127@dell> <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
 <20201102083955.GE4127@dell>
In-Reply-To: <20201102083955.GE4127@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Nov 2020 12:26:17 +0200
Message-ID: <CAHp75VeWbhEbVg2HYaeU2trASJt1EKzJfUG1VRJpD0CL+onbrg@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary CONFIG_PM_SLEEP
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 10:39 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 29 Oct 2020, Andy Shevchenko wrote:
> > On Thu, Oct 29, 2020 at 5:27 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Thu, 29 Oct 2020, Coiby Xu wrote:
> > > > On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
> > > > > > SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> > > > >
> > > > > Have you compiled this with
> > > > >     % make W=1 ...
> > > > > ?
> > > > >
> > > >
> > > > Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
> > > > disabled. I'll run "make W=1 M=..." for each driver after adding
> > > > __maybe_unused in v2.
> > >
> > > No, thank you.  Just keep it as it is.
> > >
> > > The current code is space saving.
> >
> > Perhaps you need to go thru __maybe_unused handling.
> > There are pros and cons of each approach, but not above.
>
> Do you know that all compilers drop the section?

At least all that Linux kernel can be officially built with.

-- 
With Best Regards,
Andy Shevchenko
