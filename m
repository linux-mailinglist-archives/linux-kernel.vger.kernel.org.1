Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC62852FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgJFUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:18:48 -0400
Received: from foss.arm.com ([217.140.110.172]:56210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgJFUSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:18:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A0F113E;
        Tue,  6 Oct 2020 13:18:47 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B93D3F71F;
        Tue,  6 Oct 2020 13:18:46 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: Add support for SMCCC TRNG interface
Date:   Tue,  6 Oct 2020 21:18:06 +0100
Message-Id: <20201006201808.37665-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098[1], defines an ARM SMCCC based interface to a true random number
generator, provided by firmware.

This is the arm64 implementation of that interface, implemented in
the arch_get_random_*() code.

Patch 1/2 introduces the SMCCC function identifiers, this is extracted
from Ard's patch, to avoid dependencies between the several patches
floating around (ARM, KVM, arm64).

Patch 2/2 detects the interface and calls into the firmware upon a call
to arch_get_random_seed_long().
Support for the "early" variant is under investigation.

This was tested on:
- QEMU -kernel (no SMCCC, regression test)
- Juno w/ standard firmware (SMCCC, but no TRNG: regression test)
- Juno w/ "fake TRNG" firmware (to verify "random" numbers)
- Juno w/ prototype of the h/w Trusted RNG support
- mainline KVM (SMCCC, but no TRNG: regression test)
- Ard's KVM patch (plus hack to inject fake numbers for verification purposes)

Cheers,
Andre

[1] https://developer.arm.com/documentation/den0098/latest/

Andre Przywara (1):
  arm64: Add support for SMCCC TRNG firmware interface

Ard Biesheuvel (1):
  firmware: smccc: Add SMCCC TRNG function call IDs

 arch/arm64/include/asm/archrandom.h | 83 +++++++++++++++++++++++++----
 include/linux/arm-smccc.h           | 31 +++++++++++
 2 files changed, 104 insertions(+), 10 deletions(-)

-- 
2.17.1

