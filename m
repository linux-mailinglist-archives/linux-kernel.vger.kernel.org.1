Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5792F0638
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAJJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 04:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbhAJJqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 04:46:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47F7B238E5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610271940;
        bh=5nn4h4NtHDCXue9VfNHsaZlxU7bxJQfKM7EPyThKV4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jkk+C22tc7csu+FDa3hdEyf1WcpqZ+mzDv0k6r5bB1f5AvFEDE5rD9uPZgoPvjKkc
         2gciLbolidD0pSVNrVvTEHHhLHifZUo3z7eVdDCP5X73bXMwkCO8PnySZMtQ9KmWI8
         XGEM2u+ZParM+h0GnBvTOSwbV5JQlE9X4gk5vC6Z0TeUiv1jnT+cQw1dOPa7+DGwHu
         w0L8RIobKVzRfs4ENAHhPX77id+yjsUmxRX1Q1iNCJmR4vXqjZzCkFXt64q7r6qx1e
         lIJYv31AHj5UNPxMXpek8AXikHqIwJV/Qn2lMRHEPCb56nyOCLjTh3tnmnhh78DdI0
         zN+U7p3h1SIaw==
Received: by mail-oo1-f49.google.com with SMTP id q6so3436590ooo.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 01:45:40 -0800 (PST)
X-Gm-Message-State: AOAM530DREz+8gW5ciy7215M6tzAosGQFeXhpxEtvoqj2/6Am5QZJOCQ
        PnpNEWGLUHBP0B9c61rQwvks0BXA/fBWnDKO6YA=
X-Google-Smtp-Source: ABdhPJxFA2UzPoe3lyfsOlxSV6swiWUEug3nw26cfUR6OzU/woA5RXjgkCsrwp+FCnapmHEEnU2ndvwvqnG9X5o6kcg=
X-Received: by 2002:a4a:bb86:: with SMTP id h6mr37396oop.13.1610271939504;
 Sun, 10 Jan 2021 01:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <CAMj1kXEg+22pejvof-p_z9uxNnf4yv+4ohAsJAo_LmtQ_+Bfmg@mail.gmail.com> <CAMj1kXECsVbO6tqmynSTmu-aGRKKBKSUSE3ZTzJgfCRozmK9Vw@mail.gmail.com>
In-Reply-To: <CAMj1kXECsVbO6tqmynSTmu-aGRKKBKSUSE3ZTzJgfCRozmK9Vw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 10 Jan 2021 10:45:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH2N_e722TiSU6_uUs_arjkBipwUnfD8=xj1etKE11DRQ@mail.gmail.com>
Message-ID: <CAMj1kXH2N_e722TiSU6_uUs_arjkBipwUnfD8=xj1etKE11DRQ@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jan 2021 at 20:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 at 14:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 11 Nov 2020 at 09:19, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
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
> > > >
> > > > --
> > > > 2.17.1
> > > >
> >
> > Ping?
>
> Ping?

Ping again?

Ted,

Acceptance of this patch is now blocking RNG related work that is in
flight for ARM and arm64. [0]

So please shout if you have any objections to this patch, or if you
don't, please ack it so it can be taken through one of the ARM trees.

Thanks,
Ard.

[0] https://lore.kernel.org/kvmarm/20210106103453.152275-1-andre.przywara@arm.com/
