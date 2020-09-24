Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E24276F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIXLGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:06:17 -0400
Received: from foss.arm.com ([217.140.110.172]:42210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbgIXLGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:06:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B71B613D5;
        Thu, 24 Sep 2020 04:06:14 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D50F3F73B;
        Thu, 24 Sep 2020 04:06:11 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        swboyd@chromium.org, catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v7 2/7] arm64: perf: Avoid PMXEV* indirection
Date:   Thu, 24 Sep 2020 12:07:01 +0100
Message-Id: <20200924110706.254996-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924110706.254996-1-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Currently we access the counter registers and their respective type
registers indirectly. This requires us to write to PMSELR, issue an ISB,
then access the relevant PMXEV* registers.

This is unfortunate, because:

* Under virtualization, accessing one register requires two traps to
  the hypervisor, even though we could access the register directly with
  a single trap.

* We have to issue an ISB which we could otherwise avoid the cost of.

* When we use NMIs, the NMI handler will have to save/restore the select
  register in case the code it preempted was attempting to access a
  counter or its type register.

We can avoid these issues by directly accessing the relevant registers.
This patch adds helpers to do so.

In armv8pmu_enable_event() we still need the ISB to prevent the PE from
reordering the write to PMINTENSET_EL1 register. If the interrupt is
enabled before we disable the counter and the new event is configured,
we might get an interrupt triggered by the previously programmed event
overflowing, but which we wrongly attribute to the event that we are
enabling. Execute an ISB after we disable the counter.

In the process, remove the comment that refers to the ARMv7 PMU.

Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[Julien T.: Don't inline read/write functions to avoid big code-size
	increase, remove unused read_pmevtypern function,
	fix counter index issue.]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
[Alexandru E.: Removed comment, removed trailing semicolons in macros,
	added ISB]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/perf_event.c | 99 +++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 481d48e3872b..cb0b85bebc41 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -348,6 +348,73 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 #define	ARMV8_IDX_TO_COUNTER(x)	\
 	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
 
+/*
+ * This code is really good
+ */
+
+#define PMEVN_CASE(n, case_macro) \
+	case n: case_macro(n); break
+
+#define PMEVN_SWITCH(x, case_macro)				\
+	do {							\
+		switch (x) {					\
+		PMEVN_CASE(0,  case_macro);			\
+		PMEVN_CASE(1,  case_macro);			\
+		PMEVN_CASE(2,  case_macro);			\
+		PMEVN_CASE(3,  case_macro);			\
+		PMEVN_CASE(4,  case_macro);			\
+		PMEVN_CASE(5,  case_macro);			\
+		PMEVN_CASE(6,  case_macro);			\
+		PMEVN_CASE(7,  case_macro);			\
+		PMEVN_CASE(8,  case_macro);			\
+		PMEVN_CASE(9,  case_macro);			\
+		PMEVN_CASE(10, case_macro);			\
+		PMEVN_CASE(11, case_macro);			\
+		PMEVN_CASE(12, case_macro);			\
+		PMEVN_CASE(13, case_macro);			\
+		PMEVN_CASE(14, case_macro);			\
+		PMEVN_CASE(15, case_macro);			\
+		PMEVN_CASE(16, case_macro);			\
+		PMEVN_CASE(17, case_macro);			\
+		PMEVN_CASE(18, case_macro);			\
+		PMEVN_CASE(19, case_macro);			\
+		PMEVN_CASE(20, case_macro);			\
+		PMEVN_CASE(21, case_macro);			\
+		PMEVN_CASE(22, case_macro);			\
+		PMEVN_CASE(23, case_macro);			\
+		PMEVN_CASE(24, case_macro);			\
+		PMEVN_CASE(25, case_macro);			\
+		PMEVN_CASE(26, case_macro);			\
+		PMEVN_CASE(27, case_macro);			\
+		PMEVN_CASE(28, case_macro);			\
+		PMEVN_CASE(29, case_macro);			\
+		PMEVN_CASE(30, case_macro);			\
+		default: WARN(1, "Invalid PMEV* index\n");	\
+		}						\
+	} while (0)
+
+#define RETURN_READ_PMEVCNTRN(n) \
+	return read_sysreg(pmevcntr##n##_el0)
+static unsigned long read_pmevcntrn(int n)
+{
+	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
+	return 0;
+}
+
+#define WRITE_PMEVCNTRN(n) \
+	write_sysreg(val, pmevcntr##n##_el0)
+static void write_pmevcntrn(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
+}
+
+#define WRITE_PMEVTYPERN(n) \
+	write_sysreg(val, pmevtyper##n##_el0)
+static void write_pmevtypern(int n, unsigned long val)
+{
+	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
+}
+
 static inline u32 armv8pmu_pmcr_read(void)
 {
 	return read_sysreg(pmcr_el0);
@@ -376,17 +443,11 @@ static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
 }
 
-static inline void armv8pmu_select_counter(int idx)
+static inline u32 armv8pmu_read_evcntr(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
-	write_sysreg(counter, pmselr_el0);
-	isb();
-}
 
-static inline u64 armv8pmu_read_evcntr(int idx)
-{
-	armv8pmu_select_counter(idx);
-	return read_sysreg(pmxevcntr_el0);
+	return read_pmevcntrn(counter);
 }
 
 static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
@@ -458,8 +519,9 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
 
 static inline void armv8pmu_write_evcntr(int idx, u64 value)
 {
-	armv8pmu_select_counter(idx);
-	write_sysreg(value, pmxevcntr_el0);
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+
+	write_pmevcntrn(counter, value);
 }
 
 static inline void armv8pmu_write_hw_counter(struct perf_event *event,
@@ -494,9 +556,10 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
-	armv8pmu_select_counter(idx);
+	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+
 	val &= ARMV8_PMU_EVTYPE_MASK;
-	write_sysreg(val, pmxevtyper_el0);
+	write_pmevtypern(counter, val);
 }
 
 static inline void armv8pmu_write_event_type(struct perf_event *event)
@@ -516,7 +579,10 @@ static inline void armv8pmu_write_event_type(struct perf_event *event)
 		armv8pmu_write_evtype(idx - 1, hwc->config_base);
 		armv8pmu_write_evtype(idx, chain_evt);
 	} else {
-		armv8pmu_write_evtype(idx, hwc->config_base);
+		if (idx == ARMV8_IDX_CYCLE_COUNTER)
+			write_sysreg(hwc->config_base, pmccfiltr_el0);
+		else
+			armv8pmu_write_evtype(idx, hwc->config_base);
 	}
 }
 
@@ -555,6 +621,11 @@ static inline void armv8pmu_enable_event_counter(struct perf_event *event)
 static inline void armv8pmu_disable_counter(u32 mask)
 {
 	write_sysreg(mask, pmcntenclr_el0);
+	/*
+	 * Make sure the effects of disabling the counter are visible before we
+	 * start configuring the event.
+	 */
+	isb();
 }
 
 static inline void armv8pmu_disable_event_counter(struct perf_event *event)
@@ -627,7 +698,7 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	armv8pmu_disable_event_counter(event);
 
 	/*
-	 * Set event (if destined for PMNx counters).
+	 * Set event.
 	 */
 	armv8pmu_write_event_type(event);
 
-- 
2.28.0

