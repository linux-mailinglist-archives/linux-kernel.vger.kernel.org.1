Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F622AFCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgKLBlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgKLBH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:07:56 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18487C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:07:56 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so2920833pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NZ0aQFtfOVaYs8Nc62sAlLU9M6tq2Y/pS+9Ya5s6B4=;
        b=k+wrGPWNJV9J4q1JjQfERxPiYMzUhymwjwj83tIKRuNJbKt6yerSbEe1xwD6P/dQ3/
         xA08UfzFwEdYAYD8+mYxqCNCcGnhccqABz8u/11D35xP3INDJbJVmodqkVUaXgsfiwfm
         7IwXJ8ZZx7efE8jH+dZfSjmXBuelZoJ4/WkAdTS8r9n8TzLHQC6uSBJNILqi76pyEJSy
         L9ResJzAzaQhTrs+aZ/x2iig6NxlVah9mFrxaiyhxfel3VJwQgfJTulBDzdSubTucV88
         wSHjMtraHWXOV3ePUY8CqiXzSFenAuvXwlDyqPbnfY5BfprpP1ZVuASmnkruteVx+pMZ
         5Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NZ0aQFtfOVaYs8Nc62sAlLU9M6tq2Y/pS+9Ya5s6B4=;
        b=VH4l0j9TWPkGkm96BSSBh18hWhm+cMvUqK+3k4YL9tRIc/vJO8giudWxUvqYIBGJaa
         XW465IDRJ36MgmV5HhZ5zI/EnNx4vetj7eUCrZw/AkkRmzHQn1EZsSExlipjyW8qJTV6
         aRUUCNJ1NGKZkYKOyoAMBbK0wXJnMkRuglksfgGrfPgMtvTrZ01LCx+uNIg24OEVqVyK
         1+87mdNzr/+WtKeuLFeQ0hzsCFLQ6HPVgKztHmhk2Cg9J+XBhzs8P/zM697SNOfWdt7V
         h7XGLjwbmaUqPOKsV49oszuOfyZChgSbtdgsk1b16VJJQMwX4vssyyTY+DF+mZv+CzVv
         9X+g==
X-Gm-Message-State: AOAM531JOKcOPOsXtYDTKo+ptgxcOnJweEVKByovRH/WrIV+Lmbf5uiM
        nE7UGaZGHAspV6bIL1bGYfEd/8yziWRfEomXuAxg/g==
X-Google-Smtp-Source: ABdhPJzWiQ9LQrA3adJTbckrFbkQ1a2GkYDAaW8xKEGGdSFmGlHnQ0clt/3ruWTl6OpbmIXYObcKVatNXGhEc0H8TgM=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr6595892pjh.32.1605143275383;
 Wed, 11 Nov 2020 17:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20201112001422.340449-1-willmcvicker@google.com> <CAKwvOdkDG2wt=ZT93GT7r60_qXn=tdW_zWiJ1Gr5JVdRvcU8uw@mail.gmail.com>
In-Reply-To: <CAKwvOdkDG2wt=ZT93GT7r60_qXn=tdW_zWiJ1Gr5JVdRvcU8uw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Nov 2020 17:07:43 -0800
Message-ID: <CAKwvOdnaJrcg-3Z6vCcwoRfUCrETo6HaPrqdyhm+eCook6LXQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix off-by-one vdso trampoline return value
To:     Will McVicker <willmcvicker@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:00 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Nov 11, 2020 at 4:14 PM Will McVicker <willmcvicker@google.com> wrote:
> >
> > Depending on your host nm version, the generated header
> > `include/generated/vdso32-offsets.h` may have the bottom bit set for the
> > thumb vdso offset addresses (as observed when using llvm-nm). This
>
> Sorry, the commit message seems to imply a bug in llvm-nm, but I don't
> think that's the case.  If it is, please, send us a bugreport.
>
> $ aarch64-linux-gnu-nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
> 00000968 T __kernel_rt_sigreturn_thumb
> 00000960 T __kernel_sigreturn_thumb
> 00000968 t VDSO_compat_rt_sigreturn_thumb
> 00000960 t VDSO_compat_sigreturn_thumb
> $ llvm-nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
> 00000968 t VDSO_compat_rt_sigreturn_thumb
> 00000960 t VDSO_compat_sigreturn_thumb
> 00000968 T __kernel_rt_sigreturn_thumb
> 00000960 T __kernel_sigreturn_thumb
> $ /usr/bin/nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
> 00000969 T __kernel_rt_sigreturn_thumb
> 00000961 T __kernel_sigreturn_thumb
> 00000969 t VDSO_compat_rt_sigreturn_thumb
> 00000961 t VDSO_compat_sigreturn_thumb
> $ /usr/bin/nm --version
> GNU nm (GNU Binutils for Debian) 2.35.1

(Noting that my host's GNU binutils are configured to target x86):
$ /usr/bin/nm -h
...
elf64-x86-64 elf32-i386 elf32-iamcu elf32-x86-64 pei-i386 pei-x86-64
elf64-l1om elf64-k1om elf64-little elf64-big elf32-little elf32-big
pe-x86-64 pe-bigobj-x86-64 pe-i386 srec symbolsrec verilog tekhex
binary ihex plugin

So it would seem when binutils is configured for x86, then it will
mistakenly decode thumb instructions as being off by one.

(Note to no one in particular: verilog? really?)

>
> Would you mind amending the commit message to not imply that llvm-nm is broken?
>
> It might be of interest to find out why the host `nm` was invoked,
> rather than $(NM)/$(CROSS_COMPILE)nm.
>
> > results in an additional +1 for thumb vdso trampoline return values
> > since compat_setup_return() already includes `vdso_trampoline + thumb`.
> > As a result, I see a SIGBUS error when running the LTP test
> > syscalls.rt_sigaction01. To fix this, let's clear the bottom bit of the
> > vdso_offset in the VDSO_SYMBOL macro.
> >
> > Test: LTP test syscalls.rt_sigaction01
> > Fixes: f01703b3d2e6 ("arm64: compat: Get sigreturn trampolines from vDSO")
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  arch/arm64/include/asm/vdso.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> > index f99dcb94b438..a7384379e8e1 100644
> > --- a/arch/arm64/include/asm/vdso.h
> > +++ b/arch/arm64/include/asm/vdso.h
> > @@ -23,7 +23,7 @@
> >
> >  #define VDSO_SYMBOL(base, name)                                                   \
> >  ({                                                                        \
> > -       (void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
> > +       (void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \
> >  })
> >
> >  #endif /* !__ASSEMBLY__ */
> > --
> > 2.29.2.299.gdc1121823c-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
