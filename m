Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F932486DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHRON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHROMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B130C061346
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DCeGmMIutx+7JL5yFGAwkEsJ/2/eH+8wgUgvI1srLwE=; b=eC798iBEvGIZNVmiozaHJExu4H
        LjYt/ZU1ZqlJnNMc/857+79YxlH2tT/iGut/tiLHsXOi7mPf7/VHsXcusuWu1O6ev/TxDWHbWRFtw
        QWi1clcZcPWXCEmtzdZGipvfGoR8a/U5yPY6GZm/L0GHLWvUuC2nEMPrnqBpGUlkZYI0NJDyUmddf
        nqGwW+qCSflQd03OWCzdrOnjxvP5LiXO64ZotJuyo9MAML9VxpP/NTa9O8SIwW7qL/3K8ZyYkGasJ
        48zcinkU0g4BposbmD9oVdArRD9Iw7qQfMO8P2RGwLddDG8sqYU6JbLPKp1IZUor/EzOjMEKB8vJm
        bBo63Kkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LL-0006VJ-6e; Tue, 18 Aug 2020 14:12:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B81183079A3;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F28A923D42C12; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135805.338001015@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 18/18] x86/perf, static_call: Optimize x86_pmu methods
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace many of the indirect calls with static_call().

The average PMI time, as measured by perf_sample_event_took()*:

PRE:    3283.03 [ns]
POST:   3145.12 [ns]

Which is a ~138 [ns] win per PMI, or a ~4.2% decrease.

[*] on an IVB-EP, using: 'perf record -a -e cycles -- make O=defconfig-build/ -j80'

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |  140 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 40 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/nospec.h>
+#include <linux/static_call.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -52,6 +53,34 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
+/*
+ * This here uses DEFINE_STATIC_CALL_NULL() to get a static_call defined
+ * from just a typename, as opposed to an actual function.
+ */
+DEFINE_STATIC_CALL_NULL(x86_pmu_handle_irq,  *x86_pmu.handle_irq);
+DEFINE_STATIC_CALL_NULL(x86_pmu_disable_all, *x86_pmu.disable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_enable_all,  *x86_pmu.enable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_enable,	     *x86_pmu.enable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_disable,     *x86_pmu.disable);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x86_pmu.add);
+DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
+DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
+DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
+DEFINE_STATIC_CALL_NULL(x86_pmu_put_event_constraints, *x86_pmu.put_event_constraints);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_start_scheduling,  *x86_pmu.start_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
+DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
+DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
+
+DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
+
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -660,7 +695,7 @@ static void x86_pmu_disable(struct pmu *
 	cpuc->enabled = 0;
 	barrier();
 
-	x86_pmu.disable_all();
+	static_call(x86_pmu_disable_all)();
 }
 
 void x86_pmu_enable_all(int added)
@@ -907,8 +942,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	if (x86_pmu.start_scheduling)
-		x86_pmu.start_scheduling(cpuc);
+	static_call_cond(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -925,7 +959,7 @@ int x86_schedule_events(struct cpu_hw_ev
 		 * change due to external factors (sibling state, allow_tfa).
 		 */
 		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
-			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			c = static_call(x86_pmu_get_event_constraints)(cpuc, i, cpuc->event_list[i]);
 			cpuc->event_constraint[i] = c;
 		}
 
@@ -1008,8 +1042,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			if (x86_pmu.commit_scheduling)
-				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
+			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 		}
 	} else {
 		for (i = n0; i < n; i++) {
@@ -1018,15 +1051,13 @@ int x86_schedule_events(struct cpu_hw_ev
 			/*
 			 * release events that failed scheduling
 			 */
-			if (x86_pmu.put_event_constraints)
-				x86_pmu.put_event_constraints(cpuc, e);
+			static_call_cond(x86_pmu_put_event_constraints)(cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	if (x86_pmu.stop_scheduling)
-		x86_pmu.stop_scheduling(cpuc);
+	static_call_cond(x86_pmu_stop_scheduling)(cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1217,7 +1248,7 @@ static void x86_pmu_enable(struct pmu *p
 	cpuc->enabled = 1;
 	barrier();
 
-	x86_pmu.enable_all(added);
+	static_call(x86_pmu_enable_all)(added);
 }
 
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
@@ -1338,7 +1369,7 @@ static int x86_pmu_add(struct perf_event
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		goto out;
 	/*
@@ -1356,13 +1387,11 @@ static int x86_pmu_add(struct perf_event
 	cpuc->n_added += n - n0;
 	cpuc->n_txn += n - n0;
 
-	if (x86_pmu.add) {
-		/*
-		 * This is before x86_pmu_enable() will call x86_pmu_start(),
-		 * so we enable LBRs before an event needs them etc..
-		 */
-		x86_pmu.add(event);
-	}
+	/*
+	 * This is before x86_pmu_enable() will call x86_pmu_start(),
+	 * so we enable LBRs before an event needs them etc..
+	 */
+	static_call_cond(x86_pmu_add)(event);
 
 	ret = 0;
 out:
@@ -1390,7 +1419,7 @@ static void x86_pmu_start(struct perf_ev
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	__set_bit(idx, cpuc->running);
-	x86_pmu.enable(event);
+	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
 
@@ -1460,7 +1489,7 @@ void x86_pmu_stop(struct perf_event *eve
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		x86_pmu.disable(event);
+		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
@@ -1510,8 +1539,7 @@ static void x86_pmu_del(struct perf_even
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	if (x86_pmu.put_event_constraints)
-		x86_pmu.put_event_constraints(cpuc, event);
+	static_call_cond(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1524,13 +1552,12 @@ static void x86_pmu_del(struct perf_even
 	perf_event_update_userpage(event);
 
 do_del:
-	if (x86_pmu.del) {
-		/*
-		 * This is after x86_pmu_stop(); so we disable LBRs after any
-		 * event can need them etc..
-		 */
-		x86_pmu.del(event);
-	}
+
+	/*
+	 * This is after x86_pmu_stop(); so we disable LBRs after any
+	 * event can need them etc..
+	 */
+	static_call_cond(x86_pmu_del)(event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -1608,7 +1635,7 @@ perf_event_nmi_handler(unsigned int cmd,
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = x86_pmu.handle_irq(regs);
+	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
@@ -1821,6 +1848,38 @@ ssize_t x86_event_sysfs_show(char *page,
 static struct attribute_group x86_pmu_attr_group;
 static struct attribute_group x86_pmu_caps_group;
 
+static void x86_pmu_static_call_update(void)
+{
+	static_call_update(x86_pmu_handle_irq, x86_pmu.handle_irq);
+	static_call_update(x86_pmu_disable_all, x86_pmu.disable_all);
+	static_call_update(x86_pmu_enable_all, x86_pmu.enable_all);
+	static_call_update(x86_pmu_enable, x86_pmu.enable);
+	static_call_update(x86_pmu_disable, x86_pmu.disable);
+
+	static_call_update(x86_pmu_add, x86_pmu.add);
+	static_call_update(x86_pmu_del, x86_pmu.del);
+	static_call_update(x86_pmu_read, x86_pmu.read);
+
+	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
+	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
+	static_call_update(x86_pmu_put_event_constraints, x86_pmu.put_event_constraints);
+
+	static_call_update(x86_pmu_start_scheduling, x86_pmu.start_scheduling);
+	static_call_update(x86_pmu_commit_scheduling, x86_pmu.commit_scheduling);
+	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
+
+	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
+	static_call_update(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
+
+	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
+	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
+}
+
+static void _x86_pmu_read(struct perf_event *event)
+{
+	x86_perf_event_update(event);
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -1889,6 +1948,11 @@ static int __init init_hw_perf_events(vo
 	pr_info("... fixed-purpose events:   %d\n",     x86_pmu.num_counters_fixed);
 	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
 
+	if (!x86_pmu.read)
+		x86_pmu.read = _x86_pmu_read;
+
+	x86_pmu_static_call_update();
+
 	/*
 	 * Install callbacks. Core will call them for each online
 	 * cpu.
@@ -1925,11 +1989,9 @@ static int __init init_hw_perf_events(vo
 }
 early_initcall(init_hw_perf_events);
 
-static inline void x86_pmu_read(struct perf_event *event)
+static void x86_pmu_read(struct perf_event *event)
 {
-	if (x86_pmu.read)
-		return x86_pmu.read(event);
-	x86_perf_event_update(event);
+	static_call(x86_pmu_read)(event);
 }
 
 /*
@@ -2006,7 +2068,7 @@ static int x86_pmu_commit_txn(struct pmu
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		return ret;
 
@@ -2299,15 +2361,13 @@ static const struct attribute_group *x86
 
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
-	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
 				  struct perf_event_context *next)
 {
-	if (x86_pmu.swap_task_ctx)
-		x86_pmu.swap_task_ctx(prev, next);
+	static_call_cond(x86_pmu_swap_task_ctx)(prev, next);
 }
 
 void perf_check_microcode(void)


