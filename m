Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835302C4CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbgKZBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732098AbgKZBgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:36:48 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6055D206F7;
        Thu, 26 Nov 2020 01:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606354607;
        bh=DHcTvmA/WJHw9Fef17EQ48UfNXJ4eOswow3HLd1nbKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wgO6ET37DsEZWesI0u/8IZhSkcxPGnkLC6/msVEPGWZ2gUGmOgoDEsQec9/9c+Ocb
         H6klNG3OQpnQBad/oR19wBjx6AnQb90bTtMLNhD/RKkTHU9Wwd5Qs4EZI+LGohBOIH
         SsbAO57nvfdr653/S4KlTQlkoJZ/lIhplnag+vhE=
Received: by mail-lj1-f174.google.com with SMTP id z1so503766ljn.4;
        Wed, 25 Nov 2020 17:36:47 -0800 (PST)
X-Gm-Message-State: AOAM530iIfotgkMqGPSCNTW5ZQiuHSF9JDp2eXiYemsVmU9sKWjmjiTm
        J81FBsrhCnOtx3ijJ5sHkA6dFy1vioOG3Bm06ls=
X-Google-Smtp-Source: ABdhPJynU3Q6OuiQr1gLVZT8RMGMk5PPaD9gUtqgzbi5KO1M0HS0fEeUJkhnusDypDgk9XMT4B+DIjg/pAozFIBwnNk=
X-Received: by 2002:a05:651c:203:: with SMTP id y3mr310118ljn.66.1606354605575;
 Wed, 25 Nov 2020 17:36:45 -0800 (PST)
MIME-Version: 1.0
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org> <20201124143931.GI2414@hirez.programming.kicks-ass.net>
 <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
 <20201125141645.GB2414@hirez.programming.kicks-ass.net> <20201125143128.GC16159@willie-the-truck>
In-Reply-To: <20201125143128.GC16159@willie-the-truck>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 26 Nov 2020 09:36:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTD8NqegPGvqFhUeidGYiuiE6aT3AOELEs2e0JeE_CmUg@mail.gmail.com>
Message-ID: <CAJF2gTTD8NqegPGvqFhUeidGYiuiE6aT3AOELEs2e0JeE_CmUg@mail.gmail.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS supported
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Nov 25, 2020 at 10:31 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Nov 25, 2020 at 03:16:45PM +0100, Peter Zijlstra wrote:
> > @@ -207,6 +187,32 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
> >       atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
> >  }
> >
> > +#endif /* _Q_PENDING_BITS == 8 */
> > +
> > +#if _Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16
> > +
> > +/*
> > + * xchg_tail - Put in the new queue tail code word & retrieve previous one
> > + * @lock : Pointer to queued spinlock structure
> > + * @tail : The new queue tail code word
> > + * Return: The previous queue tail code word
> > + *
> > + * xchg(lock, tail), which heads an address dependency
> > + *
> > + * p,*,* -> n,*,* ; prev = xchg(lock, node)
> > + */
> > +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > +{
> > +     /*
> > +      * We can use relaxed semantics since the caller ensures that the
> > +      * MCS node is properly initialized before updating the tail.
> > +      */
> > +     return (u32)xchg_relaxed(&lock->tail,
> > +                              tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> > +}
> > +
> > +#else /* !(_Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16) */
>
> Why can't architectures just implement this with a 32-bit xchg instruction
> if they don't have one that operates on 16 bits? Sure, they'll store more
> data, but it's atomic so you shouldn't be able to tell... (ignoring parisc
> crazy).
>
> Also, I'm surprised qspinlock benefits riscv. On arm64, there's nothing in
> it over tickets for <= 16 CPUs.
NUMA is on the way:
https://lore.kernel.org/linux-riscv/20201119003829.1282810-1-atish.patra@wdc.com/

With your advice, I think we could using tickets lock when <= 16 CPUs
and using qspinlock when > 16 CPUs.
Is that right?

The next patchset plan is:
 - Using tickets & qspinlock together in riscv. Abandon 16bits
xchg/cmpxchg implementation.
 - Abanden qspinlock in csky, because it only could 4 CPUs' SMP.

>
> Will



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
