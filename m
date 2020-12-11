Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369E32D7A78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395340AbgLKQDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:03:12 -0500
Received: from foss.arm.com ([217.140.110.172]:37204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406679AbgLKQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:00:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BFB31B;
        Fri, 11 Dec 2020 08:00:12 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6493F66B;
        Fri, 11 Dec 2020 08:00:10 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Date:   Fri, 11 Dec 2020 16:00:00 +0000
Message-Id: <20201211160005.187336-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a small update to v3, fixing the rare build issue the kernel test robot
pointed out, and changing the priority of the SMCCC vs. RNDR call in
the arm64 patch, as per discussion with Ard.
Adding tags on the way. Changelog below.

Cheers,
Andre
==============================

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098[1], defines an ARM SMCCC based interface to a true random number
generator, provided by firmware.

This series collects all the patches implementing this in various
places: as a user feeding into the ARCH_RANDOM pool, both for ARM and
arm64, and as a service provider for KVM guests.

Patch 1 introduces the interface definition used by all three entities.
Patch 2 prepares the Arm SMCCC firmware driver to probe for the
interface. This patch is needed to avoid a later dependency on *two*
patches (there might be a better solution to this problem).

Patch 3 implements the ARM part, patch 4 is the arm64 version.
The final patch 5 adds support to provide random numbers to KVM guests.

This was tested on:
- QEMU -kernel (no SMCCC, regression test)
- Juno w/ prototype of the h/w Trusted RNG support
- mainline KVM (SMCCC, but no TRNG: regression test)
- ARM and arm64 KVM guests, using the KVM service in patch 5/5

Based on arm64/for-next/core, please let me know if I should rebased on
something else. A git repo is accessible at:
https://gitlab.arm.com/linux-arm/linux-ap/-/commits/smccc-trng/v4/

Cheers,
Andre

[1] https://developer.arm.com/documentation/den0098/latest/

Changelog v3 ... v4:
- include cache.h to always have __ro_after_init defined
- change order of SMCCC call vs. RNDR call in arm64's archrandom.h
- adding LinusW's R-b: tags

Changelog v2 ... v3:
- ARM: fix compilation with randconfig
- arm64: use SMCCC call also in arch_get_random_seed_long_early()
- KVM: comment on return value usage
- KVM: use more interesting UUID (enjoy, Marc!)
- KVM: use bitmaps instead of open coded long arrays
- KVM: drop direct usage of arch_get_random() interface

Changelog "v1" ... v2:
- trigger ARCH_RANDOM initialisation from the SMCCC firmware driver
- use a single bool in smccc.c to hold the initialisation state for arm64
- handle endianess correctly in the KVM provider

Andre Przywara (2):
  firmware: smccc: Introduce SMCCC TRNG framework
  arm64: Add support for SMCCC TRNG entropy source

Ard Biesheuvel (3):
  firmware: smccc: Add SMCCC TRNG function call IDs
  ARM: implement support for SMCCC TRNG entropy source
  KVM: arm64: implement the TRNG hypervisor call

 arch/arm/Kconfig                    |  4 ++
 arch/arm/include/asm/archrandom.h   | 74 +++++++++++++++++++++++++
 arch/arm64/include/asm/archrandom.h | 82 ++++++++++++++++++++++++----
 arch/arm64/include/asm/kvm_host.h   |  2 +
 arch/arm64/kvm/Makefile             |  2 +-
 arch/arm64/kvm/hypercalls.c         |  6 ++
 arch/arm64/kvm/trng.c               | 85 +++++++++++++++++++++++++++++
 drivers/firmware/smccc/smccc.c      |  6 ++
 include/linux/arm-smccc.h           | 31 +++++++++++
 9 files changed, 281 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/include/asm/archrandom.h
 create mode 100644 arch/arm64/kvm/trng.c

-- 
2.17.1

