Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220AB2F83D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbhAOSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbhAOSQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:16:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6611223A58;
        Fri, 15 Jan 2021 18:15:49 +0000 (UTC)
Date:   Fri, 15 Jan 2021 18:15:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.11-rc4
Message-ID: <20210115181544.GA8353@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 3a57a643a851dbb1c4a1819394ca009e3bfa4813:

  arm64: selftests: Fix spelling of 'Mismatch' (2021-01-15 10:05:27 +0000)

----------------------------------------------------------------
arm64 fixes:

- Set the minimum GCC version to 5.1 for arm64 due to earlier compiler
  bugs.

- Make atomic helpers __always_inline to avoid a section mismatch when
  compiling with clang.

- Fix the CMA and crashkernel reservations to use ZONE_DMA (remove the
  arm64_dma32_phys_limit variable, no longer needed with a dynamic
  ZONE_DMA sizing in 5.11).

- Remove redundant IRQ flag tracing that was leaving lockdep
  inconsistent with the hardware state.

- Revert perf events based hard lockup detector that was causing
  smp_processor_id() to be called in preemptible context.

- Some trivial cleanups - spelling fix, renaming S_FRAME_SIZE to
  PT_REGS_SIZE, function prototypes added.

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: make atomic helpers __always_inline

Catalin Marinas (1):
      arm64: Remove arm64_dma32_phys_limit and its uses

Jianlin Lv (1):
      arm64: rename S_FRAME_SIZE to PT_REGS_SIZE

Mark Brown (1):
      arm64: selftests: Fix spelling of 'Mismatch'

Mark Rutland (2):
      arm64: entry: remove redundant IRQ flag tracing
      arm64: syscall: include prototype for EL0 SVC functions

Will Deacon (2):
      Revert "arm64: Enable perf events based hard lockup detector"
      compiler.h: Raise minimum version of GCC to 5.1 for arm64

 arch/arm64/Kconfig                             |  2 --
 arch/arm64/include/asm/atomic.h                | 10 +++----
 arch/arm64/include/asm/processor.h             |  3 +-
 arch/arm64/kernel/asm-offsets.c                |  2 +-
 arch/arm64/kernel/entry-ftrace.S               | 12 ++++----
 arch/arm64/kernel/entry.S                      | 14 ++++-----
 arch/arm64/kernel/perf_event.c                 | 41 ++------------------------
 arch/arm64/kernel/probes/kprobes_trampoline.S  |  6 ++--
 arch/arm64/kernel/signal.c                     |  7 -----
 arch/arm64/kernel/syscall.c                    | 10 ++-----
 arch/arm64/mm/init.c                           | 33 +++++++++++----------
 drivers/perf/arm_pmu.c                         |  5 ----
 include/asm-generic/bitops/atomic.h            |  6 ++--
 include/linux/compiler-gcc.h                   |  6 ++++
 include/linux/perf/arm_pmu.h                   |  2 --
 tools/testing/selftests/arm64/fp/fpsimd-test.S |  2 +-
 tools/testing/selftests/arm64/fp/sve-test.S    |  2 +-
 17 files changed, 56 insertions(+), 107 deletions(-)

-- 
Catalin
