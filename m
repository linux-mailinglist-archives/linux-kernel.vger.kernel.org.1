Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EB274DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIWAjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgIWAjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:39:43 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9776C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:39:42 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n7so4737099vkq.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8C1mlEJMqwWptPrIyFJT+dpSuLKuAMNUHxa+me7hPw=;
        b=CmoOMqwpb8rDpx9s1EjCYGLAtKTnWnMdGUdS+jco/xwO4ZPBcMKbCV/8dwLWZyBVgU
         7uI0/GVpgpI/LbW13HgXLMHljX8kDL1YIO+hKzzvKRgasAjl75o9YN+aSJbTN5nbVMxn
         J2Cijewfe7WC/mwuSPoLQwxqsUT7SK8Da6Waw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8C1mlEJMqwWptPrIyFJT+dpSuLKuAMNUHxa+me7hPw=;
        b=B3456ReCsmcQwT0CuuzJRY8QOzIukRWkKCH5HaR/VihvUd4kspjo3i2r1lkSR5PGPi
         NnpRRP4RnSLDUYtpPnkk+fzX5fyoovfmU/kBvi9o77Hihf0x30bPUzn/+4cuxKNuy62v
         9sm1q5j58UEIfOkYI5j3SF1+TbuK+nnoqSB6yJ8LTguYJi89LAHf3gV3LFjRFMEqyF8O
         uRyGKMVIj75N6NoqCGj20Yl85va+yMRKluuaLu4CXUrF91Kn7uIdDEzb80W+pO4SaVZj
         DHSQ8R4wLYlilYm1MOer60yxJsH6OAdIjY2mnJ1PUgFV3r/Sr9PzNvdoO3rNA+8VQhd5
         iHSg==
X-Gm-Message-State: AOAM532wtbf9YHAdZAXiHwVXnUYM0NNr5S4I7h//ue+yaliNq3Ruaxkl
        Der+VOsguzxay2dce6i2ICKWzdS0CaVWZg==
X-Google-Smtp-Source: ABdhPJxzvbrtfAk3cBpko67T6auK+l6PBLMB44f5dfaCKm+4TH8B1QhSbcKlfSpi0jQqyOPJC0jJHw==
X-Received: by 2002:a1f:1f46:: with SMTP id f67mr5467105vkf.6.1600821581422;
        Tue, 22 Sep 2020 17:39:41 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id v16sm2095715uam.5.2020.09.22.17.39.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 17:39:40 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id h15so6088728uab.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 17:39:39 -0700 (PDT)
X-Received: by 2002:ab0:4542:: with SMTP id r60mr5032191uar.90.1600821578898;
 Tue, 22 Sep 2020 17:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
 <ad9108e155ba4245a2005e9212a7d2b5@AcuMS.aculab.com> <CAMj1kXEF9SHnas_Hy=eU+=hHuuyxMb2_UtPtsuU2CCH6BaUPbg@mail.gmail.com>
In-Reply-To: <CAMj1kXEF9SHnas_Hy=eU+=hHuuyxMb2_UtPtsuU2CCH6BaUPbg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Sep 2020 17:39:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VG-BzzEJ2jn6hAYjre+BtOu-uyi4OQst=Lg9QQqAtKNw@mail.gmail.com>
Message-ID: <CAD=FV=VG-BzzEJ2jn6hAYjre+BtOu-uyi4OQst=Lg9QQqAtKNw@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the fastest
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jackie Liu <liuyun01@kylinos.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 22, 2020 at 3:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 22 Sep 2020 at 10:26, David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Douglas Anderson
> > > Sent: 22 September 2020 01:26
> > >
> > > On every boot time we see messages like this:
> > >
> > > [    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
> > > [    0.025363] xor: measuring software checksum speed
> > > [    0.035351]    8regs     :  3952.000 MB/sec
> > > [    0.045384]    32regs    :  4860.000 MB/sec
> > > [    0.055418]    arm64_neon:  5900.000 MB/sec
> > > [    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
> > > [    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs
> > >
> > > As you can see, we spend 30 ms on every boot re-confirming that, yet
> > > again, the arm64_neon implementation is the fastest way to do XOR.
> > > ...and the above is on a system with HZ=1000.  Due to the way the
> > > testing happens, if we have HZ defined to something slower it'll take
> > > much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
> > > a fact that will be the same for every bootup.
> >
> > Can't the code use a TSC (or similar high-res counter) to
> > see how long it takes to process a short 'hot cache' block?
> > That wouldn't take long at all.
> >
>
> This is generic code that runs from an core_initcall() so I am not
> sure we can easily implement this in a portable way.

If it ran later, presumably you could just use ktime?  That seems like
it'd be a portable enough way?


> Doug: would it help if we deferred this until late_initcall()? We
> could take an arbitrary pick from the list at core_initcall() time to
> serve early users, and update to the fastest one at a later time.

Yeah, I think that'd work OK.  One advantage of it being later would
be that it could run in parallel to other things that were happening
in the system (anyone who enabled async probe on their driver).  Even
better would be if your code itself could run async and not block the
rest of boot.  ;-)  I do like the idea that we could just arbitrarily
pick one implementation until we've calibrated.  I guess we'd want to
figure out how to do this lockless but it shouldn't be too hard to
just check to see if a single pointer is non-NULL and once it becomes
non-NULL then you can use it...  ...or a pointer plus a sentinel if
writing the pointer can't be done atomically...

It also feels like with the large number of big.LITTLE systems out
there you'd either want a lookup table per core or you'd want to do
calibration per core.

-Doug
