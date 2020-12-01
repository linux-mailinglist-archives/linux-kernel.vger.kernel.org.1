Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34602CA9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbgLAR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgLAR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:29:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC61C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CObHh35V+AFFfYYIvx+e8+V2B37JZucFJ9DAtVuUcAU=; b=grMiLZ+3xScdv/UVtd6k1wAkLo
        KXLJCCx5yKyNtudl5sKKuzbANAl+ocX9TUpKWNCf1uzQ/BtkCSe2nFdUPtfn/sqtUyufEjFqwHhQH
        IwnMyPKasHfbfh4YvCA72YUId28UZBriqSmy9tKyNUYEmid/srp9Q899496MIT/3mCQRMuAM5cBH7
        O75uPBymL6CHdPmAR8VZKFMh6ONW16zIcUYjtqUvMwr/71dPcyCoLJgIqO0lT6hWmJYjjDuODbOar
        0h0XewgIPVGMYtTN0+Wb6iCnTJeXB4MwNkhnJVKzasYWwb+xK47oUzC+2tmEnlUoZ+jvRobvp+UEm
        nw2iPTkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk9Sb-0007gJ-Q8; Tue, 01 Dec 2020 17:29:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F2983003E1;
        Tue,  1 Dec 2020 18:29:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 294CC20103D72; Tue,  1 Dec 2020 18:29:03 +0100 (CET)
Date:   Tue, 1 Dec 2020 18:29:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
Message-ID: <20201201172903.GT3040@hirez.programming.kicks-ass.net>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130193842.10569-3-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:38:42AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Some calls to sched_task() in a context switch can be avoided. For
> example, large PEBS only requires flushing the buffer in context switch
> out. The current code still invokes the sched_task() for large PEBS in
> context switch in.

I still hate this one, how's something like this then?
Which I still don't really like.. but at least its simpler.

(completely untested, may contain spurious edits, might ICE the
compiler and set your pets on fire if it doesn't)

And given this is an optimization, can we actually measure it to improve
matters?

---

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -380,7 +380,7 @@ static void power_pmu_bhrb_enable(struct
 		cpuhw->bhrb_context = event->ctx;
 	}
 	cpuhw->bhrb_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event);
 }
 
 static void power_pmu_bhrb_disable(struct perf_event *event)
@@ -392,7 +392,7 @@ static void power_pmu_bhrb_disable(struc
 
 	WARN_ON_ONCE(!cpuhw->bhrb_users);
 	cpuhw->bhrb_users--;
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event);
 
 	if (!cpuhw->disabled && !cpuhw->bhrb_users) {
 		/* BHRB cannot be turned off when other
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3567,7 +3567,7 @@ static int intel_pmu_hw_config(struct pe
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event))) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
-				event->attach_state |= PERF_ATTACH_SCHED_CB;
+				event->attach_state |= PERF_ATTACH_SCHED_CB_OUT;
 			}
 		}
 		if (x86_pmu.pebs_aliases)
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1014,7 +1014,6 @@ static void
 pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 		  struct perf_event *event, bool add)
 {
-	struct pmu *pmu = event->ctx->pmu;
 	/*
 	 * Make sure we get updated with the first PEBS
 	 * event. It will trigger also during removal, but
@@ -1024,9 +1023,9 @@ pebs_update_state(bool needed_cb, struct
 
 	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
 		if (!needed_cb)
-			perf_sched_cb_inc(pmu);
+			perf_sched_cb_inc(event);
 		else
-			perf_sched_cb_dec(pmu);
+			perf_sched_cb_dec(event);
 
 		update = true;
 	}
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -693,7 +693,7 @@ void intel_pmu_lbr_add(struct perf_event
 	 */
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
 
@@ -740,7 +740,7 @@ void intel_pmu_lbr_del(struct perf_event
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event);
 }
 
 static inline bool vlbr_exclude_host(void)
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -601,12 +601,14 @@ struct swevent_hlist {
 	struct rcu_head			rcu_head;
 };
 
-#define PERF_ATTACH_CONTEXT	0x01
-#define PERF_ATTACH_GROUP	0x02
-#define PERF_ATTACH_TASK	0x04
-#define PERF_ATTACH_TASK_DATA	0x08
-#define PERF_ATTACH_ITRACE	0x10
-#define PERF_ATTACH_SCHED_CB	0x20
+#define PERF_ATTACH_CONTEXT		0x01
+#define PERF_ATTACH_GROUP		0x02
+#define PERF_ATTACH_TASK		0x04
+#define PERF_ATTACH_TASK_DATA		0x08
+#define PERF_ATTACH_ITRACE		0x10
+#define PERF_ATTACH_SCHED_CB_IN		0x20
+#define PERF_ATTACH_SCHED_CB_OUT	0x40
+#define PERF_ATTACH_SCHED_CB		0x60
 
 struct perf_cgroup;
 struct perf_buffer;
@@ -875,6 +877,7 @@ struct perf_cpu_context {
 
 	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
+	int				sched_cb_dir[2];
 
 	int				online;
 	/*
@@ -967,8 +970,8 @@ extern const struct perf_event_attr *per
 extern void perf_event_print_debug(void);
 extern void perf_pmu_disable(struct pmu *pmu);
 extern void perf_pmu_enable(struct pmu *pmu);
-extern void perf_sched_cb_dec(struct pmu *pmu);
-extern void perf_sched_cb_inc(struct pmu *pmu);
+extern void perf_sched_cb_dec(struct perf_event *event);
+extern void perf_sched_cb_inc(struct perf_event *event);
 extern int perf_event_task_disable(void);
 extern int perf_event_task_enable(void);
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -384,7 +384,6 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
-static DEFINE_PER_CPU(int, perf_sched_cb_usage);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -3376,6 +3375,16 @@ static void perf_event_sync_stat(struct
 	}
 }
 
+static void context_sched_task(struct perf_cpu_context *cpuctx,
+			       struct perf_event_context *ctx,
+			       bool sched_in)
+{
+	struct pmu *pmu = ctx->pmu;
+
+	if (cpuctx->sched_cb_dir[sched_in] && pmu->sched_task)
+		pmu->sched_task(ctx, false);
+}
+
 static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 					 struct task_struct *next)
 {
@@ -3424,9 +3433,7 @@ static void perf_event_context_sched_out
 			WRITE_ONCE(next_ctx->task, task);
 
 			perf_pmu_disable(pmu);
-
-			if (cpuctx->sched_cb_usage && pmu->sched_task)
-				pmu->sched_task(ctx, false);
+			context_sched_task(cpuctx, ctx, false);
 
 			/*
 			 * PMU specific parts of task perf context can require
@@ -3465,8 +3472,7 @@ static void perf_event_context_sched_out
 		raw_spin_lock(&ctx->lock);
 		perf_pmu_disable(pmu);
 
-		if (cpuctx->sched_cb_usage && pmu->sched_task)
-			pmu->sched_task(ctx, false);
+		context_sched_task(cpuctx, ctx, false);
 		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
 
 		perf_pmu_enable(pmu);
@@ -3476,25 +3482,38 @@ static void perf_event_context_sched_out
 
 static DEFINE_PER_CPU(struct list_head, sched_cb_list);
 
-void perf_sched_cb_dec(struct pmu *pmu)
+void perf_sched_cb_dec(struct perf_event *event)
 {
+	struct perf_event_context *ctx = event->ctx;
+	struct pmu *pmu = ctx->pmu;
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	this_cpu_dec(perf_sched_cb_usage);
-
-	if (!--cpuctx->sched_cb_usage)
+	if (!ctx->task && !--cpuctx->sched_cb_usage)
 		list_del(&cpuctx->sched_cb_entry);
+
+	if (event->attach_state & PERF_ATTACH_SCHED_CB_OUT)
+		cpuctx->sched_cb_dir[0]--;
+	if (event->attach_state & PERF_ATTACH_SCHED_CB_IN)
+		cpuctx->sched_cb_dir[1]--;
 }
 
 
-void perf_sched_cb_inc(struct pmu *pmu)
+void perf_sched_cb_inc(struct perf_event *event)
 {
+	struct perf_event_context *ctx = event->ctx;
+	struct pmu *pmu = ctx->pmu;
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	if (!cpuctx->sched_cb_usage++)
+	if (!ctx->task && !cpuctx->sched_cb_usage++)
 		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
 
-	this_cpu_inc(perf_sched_cb_usage);
+	if (!(event->attach_state & PERF_ATTACH_SCHED_CB))
+		event->attach_state |= PERF_ATTACH_SCHED_CB;
+
+	if (event->attach_state & PERF_ATTACH_SCHED_CB_OUT)
+		cpuctx->sched_cb_dir[0]++;
+	if (event->attach_state & PERF_ATTACH_SCHED_CB_IN)
+		cpuctx->sched_cb_dir[1]++;
 }
 
 /*
@@ -3523,9 +3542,9 @@ static void __perf_pmu_sched_task(struct
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
-static void perf_pmu_sched_task(struct task_struct *prev,
-				struct task_struct *next,
-				bool sched_in)
+static inline void perf_pmu_sched_task(struct task_struct *prev,
+				       struct task_struct *next,
+				       bool sched_in)
 {
 	struct perf_cpu_context *cpuctx;
 
@@ -3563,8 +3582,7 @@ void __perf_event_task_sched_out(struct
 {
 	int ctxn;
 
-	if (__this_cpu_read(perf_sched_cb_usage))
-		perf_pmu_sched_task(task, next, false);
+	perf_pmu_sched_task(task, next, false);
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
@@ -3828,8 +3846,7 @@ static void perf_event_context_sched_in(
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
-		pmu->sched_task(cpuctx->task_ctx, true);
+	context_sched_task(cpuctx, ctx, true);
 
 	perf_pmu_enable(pmu);
 
@@ -3875,8 +3892,7 @@ void __perf_event_task_sched_in(struct t
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
 
-	if (__this_cpu_read(perf_sched_cb_usage))
-		perf_pmu_sched_task(prev, task, true);
+	perf_pmu_sched_task(prev, task, true);
 }
 
 static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
