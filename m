Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC062B93C8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKSNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgKSNls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:41:48 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E711A246AA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605793307;
        bh=9O8JPvEoprFeeaXOpqPUadNdKTFI9oBlMrMXK00ChI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qfy27wPYWLgm4Zy3VvVfpA+DGsIjLvnT8P8fWTBqtwSFIeKZ4RZoybqgch8UF7DzU
         aj51T3m18bx7BflqHH00KWHpEEuBwbPuNa+yKOdp0eqr6u1LWj+a9cv0/q4sEksdRp
         xtd3L2090Q0Yuuxg7rHjBR2LVo3UD5EATNlKYxiA=
Received: by mail-oi1-f178.google.com with SMTP id k26so6356571oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:41:46 -0800 (PST)
X-Gm-Message-State: AOAM530598LxtpqVoV/f+4AGYnRJfmMZeGM5Xc0Y1ZoCxlCv9T+w9lPd
        fY5VGxido4UnLByqltPTjX16+uQ2gaWiXYN4DCk=
X-Google-Smtp-Source: ABdhPJzlk8WOe6gGnaue7l6s6kAkAYGjtGZxJ1XCUSxUCtC/5rRnyw1ofeqtfdLzfQMS6GFudb+FtXtrfjOXBPZ0QoQ=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr2876715oib.33.1605793306082;
 Thu, 19 Nov 2020 05:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com> <20201113182435.64015-5-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-5-andre.przywara@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 Nov 2020 14:41:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMzSKO7yMRSz55Au_kRr=zLT_2tZA_+JNDfJ+osfjkKg@mail.gmail.com>
Message-ID: <CAMj1kXFMzSKO7yMRSz55Au_kRr=zLT_2tZA_+JNDfJ+osfjkKg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: Add support for SMCCC TRNG entropy source
To:     Andre Przywara <andre.przywara@arm.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 at 19:24, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098, defines an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
> This can be discovered via the SMCCC >=v1.1 interface, and provides
> up to 192 bits of entropy per call.
>
> Hook this SMC call into arm64's arch_get_random_*() implementation,
> coming to the rescue when the CPU does not implement the ARM v8.5 RNG
> system registers.
>
> For the detection, we piggy back on the PSCI/SMCCC discovery (which gives
> us the conduit to use (hvc/smc)), then try to call the
> ARM_SMCCC_TRNG_VERSION function, which returns -1 if this interface is
> not implemented.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/include/asm/archrandom.h | 69 ++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> index abe07c21da8e..fe34bfd30caa 100644
> --- a/arch/arm64/include/asm/archrandom.h
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -4,13 +4,24 @@
>
>  #ifdef CONFIG_ARCH_RANDOM
>
> +#include <linux/arm-smccc.h>
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
>  #include <asm/cpufeature.h>
>
> +#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
> +
> +extern bool smccc_trng_available;
> +
>  static inline bool __init smccc_probe_trng(void)
>  {
> -       return false;
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
> +       if ((s32)res.a0 < 0)
> +               return false;
> +
> +       return res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION;
>  }
>
>  static inline bool __arm64_rndr(unsigned long *v)
> @@ -43,26 +54,52 @@ static inline bool __must_check arch_get_random_int(unsigned int *v)
>
>  static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
> +       struct arm_smccc_res res;
> +
>         /*
>          * Only support the generic interface after we have detected
>          * the system wide capability, avoiding complexity with the
>          * cpufeature code and with potential scheduling between CPUs
>          * with and without the feature.
>          */
> -       if (!cpus_have_const_cap(ARM64_HAS_RNG))
> -               return false;
> +       if (cpus_have_const_cap(ARM64_HAS_RNG))
> +               return __arm64_rndr(v);
>
> -       return __arm64_rndr(v);
> -}
> +       if (smccc_trng_available) {
> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> +               if ((int)res.a0 < 0)
> +                       return false;
>
> +               *v = res.a3;
> +               return true;
> +       }
> +
> +       return false;
> +}
>

I think we should be more rigorous here in how we map the concepts of
random seeds and random numbers onto the various sources.

First of all, assuming my patch dropping the call to
arch_get_random_seed_long() from add_interrupt_randomness() gets
accepted, we should switch to RNDRRS here, and implement the non-seed
variants using RNDR.

However, this is still semantically inaccurate: RNDRRS does not return
a random *seed*, it returns a number drawn from a freshly seeded
pseudo-random sequence. This means that the TRNG interface, if
implemented, is a better choice, and so we should try it first. Note
that on platforms that don't implement both, only one of these will be
available in the first place. But on platforms that *do* implement
both, the firmware interface may actually be less wasteful in terms of
resources: the TRNG interface returns every bit drawn from the
underlying entropy source, whereas RNDRRS uses ~500 bits of entropy to
reseed a DRBG that gets used only once to draw a single 64-bit number.
And the cost of the SMCCC call in terms of CPU time is charged to the
caller, which is appropriate here.

Then, I don't think we should ever return false without even trying if
RNDRRS is available if the SMCCC invocation fails.

Something like this perhaps?

if (smccc_trng_available) {
  arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
  if ((int)res.a0 >= 0) {
    *v = res.a3;
    return true;
  }
}

if (cpus_have_const_cap(ARM64_HAS_RNG))
   return __arm64_rndrrs(v);

return false;

(and something similar 2x below)


>  static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
> +       struct arm_smccc_res res;
>         unsigned long val;
> -       bool ok = arch_get_random_seed_long(&val);
>
> -       *v = val;
> -       return ok;
> +       if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> +               if (arch_get_random_seed_long(&val)) {
> +                       *v = val;
> +                       return true;
> +               }
> +               return false;
> +       }
> +
> +       if (smccc_trng_available) {
> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 32, &res);
> +               if ((int)res.a0 < 0)
> +                       return false;
> +
> +               *v = res.a3 & GENMASK(31, 0);
> +               return true;
> +       }
> +
> +       return false;
>  }
>
>  static inline bool __init __early_cpu_has_rndr(void)
> @@ -77,10 +114,20 @@ arch_get_random_seed_long_early(unsigned long *v)
>  {
>         WARN_ON(system_state != SYSTEM_BOOTING);
>
> -       if (!__early_cpu_has_rndr())
> -               return false;
> +       if (__early_cpu_has_rndr())
> +               return __arm64_rndr(v);
> +
> +       if (smccc_trng_available) {
> +               struct arm_smccc_res res;
>
> -       return __arm64_rndr(v);
> +               arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> +               if ((int)res.a0 >= 0) {
> +                       *v = res.a3;
> +                       return true;
> +               }
> +       }
> +
> +       return false;
>  }
>  #define arch_get_random_seed_long_early arch_get_random_seed_long_early
>
> --
> 2.17.1
>
