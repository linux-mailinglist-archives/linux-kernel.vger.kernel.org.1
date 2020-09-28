Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C8427B5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgI1Tu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgI1Tu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:50:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9248EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:50:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so2092774pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqGk7vDyMCAYS8I0sgrwIKxqUFOoutHt+GIsW8/pgQc=;
        b=DqDoWsT06mOCMfIx6LctUTHasONJ7on/4G6nmmzsxGhrlqdoj3LaatYg4kcZmhdPGB
         hSUbmWlK9gRdKLfGy9LIor3kAeQjbQo6ZZRACf7OrHSvjKG+M1TT4gSRNg7lVJUwl5CL
         dYiWoZjxH36IntLebqXhNCliD1Kd0jP+VJBoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqGk7vDyMCAYS8I0sgrwIKxqUFOoutHt+GIsW8/pgQc=;
        b=ido93POw8JGMVI5MMBEZ1dHVmAWD6/JvOlh6riQrl7fF/zCi+j9d0Uzkwb42xIiVWt
         CVxD1IA5+6NxpZHAl16HwmHNpwxw7dXlGIyQzMmlI0sSBELxavK6ZJov+SmuOtozIilb
         JTcUkqMfUbVXhirqV/M82jItkavPDGqZQXBmQFI9Lx4OiHsP6SmuQ6OZa5BfCRDNvInN
         1KicixLfGwCIMkouxB2clCo+kIipQJQLMCJiRoyrCH7lxWY18TneSAMAqO2Sa+ZjzWbV
         ssUB3qLklr0D+IDlmksZg9f6WTtYcXPLbwG1/7NDJ8qx4a7GMUktt5RoL6Pr4pP1f0Yi
         ctiA==
X-Gm-Message-State: AOAM533I2OO/2FdGFhTu67k5R24sIaPOIExym/LkVu/ht5yRdVOr+iz7
        aA4sLpTvVKuXgLW6nwvrSNAU0w==
X-Google-Smtp-Source: ABdhPJzFoE1z3csOguwYxTy5MCxiW4q9PSri9tP2w2oD+oE/SdmrU1HJhQYA+xffFi8Douas2i3D2A==
X-Received: by 2002:a63:e504:: with SMTP id r4mr498143pgh.431.1601322627926;
        Mon, 28 Sep 2020 12:50:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x4sm2569463pfm.86.2020.09.28.12.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:50:27 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:50:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, matt@codeblueprint.co.uk,
        nico@linaro.org, Thomas Garnier <thgarnie@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: KASLR support on ARM with Kernel 4.9 and 4.14
Message-ID: <202009281248.6F601005CA@keescook>
References: <CAOuPNLjtG_VHL1M8-=pKNNRmWQg_8oC0YG7C8H3gQcbJ+0B3=A@mail.gmail.com>
 <202009251301.A1FD183582@keescook>
 <CAMj1kXGtv84JHQfKoqOYyq=3m2w0Yuj_n4_Teo83zvdZ9kpZhw@mail.gmail.com>
 <202009251338.D17FB071@keescook>
 <CAMj1kXEWutwE-fP9bc=tsyPoTuV6J7bLzLpkZ213P9y9JszkTw@mail.gmail.com>
 <202009251647.FD8CECD4@keescook>
 <CAOuPNLif93a1uHhqsKFwhd35nfCnmRu_uxpB62shOEKyQ96hNw@mail.gmail.com>
 <202009260933.C603CD8@keescook>
 <CAOuPNLiM+ghH_7eNkAfA=jDgHrc+2_jB_n3FvYG-JMN0EiNfGA@mail.gmail.com>
 <CAOuPNLiw1FyzHq2DykRFwgG0BeaWaNymiV8_DmD=ump7P8W_ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLiw1FyzHq2DykRFwgG0BeaWaNymiV8_DmD=ump7P8W_ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 07:41:13PM +0530, Pintu Agarwal wrote:
> On Mon, 28 Sep 2020 at 19:15, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Sat, 26 Sep 2020 at 22:10, Kees Cook <keescook@chromium.org> wrote:
> >
> > > > >> I wonder if this is an Android Common kernel?
> > > > It uses the below kernel for 4.14:
> > > > https://gitlab.com/quicla/kernel/msm-4.14/-/tree/LE.UM.3.4.2.r1.5  (or
> > > > similar branch).
> > >
> > > Okay, so yes. And this appears to have the hashing of %p backported. I
> > > cannot, however, explain why it's showing hashed pointers instead of
> > > just NULL, though.
> > >
> > > It might be related to these commits but they're not in that kernel:
> > > 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
> > > 7bd57fbc4a4d ("vsprintf: don't obfuscate NULL and error pointers")
> > >
> > > > ==> The case where symbol addresses are changing.
> > > >
> > > > kptr_restrict is set to 2 by default:
> > > > / # cat /proc/sys/kernel/kptr_restrict
> > > > 2
> > > >
> > > > Basically, the goal is:
> > > > * To understand how addresses are changing in 4.14 Kernel (without
> > > > KASLR support)?
> > > > * Is it possible to support the same in 4.9 Kernel ?
> > >
> > > Try setting kptr_restrict to 0 and see if the symbol addresses change? I
> > > suspect Ard is correct: there's no KASLR here, just hashed pointers
> > > behaving weird on an old non-stock kernel. :)
> > >
> >
> > Okay. Thank you so much for your comments and suggestions.
> > You mean to say, setting kptr_restrict to 0 may avoid changing symbol
> > addresses in 4.14 ?
> > And, sorry, I could not understand the thing about this "hashed pointers".
> > How can I check this behavior in source code to understand better?
> > Is it possible to give some reference ?
> > I wanted to disable this hash pointer on 4.14 kernel and check the behavior.
> > Also if possible, we would like to make this similar change on 4.9
> > kernel as well.
> >
> 
> Okay, I found these changes in 4.14 kernel:
> https://gitlab.com/quicla/kernel/msm-4.14/-/commit/e63732dbfe017aa0dbabac9d096b5fde8afbd395

That's an out-of-tree patch. The one that was backported to 4.14 from
4.15 that does %p hashing is this one:
https://gitlab.com/quicla/kernel/msm-4.14/-/commit/ad67b74d2469d9b82aaa572d76474c95bc484d57

> Are we talking about this?
> I cound not find this in 4.9 kernel.

Note that I still can't explain what you're seeing. /proc/kallsyms
shouldn't be affected by these patches -- I would expect it to either
report the true value or 00s.

> I will disable kptr_restrict and check or, I will enable
> CONFIG_DEBUG_CONSOLE_UNHASHED_POINTERS and check.

I would start with kptr_restrict=0 and see if that changes the contents
of /proc/kallsyms. If it does, then it is the hashing. If it doesn't,
well, we're back to square one. :)

-- 
Kees Cook
