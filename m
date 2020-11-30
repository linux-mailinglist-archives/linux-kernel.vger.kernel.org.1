Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC32C8AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgK3RTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387420AbgK3RTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:19:08 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B972074A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606756707;
        bh=KnupxPqYJIrOe6lKkkTPQdnW31W2COK7xbBRyWpFMfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MriswbwevMLk9bqQMJWJknZT2RLSWyjiWhmf19oAMzrk2qGHoBlTA48JbnogRxyow
         tG77HoaECF/GK1jd2iwzMGwV2zu9km9SC/oRAchUmXrzQqpRTkQpL6JIbHz4xBFwuE
         8xEs9NjQohh2Q3dj+v5UrnKAQySRbii12eimcz1I=
Received: by mail-oo1-f41.google.com with SMTP id z13so2847634ooa.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:18:27 -0800 (PST)
X-Gm-Message-State: AOAM53184A4G+wKY/6bfFp+WrDy2prgcomM/6ynKYWUIHi1e5XHt1Ylc
        5QsrcUF13HFy3Tak/siQd1mDntIVBKsLiphwCM8=
X-Google-Smtp-Source: ABdhPJy8hfBjOtNzK48S2FyKVVebJCJg3iU22Qw/uLZLijGzLW3aN8ivd/XSoPBZX1+2TW9QKXAg+oco4Ht0t8zlKX8=
X-Received: by 2002:a4a:45c3:: with SMTP id y186mr16208144ooa.13.1606756707013;
 Mon, 30 Nov 2020 09:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com> <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
 <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com> <89n4o5sp-4432-7r33-r9s-54po13q25pnp@syhkavp.arg>
In-Reply-To: <89n4o5sp-4432-7r33-r9s-54po13q25pnp@syhkavp.arg>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Nov 2020 18:18:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGuHw+p5=YPrVwaHjp5hQ9uxsp7hbA0Vk-ppZ3_qHDVrA@mail.gmail.com>
Message-ID: <CAMj1kXGuHw+p5=YPrVwaHjp5hQ9uxsp7hbA0Vk-ppZ3_qHDVrA@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Antony Yu <swpenim@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 16:51, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Mon, 30 Nov 2020, Ard Biesheuvel wrote:
>
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
> You're right.
>
> This was done like that most likely to work around some stupid code
> generation with "__n >> 32" while using gcc from about 20 years ago. IOW
> I don't exactly remember why I did it like that, but it is certainly
> flawed.
>
> Here's my version of the fix which should be correct. Warning: this
> is completely untested, but should in theory produce the same code on
> modern gcc.
>
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 898e9c78a7..595e538f5b 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -21,29 +21,20 @@
>   * assembly implementation with completely non standard calling convention
>   * for arguments and results (beware).
>   */
> -
> -#ifdef __ARMEB__
> -#define __xh "r0"
> -#define __xl "r1"
> -#else
> -#define __xl "r0"
> -#define __xh "r1"
> -#endif
> -
>  static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>  {
>         register unsigned int __base      asm("r4") = base;
>         register unsigned long long __n   asm("r0") = *n;
>         register unsigned long long __res asm("r2");
> -       register unsigned int __rem       asm(__xh);
> -       asm(    __asmeq("%0", __xh)
> +       unsigned int __rem;
> +       asm(    __asmeq("%0", "r0")
>                 __asmeq("%1", "r2")
> -               __asmeq("%2", "r0")
> -               __asmeq("%3", "r4")
> +               __asmeq("%2", "r4")
>                 "bl     __do_div64"
> -               : "=r" (__rem), "=r" (__res)
> -               : "r" (__n), "r" (__base)
> +               : "+r" (__n), "=r" (__res)
> +               : "r" (__base)
>                 : "ip", "lr", "cc");
> +       __rem = __n >> 32;

This treats {r0, r1} as a {low, high} pair, regardless of endianness,
and so it puts the value of r0 into r1. Doesn't that mean the shift
should only be done on little endian?


>         *n = __res;
>         return __rem;
>  }
>
> I'll submit it if someone confirms it works.
>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
