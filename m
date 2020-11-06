Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6692A988F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgKFPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:31:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgKFPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:31:05 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFA622228
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604676663;
        bh=6k23W7n1hqE5DTj7u+KieMAY+BhStl2vVGVq76+oF+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+JGFQG6CNXM1vo+BZ40tw+14JcCBdsP7Oclrt6znYXzEYNncpGHPpyUAbn6Ik3oY
         awATx8S3o5fOhk3BgHE7cYZ3jDVmt2fTRsaEBVD3KWWg+6dQnDt044QkD1HSn5ytTb
         qUwT+c3vn6wS2KYMW6YVRsXmmADbPajNikyeOyXE=
Received: by mail-oo1-f51.google.com with SMTP id l20so415914oot.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 07:31:03 -0800 (PST)
X-Gm-Message-State: AOAM532qDyVJ0NMn4t711jX7Givh9RC+TLvzflQtRTiLPhkhBqKE7NC8
        mNDP6G9q878nFe1eziuCi3XQ6ZVzemhYl9yc/rg=
X-Google-Smtp-Source: ABdhPJz5nB84yGzY7sSYQTnno9bchEHa6eOOd2pf3A5r1xemkxAhXhr2yf/NvJm4s71rwWXqG8Lm3uwJhu5poLAyNzU=
X-Received: by 2002:a4a:8928:: with SMTP id f37mr1650527ooi.41.1604676662265;
 Fri, 06 Nov 2020 07:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-4-andre.przywara@arm.com> <7b36daa49c78d60dc788bbb3c9c1bdaa@misterjones.org>
In-Reply-To: <7b36daa49c78d60dc788bbb3c9c1bdaa@misterjones.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 Nov 2020 16:30:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHfRpA906eDq6-yo-FbhvNbXYa5vs1xhAr7zG43VTP_QQ@mail.gmail.com>
Message-ID: <CAMj1kXHfRpA906eDq6-yo-FbhvNbXYa5vs1xhAr7zG43VTP_QQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ARM: implement support for SMCCC TRNG entropy source
To:     Marc Zyngier <maz@misterjones.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 16:30, Marc Zyngier <maz@misterjones.org> wrote:
>
> On 2020-11-05 12:56, Andre Przywara wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Implement arch_get_random_seed_*() for ARM based on the firmware
> > or hypervisor provided entropy source described in ARM DEN0098.
> >
> > This will make the kernel's random number generator consume entropy
> > provided by this interface, at early boot, and periodically at
> > runtime when reseeding.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > [Andre: rework to be initialised by the SMCCC firmware driver]
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/Kconfig                  |  4 ++
> >  arch/arm/include/asm/archrandom.h | 64 +++++++++++++++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index fe2f17eb2b50..06fda4f954fd 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1667,6 +1667,10 @@ config STACKPROTECTOR_PER_TASK
> >         Enable this option to switch to a different method that uses a
> >         different canary value for each task.
> >
> > +config ARCH_RANDOM
> > +     def_bool y
> > +     depends on HAVE_ARM_SMCCC
> > +
> >  endmenu
> >
> >  menu "Boot options"
> > diff --git a/arch/arm/include/asm/archrandom.h
> > b/arch/arm/include/asm/archrandom.h
> > index a8e84ca5c2ee..f3e96a5b65f8 100644
> > --- a/arch/arm/include/asm/archrandom.h
> > +++ b/arch/arm/include/asm/archrandom.h
> > @@ -2,9 +2,73 @@
> >  #ifndef _ASM_ARCHRANDOM_H
> >  #define _ASM_ARCHRANDOM_H
> >
> > +#ifdef CONFIG_ARCH_RANDOM
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/kernel.h>
> > +
> > +#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
> > +
> > +extern bool smccc_trng_available;
> > +
> > +static inline bool __init smccc_probe_trng(void)
> > +{
> > +     struct arm_smccc_res res;
> > +
> > +     arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
> > +     if ((s32)res.a0 < 0)
> > +             return false;
> > +     if (res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION) {
> > +             /* double check that the 32-bit flavor is available */
> > +             arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_FEATURES,
> > +                                  ARM_SMCCC_TRNG_RND32,
> > +                                  &res);
> > +             if ((s32)res.a0 >= 0)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static inline bool __must_check arch_get_random_long(unsigned long *v)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool __must_check arch_get_random_int(unsigned int *v)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool __must_check arch_get_random_seed_long(unsigned
> > long *v)
> > +{
> > +     struct arm_smccc_res res;
> > +
> > +     if (smccc_trng_available) {
> > +             arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND32, 8 * sizeof(*v), &res);
> > +
> > +             if (res.a0 != 0)
> > +                     return false;
> > +
> > +             *v = res.a3;
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static inline bool __must_check arch_get_random_seed_int(unsigned int
> > *v)
> > +{
> > +     return arch_get_random_seed_long((unsigned long *)v);
>
> I don't think this cast is safe. At least not on 64bit.

True, but this is arch/arm
