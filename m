Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398B3272D56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgIUQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgIUQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:39:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3381C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2z0lQgue6Fm5h/Y7YuL0IiC8MlEq2KdFyXIvL9aCOd8=; b=c+I3KUL20BSJEJJBulJl3oO8ul
        Uv2JF7ECScVfWBpCJTHBwk3aZoetuJfTHrbJjasUnWzgTR87sgAsI0Mz9GobJXFmu1trt1Y/HIGmm
        8LOo8olnsHJfSUh3vEqit3RFM60GLzJs7yN5BWuEe65n9WCM8tZ7mM0siWzFlazOszlpu2qZoJt0P
        J7TtNw9EQIKvtRYH9vC5OXmG14zI+DmQG20TFSJurwc5x2dD4B1tfME7STD3Tt56PRtDw7ImI8iEc
        FQjh1hp05wNUHB2c1lTd/gKgksMMWVZUB0wIh9TF3tHKK8lNpZm4ZJ2PFy9G+xpgeteCahM0D9dzu
        UNhfNX/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKOqE-00025w-ST; Mon, 21 Sep 2020 16:39:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2567B307A66;
        Mon, 21 Sep 2020 18:39:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B83C8201DA672; Mon, 21 Sep 2020 18:38:59 +0200 (CEST)
Message-ID: <20200921163845.830487105@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 18:36:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: [PATCH 8/9] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
References: <20200921163557.234036895@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concurrent migrate_disable() and set_cpus_allowed_ptr() has
interesting features. We rely on set_cpus_allowed_ptr() to not return
until the task runs inside the provided mask. This expectation is
exported to userspace.

This means that any set_cpus_allowed_ptr() caller must wait until
migrate_enable() allows migrations.

At the same time, we don't want migrate_enable() to schedule, due to
patterns like:

	preempt_disable();
	migrate_disable();
	...
	migrate_enable();
	preempt_enable();

And:

	raw_spin_lock(&B);
	spin_unlock(&A);

this means that when migrate_enable() must restore the affinity
mask, it cannot wait for completion thereof. Luck will have it that
that is exactly the case where there is a pending
set_cpus_allowed_ptr(), so let that provide storage for the async stop
machine.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 
 kernel/sched/core.c   |  142 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 123 insertions(+), 20 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -713,6 +713,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+	void				*migration_pending;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
 	int				migration_disabled;
 #endif
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1734,15 +1734,28 @@ EXPORT_SYMBOL_GPL(migrate_disable);
 
 void migrate_enable(void)
 {
-	if (--current->migration_disabled)
-		return;
-
-	barrier();
+	struct task_struct *p = current;
 
-	if (p->cpus_ptr == &p->cpus_mask)
+	if (p->migration_disabled > 1) {
+		p->migration_disabled--;
 		return;
+	}
 
-	__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+	/*
+	 * Ensure stop_task runs either before or after this, and that
+	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+	 */
+	preempt_disable();
+	if (p->cpus_ptr != &p->cpus_mask)
+		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
+	barrier();
+	p->migration_disabled = 0;
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
@@ -1818,6 +1831,7 @@ static struct rq *move_queued_task(struc
 struct migration_arg {
 	struct task_struct *task;
 	int dest_cpu;
+	struct completion *done;
 };
 
 /*
@@ -1852,6 +1866,7 @@ static int migration_cpu_stop(void *data
 	struct migration_arg *arg = data;
 	struct task_struct *p = arg->task;
 	struct rq *rq = this_rq();
+	bool complete = false;
 	struct rq_flags rf;
 
 	/*
@@ -1874,15 +1889,27 @@ static int migration_cpu_stop(void *data
 	 * we're holding p->pi_lock.
 	 */
 	if (task_rq(p) == rq) {
+		if (is_migration_disabled(p))
+			goto out;
+
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
 			p->wake_cpu = arg->dest_cpu;
+
+		if (arg->done) {
+			p->migration_pending = NULL;
+			complete = true;
+		}
 	}
+out:
 	rq_unlock(rq, &rf);
 	raw_spin_unlock(&p->pi_lock);
-
 	local_irq_enable();
+
+	if (complete)
+		complete_all(arg->done);
+
 	return 0;
 }
 
@@ -1957,6 +1984,92 @@ void do_set_cpus_allowed(struct task_str
 	__do_set_cpus_allowed(p, new_mask, 0);
 }
 
+struct set_affinity_pending {
+	refcount_t		refs;
+	struct completion	done;
+	struct cpu_stop_work	stop_work;
+	struct migration_arg	arg;
+};
+
+static int move_task(struct rq *rq, struct rq_flags *rf, struct task_struct *p,
+		     int dest_cpu, unsigned int flags)
+{
+	struct set_affinity_pending my_pending, *pending = NULL;
+	struct migration_arg arg = {
+		.task = p,
+		.dest_cpu = dest_cpu,
+	};
+
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		/* serialized by p->pi_lock */
+		if (!p->migration_pending) {
+			refcount_set(&my_pending.refs, 1);
+			init_completion(&my_pending.done);
+			p->migration_pending = &my_pending;
+		} else {
+			pending = p->migration_pending;
+			refcount_inc(&pending->refs);
+		}
+	}
+	pending = p->migration_pending;
+	/*
+	 * - !MIGRATE_ENABLE:
+	 *   we'll have installed a pending if there wasn't one already.
+	 *
+	 * - MIGRATE_ENABLE:
+	 *   we're here because the current CPU isn't matching anymore,
+	 *   the only way that can happen is because of a concurrent
+	 *   set_cpus_allowed_ptr() call, which should then still be
+	 *   pending completion.
+	 *
+	 * Either way, we really should have a @pending here.
+	 */
+	if (WARN_ON_ONCE(!pending))
+		return -EINVAL;
+
+	arg.done = &pending->done;
+
+	if (flags & SCA_MIGRATE_ENABLE) {
+
+		task_rq_unlock(rq, p, rf);
+		pending->arg = arg;
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+
+		return 0;
+	}
+
+	if (task_running(rq, p) || p->state == TASK_WAKING) {
+
+		task_rq_unlock(rq, p, rf);
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+	} else {
+		bool complete = false;
+
+		if (!is_migration_disabled(p)) {
+			if (task_on_rq_queued(p))
+				rq = move_queued_task(rq, rf, p, dest_cpu);
+
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+		if (complete)
+			complete_all(&pending->done);
+	}
+
+	wait_for_completion(&pending->done);
+
+	if (refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
+
+	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
+
+	return 0;
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -2025,19 +2138,8 @@ static int __set_cpus_allowed_ptr(struct
 	if (cpumask_test_cpu(task_cpu(p), new_mask))
 		goto out;
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
-		struct migration_arg arg = { p, dest_cpu };
-		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
-		return 0;
-	} else if (task_on_rq_queued(p)) {
-		/*
-		 * OK, since we're going to drop the lock immediately
-		 * afterwards anyway.
-		 */
-		rq = move_queued_task(rq, &rf, p, dest_cpu);
-	}
+	return move_task(rq, &rf, p, dest_cpu, flags);
+
 out:
 	task_rq_unlock(rq, p, &rf);
 


