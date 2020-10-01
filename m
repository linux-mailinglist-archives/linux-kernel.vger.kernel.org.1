Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3136E2808B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbgJAUoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:44:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:58718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgJAUm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:42:58 -0400
IronPort-SDR: +HRAlbeL3FBi05BpErQIukaIrHj7EOciEG7NPP1ZbTvbru5Lb0r3cPPwe0mKB7YZhOexRAekaT
 jC4jPrDtqMzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170708"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:51 -0700
IronPort-SDR: CEzqFgSfA5hh2SUumpyFIP37p19uiC6VdR0p+/SqFhjC4Q3RD8v/MqioChUkHkylsFVQdvr1+7
 V9RSXlCkvjog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297035"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 00/22] x86: Support Intel Advanced Matrix Extensions
Date:   Thu,  1 Oct 2020 13:38:51 -0700
Message-Id: <20201001203913.9125-1-chang.seok.bae@intel.com>
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

This series requires the new minimum sigaltstack support [4] and is based
on the mainline with dynamic supervisor state support [3]. The series is
composed of three parts:
* Patch 1-16: Foundation to support dynamic user state management, as
              preparatory for managing tile data state.
* Patch 17-21: Actual AMX enablement, including unit tests
* Patch 22: Introduce boot parameters

Thanks to Len Brown and Dave Hansen for help with the cover letter.

[1]: Intel Architecture Instruction Set Extension Programming Reference
     June 2020, https://software.intel.com/content/dam/develop/public/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf
[2]: https://software.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/compiler-reference/intrinsics/intrinsics-for-intel-advanced-matrix-extensions-intel-amx-instructions.html
[3]: https://lore.kernel.org/lkml/1593780569-62993-1-git-send-email-kan.liang@linux.intel.com/
[4]: https://lore.kernel.org/lkml/20200929205746.6763-1-chang.seok.bae@intel.com/

Chang S. Bae (22):
  x86/fpu/xstate: Modify area init helper prototypes to access all the
    possible areas
  x86/fpu/xstate: Modify xstate copy helper prototypes to access all the
    possible areas
  x86/fpu/xstate: Modify address finder prototypes to access all the
    possible areas
  x86/fpu/xstate: Modify save and restore helper prototypes to access
    all the possible areas
  x86/fpu/xstate: Introduce a new variable for dynamic user states
  x86/fpu/xstate: Outline dynamic xstate area size in the task context
  x86/fpu/xstate: Introduce helpers to manage an xstate area dynamically
  x86/fpu/xstate: Define the scope of the initial xstate data
  x86/fpu/xstate: Introduce wrapper functions for organizing xstate area
    access
  x86/fpu/xstate: Update xstate save function for supporting dynamic
    user xstate
  x86/fpu/xstate: Update xstate area address finder for supporting
    dynamic user xstate
  x86/fpu/xstate: Update xstate context copy function for supporting
    dynamic area
  x86/fpu/xstate: Expand dynamic user state area on first use
  x86/fpu/xstate: Inherit dynamic user state when used in the parent
  x86/fpu/xstate: Support ptracer-induced xstate area expansion
  x86/fpu/xstate: Support dynamic user state in the signal handling path
  x86/fpu/xstate: Extend the table for mapping xstate components with
    features
  x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature
    bits
  x86/fpu/amx: Define AMX state components and have it used for
    boot-time checks
  x86/fpu/amx: Enable the AMX feature in 64-bit mode
  selftest/x86/amx: Include test cases for the AMX state management
  x86/fpu/xstate: Introduce boot-parameters for control some state
    component support

 .../admin-guide/kernel-parameters.txt         |  15 +
 arch/x86/include/asm/cpufeatures.h            |   4 +
 arch/x86/include/asm/fpu/internal.h           |  99 ++-
 arch/x86/include/asm/fpu/types.h              |  62 +-
 arch/x86/include/asm/fpu/xstate.h             |  41 +-
 arch/x86/include/asm/msr-index.h              |   2 +
 arch/x86/include/asm/pgtable.h                |   2 +-
 arch/x86/include/asm/processor.h              |  10 +-
 arch/x86/include/asm/trace/fpu.h              |   6 +-
 arch/x86/kernel/cpu/common.c                  |   2 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/fpu/core.c                    | 107 ++-
 arch/x86/kernel/fpu/init.c                    |  89 ++-
 arch/x86/kernel/fpu/regset.c                  |  65 +-
 arch/x86/kernel/fpu/signal.c                  |  41 +-
 arch/x86/kernel/fpu/xstate.c                  | 483 ++++++++++--
 arch/x86/kernel/process.c                     |  11 +
 arch/x86/kernel/process_32.c                  |   2 +-
 arch/x86/kernel/process_64.c                  |   2 +-
 arch/x86/kernel/traps.c                       |   3 +
 arch/x86/kvm/x86.c                            |  43 +-
 arch/x86/mm/pkeys.c                           |   2 +-
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/amx.c             | 736 ++++++++++++++++++
 24 files changed, 1620 insertions(+), 212 deletions(-)
 create mode 100644 tools/testing/selftests/x86/amx.c

--
2.17.1

