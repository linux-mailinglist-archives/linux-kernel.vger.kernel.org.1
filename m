Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA30B2C50C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKZIxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgKZIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:53:53 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC2B208CA;
        Thu, 26 Nov 2020 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606380832;
        bh=QgT3huId6ytL516YbcEUvc9XJ34jPp0iYndtARK7j7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fps3RUNTT6v4G7ajKtKqSUj2jXFhSwRjBEUhAc7zMVhuwc6iK2ugTVc5QxDir51Ll
         0YI0WlG22bHOBDH+2Ms77ivo4ky7Frt+8tzAyThYRrj9v6IUH74BoTQR7xaAheNRl+
         l3KTm98g20RAa1PZ1itQJ4uWPurNWa4XVGdVFjQ0=
Date:   Thu, 26 Nov 2020 08:53:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Michael Clark <michaeljclark@mac.com>
Subject: Re: [PATCH 2/5] riscv: Add QUEUED_SPINLOCKS & QUEUED_RWLOCKS
 supported
Message-ID: <20201126085346.GB17797@willie-the-truck>
References: <1606225437-22948-1-git-send-email-guoren@kernel.org>
 <1606225437-22948-2-git-send-email-guoren@kernel.org>
 <20201124143931.GI2414@hirez.programming.kicks-ass.net>
 <CAK8P3a1ykYmpXtjVbeAjLPY0AtfQTpL9jJ8e6SokiTb=J9UhnQ@mail.gmail.com>
 <20201125141645.GB2414@hirez.programming.kicks-ass.net>
 <20201125143128.GC16159@willie-the-truck>
 <CAJF2gTTD8NqegPGvqFhUeidGYiuiE6aT3AOELEs2e0JeE_CmUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTD8NqegPGvqFhUeidGYiuiE6aT3AOELEs2e0JeE_CmUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 09:36:34AM +0800, Guo Ren wrote:
> On Wed, Nov 25, 2020 at 10:31 PM Will Deacon <will@kernel.org> wrote:
> > On Wed, Nov 25, 2020 at 03:16:45PM +0100, Peter Zijlstra wrote:
> > > @@ -207,6 +187,32 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
> > >       atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
> > >  }
> > >
> > > +#endif /* _Q_PENDING_BITS == 8 */
> > > +
> > > +#if _Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16
> > > +
> > > +/*
> > > + * xchg_tail - Put in the new queue tail code word & retrieve previous one
> > > + * @lock : Pointer to queued spinlock structure
> > > + * @tail : The new queue tail code word
> > > + * Return: The previous queue tail code word
> > > + *
> > > + * xchg(lock, tail), which heads an address dependency
> > > + *
> > > + * p,*,* -> n,*,* ; prev = xchg(lock, node)
> > > + */
> > > +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > > +{
> > > +     /*
> > > +      * We can use relaxed semantics since the caller ensures that the
> > > +      * MCS node is properly initialized before updating the tail.
> > > +      */
> > > +     return (u32)xchg_relaxed(&lock->tail,
> > > +                              tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> > > +}
> > > +
> > > +#else /* !(_Q_PENDING_BITS == 8 && ARCH_HAS_XCHG16) */
> >
> > Why can't architectures just implement this with a 32-bit xchg instruction
> > if they don't have one that operates on 16 bits? Sure, they'll store more
> > data, but it's atomic so you shouldn't be able to tell... (ignoring parisc
> > crazy).
> >
> > Also, I'm surprised qspinlock benefits riscv. On arm64, there's nothing in
> > it over tickets for <= 16 CPUs.
> NUMA is on the way:
> https://lore.kernel.org/linux-riscv/20201119003829.1282810-1-atish.patra@wdc.com/

Well, they're patches not hardware (and I only see mention of QEMU over
there for the RISCV platform) ;)

> With your advice, I think we could using tickets lock when <= 16 CPUs
> and using qspinlock when > 16 CPUs.
> Is that right?

No, when I say "there's nothing in it", it means they're interchangeable.
It's just that qspinlock introduces a lot of complexity and I'm not keen
massively keen on changing the core code (which is used by many other
architectures) just because you don't have a 16-bit xchg() implementation.

So if you need qspinlock on riscv (not sure you do), then go ahead and make
that your one true lock implementation, but implement 16-bit xchg() at the
same time. Bonus points if you implement that in terms of 32-bit xchg() in
generic code (might need to watch out for endianness when shifting the new
value after aligning the base pointer).

Will
