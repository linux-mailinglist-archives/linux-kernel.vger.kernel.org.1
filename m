Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0109F276F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgIXLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:06:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgIXLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:06:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79415113E;
        Thu, 24 Sep 2020 04:06:17 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03CCA3F73B;
        Thu, 24 Sep 2020 04:06:14 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        swboyd@chromium.org, catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 3/7] arm64: perf: Remove PMU locking
Date:   Thu, 24 Sep 2020 12:07:02 +0100
Message-Id: <20200924110706.254996-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924110706.254996-1-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

The PMU is disabled and enabled, and the counters are programmed from
contexts where interrupts or preemption is disabled.

The functions to toggle the PMU and to program the PMU counters access the
registers directly and don't access data modified by the interrupt handler.
That, and the fact that they're always called from non-preemptible
contexts, means that we don't need to disable interrupts or use a spinlock.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
[Alexandru E.: Explained why locking is not needed, removed WARN_ONs]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/perf_event.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb0b85bebc41..610500166f90 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -682,15 +682,10 @@ static inline u32 armv8pmu_getreset_flags(void)
 
 static void armv8pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -711,21 +706,10 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter
 	 */
 	armv8pmu_enable_event_counter(event);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	/*
-	 * Disable counter and interrupt
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
 	/*
 	 * Disable counter
 	 */
@@ -735,30 +719,18 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 * Disable interrupt for this counter
 	 */
 	armv8pmu_disable_event_irq(event);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
-- 
2.28.0

