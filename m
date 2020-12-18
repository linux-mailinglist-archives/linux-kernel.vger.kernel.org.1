Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3712DE8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgLRSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgLRSSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:18:00 -0500
Date:   Fri, 18 Dec 2020 18:17:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Second set of arm64 updates for 5.11
Message-ID: <20201218181713.GA13068@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

These are some some trivial updates that mostly fix/clean-up code pushed
during the merging window. I'll be on holiday until the new year but
I'll check email occasionally in case anything falls apart.

Merry Christmas!

The following changes since commit d889797530c66f699170233474eab3361471e808:

  Merge remote-tracking branch 'arm64/for-next/fixes' into for-next/core (2020-12-09 18:04:55 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 9fd339a45be5c06e239d45a042eab9d25de87882:

  arm64: Work around broken GCC 4.9 handling of "S" constraint (2020-12-17 11:46:20 +0000)

----------------------------------------------------------------
arm64 fixes/updates:

- Work around broken GCC 4.9 handling of "S" asm constraint.

- Suppress W=1 missing prototype warnings.

- Warn the user when a small VA_BITS value cannot map the available
  memory.

- Drop the useless update to per-cpu cycles.

----------------------------------------------------------------
Marc Zyngier (2):
      arm64: Warn the user when a small VA_BITS value wastes memory
      arm64: Work around broken GCC 4.9 handling of "S" constraint

Mark Rutland (1):
      arm64: entry: suppress W=1 prototype warnings

Viresh Kumar (1):
      arm64: topology: Drop the useless update to per-cpu cycles

 arch/arm64/include/asm/exception.h | 4 ++++
 arch/arm64/include/asm/kvm_asm.h   | 8 +++++++-
 arch/arm64/kernel/topology.c       | 6 +-----
 arch/arm64/mm/init.c               | 3 +++
 4 files changed, 15 insertions(+), 6 deletions(-)

-- 
Catalin
