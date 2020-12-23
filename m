Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5572E1F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgLWQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:02:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:48955 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgLWQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:02:21 -0500
IronPort-SDR: ZstYkz+XkA7MkdjtKQqzIg1fKQ5xphFV1HDu6idjL/8cC/viUCc8aeX6rxuiHuEIMsv+ItWFOJ
 EeA5Tqjuzk7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="155241854"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="155241854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:37 -0800
IronPort-SDR: OcebSDZBC0jpH5mfQg+n5xl5bVwYMoKCkqgMysLuAQqwf8lTT5e63100K4NPC4npQGEkT+XewJ
 Y2HgSm/9roEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458027900"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:36 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 00/21] x86: Support Intel Advanced Matrix Extensions
Date:   Wed, 23 Dec 2020 07:56:56 -0800
Message-Id: <20201223155717.19556-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Advanced Matrix Extensions (AMX)[1][2] will be shipping on servers
soon.  AMX consists of configurable TMM "TILE" registers plus new
accelerator instructions that operate on them.  TMUL (Tile matrix MULtiply)
is the first accelerator instruction set to use the new registers, and we
anticipate additional instructions in the future.

Neither AMX state nor TMUL instructions depend on AVX.  However, AMX and
AVX do share common challenges.  The TMM registers are 8KB today, and
architecturally as large as 64KB, which merits updates to hardware and
software state management.

Further, both technologies run faster when they are not simultaneously
running on SMT siblings, and both technologies use of power and bandwidth
impact the power and performance available to neighboring cores.  (This
impact has measurably improved in recent hardware.)

If the existing kernel approach for managing XSAVE state was employed to
handle AMX, 8KB space would be added to every task, but possibly rarely
used.  So Linux support is optimized by using a new XSAVE feature: eXtended
Feature Disabling (XFD).  The kernel arms XFD to provide a #NM exception
upon a tasks' first access to TILE state. The kernel exception handler
installs the appropriate XSAVE context switch buffer, and the task behaves
as if the kernel had done that for all tasks.  Using XFD, AMX space is
allocated only when needed, eliminating the memory waste for unused state
components.

This series requires the new minimum sigaltstack support [3] and is based
on the mainline. The series is composed of three parts:
* Patch 01-14: Foundation to support dynamic user state management
* Patch 15-19: AMX enablement, including unit tests
* Patch 20-21: Signal handling optimization and new boot-parameters

Thanks to Len Brown and Dave Hansen for help with the cover letter.

Changes from v2 [5]:
* Removed the patch for the tile data inheritance. Also, updated the
  selftest patch. (Andy Lutomirski)
* Changed the kernel tainted when any unknown state is enabled. (Andy
  Lutomirski)
* Changed to use the XFD feature only when the compacted format in use.
* Improved the test code.
* Simplified the cmdline handling.
* Removed 'task->fpu' in changelogs. (Boris Petkov)
* Updated the variable name / comments / changelogs for clarification.

Changes from v1 [4]:
* Added vmalloc() error tracing (Dave Hansen, PeterZ, and Andy Lutomirski)
* Inlined the #NM handling code (Andy Lutomirski)
* Made signal handling optimization revertible
* Revised the new parameter handling code (Andy Lutomirski and Dave Hansen)
* Rebased on the upstream kernel

[1]: Intel Architecture Instruction Set Extension Programming Reference
    October 2020, https://software.intel.com/content/dam/develop/external/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf
[2]: https://software.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/compiler-reference/intrinsics/intrinsics-for-intel-advanced-matrix-extensions-intel-amx-instructions.html
[3]: https://lore.kernel.org/lkml/20201223015312.4882-1-chang.seok.bae@intel.com/
[4]: https://lore.kernel.org/lkml/20201001203913.9125-1-chang.seok.bae@intel.com/
[5]: https://lore.kernel.org/lkml/20201119233257.2939-1-chang.seok.bae@intel.com/

Chang S. Bae (21):
  x86/fpu/xstate: Modify initialization helper to handle both static and
    dynamic buffers
  x86/fpu/xstate: Modify state copy helpers to handle both static and
    dynamic buffers
  x86/fpu/xstate: Modify address finders to handle both static and
    dynamic buffers
  x86/fpu/xstate: Modify context switch helpers to handle both static
    and dynamic buffers
  x86/fpu/xstate: Add a new variable to indicate dynamic user states
  x86/fpu/xstate: Calculate and remember dynamic xstate buffer sizes
  x86/fpu/xstate: Introduce helpers to manage dynamic xstate buffers
  x86/fpu/xstate: Define the scope of the initial xstate data
  x86/fpu/xstate: Introduce wrapper functions to organize xstate buffer
    access
  x86/fpu/xstate: Update xstate save function to support dynamic xstate
  x86/fpu/xstate: Update xstate buffer address finder to support dynamic
    xstate
  x86/fpu/xstate: Update xstate context copy function to support dynamic
    buffer
  x86/fpu/xstate: Expand dynamic context switch buffer on first use
  x86/fpu/xstate: Support ptracer-induced xstate buffer expansion
  x86/fpu/xstate: Extend the table to map xstate components with
    features
  x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature
    bits
  x86/fpu/amx: Define AMX state components and have it used for
    boot-time checks
  x86/fpu/amx: Enable the AMX feature in 64-bit mode
  selftest/x86/amx: Include test cases for the AMX state management
  x86/fpu/xstate: Support dynamic user state in the signal handling path
  x86/fpu/xstate: Introduce boot-parameters to control some state
    component support

 .../admin-guide/kernel-parameters.txt         |  15 +
 arch/x86/include/asm/cpufeatures.h            |   4 +
 arch/x86/include/asm/fpu/internal.h           |  97 ++-
 arch/x86/include/asm/fpu/types.h              |  62 +-
 arch/x86/include/asm/fpu/xstate.h             |  61 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/pgtable.h                |   2 +-
 arch/x86/include/asm/processor.h              |  10 +-
 arch/x86/include/asm/trace/fpu.h              |  11 +-
 arch/x86/kernel/cpu/common.c                  |   2 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   4 +
 arch/x86/kernel/fpu/core.c                    |  50 +-
 arch/x86/kernel/fpu/init.c                    | 103 ++-
 arch/x86/kernel/fpu/regset.c                  |  65 +-
 arch/x86/kernel/fpu/signal.c                  |  40 +-
 arch/x86/kernel/fpu/xstate.c                  | 481 ++++++++++--
 arch/x86/kernel/process.c                     |  11 +
 arch/x86/kernel/process_32.c                  |   2 +-
 arch/x86/kernel/process_64.c                  |   2 +-
 arch/x86/kernel/traps.c                       |  40 +
 arch/x86/kvm/x86.c                            |  43 +-
 arch/x86/mm/pkeys.c                           |   2 +-
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/amx.c             | 743 ++++++++++++++++++
 24 files changed, 1631 insertions(+), 223 deletions(-)
 create mode 100644 tools/testing/selftests/x86/amx.c

-- 
2.17.1

