Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53ED26C89C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgIPSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgIPSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D6C08E8BB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cPoHsh3Zn5KSw4VDzRJvxDxWwLUjpfqu8faDYE/sRaQ=; b=muLlNkUHiyiwKwcnjadeilB5KM
        dkkE0lRqQrmB3E5cAcp4yQ5GF5q11HmYBOpchf2iAl1NeRwjDak2Vyfp7PbiY3DFU2ZurJHZtmjCQ
        1fvE33Y8939khgXYfEel5v6vW/rMzGqAeRcajJWMfvN4FN7l+H8nVTcBnGn03TQuhuvC63PAk7aWf
        HP0KKyZh8VRuFHNxhBgTy2e73WU7myzNL5UJ4fkLujpebJcgqtyDL8rfTrYXY01E+uwzow5wPfRAz
        Dz5iW5nYcPrHJkVsD2s2SShExSKhs0Qky0BdFHDMhssPxp0fw8gbG6e0YGeLPI1HyElOVIA3PP/gS
        CIT3lwTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIWGU-0001xn-Hd; Wed, 16 Sep 2020 12:10:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0059C3011FE;
        Wed, 16 Sep 2020 14:10:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4A3C21242341; Wed, 16 Sep 2020 14:10:20 +0200 (CEST)
Date:   Wed, 16 Sep 2020 14:10:20 +0200
From:   peterz@infradead.org
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Message-ID: <20200916121020.GP2674@hirez.programming.kicks-ass.net>
References: <20200911081745.214686199@infradead.org>
 <20200911082536.528661716@infradead.org>
 <20200916101845.5ikjhfk27bgvs3pe@flow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916101845.5ikjhfk27bgvs3pe@flow>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:18:45PM +0200, Sebastian Andrzej Siewior wrote:
> With this on top of -rc5 I get:
> 
> [   42.678670] process 1816 (hackbench) no longer affine to cpu2
> [   42.678684] process 1817 (hackbench) no longer affine to cpu2
> [   42.710502] ------------[ cut here ]------------
> [   42.711505] rq->clock_update_flags < RQCF_ACT_SKIP
> [   42.711514] WARNING: CPU: 2 PID: 19 at kernel/sched/sched.h:1141 update_curr+0xe3/0x3f0

> [   42.736635]  select_fallback_rq+0x129/0x160
> [   42.737450]  __balance_push_stop+0x132/0x230

Duh.. I wonder why I didn't see that.. anyway, I think the below version
ought to cure that.

> That comes due to DEQUEUE_NOCLOCK in do_set_cpus_allowed(). And then
> there is this:
> 
> [   42.752454] ======================================================
> [   42.752455] WARNING: possible circular locking dependency detected
> [   42.752455] 5.9.0-rc5+ #107 Not tainted
> [   42.752455] ------------------------------------------------------
> [   42.752456] migration/2/19 is trying to acquire lock:
> [   42.752456] ffffffff824639f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xa/0x30
> [   42.752458] but task is already holding lock:
> [   42.752458] ffff888276ca9598 (&rq->lock){-.-.}-{2:2}, at: __balance_push_stop+0x50/0x230
> [   42.752460] which lock already depends on the new lock.

Yeah, that's the known issue with printk()...


---
Subject: sched/hotplug: Ensure only per-cpu kthreads run during hotplug
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Sep 11 09:54:27 CEST 2020

In preparation for migrate_disable(), make sure only per-cpu kthreads
are allowed to run on !active CPUs.

This is ran (as one of the very first steps) from the cpu-hotplug
task which is a per-cpu kthread and completion of the hotplug
operation only requires such tasks.

This constraint enables the migrate_disable() implementation to wait
for completion of all migrate_disable regions on this CPU at hotplug
time without fear of any new ones starting.

This replaces the unlikely(rq->balance_callbacks) test at the tail of
context_switch with an unlikely(rq->balance_work), the fast path is
not affected.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |    5 ++
 2 files changed, 117 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3513,8 +3513,10 @@ static inline struct callback_head *spli
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head)
+	if (head) {
 		rq->balance_callback = NULL;
+		rq->balance_flags &= ~BALANCE_WORK;
+	}
 
 	return head;
 }
@@ -3535,6 +3537,22 @@ static inline void balance_callbacks(str
 	}
 }
 
+static bool balance_push(struct rq *rq);
+
+static inline void balance_switch(struct rq *rq)
+{
+	if (unlikely(rq->balance_flags)) {
+		/*
+		 * Run the balance_callbacks, except on hotplug
+		 * when we need to push the current task away.
+		 */
+		if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
+		    !(rq->balance_flags & BALANCE_PUSH) ||
+		    !balance_push(rq))
+			__balance_callbacks(rq);
+	}
+}
+
 #else
 
 static inline void __balance_callbacks(struct rq *rq)
@@ -3550,6 +3568,10 @@ static inline void balance_callbacks(str
 {
 }
 
+static inline void balance_switch(struct rq *rq)
+{
+}
+
 #endif
 
 static inline void
@@ -3577,7 +3599,7 @@ static inline void finish_lock_switch(st
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	balance_switch(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -6836,6 +6858,89 @@ static void migrate_tasks(struct rq *dea
 
 	rq->stop = stop;
 }
+
+static int __balance_push_cpu_stop(void *arg)
+{
+	struct task_struct *p = arg;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+	int cpu;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	rq_lock(rq, &rf);
+
+	update_rq_clock();
+
+	if (task_rq(p) == rq && task_on_rq_queued(p)) {
+		cpu = select_fallback_rq(rq->cpu, p);
+		rq = __migrate_task(rq, &rf, p, cpu);
+	}
+
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
+
+/*
+ * Ensure we only run per-cpu kthreads once the CPU goes !active.
+ */
+static bool balance_push(struct rq *rq)
+{
+	struct task_struct *push_task = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+
+	/*
+	 * Both the cpu-hotplug and stop task are in this case and are
+	 * required to complete the hotplug process.
+	 */
+	if (is_per_cpu_kthread(push_task))
+		return false;
+
+	get_task_struct(push_task);
+	/*
+	 * Temporarily drop rq->lock such that we can wake-up the stop task.
+	 * Both preemption and IRQs are still disabled.
+	 */
+	raw_spin_unlock(&rq->lock);
+	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
+			    this_cpu_ptr(&push_work));
+	/*
+	 * At this point need_resched() is true and we'll take the loop in
+	 * schedule(). The next pick is obviously going to be the stop task
+	 * which is_per_cpu_kthread() and will push this task away.
+	 */
+	raw_spin_lock(&rq->lock);
+
+	return true;
+}
+
+static void balance_push_set(int cpu, bool on)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (on)
+		rq->balance_flags |= BALANCE_PUSH;
+	else
+		rq->balance_flags &= ~BALANCE_PUSH;
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+#else
+
+static inline bool balance_push(struct rq *rq)
+{
+	return false;
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6921,6 +7026,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -6968,6 +7075,8 @@ int sched_cpu_deactivate(unsigned int cp
 	 */
 	synchronize_rcu();
 
+	balance_push_set(cpu, true);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -6981,6 +7090,7 @@ int sched_cpu_deactivate(unsigned int cp
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -973,6 +973,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1384,6 +1385,9 @@ init_numa_balancing(unsigned long clone_
 
 #ifdef CONFIG_SMP
 
+#define BALANCE_WORK	0x01
+#define BALANCE_PUSH	0x02
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1397,6 +1401,7 @@ queue_balance_callback(struct rq *rq,
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
