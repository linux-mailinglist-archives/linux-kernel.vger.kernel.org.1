Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9574F2FDDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392869AbhAUAPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390857AbhATXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:16:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6CC06134A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:15:51 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y205so193495pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muNwPqj3IkfhKZEjpn4BdoeLJPrHYLRIQ5wRRrb83eM=;
        b=iQRFLI8z9+aHSUAgDB0kBragh2wVk/7sHwLmPrRBZO43UHiX1V/6M0AMy7vrkxcrdg
         K+iQIFtaKkbGj3uhWVuqVYJWrjKqJaFjN33RsFtvOwIBo0+ptibWLv3o5z+Arh4GdzcB
         QgLNuX9XkEDNNeRcrLs9ZzpdV5xGkN5+gxICpUn0m13Zfx3sY7+A6BkrmGS0HPaziWLY
         jA1eyiE54ledZbFf6JrQ97IciWJWTQQMn1Fr4i5B7GGwVrn0riJRijgttxdnzr3xpJmy
         dOI10Jy/LnGN3uS2Wo/UlEeyJft1U0iN6l2+iZ8vJ+7EjOcmk07wrO2Wql6Mzi1qn/WT
         3zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muNwPqj3IkfhKZEjpn4BdoeLJPrHYLRIQ5wRRrb83eM=;
        b=fBIO72Vo29Se+MSiqtgjgQB9l9SzGV6VSfQsxFEPIkHLcaZmrwWARs0z/LGR3YCacp
         ymQcJzcVDM+o94jMFIcjtR+ExhBkYgHgXIdlidMKN8VVQq5BuNIGeG7D7zOC7HOuKgff
         zdE2MuRPq10rtlW4C6Jl9aEvYfoq7J5BmYDel2v13WrKUrlY0APtOMTB/PbkB6HmqH2e
         HXZ1scXficWkPiLqvpMmmzhlTMzu/meDQ1K7WGUcHwdz07Mc0hGpjCvod1RQlG7xfPtb
         zWrakXS8x8n15AO0GnWEYk26nVwMjMuUnLRmPxgYzBEykAXHAAaKpd4lDQRlV0FrDch9
         S2xQ==
X-Gm-Message-State: AOAM533woLvRSgXFaA29eCLxGe1S1P/+zQeTpJVEmGw77/r9vP7+aTDD
        9sDWmbtxoNy6Hdx5aWBR/OSBYewoYDCE9zAHvWVaLg==
X-Google-Smtp-Source: ABdhPJz3jBFaSrs5DktJXtA4EyUYw3yXxMJ24F+1drEkngz60VRBnhVnVmaZXnjQkLyg1PI4+Xati1D2lk8MIjYKf24=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr11604193pgm.10.1611184550928;
 Wed, 20 Jan 2021 15:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
 <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com> <CAKwvOdnVwkxQTQ-LkdZi4pFWTMg6d0Lddddp=j4pCEh-JT-34Q@mail.gmail.com>
In-Reply-To: <CAKwvOdnVwkxQTQ-LkdZi4pFWTMg6d0Lddddp=j4pCEh-JT-34Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 15:15:40 -0800
Message-ID: <CAKwvOdkV6ykvmwoaBrTMZ6htp0qVQU5AQzQeKpsg7FGjb4GwCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 3:09 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 19, 2021 at 1:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Jan 19, 2021 at 10:18 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > > index b99dd8e1c93f..f9f3601cc2d1 100644
> > > > --- a/arch/arm/lib/xor-neon.c
> > > > +++ b/arch/arm/lib/xor-neon.c
> > > > @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
> > > >  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> > > >  #endif
> > > >
> > > > +/*
> > > > + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> > > > + * compiler does not produce vectorized code due to its cost model.
> > > > + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> > > > + */
> > > > +#ifdef CONFIG_CC_IS_CLANG
> > > > +#warning Clang does not vectorize code in this file.
> > > > +#endif
> > >
> > > Arnd, remind me again why it's a bug that the compiler's cost model
> > > says it's faster to not produce a vectorized version of these loops?
> > > I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8
> >
> > The point is that without vectorizing the code, there is no point in building
> > both the default xor code and a "neon" version that has to save/restore
> > the neon registers but doesn't actually use them.
>
> Doesn't that already happen today with GCC when the pointer arguments
> are overlapping?  The loop is "versioned" and may not actually use the
> NEON registers at all at runtime for such arguments.
> https://godbolt.org/z/q48q8v  See also:
> https://bugs.llvm.org/show_bug.cgi?id=40976#c11.  Or am I missing
> something?
>
> So I'm thinking if we extend out this pattern to the rest of the
> functions, we can actually avoid calls to
> kernel_neon_begin()/kernel_neon_end() for cases in which pointers
> would be too close to use the vectorized loop version; meaning for GCC
> this would be an optimization (don't save neon registers when you're
> not going to use them).  I would probably consider moving
> include/asm-generic/xor.h somewhere under arch/arm/
> perhaps...err...something for the other users of <asm-generic/xor.h>.
>
> diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> index aefddec79286..abd748d317e8 100644
> --- a/arch/arm/include/asm/xor.h
> +++ b/arch/arm/include/asm/xor.h
> @@ -148,12 +148,12 @@ extern struct xor_block_template const
> xor_block_neon_inner;
>  static void
>  xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  {
> -       if (in_interrupt()) {
> -               xor_arm4regs_2(bytes, p1, p2);
> -       } else {
> +       if (!in_interrupt() && abs((uintptr_t)p1, (uintptr_t)p2) >= 8) {
>                 kernel_neon_begin();
>                 xor_block_neon_inner.do_2(bytes, p1, p2);
>                 kernel_neon_end();
> +       } else {
> +               xor_arm4regs_2(bytes, p1, p2);
>         }
>  }
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index b99dd8e1c93f..0e8e474c0523 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,22 +14,6 @@ MODULE_LICENSE("GPL");
>  #error You should compile this file with '-march=armv7-a
> -mfloat-abi=softfp -mfpu=neon'
>  #endif
>
> -/*
> - * Pull in the reference implementations while instructing GCC (through
> - * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> - * NEON instructions.
> - */
> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> -#pragma GCC optimize "tree-vectorize"

Err...we need to keep this but use the -f flag with __restrict for GCC
to vectorize:
https://godbolt.org/z/9acnEv

-- 
Thanks,
~Nick Desaulniers
