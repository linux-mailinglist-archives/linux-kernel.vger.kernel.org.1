Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8122C35C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKYAwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgKYAwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:52:37 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F5421741;
        Wed, 25 Nov 2020 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606265556;
        bh=CyLRVh8JtmFuJs0UzEiC19JLYFq/L1Q+qkZ2v4YFjYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uq66iisQgQ3PIjtDoE4msOhqb5OHJ3lFF57H0J9pOfOI7izqnpVv7JWsMXjv0WP6+
         Zdt4rAhfJf64SNHy3loP5/dMi5t4SugO1tTpQ4+NM4pqEyQ0Wnj+KgD0sbYyjfKfBg
         66yXHsIfGBf8VrGfRTF8+lDdnuqak9ZLIlSVa1a0=
Received: by mail-lj1-f182.google.com with SMTP id b17so436551ljf.12;
        Tue, 24 Nov 2020 16:52:36 -0800 (PST)
X-Gm-Message-State: AOAM533zUPshGroIo8BOKSpAuuwie3HaahsHt0Nr/K1jZxzK56kiyP/Z
        VQO8X/jxm0fyfny350Vjw0MHjNQ402GCNg1Iyqg=
X-Google-Smtp-Source: ABdhPJxXNypMXNrwvl404YxnwDVGzaYXnO59TiupDEKcpkPWd6NZwPa2V/R/J4KGCf3GcXUkVvM9vFT0gdbbTku0XNk=
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr325504ljn.250.1606265554826;
 Tue, 24 Nov 2020 16:52:34 -0800 (PST)
MIME-Version: 1.0
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org> <20201124143931.GI2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201124143931.GI2414@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 25 Nov 2020 08:52:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTBbjOhvvLTd6d5zgb0kskoSJhPW7nmg==4w2wV+OaUgg@mail.gmail.com>
Message-ID: <CAJF2gTTBbjOhvvLTd6d5zgb0kskoSJhPW7nmg==4w2wV+OaUgg@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS supported
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Peter,

On Tue, Nov 24, 2020 at 10:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 24, 2020 at 01:43:54PM +0000, guoren@kernel.org wrote:
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > index 59dd7be..6f5f438 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -6,3 +6,6 @@ generic-y += kvm_para.h
> >  generic-y += local64.h
> >  generic-y += user.h
> >  generic-y += vmlinux.lds.h
> > +generic-y += mcs_spinlock.h
> > +generic-y += qrwlock.h
> > +generic-y += qspinlock.h
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 5609185..e178700 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -16,7 +16,43 @@
> >       __typeof__(ptr) __ptr = (ptr);                                  \
> >       __typeof__(new) __new = (new);                                  \
> >       __typeof__(*(ptr)) __ret;                                       \
> > +     register unsigned long __rc, tmp, align, addr;                  \
> >       switch (size) {                                                 \
> > +     case 2:                                                         \
> > +             align = ((unsigned long) __ptr & 0x3);                  \
> > +             addr = ((unsigned long) __ptr & ~0x3);                  \
> > +             if (align) {                                            \
> > +             __asm__ __volatile__ (                                  \
> > +                     "0:     lr.w %0, 0(%z4)\n"                      \
> > +                     "       move %1, %0\n"                          \
> > +                     "       slli %1, %1, 16\n"                      \
> > +                     "       srli %1, %1, 16\n"                      \
> > +                     "       move %2, %z3\n"                         \
> > +                     "       slli %2, %2, 16\n"                      \
> > +                     "       or   %1, %2, %1\n"                      \
> > +                     "       sc.w %2, %1, 0(%z4)\n"                  \
> > +                     "       bnez %2, 0b\n"                          \
> > +                     "       srli %0, %0, 16\n"                      \
> > +                     : "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)      \
> > +                     : "rJ" (__new), "rJ"(addr)                      \
> > +                     : "memory");                                    \
> > +             } else {                                                \
> > +             __asm__ __volatile__ (                                  \
> > +                     "0:     lr.w %0, (%z4)\n"                       \
> > +                     "       move %1, %0\n"                          \
> > +                     "       srli %1, %1, 16\n"                      \
> > +                     "       slli %1, %1, 16\n"                      \
> > +                     "       move %2, %z3\n"                         \
> > +                     "       or   %1, %2, %1\n"                      \
> > +                     "       sc.w %2, %1, 0(%z4)\n"                  \
> > +                     "       bnez %2, 0b\n"                          \
> > +                     "       slli %0, %0, 16\n"                      \
> > +                     "       srli %0, %0, 16\n"                      \
> > +                     : "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)      \
> > +                     : "rJ" (__new), "rJ"(addr)                      \
> > +                     : "memory");                                    \
> > +             }                                                       \
> > +             break;                                                  \
> >       case 4:                                                         \
> >               __asm__ __volatile__ (                                  \
> >                       "       amoswap.w %0, %2, %1\n"                 \
>
> I'm pretty sure there's a handfull of implementations like this out
> there... if only we could share.
Michael has sent qspinlock before, ref to Link below. He reused mips' code.

Link: https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/

Which short xchg implementation do you prefer (Mine or his)?

>
> Anyway, this too should be an independent patch.
Ok, I'll separate it into two patches,
1. implement short xchg
2. qspinlock enabled based on Michael's patch

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
