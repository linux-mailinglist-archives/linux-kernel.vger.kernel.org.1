Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF92C6040
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392642AbgK0G76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:59:58 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:42238 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbgK0G75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606460396; x=1637996396;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+FEJv1fQ39z8JgnZf/P2HXjJYzj/7OE2CjbzTdcAj1U=;
  b=R3A0hMyGFyT0ru11u430YQDifeHa09xvKuOrf9o2RntJZJHay3d2UJHw
   MKjnEoJrtSs84W5cx9NHwc0AAXA6EZdRZTQmBgp7RTkj/7ZR1yXRwUPWC
   q+nJDSV3xHsjL/KohxIfS3zMzuDVCM2JSlfKgRi0Bpv9rTy87Gr225XYo
   E=;
X-IronPort-AV: E=Sophos;i="5.78,373,1599523200"; 
   d="scan'208";a="91359367"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Nov 2020 06:59:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id B4D4AA1FFC;
        Fri, 27 Nov 2020 06:59:48 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:48 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:48 +0000
Received: from localhost (10.85.0.203) by mail-relay.amazon.com (10.43.60.234)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 27 Nov
 2020 06:59:46 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v3 0/5] Next revision of the L1D flush patches
Date:   Fri, 27 Nov 2020 17:59:33 +1100
Message-ID: <20201127065938.8200-1-sblbir@amazon.com>
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
3. Provide an override to disable this mechanism completely
4. Be SMT aware in the implementation

The patches support a use case where the entire system is not in
non SMT mode, but rather a few CPUs can have their SMT turned off
and processes that want to opt-in are expected to run on non SMT
cores. This gives the administrator complete control over setting
up the mitigation for the issue. In addition, the administrator
has a boot time override (l1d_flush_out=off) to turn of the mechanism
completely.

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

Changelog v3:
- Implement the SIGBUS mechansim
- Update and fix the documentation

Balbir Singh (5):
  x86/mm: change l1d flush runtime prctl behaviour
  x86/mm: Refactor cond_ibpb() to support other use cases
  x86/mm: Optionally flush L1D on context switch
  prctl: Hook L1D flushing in via prctl
  Documentation: Add L1D flushing Documentation

 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         |  69 ++++++++++++
 .../admin-guide/kernel-parameters.txt         |  17 +++
 Documentation/userspace-api/spec_ctrl.rst     |   8 ++
 arch/Kconfig                                  |   4 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/cacheflush.h             |   8 ++
 arch/x86/include/asm/processor.h              |   2 +
 arch/x86/include/asm/thread_info.h            |   9 +-
 arch/x86/include/asm/tlbflush.h               |   2 +-
 arch/x86/kernel/cpu/bugs.c                    |  54 +++++++++
 arch/x86/kernel/smpboot.c                     |  11 +-
 arch/x86/mm/tlb.c                             | 105 ++++++++++++++----
 include/linux/sched.h                         |  10 ++
 include/uapi/linux/prctl.h                    |   1 +
 15 files changed, 274 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

-- 
2.17.1

