Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0112A0C13
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgJ3RF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgJ3RF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:05:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9402075E;
        Fri, 30 Oct 2020 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604077556;
        bh=Njl1f7sTJUGbIkrVcDP2LAdv9SVEBuYpzSiBvEHmwRY=;
        h=Date:From:To:Cc:Subject:From;
        b=XpJ1VNQuDe5/glAfCLZ5zczErpPzp8K1wXe/a8JAuBkDWL21fXzVQnzGNamagQ1Jw
         pB+zbwtm1AkGgsDdxfeDjJ7y+AhWLNZSPKHAfmNDFbhuVV0PiQrnU0J3wV39OKwIG5
         s23carmio4OvFX7ZJDYIKDHZBMyKx+4PXY9P2n+0=
Date:   Fri, 30 Oct 2020 17:05:52 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc2
Message-ID: <20201030170551.GA531@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. The diffstat is a bit spread out
thanks to an invasive CPU erratum workaround which missed the merge window
and also a bunch of fixes to the recently added MTE selftests.

We're aware of an arm64 kprobes regression and have a tentative fix [1], but
I'd like it to sit in -next for a bit before sending it to you for -rc3.

Summary in the tag.

Cheers,

Will

[1] https://lore.kernel.org/r/20201029173440.117174-1-jean-philippe@linaro.org

--->8

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ec9d78070de986ecf581ea204fd322af4d2477ec:

  arm64: Change .weak to SYM_FUNC_START_WEAK_PI for arch/arm64/lib/mem*.S (2020-10-30 08:32:31 +0000)

----------------------------------------------------------------
arm64 fixes for -rc2

- Fixes to MTE kselftests

- Fix return code from KVM Spectre-v2 hypercall

- Build fixes for ld.lld and Clang's infamous integrated assembler

- Ensure RCU is up and running before we use printk()

- Workaround for Cortex-A77 erratum 1508412

- Fix linker warnings from unexpected ELF sections

- Ensure PE/COFF sections are 64k aligned

----------------------------------------------------------------
Ard Biesheuvel (3):
      arm64: vmlinux.lds: account for spurious empty .igot.plt sections
      arm64: efi: increase EFI PE/COFF header padding to 64 KB
      module: use hidden visibility for weak symbol references

Arnd Bergmann (1):
      arm64: avoid -Woverride-init warning

Catalin Marinas (1):
      arm64: mte: Document that user PSTATE.TCO is ignored by kernel uaccess

Fangrui Song (1):
      arm64: Change .weak to SYM_FUNC_START_WEAK_PI for arch/arm64/lib/mem*.S

Nathan Chancellor (1):
      arm64: vdso32: Allow ld.lld to properly link the VDSO

Qian Cai (1):
      arm64/smp: Move rcu_cpu_starting() earlier

Rob Herring (2):
      arm64: Add part number for Arm Cortex-A77
      arm64: Add workaround for Arm Cortex-A77 erratum 1508412

Stephen Boyd (1):
      KVM: arm64: ARM_SMCCC_ARCH_WORKAROUND_1 doesn't return SMCCC_RET_NOT_REQUIRED

Vincenzo Frascino (6):
      kselftest/arm64: Fix check_buffer_fill test
      kselftest/arm64: Fix check_tags_inclusion test
      kselftest/arm64: Fix check_child_memory test
      kselftest/arm64: Fix check_mmap_options test
      kselftest/arm64: Fix check_ksm_options test
      kselftest/arm64: Fix check_user_mem test

 Documentation/arm64/memory-tagging-extension.rst   |  4 +++-
 Documentation/arm64/silicon-errata.rst             |  2 ++
 arch/arm64/Kconfig                                 | 20 +++++++++++++++++++
 arch/arm64/include/asm/cache.h                     |  1 +
 arch/arm64/include/asm/cpucaps.h                   |  3 ++-
 arch/arm64/include/asm/cputype.h                   |  2 ++
 arch/arm64/include/asm/sysreg.h                    |  9 +++++++++
 arch/arm64/kernel/cpu_errata.c                     | 10 ++++++++++
 arch/arm64/kernel/cpuinfo.c                        |  7 ++++---
 arch/arm64/kernel/efi-header.S                     |  2 +-
 arch/arm64/kernel/entry.S                          |  3 +++
 arch/arm64/kernel/proton-pack.c                    |  2 --
 arch/arm64/kernel/smp.c                            |  1 +
 arch/arm64/kernel/vdso32/Makefile                  | 23 +++++++++++-----------
 arch/arm64/kernel/vmlinux.lds.S                    |  2 +-
 arch/arm64/kvm/arm.c                               |  3 ++-
 arch/arm64/kvm/hyp/include/hyp/switch.h            | 21 ++++++++++++--------
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |  2 +-
 arch/arm64/kvm/hypercalls.c                        |  2 +-
 arch/arm64/kvm/sys_regs.c                          |  2 +-
 arch/arm64/lib/memcpy.S                            |  3 +--
 arch/arm64/lib/memmove.S                           |  3 +--
 arch/arm64/lib/memset.S                            |  3 +--
 arch/arm64/mm/fault.c                              |  2 +-
 include/linux/arm-smccc.h                          |  2 ++
 include/linux/module.h                             |  2 +-
 .../selftests/arm64/mte/check_buffer_fill.c        |  3 +++
 .../selftests/arm64/mte/check_child_memory.c       |  3 +++
 .../selftests/arm64/mte/check_ksm_options.c        |  4 ++++
 .../selftests/arm64/mte/check_mmap_options.c       |  4 ++++
 .../selftests/arm64/mte/check_tags_inclusion.c     |  3 +++
 tools/testing/selftests/arm64/mte/check_user_mem.c |  4 ++++
 34 files changed, 119 insertions(+), 42 deletions(-)
