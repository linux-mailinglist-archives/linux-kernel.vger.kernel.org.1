Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508022BA165
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKTELf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKTELf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:11:35 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236C5222C8;
        Fri, 20 Nov 2020 04:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605845494;
        bh=Vt2nOl7KcXqOp1T0wQlU+ExwVGJdC23WC1Dq9lPDKD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wy0sMTNA4khCq/atdsui9N3bhnj6ZLxOU6xcZSt7kK4nVMWYX6yvGpjZk1hihgSqQ
         QlZY3GZRlzHgbLfKl/ZokQXyIcYkbb1fp/JLDDJAM3oWh7wihm9kZ9c0lZJvw2hiWW
         T6rqkVxhWBR5o0jotQpuVVPjcyZ6cfEpmboDCADI=
Date:   Thu, 19 Nov 2020 20:11:32 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when
 collecting IRQ randomness
Message-ID: <X7dB9GCUeHa+Hosn@sol.localdomain>
References: <20201105152944.16953-1-ardb@kernel.org>
 <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:19:37AM +0100, Ard Biesheuvel wrote:
> (+ Eric)
> 
> On Thu, 5 Nov 2020 at 16:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > When reseeding the CRNG periodically, arch_get_random_seed_long() is
> > called to obtain entropy from an architecture specific source if one
> > is implemented. In most cases, these are special instructions, but in
> > some cases, such as on ARM, we may want to back this using firmware
> > calls, which are considerably more expensive.
> >
> > Another call to arch_get_random_seed_long() exists in the CRNG driver,
> > in add_interrupt_randomness(), which collects entropy by capturing
> > inter-interrupt timing and relying on interrupt jitter to provide
> > random bits. This is done by keeping a per-CPU state, and mixing in
> > the IRQ number, the cycle counter and the return address every time an
> > interrupt is taken, and mixing this per-CPU state into the entropy pool
> > every 64 invocations, or at least once per second. The entropy that is
> > gathered this way is credited as 1 bit of entropy. Every time this
> > happens, arch_get_random_seed_long() is invoked, and the result is
> > mixed in as well, and also credited with 1 bit of entropy.
> >
> > This means that arch_get_random_seed_long() is called at least once
> > per second on every CPU, which seems excessive, and doesn't really
> > scale, especially in a virtualization scenario where CPUs may be
> > oversubscribed: in cases where arch_get_random_seed_long() is backed
> > by an instruction that actually goes back to a shared hardware entropy
> > source (such as RNDRRS on ARM), we will end up hitting it hundreds of
> > times per second.
> >
> > So let's drop the call to arch_get_random_seed_long() from
> > add_interrupt_randomness(), and instead, rely on crng_reseed() to call
> > the arch hook to get random seed material from the platform.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/char/random.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 2a41b21623ae..a9c393c1466d 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1261,8 +1261,6 @@ void add_interrupt_randomness(int irq, int irq_flags)
> >         cycles_t                cycles = random_get_entropy();
> >         __u32                   c_high, j_high;
> >         __u64                   ip;
> > -       unsigned long           seed;
> > -       int                     credit = 0;
> >
> >         if (cycles == 0)
> >                 cycles = get_reg(fast_pool, regs);
> > @@ -1298,23 +1296,12 @@ void add_interrupt_randomness(int irq, int irq_flags)
> >
> >         fast_pool->last = now;
> >         __mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
> > -
> > -       /*
> > -        * If we have architectural seed generator, produce a seed and
> > -        * add it to the pool.  For the sake of paranoia don't let the
> > -        * architectural seed generator dominate the input from the
> > -        * interrupt noise.
> > -        */
> > -       if (arch_get_random_seed_long(&seed)) {
> > -               __mix_pool_bytes(r, &seed, sizeof(seed));
> > -               credit = 1;
> > -       }
> >         spin_unlock(&r->lock);
> >
> >         fast_pool->count = 0;
> >
> >         /* award one bit for the contents of the fast pool */
> > -       credit_entropy_bits(r, credit + 1);
> > +       credit_entropy_bits(r, 1);
> >  }
> >  EXPORT_SYMBOL_GPL(add_interrupt_randomness);

Looks reasonable to me.  The CRNG state already gets XOR'ed with the output of
arch_get_random_seed_long() each time the CRNG is reseeded.  Calling
arch_get_random_seed_long() here too isn't necessary, and it's not really
appropriate to repeatedly call it during interrupt handling, as you point out.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
