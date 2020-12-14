Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5832A2D9AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405383AbgLNP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:27:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:47394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgLNP1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:27:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 130B0AC7F;
        Mon, 14 Dec 2020 15:27:04 +0000 (UTC)
Date:   Mon, 14 Dec 2020 16:26:59 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v5.11
Message-ID: <20201214152659.GI26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's yet another branch with a nicely negative diffstat, just the way
I like 'em.

Please pull,
thx.

---

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.11

for you to fetch changes up to 9a02fd8b19247e80e2354a227b6e2392e8fae78a:

  x86/ia32_signal: Propagate __user annotation properly (2020-12-11 19:44:31 +0100)

----------------------------------------------------------------
- Remove all uses of TIF_IA32 and TIF_X32 and reclaim the two bits in the end
(Gabriel Krisman Bertazi)

- All kinds of minor cleanups all over the tree.

----------------------------------------------------------------
Alex Shi (1):
      x86/PCI: Make a kernel-doc comment a normal one

Arvind Sankar (2):
      x86/boot: Remove unused finalize_identity_maps()
      x86/head/64: Remove unused GET_CR2_INTO() macro

Borislav Petkov (1):
      x86/setup: Remove unused MCA variables

Dan Williams (1):
      x86, libnvdimm/test: Remove COPY_MC_TEST

Gabriel Krisman Bertazi (10):
      perf/x86: Avoid TIF_IA32 when checking 64bit mode
      x86/compat: Simplify compat syscall userspace allocation
      x86/oprofile: Avoid TIF_IA32 when checking 64bit mode
      x86/elf: Use e_machine to choose DLINFO in compat
      elf: Expose ELF header in compat_start_thread()
      x86/elf: Use e_machine to select start_thread for x32
      elf: Expose ELF header on arch_setup_additional_pages()
      x86/elf: Use e_machine to check for x32/ia32 in setup_additional_pages()
      x86/mm: Convert mmu context ia32_compat into a proper flags field
      x86: Reclaim TIF_IA32 and TIF_X32

Hui Su (1):
      x86/dumpstack: Make show_trace_log_lvl() static

Lukas Bulwahn (2):
      x86/mm: Declare 'start' variable where it is used
      x86/ia32_signal: Propagate __user annotation properly

Mauro Carvalho Chehab (1):
      x86/mtrr: Fix a kernel-doc markup

Qiujun Huang (1):
      x86/alternative: Update text_poke_bp() kernel-doc comment

Sean Christopherson (1):
      x86/asm: Drop unused RDPID macro

Thomas Gleixner (1):
      x86/uaccess: Document copy_from_user_nmi()

Uros Bizjak (1):
      x86/boot/compressed/64: Use TEST %reg,%reg instead of CMP $0,%reg

Wang Qing (1):
      x86/head64: Remove duplicate include

 arch/x86/Kconfig.debug                  |   3 -
 arch/x86/boot/compressed/head_64.S      |   8 +--
 arch/x86/boot/compressed/ident_map_64.c |  10 ----
 arch/x86/entry/vdso/vma.c               |   4 +-
 arch/x86/entry/vsyscall/vsyscall_64.c   |   2 +-
 arch/x86/events/core.c                  |   2 +-
 arch/x86/events/intel/ds.c              |   2 +-
 arch/x86/events/intel/lbr.c             |   2 +-
 arch/x86/ia32/ia32_signal.c             |   2 +-
 arch/x86/include/asm/compat.h           |  15 +++--
 arch/x86/include/asm/copy_mc_test.h     |  75 -----------------------
 arch/x86/include/asm/elf.h              |  13 ++--
 arch/x86/include/asm/inst.h             |  15 -----
 arch/x86/include/asm/mmu.h              |   9 ++-
 arch/x86/include/asm/mmu_context.h      |   2 +-
 arch/x86/include/asm/paravirt.h         |  11 ----
 arch/x86/include/asm/stacktrace.h       |   3 -
 arch/x86/include/asm/thread_info.h      |   4 --
 arch/x86/kernel/alternative.c           |   2 +-
 arch/x86/kernel/asm-offsets.c           |   1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c         |   3 +-
 arch/x86/kernel/dumpstack.c             |   2 +-
 arch/x86/kernel/head64.c                |   1 -
 arch/x86/kernel/head_64.S               |   9 ---
 arch/x86/kernel/perf_regs.c             |   2 +-
 arch/x86/kernel/process_64.c            |  28 ++++-----
 arch/x86/kernel/setup.c                 |   5 --
 arch/x86/lib/copy_mc.c                  |   4 --
 arch/x86/lib/copy_mc_64.S               |  10 ----
 arch/x86/lib/usercopy.c                 |  22 +++++--
 arch/x86/mm/init.c                      |   6 +-
 arch/x86/oprofile/backtrace.c           |   2 +-
 arch/x86/pci/i386.c                     |   6 +-
 fs/binfmt_elf.c                         |   4 +-
 fs/compat_binfmt_elf.c                  |  20 +++++--
 include/linux/elf.h                     |  10 ++++
 tools/testing/nvdimm/test/nfit.c        | 103 --------------------------------
 37 files changed, 105 insertions(+), 317 deletions(-)
 delete mode 100644 arch/x86/include/asm/copy_mc_test.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
