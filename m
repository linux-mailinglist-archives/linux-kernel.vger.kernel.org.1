Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFC32AEE67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKKKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgKKKFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:05:41 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9940B20729
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605089140;
        bh=JMJDdRzH3QwjOuXDoBx7SvWwgW4sbLkHYJkkc39eVnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v/nJ0O7/qyH5mE+/znROZYqG+O4zm+MPuwvVFCjjDzAN6wygJnXCtfKlxcLM5aaBx
         X/RBlrJs1I7FTIcu9e6QAOzAJh5j7rYrLPr3TbdT2h/K5rYICk1jxzr73UKhSKkrNt
         eqnHBb5lXsKZcnu94DqccGvdjCI4OBcYCqNLG5s4=
Received: by mail-ot1-f54.google.com with SMTP id a15so1623290otf.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:05:40 -0800 (PST)
X-Gm-Message-State: AOAM533xfseVAePY/R9gClqIiqVxpDzTCHPLr5aBlKPISYW/O1DyOfyV
        2QiGx0SE9Ol0woT/H0VVLio1vyIFSI9v8q75h6I=
X-Google-Smtp-Source: ABdhPJwesThzIC4EG/7rHaew6jOU6q98im6yKnr0YIGUDrxwbPOYxwQIhAUwI9HFfL6Hx7UC9xe1NUWp1uyhriw7hso=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr16523361otk.108.1605089139764;
 Wed, 11 Nov 2020 02:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <0b0d47d9-76a5-723f-6642-d5ddadce7f94@arm.com>
In-Reply-To: <0b0d47d9-76a5-723f-6642-d5ddadce7f94@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Nov 2020 11:05:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHBcb_UxeLs23XZt0VvNM-8JqchutU+qDwdWJm-WQpt5Q@mail.gmail.com>
Message-ID: <CAMj1kXHBcb_UxeLs23XZt0VvNM-8JqchutU+qDwdWJm-WQpt5Q@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 at 10:45, Andr=C3=A9 Przywara <andre.przywara@arm.com> =
wrote:
>
> On 11/11/2020 08:19, Ard Biesheuvel wrote:
>
> Hi,
>
> > (+ Eric)
> >
> > On Thu, 5 Nov 2020 at 16:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> When reseeding the CRNG periodically, arch_get_random_seed_long() is
> >> called to obtain entropy from an architecture specific source if one
> >> is implemented. In most cases, these are special instructions, but in
> >> some cases, such as on ARM, we may want to back this using firmware
> >> calls, which are considerably more expensive.
> >>
> >> Another call to arch_get_random_seed_long() exists in the CRNG driver,
> >> in add_interrupt_randomness(), which collects entropy by capturing
> >> inter-interrupt timing and relying on interrupt jitter to provide
> >> random bits. This is done by keeping a per-CPU state, and mixing in
> >> the IRQ number, the cycle counter and the return address every time an
> >> interrupt is taken, and mixing this per-CPU state into the entropy poo=
l
> >> every 64 invocations, or at least once per second. The entropy that is
> >> gathered this way is credited as 1 bit of entropy. Every time this
> >> happens, arch_get_random_seed_long() is invoked, and the result is
> >> mixed in as well, and also credited with 1 bit of entropy.
> >>
> >> This means that arch_get_random_seed_long() is called at least once
> >> per second on every CPU, which seems excessive, and doesn't really
> >> scale, especially in a virtualization scenario where CPUs may be
> >> oversubscribed: in cases where arch_get_random_seed_long() is backed
> >> by an instruction that actually goes back to a shared hardware entropy
> >> source (such as RNDRRS on ARM), we will end up hitting it hundreds of
> >> times per second.
>
> May I ask why this should be a particular problem? Form what I gathered
> on the web, it seems like most h/w RNGs have a capacity of multiple
> MBit/s. Wikipedia [1] suggests that the x86 CPU instructions generate at
> least 20 Mbit/s (worst case: AMD's 2500 cycles @ 800 MHz), and I
> measured around 78 Mbit/s with the raw entropy source on my Juno
> (possibly even limited by slow MMIO).
> So it seems unlikely that a few kbit/s drain the hardware entropy source.
>
> If we consider this interface comparably cheap, should we then not try
> to plug the Arm firmware interface into this?
>

I'm not sure I follow. Are you saying we should not wire up a
comparatively expensive firmware interface to
arch_get_random_seed_long() because we currently assume it is backed
by something cheap?

Because doing so would add significantly to the cost. Also note that a
firmware interface would permit other ways of gathering entropy that
are not necessarily backed by a dedicated high bandwidth noise source
(and we already have examples of this)


> I am not against this patch, actually am considering this a nice
> cleanup, to separate interrupt generated entropy from other sources.
> Especially since we call arch_get_random_seed_long() under a spinlock her=
e.
> But I am curious about the expectations from arch_get_random in general.
>

I think it is reasonable to clean this up a little bit. A random
*seed* is not the same thing as a random number, and given that we
expose both interfaces, it makes sense to permit the seed variant to
be more costly, and only use it as intended (i.e., to seed a random
number generator)

> >> So let's drop the call to arch_get_random_seed_long() from
> >> add_interrupt_randomness(), and instead, rely on crng_reseed() to call
> >> the arch hook to get random seed material from the platform.
>
> So I tested this and it works as expected: I see some calls on
> initialisation, then a handful of calls every few seconds from the
> periodic reseeding. The large number of calls every second are gone.
>

Excellent, thanks for confirming.

> >>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Since the above questions are unrelated to this particular patch:
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
>
> Cheers,
> Andre
>
> [1] https://en.wikipedia.org/wiki/RDRAND#Performance
>
> >> ---
> >>  drivers/char/random.c | 15 +--------------
> >>  1 file changed, 1 insertion(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/char/random.c b/drivers/char/random.c
> >> index 2a41b21623ae..a9c393c1466d 100644
> >> --- a/drivers/char/random.c
> >> +++ b/drivers/char/random.c
> >> @@ -1261,8 +1261,6 @@ void add_interrupt_randomness(int irq, int irq_f=
lags)
> >>         cycles_t                cycles =3D random_get_entropy();
> >>         __u32                   c_high, j_high;
> >>         __u64                   ip;
> >> -       unsigned long           seed;
> >> -       int                     credit =3D 0;
> >>
> >>         if (cycles =3D=3D 0)
> >>                 cycles =3D get_reg(fast_pool, regs);
> >> @@ -1298,23 +1296,12 @@ void add_interrupt_randomness(int irq, int irq=
_flags)
> >>
> >>         fast_pool->last =3D now;
> >>         __mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool))=
;
> >> -
> >> -       /*
> >> -        * If we have architectural seed generator, produce a seed and
> >> -        * add it to the pool.  For the sake of paranoia don't let the
> >> -        * architectural seed generator dominate the input from the
> >> -        * interrupt noise.
> >> -        */
> >> -       if (arch_get_random_seed_long(&seed)) {
> >> -               __mix_pool_bytes(r, &seed, sizeof(seed));
> >> -               credit =3D 1;
> >> -       }
> >>         spin_unlock(&r->lock);
> >>
> >>         fast_pool->count =3D 0;
> >>
> >>         /* award one bit for the contents of the fast pool */
> >> -       credit_entropy_bits(r, credit + 1);
> >> +       credit_entropy_bits(r, 1);
> >>  }
> >>  EXPORT_SYMBOL_GPL(add_interrupt_randomness);
> >>
> >> --
> >> 2.17.1
> >>
>
