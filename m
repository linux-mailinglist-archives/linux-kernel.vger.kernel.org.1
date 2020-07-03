Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9295D213A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCMxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 08:53:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:25720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGCMxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:31 -0400
IronPort-SDR: 4lP42NYOto2LbT5bfJYhyyL2x9HHiRkhXvte8dpb9HxDxJFXG7xCkeanHaA9cyM0Yf+tnF7X3W
 EbGS/qZWWmYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598354"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598354"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:29 -0700
IronPort-SDR: X2qUcr0EVNnDqrwNHI5wb9OjQPBbWA5gC3X9p0qrieTbNk2BQ0APhvjk4PTM+xu8SSJHPnEJlg
 JLruLDrRNxkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265963975"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 04/23] perf/x86/intel/lbr: Add the function pointers for LBR save and restore
Date:   Fri,  3 Jul 2020 05:49:10 -0700
Message-Id: <1593780569-62993-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The MSRs of Architectural LBR are different from previous model-specific
LBR. Perf has to implement different functions to save and restore them.

The function pointers for LBR save and restore are introduced. Perf
should initialize the corresponding functions at boot time.

The generic optimizations, e.g. avoiding restore LBR if no one else
touched them, still apply for Architectural LBRs. The related codes are
not moved to model-specific functions.

Current model-specific LBR functions are set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  4 +++
 arch/x86/events/intel/lbr.c  | 79 +++++++++++++++++++++++++++-----------------
 arch/x86/events/perf_event.h |  6 ++++
 3 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6414b47..50cb3c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3981,6 +3981,8 @@ static __initconst const struct x86_pmu core_pmu = {
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
 	.lbr_read		= intel_pmu_lbr_read_64,
+	.lbr_save		= intel_pmu_lbr_save,
+	.lbr_restore		= intel_pmu_lbr_restore,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4029,6 +4031,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
 	.lbr_read		= intel_pmu_lbr_read_64,
+	.lbr_save		= intel_pmu_lbr_save,
+	.lbr_restore		= intel_pmu_lbr_restore,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b8943f4..b2b8dc9 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -323,31 +323,13 @@ static inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
-static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
+void intel_pmu_lbr_restore(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_task_context *task_ctx = ctx;
 	int i;
 	unsigned lbr_idx, mask;
-	u64 tos;
-
-	if (task_ctx->lbr_callstack_users == 0 ||
-	    task_ctx->lbr_stack_state == LBR_NONE) {
-		intel_pmu_lbr_reset();
-		return;
-	}
-
-	tos = task_ctx->tos;
-	/*
-	 * Does not restore the LBR registers, if
-	 * - No one else touched them, and
-	 * - Did not enter C6
-	 */
-	if ((task_ctx == cpuc->last_task_ctx) &&
-	    (task_ctx->log_id == cpuc->last_log_id) &&
-	    rdlbr_from(tos)) {
-		task_ctx->lbr_stack_state = LBR_NONE;
-		return;
-	}
+	u64 tos = task_ctx->tos;
 
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
@@ -368,24 +350,48 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 	}
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
-	task_ctx->lbr_stack_state = LBR_NONE;
 
 	if (cpuc->lbr_select)
 		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
-static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	unsigned lbr_idx, mask;
-	u64 tos, from;
-	int i;
+	u64 tos;
 
-	if (task_ctx->lbr_callstack_users == 0) {
+	if (task_ctx->lbr_callstack_users == 0 ||
+	    task_ctx->lbr_stack_state == LBR_NONE) {
+		intel_pmu_lbr_reset();
+		return;
+	}
+
+	tos = task_ctx->tos;
+	/*
+	 * Does not restore the LBR registers, if
+	 * - No one else touched them, and
+	 * - Did not enter C6
+	 */
+	if ((task_ctx == cpuc->last_task_ctx) &&
+	    (task_ctx->log_id == cpuc->last_log_id) &&
+	    rdlbr_from(tos)) {
 		task_ctx->lbr_stack_state = LBR_NONE;
 		return;
 	}
 
+	x86_pmu.lbr_restore(task_ctx);
+
+	task_ctx->lbr_stack_state = LBR_NONE;
+}
+
+void intel_pmu_lbr_save(void *ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_task_context *task_ctx = ctx;
+	unsigned lbr_idx, mask;
+	u64 tos, from;
+	int i;
+
 	mask = x86_pmu.lbr_nr - 1;
 	tos = intel_pmu_lbr_tos();
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
@@ -400,13 +406,26 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
+
+	if (cpuc->lbr_select)
+		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
+}
+
+static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (task_ctx->lbr_callstack_users == 0) {
+		task_ctx->lbr_stack_state = LBR_NONE;
+		return;
+	}
+
+	x86_pmu.lbr_save(task_ctx);
+
 	task_ctx->lbr_stack_state = LBR_VALID;
 
 	cpuc->last_task_ctx = task_ctx;
 	cpuc->last_log_id = ++task_ctx->log_id;
-
-	if (cpuc->lbr_select)
-		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 312d27f..6d11813 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -695,6 +695,8 @@ struct x86_pmu {
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
+	void		(*lbr_save)(void *ctx);
+	void		(*lbr_restore)(void *ctx);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1090,6 +1092,10 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
 
 void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
 
+void intel_pmu_lbr_save(void *ctx);
+
+void intel_pmu_lbr_restore(void *ctx);
+
 void intel_pmu_lbr_init_core(void);
 
 void intel_pmu_lbr_init_nhm(void);
-- 
2.7.4

