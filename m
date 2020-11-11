Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE42AF643
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKKQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:25:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAECC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mynt2a8IAPIU9Yz15o8FZmNkZ1SCjD9s8O21JrofvzM=; b=DWHY0RrYALVM4n1BNCNFMRLVUZ
        EVwXUH+MoLvHDzuiC1Ifw3LXXUpIMz0IM9MBWdvNg6eq+vl7fgU4fGZwvwaIII+4+blDS+/3blAmN
        fRfpJHHhNyO3iF2mCV4V28Ms3+/e8EQuRuobA2+ilP9avpSEku02sTgK3ZncyR/fAhJxQrxP4z4rx
        +5JvstNW9N8SZgPNOwNIAtOwaf2EB5ZLFy7G1rgtBfsN5z9bBOUZPpWcnCnUtBM0yCi1/GWkS9cep
        ZERwqNj7ep5iMv51kdeo5/BtQaNak7QiBHXEqwj/ADn3YTJ9BeFVksQJd0IfIIMS3ZQCNpVulSoOY
        aQzWtpGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcsvm-00012M-Q9; Wed, 11 Nov 2020 16:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA5AD301E02;
        Wed, 11 Nov 2020 17:25:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94F53203E65DA; Wed, 11 Nov 2020 17:25:09 +0100 (CET)
Date:   Wed, 11 Nov 2020 17:25:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
Message-ID: <20201111162509.GW2611@hirez.programming.kicks-ass.net>
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net>
 <20201109110405.GN2651@hirez.programming.kicks-ass.net>
 <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:

> - When the large PEBS was introduced (9c964efa4330), the sched_task() should
> be invoked to flush the PEBS buffer in each context switch. However, The
> perf_sched_events in account_event() is not updated accordingly. The
> perf_event_task_sched_* never be invoked for a pure per-CPU context. Only
> per-task event works.
>    At that time, the perf_pmu_sched_task() is outside of
> perf_event_context_sched_in/out. It means that perf has to double
> perf_pmu_disable() for per-task event.

> - The patch 1 tries to fix broken per-CPU events. The CPU context cannot be
> retrieved from the task->perf_event_ctxp. So it has to be tracked in the
> sched_cb_list. Yes, the code is very similar to the original codes, but it
> is actually the new code for per-CPU events. The optimization for per-task
> events is still kept.
>   For the case, which has both a CPU context and a task context, yes, the
> __perf_pmu_sched_task() in this patch is not invoked. Because the
> sched_task() only need to be invoked once in a context switch. The
> sched_task() will be eventually invoked in the task context.

The thing is; your first two patches rely on PERF_ATTACH_SCHED_CB and
only set that for large pebs. Are you sure the other users (Intel LBR
and PowerPC BHRB) don't need it?

If they indeed do not require the pmu::sched_task() callback for CPU
events, then I still think the whole perf_sched_cb_{inc,dec}() interface
is confusing at best.

Can't we do something like this instead?

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 546cc89217bb..672d6f039fce 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3565,8 +3565,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event)))
+			      ~intel_pmu_large_pebs_flags(event))) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
+				event->attach_state |= PERF_ATTACH_SCHED_CB;
+			}
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f579bc76..af9ee539c179 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -606,6 +606,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_TASK	0x04
 #define PERF_ATTACH_TASK_DATA	0x08
 #define PERF_ATTACH_ITRACE	0x10
+#define PERF_ATTACH_SCHED_CB	0x20
 
 struct perf_cgroup;
 struct perf_buffer;
@@ -817,6 +818,7 @@ struct perf_event_context {
 	int				is_active;
 	int				nr_stat;
 	int				nr_freq;
+	int				nr_sched_task;
 	int				rotate_disable;
 	/*
 	 * Set when nr_events != nr_active, except tolerant to events not
@@ -872,7 +874,7 @@ struct perf_cpu_context {
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
-	int				sched_cb_usage;
+	struct list_head		sched_cb_entry;
 
 	int				online;
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d2f3ca792936..0a5dfed6bb46 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -384,6 +384,7 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
+static DEFINE_PER_CPU(int, perf_sched_cb_usage);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -2292,6 +2293,12 @@ event_sched_out(struct perf_event *event,
 		perf_event_ctx_deactivate(ctx);
 	if (event->attr.freq && event->attr.sample_freq)
 		ctx->nr_freq--;
+	if (event->attach_state & PERF_ATTACH_SCHED_CB) {
+		if (!--ctx->nr_sched_task && &cpuctx->ctx == ctx) {
+			list_del(&cpuctx->sched_cb_entry);
+			this_cpu_dec(perf_sched_cb_usage);
+		}
+	}
 	if (event->attr.exclusive || !cpuctx->active_oncpu)
 		cpuctx->exclusive = 0;
 
@@ -2564,6 +2571,12 @@ event_sched_in(struct perf_event *event,
 		perf_event_ctx_activate(ctx);
 	if (event->attr.freq && event->attr.sample_freq)
 		ctx->nr_freq++;
+	if (event->attach_state & PERF_ATTACH_SCHED_CB) {
+		if (!ctx->nr_sched_task++ && &cpuctx->ctx == ctx) {
+			list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+			this_cpu_inc(perf_sched_cb_usage);
+		}
+	}
 
 	if (event->attr.exclusive)
 		cpuctx->exclusive = 1;
@@ -3424,7 +3437,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 
 			perf_pmu_disable(pmu);
 
-			if (cpuctx->sched_cb_usage && pmu->sched_task)
+			if (ctx->nr_sched_task)
 				pmu->sched_task(ctx, false);
 
 			/*
@@ -3464,7 +3477,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		perf_pmu_disable(pmu);
 
-		if (cpuctx->sched_cb_usage && pmu->sched_task)
+		if (ctx->nr_sched_task)
 			pmu->sched_task(ctx, false);
 		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
 
@@ -3473,20 +3486,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 	}
 }
 
-void perf_sched_cb_dec(struct pmu *pmu)
-{
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
-
-	--cpuctx->sched_cb_usage;
-}
-
-
-void perf_sched_cb_inc(struct pmu *pmu)
-{
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
-
-	cpuctx->sched_cb_usage++;
-}
+static DEFINE_PER_CPU(struct list_head, sched_cb_list);
 
 /*
  * This function provides the context switch callback to the lower code
@@ -3514,6 +3514,24 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
+static void perf_pmu_sched_task(struct task_struct *prev,
+				struct task_struct *next,
+				bool sched_in)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (prev == next)
+		return;
+
+	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		/* will be handled in perf_event_context_sched_in/out */
+		if (cpuctx->task_ctx)
+			continue;
+
+		__perf_pmu_sched_task(cpuctx, sched_in);
+	}
+}
+
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
@@ -3536,6 +3554,9 @@ void __perf_event_task_sched_out(struct task_struct *task,
 {
 	int ctxn;
 
+	if (__this_cpu_read(perf_sched_cb_usage))
+		perf_pmu_sched_task(task, next, false);
+
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
@@ -3772,7 +3793,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 
 	cpuctx = __get_cpu_context(ctx);
 	if (cpuctx->task_ctx == ctx) {
-		if (cpuctx->sched_cb_usage)
+		if (ctx->nr_sched_task)
 			__perf_pmu_sched_task(cpuctx, true);
 		return;
 	}
@@ -3798,8 +3819,8 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
-		pmu->sched_task(cpuctx->task_ctx, true);
+	if (ctx->nr_sched_task)
+		pmu->sched_task(ctx, true);
 
 	perf_pmu_enable(pmu);
 
@@ -3844,6 +3865,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
+
+	if (__this_cpu_read(perf_sched_cb_usage))
+		perf_pmu_sched_task(prev, task, true);
 }
 
 static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
@@ -4668,7 +4692,7 @@ static void unaccount_event(struct perf_event *event)
 	if (event->parent)
 		return;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
@@ -11195,7 +11219,7 @@ static void account_event(struct perf_event *event)
 	if (event->parent)
 		return;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
@@ -12987,6 +13011,7 @@ static void __init perf_event_init_all_cpus(void)
 #ifdef CONFIG_CGROUP_PERF
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
+		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 	}
 }
 
