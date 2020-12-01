Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8292CA2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgLAMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbgLAMYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:24:50 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DE220870
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606825450;
        bh=bBnrt/qXPq+H01MHvNMWCrKJ7NdoTh2PlKA4hnqr0vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oamBLPTGYBVKgHcGxo4swpudDywxg915icZq6iIxy7vZGrGgXeJxtEL0gNh5xMjbw
         c4t44STSXttX0GTkGGvXoAl1DisbmFfGlIOY5Qo71JYr0lISDhQGjEZ2Aba5fgcVCU
         6JQytp1lZEmg+gZgffbPzKwTE1XlGthk2sAIKE3Q=
Received: by mail-lj1-f171.google.com with SMTP id y10so2548434ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 04:24:09 -0800 (PST)
X-Gm-Message-State: AOAM533lj+/ktVckjpjKQvRH3edIqgyy+X5qRuxfJal8zvLiqyqxOkuj
        XzR5gZR91A2EyMHcn+g3O3aDv5LzPa7dMUnkCws=
X-Google-Smtp-Source: ABdhPJwFK5+905CbgqECOO1cwvLh6rCSUwEu4cRIahJ2fhT+HsmIJLhDNt1D6iZInyBu8GXHMh1ZstaQibTviZg8st0=
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr1110517lja.407.1606825448068;
 Tue, 01 Dec 2020 04:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <X7dB9GCUeHa+Hosn@sol.localdomain>
In-Reply-To: <X7dB9GCUeHa+Hosn@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Dec 2020 13:23:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
Message-ID: <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
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

(+ Jason)

On Fri, 20 Nov 2020 at 05:11, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Nov 11, 2020 at 09:19:37AM +0100, Ard Biesheuvel wrote:
> > (+ Eric)
> >
> > On Thu, 5 Nov 2020 at 16:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > When reseeding the CRNG periodically, arch_get_random_seed_long() is
> > > called to obtain entropy from an architecture specific source if one
> > > is implemented. In most cases, these are special instructions, but in
> > > some cases, such as on ARM, we may want to back this using firmware
> > > calls, which are considerably more expensive.
> > >
> > > Another call to arch_get_random_seed_long() exists in the CRNG driver,
> > > in add_interrupt_randomness(), which collects entropy by capturing
> > > inter-interrupt timing and relying on interrupt jitter to provide
> > > random bits. This is done by keeping a per-CPU state, and mixing in
> > > the IRQ number, the cycle counter and the return address every time an
> > > interrupt is taken, and mixing this per-CPU state into the entropy pool
> > > every 64 invocations, or at least once per second. The entropy that is
> > > gathered this way is credited as 1 bit of entropy. Every time this
> > > happens, arch_get_random_seed_long() is invoked, and the result is
> > > mixed in as well, and also credited with 1 bit of entropy.
> > >
> > > This means that arch_get_random_seed_long() is called at least once
> > > per second on every CPU, which seems excessive, and doesn't really
> > > scale, especially in a virtualization scenario where CPUs may be
> > > oversubscribed: in cases where arch_get_random_seed_long() is backed
> > > by an instruction that actually goes back to a shared hardware entropy
> > > source (such as RNDRRS on ARM), we will end up hitting it hundreds of
> > > times per second.
> > >
> > > So let's drop the call to arch_get_random_seed_long() from
> > > add_interrupt_randomness(), and instead, rely on crng_reseed() to call
> > > the arch hook to get random seed material from the platform.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/char/random.c | 15 +--------------
> > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > index 2a41b21623ae..a9c393c1466d 100644
> > > --- a/drivers/char/random.c
> > > +++ b/drivers/char/random.c
> > > @@ -1261,8 +1261,6 @@ void add_interrupt_randomness(int irq, int irq_flags)
> > >         cycles_t                cycles = random_get_entropy();
> > >         __u32                   c_high, j_high;
> > >         __u64                   ip;
> > > -       unsigned long           seed;
> > > -       int                     credit = 0;
> > >
> > >         if (cycles == 0)
> > >                 cycles = get_reg(fast_pool, regs);
> > > @@ -1298,23 +1296,12 @@ void add_interrupt_randomness(int irq, int irq_flags)
> > >
> > >         fast_pool->last = now;
> > >         __mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
> > > -
> > > -       /*
> > > -        * If we have architectural seed generator, produce a seed and
> > > -        * add it to the pool.  For the sake of paranoia don't let the
> > > -        * architectural seed generator dominate the input from the
> > > -        * interrupt noise.
> > > -        */
> > > -       if (arch_get_random_seed_long(&seed)) {
> > > -               __mix_pool_bytes(r, &seed, sizeof(seed));
> > > -               credit = 1;
> > > -       }
> > >         spin_unlock(&r->lock);
> > >
> > >         fast_pool->count = 0;
> > >
> > >         /* award one bit for the contents of the fast pool */
> > > -       credit_entropy_bits(r, credit + 1);
> > > +       credit_entropy_bits(r, 1);
> > >  }
> > >  EXPORT_SYMBOL_GPL(add_interrupt_randomness);
>
> Looks reasonable to me.  The CRNG state already gets XOR'ed with the output of
> arch_get_random_seed_long() each time the CRNG is reseeded.  Calling
> arch_get_random_seed_long() here too isn't necessary, and it's not really
> appropriate to repeatedly call it during interrupt handling, as you point out.
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
>
> - Eric
