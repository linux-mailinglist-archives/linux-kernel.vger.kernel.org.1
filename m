Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22761223DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGQOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:07:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:11841 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgGQOH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:29 -0400
IronPort-SDR: S0JcLrkRZ+NQY8t2ikBB8S5nap5GhIjnuBZDGzBcvnun8U6vsPhz6PQpnMnVxnO4SvJnlqBn4x
 tqQXlPhi/alQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722815"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:27 -0700
IronPort-SDR: RGu/W7GYMGbgPsbB75qA4TM0MwSK29k0qVP7VPyurHWZFQ3SAn14a4qzbRlPnWmR9sxV6M/4m2
 ekCJ5c5LcY6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856493"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:27 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice Lake
Date:   Fri, 17 Jul 2020 07:05:49 -0700
Message-Id: <20200717140554.22863-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Ice Lake supports the hardware TopDown metrics feature, which can free
up the scarce GP counters.

Update the event constraints for the metrics events. The metric counters
do not exist, which are mapped to a dummy offset. The sharing between
multiple users of the same metric without multiplexing is not allowed.

Implement set_topdown_event_period for Ice Lake. The values in
PERF_METRICS MSR are derived from the fixed counter 3. Both registers
should start from zero.

Implement update_topdown_event for Ice Lake. The metric is reported by
multiplying the metric (fraction) with slots. To maintain accurate
measurements, both registers are cleared for each update. The fixed
counter 3 should always be cleared before the PERF_METRICS.

Implement td_attr for the new metrics events and the new slots fixed
counter. Make them visible to the perf user tools.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 124 ++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h      |  13 ++++
 arch/x86/include/asm/msr-index.h  |   2 +
 arch/x86/include/asm/perf_event.h |   2 +
 4 files changed, 141 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bc0f9dcb552c..cd622b69e882 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -247,6 +247,10 @@ static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x03, 0x0a, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x1f, 0x28, 0xf),
 	INTEL_EVENT_CONSTRAINT(0x32, 0xf),	/* SW_PREFETCH_ACCESS.* */
@@ -309,6 +313,12 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles, td_recovery_bubbles,
 EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
+EVENT_ATTR_STR(slots,			slots,		"event=0x00,umask=0x4");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring,	"event=0x00,umask=0x10");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,	"event=0x00,umask=0x11");
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,	"event=0x00,umask=0x12");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,	"event=0x00,umask=0x13");
+
 static struct attribute *snb_events_attrs[] = {
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
@@ -2232,6 +2242,105 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_pebs_del(event);
 }
 
+static int icl_set_topdown_event_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+
+	/*
+	 * The values in PERF_METRICS MSR are derived from fixed counter 3.
+	 * Software should start both registers, PERF_METRICS and fixed
+	 * counter 3, from zero.
+	 * Clear PERF_METRICS and Fixed counter 3 in initialization.
+	 * After that, both MSRs will be cleared for each read.
+	 * Don't need to clear them again.
+	 */
+	if (left == x86_pmu.max_period) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+		local64_set(&hwc->period_left, 0);
+	}
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
+{
+	u32 val;
+
+	/*
+	 * The metric is reported as an 8bit integer fraction
+	 * suming up to 0xff.
+	 * slots-in-metric = (Metric / 0xff) * slots
+	 */
+	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
+	return  mul_u64_u32_div(slots, val, 0xff);
+}
+
+static void __icl_update_topdown_event(struct perf_event *event,
+				       u64 slots, u64 metrics)
+{
+	int idx = event->hw.idx;
+	u64 delta;
+
+	if (is_metric_idx(idx))
+		delta = icl_get_metrics_event_value(metrics, slots, idx);
+	else
+		delta = slots;
+
+	local64_add(delta, &event->count);
+}
+
+/*
+ * Update all active Topdown events.
+ *
+ * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
+ * modify by a NMI. PMU has to be disabled before calling this function.
+ */
+static u64 icl_update_topdown_event(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *other;
+	u64 slots, metrics;
+	int idx;
+
+	/* read Fixed counter 3 */
+	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+	if (!slots)
+		return 0;
+
+	/* read PERF_METRICS */
+	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+
+	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+		if (!is_topdown_idx(idx))
+			continue;
+		other = cpuc->events[idx];
+		__icl_update_topdown_event(other, slots, metrics);
+	}
+
+	/*
+	 * Check and update this event, which may have been cleared
+	 * in active_mask e.g. x86_pmu_stop()
+	 */
+	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
+		__icl_update_topdown_event(event, slots, metrics);
+
+	/*
+	 * Software is recommended to periodically clear both registers
+	 * in order to maintain accurate measurements, which is required for
+	 * certain scenarios that involve sampling metrics at high rates.
+	 * Software should always write fixed counter 3 before write to
+	 * PERF_METRICS.
+	 */
+	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+	wrmsrl(MSR_PERF_METRICS, 0);
+
+	return slots;
+}
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -4461,6 +4570,15 @@ static struct attribute *icl_events_attrs[] = {
 	NULL,
 };
 
+static struct attribute *icl_td_events_attrs[] = {
+	EVENT_PTR(slots),
+	EVENT_PTR(td_retiring),
+	EVENT_PTR(td_bad_spec),
+	EVENT_PTR(td_fe_bound),
+	EVENT_PTR(td_be_bound),
+	NULL,
+};
+
 static struct attribute *icl_tsx_events_attrs[] = {
 	EVENT_PTR(tx_start),
 	EVENT_PTR(tx_abort),
@@ -5245,10 +5363,13 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
+		td_attr = icl_td_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.update_topdown_event = icl_update_topdown_event;
+		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
@@ -5368,6 +5489,9 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
+	if (x86_pmu.intel_cap.perf_metrics)
+		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b947244da943..8100c21205e8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -406,6 +406,19 @@ struct cpu_hw_events {
 #define FIXED_EVENT_CONSTRAINT(c, n)	\
 	EVENT_CONSTRAINT(c, (1ULL << (32+n)), FIXED_EVENT_FLAGS)
 
+/*
+ * The special metric counters do not actually exist. They are calculated from
+ * the combination of the FxCtr3 + MSR_PERF_METRICS.
+ *
+ * The special metric counters are mapped to a dummy offset for the scheduler.
+ * The sharing between multiple users of the same metric without multiplexing
+ * is not allowed, even though the hardware supports that in principle.
+ */
+
+#define METRIC_EVENT_CONSTRAINT(c, n)					\
+	EVENT_CONSTRAINT(c, (1ULL << (INTEL_PMC_IDX_METRIC_BASE + n)),	\
+			 INTEL_ARCH_EVENT_MASK)
+
 /*
  * Constraint on the Event code + UMask
  */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d8c6cb82866d..325cfe5dd95a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -859,6 +859,8 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 
+#define MSR_PERF_METRICS		0x00000329
+
 /* PERF_GLOBAL_OVF_CTL bits */
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 84bfb9d1f948..b92849f37c37 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -198,6 +198,7 @@ struct x86_pmu_capability {
 
 /* RDPMC offset for Fixed PMCs */
 #define INTEL_PMC_FIXED_RDPMC_BASE		(1 << 30)
+#define INTEL_PMC_FIXED_RDPMC_METRICS		(1 << 29)
 
 /*
  * All the fixed-mode PMCs are configured via this single MSR:
@@ -304,6 +305,7 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
+#define GLOBAL_CTRL_EN_PERF_METRICS		48
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
  *
-- 
2.17.1

