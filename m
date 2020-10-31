Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC352A11E9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 01:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJaA1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 20:27:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:24067 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJaA1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 20:27:53 -0400
IronPort-SDR: m9/GxqAQraEtEekYzt+V6sb68YWpSJtzWr2qvFpQKNBALJRf8kTQ2QzNVql1WWb6TYwYJCMYFk
 S6Mv9hl+SXCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230318023"
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="scan'208";a="230318023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 17:27:53 -0700
IronPort-SDR: MQlrTZMYLXGOeRlKjMOe8kvXP6V7s+AUaJYIEoF0cDAgfKNVho4uRVnXjzicC8hJ+69Ow5snBy
 j+KJTo3cZGOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="scan'208";a="469683903"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 17:27:52 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH RFC v3 0/4] x86/bus_lock: Enable bus lock detection
Date:   Sat, 31 Oct 2020 00:27:10 +0000
Message-Id: <20201031002714.3649728-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus lock [1] is acquired either through split locked access to
writeback (WB) memory or by using locks to uncacheable (UC) memory
(e.g. direct device assignment). This is typically >1000 cycles slower
than an atomic operation within a cache line. It also disrupts performance
on other cores.

Although split lock can be detected by #AC trap, the trap is triggered
before the instruction acquires bus lock. This makes it difficult to
mitigate bus lock (e.g. throttle the user application).

Some CPUs have ability to notify the kernel by an #DB trap after a user
instruction acquires a bus lock and is executed. This allows the kernel
to enforce user application throttling or mitigations.

#DB for bus lock detect fixes issues in #AC for split lock detect:
1) It's architectural ... just need to look at one CPUID bit to know it
   exists
2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
   So each process or guest can have different behavior.
3) It has support for VMM/guests (new VMEXIT codes, etc).

Hardware only generates #DB for bus lock detect when CPL>0 to avoid
nested #DB from multiple bus locks while the first #DB is being handled.

Use the existing kernel command line option "split_lock_detect=" to handle
#DB for bus lock:

split_lock_detect=
		#AC for split lock		#DB for bus lock

off		Do nothing			Do nothing

warn		Kernel OOPs			Warn once per task and
		Warn once per task and		and continues to run.
		disable future checking 	When both features are
						supported, warn in #DB

fatal		Kernel OOPs			Send SIGBUS to user
		Send SIGBUS to user
		When both features are
		supported, fatal in #AC.

ratelimit:N	Do nothing			Limit bus lock rate to
						N per second in the
						current non root user.

Default split_lock_detect is "warn".

[1] Chapter 8 https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Change Log:
RFC v3:
- Remove DR6_RESERVED change (PeterZ).
- Simplify the documentation (Randy).

RFC v2:
- Architecture changed based on feedback from Thomas and PeterZ. #DB is
  no longer generated for bus lock in ring0.
- Split the one single patch into four patches.
[RFC v1 can be found at: https://lore.kernel.org/lkml/1595021700-68460-1-git-send-email-fenghua.yu@intel.com/]

Fenghua Yu (4):
  x86/cpufeatures: Enumerate #DB for bus lock detection
  x86/bus_lock: Handle warn and fatal in #DB for bus lock
  x86/bus_lock: Set rate limit for bus lock
  Documentation/admin-guide: Change doc for split_lock_detect parameter

 .../admin-guide/kernel-parameters.txt         |  28 +++-
 arch/x86/include/asm/cpu.h                    |  10 +-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/include/uapi/asm/debugreg.h          |   1 +
 arch/x86/kernel/cpu/common.c                  |   2 +-
 arch/x86/kernel/cpu/intel.c                   | 145 +++++++++++++++---
 arch/x86/kernel/traps.c                       |   7 +
 include/linux/sched/user.h                    |   4 +-
 kernel/user.c                                 |   7 +
 10 files changed, 176 insertions(+), 30 deletions(-)

-- 
2.29.1

