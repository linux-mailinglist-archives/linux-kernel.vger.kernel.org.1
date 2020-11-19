Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8F2B9E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKSXhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:10765 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgKSXhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:00 -0500
IronPort-SDR: FSJFF+zTw8eEf0dQS877hMyk/JyHHzwO0IXaQI2HTR9R2eudKMxfu1K93I+t5qsu9lkhcDflTH
 Mu2fnJQKI7mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171481773"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171481773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:36:59 -0800
IronPort-SDR: +0G5sjFCtVQxIjd0ghpYOn7v2uuadLcnopT/Lo8mZLmmjsQ4dnJ3OwZpaYWmfNdr28iRuSLWzx
 N2Ffxq5PhoQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392181"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:36:59 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 00/22] x86: Support Intel Advanced Matrix Extensions
Date:   Thu, 19 Nov 2020 15:32:35 -0800
Message-Id: <20201119233257.2939-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ We know there are a lot of Intel patches out there this week. We're
  posting this as early as we can in case anyone has bandwidth to take a
  look.  We don't think these are quite ready to be merged, but any review
  is appreciated. ]

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
* Patch 01-16: Foundation to support dynamic user state management
* Patch 16-20: AMX enablement, including unit tests
* Patch 21-22: Signal handling optimization and new boot-parameters

Thanks to Len Brown and Dave Hansen for help with the cover letter.

Changes from v1 [4]:
* Added vmalloc() error tracing (Dave Hansen, PeterZ, and Andy Lutomirski)
* Inlined the #NM handling code (Andy Lutomirski)
* Made signal handling optimization revertible
* Revised the new parameter handling code (Andy Lutomirski and Dave Hansen)
* Rebased on the upstream kernel

[1]: Intel Architecture Instruction Set Extension Programming Reference
    June 2020, https://software.intel.com/content/dam/develop/public/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf
[2]: https://software.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/compiler-reference/intrinsics/intrinsics-for-intel-advanced-matrix-extensions-intel-amx-instructions.html
[3]: https://lore.kernel.org/lkml/20201119190237.626-1-chang.seok.bae@intel.com/
[4]: https://lore.kernel.org/lkml/20201001203913.9125-1-chang.seok.bae@intel.com/

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
  x86/fpu/xstate: Extend the table for mapping xstate components with
    features
  x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature
    bits
  x86/fpu/amx: Define AMX state components and have it used for
    boot-time checks
  x86/fpu/amx: Enable the AMX feature in 64-bit mode
  selftest/x86/amx: Include test cases for the AMX state management
  x86/fpu/xstate: Support dynamic user state in the signal handling path
  x86/fpu/xstate: Introduce boot-parameters for control some state
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
 arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
 arch/x86/kernel/fpu/core.c                    |  70 +-
 arch/x86/kernel/fpu/init.c                    | 108 ++-
 arch/x86/kernel/fpu/regset.c                  |  65 +-
 arch/x86/kernel/fpu/signal.c                  |  41 +-
 arch/x86/kernel/fpu/xstate.c                  | 487 ++++++++++--
 arch/x86/kernel/process.c                     |  11 +
 arch/x86/kernel/process_32.c                  |   2 +-
 arch/x86/kernel/process_64.c                  |   2 +-
 arch/x86/kernel/traps.c                       |  40 +
 arch/x86/kvm/x86.c                            |  43 +-
 arch/x86/mm/pkeys.c                           |   2 +-
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/amx.c             | 736 ++++++++++++++++++
 24 files changed, 1650 insertions(+), 228 deletions(-)
 create mode 100644 tools/testing/selftests/x86/amx.c

-- 
2.17.1

