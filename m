Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6C2B62F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgKQNd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgKQNdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:33:21 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659C02078E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605620001;
        bh=FNUMtUFr2gxSIUeoSoFkfzUvq7YGPvz+XCfemlIQIAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LLloAgMGPWy91D8Y4ee412VaiCmoj3pC4+2SLtgPrMG5nYwq9SmNLMNU7ZCD/zfMf
         SzkM4JXJ+ZSI+rW8mH1mgroaDREOQi8gNh+Fa+Ki8wgRmoG012ZPjscxUoiShwLC0o
         y/d99XNK3HuxqgAgiesuPzjRMn79zlUzJJoVrLVw=
Received: by mail-oi1-f174.google.com with SMTP id c80so22565804oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:33:21 -0800 (PST)
X-Gm-Message-State: AOAM530fyfVoF5l5rNsV6mvSvQVauToLOgTfzkG8eJBfBGDeyHVwJzva
        GQXdQgBmlBOTEeumpmZs+xaFHgs/tfOoVEPB7IY=
X-Google-Smtp-Source: ABdhPJwOnPvX+BNtVwZ97OrxVD0rtgmW87x9HXG8AE2Ywt1B6SDyPwGbKbuLAl1rzsviKGVVXrMB4fIB/Ggen5lujz0=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr2367095oib.33.1605620000524;
 Tue, 17 Nov 2020 05:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
In-Reply-To: <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Nov 2020 14:33:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEg+22pejvof-p_z9uxNnf4yv+4ohAsJAo_LmtQ_+Bfmg@mail.gmail.com>
Message-ID: <CAMj1kXEg+22pejvof-p_z9uxNnf4yv+4ohAsJAo_LmtQ_+Bfmg@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>
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

On Wed, 11 Nov 2020 at 09:19, Ard Biesheuvel <ardb@kernel.org> wrote:
>
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
> >
> > --
> > 2.17.1
> >

Ping?
