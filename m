Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC310203CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgFVQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 12:44:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:18796 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbgFVQoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:44:06 -0400
IronPort-SDR: YsJmCxZnfDlFqaBTXHMSWK9CUgV1Fx53etC6V79yzRbUCM3XTUiDGSSJhCQV1ipcQ56syPEPKP
 H72fsdx3n30Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="143772323"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="143772323"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 09:44:05 -0700
IronPort-SDR: fMpi67WRzppWgoJWeDaythnS6Tm4mTPcrUWhJdg3iReJv1ZEm3+IAkQ2sSkK0gQ1zV3iiPJPHw
 0md1efhKroQQ==
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="281020585"
Received: from rchatre-mobl1.jf.intel.com ([10.54.70.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 09:44:04 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 0/4] x86/resctrl: Enable user to view and select thread throttling mode
Date:   Mon, 22 Jun 2020 09:43:27 -0700
Message-Id: <cover.1592841671.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V6 upstream submission available from:
https://lore.kernel.org/lkml/cover.1589922949.git.reinette.chatre@intel.com

Patches apply against v5.8-rc2
base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110

Changes since V6:
- Rebase against v5.8-rc2
- Add Andy's Reviewed-by tag to patch 4

V5 upstream submission available from:
https://lore.kernel.org/lkml/cover.1589844108.git.reinette.chatre@intel.com

Patches apply against x86/cache branch commit 0c4d5ba1b998e of tip repo at
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Changes since V5:
- Remove the early check of the sysfs_match_string() return code. (Andy)

V4 upstream submission available from:
https://lore.kernel.org/lkml/cover.1589652468.git.reinette.chatre@intel.com

Patches apply against x86/cache branch commit 0c4d5ba1b998e of tip repo at
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Changes since V4:
- Pick up Babu's "Reviewed-by" tags.
- Three checks are performed before the MBA_CFG register is updated from
  its cache. Move all checks to the same if statement. (Babu)
- Remove unnecessary return statement when there is only a switch statement
  in the function that is already handling all cases. (Babu)
- Remove "mode" local variable from rdtgroup_mode_write(). This variable
  was previously used to create shorter lines with the original strcmp()
  code that was removed in patch 4/4.
- Andy pointed out that the repeated assignment to rdtgrp->mode could be
  replaced by a single assignment after all the checks. This was initially
  rejected because it would let the "RDT_MODE_PSEUDO_LOCKED" assignment
  slip through. Even so, Andy's feedback revealed that the new changes
  unintentionally let a user's attempt at setting the mode to pseudo-locked
  be silently ignored where it previously reported an error. Restore original
  user space behavior by returning success when user attempts to change any
  mode when it is already the current mode (including pseudo-locked) and
  returning failure when user attempts to set the mode to pseudo-locked.
  After this change it is possible to follow Andy's original suggestion
  of using a single assignment. (Andy)

V3 upstream submission available from:
https://lore.kernel.org/lkml/cover.1588808537.git.reinette.chatre@intel.com

Patches apply against x86/cache branch of tip repo at
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Changes since V3:
- Maintain the thread throttling mode as a property ("arch_throttle_mode")
  of the memory bandwidth allocation resource
  instead of calling a function that queries the system's model each time
  this information is needed. Use this new property generically throughout
  with the goal of being independent of architecture. (Babu)
- Remove "intel" from thread_throttle_mode_init_intel_rw() and
  thread_throttle_mode_init_intel_ro() in anticipation of usage by other
  architectures.
- Use function parameter to update_mba_cfg() directly instead of having
  local variable point to it. (Fenghua)
- Remove unnecessary additional check whether platform supports feature
  from the "thread_throttle_mode" callback. The file will only be
  accessible on platforms that support the feature.
- Rework commit message of first patch to be more complete regarding
  support of all architectures after incorporating AMD feedback.
- View the thread throttle mode with rdtgroup mutex held since it is using
  cached information that may be changed concurrently.
- Remove unnecessary empty line. (Babu)

V2 upstream submission available from:
https://lore.kernel.org/lkml/cover.1586801373.git.reinette.chatre@intel.com

Changes since V2:
- Rebase on top of recently merged series "x86/resctrl: Support wider
  MBM counters". Small change needed to take into account
  asm/resctrl_sched.h -> asm/resctrl.h name change.
- Fix rST formatting of documentation (resctrl_ui.rst) describing
  new "thread_throttle_mode" resctrl file.
- Use boot_cpu_has() instead of static_cpu_has() when determining what
  to display to user (slow path).

V1 upstream submission available from:
https://lore.kernel.org/lkml/cover.1585765499.git.reinette.chatre@intel.com

A notable change since V1 is the inclusion of two additional patches from
Fenghua Yu that introduce the new per-thread MBA feature. These changes are
added to this series because they are small and closely related to the
original submission. The per-thread MBA feature is a hardware advancement
that requires no software interface changes. The patches added just enumerate
the feature and expose it to userspace by showing "per-thread" in the new
resctrl file "thread_throttle_mode" to help user applications fine tune
performance.

There are currently a few resctrl changes outstanding for upstream inclusion.
To support their consideration all outstanding resctrl patches can be
viewed at https://github.com/rchatre/linux.git (branch resctrl/next)

Changes since V1 (also documented within patches to which they apply):
- Rebased on top of James Morse's CDP fix
(https://lore.kernel.org/lkml/20200221162105.154163-1-james.morse@arm.com)
- Remove RF_UNINITIALIZED (having uninitialized be represented with ones
  creates too much confusion), replace with an explicit check of rft->fflags
  in rdtgroup_add_files() (Fenghua Yu)
- Rename MBA_THREAD_THROTTLE_MODE to MBA_THROTTLE_MODE_MASK to clarify its
  use as a mask (Tony Luck)
- Introduce explicit MBA_THROTTLE_MODE_MAX instead of implying it is the
  opposite of min and use these values (min and max) explicitly whenever
  testing/setting the throttle mode value (Tony Luck)
- Add __init attribute to thread_throttle_mode_init_intel_rw() and
  thread_throttle_mode_init_intel_ro() since they are only needed during
  initialization (Fenghua Yu)
- Remove MBA_CFG MSR reads and error checking so that the patch is simpler
  and easier to review (Fenghua Yu)
- Ensure CPU hotplug lock is taken when writing register on multiple CPUs (Fenghua Yu)
- Use CPU mask already maintained as part of domains to determine which
  CPUs to update MBA register on (Fenghua Yu)
- Maintain MBA configuration register contents to support use case when not
  all CPUs of a package are online when configuration is set from user
  space
- Use seq_puts() instead of seq_printf() when simple strings are printed
- Set MBA configuration to default when resctrl is unmounted
- Complete rewrite of "thread_throttle_mode" documentation (Tony Luck)
- Remove unnecessary checks on user input (Andy Shevchenko)
- Change code style surrounding usage of sysfs_match_string() (Andy Shevchenko)

From V1 submission:

The first patch in this series introduces a new resctrl file,
"thread_throttle_mode", on Intel systems that exposes to the
user how per-thread values are allocated to a core. This is added in
support of newer Intel systems that can be configured to allocate
either maximum or minimum throttling of the per-thread CLOS values
to the core.

Details about the feature can be found in the commit description and
in Chapter 9 of the most recent Intel ISE available from
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

The first patch parses user input with the appropriate sysfs API that has
not previously been used in resctrl. The second (later in the fourth) patch is
added as a subsequent cleanup that switches existing resctrl string parsing
code to also use this appropriate API.

Fenghua Yu (2):
  x86/resctrl: Enumerate per-thread MBA
  x86/resctrl: Enable per-thread MBA

Reinette Chatre (2):
  x86/resctrl: Enable user to view and select thread throttling mode
  x86/resctrl: Use appropriate API for strings terminated by newline

 Documentation/x86/resctrl_ui.rst       |  22 ++-
 arch/x86/include/asm/cpufeatures.h     |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c       |   1 +
 arch/x86/kernel/cpu/resctrl/core.c     |  52 ++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  49 +++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 235 +++++++++++++++++++++++--
 arch/x86/kernel/cpu/scattered.c        |   1 +
 7 files changed, 335 insertions(+), 26 deletions(-)

-- 
2.26.2

