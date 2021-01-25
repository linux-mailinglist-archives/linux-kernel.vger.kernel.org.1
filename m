Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71013304819
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbhAZFxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:53:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:45272 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbhAYMXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:23:37 -0500
IronPort-SDR: O9QxAXkpbllJAGhlARYMTIQIoDEriVHk0bgKjxBKOsGRTSLmtUKrPdq04iJsLDoNY1vOpwfZH6
 ZlbLaFwKA+vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="243793067"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="243793067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 04:21:18 -0800
IronPort-SDR: crmIXwO044ecO7FitbNN4aDN1CbQ47GTD4Nlzh7dbNMKFJYjsoQ1AhwuASa+enYzoz9V3621OT
 2qXz+IOJ592g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="429264809"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2021 04:21:15 -0800
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        like.xu@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/perf: Use static_call for x86_pmu.guest_get_msrs
Date:   Mon, 25 Jan 2021 20:14:58 +0800
Message-Id: <20210125121458.181635-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up that CONFIG_RETPOLINE crud and replace the
indirect call x86_pmu.guest_get_msrs with static_call().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
v2->v3 Changelog:
- fix compiler warning from [-Wmissing-prototypes]
v1->v2 Changelog:
- fix compiler error from redifinition

 arch/x86/events/core.c            | 20 ++++++++++++++++++++
 arch/x86/events/intel/core.c      | 20 --------------------
 arch/x86/include/asm/perf_event.h |  6 +-----
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e37de298a495..cf0a52c80408 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -81,6 +81,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_guest_get_msrs,  *x86_pmu.guest_get_msrs);
+
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -665,6 +667,12 @@ void x86_pmu_disable_all(void)
 	}
 }
 
+struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
+{
+	return static_call(x86_pmu_guest_get_msrs)(nr);
+}
+EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
+
 /*
  * There may be PMI landing after enabled=0. The PMI hitting could be before or
  * after disable_all.
@@ -1923,6 +1931,8 @@ static void x86_pmu_static_call_update(void)
 
 	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
+
+	static_call_update(x86_pmu_guest_get_msrs, x86_pmu.guest_get_msrs);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
@@ -1930,6 +1940,13 @@ static void _x86_pmu_read(struct perf_event *event)
 	x86_perf_event_update(event);
 }
 
+static inline struct perf_guest_switch_msr *
+perf_guest_get_msrs_nop(int *nr)
+{
+	*nr = 0;
+	return NULL;
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2001,6 +2018,9 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
 
+	if (!x86_pmu.guest_get_msrs)
+		x86_pmu.guest_get_msrs = perf_guest_get_msrs_nop;
+
 	x86_pmu_static_call_update();
 
 	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d4569bfa83e3..93adf53cce5f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3680,26 +3680,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	return 0;
 }
 
-#ifdef CONFIG_RETPOLINE
-static struct perf_guest_switch_msr *core_guest_get_msrs(int *nr);
-static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr);
-#endif
-
-struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-#ifdef CONFIG_RETPOLINE
-	if (x86_pmu.guest_get_msrs == intel_guest_get_msrs)
-		return intel_guest_get_msrs(nr);
-	else if (x86_pmu.guest_get_msrs == core_guest_get_msrs)
-		return core_guest_get_msrs(nr);
-#endif
-	if (x86_pmu.guest_get_msrs)
-		return x86_pmu.guest_get_msrs(nr);
-	*nr = 0;
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
-
 static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index b9a7fd0a27e2..e2a4c785e4e3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -483,11 +483,7 @@ static inline void perf_check_microcode(void) { }
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
 #else
-static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-	*nr = 0;
-	return NULL;
-}
+struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
 	return -1;
-- 
2.29.2

