Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B922F9A87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbhARHaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:30:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:55805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732414AbhARH3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:29:49 -0500
IronPort-SDR: cJcGwg4jcOQ1DS6yBsJqFE6OzhdQReTO2Y19oLsH+wHdAR/wVZLgVqYYK2xCfk9L4d+6m/05DJ
 2UbAlqMdJ6/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="178919106"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="178919106"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 23:28:00 -0800
IronPort-SDR: dMdvbW9dLZGVjiN08Vqhe0d/AtEdv3AusvFRu5hgJDKWpeIRq/oHEZC/RCWXsccHvmJD7V+fiF
 17eqK5FfcCxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="466280086"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2021 23:27:57 -0800
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/perf: Use static_call for x86_pmu.guest_get_msrs
Date:   Mon, 18 Jan 2021 15:21:51 +0800
Message-Id: <20210118072151.44481-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up that CONFIG_RETPOLINE crud and replace the
indirect call x86_pmu.guest_get_msrs with static_call().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/events/core.c       | 16 ++++++++++++++++
 arch/x86/events/intel/core.c | 20 --------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e37de298a495..2eec3c8d0a13 100644
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
@@ -665,6 +667,18 @@ void x86_pmu_disable_all(void)
 	}
 }
 
+struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
+{
+	struct perf_guest_switch_msr *ret = NULL;
+
+	ret = static_call(x86_pmu_guest_get_msrs)(nr);
+	if (!ret)
+		*nr = 0;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
+
 /*
  * There may be PMI landing after enabled=0. The PMI hitting could be before or
  * after disable_all.
@@ -1923,6 +1937,8 @@ static void x86_pmu_static_call_update(void)
 
 	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
+
+	static_call_update(x86_pmu_guest_get_msrs, x86_pmu.guest_get_msrs);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
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
-- 
2.29.2

