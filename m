Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340381C25B5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEBNe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 09:34:56 -0400
Received: from foss.arm.com ([217.140.110.172]:52290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgEBNez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:34:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAED330E;
        Sat,  2 May 2020 06:34:54 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A17F73F68F;
        Sat,  2 May 2020 06:34:51 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH V3 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1, ID_MMFR5 and other changes
Date:   Sat,  2 May 2020 19:03:49 +0530
Message-Id: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is primarily motivated from an adhoc list from Mark Rutland
during our previous ID_ISAR6 discussion [1]. The current proposal also
accommodates some more suggestions from Will and Suzuki.

This series adds missing 32 bit system registers (ID_PFR2, ID_DFR1 and
ID_MMFR5), adds missing features bits on all existing system registers
(32 and 64 bit) and some other miscellaneous changes. While here it also
includes a patch which does macro replacement for various open bits shift
encodings for various CPU ID registers. There is a slight re-order of the
patches here as compared to the previous version (V1).

This series is based on arm64 tree (for-next/cpufeature). All feature bits
enabled here can be referred in ARM DDI 0487F.a specification. Though I
have tried to select appropriate values for each new feature being added
here, there might be some inconsistencies (or mistakes). In which case,
please do let me know if anything needs to change. Thank you.

[1] https://patchwork.kernel.org/patch/11287805/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Changes in V3:

- Rebased on git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git (for-next/cpufeature)

Changes in V2: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=270605)

- Added Suggested-by tag from Mark Rutland for all changes he had proposed
- Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
- Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
- Added ID_DFR1 and ID_MMFR5 system register definitions per Will
- Added remaining features bits for relevant 64 bit system registers per Will
- Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
- Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
- Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
- Changed some commit messages

Changes in V1: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=234093)

Anshuman Khandual (16):
  arm64/cpufeature: Add explicit ftr_id_isar0[] for ID_ISAR0 register
  arm64/cpufeature: Drop TraceFilt feature exposure from ID_DFR0 register
  arm64/cpufeature: Make doublelock a signed feature in ID_AA64DFR0
  arm64/cpufeature: Introduce ID_PFR2 CPU register
  arm64/cpufeature: Introduce ID_DFR1 CPU register
  arm64/cpufeature: Introduce ID_MMFR5 CPU register
  arm64/cpufeature: Add remaining feature bits in ID_PFR0 register
  arm64/cpufeature: Add remaining feature bits in ID_MMFR4 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64ISAR0 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64PFR0 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64PFR1 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR0 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR1 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR2 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64DFR0 register
  arm64/cpufeature: Replace all open bits shift encodings with macros

 arch/arm64/include/asm/cpu.h    |   3 +
 arch/arm64/include/asm/sysreg.h |  90 ++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c  | 141 +++++++++++++++++++++++++-------
 arch/arm64/kernel/cpuinfo.c     |   3 +
 arch/arm64/kvm/sys_regs.c       |   6 +-
 5 files changed, 211 insertions(+), 32 deletions(-)

-- 
2.20.1

