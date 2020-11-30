Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C112C8E47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgK3Tlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:41:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:56644 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgK3Tlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:41:40 -0500
IronPort-SDR: CGX44UpPR5wnticSrjMHU3XuuFFnY399m5Dtud7rjcAPA9lotbY455YslNqcgr2d1SqOulymUb
 PQzzPCGmjhfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170134966"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170134966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:39:04 -0800
IronPort-SDR: 25bT4b6sLFoEA3C8IsM5Vfzz7ibJcMHw6uNvavzetToo82xYdQhNR8ndw1KMRTXiR5VZbTvFto
 0ds7tV1Dy60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480781848"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 11:39:04 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
Date:   Mon, 30 Nov 2020 11:38:42 -0800
Message-Id: <20201130193842.10569-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130193842.10569-1-kan.liang@linux.intel.com>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some calls to sched_task() in a context switch can be avoided. For
example, large PEBS only requires flushing the buffer in context switch
out. The current code still invokes the sched_task() for large PEBS in
context switch in.

The current code doesn't know and check the states of an event. It has
no idea which calls is unnecessary.

Add a new variable, sched_cb_state, to indicate the states of an event.
Add sched_cb_state to track the states per CPU context. Only invokes
the sched_task() when the relative states are set.

Split sched_cb_usage into sched_cb_task_usage and sched_cb_cpu_usage to
track per-task and per-CPU events respectively. Avoid going through the
sched_cb_list for pure per-task events. Avoid invoking sched_task() in
perf_event_context_sched_in/out for pure perf-CPU events.

Since the interface functions are changed, the specific codes are also
changed here.
- For power, the BHRB entries are reset in context switch in.
- For X86 large PEBS, the PEBS buffer are flushed in context switch out.
- For X86 normal LBR, the LBR registers are reset in context switch in.
- For X86 LBR call stack, the LBR registers are saved in context switch
out, and restored in context switch in.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Fix the missed changes in the power_pmu_bhrb_disable()

This patch still not split the ppc change to a separate patch, because
both PPC and X86 invokes the perf_sched_cb_inc() directly. The patch
changes the parameters of the perf_sched_cb_inc(). We have to update
the PPC and X86 codes together.

 arch/powerpc/perf/core-book3s.c | 14 ++++++--
 arch/x86/events/intel/ds.c      |  8 +++--
 arch/x86/events/intel/lbr.c     | 15 ++++++--
 include/linux/perf_event.h      | 12 +++++--
 kernel/events/core.c            | 62 +++++++++++++++++++++++++++------
 5 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 08643cba1494..63477002bfcb 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -370,6 +370,7 @@ static void power_pmu_bhrb_reset(void)
 static void power_pmu_bhrb_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
+	int state = PERF_SCHED_CB_SW_IN;
 
 	if (!ppmu->bhrb_nr)
 		return;
@@ -380,19 +381,28 @@ static void power_pmu_bhrb_enable(struct perf_event *event)
 		cpuhw->bhrb_context = event->ctx;
 	}
 	cpuhw->bhrb_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+
+	perf_sched_cb_inc(event->ctx->pmu, state);
 }
 
 static void power_pmu_bhrb_disable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
+	int state = PERF_SCHED_CB_SW_IN;
 
 	if (!ppmu->bhrb_nr)
 		return;
 
 	WARN_ON_ONCE(!cpuhw->bhrb_users);
 	cpuhw->bhrb_users--;
-	perf_sched_cb_dec(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+
+	perf_sched_cb_dec(event->ctx->pmu, state);
 
 	if (!cpuhw->disabled && !cpuhw->bhrb_users) {
 		/* BHRB cannot be turned off when other
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315df1e16..3c124c203264 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1018,12 +1018,16 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	 * that does not hurt:
 	 */
 	bool update = cpuc->n_pebs == 1;
+	int state = PERF_SCHED_CB_SW_OUT;
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
+		if (!(event->attach_state & PERF_ATTACH_TASK))
+			state |= PERF_SCHED_CB_CPU;
+
 		if (!needed_cb)
-			perf_sched_cb_inc(pmu);
+			perf_sched_cb_inc(pmu, state);
 		else
-			perf_sched_cb_dec(pmu);
+			perf_sched_cb_dec(pmu, state);
 
 		update = true;
 	}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..e4c500580df5 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -660,6 +660,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 {
 	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int state = PERF_SCHED_CB_SW_IN;
 
 	if (!x86_pmu.lbr_nr)
 		return;
@@ -693,7 +694,13 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 */
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		state |= PERF_SCHED_CB_SW_OUT;
+
+	perf_sched_cb_inc(event->ctx->pmu, state);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
 
@@ -724,6 +731,7 @@ void release_lbr_buffers(void)
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int state = 0;
 
 	if (!x86_pmu.lbr_nr)
 		return;
@@ -740,7 +748,10 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+	perf_sched_cb_dec(event->ctx->pmu, state);
 }
 
 static inline bool vlbr_exclude_host(void)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 530a505e1c7e..35f741a610bd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -854,6 +854,10 @@ struct perf_event_context {
  */
 #define PERF_NR_CONTEXTS	4
 
+#define PERF_SCHED_CB_CPU	0x1
+#define PERF_SCHED_CB_SW_IN	0x2
+#define PERF_SCHED_CB_SW_OUT	0x4
+
 /**
  * struct perf_event_cpu_context - per cpu event context structure
  */
@@ -874,7 +878,9 @@ struct perf_cpu_context {
 #endif
 
 	struct list_head		sched_cb_entry;
-	int				sched_cb_usage;
+	int				sched_cb_task_usage;
+	int				sched_cb_cpu_usage;
+	int				sched_cb_state;
 
 	int				online;
 	/*
@@ -967,8 +973,8 @@ extern const struct perf_event_attr *perf_event_attrs(struct perf_event *event);
 extern void perf_event_print_debug(void);
 extern void perf_pmu_disable(struct pmu *pmu);
 extern void perf_pmu_enable(struct pmu *pmu);
-extern void perf_sched_cb_dec(struct pmu *pmu);
-extern void perf_sched_cb_inc(struct pmu *pmu);
+extern void perf_sched_cb_dec(struct pmu *pmu, int state);
+extern void perf_sched_cb_inc(struct pmu *pmu, int state);
 extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c0f7d84a4245..a642494f4ce2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3377,6 +3377,32 @@ static void perf_event_sync_stat(struct perf_event_context *ctx,
 	}
 }
 
+static inline bool perf_pmu_sched_in_ctx(struct perf_cpu_context *cpuctx)
+{
+	return !!(cpuctx->sched_cb_state & PERF_SCHED_CB_SW_IN);
+}
+
+static inline bool perf_pmu_sched_out_ctx(struct perf_cpu_context *cpuctx)
+{
+	return !!(cpuctx->sched_cb_state & PERF_SCHED_CB_SW_OUT);
+}
+
+static inline bool perf_pmu_has_sched_task(struct perf_cpu_context *cpuctx, bool sched_in)
+{
+	struct pmu *pmu = cpuctx->ctx.pmu;
+
+	if (!pmu->sched_task)
+		return false;
+
+	if (sched_in && perf_pmu_sched_in_ctx(cpuctx))
+		return true;
+
+	if (!sched_in && perf_pmu_sched_out_ctx(cpuctx))
+		return true;
+
+	return false;
+}
+
 static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 					 struct task_struct *next)
 {
@@ -3426,7 +3452,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 
 			perf_pmu_disable(pmu);
 
-			if (cpuctx->sched_cb_usage && pmu->sched_task)
+			if (cpuctx->sched_cb_task_usage && perf_pmu_has_sched_task(cpuctx, false))
 				pmu->sched_task(ctx, false);
 
 			/*
@@ -3466,7 +3492,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		perf_pmu_disable(pmu);
 
-		if (cpuctx->sched_cb_usage && pmu->sched_task)
+		if (cpuctx->sched_cb_task_usage && perf_pmu_has_sched_task(cpuctx, false))
 			pmu->sched_task(ctx, false);
 		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
 
@@ -3477,22 +3503,37 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 
 static DEFINE_PER_CPU(struct list_head, sched_cb_list);
 
-void perf_sched_cb_dec(struct pmu *pmu)
+void perf_sched_cb_dec(struct pmu *pmu, int state)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
+	if (!(state & PERF_SCHED_CB_CPU)) {
+		--cpuctx->sched_cb_task_usage;
+		goto end;
+	}
+
 	this_cpu_dec(perf_sched_cb_usages);
 
-	if (!--cpuctx->sched_cb_usage)
+	if (!--cpuctx->sched_cb_cpu_usage)
 		list_del(&cpuctx->sched_cb_entry);
+end:
+	if (!cpuctx->sched_cb_cpu_usage && !cpuctx->sched_cb_task_usage)
+		cpuctx->sched_cb_state = 0;
 }
 
 
-void perf_sched_cb_inc(struct pmu *pmu)
+void perf_sched_cb_inc(struct pmu *pmu, int state)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	if (!cpuctx->sched_cb_usage++)
+	cpuctx->sched_cb_state |= state;
+
+	if (!(state & PERF_SCHED_CB_CPU)) {
+		cpuctx->sched_cb_task_usage++;
+		return;
+	}
+
+	if (!cpuctx->sched_cb_cpu_usage++)
 		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
 
 	this_cpu_inc(perf_sched_cb_usages);
@@ -3537,8 +3578,8 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 		/* will be handled in perf_event_context_sched_in/out */
 		if (cpuctx->task_ctx)
 			continue;
-
-		__perf_pmu_sched_task(cpuctx, sched_in);
+		if (perf_pmu_has_sched_task(cpuctx, sched_in))
+			__perf_pmu_sched_task(cpuctx, sched_in);
 	}
 }
 
@@ -3802,7 +3843,8 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 
 	cpuctx = __get_cpu_context(ctx);
 	if (cpuctx->task_ctx == ctx) {
-		if (cpuctx->sched_cb_usage)
+		if (cpuctx->sched_cb_task_usage &&
+		    (cpuctx->sched_cb_state & PERF_SCHED_CB_SW_IN))
 			__perf_pmu_sched_task(cpuctx, true);
 		return;
 	}
@@ -3828,7 +3870,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
+	if (cpuctx->sched_cb_task_usage && perf_pmu_has_sched_task(cpuctx, true))
 		pmu->sched_task(cpuctx->task_ctx, true);
 
 	perf_pmu_enable(pmu);
-- 
2.17.1

