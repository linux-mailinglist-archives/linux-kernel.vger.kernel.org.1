Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8A1C5955
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgEEONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgEEONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5D3C0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyJx-0000Hh-Ta; Tue, 05 May 2020 16:13:18 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 62729FFC8D;
        Tue,  5 May 2020 16:13:17 +0200 (CEST)
Message-Id: <20200505134058.361859938@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler IPI has grown weird and wonderful over the years, time
for spring cleaning.

Move all the non-trivial stuff out of it and into a regular smp function
call IPI. This then reduces the schedule_ipi() to most of it's former MOP
glory and ensures to keep the interrupt vector lean and mean.

Aside of that avoiding the full irq_enter() in the x86 IPI implementation
is incorrect as scheduler_ipi() can be instrumented. To work around that
scheduler_ipi() had an irq_enter/exit() hack when heavy work was
pending. This is gone now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c  |   64 +++++++++++++++++++++++----------------------------
 kernel/sched/fair.c  |    5 +--
 kernel/sched/sched.h |    6 +++-
 3 files changed, 36 insertions(+), 39 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -219,6 +219,13 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
+static inline void
+rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
+{
+	csd->flags = 0;
+	csd->func = func;
+	csd->info = rq;
+}
 
 #ifdef CONFIG_SCHED_HRTICK
 /*
@@ -314,16 +321,14 @@ void hrtick_start(struct rq *rq, u64 del
 	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
 		      HRTIMER_MODE_REL_PINNED_HARD);
 }
+
 #endif /* CONFIG_SMP */
 
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq->hrtick_csd.flags = 0;
-	rq->hrtick_csd.func = __hrtick_start;
-	rq->hrtick_csd.info = rq;
+	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
 #endif
-
 	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
 }
@@ -650,6 +655,16 @@ static inline bool got_nohz_idle_kick(vo
 	return false;
 }
 
+static void nohz_csd_func(void *info)
+{
+	struct rq *rq = info;
+
+	if (got_nohz_idle_kick()) {
+		rq->idle_balance = 1;
+		raise_softirq_irqoff(SCHED_SOFTIRQ);
+	}
+}
+
 #else /* CONFIG_NO_HZ_COMMON */
 
 static inline bool got_nohz_idle_kick(void)
@@ -2292,6 +2307,11 @@ void sched_ttwu_pending(void)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
+static void wake_csd_func(void *info)
+{
+	sched_ttwu_pending();
+}
+
 void scheduler_ipi(void)
 {
 	/*
@@ -2300,34 +2320,6 @@ void scheduler_ipi(void)
 	 * this IPI.
 	 */
 	preempt_fold_need_resched();
-
-	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
-		return;
-
-	/*
-	 * Not all reschedule IPI handlers call irq_enter/irq_exit, since
-	 * traditionally all their work was done from the interrupt return
-	 * path. Now that we actually do some work, we need to make sure
-	 * we do call them.
-	 *
-	 * Some archs already do call them, luckily irq_enter/exit nest
-	 * properly.
-	 *
-	 * Arguably we should visit all archs and update all handlers,
-	 * however a fair share of IPIs are still resched only so this would
-	 * somewhat pessimize the simple resched case.
-	 */
-	irq_enter();
-	sched_ttwu_pending();
-
-	/*
-	 * Check if someone kicked us for doing the nohz idle load balance.
-	 */
-	if (unlikely(got_nohz_idle_kick())) {
-		this_rq()->idle_balance = 1;
-		raise_softirq_irqoff(SCHED_SOFTIRQ);
-	}
-	irq_exit();
 }
 
 static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
@@ -2336,9 +2328,9 @@ static void ttwu_queue_remote(struct tas
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
-	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
+	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
-			smp_send_reschedule(cpu);
+			smp_call_function_single_async(cpu, &rq->wake_csd);
 		else
 			trace_sched_wake_idle_without_ipi(cpu);
 	}
@@ -6685,12 +6677,16 @@ void __init sched_init(void)
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
+		rq_csd_init(rq, &rq->wake_csd, wake_csd_func);
+
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
+
+		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10009,12 +10009,11 @@ static void kick_ilb(unsigned int flags)
 		return;
 
 	/*
-	 * Use smp_send_reschedule() instead of resched_cpu().
-	 * This way we generate a sched IPI on the target CPU which
+	 * This way we generate an IPI on the target CPU which
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_send_reschedule(ilb_cpu);
+	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->wake_csd);
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -890,9 +890,10 @@ struct rq {
 #ifdef CONFIG_SMP
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
+	call_single_data_t	nohz_csd;
 #endif /* CONFIG_SMP */
 	unsigned int		nohz_tick_stopped;
-	atomic_t nohz_flags;
+	atomic_t		nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
 	unsigned long		nr_load_updates;
@@ -979,7 +980,7 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
-#endif
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
@@ -1021,6 +1022,7 @@ struct rq {
 #endif
 
 #ifdef CONFIG_SMP
+	call_single_data_t	wake_csd;
 	struct llist_head	wake_list;
 #endif
 

