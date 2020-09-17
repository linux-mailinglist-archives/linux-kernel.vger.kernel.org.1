Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4EB26D994
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIQKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgIQKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B6C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:56 -0700 (PDT)
Message-Id: <20200917101624.907536563@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OrB01BH6Q64hZGxuj6QnQFXBl/a0jOJLmVQxnZHsfwI=;
        b=ipoDYSQbXvA4n0ePEn93fD2XL2Vnjl6zKNz3pFlr7idGoahV7c10icF1+dWby5wD3bpLdC
        ZPLuAuiLEGpdEK2k0UfZjrFC3+tWM2wNolQbfgu/Ix1sMqoHBpIsKndzpXbjEEI2Oklhkh
        8eAXgt92se9i+jTtELU0Owp2DQDaremdXZptF7Levice541Jxn3dDaCEgGYEAgGuM/EV38
        Z5v9fVkl085zeWAYw7GDUaTzIprmi9Ch1lc7N5VLrz2eNh5Di00AVsxhSLpPEz99Xmi87q
        iWzjgtBEa2L9YlWBUDrgV6woOhkXKO/uFgXXX1TGvmUVHs8sa2GvKqUxJAJ6RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OrB01BH6Q64hZGxuj6QnQFXBl/a0jOJLmVQxnZHsfwI=;
        b=kO4Car/Z8zNieAmc6WRqgFOYWzOvMNXKI2lfXcYJe0mNHzVL2e0iuodYi+VpRxp+J6FZxP
        zievY96g2DvbhkBg==
Date:   Thu, 17 Sep 2020 11:42:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [patch 10/10] sched/core: Make migrate disable and CPU hotplug cooperative
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPU unplug tasks which are in a migrate disabled region cannot be pushed
to a different CPU until they returned to migrateable state.

Account the number of tasks on a runqueue which are in a migrate disabled
section and make the hotplug wait mechanism respect that.

Originally-by: Scott Wood <swood@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c  |   38 ++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |    4 ++++
 2 files changed, 38 insertions(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -494,6 +494,11 @@ static bool task_self_migration(struct t
 	return true;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return rq->nr_pinned > 0;
+}
+
 #else /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT) */
 static inline void task_lock_migration_ctrl(struct task_struct *p) { }
 static inline void task_unlock_migration_ctrl(struct task_struct *p) { }
@@ -504,6 +509,10 @@ static bool task_self_migration(struct t
 {
 	return false;
 }
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return false;
+}
 #endif /* !(defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)) */
 
 /*
@@ -3591,6 +3600,12 @@ void migrate_disable(void)
 	if (!current->migration_ctrl.disable_cnt) {
 		raw_spin_lock_irqsave(&current->pi_lock, flags);
 		current->migration_ctrl.disable_cnt++;
+		/*
+		 * Account the pinned task in the runqueue so that an
+		 * eventual CPU hot unplug operation will wait until
+		 * this task left the migrate disabled section.
+		 */
+		this_rq()->nr_pinned++;
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 	} else {
 		current->migration_ctrl.disable_cnt++;
@@ -3619,6 +3634,13 @@ void migrate_enable(void)
 	p->migration_ctrl.pending = NULL;
 
 	/*
+	 * Adjust the number of pinned tasks in the runqueue. No further
+	 * action required here. An eventually waiting CPU hot unplug
+	 * operation will be woken up once the CPU goes through idle.
+	 */
+	this_rq()->nr_pinned--;
+
+	/*
 	 * If the task was never scheduled out while in the migrate
 	 * disabled region and there is no migration request pending,
 	 * return.
@@ -6989,8 +7011,13 @@ static bool balance_push(struct rq *rq)
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
@@ -7033,13 +7060,16 @@ static void balance_push_set(int cpu, bo
  * Invoked from a CPUs hotplug control thread after the CPU has been marked
  * inactive. All tasks which are not per CPU kernel threads are either
  * pushed off this CPU now via balance_push() or placed on a different CPU
- * during wakeup. Wait until the CPU is quiescent.
+ * during wakeup. Wait until the CPU is quiescent.  On RT kernels this also
+ * waits for pinned non-runnable tasks to leave the migrate disabled
+ * section.
  */
 static void balance_hotplug_wait(void)
 {
 	struct rq *rq = this_rq();
 
-	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+	rcuwait_wait_event(&rq->hotplug_wait,
+			   rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
 			   TASK_UNINTERRUPTIBLE);
 }
 
@@ -7279,7 +7309,7 @@ int sched_cpu_dying(unsigned int cpu)
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

