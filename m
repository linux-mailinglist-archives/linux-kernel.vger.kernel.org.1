Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E008D28B1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgJLJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:45:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgJLJpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:45:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84C9BACDB;
        Mon, 12 Oct 2020 09:45:30 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:45:20 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS queue for v5.10
Message-ID: <20201012094520.GB25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the RAS pile this time around.

Thx.

---
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.10

for you to fetch changes up to b3149ffcdb31a8eb854cc442a389ae0b539bf28a:

  x86/mce: Allow for copy_mc_fragile symbol checksum to be generated (2020-10-08 10:39:21 +0200)

----------------------------------------------------------------
* Extend the recovery from MCE in kernel space also to processes which
encounter an MCE in kernel space but while copying from user memory by
sending them a SIGBUS on return to user space and umapping the faulty
memory, by Tony Luck and Youquan Song.

* memcpy_mcsafe() rework by splitting the functionality into
copy_mc_to_user() and copy_mc_to_kernel(). This, as a result, enables
support for new hardware which can recover from a machine check
encountered during a fast string copy and makes that the default and
lets the older hardware which does not support that advance recovery,
opt in to use the old, fragile, slow variant, by Dan Williams.

* New AMD hw enablement, by Yazen Ghannam and Akshay Gupta.

* Do not use MSR-tracing accessors in #MC context and flag any fault
while accessing MCA architectural MSRs as an architectural violation
with the hope that such hw/fw misdesigns are caught early during the hw
eval phase and they don't make it into production.

* Misc fixes, improvements and cleanups, as always.

----------------------------------------------------------------
Akshay Gupta (1):
      x86/mce: Increase maximum number of banks to 64

Borislav Petkov (4):
      x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR
      x86/mce: Annotate mce_rd/wrmsrl() with noinstr
      x86/mce: Add Skylake quirk for patrol scrub reported errors
      x86/mce: Allow for copy_mc_fragile symbol checksum to be generated

Dan Williams (2):
      x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()
      x86/copy_mc: Introduce copy_mc_enhanced_fast_string()

Luca Stefani (1):
      RAS/CEC: Fix cec_init() prototype

Qinglang Miao (1):
      RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE()

Smita Koralahalli (1):
      x86/mce/dev-mcelog: Do not update kflags on AMD systems

Tony Luck (7):
      x86/mce: Delay clearing IA32_MCG_STATUS to the end of do_machine_check()
      x86/mce: Stop mce_reign() from re-computing severity for every CPU
      x86/mce: Drop AMD-specific "DEFERRED" case from Intel severity rule list
      x86/mce: Provide method to find out the type of an exception handler
      x86/mce: Avoid tail copy when machine check terminated a copy from user
      x86/mce: Recover from poison found while copying from user space
      x86/mce: Decode a kernel instruction to determine if it is copying from user

Yazen Ghannam (1):
      x86/MCE/AMD, EDAC/mce_amd: Remove struct smca_hwid.xec_bitmap

Youquan Song (2):
      x86/mce: Pass pointer to saved pt_regs to severity calculation routines
      x86/mce: Add _ASM_EXTABLE_CPY for copy user access

 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/include/asm/string.h                  |   2 -
 arch/powerpc/include/asm/uaccess.h                 |  40 +++--
 arch/powerpc/lib/Makefile                          |   2 +-
 .../lib/{memcpy_mcsafe_64.S => copy_mc_64.S}       |   4 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/Kconfig.debug                             |   2 +-
 arch/x86/include/asm/asm-prototypes.h              |   1 +
 arch/x86/include/asm/asm.h                         |   6 +
 arch/x86/include/asm/copy_mc_test.h                |  75 +++++++++
 arch/x86/include/asm/extable.h                     |   9 +-
 arch/x86/include/asm/mce.h                         |  33 +++-
 arch/x86/include/asm/mcsafe_test.h                 |  75 ---------
 arch/x86/include/asm/string_64.h                   |  32 ----
 arch/x86/include/asm/traps.h                       |   2 +
 arch/x86/include/asm/uaccess.h                     |   9 +
 arch/x86/include/asm/uaccess_64.h                  |  20 ---
 arch/x86/kernel/cpu/mce/amd.c                      |  44 ++---
 arch/x86/kernel/cpu/mce/core.c                     | 182 +++++++++++++++------
 arch/x86/kernel/cpu/mce/dev-mcelog.c               |   4 +-
 arch/x86/kernel/cpu/mce/internal.h                 |  13 +-
 arch/x86/kernel/cpu/mce/severity.c                 | 102 ++++++++++--
 arch/x86/kernel/quirks.c                           |  10 +-
 arch/x86/lib/Makefile                              |   1 +
 arch/x86/lib/copy_mc.c                             |  96 +++++++++++
 arch/x86/lib/copy_mc_64.S                          | 163 ++++++++++++++++++
 arch/x86/lib/copy_user_64.S                        | 111 +++++++------
 arch/x86/lib/memcpy_64.S                           | 115 -------------
 arch/x86/lib/usercopy_64.c                         |  21 ---
 arch/x86/mm/extable.c                              |  24 ++-
 arch/x86/mm/fault.c                                |   2 +-
 drivers/edac/mce_amd.c                             |   4 +-
 drivers/md/dm-writecache.c                         |  15 +-
 drivers/nvdimm/claim.c                             |   2 +-
 drivers/nvdimm/pmem.c                              |   6 +-
 drivers/ras/cec.c                                  |  26 +--
 include/linux/sched.h                              |   2 +
 include/linux/string.h                             |   9 +-
 include/linux/uaccess.h                            |  13 ++
 include/linux/uio.h                                |  10 +-
 lib/Kconfig                                        |   7 +-
 lib/iov_iter.c                                     |  48 +++---
 tools/arch/x86/include/asm/mcsafe_test.h           |  13 --
 tools/arch/x86/lib/memcpy_64.S                     | 115 -------------
 tools/objtool/check.c                              |   5 +-
 tools/perf/bench/Build                             |   1 -
 tools/perf/bench/mem-memcpy-x86-64-lib.c           |  24 ---
 tools/testing/nvdimm/test/nfit.c                   |  49 +++---
 .../testing/selftests/powerpc/copyloops/.gitignore |   2 +-
 tools/testing/selftests/powerpc/copyloops/Makefile |   6 +-
 .../selftests/powerpc/copyloops/copy_mc_64.S       |   1 +
 .../selftests/powerpc/copyloops/memcpy_mcsafe_64.S |   1 -
 52 files changed, 866 insertions(+), 697 deletions(-)
 rename arch/powerpc/lib/{memcpy_mcsafe_64.S => copy_mc_64.S} (98%)
 create mode 100644 arch/x86/include/asm/copy_mc_test.h
 delete mode 100644 arch/x86/include/asm/mcsafe_test.h
 create mode 100644 arch/x86/lib/copy_mc.c
 create mode 100644 arch/x86/lib/copy_mc_64.S
 delete mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
 delete mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c
 create mode 120000 tools/testing/selftests/powerpc/copyloops/copy_mc_64.S
 delete mode 120000 tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
