Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC1276F49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgIXLGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXLGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:06:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF252113E;
        Thu, 24 Sep 2020 04:06:08 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 915C43F73B;
        Thu, 24 Sep 2020 04:06:07 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        swboyd@chromium.org, catalin.marinas@arm.com, will@kernel.org
Subject: [PATCH v7 0/7] arm_pmu: Use NMI for perf interrupt
Date:   Thu, 24 Sep 2020 12:06:59 +0100
Message-Id: <20200924110706.254996-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series changes the arm_pmu driver to use NMIs for the perf interrupt
when NMIs are available on the platform (currently, only arm64 + GICv3). To
make it easier to play with the patches, I've pushed a branch at [1]:

$ git clone -b pmu-nmi-v7 git://linux-arm.org/linux-ae

The changes from v6 were minor, but I've still run the same tests on an
espressobin v7*. These are the results of running perf record -a -- sleep
60 (all results show kernel symbols with overhead >= 1%):

1. Without the patches:

    11.14%  [k] _raw_spin_unlock_irq
     9.09%  [k] _raw_spin_unlock_irqrestore
     8.55%  [k] arch_cpu_idle
     2.60%  [k] __softirqentry_text_start
     1.13%  [k] arch_counter_get_cntpct
     1.13%  [k] tick_nohz_idle_exit
     1.09%  [k] el0_svc_common.constprop.0
    [..]

2. Using NMIs:

     9.46%  [k] arch_counter_get_cntpct
     5.59%  [k] wait_for_xmitr
     3.78%  [k] ktime_get
     3.63%  [k] __delay
     1.54%  [k] _raw_write_lock_irqsave
     1.29%  [k] arch_timer_evtstrm_available
     1.24%  [k] _raw_spin_lock_irqsave
     1.11%  [k] refresh_cpu_vm_stats
     1.06%  [k] __schedule
     1.03%  [k] _find_next_bit.constprop.0
     [..]

When running perf record -a -- iperf3 -c 127.0.0.1 -t 60:

1. Without the patches:

    25.46%  [k] __arch_copy_from_user
    24.06%  [k] __arch_copy_to_user
     4.17%  [k] _raw_spin_unlock_irq
     2.52%  [k] _raw_spin_unlock_irqrestore
     1.90%  [k] __free_pages_ok
     1.22%  [k] get_page_from_freelist
     1.21%  [k] arch_cpu_idle
     1.19%  [k] tcp_ack
    [..]

2. Using NMIs:

    23.94%  [k] __arch_copy_from_user
    21.65%  [k] __arch_copy_to_user
     1.19%  [k] tcp_ack
    [..]

I've run the same tests in a VM when both host+guest use NMIs, and when
they don't. All of these tests were also ran on the model. Similar results
in all cases.

* All the firmware versions for espressobin v7 that I've tried clear
SCR_EL3.FIQ, which means that NMIs don't work with the upstream kernel.  To
test the series, I've applied the patches from irq/irqchip-next to enable
pseudo-NMIs when SCR_EL3.FIQ == 0. I've also pushed a branch [2] with the
patches applied on top of this series:

$ git clone -b pmu-nmi-v7-nmi-fiq-clear-v3 git://linux-arm.org/linux-ae

Summary of the patches:
* Patch 1 is a fix for a bug that Julien found during the review for v4.
* Patches 2 and 3 remove locking from arm64 perf event code.
* Patches 4 and 5 makes the arm64 PMU interrupt handler NMI safe.
* Patches 6 and 7 enable the use of NMIs on arm64 with a GICv3 irqchip.

Changes since v6 [3]:
- Rebased on top of v5.9-rc6
- Moved the ISBs to armv8pmu_{enable, disable}_counter()
- Added irq_work_sync() to kvm_pmu_vcpu_destroy()
- Reworked armpmu_find_irq_ops() as per Will's suggestion
- Print message when NMIs are used by the PMU
- The changes were minor, so I've added the Tested-by tag for v6 from Sumit
  Garg. Many thanks for the testing!

Changes since v5 [4]:
- Rebased on top of v5.9-rc1.
- Typo fixes.
- Added comments to the ISB added by patches #1 and #2.
- Reworded message for patch #4, as per Mark's excellent suggestion.

Changes since v4 [5]:
- Rebased on top of v5.8-rc1 and dropped the Tested-by tags because it's
  been almost a year since the series has been tested.
- Dropped patch 3 because I couldn't find any instance where
  armv7pmu_read_counter() was called with interrupts enabled. I've also
  tested this by running several instances of perf for a few hours, and the
  function was called every time with interrupts disabled.
- Dropped patches 4 and 5 because the tradeoff wasn't worth it in my
  opinion: the irq handler was slower all the time (because it
  saved/restored the counter select register), in exchange for being
  slightly faster on the rare ocassions when it triggered at the beginning
  of the critical sections.
- Minor changes here and there to address review comments.

Changes since v3 [6]:
- Added tags
- Fix build issue for perf_event_v6
- Don't disable preemption in pmu->enable()
- Always rely on IPI_IRQ_WORK to run the queued work
- Fixed typos + cleanups

Changes since v2 [7]:
- Rebased on recent linux-next (next-20190708)
- Fixed a number of bugs with indices (reported by Wei)
- Minor style fixes

Changes since v1 [8]:
- Rebased on v5.1-rc1
- Pseudo-NMI has changed a lot since then, use the (now merged) NMI API
- Remove locking from armv7 perf_event
- Use locking only in armv6 perf_event
- Use direct counter/type registers insted of selector register for armv8

[1] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/pmu-nmi-v7
[2] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/pmu-nmi-v7-nmi-fiq-clear-v3
[3] https://lkml.org/lkml/2020/8/19/671
[4] https://www.spinics.net/lists/kernel/msg3554236.html
[5] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/666824.html
[6] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/665339.html
[7] https://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/640536.html
[8] https://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554611.html

Alexandru Elisei (1):
  arm64: perf: Add missing ISB in armv8pmu_enable_counter()

Julien Thierry (5):
  arm64: perf: Remove PMU locking
  arm64: perf: Defer irq_work to IPI_IRQ_WORK
  KVM: arm64: pmu: Make overflow handler NMI safe
  arm_pmu: Introduce pmu_irq_ops
  arm_pmu: arm64: Use NMIs for PMU

Mark Rutland (1):
  arm64: perf: Avoid PMXEV* indirection

 arch/arm64/kernel/perf_event.c | 146 ++++++++++++++++++++-----------
 arch/arm64/kvm/pmu-emul.c      |  26 +++++-
 drivers/perf/arm_pmu.c         | 155 ++++++++++++++++++++++++++++-----
 include/kvm/arm_pmu.h          |   1 +
 4 files changed, 255 insertions(+), 73 deletions(-)

-- 
2.28.0

