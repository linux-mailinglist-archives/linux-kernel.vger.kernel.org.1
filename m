Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3492B28F5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMXFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMXFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:05:48 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094BB22263
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 23:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605308748;
        bh=rxXZRbWdF7kFIEpjIlgp4JhisxbNWUCpDybad8Epf78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p7cXewQjdUFsjCaMvIsNjMrhUltximm9Trhf+GbCZqgoDpmrqyXLMwpSdPWWkE7VF
         A082URcztNoLO9CPID8NL+L8198O3y9bBPxWfbL7yOlqHdJUb0IBTTppdcKSnHfnam
         J/aT3V06wWmp0GnFM0KNobLQa1gmEofnkmP/77Qc=
Received: by mail-oi1-f175.google.com with SMTP id m143so12222189oig.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 15:05:48 -0800 (PST)
X-Gm-Message-State: AOAM5302+eTJ2wMTx/UexBN+TrDpCcR8qfib0cGa6bNcMx6SQl8DFNvk
        VbUJX+hJo1d7LGDmlusX2jgt8F9YQvSG/K6xIpE=
X-Google-Smtp-Source: ABdhPJx9ux+FpFaYeBgYw09pe+K5GKEwpjUQpJEX1l9QRE0KF2MevwplpUs4/CB6CUT5iCNJT/lyzjNvsYQzLdaA7lQ=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr3157521oib.33.1605308747182;
 Fri, 13 Nov 2020 15:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-1-andre.przywara@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 14 Nov 2020 00:05:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG__RAneq6NwquLiM1ja8O3cepUB6Ovp9aSgy3D_6hN1A@mail.gmail.com>
Message-ID: <CAMj1kXG__RAneq6NwquLiM1ja8O3cepUB6Ovp9aSgy3D_6hN1A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ARM: arm64: Add SMCCC TRNG entropy service
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
> Hi,
>
> an update to v2 with some fixes and a few tweaks. Ard's patch [1] should
> significantly reduce the frequency of arch_get_random_seed_long() calls,
> not sure if that is enough the appease the concerns about the
> potentially long latency of SMC calls. I also dropped the direct
> arch_get_random() call in KVM for the same reason. An alternative could
> be to just use the SMC in the _early() versions, but then we would lose
> the SMCCC entropy source for the periodic reseeds. This could be mitigated
> by using a hwrng driver [2] and rngd.
> The only other non-minor change to v2 is the addition of using the SMCCC
> call in the _early() variant. For a changelog see below.
>
> Sudeep: patch 1/5 is a prerequisite for all other patches, which
> themselves could be considered separate and need to go via different trees.
> If we could agree on that one now and get that merged, it would help the
> handling of the other patches going forward.
>
> Cheers,
> Andre
> ==============================
>
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098[3], defines an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
>
> This series collects all the patches implementing this in various
> places: as a user feeding into the ARCH_RANDOM pool, both for ARM and
> arm64, and as a service provider for KVM guests.
>
> Patch 1 introduces the interface definition used by all three entities.
> Patch 2 prepares the Arm SMCCC firmware driver to probe for the
> interface. This patch is needed to avoid a later dependency on *two*
> patches (there might be a better solution to this problem).
>
> Patch 3 implements the ARM part, patch 4 is the arm64 version.
> The final patch 5 adds support to provide random numbers to KVM guests.
>
> This was tested on:
> - QEMU -kernel (no SMCCC, regression test)
> - Juno w/ prototype of the h/w Trusted RNG support
> - mainline KVM (SMCCC, but no TRNG: regression test)
> - ARM and arm64 KVM guests, using the KVM service in patch 5/5
>
> Based on v5.10-rc3, please let me know if I should rebased on something
> else. A git repo is accessible at:
> https://gitlab.arm.com/linux-arm/linux-ap/-/commits/smccc-trng/v3/
>
> Cheers,
> Andre
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-November/615446.html
> [2] https://gitlab.arm.com/linux-arm/linux-ap/-/commit/87e3722f437
> [3] https://developer.arm.com/documentation/den0098/latest/
>
> Changelog v2 ... v3:
> - ARM: fix compilation with randconfig
> - arm64: use SMCCC call also in arch_get_random_seed_long_early()
> - KVM: comment on return value usage
> - KVM: use more interesting UUID (enjoy, Marc!)

UUIDs are constructed using certain rules, so probably better to
refrain from playing games with them here.

If Marc wants an easter egg, he will have to wait until Easter.

> - KVM: use bitmaps instead of open coded long arrays
> - KVM: drop direct usage of arch_get_random() interface
>
> Changelog "v1" ... v2:
> - trigger ARCH_RANDOM initialisation from the SMCCC firmware driver
> - use a single bool in smccc.c to hold the initialisation state for arm64
> - handle endianess correctly in the KVM provider
>
> Andre Przywara (2):
>   firmware: smccc: Introduce SMCCC TRNG framework
>   arm64: Add support for SMCCC TRNG entropy source
>
> Ard Biesheuvel (3):
>   firmware: smccc: Add SMCCC TRNG function call IDs
>   ARM: implement support for SMCCC TRNG entropy source
>   KVM: arm64: implement the TRNG hypervisor call
>
>  arch/arm/Kconfig                    |  4 ++
>  arch/arm/include/asm/archrandom.h   | 74 +++++++++++++++++++++++++
>  arch/arm64/include/asm/archrandom.h | 79 +++++++++++++++++++++++----
>  arch/arm64/include/asm/kvm_host.h   |  2 +
>  arch/arm64/kvm/Makefile             |  2 +-
>  arch/arm64/kvm/hypercalls.c         |  6 ++
>  arch/arm64/kvm/trng.c               | 85 +++++++++++++++++++++++++++++
>  drivers/firmware/smccc/smccc.c      |  5 ++
>  include/linux/arm-smccc.h           | 31 +++++++++++
>  9 files changed, 277 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm/include/asm/archrandom.h
>  create mode 100644 arch/arm64/kvm/trng.c
>
> --
> 2.17.1
>
