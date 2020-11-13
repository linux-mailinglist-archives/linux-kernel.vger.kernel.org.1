Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B302B2964
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKMXzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:55:13 -0500
Received: from foss.arm.com ([217.140.110.172]:49356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMXzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:55:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA3CD1042;
        Fri, 13 Nov 2020 15:55:11 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4673F718;
        Fri, 13 Nov 2020 15:55:09 -0800 (PST)
Subject: Re: [PATCH v3 0/5] ARM: arm64: Add SMCCC TRNG entropy service
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201113182435.64015-1-andre.przywara@arm.com>
 <CAMj1kXG__RAneq6NwquLiM1ja8O3cepUB6Ovp9aSgy3D_6hN1A@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <aed68ebe-5289-56fa-699d-4feda8bf58e2@arm.com>
Date:   Fri, 13 Nov 2020 23:54:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXG__RAneq6NwquLiM1ja8O3cepUB6Ovp9aSgy3D_6hN1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2020 23:05, Ard Biesheuvel wrote:
> On Fri, 13 Nov 2020 at 19:24, Andre Przywara <andre.przywara@arm.com> wrote:
>>
>> Hi,
>>
>> an update to v2 with some fixes and a few tweaks. Ard's patch [1] should
>> significantly reduce the frequency of arch_get_random_seed_long() calls,
>> not sure if that is enough the appease the concerns about the
>> potentially long latency of SMC calls. I also dropped the direct
>> arch_get_random() call in KVM for the same reason. An alternative could
>> be to just use the SMC in the _early() versions, but then we would lose
>> the SMCCC entropy source for the periodic reseeds. This could be mitigated
>> by using a hwrng driver [2] and rngd.
>> The only other non-minor change to v2 is the addition of using the SMCCC
>> call in the _early() variant. For a changelog see below.
>>
>> Sudeep: patch 1/5 is a prerequisite for all other patches, which
>> themselves could be considered separate and need to go via different trees.
>> If we could agree on that one now and get that merged, it would help the
>> handling of the other patches going forward.
>>
>> Cheers,
>> Andre
>> ==============================
>>
>> The ARM architected TRNG firmware interface, described in ARM spec
>> DEN0098[3], defines an ARM SMCCC based interface to a true random number
>> generator, provided by firmware.
>>
>> This series collects all the patches implementing this in various
>> places: as a user feeding into the ARCH_RANDOM pool, both for ARM and
>> arm64, and as a service provider for KVM guests.
>>
>> Patch 1 introduces the interface definition used by all three entities.
>> Patch 2 prepares the Arm SMCCC firmware driver to probe for the
>> interface. This patch is needed to avoid a later dependency on *two*
>> patches (there might be a better solution to this problem).
>>
>> Patch 3 implements the ARM part, patch 4 is the arm64 version.
>> The final patch 5 adds support to provide random numbers to KVM guests.
>>
>> This was tested on:
>> - QEMU -kernel (no SMCCC, regression test)
>> - Juno w/ prototype of the h/w Trusted RNG support
>> - mainline KVM (SMCCC, but no TRNG: regression test)
>> - ARM and arm64 KVM guests, using the KVM service in patch 5/5
>>
>> Based on v5.10-rc3, please let me know if I should rebased on something
>> else. A git repo is accessible at:
>> https://gitlab.arm.com/linux-arm/linux-ap/-/commits/smccc-trng/v3/
>>
>> Cheers,
>> Andre
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-November/615446.html
>> [2] https://gitlab.arm.com/linux-arm/linux-ap/-/commit/87e3722f437
>> [3] https://developer.arm.com/documentation/den0098/latest/
>>
>> Changelog v2 ... v3:
>> - ARM: fix compilation with randconfig
>> - arm64: use SMCCC call also in arch_get_random_seed_long_early()
>> - KVM: comment on return value usage
>> - KVM: use more interesting UUID (enjoy, Marc!)
> 
> UUIDs are constructed using certain rules, so probably better to
> refrain from playing games with them here.

Hey, it's a valid variant 1 version 1 UUID (otherwise this would be no
real easter egg). uuidgen -t should be able to generate this one. I
found it too easy to use the random variant, but we can revert to that.

> If Marc wants an easter egg, he will have to wait until Easter.

Don't mess with your maintainer ;-)

Cheers,
Andre

> 
>> - KVM: use bitmaps instead of open coded long arrays
>> - KVM: drop direct usage of arch_get_random() interface
>>
>> Changelog "v1" ... v2:
>> - trigger ARCH_RANDOM initialisation from the SMCCC firmware driver
>> - use a single bool in smccc.c to hold the initialisation state for arm64
>> - handle endianess correctly in the KVM provider
>>
>> Andre Przywara (2):
>>   firmware: smccc: Introduce SMCCC TRNG framework
>>   arm64: Add support for SMCCC TRNG entropy source
>>
>> Ard Biesheuvel (3):
>>   firmware: smccc: Add SMCCC TRNG function call IDs
>>   ARM: implement support for SMCCC TRNG entropy source
>>   KVM: arm64: implement the TRNG hypervisor call
>>
>>  arch/arm/Kconfig                    |  4 ++
>>  arch/arm/include/asm/archrandom.h   | 74 +++++++++++++++++++++++++
>>  arch/arm64/include/asm/archrandom.h | 79 +++++++++++++++++++++++----
>>  arch/arm64/include/asm/kvm_host.h   |  2 +
>>  arch/arm64/kvm/Makefile             |  2 +-
>>  arch/arm64/kvm/hypercalls.c         |  6 ++
>>  arch/arm64/kvm/trng.c               | 85 +++++++++++++++++++++++++++++
>>  drivers/firmware/smccc/smccc.c      |  5 ++
>>  include/linux/arm-smccc.h           | 31 +++++++++++
>>  9 files changed, 277 insertions(+), 11 deletions(-)
>>  create mode 100644 arch/arm/include/asm/archrandom.h
>>  create mode 100644 arch/arm64/kvm/trng.c
>>
>> --
>> 2.17.1
>>

