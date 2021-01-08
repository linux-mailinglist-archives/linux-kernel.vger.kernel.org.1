Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76F2EF20F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAHML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:11:58 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:15811 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAHML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610107916; x=1641643916;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Z29bpTlTJXmfjEr5OxKwymvL0iqXu9IeOWWabrKSkR8=;
  b=FSboSYtRhyizlguD5gCGw20GhxzNJRBn/kRHO+KKfOcA7LuCsCH+R6iu
   IgENyl0Us9vcPaOpWcd/N9kOrm5Z9nVKJrJLp9xciWPyA3x8XzLYFsfMX
   r0kYTZOai+AGoKaoB1BcB0R5q1ap2gPnk9T8Ec0O+fEIUq/kuRh/tsd8D
   g=;
X-IronPort-AV: E=Sophos;i="5.79,330,1602547200"; 
   d="scan'208";a="110540357"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Jan 2021 12:11:10 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id B487CA253B;
        Fri,  8 Jan 2021 12:11:06 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:05 +0000
Received: from localhost (10.85.0.12) by mail-relay.amazon.com (10.43.160.118)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 8 Jan
 2021 12:11:04 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v4 0/5] Next revision of the L1D flush patches
Date:   Fri, 8 Jan 2021 23:10:51 +1100
Message-ID: <20210108121056.21940-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a mechanism that allows tasks to conditionally flush
their L1D cache (mitigation mechanism suggested in [2]). The previous
posts of these patches were sent for inclusion (see [3]) and were not
included due to the concern for the need for additional checks,
those checks were:

1. Implement this mechanism only for CPUs affected by the L1TF bug
2. Disable the software fallback
3. Provide an override to enable this mechanism
4. Be SMT aware in the implementation

The patches support a use case where the entire system is not in
non SMT mode, but rather a few CPUs can have their SMT turned off
and processes that want to opt-in are expected to run on non SMT
cores. This gives the administrator complete control over setting
up the mitigation for the issue. In addition, the administrator
has a boot time override (l1d_flush=on) to turn on the mechanism
without which this mechanism will not work.

To implement these efficiently, a new per cpu view of whether the core
is in SMT mode or not is implemented in patch 1. The code is refactored
in patch 2 so that the existing code can allow for other speculation
related checks when switching mm between tasks, this mechanism has not
changed since the last post. The ability to flush L1D for tasks if the
TIF_SPEC_L1D_FLUSH bit is set and the task has context switched out of a
non SMT core is provided by patch 3. Hooks for the user space API, for
this feature to be invoked via prctl are provided in patch 4, along with
the checks described above (1, 2, and 3). Documentation updates are in
patch 5, with updates on l1d_flush, the prctl changes and updates to the
kernel-parameters (l1d_flush_out).

The checks for opting into L1D flushing are:
	a. If the CPU is affected by L1TF
        b. Hardware L1D flush mechanism is available

A task running on a core with SMT enabled and opting into this feature will
receive a SIGBUS.

References
[1] https://software.intel.com/security-software-guidance/software-guidance/snoop-assisted-l1-data-sampling
[2] https://software.intel.com/security-software-guidance/insights/deep-dive-snoop-assisted-l1-data-sampling
[3] https://lkml.org/lkml/2020/6/2/1150
[4] https://lore.kernel.org/lkml/20200729001103.6450-1-sblbir@amazon.com/
[5] https://lore.kernel.org/lkml/20201117234934.25985-2-sblbir@amazon.com/

Reviewers guide to v4
- The key patch in the series and most of the changes to this
  revision are to patch 4. patches 3 and 5 have been modified
  to keep them consistent with the changes to patch 4.

Changelog v4:
- Use a static key to enable the mechanism (remove overheads)
- By default have the mechanism turned off, so there are two
  opt-ins needed, one by the administrator at boot time, second
  by the application
- Rename l1d_flush_out/L1D_FLUSH_OUT to l1d_flush/L1D_FLUSH
- Implement other review recommendations
Changelog v3:
- Implement the SIGBUS mechansim
- Update and fix the documentation


Balbir Singh (5):
  x86/smp: Add a per-cpu view of SMT state
  x86/mm: Refactor cond_ibpb() to support other use cases
  x86/mm: Optionally flush L1D on context switch
  prctl: Hook L1D flushing in via prctl
  Documentation: Add L1D flushing Documentation

 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         | 70 +++++++++++++++
 .../admin-guide/kernel-parameters.txt         | 17 ++++
 Documentation/userspace-api/spec_ctrl.rst     |  8 ++
 arch/Kconfig                                  |  4 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/cacheflush.h             |  8 ++
 arch/x86/include/asm/nospec-branch.h          |  2 +
 arch/x86/include/asm/processor.h              |  2 +
 arch/x86/include/asm/thread_info.h            |  6 +-
 arch/x86/include/asm/tlbflush.h               |  2 +-
 arch/x86/kernel/cpu/bugs.c                    | 71 +++++++++++++++
 arch/x86/kernel/smpboot.c                     | 10 ++-
 arch/x86/mm/tlb.c                             | 88 ++++++++++++++-----
 include/linux/sched.h                         | 10 +++
 include/uapi/linux/prctl.h                    |  1 +
 16 files changed, 273 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

-- 
2.17.1

