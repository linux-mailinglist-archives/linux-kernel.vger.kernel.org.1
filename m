Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7A2A7F38
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgKEM5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:57:11 -0500
Received: from foss.arm.com ([217.140.110.172]:60080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbgKEM5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:57:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79205142F;
        Thu,  5 Nov 2020 04:57:05 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD4383F719;
        Thu,  5 Nov 2020 04:57:03 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Date:   Thu,  5 Nov 2020 12:56:51 +0000
Message-Id: <20201105125656.25259-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Compared to the initial posts, this version:
- triggers the ARCH_RANDOM initialisation from the SMCCC firmware driver
- uses a single bool in smccc.c to hold the initialisation state for arm64
- handles endianess correctly in the KVM provider

This was tested on:
- QEMU -kernel (no SMCCC, regression test)
- Juno w/ standard firmware (SMCCC, but no TRNG: regression test)
- Juno w/ "fake TRNG" firmware (to verify "random" numbers)
- Juno w/ prototype of the h/w Trusted RNG support
- mainline KVM (SMCCC, but no TRNG: regression test)
- ARM and arm64 KVM guests, using the KVM service in patch 5/5

Based on v5.10-rc2, please let me know if I should rebased on something
else. A git repo is accessible at:
https://gitlab.arm.com/linux-arm/linux-ap/-/commits/smccc-trng/v2/

Cheers,
Andre

[1] https://developer.arm.com/documentation/den0098/latest/

Andre Przywara (2):
  firmware: smccc: Introduce SMCCC TRNG framework
  arm64: Add support for SMCCC TRNG entropy source

Ard Biesheuvel (3):
  firmware: smccc: Add SMCCC TRNG function call IDs
  ARM: implement support for SMCCC TRNG entropy source
  KVM: arm64: implement the TRNG hypervisor call

 arch/arm/Kconfig                    |  4 ++
 arch/arm/include/asm/archrandom.h   | 74 +++++++++++++++++++++++
 arch/arm64/include/asm/archrandom.h | 63 +++++++++++++++++---
 arch/arm64/include/asm/kvm_host.h   |  2 +
 arch/arm64/kvm/Makefile             |  2 +-
 arch/arm64/kvm/hypercalls.c         |  6 ++
 arch/arm64/kvm/trng.c               | 91 +++++++++++++++++++++++++++++
 drivers/firmware/smccc/smccc.c      |  5 ++
 include/linux/arm-smccc.h           | 31 ++++++++++
 9 files changed, 270 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/include/asm/archrandom.h
 create mode 100644 arch/arm64/kvm/trng.c

-- 
2.17.1

