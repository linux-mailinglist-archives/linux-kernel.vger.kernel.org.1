Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21F12AAD59
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKHUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 15:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 15:15:04 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F020221FF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604866503;
        bh=DzrytRBv4yv5uzHi5q12YXuVzqPc8Sd8QLQFJ4ZtEog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f5oYkN2hm7CQkCGPle6S4dyWS8tIC1tMMuM6cjt85xmYsYDSkVvDzUDGGcQ39Epj7
         fM989LT3208jEDVzaHwGhOBfrNsS8EynVAM+5QpXuFoUBdExq+drjN1/A8h4mWRXQK
         6qC3kXj2nXqTvTFacf0itLMI2Kt5NBWgDulF/eNA=
Received: by mail-ot1-f53.google.com with SMTP id n15so6920135otl.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 12:15:03 -0800 (PST)
X-Gm-Message-State: AOAM530cpE8CcxCA+awGgT4zltmP32dMQJRA9Ukyx+YAP3dQOp9RTkLd
        +dQ9dK9IjeZW8Nvzd2GNSOpTgRbq7RhTHQU/HV0=
X-Google-Smtp-Source: ABdhPJwyfxDiepX9W1qFF/eCJEQI5wveTdc/w527QnERqa9koyap7NZ2zJa5jDpKtZMUOMXbs0hB/4yDp21GgbqrWBw=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr7838332otk.108.1604866502776;
 Sun, 08 Nov 2020 12:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201108174014.GA219672@rani.riverdale.lan>
 <20201108180942.GA226037@rani.riverdale.lan>
In-Reply-To: <20201108180942.GA226037@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 8 Nov 2020 21:14:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEhkW=twpprrqjRahBvgiyL6kkSOcJPAGkeOUZ_DC5euQ@mail.gmail.com>
Message-ID: <CAMj1kXEhkW=twpprrqjRahBvgiyL6kkSOcJPAGkeOUZ_DC5euQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Nov 2020 at 19:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Nov 08, 2020 at 12:40:14PM -0500, Arvind Sankar wrote:
> > On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote:
> > > Due to a Clang bug [1] neon autoloop vectorization does not happen or
> > > happens badly with no gains and considering previous GCC experiences
> > > which generated unoptimized code which was worse than the default asm
> > > implementation, it is safer to default clang builds to the known good
> > > generic implementation.
> > >
> > > The kernel currently supports a minimum Clang version of v10.0.1, see
> > > commit 1f7a44f63e6c ("compiler-clang: add build check for clang 10.0.1").
> > >
> > > When the bug gets eventually fixed, this commit could be reverted or,
> > > if the minimum clang version bump takes a long time, a warning could
> > > be added for users to upgrade their compilers like was done for GCC.
> > >
> > > [1] https://bugs.llvm.org/show_bug.cgi?id=40976
> > >
> > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > > ---
> > >  arch/arm/include/asm/xor.h | 3 ++-
> > >  arch/arm/lib/Makefile      | 3 +++
> > >  arch/arm/lib/xor-neon.c    | 4 ++++
> > >  3 files changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> > > index aefddec79286..49937dafaa71 100644
> > > --- a/arch/arm/include/asm/xor.h
> > > +++ b/arch/arm/include/asm/xor.h
> > > @@ -141,7 +141,8 @@ static struct xor_block_template xor_block_arm4regs = {
> > >             NEON_TEMPLATES;                 \
> > >     } while (0)
> > >
> > > -#ifdef CONFIG_KERNEL_MODE_NEON
> > > +/* disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976 */
> > > +#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
> > >
> > >  extern struct xor_block_template const xor_block_neon_inner;
> > >
> > > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > > index 6d2ba454f25b..53f9e7dd9714 100644
> > > --- a/arch/arm/lib/Makefile
> > > +++ b/arch/arm/lib/Makefile
> > > @@ -43,8 +43,11 @@ endif
> > >  $(obj)/csumpartialcopy.o:  $(obj)/csumpartialcopygeneric.S
> > >  $(obj)/csumpartialcopyuser.o:      $(obj)/csumpartialcopygeneric.S
> > >
> > > +# disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976
> > > +ifndef CONFIG_CC_IS_CLANG
> > >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> > >    NEON_FLAGS                       := -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> > >    CFLAGS_xor-neon.o                += $(NEON_FLAGS)
> > >    obj-$(CONFIG_XOR_BLOCKS) += xor-neon.o
> > >  endif
> > > +endif
> > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > index e1e76186ec23..84c91c48dfa2 100644
> > > --- a/arch/arm/lib/xor-neon.c
> > > +++ b/arch/arm/lib/xor-neon.c
> > > @@ -18,6 +18,10 @@ MODULE_LICENSE("GPL");
> > >   * Pull in the reference implementations while instructing GCC (through
> > >   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> > >   * NEON instructions.
> > > +
> > > + * On Clang the loop vectorizer is enabled by default, but due to a bug
> > > + * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
> > > + * so xor-neon is disabled in favor of the default reg implementations.
> > >   */
> > >  #ifdef CONFIG_CC_IS_GCC
> > >  #pragma GCC optimize "tree-vectorize"
> > > --
> > > 2.29.0
> > >
> >
> > It's actually a bad idea to use #pragma GCC optimize. This is basically
> > the same as tagging all the functions with __attribute__((optimize)),
> > which GCC does not recommend for production use, as it _replaces_
> > optimization options rather than appending to them, and has been
> > observed to result in dropping important compiler flags.
> >
> > There've been a few discussions recently around other such cases:
> > https://lore.kernel.org/lkml/20201028171506.15682-1-ardb@kernel.org/
> > https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
> >
> > For this file, given that it is supposed to use -ftree-vectorize for the
> > whole file anyway, is there any reason it's not just added to CFLAGS via
> > the Makefile? This seems to be the only use of pragma optimize in the
> > kernel.
>
> Eg, this shows that the pragma results in dropping -fno-strict-aliasing.
> https://godbolt.org/z/1nfrKT
>
> The first function does not use vectorization because s and s->a might
> alias.
>

Thanks, Arvind. I wasn't aware of this issue at the time, but I agree
that we should replace the #pragma with a command line option in this
case.

And given that we already set CFLAGS_xor-neon.o in the Makefile,
adding it there would have been more straight-forward to begin with.
