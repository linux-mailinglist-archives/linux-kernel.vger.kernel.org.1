Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729C2FC1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhASVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:02:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:26412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbhASUuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:50:13 -0500
IronPort-SDR: qJrRZYhi0hGKyj5YJInnnwJXOURn9spqLYRpLEVjkWT5KNRY7uThof3Bi+0H3llwynXceRvnij
 TdWBA4PF7e0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064948"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:13 -0800
IronPort-SDR: HDliyolnbQziYj8ThG9hBNZqG3JTWJzuA3FxKq+0IOXtZruGN8xPkuT/eqj3y6nwxqy4V1HSz2
 GV+ihyBYKnHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990817"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:13 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 12/12] perf, tools: Update topdown documentation for Sapphire Rapids
Date:   Tue, 19 Jan 2021 12:38:31 -0800
Message-Id: <1611088711-17177-13-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Update Topdown extension on Sapphire Rapids and how to collect the L2
events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/topdown.txt | 78 ++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index 3c39bb3..10f07f9 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -121,7 +121,7 @@ to read slots and the topdown metrics at different points of the program:
 #define RDPMC_METRIC	(1 << 29)	/* return metric counters */
 
 #define FIXED_COUNTER_SLOTS		3
-#define METRIC_COUNTER_TOPDOWN_L1	0
+#define METRIC_COUNTER_TOPDOWN_L1_L2	0
 
 static inline uint64_t read_slots(void)
 {
@@ -130,7 +130,7 @@ static inline uint64_t read_slots(void)
 
 static inline uint64_t read_metrics(void)
 {
-	return _rdpmc(RDPMC_METRIC | METRIC_COUNTER_TOPDOWN_L1);
+	return _rdpmc(RDPMC_METRIC | METRIC_COUNTER_TOPDOWN_L1_L2);
 }
 
 Then the program can be instrumented to read these metrics at different
@@ -152,11 +152,21 @@ The binary ratios in the metric value can be converted to float ratios:
 
 #define GET_METRIC(m, i) (((m) >> (i*8)) & 0xff)
 
+/* L1 Topdown metric events */
 #define TOPDOWN_RETIRING(val)	((float)GET_METRIC(val, 0) / 0xff)
 #define TOPDOWN_BAD_SPEC(val)	((float)GET_METRIC(val, 1) / 0xff)
 #define TOPDOWN_FE_BOUND(val)	((float)GET_METRIC(val, 2) / 0xff)
 #define TOPDOWN_BE_BOUND(val)	((float)GET_METRIC(val, 3) / 0xff)
 
+/*
+ * L2 Topdown metric events.
+ * Available on Sapphire Rapids and later platforms.
+ */
+#define TOPDOWN_HEAVY_OPS(val)		((float)GET_METRIC(val, 4) / 0xff)
+#define TOPDOWN_BR_MISPREDICT(val)	((float)GET_METRIC(val, 5) / 0xff)
+#define TOPDOWN_FETCH_LAT(val)		((float)GET_METRIC(val, 6) / 0xff)
+#define TOPDOWN_MEM_BOUND(val)		((float)GET_METRIC(val, 7) / 0xff)
+
 and then converted to percent for printing.
 
 The ratios in the metric accumulate for the time when the counter
@@ -190,8 +200,8 @@ for that time period.
 	fe_bound_slots = GET_METRIC(metric_b, 2) * slots_b - fe_bound_slots_a
 	be_bound_slots = GET_METRIC(metric_b, 3) * slots_b - be_bound_slots_a
 
-Later the individual ratios for the measurement period can be recreated
-from these counts.
+Later the individual ratios of L1 metric events for the measurement period can
+be recreated from these counts.
 
 	slots_delta = slots_b - slots_a
 	retiring_ratio = (float)retiring_slots / slots_delta
@@ -205,6 +215,48 @@ from these counts.
 		fe_bound_ratio * 100.,
 		be_bound_ratio * 100.);
 
+The individual ratios of L2 metric events for the measurement period can be
+recreated from L1 and L2 metric counters. (Available on Sapphire Rapids and
+later platforms)
+
+	# compute scaled metrics for measurement a
+	heavy_ops_slots_a = GET_METRIC(metric_a, 4) * slots_a
+	br_mispredict_slots_a = GET_METRIC(metric_a, 5) * slots_a
+	fetch_lat_slots_a = GET_METRIC(metric_a, 6) * slots_a
+	mem_bound_slots_a = GET_METRIC(metric_a, 7) * slots_a
+
+	# compute delta scaled metrics between b and a
+	heavy_ops_slots = GET_METRIC(metric_b, 4) * slots_b - heavy_ops_slots_a
+	br_mispredict_slots = GET_METRIC(metric_b, 5) * slots_b - br_mispredict_slots_a
+	fetch_lat_slots = GET_METRIC(metric_b, 6) * slots_b - fetch_lat_slots_a
+	mem_bound_slots = GET_METRIC(metric_b, 7) * slots_b - mem_bound_slots_a
+
+	slots_delta = slots_b - slots_a
+	heavy_ops_ratio = (float)heavy_ops_slots / slots_delta
+	light_ops_ratio = retiring_ratio - heavy_ops_ratio;
+
+	br_mispredict_ratio = (float)br_mispredict_slots / slots_delta
+	machine_clears_ratio = bad_spec_ratio - br_mispredict_ratio;
+
+	fetch_lat_ratio = (float)fetch_lat_slots / slots_delta
+	fetch_bw_ratio = fe_bound_ratio - fetch_lat_ratio;
+
+	mem_bound_ratio = (float)mem_bound_slots / slota_delta
+	core_bound_ratio = be_bound_ratio - mem_bound_ratio;
+
+	printf("Heavy Operations %.2f%% Light Operations %.2f%% "
+	       "Branch Mispredict %.2f%% Machine Clears %.2f%% "
+	       "Fetch Latency %.2f%% Fetch Bandwidth %.2f%% "
+	       "Mem Bound %.2f%% Core Bound %.2f%%\n",
+		heavy_ops_ratio * 100.,
+		light_ops_ratio * 100.,
+		br_mispredict_ratio * 100.,
+		machine_clears_ratio * 100.,
+		fetch_lat_ratio * 100.,
+		fetch_bw_ratio * 100.,
+		mem_bound_ratio * 100.,
+		core_bound_ratio * 100.);
+
 Resetting metrics counters
 ==========================
 
@@ -248,6 +300,24 @@ a sampling read group. Since the SLOTS event must be the leader of a TopDown
 group, the second event of the group is the sampling event.
 For example, perf record -e '{slots, $sampling_event, topdown-retiring}:S'
 
+Extension on Sapphire Rapids Server
+===================================
+The metrics counter is extended to support TMA method level 2 metrics.
+The lower half of the register is the TMA level 1 metrics (legacy).
+The upper half is also divided into four 8-bit fields for the new level 2
+metrics. Four more TopDown metric events are exposed for the end-users,
+topdown-heavy-ops, topdown-br-mispredict, topdown-fetch-lat and
+topdown-mem-bound.
+
+Each of the new level 2 metrics in the upper half is a subset of the
+corresponding level 1 metric in the lower half. Software can deduce the
+other four level 2 metrics by subtracting corresponding metrics as below.
+
+    Light_Operations = Retiring - Heavy_Operations
+    Machine_Clears = Bad_Speculation - Branch_Mispredicts
+    Fetch_Bandwidth = Frontend_Bound - Fetch_Latency
+    Core_Bound = Backend_Bound - Memory_Bound
+
 
 [1] https://software.intel.com/en-us/top-down-microarchitecture-analysis-method-win
 [2] https://github.com/andikleen/pmu-tools/wiki/toplev-manual
-- 
2.7.4

