Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDE2D0B86
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLGINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgLGINL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:13:11 -0500
X-Gm-Message-State: AOAM533M0ghu2QmWfDuWA8jvbnUlxmqPB7YwtpUquWlaMhy2zWB4FnSJ
        5tsr3Rm1PKOYkR8AHavp50M/hQlCEc4t89ZHdVw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607328750;
        bh=2hUhQnF9l1LImQjnWjv94em5qn5VQEOpywTRkx/c3rQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pq5zKReJjLJNDItQxr3EWe1E+aTcDfU88/QPu367q6jR5dpiE4ehxqVm5K9gosWR/
         c728tSYqeGv9SIR8tif4Z3Ln+pJPu5uVs92cpjPfIld5ofLPmjiFnQolEvxtUAhuBl
         HCvfeL5kwj0oElI1O++q15patuycAqWxTNIYWzonXAl6w8x2EBb15gg29CsOSxorO2
         cLz0D8rxzMTGWIurM2YPj86or3BXSg4XORI9o4PXmLIkz5pf8neZlEhtJ/DFGU6XdS
         vPNLE1ZCYPxNX45BATLHsgPu0OMkH6lA+Ou/v4UZ2CDWmwvszGeapPL9ue1F6mJcT7
         C8IlW77Iq70eg==
X-Google-Smtp-Source: ABdhPJxsGLcuJMWWYGaOAycAe+OE+3lfO+Oalfp0NmdNwhvlrHlSZfNjo21rjvdvJ8sfe5Ca8F2jCdFZhbVK1pLhz9M=
X-Received: by 2002:aca:dd0b:: with SMTP id u11mr11665377oig.47.1607328749431;
 Mon, 07 Dec 2020 00:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <X7dB9GCUeHa+Hosn@sol.localdomain> <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
In-Reply-To: <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Dec 2020 09:12:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFp5dK+qnx3T6hyZK8GLcHg=U835X1pf88PbSbgq3Q_Hg@mail.gmail.com>
Message-ID: <CAMj1kXFp5dK+qnx3T6hyZK8GLcHg=U835X1pf88PbSbgq3Q_Hg@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 13:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (+ Jason)
>
> On Fri, 20 Nov 2020 at 05:11, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Nov 11, 2020 at 09:19:37AM +0100, Ard Biesheuvel wrote:
> > > (+ Eric)
> > >
> > > On Thu, 5 Nov 2020 at 16:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > When reseeding the CRNG periodically, arch_get_random_seed_long() is
> > > > called to obtain entropy from an architecture specific source if one
> > > > is implemented. In most cases, these are special instructions, but in
> > > > some cases, such as on ARM, we may want to back this using firmware
> > > > calls, which are considerably more expensive.
> > > >
> > > > Another call to arch_get_random_seed_long() exists in the CRNG driver,
> > > > in add_interrupt_randomness(), which collects entropy by capturing
> > > > inter-interrupt timing and relying on interrupt jitter to provide
> > > > random bits. This is done by keeping a per-CPU state, and mixing in
> > > > the IRQ number, the cycle counter and the return address every time an
> > > > interrupt is taken, and mixing this per-CPU state into the entropy pool
> > > > every 64 invocations, or at least once per second. The entropy that is
> > > > gathered this way is credited as 1 bit of entropy. Every time this
> > > > happens, arch_get_random_seed_long() is invoked, and the result is
> > > > mixed in as well, and also credited with 1 bit of entropy.
> > > >
> > > > This means that arch_get_random_seed_long() is called at least once
> > > > per second on every CPU, which seems excessive, and doesn't really
> > > > scale, especially in a virtualization scenario where CPUs may be
> > > > oversubscribed: in cases where arch_get_random_seed_long() is backed
> > > > by an instruction that actually goes back to a shared hardware entropy
> > > > source (such as RNDRRS on ARM), we will end up hitting it hundreds of
> > > > times per second.
> > > >
> > > > So let's drop the call to arch_get_random_seed_long() from
> > > > add_interrupt_randomness(), and instead, rely on crng_reseed() to call
> > > > the arch hook to get random seed material from the platform.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  drivers/char/random.c | 15 +--------------
> > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > >
> > > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > > index 2a41b21623ae..a9c393c1466d 100644
> > > > --- a/drivers/char/random.c
> > > > +++ b/drivers/char/random.c
> > > > @@ -1261,8 +1261,6 @@ void add_interrupt_randomness(int irq, int irq_flags)
> > > >         cycles_t                cycles = random_get_entropy();
> > > >         __u32                   c_high, j_high;
> > > >         __u64                   ip;
> > > > -       unsigned long           seed;
> > > > -       int                     credit = 0;
> > > >
> > > >         if (cycles == 0)
> > > >                 cycles = get_reg(fast_pool, regs);
> > > > @@ -1298,23 +1296,12 @@ void add_interrupt_randomness(int irq, int irq_flags)
> > > >
> > > >         fast_pool->last = now;
> > > >         __mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
> > > > -
> > > > -       /*
> > > > -        * If we have architectural seed generator, produce a seed and
> > > > -        * add it to the pool.  For the sake of paranoia don't let the
> > > > -        * architectural seed generator dominate the input from the
> > > > -        * interrupt noise.
> > > > -        */
> > > > -       if (arch_get_random_seed_long(&seed)) {
> > > > -               __mix_pool_bytes(r, &seed, sizeof(seed));
> > > > -               credit = 1;
> > > > -       }
> > > >         spin_unlock(&r->lock);
> > > >
> > > >         fast_pool->count = 0;
> > > >
> > > >         /* award one bit for the contents of the fast pool */
> > > > -       credit_entropy_bits(r, credit + 1);
> > > > +       credit_entropy_bits(r, 1);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(add_interrupt_randomness);
> >
> > Looks reasonable to me.  The CRNG state already gets XOR'ed with the output of
> > arch_get_random_seed_long() each time the CRNG is reseeded.  Calling
> > arch_get_random_seed_long() here too isn't necessary, and it's not really
> > appropriate to repeatedly call it during interrupt handling, as you point out.
> >
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> >
> > - Eric

Ping?
