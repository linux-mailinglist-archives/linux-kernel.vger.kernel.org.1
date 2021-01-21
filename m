Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C42FE55B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbhAUIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbhAUIrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:47:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DF5239CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611218791;
        bh=A7dzYX1WsIR/ZnVt2MQcZkXX5OVwc6fA8JUVQ7nzhB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dpmeUZ58F4d7jPC/UwAaSySnYU1zZ4lhkG27a9p1/MsVpRTuwqViNMaBHgyVb5350
         vz+NJJXDe53yNrlD0B2/mRX5gAsF201SrpLBsPNSMdU2zQrEq+D9xfXD+khgkLddPw
         pcXgQZugloGvBA7F6jw2jyJbp2sKvEX7edpzVO6h+bSFqVyomNvrckXBNnLqePg+Yg
         k22f+Qxz4qm4JBcPxnWFGiPmfjzogqeVtQww5SjCcJiPThsqXfX74/ePbg6E7qDYGQ
         lwAFV/g5tSYXwgbo1NhTrfAKhgYtpLjAgFNm7CnVqJMoLS6E5MsDSgPHoyeVkq6o7L
         tjfnojp31RaLw==
Received: by mail-lj1-f169.google.com with SMTP id b10so1566020ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:46:30 -0800 (PST)
X-Gm-Message-State: AOAM533Jrh8DqIaXa4KfWv+L1ccXUpWl+jZ4vkpWoAI2KymmWiAw30Or
        cDprY6rmrqOu9+X6t7Aa9KmKmZDZlGcUYp9xK/4=
X-Google-Smtp-Source: ABdhPJw0HAz2Ji9UEh/QtkUlTh+BKoUnXsWI796UHYzxcYj5OLvRlzicgko+xc4E4VaFk9nrOzW0gYwWtc0eUk5h1LA=
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr6390528ljc.255.1611218788873;
 Thu, 21 Jan 2021 00:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
 <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
 <CAKwvOdnVwkxQTQ-LkdZi4pFWTMg6d0Lddddp=j4pCEh-JT-34Q@mail.gmail.com> <YAj/VBzbRaBy7zLv@rani.riverdale.lan>
In-Reply-To: <YAj/VBzbRaBy7zLv@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 21 Jan 2021 09:46:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHysorzm2uRzvOBXaP2s61jN7nyAD3pju_rhzGF2UH7uw@mail.gmail.com>
Message-ID: <CAMj1kXHysorzm2uRzvOBXaP2s61jN7nyAD3pju_rhzGF2UH7uw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 at 05:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 20, 2021 at 03:09:53PM -0800, Nick Desaulniers wrote:
> > On Tue, Jan 19, 2021 at 1:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Tue, Jan 19, 2021 at 10:18 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > > > index b99dd8e1c93f..f9f3601cc2d1 100644
> > > > > --- a/arch/arm/lib/xor-neon.c
> > > > > +++ b/arch/arm/lib/xor-neon.c
> > > > > @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
> > > > >  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> > > > >  #endif
> > > > >
> > > > > +/*
> > > > > + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> > > > > + * compiler does not produce vectorized code due to its cost model.
> > > > > + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> > > > > + */
> > > > > +#ifdef CONFIG_CC_IS_CLANG
> > > > > +#warning Clang does not vectorize code in this file.
> > > > > +#endif
> > > >
> > > > Arnd, remind me again why it's a bug that the compiler's cost model
> > > > says it's faster to not produce a vectorized version of these loops?
> > > > I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8
> > >
> > > The point is that without vectorizing the code, there is no point in building
> > > both the default xor code and a "neon" version that has to save/restore
> > > the neon registers but doesn't actually use them.
> >
> > Doesn't that already happen today with GCC when the pointer arguments
> > are overlapping?  The loop is "versioned" and may not actually use the
> > NEON registers at all at runtime for such arguments.
> > https://godbolt.org/z/q48q8v  See also:
> > https://bugs.llvm.org/show_bug.cgi?id=40976#c11.  Or am I missing
> > something?
>
> The gcc version is at least useful when the arguments _don't_ overlap,
> which is presumably most/all the time.
>

Indeed

> There's no point to building this file if it's not going to produce a
> vectorized version at all. The warning seems unnecessary, and it's not
> really a compiler bug either -- until we agree on a way to get clang to
> produce a vectorized version, the best thing would be for the neon
> version to not be built at all with clang. Is that too messy to achieve?
>

+1

> >
> > So I'm thinking if we extend out this pattern to the rest of the
> > functions, we can actually avoid calls to
> > kernel_neon_begin()/kernel_neon_end() for cases in which pointers
> > would be too close to use the vectorized loop version; meaning for GCC
> > this would be an optimization (don't save neon registers when you're
> > not going to use them).  I would probably consider moving
> > include/asm-generic/xor.h somewhere under arch/arm/
> > perhaps...err...something for the other users of <asm-generic/xor.h>.
>
> We can't directly do the patch below since there are other users of the
> asm-generic/xor.h implementations than just the neon file.  If it's too
> much work to check and add __restrict everywhere, I think we'd either
> need to copy the code into the xor-neon file, or maybe do some ifdeffery
> so __restrict is only used for the neon version.
>

Don't mess with the code, please. It's really not worth it.

The current implementation works fine with overlapping inputs, but
works better when they don't. I don't see why we would change that.

If Clang cannot be forced to vectorize this code, then just disable it
for Clang - it's not the end of the world, who runs xor_blocks() on a
hot path on 32-bit ARM anyway?



> >
> > diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> > index aefddec79286..abd748d317e8 100644
> > --- a/arch/arm/include/asm/xor.h
> > +++ b/arch/arm/include/asm/xor.h
> > @@ -148,12 +148,12 @@ extern struct xor_block_template const
> > xor_block_neon_inner;
> >  static void
> >  xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> >  {
> > -       if (in_interrupt()) {
> > -               xor_arm4regs_2(bytes, p1, p2);
> > -       } else {
> > +       if (!in_interrupt() && abs((uintptr_t)p1, (uintptr_t)p2) >= 8) {
> >                 kernel_neon_begin();
> >                 xor_block_neon_inner.do_2(bytes, p1, p2);
> >                 kernel_neon_end();
> > +       } else {
> > +               xor_arm4regs_2(bytes, p1, p2);
> >         }
> >  }
> > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > index b99dd8e1c93f..0e8e474c0523 100644
> > --- a/arch/arm/lib/xor-neon.c
> > +++ b/arch/arm/lib/xor-neon.c
> > @@ -14,22 +14,6 @@ MODULE_LICENSE("GPL");
> >  #error You should compile this file with '-march=armv7-a
> > -mfloat-abi=softfp -mfpu=neon'
> >  #endif
> >
> > -/*
> > - * Pull in the reference implementations while instructing GCC (through
> > - * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> > - * NEON instructions.
> > - */
> > -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> > -#pragma GCC optimize "tree-vectorize"
> > -#else
> > -/*
> > - * While older versions of GCC do not generate incorrect code, they fail to
> > - * recognize the parallel nature of these functions, and emit plain ARM code,
> > - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> > - */
> > -#warning This code requires at least version 4.6 of GCC
> > -#endif
> > -
> >  #pragma GCC diagnostic ignored "-Wunused-variable"
> >  #include <asm-generic/xor.h>
> > diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
> > index b62a2a56a4d4..69df62095c33 100644
> > --- a/include/asm-generic/xor.h
> > +++ b/include/asm-generic/xor.h
> > @@ -8,7 +8,7 @@
> >  #include <linux/prefetch.h>
> >
> >  static void
> > -xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> > +xor_8regs_2(unsigned long bytes, unsigned long * __restrict p1,
> > unsigned long * __restrict p2)
> >  {
> >         long lines = bytes / (sizeof (long)) / 8;
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
