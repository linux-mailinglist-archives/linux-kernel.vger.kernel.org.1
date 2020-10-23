Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC33F296CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462338AbgJWKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462266AbgJWKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE02C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UPhP6jNnoiENPNgu0BUJDKK+cwBkBTVOMPQuNogGnOU=; b=wST3pIXajFDu2yVSt+WIRUglhk
        35+rjgvwmeR7lcYrk21O+akwzGV6ZKAhZmNSKOiD0ngtCX19n4aF82rA5nN4uSDhQO5pdPuIXrxCJ
        QlDAsOFzqWJwe0HatirzEGu0xkYvYLTgkb/vmdc+3SY9sB/5sM92iqIY5Nx6M3J83YbKQBlNJ57iW
        FempPi2aRYQUNKH0d0hyJ8OhtLPD/OVhYJfCCfKDqGYo5ucYw/7dO8WA/ZAkR/8+kHZAls2iLchdw
        mjNKZHMiNzzrxhiAUYwG8OpjI26Yui9/5Hmqdf6WK5VWqOa2+Ley/E6A8DqBGT42rCr/6ooUDJrZF
        +nhlLY+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFn-0002sz-D3; Fri, 23 Oct 2020 10:25:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72FC7305CC3;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3F31A29DDA65A; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102346.292709163@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 03/19] sched/hotplug: Ensure only per-cpu kthreads run during hotplug
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 kernel/sched/sched.h |    7 ++-
 2 files changed, 118 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3509,8 +3509,10 @@ static inline struct callback_head *spli
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head)
+	if (head) {
 		rq->balance_callback = NULL;
+		rq->balance_flags &= ~BALANCE_WORK;
+	}
 
 	return head;
 }
@@ -3531,6 +3533,21 @@ static inline void balance_callbacks(str
 	}
 }
 
+static void balance_push(struct rq *rq);
+
+static inline void balance_switch(struct rq *rq)
+{
+	if (likely(!rq->balance_flags))
+		return;
+
+	if (rq->balance_flags & BALANCE_PUSH) {
+		balance_push(rq);
+		return;
+	}
+
+	__balance_callbacks(rq);
+}
+
 #else
 
 static inline void __balance_callbacks(struct rq *rq)
@@ -3546,6 +3563,10 @@ static inline void balance_callbacks(str
 {
 }
 
+static inline void balance_switch(struct rq *rq)
+{
+}
+
 #endif
 
 static inline void
@@ -3573,7 +3594,7 @@ static inline void finish_lock_switch(st
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	balance_switch(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -6831,6 +6852,90 @@ static void migrate_tasks(struct rq *dea
 
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
+	update_rq_clock(rq);
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
+static void balance_push(struct rq *rq)
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
+		return;
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
+static inline void balance_push(struct rq *rq)
+{
+}
+
+static inline void balance_push_set(int cpu, bool on)
+{
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6916,6 +7021,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -6963,6 +7070,8 @@ int sched_cpu_deactivate(unsigned int cp
 	 */
 	synchronize_rcu();
 
+	balance_push_set(cpu, true);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -6976,6 +7085,7 @@ int sched_cpu_deactivate(unsigned int cp
 
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
@@ -1385,6 +1386,9 @@ init_numa_balancing(unsigned long clone_
 
 #ifdef CONFIG_SMP
 
+#define BALANCE_WORK	0x01
+#define BALANCE_PUSH	0x02
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1392,12 +1396,13 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next))
+	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \


