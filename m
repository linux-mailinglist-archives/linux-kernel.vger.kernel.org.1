Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1432FC1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhASVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:04:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:26409 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbhASUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:45:32 -0500
IronPort-SDR: FOUFlHSJ3COUSx2uyZQbOlUGysFNa1dAmGkL1TX+Mp+Ea84JNEgmX3UfdE3U5zXYy9xa4H5ybM
 cb1Dz+9/tQNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064927"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064927"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:03 -0800
IronPort-SDR: cJZGzBRTNHaSjwr5qHNd9sBieiaZyxBBM2DWd59f1AoF/k8N6QwjnCRWWUJD580rxI6kZEXbT9
 3z/EsvDCwq7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990789"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:03 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 02/12] perf/x86/intel: Factor out intel_update_topdown_event()
Date:   Tue, 19 Jan 2021 12:38:21 -0800
Message-Id: <1611088711-17177-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Similar to Ice Lake, Intel Sapphire Rapids server also supports the
topdown performance metrics feature. The difference is that Intel
Sapphire Rapids server extends the PERF_METRICS MSR to feature TMA
method level two metrics, which will introduce 8 metrics events. Current
icl_update_topdown_event() only check 4 level one metrics events.

Factor out intel_update_topdown_event() to facilitate the code sharing
between Ice Lake and Sapphire Rapids.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d4569bf..8eba41b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2337,8 +2337,8 @@ static void __icl_update_topdown_event(struct perf_event *event,
 	}
 }
 
-static void update_saved_topdown_regs(struct perf_event *event,
-				      u64 slots, u64 metrics)
+static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
+				      u64 metrics, int metric_end)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2347,7 +2347,7 @@ static void update_saved_topdown_regs(struct perf_event *event,
 	event->hw.saved_slots = slots;
 	event->hw.saved_metric = metrics;
 
-	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
@@ -2362,7 +2362,8 @@ static void update_saved_topdown_regs(struct perf_event *event,
  * The PERF_METRICS and Fixed counter 3 are read separately. The values may be
  * modify by a NMI. PMU has to be disabled before calling this function.
  */
-static u64 icl_update_topdown_event(struct perf_event *event)
+
+static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2378,7 +2379,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 	/* read PERF_METRICS */
 	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
 
-	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
@@ -2404,7 +2405,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		 * Don't need to reset the PERF_METRICS and Fixed counter 3.
 		 * Because the values will be restored in next schedule in.
 		 */
-		update_saved_topdown_regs(event, slots, metrics);
+		update_saved_topdown_regs(event, slots, metrics, metric_end);
 		reset = false;
 	}
 
@@ -2413,12 +2414,17 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
 		wrmsrl(MSR_PERF_METRICS, 0);
 		if (event)
-			update_saved_topdown_regs(event, 0, 0);
+			update_saved_topdown_regs(event, 0, 0, metric_end);
 	}
 
 	return slots;
 }
 
+static u64 icl_update_topdown_event(struct perf_event *event)
+{
+	return intel_update_topdown_event(event, INTEL_PMC_IDX_TD_BE_BOUND);
+}
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-- 
2.7.4

