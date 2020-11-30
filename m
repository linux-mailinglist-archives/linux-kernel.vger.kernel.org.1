Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582442C825D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgK3KlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgK3KlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:41:14 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C3B20708
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606732833;
        bh=39vInkTGAE+LkQ+SzCA3sJF1Tx8QEsgRu2TPOQXivk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KDWJW6fVU2McFKth3y88857GlJZ7ZrU0jb62vc4SeU5k7VPZlCVrO5fxhcdC2Y1qa
         tIbX3iYwnb2IQaKKcYKOt3F6akJYewP5wmge3M0e3Td4RnuKy4fZ+uNKOqoyXvx9Tx
         PUEiBMHfYGQ54gxSHGRJ/+wZ6ieeJYP5KeTo963c=
Received: by mail-oo1-f43.google.com with SMTP id i13so2558670oou.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:40:32 -0800 (PST)
X-Gm-Message-State: AOAM530kAB5tmAtZnhabk+85sFiI/wEMbN1wM/2gpDfzFBVbRuEx3XLi
        oCgKSE/0Vg89ZPvlT0UsNH9irxGMdf83W0/yIaw=
X-Google-Smtp-Source: ABdhPJyWBdAYDLcFa1CrlhJ1v0MNuli5TP5kCCX277R/RrjNVoKM9mIZWeye1kofjevJwGZ0ulkLBBBcGD18ay6+zOc=
X-Received: by 2002:a4a:45c3:: with SMTP id y186mr14718768ooa.13.1606732832043;
 Mon, 30 Nov 2020 02:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com> <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
 <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com> <20201130102122.GT1551@shell.armlinux.org.uk>
In-Reply-To: <20201130102122.GT1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Nov 2020 11:40:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHuERnB01sNrpY9w3C0ECOry7jCK=A2H0D4-_cBXbOmcw@mail.gmail.com>
Message-ID: <CAMj1kXHuERnB01sNrpY9w3C0ECOry7jCK=A2H0D4-_cBXbOmcw@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Antony Yu <swpenim@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 11:21, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Nov 30, 2020 at 11:12:33AM +0100, Ard Biesheuvel wrote:
> > (+ Nico)
> >
> > On Mon, 30 Nov 2020 at 11:11, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 23 Nov 2020 at 08:39, Antony Yu <swpenim@gmail.com> wrote:
> > > >
> > > > __do_div64 clobbers the input register r0 in little endian system.
> > > > According to the inline assembly document, if an input operand is
> > > > modified, it should be tied to a output operand. This patch can
> > > > prevent compilers from reusing r0 register after asm statements.
> > > >
> > > > Signed-off-by: Antony Yu <swpenim@gmail.com>
> > > > ---
> > > >  arch/arm/include/asm/div64.h | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> > > > index 898e9c78a7e7..809efc51e90f 100644
> > > > --- a/arch/arm/include/asm/div64.h
> > > > +++ b/arch/arm/include/asm/div64.h
> > > > @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> > > >         asm(    __asmeq("%0", __xh)
> > > >                 __asmeq("%1", "r2")
> > > >                 __asmeq("%2", "r0")
> > > > -               __asmeq("%3", "r4")
> > > > +               __asmeq("%3", "r0")
> > > > +               __asmeq("%4", "r4")
> > > >                 "bl     __do_div64"
> > > > -               : "=r" (__rem), "=r" (__res)
> > > > +               : "=r" (__rem), "=r" (__res), "=r" (__n)
> > > >                 : "r" (__n), "r" (__base)
> > > >                 : "ip", "lr", "cc");
> > > >         *n = __res;
> > > > --
> > > > 2.23.0
> > > >
> > >
> > > Agree that using r0 as an input operand only is incorrect, and not
> > > only on Clang. The compiler might assume that r0 will retain its value
> > > across the asm() block, which is obviously not the case.
>
> However, you can _not_ have an asm block that names two outputs using
> the same physical register - that's why both the original patch and
> the posted v2 will fail.
>
> You also can't mark r0 as clobbered because it's used as an operand
> and that is not allowed by gcc.
>
> The fact is, we have two register variables occupying the same register,
> which are __n and __rem. It doesn't matter which endian-ness __rem is,
> r0 will be used for both __n (input) and __rem (output).
>

__rem is a 32-bit variable, so in LE mode, only r1 is used for __rem,
not r0. So r0/r1 are used as an input operand pair, and r1 is used as
an output operand.

So I don't think the compiler has to be buggy in order for it to
assume that r0 will still contain the low word of the dividend
afterwards.

And actually, the same applies on BE, but the other way around. So we
should mark __xl as an output register as well, as __xl will assume
the right value depending on the endianness.

I suggest something like the below,

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 898e9c78a7e7..85ff9109595e 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -36,12 +36,14 @@ static inline uint32_t __div64_32(uint64_t *n,
uint32_t base)
        register unsigned long long __n   asm("r0") = *n;
        register unsigned long long __res asm("r2");
        register unsigned int __rem       asm(__xh);
+       register unsigned int __dummy     asm(__xl);
        asm(    __asmeq("%0", __xh)
                __asmeq("%1", "r2")
-               __asmeq("%2", "r0")
-               __asmeq("%3", "r4")
+               __asmeq("%2", __xl)
+               __asmeq("%3", "r0")
+               __asmeq("%4", "r4")
                "bl     __do_div64"
-               : "=r" (__rem), "=r" (__res)
+               : "=r" (__rem), "=r" (__res), "=r"(__dummy)
                : "r" (__n), "r" (__base)
                : "ip", "lr", "cc");
        *n = __res;



> If the compiler can't work out that if a physical register used as an
> output operand will be written by the assembler, then the compiler is
> quite simply buggy.
>
> The code is correct as it stands; Clang is buggy.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
