Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD02BA94C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKTLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:36:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgKTLgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:36:25 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4D122264
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605872184;
        bh=l22FqpfMhdHqL8kobUx9fWCDmrCGA9joxTifiiwbs0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YmPQnNjYAb8lvWSlBh2Si9Hz3UmiW5buL12A4zzzAP1pU0QzW2xoVR9f4DC1Aytac
         bZnGX+lkw8APOc2WzHu0CD20rhrBOTCX+pB1kqebS9bLsozzdyB9ROBxQDP1DAsDpE
         jqbMa0BhSFlRkBo0vcukvI4vPKSSZiS+lAFjk0lE=
Received: by mail-oi1-f181.google.com with SMTP id k26so10109843oiw.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:36:24 -0800 (PST)
X-Gm-Message-State: AOAM532vvENxLLO5TJiMHtx8K2/RbMbHL1Al4pMbotOf9ZtV8krchnxF
        XMl8DknYJCPeQ0HNRjGqe0BWy2JwiSzC1hdfyWw=
X-Google-Smtp-Source: ABdhPJy4smxIDFAdZ/MHfjEYx55tEaD5yvhfyzqfrLOTKir4MlCRoGlCVpDauB4Nb3Y00CqMCGTsiijWE6rrEiUZ0yc=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr6134989oib.33.1605872183139;
 Fri, 20 Nov 2020 03:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com>
 <20201113182435.64015-5-andre.przywara@arm.com> <CAMj1kXFMzSKO7yMRSz55Au_kRr=zLT_2tZA_+JNDfJ+osfjkKg@mail.gmail.com>
 <ecff0731-b007-9e7c-3d1d-ae9bc7b1c92e@arm.com>
In-Reply-To: <ecff0731-b007-9e7c-3d1d-ae9bc7b1c92e@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 20 Nov 2020 12:36:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEH0boGErYbBNy3F9h9YYwRbumVeeLV94=1QfZcS6ffdg@mail.gmail.com>
Message-ID: <CAMj1kXEH0boGErYbBNy3F9h9YYwRbumVeeLV94=1QfZcS6ffdg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: Add support for SMCCC TRNG entropy source
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 11:52, Andr=C3=A9 Przywara <andre.przywara@arm.com> =
wrote:
>
> On 19/11/2020 13:41, Ard Biesheuvel wrote:
>
> Hi,
>
> > On Fri, 13 Nov 2020 at 19:24, Andre Przywara <andre.przywara@arm.com> w=
rote:
> >>
> >> The ARM architected TRNG firmware interface, described in ARM spec
> >> DEN0098, defines an ARM SMCCC based interface to a true random number
> >> generator, provided by firmware.
> >> This can be discovered via the SMCCC >=3Dv1.1 interface, and provides
> >> up to 192 bits of entropy per call.
> >>
> >> Hook this SMC call into arm64's arch_get_random_*() implementation,
> >> coming to the rescue when the CPU does not implement the ARM v8.5 RNG
> >> system registers.
> >>
> >> For the detection, we piggy back on the PSCI/SMCCC discovery (which gi=
ves
> >> us the conduit to use (hvc/smc)), then try to call the
> >> ARM_SMCCC_TRNG_VERSION function, which returns -1 if this interface is
> >> not implemented.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  arch/arm64/include/asm/archrandom.h | 69 ++++++++++++++++++++++++----=
-
> >>  1 file changed, 58 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/=
asm/archrandom.h
> >> index abe07c21da8e..fe34bfd30caa 100644
> >> --- a/arch/arm64/include/asm/archrandom.h
> >> +++ b/arch/arm64/include/asm/archrandom.h
> >> @@ -4,13 +4,24 @@
> >>
> >>  #ifdef CONFIG_ARCH_RANDOM
> >>
> >> +#include <linux/arm-smccc.h>
> >>  #include <linux/bug.h>
> >>  #include <linux/kernel.h>
> >>  #include <asm/cpufeature.h>
> >>
> >> +#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
> >> +
> >> +extern bool smccc_trng_available;
> >> +
> >>  static inline bool __init smccc_probe_trng(void)
> >>  {
> >> -       return false;
> >> +       struct arm_smccc_res res;
> >> +
> >> +       arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
> >> +       if ((s32)res.a0 < 0)
> >> +               return false;
> >> +
> >> +       return res.a0 >=3D ARM_SMCCC_TRNG_MIN_VERSION;
> >>  }
> >>
> >>  static inline bool __arm64_rndr(unsigned long *v)
> >> @@ -43,26 +54,52 @@ static inline bool __must_check arch_get_random_in=
t(unsigned int *v)
> >>
> >>  static inline bool __must_check arch_get_random_seed_long(unsigned lo=
ng *v)
> >>  {
> >> +       struct arm_smccc_res res;
> >> +
> >>         /*
> >>          * Only support the generic interface after we have detected
> >>          * the system wide capability, avoiding complexity with the
> >>          * cpufeature code and with potential scheduling between CPUs
> >>          * with and without the feature.
> >>          */
> >> -       if (!cpus_have_const_cap(ARM64_HAS_RNG))
> >> -               return false;
> >> +       if (cpus_have_const_cap(ARM64_HAS_RNG))
> >> +               return __arm64_rndr(v);
> >>
> >> -       return __arm64_rndr(v);
> >> -}
> >> +       if (smccc_trng_available) {
> >> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> >> +               if ((int)res.a0 < 0)
> >> +                       return false;
> >>
> >> +               *v =3D res.a3;
> >> +               return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >>
> >
> > I think we should be more rigorous here in how we map the concepts of
> > random seeds and random numbers onto the various sources.
> >
> > First of all, assuming my patch dropping the call to
> > arch_get_random_seed_long() from add_interrupt_randomness() gets
> > accepted, we should switch to RNDRRS here, and implement the non-seed
> > variants using RNDR.
>
> I agree (and have a patch ready), but that seems independent from this
> series.
>

Well, it will conflict, but other than that, I agree it is orthogonal.

> > However, this is still semantically inaccurate: RNDRRS does not return
> > a random *seed*, it returns a number drawn from a freshly seeded
> > pseudo-random sequence. This means that the TRNG interface, if
> > implemented, is a better choice, and so we should try it first. Note
> > that on platforms that don't implement both, only one of these will be
> > available in the first place. But on platforms that *do* implement
> > both, the firmware interface may actually be less wasteful in terms of
> > resources: the TRNG interface returns every bit drawn from the
> > underlying entropy source, whereas RNDRRS uses ~500 bits of entropy to
> > reseed a DRBG that gets used only once to draw a single 64-bit number.
>
> I am not sure I share your enthusiasm about the quality of the actual
> TRNG firmware implementations, but we can go with this for now.
> Maybe if we see bad implementations in the future, we can revisit this,
> and have some tuneables? Or a command line option to ignore the SMCCC
> interface? Or use the UUID mechanism for that?
>

This is not about good or bad implementations. It is about mapping the
OS's request for a seed onto a privileged entropy source if one is
available, instead of onto a non-privileged instruction which is
documented as producing the output of a pseudo random number
generator, not of an entropy source. And again, it remains to be seen
whether any systems will turn up that implement both, but if they do,
it likely means that the SMC call provides access to the entropy
source that is also used to seed the RNDRRS DRBG, and in this case,
the SMC call is more appropriate.

> > And the cost of the SMCCC call in terms of CPU time is charged to the
> > caller, which is appropriate here.
>
> This still leaves the problem that the core might be stuck in EL3 for an
> unknown period of time, impeding our realtime efforts.

I agree that there may be quality of implementation issues here, but
the call is documented as non-blocking, i.e., it either returns the
result immediately, or it signals failure.

> Do we have some ball park number of a number of cycles spent in EL3
> still being acceptable? That could serve as a guideline for firmware
> implementations?
>

Realtime is typically about having a bounded worst case, and so I
think the non-blocking requirement is what is most important here. How
many cycles or nanoseconds are spent exactly is of a lesser concern
IMO.

> > Then, I don't think we should ever return false without even trying if
> > RNDRRS is available if the SMCCC invocation fails.
>
> That's a good point.
>
> > Something like this perhaps?
> >
> > if (smccc_trng_available) {
> >   arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> >   if ((int)res.a0 >=3D 0) {
> >     *v =3D res.a3;
> >     return true;
> >   }
> > }
>
> yeah, the fall-through here is a good idea.
>
> >
> > if (cpus_have_const_cap(ARM64_HAS_RNG))
> >    return __arm64_rndrrs(v);
> >
> > return false;
>
> So I wonder if we have a trade-off here between the performance of the
> RNDRRS entropy source and the latency of the firmware implementation.
> If the RNDR entropy source delivers Mbits/s (the Juno h/w definitely
> does), we might just not care about throwing away some (or even the
> majority) of it.
>

The important distinction here is that you can only waste your own CPU
cycles, but you can potentially waste a shared resource by hitting on
RNDRRS (and the architecture does not give any guidance whatsoever on
the permitted failure rate of RNDRRS)

But perhaps we should save this discussion for another time, when we
have actual hardware to test this on. In the meantime, I am fine with
the current precedence of RNDR[RS] over the SMC call.

> On the other hand the Juno TRNG hardware for instance spends already
> hundreds of cycles on a single 32-bit MMIO read alone, just to transfer
> the bits into the CPU. Having a rather large pool could avoid paying
> this price on every SMC call, but I don't see a nice way of allowing
> TF-A to fill this pool, when Linux thinks it can spare the time.
>
> So I am a bit uneasy about unconditionally preferring the SMCCC
> implementation over the RNDRRS instruction.
>
> Cheers,
> Andre
>
> > (and something similar 2x below)
> >
> >
> >>  static inline bool __must_check arch_get_random_seed_int(unsigned int=
 *v)
> >>  {
> >> +       struct arm_smccc_res res;
> >>         unsigned long val;
> >> -       bool ok =3D arch_get_random_seed_long(&val);
> >>
> >> -       *v =3D val;
> >> -       return ok;
> >> +       if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> >> +               if (arch_get_random_seed_long(&val)) {
> >> +                       *v =3D val;
> >> +                       return true;
> >> +               }
> >> +               return false;
> >> +       }
> >> +
> >> +       if (smccc_trng_available) {
> >> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 32, &res);
> >> +               if ((int)res.a0 < 0)
> >> +                       return false;
> >> +
> >> +               *v =3D res.a3 & GENMASK(31, 0);
> >> +               return true;
> >> +       }
> >> +
> >> +       return false;
> >>  }
> >>
> >>  static inline bool __init __early_cpu_has_rndr(void)
> >> @@ -77,10 +114,20 @@ arch_get_random_seed_long_early(unsigned long *v)
> >>  {
> >>         WARN_ON(system_state !=3D SYSTEM_BOOTING);
> >>
> >> -       if (!__early_cpu_has_rndr())
> >> -               return false;
> >> +       if (__early_cpu_has_rndr())
> >> +               return __arm64_rndr(v);
> >> +
> >> +       if (smccc_trng_available) {
> >> +               struct arm_smccc_res res;
> >>
> >> -       return __arm64_rndr(v);
> >> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> >> +               if ((int)res.a0 >=3D 0) {
> >> +                       *v =3D res.a3;
> >> +                       return true;
> >> +               }
> >> +       }
> >> +
> >> +       return false;
> >>  }
> >>  #define arch_get_random_seed_long_early arch_get_random_seed_long_ear=
ly
> >>
> >> --
> >> 2.17.1
> >>
>
