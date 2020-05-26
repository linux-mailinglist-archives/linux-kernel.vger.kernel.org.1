Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD05C1CF7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgELOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 10:55:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:29538 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgELOzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:09 -0400
IronPort-SDR: RQOjAsQsZ6enswCI8hngDKcMaDoJJxmXjEv5zrZNgqsgRkJHuozTBMiUJf0CXr1cho/m6achLa
 oZwms69XDMtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:08 -0700
IronPort-SDR: u5C/sAfYhDNXD5BocBi1vuwMEfZssiUXSaTFAq3X9E1o4nQp94e4NxlxZy89ojyJXgKVHTU56O
 6wp7k5ATjw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587795"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 07:55:07 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 00/10] Support XSAVES supervisor states
Date:   Tue, 12 May 2020 07:54:34 -0700
Message-Id: <20200512145444.15483-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:

Cleanup commit logs.

----

Changes in v3:

This version addresses the overhead of an extra XSAVES in
__fpu__restore_sig() with additional patches:

    Patch #8: Introduce copy_supervisor_to_kernel(), which does a
              supervisor-state-only XSAVES and then relocates the contents
              to the standard location.
    Patch #9: Preserve supervisor states for __fpu__restore_sig() slow path.

Other small changes are noted in each patch's commit log.

----

Changes in v2:

- Split out small changes to:
    https://lkml.kernel.org/r/20191212210855.19260-1-yu-cheng.yu@intel.com/

- Fix an issue in patch #4, where fpu__clear_user_states() drops
  supervisor xstates.

- Add three patches:
    Patch #6: Update sanitize_restored_xstate() for supervisor xstates.
    Patch #7: Update copy_kernel_to_xregs_err() to use XRSTORS when
              supervisor xstates are present.
    Patch #8: Update __fpu__restore_sig() to preserve supervisor xstates.

Also make some small changes in response to comments.  More details are in
each patch's commit log.

----

There are two types of XSAVE-managed states (xstates): user and supervisor.
This series introduces the supervisor xstate support in preparation for new
features that will make use of supervisor xstates.

This series has been separated for ease of review from the series that add
supervisor xstate features [3].

In current and near future generations of Intel processors there are three
classes of objects that can be managed as supervisor xstates:

- Processor Trace (PT):
    Linux already supports PT, but PT xstates are not saved to the FPU
    context and not context-switched by the kernel.  There are no plans to
    integrate PT into XSAVES supervisor states.

- ENQCMD Process Address Space ID (MSR_IA32_PASID):
    ENQCMD is a new instruction and will be introduced shortly in a
    separate series [2].

- Control-flow Enforcement Technology (CET):
    CET is being reviewed on the LKML [1] [3].

Supervisor xstates can be accessed only from the kernel (PL-0) with XSAVES/
XRSTORS instructions.  They cannot be accessed with other XSAVE*/XRSTOR*
instructions.  MSR_IA32_XSS sets enabled supervisor xstates, while XCR0
sets enabled user xstates.

This series separates the two xstate types by declaring new macros for each
type.  The kernel finds all available features during system initialization
and stores them in xfeatures_mask_all.  It then retrieves perspective
xstate type with xfeatures_mask_supervisor()/xfeatures_mask_user() for
handling signals and PTRACE.

[1] Detailed information on supervisor xstates can be found in "Intel 64
    and IA-32 Architectures Software Developer's Manual":

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Detailed information on the ENQCMD instruction and MSR_IA32_PASID can
    be found in "Intel Architecture Instruction Set Extensions and Future
    Features Programming Reference":

    https://software.intel.com/sites/default/files/managed/c5/15/
    architecture-instruction-set-extensions-programming-reference.pdf

[3] CET patches:

    https://lkml.kernel.org/r/20200205181935.3712-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20200205182308.4028-1-yu-cheng.yu@intel.com/

Fenghua Yu (3):
  x86/fpu/xstate: Rename validate_xstate_header() to
    validate_user_xstate_header()
  x86/fpu/xstate: Define new macros for supervisor and user xstates
  x86/fpu/xstate: Define new functions for clearing fpregs and xstates

Yu-cheng Yu (7):
  x86/fpu/xstate: Separate user and supervisor xfeatures mask
  x86/fpu/xstate: Introduce XSAVES supervisor states
  x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor
    xstates
  x86/fpu/xstate: Update copy_kernel_to_xregs_err() for XSAVES
    supervisor states
  x86/fpu: Introduce copy_supervisor_to_kernel()
  x86/fpu/xstate: Preserve supervisor states for slow path of
    __fpu__restore_sig()
  x86/fpu/xstate: Restore supervisor states for signal return

 arch/x86/include/asm/fpu/internal.h |  10 +-
 arch/x86/include/asm/fpu/xstate.h   |  52 +++++---
 arch/x86/kernel/fpu/core.c          |  49 ++++---
 arch/x86/kernel/fpu/init.c          |   3 +-
 arch/x86/kernel/fpu/regset.c        |   2 +-
 arch/x86/kernel/fpu/signal.c        | 144 +++++++++++++-------
 arch/x86/kernel/fpu/xstate.c        | 199 +++++++++++++++++++++-------
 arch/x86/kernel/process.c           |   2 +-
 arch/x86/kernel/signal.c            |   2 +-
 9 files changed, 334 insertions(+), 129 deletions(-)

-- 
2.21.0

