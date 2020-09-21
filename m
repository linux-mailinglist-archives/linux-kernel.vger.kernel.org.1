Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263C0272D58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgIUQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgIUQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:39:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16123C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OogKNOxaDqcIf/ddsKSLqJz/x8ay6irwP1mJLumHRQg=; b=FwWpw/XfEqBGv4SgrgPQQW+Oox
        rEmRIh0L0CkHkQBbPsreubrDEIUP7RoZokIiB2KsK4cAp97I8zY+SR1Wa9yFgRfjtkurxeQ15t5MU
        /kFGFf0ufnudrpBFMOlAB80TS+fE7nwgmV66CheOt3ma38KEc6C3KS4IKdNYm+dhnfUhhfDOuq9S8
        2ssQoTXspGZ35pYYHmvUhj+ZKmB0j7T4dE+WlUttVjrgPAN7DacoLZ6UKWWLwxKq+g8sWsRBvzeyM
        dk1cISYL5UUskRppPMHKhDFxFq4c8MFqDSGUJV0TtpEdRJkSaoONZVK6/nXUr3bo9o+sYN4p7FkzP
        u8j4x15Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKOqE-00025x-U3; Mon, 21 Sep 2020 16:39:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25598307A61;
        Mon, 21 Sep 2020 18:39:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC04B201DA66E; Mon, 21 Sep 2020 18:38:59 +0200 (CEST)
Message-ID: <20200921163845.897527418@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 18:36:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: [PATCH 9/9] sched/core: Make migrate disable and CPU hotplug cooperative
References: <20200921163557.234036895@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On CPU unplug tasks which are in a migrate disabled region cannot be pushed
to a different CPU until they returned to migrateable state.

Account the number of tasks on a runqueue which are in a migrate disabled
section and make the hotplug wait mechanism respect that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   36 ++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |    4 ++++
 2 files changed, 34 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1725,10 +1725,17 @@ static void migrate_disable_switch(struc
 
 void migrate_disable(void)
 {
-	if (current->migration_disabled++)
+	struct task_struct *p = current;
+
+	if (p->migration_disabled) {
+		p->migration_disabled++;
 		return;
+	}
 
-	barrier();
+	preempt_disable();
+	this_rq()->nr_pinned++;
+	p->migration_disabled = 1;
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -1755,6 +1762,7 @@ void migrate_enable(void)
 	 */
 	barrier();
 	p->migration_disabled = 0;
+	this_rq()->nr_pinned--;
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
@@ -1764,6 +1772,11 @@ static inline bool is_migration_disabled
 	return p->migration_disabled;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return rq->nr_pinned;
+}
+
 #else
 
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
@@ -1773,6 +1786,11 @@ static inline bool is_migration_disabled
 	return false;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return false;
+}
+
 #endif
 
 /*
@@ -2809,7 +2827,8 @@ static void balance_hotplug_wait(void)
 {
 	struct rq *rq = this_rq();
 
-	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+	rcuwait_wait_event(&rq->hotplug_wait,
+			   rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
 			   TASK_UNINTERRUPTIBLE);
 }
 
@@ -7009,15 +7028,20 @@ static bool balance_push(struct rq *rq)
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task)) {
+	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
 		 * last task to vanish. The rcuwait_active() check is
 		 * accurate here because the waiter is pinned on this CPU
 		 * and can't obviously be running in parallel.
+		 *
+		 * On RT kernels this also has to check whether there are
+		 * pinned and scheduled out tasks on the runqueue. They
+		 * need to leave the migrate disabled section first.
 		 */
-		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
+		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
+		    rcuwait_active(&rq->hotplug_wait)) {
 			raw_spin_unlock(&rq->lock);
 			rcuwait_wake_up(&rq->hotplug_wait);
 			raw_spin_lock(&rq->lock);
@@ -7290,7 +7314,7 @@ int sched_cpu_dying(unsigned int cpu)
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
-	BUG_ON(rq->nr_running != 1);
+	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1053,6 +1053,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+	unsigned int		nr_pinned;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED


