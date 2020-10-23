Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C706D296CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462300AbgJWKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462248AbgJWKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97471C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vnSQHp+fXBX+qvN3Gm+2iUBSiaDKalpCY7XXz8QLghU=; b=Wf3RWhDjNFyI+xkS+A9IVxMeyY
        oR+gQxWIDNb7X/1uFkxdRQtHN0SORvhjo+ZF/obin7pvOUg0mTDWPDXbL5DFVUgHAi/VzHTC/0eP4
        RH0B8Nk8wPfREh8KoflrL7XWKD4E5m4yN1xF/7N2a2nJRdZXeDJC9UhZGaG/56pw+AIIR5k1b0DKg
        C6yWrLFrx6tbtmbJM5OgnlsKKJQmYZRXAxq8F+vu/6mEDaJhSFAFVBhYAEkmaHU9bz8hstDmMl3Cw
        XznoxoIFdThNTC6NwQDd5/iqLgt/ksb8EOC2mMrrx+HDloSxyV+4+dn6FwlqzlOEMnAI/OMLFJpgZ
        yORxsVBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFn-0002t3-C8; Fri, 23 Oct 2020 10:25:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D12B93075F1;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4D13C29DDA65D; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102346.547163969@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 06/19] sched/hotplug: Consolidate task migration on CPU unplug
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

With the new mechanism which kicks tasks off the outgoing CPU at the end of
schedule() the situation on an outgoing CPU right before the stopper thread
brings it down completely is:

 - All user tasks and all unbound kernel threads have either been migrated
   away or are not running and the next wakeup will move them to a online CPU.

 - All per CPU kernel threads, except cpu hotplug thread and the stopper
   thread have either been unbound or parked by the responsible CPU hotplug
   callback.

That means that at the last step before the stopper thread is invoked the
cpu hotplug thread is the last legitimate running task on the outgoing
CPU.

Add a final wait step right before the stopper thread is kicked which
ensures that any still running tasks on the way to park or on the way to
kick themself of the CPU are either sleeping or gone.

This allows to remove the migrate_tasks() crutch in sched_cpu_dying(). If
sched_cpu_dying() detects that there is still another running task aside of
the stopper thread then it will explode with the appropriate fireworks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpuhotplug.h    |    1 
 include/linux/sched/hotplug.h |    2 
 kernel/cpu.c                  |    9 ++
 kernel/sched/core.c           |  154 +++++++++---------------------------------
 4 files changed, 46 insertions(+), 120 deletions(-)

--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -151,6 +151,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
+	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
--- a/include/linux/sched/hotplug.h
+++ b/include/linux/sched/hotplug.h
@@ -11,8 +11,10 @@ extern int sched_cpu_activate(unsigned i
 extern int sched_cpu_deactivate(unsigned int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
+extern int sched_cpu_wait_empty(unsigned int cpu);
 extern int sched_cpu_dying(unsigned int cpu);
 #else
+# define sched_cpu_wait_empty	NULL
 # define sched_cpu_dying	NULL
 #endif
 
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1602,7 +1602,7 @@ static struct cpuhp_step cpuhp_hp_states
 		.name			= "ap:online",
 	},
 	/*
-	 * Handled on controll processor until the plugged processor manages
+	 * Handled on control processor until the plugged processor manages
 	 * this itself.
 	 */
 	[CPUHP_TEARDOWN_CPU] = {
@@ -1611,6 +1611,13 @@ static struct cpuhp_step cpuhp_hp_states
 		.teardown.single	= takedown_cpu,
 		.cant_stop		= true,
 	},
+
+	[CPUHP_AP_SCHED_WAIT_EMPTY] = {
+		.name			= "sched:waitempty",
+		.startup.single		= NULL,
+		.teardown.single	= sched_cpu_wait_empty,
+	},
+
 	/* Handle smpboot threads park/unpark */
 	[CPUHP_AP_SMPBOOT_THREADS] = {
 		.name			= "smpboot/threads:online",
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6759,120 +6759,6 @@ void idle_task_exit(void)
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-/*
- * Since this CPU is going 'away' for a while, fold any nr_active delta
- * we might have. Assumes we're called after migrate_tasks() so that the
- * nr_active count is stable. We need to take the teardown thread which
- * is calling this into account, so we hand in adjust = 1 to the load
- * calculation.
- *
- * Also see the comment "Global load-average calculations".
- */
-static void calc_load_migrate(struct rq *rq)
-{
-	long delta = calc_load_fold_active(rq, 1);
-	if (delta)
-		atomic_long_add(delta, &calc_load_tasks);
-}
-
-static struct task_struct *__pick_migrate_task(struct rq *rq)
-{
-	const struct sched_class *class;
-	struct task_struct *next;
-
-	for_each_class(class) {
-		next = class->pick_next_task(rq);
-		if (next) {
-			next->sched_class->put_prev_task(rq, next);
-			return next;
-		}
-	}
-
-	/* The idle class should always have a runnable task */
-	BUG();
-}
-
-/*
- * Migrate all tasks from the rq, sleeping tasks will be migrated by
- * try_to_wake_up()->select_task_rq().
- *
- * Called with rq->lock held even though we'er in stop_machine() and
- * there's no concurrency possible, we hold the required locks anyway
- * because of lock validation efforts.
- */
-static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
-{
-	struct rq *rq = dead_rq;
-	struct task_struct *next, *stop = rq->stop;
-	struct rq_flags orf = *rf;
-	int dest_cpu;
-
-	/*
-	 * Fudge the rq selection such that the below task selection loop
-	 * doesn't get stuck on the currently eligible stop task.
-	 *
-	 * We're currently inside stop_machine() and the rq is either stuck
-	 * in the stop_machine_cpu_stop() loop, or we're executing this code,
-	 * either way we should never end up calling schedule() until we're
-	 * done here.
-	 */
-	rq->stop = NULL;
-
-	/*
-	 * put_prev_task() and pick_next_task() sched
-	 * class method both need to have an up-to-date
-	 * value of rq->clock[_task]
-	 */
-	update_rq_clock(rq);
-
-	for (;;) {
-		/*
-		 * There's this thread running, bail when that's the only
-		 * remaining thread:
-		 */
-		if (rq->nr_running == 1)
-			break;
-
-		next = __pick_migrate_task(rq);
-
-		/*
-		 * Rules for changing task_struct::cpus_mask are holding
-		 * both pi_lock and rq->lock, such that holding either
-		 * stabilizes the mask.
-		 *
-		 * Drop rq->lock is not quite as disastrous as it usually is
-		 * because !cpu_active at this point, which means load-balance
-		 * will not interfere. Also, stop-machine.
-		 */
-		rq_unlock(rq, rf);
-		raw_spin_lock(&next->pi_lock);
-		rq_relock(rq, rf);
-
-		/*
-		 * Since we're inside stop-machine, _nothing_ should have
-		 * changed the task, WARN if weird stuff happened, because in
-		 * that case the above rq->lock drop is a fail too.
-		 */
-		if (WARN_ON(task_rq(next) != rq || !task_on_rq_queued(next))) {
-			raw_spin_unlock(&next->pi_lock);
-			continue;
-		}
-
-		/* Find suitable destination for @next, with force if needed. */
-		dest_cpu = select_fallback_rq(dead_rq->cpu, next);
-		rq = __migrate_task(rq, rf, next, dest_cpu);
-		if (rq != dead_rq) {
-			rq_unlock(rq, rf);
-			rq = dead_rq;
-			*rf = orf;
-			rq_relock(rq, rf);
-		}
-		raw_spin_unlock(&next->pi_lock);
-	}
-
-	rq->stop = stop;
-}
-
 static int __balance_push_cpu_stop(void *arg)
 {
 	struct task_struct *p = arg;
@@ -7128,10 +7014,6 @@ int sched_cpu_deactivate(unsigned int cp
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
-
-	/* Wait for all non per CPU kernel threads to vanish. */
-	balance_hotplug_wait();
-
 	return 0;
 }
 
@@ -7151,6 +7033,41 @@ int sched_cpu_starting(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+
+/*
+ * Invoked immediately before the stopper thread is invoked to bring the
+ * CPU down completely. At this point all per CPU kthreads except the
+ * hotplug thread (current) and the stopper thread (inactive) have been
+ * either parked or have been unbound from the outgoing CPU. Ensure that
+ * any of those which might be on the way out are gone.
+ *
+ * If after this point a bound task is being woken on this CPU then the
+ * responsible hotplug callback has failed to do it's job.
+ * sched_cpu_dying() will catch it with the appropriate fireworks.
+ */
+int sched_cpu_wait_empty(unsigned int cpu)
+{
+	balance_hotplug_wait();
+	return 0;
+}
+
+/*
+ * Since this CPU is going 'away' for a while, fold any nr_active delta we
+ * might have. Called from the CPU stopper task after ensuring that the
+ * stopper is the last running task on the CPU, so nr_active count is
+ * stable. We need to take the teardown thread which is calling this into
+ * account, so we hand in adjust = 1 to the load calculation.
+ *
+ * Also see the comment "Global load-average calculations".
+ */
+static void calc_load_migrate(struct rq *rq)
+{
+	long delta = calc_load_fold_active(rq, 1);
+
+	if (delta)
+		atomic_long_add(delta, &calc_load_tasks);
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7164,7 +7081,6 @@ int sched_cpu_dying(unsigned int cpu)
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
-	migrate_tasks(rq, &rf);
 	BUG_ON(rq->nr_running != 1);
 	rq_unlock_irqrestore(rq, &rf);
 


