Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCEA2C3235
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgKXUwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:52:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:40532 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbgKXUwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:52:54 -0500
IronPort-SDR: T7JVoUKcKNP0wqNwlRSni2IeWzYY146AzTVc614+XQa/LJn90tgua3ARmWgZyTFMAEtOid1pl5
 DoADM+e+0VRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="190147108"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="190147108"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:52:54 -0800
IronPort-SDR: bKWpTZwkezQLOmODUclYrlWAaTkhviTk1zxovF0F/jVczH4lfx4jkeF9xSEnnC5gV3Cit1tQ9q
 Z8LxtPQQCgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="432729538"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 12:52:53 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 0/4] x86/bus_lock: Enable bus lock detection
Date:   Tue, 24 Nov 2020 20:52:41 +0000
Message-Id: <20201124205245.4164633-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus lock [1] is acquired through either split locked access to
writeback (WB) memory or any locked access to non-WB memory. This is
typically >1000 cycles slower than an atomic operation within
a cache line. It also disrupts performance on other cores.

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
4) It detects not only split locks but also bus locks from non-WB.

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

fatal		Kernel OOPs			Send SIGBUS to user.
		Send SIGBUS to user		When both features are
						supported, split lock
						triggers #AC and bus lock
						from non-WB triggers #DB.

ratelimit:N	Do nothing			Limit bus lock rate to
						N per second in the
						current non-root user.

Default split_lock_detect is "warn".

[1] Intel Instruction Set Extension Chapter 8: https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Change Log:
v4:
- Fix a ratelimit wording issue in the doc (Randy).
- Patch 4 is acked by Randy (Randy).

v3:
- Enable Bus Lock Detection when fatal to handle bus lock from non-WB
  (PeterZ).
- Add Acked-by: PeterZ in patch 2.

v2:
- Send SIGBUS in fatal case for bus lock #DB (PeterZ).

v1:
- Check bus lock bit by its positive polarity (Xiaoyao).
- Fix a few wording issues in the documentation (Randy).
[RFC v3 can be found at: https://lore.kernel.org/patchwork/cover/1329943/]

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

 .../admin-guide/kernel-parameters.txt         |  30 +++-
 arch/x86/include/asm/cpu.h                    |   9 +-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/include/uapi/asm/debugreg.h          |   1 +
 arch/x86/kernel/cpu/common.c                  |   2 +-
 arch/x86/kernel/cpu/intel.c                   | 155 +++++++++++++++---
 arch/x86/kernel/traps.c                       |   7 +
 include/linux/sched/user.h                    |   4 +-
 kernel/user.c                                 |   7 +
 10 files changed, 185 insertions(+), 32 deletions(-)

-- 
2.29.2

