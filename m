Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D142FC179
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbhASUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:45:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:26408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbhASUnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:43:55 -0500
IronPort-SDR: YVhzsqYZL/7UXLCnBREmBF5sClKumTdIIBKHdM/8R0Arrl26iDKD+a1OoKIakAQdhIJtCXcmL9
 O17Pm8MCMQkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064928"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064928"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:04 -0800
IronPort-SDR: 9EqI4eqBtRLfGXqp48Hs7aoPXdNc79g2SwJZUCzZg9uW9veltn/AkfpSUEH4b6YW8CJUl+TTbX
 fLiezFuTzQjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990795"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:04 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for Sapphire Rapids
Date:   Tue, 19 Jan 2021 12:38:22 -0800
Message-Id: <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add perf core PMU support for the Intel Sapphire Rapids server, which is
the successor of the Intel Ice Lake server. The enabling code is based
on Ice Lake, but there are several new features introduced.

The event encoding is changed and simplified, e.g., the event codes
which are below 0x90 are restricted to counters 0-3. The event codes
which above 0x90 are likely to have no restrictions. The event
constraints, extra_regs(), and hardware cache events table are changed
accordingly.

A new Precise Distribution (PDist) facility is introduced, which
further minimizes the skid when a precise event is programmed on the GP
counter 0. Enable the Precise Distribution (PDist) facility with :ppp
event. For this facility to work, the period must be initialized with a
value larger than 127. Add spr_limit_period() to apply the limit for
:ppp event.

Two new data source fields, data block & address block, are added in the
PEBS Memory Info Record for the load latency event. To enable the
feature,
- An auxiliary event has to be enabled together with the load latency
  event on Sapphire Rapids. A new flag PMU_FL_MEM_LOADS_AUX is
  introduced to indicate the case. A new event, mem-loads-aux, is
  exposed to sysfs for the user tool.
  Add a check in hw_config(). If the auxiliary event is not detected,
  return an unique error -ENODATA.
- The union perf_mem_data_src is extended to support the new fields.
- Ice Lake and earlier models do not support block information, but the
  fields may be set by HW on some machines. Add pebs_no_block to
  explicitly indicate the previous platforms which don't support the new
  block fields. Accessing the new block fields are ignored on those
  platforms.

A new store Latency facility is introduced, which leverages the PEBS
facility where it can provide additional information about sampled
stores. The additional information includes the data address, memory
auxiliary info (e.g. Data Source, STLB miss) and the latency of the
store access. To enable the facility, the new event (0x02cd) has to be
programed on the GP counter 0. A new flag PERF_X86_EVENT_PEBS_STLAT is
introduced to indicate the event. The store_latency_data() is introduced
to parse the memory auxiliary info.

The layout of access latency field of PEBS Memory Info Record has been
changed. Two latency, instruction latency (bit 15:0) and cache access
latency (bit 47:32) are recorded.
- The cache access latency is similar to previous memory access latency.
  For loads, the latency starts by the actual cache access until the
  data is returned by the memory subsystem.
  For stores, the latency starts when the demand write accesses the L1
  data cache and lasts until the cacheline write is completed in the
  memory subsystem.
  The cache access latency is stored in the perf record with the sample
  type PERF_SAMPLE_WEIGHT.
- The instruction latency starts by the dispatch of the load operation
  for execution and lasts until completion of the instruction it belongs
  to.
  Add a new flag PMU_FL_INSTR_LATENCY to indicate the instruction
  latency support. The instruction latency is stored in the perf record
  with the new sample type PERF_SAMPLE_WEIGHT_EXT.

Extends the PERF_METRICS MSR to feature TMA method level 2 metrics. The
lower half of the register is the TMA level 1 metrics (legacy). The
upper half is also divided into four 8-bit fields for the new level 2
metrics. Expose all eight Topdown metrics events to user space.

The full description for the SPR features can be found at Intel
Architecture Instruction Set Extensions and Future Features
Programming Reference, 319433-041.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 320 +++++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c        | 112 ++++++++++++-
 arch/x86/events/perf_event.h      |  12 +-
 arch/x86/include/asm/perf_event.h |  16 +-
 include/uapi/linux/perf_event.h   |  12 +-
 5 files changed, 456 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8eba41b..a54d4a9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -275,6 +275,55 @@ static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct extra_reg intel_spr_extra_regs[] __read_mostly = {
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
+	EVENT_EXTRA_END
+};
+
+static struct event_constraint intel_spr_event_constraints[] = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_HEAVY_OPS, 4),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BR_MISPREDICT, 5),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
+
+	INTEL_EVENT_CONSTRAINT(0x2e, 0xff),
+	INTEL_EVENT_CONSTRAINT(0x3c, 0xff),
+	/*
+	 * Generally event codes < 0x90 are restricted to counters 0-3.
+	 * The 0x2E and 0x3C are exception, which has no restriction.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x08a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x1),
+	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
+	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
+	/*
+	 * Generally event codes >= 0x90 are likely to have no restrictions.
+	 * The exception are defined as above.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0xff),
+
+	EVENT_CONSTRAINT_END
+};
+
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
@@ -314,11 +363,15 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles, td_recovery_bubbles,
 EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
-EVENT_ATTR_STR(slots,			slots,		"event=0x00,umask=0x4");
-EVENT_ATTR_STR(topdown-retiring,	td_retiring,	"event=0x00,umask=0x80");
-EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,	"event=0x00,umask=0x81");
-EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,	"event=0x00,umask=0x82");
-EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,	"event=0x00,umask=0x83");
+EVENT_ATTR_STR(slots,			slots,			"event=0x00,umask=0x4");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring,		"event=0x00,umask=0x80");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,		"event=0x00,umask=0x81");
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,		"event=0x00,umask=0x82");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,		"event=0x00,umask=0x83");
+EVENT_ATTR_STR(topdown-heavy-ops,	td_heavy_ops,		"event=0x00,umask=0x84");
+EVENT_ATTR_STR(topdown-br-mispredict,	td_br_mispredict,	"event=0x00,umask=0x85");
+EVENT_ATTR_STR(topdown-fetch-lat,	td_fetch_lat,		"event=0x00,umask=0x86");
+EVENT_ATTR_STR(topdown-mem-bound,	td_mem_bound,		"event=0x00,umask=0x87");
 
 static struct attribute *snb_events_attrs[] = {
 	EVENT_PTR(td_slots_issued),
@@ -384,6 +437,108 @@ static u64 intel_pmu_event_map(int hw_event)
 	return intel_perfmon_event_map[hw_event];
 }
 
+static __initconst const u64 spr_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(L1D ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x81d0,
+		[ C(RESULT_MISS)   ] = 0xe124,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x82d0,
+	},
+ },
+ [ C(L1I ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_MISS)   ] = 0xe424,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x12a,
+		[ C(RESULT_MISS)   ] = 0x12a,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x12a,
+		[ C(RESULT_MISS)   ] = 0x12a,
+	},
+ },
+ [ C(DTLB) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x81d0,
+		[ C(RESULT_MISS)   ] = 0xe12,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x82d0,
+		[ C(RESULT_MISS)   ] = 0xe13,
+	},
+ },
+ [ C(ITLB) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = 0xe11,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+ [ C(BPU ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x4c4,
+		[ C(RESULT_MISS)   ] = 0x4c5,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+ [ C(NODE) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x12a,
+		[ C(RESULT_MISS)   ] = 0x12a,
+	},
+ },
+};
+
+static __initconst const u64 spr_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10001,
+		[ C(RESULT_MISS)   ] = 0x3fbfc00001,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,
+		[ C(RESULT_MISS)   ] = 0x3f3fc00002,
+	},
+ },
+ [ C(NODE) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10c000001,
+		[ C(RESULT_MISS)   ] = 0x3fb3000001,
+	},
+ },
+};
+
 /*
  * Notes on the events:
  * - data reads do not include code reads (comparable to earlier tables)
@@ -2319,6 +2474,17 @@ static void __icl_update_topdown_event(struct perf_event *event,
 {
 	u64 delta, last = 0;
 
+	/*
+	 * Although the unsupported topdown events are not exposed to users,
+	 * users may mistakenly use the unsupported events via RAW format.
+	 * For example, using L2 topdown event, cpu/event=0x00,umask=0x84/,
+	 * on Ice Lake. In this case, the scheduler follows the unknown
+	 * event handling and assigns a GP counter to the event.
+	 * Check the case, and avoid updating unsupported events.
+	 */
+	if (event->hw.idx < INTEL_PMC_IDX_FIXED)
+		return;
+
 	delta = icl_get_topdown_value(event, slots, metrics);
 	if (last_slots)
 		last = icl_get_topdown_value(event, last_slots, last_metrics);
@@ -2425,6 +2591,11 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 	return intel_update_topdown_event(event, INTEL_PMC_IDX_TD_BE_BOUND);
 }
 
+static u64 spr_update_topdown_event(struct perf_event *event)
+{
+	return intel_update_topdown_event(event, INTEL_PMC_IDX_TD_MEM_BOUND);
+}
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3569,6 +3740,17 @@ static int core_pmu_hw_config(struct perf_event *event)
 	return intel_pmu_bts_config(event);
 }
 
+static inline bool is_mem_loads_event(struct perf_event *event)
+{
+	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0xcd, .umask=0x01);
+}
+
+static inline bool is_mem_loads_aux_event(struct perf_event *event)
+{
+	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0x03, .umask=0x02);
+}
+
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3671,6 +3853,31 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
+	/*
+	 * To retrieve complete Memory Info of the load latency event, an
+	 * auxiliary event has to be enabled simultaneously. Add a check for
+	 * the load latency event.
+	 *
+	 * In a group, the auxiliary event must be in front of the load latency
+	 * event. The rule is to simplify the implementation of the check.
+	 * That's because perf cannot have a complete group at the moment.
+	 */
+	if (x86_pmu.flags & PMU_FL_MEM_LOADS_AUX &&
+	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
+	    is_mem_loads_event(event)) {
+		struct perf_event *leader = event->group_leader;
+		struct perf_event *sibling = NULL;
+
+		if (!is_mem_loads_aux_event(leader)) {
+			for_each_sibling_event(sibling, leader) {
+				if (is_mem_loads_aux_event(sibling))
+					break;
+			}
+			if (list_entry_is_head(sibling, &leader->sibling_list, sibling_list))
+				return -ENODATA;
+		}
+	}
+
 	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
 		return 0;
 
@@ -3871,6 +4078,29 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 }
 
 static struct event_constraint *
+spr_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct event_constraint *c;
+
+	c = icl_get_event_constraints(cpuc, idx, event);
+
+	/*
+	 * The :ppp indicates the Precise Distribution (PDist) facility, which
+	 * is only supported on the GP counter 0. If a :ppp event which is not
+	 * available on the GP counter 0, error out.
+	 */
+	if (event->attr.precise_ip == 3) {
+		if (c->idxmsk64 & BIT_ULL(0))
+			return &counter0_constraint;
+
+		return &emptyconstraint;
+	}
+
+	return c;
+}
+
+static struct event_constraint *
 glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
@@ -3959,6 +4189,14 @@ static u64 nhm_limit_period(struct perf_event *event, u64 left)
 	return max(left, 32ULL);
 }
 
+static u64 spr_limit_period(struct perf_event *event, u64 left)
+{
+	if (event->attr.precise_ip == 3)
+		return max(left, 128ULL);
+
+	return left;
+}
+
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
 PMU_FORMAT_ATTR(umask,	"config:8-15"	);
 PMU_FORMAT_ATTR(edge,	"config:18"	);
@@ -4709,6 +4947,42 @@ static struct attribute *icl_tsx_events_attrs[] = {
 	NULL,
 };
 
+
+EVENT_ATTR_STR(mem-stores,	mem_st_spr,	"event=0xcd,umask=0x2");
+EVENT_ATTR_STR(mem-loads-aux,	mem_ld_aux,	"event=0x03,umask=0x2");
+
+static struct attribute *spr_events_attrs[] = {
+	EVENT_PTR(mem_ld_hsw),
+	EVENT_PTR(mem_st_spr),
+	EVENT_PTR(mem_ld_aux),
+	NULL,
+};
+
+static struct attribute *spr_td_events_attrs[] = {
+	EVENT_PTR(slots),
+	EVENT_PTR(td_retiring),
+	EVENT_PTR(td_bad_spec),
+	EVENT_PTR(td_fe_bound),
+	EVENT_PTR(td_be_bound),
+	EVENT_PTR(td_heavy_ops),
+	EVENT_PTR(td_br_mispredict),
+	EVENT_PTR(td_fetch_lat),
+	EVENT_PTR(td_mem_bound),
+	NULL,
+};
+
+static struct attribute *spr_tsx_events_attrs[] = {
+	EVENT_PTR(tx_start),
+	EVENT_PTR(tx_abort),
+	EVENT_PTR(tx_commit),
+	EVENT_PTR(tx_capacity_read),
+	EVENT_PTR(tx_capacity_write),
+	EVENT_PTR(tx_conflict),
+	EVENT_PTR(cycles_t),
+	EVENT_PTR(cycles_ct),
+	NULL,
+};
+
 static ssize_t freeze_on_smi_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -5475,6 +5749,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs = intel_icl_extra_regs;
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.pebs_no_block = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
@@ -5495,6 +5770,41 @@ __init int intel_pmu_init(void)
 		name = "icelake";
 		break;
 
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+		pmem = true;
+		x86_pmu.late_ack = true;
+		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, spr_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+
+		x86_pmu.event_constraints = intel_spr_event_constraints;
+		x86_pmu.pebs_constraints = intel_spr_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_spr_extra_regs;
+		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+		x86_pmu.flags |= PMU_FL_PEBS_ALL;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+
+		x86_pmu.hw_config = hsw_hw_config;
+		x86_pmu.get_event_constraints = spr_get_event_constraints;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			hsw_format_attr : nhm_format_attr;
+		extra_skl_attr = skl_format_attr;
+		mem_attr = spr_events_attrs;
+		td_attr = spr_td_events_attrs;
+		tsx_attr = spr_tsx_events_attrs;
+		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
+		x86_pmu.lbr_pt_coexist = true;
+		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.update_topdown_event = spr_update_topdown_event;
+		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		pr_cont("Sapphire Rapids events, ");
+		name = "sapphire_rapids";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 67dbc91..d27a30c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -36,7 +36,9 @@ union intel_x86_pebs_dse {
 		unsigned int ld_dse:4;
 		unsigned int ld_stlb_miss:1;
 		unsigned int ld_locked:1;
-		unsigned int ld_reserved:26;
+		unsigned int ld_data_blk:1;
+		unsigned int ld_addr_blk:1;
+		unsigned int ld_reserved:24;
 	};
 	struct {
 		unsigned int st_l1d_hit:1;
@@ -45,6 +47,12 @@ union intel_x86_pebs_dse {
 		unsigned int st_locked:1;
 		unsigned int st_reserved2:26;
 	};
+	struct {
+		unsigned int st_lat_dse:4;
+		unsigned int st_lat_stlb_miss:1;
+		unsigned int st_lat_locked:1;
+		unsigned int ld_reserved3:26;
+	};
 };
 
 
@@ -198,6 +206,63 @@ static u64 load_latency_data(u64 status)
 	if (dse.ld_locked)
 		val |= P(LOCK, LOCKED);
 
+	/*
+	 * Ice Lake and earlier models do not support block infos.
+	 */
+	if (x86_pmu.pebs_no_block) {
+		val |= P(BLK, NA);
+		return val;
+	}
+	/*
+	 * bit 6: load was blocked since its data could not be forwarded
+	 *        from a preceding store
+	 */
+	if (dse.ld_data_blk)
+		val |= P(BLK, DATA);
+
+	/*
+	 * bit 7: load was blocked due to potential address conflict with
+	 *        a preceding store
+	 */
+	if (dse.ld_addr_blk)
+		val |= P(BLK, ADDR);
+
+	if (!dse.ld_data_blk && !dse.ld_addr_blk)
+		val |= P(BLK, NA);
+
+	return val;
+}
+
+static u64 store_latency_data(u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	u64 val;
+
+	dse.val = status;
+
+	/*
+	 * use the mapping table for bit 0-3
+	 */
+	val = pebs_data_source[dse.st_lat_dse];
+
+	/*
+	 * bit 4: TLB access
+	 * 0 = did not miss 2nd level TLB
+	 * 1 = missed 2nd level TLB
+	 */
+	if (dse.st_lat_stlb_miss)
+		val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	/*
+	 * bit 5: locked prefix
+	 */
+	if (dse.st_lat_locked)
+		val |= P(LOCK, LOCKED);
+
+	val |= P(BLK, NA);
+
 	return val;
 }
 
@@ -870,6 +935,27 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_spr_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
+
+	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
+	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x2d0, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
+
+	/*
+	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
+	 * need the full constraints from the main table.
+	 */
+
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
 	struct event_constraint *c;
@@ -1331,6 +1417,8 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 
 	if (fl & PERF_X86_EVENT_PEBS_LDLAT)
 		val = load_latency_data(aux);
+	else if (fl & PERF_X86_EVENT_PEBS_STLAT)
+		val = store_latency_data(aux);
 	else if (fst && (fl & PERF_X86_EVENT_PEBS_HSW_PREC))
 		val = precise_datala_hsw(event, aux);
 	else if (fst)
@@ -1507,6 +1595,9 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 #endif
 }
 
+#define PEBS_LATENCY_MASK			0xffff
+#define PEBS_CACHE_LATENCY_OFFSET		32
+
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
  */
@@ -1577,9 +1668,20 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	}
 
 	if (format_size & PEBS_DATACFG_MEMINFO) {
-		if (sample_type & PERF_SAMPLE_WEIGHT)
-			data->weight = meminfo->latency ?:
+		if (sample_type & PERF_SAMPLE_WEIGHT) {
+			u64 weight = meminfo->latency;
+
+			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
+				weight >>= PEBS_CACHE_LATENCY_OFFSET;
+			data->weight = weight & PEBS_LATENCY_MASK ?:
 				intel_get_tsx_weight(meminfo->tsx_tuning);
+		}
+
+		if (sample_type & PERF_SAMPLE_WEIGHT_EXT) {
+			data->weight_ext.val = 0;
+			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
+				data->weight_ext.instr_latency = meminfo->latency & PEBS_LATENCY_MASK;
+		}
 
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
 			data->data_src.val = get_data_src(event, meminfo->aux);
@@ -2026,8 +2128,10 @@ void __init intel_ds_init(void)
 	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
-	if (x86_pmu.version <= 4)
+	if (x86_pmu.version <= 4) {
 		x86_pmu.pebs_no_isolation = 1;
+		x86_pmu.pebs_no_block = 1;
+	}
 
 	if (x86_pmu.pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7895cf4..0ae4e50 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -80,6 +80,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_PAIR		0x1000 /* Large Increment per Cycle */
 #define PERF_X86_EVENT_LBR_SELECT	0x2000 /* Save/Restore MSR_LBR_SELECT */
 #define PERF_X86_EVENT_TOPDOWN		0x4000 /* Count Topdown slots/metrics events */
+#define PERF_X86_EVENT_PEBS_STLAT	0x8000 /* st+stlat data address sampling */
 
 static inline bool is_topdown_count(struct perf_event *event)
 {
@@ -443,6 +444,10 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			   HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LDLAT)
 
+#define INTEL_PSD_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			   HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_STLAT)
+
 #define INTEL_PST_CONSTRAINT(c, n)	\
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_ST)
@@ -724,7 +729,8 @@ struct x86_pmu {
 			pebs_broken		:1,
 			pebs_prec_dist		:1,
 			pebs_no_tlb		:1,
-			pebs_no_isolation	:1;
+			pebs_no_isolation	:1,
+			pebs_no_block		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
@@ -871,6 +877,8 @@ do {									\
 #define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
 #define PMU_FL_TFA		0x20 /* deal with TSX force abort */
 #define PMU_FL_PAIR		0x40 /* merge counters for large incr. events */
+#define PMU_FL_INSTR_LATENCY	0x80 /* Support Instruction Latency in PEBS Memory Info Record */
+#define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
@@ -1157,6 +1165,8 @@ extern struct event_constraint intel_skl_pebs_event_constraints[];
 
 extern struct event_constraint intel_icl_pebs_event_constraints[];
 
+extern struct event_constraint intel_spr_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
 void intel_pmu_pebs_add(struct perf_event *event);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index b9a7fd0..f54484b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -261,8 +261,12 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_METRIC_BASE + 1)
 #define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 2)
 #define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 3)
-#define INTEL_PMC_IDX_METRIC_END		INTEL_PMC_IDX_TD_BE_BOUND
-#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_METRIC_BASE) | \
+#define INTEL_PMC_IDX_TD_HEAVY_OPS		(INTEL_PMC_IDX_METRIC_BASE + 4)
+#define INTEL_PMC_IDX_TD_BR_MISPREDICT		(INTEL_PMC_IDX_METRIC_BASE + 5)
+#define INTEL_PMC_IDX_TD_FETCH_LAT		(INTEL_PMC_IDX_METRIC_BASE + 6)
+#define INTEL_PMC_IDX_TD_MEM_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 7)
+#define INTEL_PMC_IDX_METRIC_END		INTEL_PMC_IDX_TD_MEM_BOUND
+#define INTEL_PMC_MSK_TOPDOWN			((0xffull << INTEL_PMC_IDX_METRIC_BASE) | \
 						INTEL_PMC_MSK_FIXED_SLOTS)
 
 /*
@@ -280,8 +284,12 @@ struct x86_pmu_capability {
 #define INTEL_TD_METRIC_BAD_SPEC		0x8100	/* Bad speculation metric */
 #define INTEL_TD_METRIC_FE_BOUND		0x8200	/* FE bound metric */
 #define INTEL_TD_METRIC_BE_BOUND		0x8300	/* BE bound metric */
-#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_BE_BOUND
-#define INTEL_TD_METRIC_NUM			4
+#define INTEL_TD_METRIC_HEAVY_OPS		0x8400	/* Heavy Operations metric */
+#define INTEL_TD_METRIC_BR_MISPREDICT		0x8500	/* Branch Mispredict metric */
+#define INTEL_TD_METRIC_FETCH_LAT		0x8600	/* Fetch Latency metric */
+#define INTEL_TD_METRIC_MEM_BOUND		0x8700	/* Memory bound metric */
+#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
+#define INTEL_TD_METRIC_NUM			8
 
 static inline bool is_metric_idx(int idx)
 {
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d0129e5..17f19cc 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1135,14 +1135,16 @@ union perf_mem_data_src {
 			mem_lvl_num:4,	/* memory hierarchy level number */
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
-			mem_rsvd:24;
+			mem_blk:3,	/* access blocked */
+			mem_rsvd:21;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:24,
+		__u64	mem_rsvd:21,
+			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
 			mem_lvl_num:4,	/* memory hierarchy level number */
@@ -1225,6 +1227,12 @@ union perf_mem_data_src {
 #define PERF_MEM_TLB_OS		0x40 /* OS fault handler */
 #define PERF_MEM_TLB_SHIFT	26
 
+/* Access blocked */
+#define PERF_MEM_BLK_NA		0x01 /* not available */
+#define PERF_MEM_BLK_DATA	0x02 /* data could not be forwarded */
+#define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
+#define PERF_MEM_BLK_SHIFT	40
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
-- 
2.7.4

