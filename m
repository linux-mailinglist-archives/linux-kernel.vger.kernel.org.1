Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844C12FDE26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbhAUAZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404075AbhATXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:24:12 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF7C061345
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:10:04 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m6so192618pfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhYUIY/pxxk2hZgz6LMzQ8D+neAYmmcm1aEWExzAYmQ=;
        b=D35sbY5IM0l3nNJgTq2Mtt9TnUMLXk7pZLD8wejcrmNzPKBoXjjA6qJep8jGe+pbBv
         A8dXbesIoDRV3Fyi3J5haKssIm6x7MlVuJeglxbaMegCO2Ge0Mw9gZlFNk4W1gd8AOwJ
         dbnI/52USn8/1EivK6GDDoNlLgSVB1vpsmDfk1puY3nWmCuvGNUAlK6ZvABTKfam7VTm
         XahN0A8JdrDdi9vzGtuVIoI9/Xr6z8G+Zdyzot3YMcLUTsNpf1iYTi4OctF6CQf5Hr4z
         g/tAzqM8CnyzcoJYtfefYiu+ebJGfpY257m1WhFUHhbTVj/OzefOIK7R6Pdo5zv/fKBY
         x5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhYUIY/pxxk2hZgz6LMzQ8D+neAYmmcm1aEWExzAYmQ=;
        b=QyIEp4GzKJVuf0cnxPE7pX6f63NKLFzF46mKL9WworoTbcOq4u/B/HGkGpBbeWyLEQ
         075gJ2xP0zWU+JVcbyXwf5ZXzvN8Nvt5/Q76WpwdVi/EBCfLCacMzBSpIGkWqY3KQoyx
         oGvo2bi+iK0qMwKk41JmL/3JorP2sFF44XC9I7a0Q3SIrBZ/dpgRHs0gM06ZSQ/iK9ca
         7DKnHWtkUE5pUat+JcBbPXIKa4/2qneQvRPsa2WtERR2KlnSBAUG5Hf9QC/R8KA0QWBy
         rCzmlzglV9M0HQM7GENyYG2U0Nmra6uwIz6ZrJBxoAfnRyIrIEn9BjzBiOhU6qnpYuRS
         b8ng==
X-Gm-Message-State: AOAM530erP3cahxFJGwEiyGinmFSRxJ0VhbThBSk9/QSB7dQMkT5bO59
        ZgIRPJi91iL5LARsFGIm4Vh/t+YssCC7eqxtUmZXnw==
X-Google-Smtp-Source: ABdhPJzoTxwT1LcGVojArd3Ht6jp/TQI1VNqgqsQgJka5cM6J4ZuTRLZJAoeXNVoFzJg22TSN3YTDOBTBWbRpbXwAjE=
X-Received: by 2002:a63:1142:: with SMTP id 2mr11653031pgr.263.1611184203611;
 Wed, 20 Jan 2021 15:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
 <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
In-Reply-To: <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 15:09:53 -0800
Message-ID: <CAKwvOdnVwkxQTQ-LkdZi4pFWTMg6d0Lddddp=j4pCEh-JT-34Q@mail.gmail.com>
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

On Tue, Jan 19, 2021 at 1:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Jan 19, 2021 at 10:18 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > index b99dd8e1c93f..f9f3601cc2d1 100644
> > > --- a/arch/arm/lib/xor-neon.c
> > > +++ b/arch/arm/lib/xor-neon.c
> > > @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
> > >  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> > >  #endif
> > >
> > > +/*
> > > + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> > > + * compiler does not produce vectorized code due to its cost model.
> > > + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> > > + */
> > > +#ifdef CONFIG_CC_IS_CLANG
> > > +#warning Clang does not vectorize code in this file.
> > > +#endif
> >
> > Arnd, remind me again why it's a bug that the compiler's cost model
> > says it's faster to not produce a vectorized version of these loops?
> > I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8
>
> The point is that without vectorizing the code, there is no point in building
> both the default xor code and a "neon" version that has to save/restore
> the neon registers but doesn't actually use them.

Doesn't that already happen today with GCC when the pointer arguments
are overlapping?  The loop is "versioned" and may not actually use the
NEON registers at all at runtime for such arguments.
https://godbolt.org/z/q48q8v  See also:
https://bugs.llvm.org/show_bug.cgi?id=40976#c11.  Or am I missing
something?

So I'm thinking if we extend out this pattern to the rest of the
functions, we can actually avoid calls to
kernel_neon_begin()/kernel_neon_end() for cases in which pointers
would be too close to use the vectorized loop version; meaning for GCC
this would be an optimization (don't save neon registers when you're
not going to use them).  I would probably consider moving
include/asm-generic/xor.h somewhere under arch/arm/
perhaps...err...something for the other users of <asm-generic/xor.h>.

diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
index aefddec79286..abd748d317e8 100644
--- a/arch/arm/include/asm/xor.h
+++ b/arch/arm/include/asm/xor.h
@@ -148,12 +148,12 @@ extern struct xor_block_template const
xor_block_neon_inner;
 static void
 xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 {
-       if (in_interrupt()) {
-               xor_arm4regs_2(bytes, p1, p2);
-       } else {
+       if (!in_interrupt() && abs((uintptr_t)p1, (uintptr_t)p2) >= 8) {
                kernel_neon_begin();
                xor_block_neon_inner.do_2(bytes, p1, p2);
                kernel_neon_end();
+       } else {
+               xor_arm4regs_2(bytes, p1, p2);
        }
 }
diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index b99dd8e1c93f..0e8e474c0523 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -14,22 +14,6 @@ MODULE_LICENSE("GPL");
 #error You should compile this file with '-march=armv7-a
-mfloat-abi=softfp -mfpu=neon'
 #endif

-/*
- * Pull in the reference implementations while instructing GCC (through
- * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
- * NEON instructions.
- */
-#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
-#pragma GCC optimize "tree-vectorize"
-#else
-/*
- * While older versions of GCC do not generate incorrect code, they fail to
- * recognize the parallel nature of these functions, and emit plain ARM code,
- * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
- */
-#warning This code requires at least version 4.6 of GCC
-#endif
-
 #pragma GCC diagnostic ignored "-Wunused-variable"
 #include <asm-generic/xor.h>
diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
index b62a2a56a4d4..69df62095c33 100644
--- a/include/asm-generic/xor.h
+++ b/include/asm-generic/xor.h
@@ -8,7 +8,7 @@
 #include <linux/prefetch.h>

 static void
-xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+xor_8regs_2(unsigned long bytes, unsigned long * __restrict p1,
unsigned long * __restrict p2)
 {
        long lines = bytes / (sizeof (long)) / 8;


-- 
Thanks,
~Nick Desaulniers
