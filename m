Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6364E2EF5E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbhAHQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbhAHQe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:34:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 510D4238EC;
        Fri,  8 Jan 2021 16:33:48 +0000 (UTC)
Date:   Fri, 8 Jan 2021 16:33:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.11-rc3
Message-ID: <20210108163343.GA18635@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 83b5bd628f65e6b4d1924b307d6a88a57827bdb0:

  arm64: Move PSTATE.TCO setting to separate functions (2021-01-07 11:39:01 +0000)

----------------------------------------------------------------
arm64 fixes:

- Clean-ups following the merging window: remove unused variable,
  duplicate includes, superfluous barrier, move some inline asm to
  separate functions.

- Disable top-byte-ignore on kernel code addresses with KASAN/MTE
  enabled (already done when MTE is disabled).

- Fix ARCH_LOW_ADDRESS_LIMIT definition with CONFIG_ZONE_DMA disabled.

- Compiler/linker flags: link with "-z norelno", discard .eh_frame_hdr
  instead of --no-eh-frame-hdr.

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: kasan: Set TCR_EL1.TBID1 when KASAN_HW_TAGS is enabled
      arm64: Move PSTATE.TCO setting to separate functions

Geert Uytterhoeven (1):
      arm64/smp: Remove unused irq variable in arch_show_interrupts()

Nick Desaulniers (1):
      arm64: link with -z norelro for LLD or aarch64-elf

Nicolas Saenz Julienne (1):
      arm64: mm: Fix ARCH_LOW_ADDRESS_LIMIT when !CONFIG_ZONE_DMA

Peter Collingbourne (2):
      arm64: mte: remove an ISB on kernel exit
      arm64: vdso: disable .eh_frame_hdr via /DISCARD/ instead of --no-eh-frame-hdr

Tian Tao (1):
      arm64: traps: remove duplicate include statement

 arch/arm64/Makefile                | 10 +++++++---
 arch/arm64/include/asm/processor.h |  3 ++-
 arch/arm64/include/asm/uaccess.h   | 16 +++++++++++++---
 arch/arm64/kernel/entry.S          |  2 +-
 arch/arm64/kernel/smp.c            |  1 -
 arch/arm64/kernel/traps.c          |  1 -
 arch/arm64/kernel/vdso/Makefile    |  3 +--
 arch/arm64/kernel/vdso/vdso.lds.S  |  5 +----
 arch/arm64/mm/init.c               |  2 +-
 arch/arm64/mm/proc.S               |  2 +-
 10 files changed, 27 insertions(+), 18 deletions(-)

-- 
Catalin
