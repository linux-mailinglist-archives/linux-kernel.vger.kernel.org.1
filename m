Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEE286832
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgJGTYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:24:18 -0400
Received: from foss.arm.com ([217.140.110.172]:49222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgJGTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:24:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98E9D6E;
        Wed,  7 Oct 2020 12:24:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB0FA3F70D;
        Wed,  7 Oct 2020 12:24:15 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150922.458081448@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
In-reply-to: <20201005150922.458081448@infradead.org>
Date:   Wed, 07 Oct 2020 20:22:44 +0100
Message-ID: <jhjpn5tn8mz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/20 15:57, Peter Zijlstra wrote:
> In order to minimize the interference of migrate_disable() on lower
> priority tasks, which can be deprived of runtime due to being stuck
> below a higher priority task. Teach the RT/DL balancers to push away
> these higher priority tasks when a lower priority task gets selected
> to run on a freshly demoted CPU (pull).
>
> This adds migration interference to the higher priority task, but
> restores bandwidth to system that would otherwise be irrevocably lost.
> Without this it would be possible to have all tasks on the system
> stuck on a single CPU, each task preempted in a migrate_disable()
> section with a single high priority task running.
>
> This way we can still approximate running the M highest priority tasks
> on the system.
>
> Migrating the top task away is (ofcourse) still subject to
> migrate_disable() too, which means the lower task is subject to an
> interference equivalent to the worst case migrate_disable() section.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[...]
> @@ -1917,6 +1912,49 @@ static int migration_cpu_stop(void *data
>       return 0;
>  }
>
> +int push_cpu_stop(void *arg)
> +{
> +	struct rq *lowest_rq = NULL, *rq = this_rq();
> +	struct task_struct *p = arg;
> +
> +	raw_spin_lock_irq(&p->pi_lock);
> +	raw_spin_lock(&rq->lock);
> +
> +	if (task_rq(p) != rq)
> +		goto out_unlock;
> +
> +	if (is_migration_disabled(p)) {
> +		p->migration_flags |= MDF_PUSH;
> +		goto out_unlock;
> +	}
> +
> +	p->migration_flags &= ~MDF_PUSH;
> +
> +	if (p->sched_class->find_lock_rq)
> +		lowest_rq = p->sched_class->find_lock_rq(p, rq);
> +
> +	if (!lowest_rq)
> +		goto out_unlock;
> +
> +	// XXX validate p is still the highest prio task

So we want to move some !migrate_disable(), highest priority task to make
room for a migrate_disable(), lower priority task. We're working with the
task that was highest prio at the time of kicking the CPU stopper
(i.e. back when we invoked get_push_task()), but as you point out here it
might no longer be of highest prio.

I was thinking that since this is done in stopper context we could peek at
what actually is the current (!stopper) highest prio task, but that implies
first grabbing the rq lock and *then* some p->pi_lock, which is a no-no :(

Regarding the check, I've cobbled the below. I'm not fond of the implicit
expectation that p will always be > CFS, but there's no CFS .find_lock_rq()
(... for now).

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 69b1173eaf45..3ed339980f87 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1919,6 +1919,7 @@ static int migration_cpu_stop(void *data)
 int push_cpu_stop(void *arg)
 {
        struct rq *lowest_rq = NULL, *rq = this_rq();
+	const struct sched_class *class;
        struct task_struct *p = arg;

        raw_spin_lock_irq(&p->pi_lock);
@@ -1940,14 +1941,23 @@ int push_cpu_stop(void *arg)
        if (!lowest_rq)
                goto out_unlock;

-	// XXX validate p is still the highest prio task
-	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
-		resched_curr(lowest_rq);
+	// Validate p is still the highest prio task
+	for_class_range(class, &stop_sched_class - 1, p->sched_class - 1) {
+		struct task_struct *curr = class->peek_next_task(rq);
+
+		if (!curr)
+			continue;
+		if (curr != p)
+			goto out_unlock;
+		else
+			break;
        }

+	deactivate_task(rq, p, 0);
+	set_task_cpu(p, lowest_rq->cpu);
+	activate_task(lowest_rq, p, 0);
+	resched_curr(lowest_rq);
+
        double_unlock_balance(rq, lowest_rq);

 out_unlock:
@@ -7312,7 +7322,7 @@ int sched_cpu_deactivate(unsigned int cpu)

        rq_lock_irqsave(rq, &rf);
        if (rq->rd) {
-		update_rq_clock();
+		update_rq_clock(rq);
                BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
                set_rq_offline(rq);
        }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 15320ede2f45..7964c42b8604 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1840,6 +1840,19 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
        return p;
 }

+static struct task_struct *peek_next_task_dl(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se;
+	struct dl_rq *dl_rq = &rq->dl;
+
+	if (!sched_dl_runnable(rq))
+		return NULL;
+
+	dl_se = pick_next_dl_entity(rq, dl_rq);
+	BUG_ON(!dl_se);
+	return dl_task_of(dl_se);
+}
+
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
        update_curr_dl(rq);
@@ -2498,6 +2511,8 @@ const struct sched_class dl_sched_class
        .check_preempt_curr	= check_preempt_curr_dl,

        .pick_next_task		= pick_next_task_dl,
+	.peek_next_task         = peek_next_task_dl,
+
        .put_prev_task		= put_prev_task_dl,
        .set_next_task		= set_next_task_dl,

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e90a69b3e85c..83949e9018a3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1636,6 +1636,14 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
        return p;
 }

+static struct task_struct *peek_next_task_rt(struct rq *rq)
+{
+	if (!sched_rt_runnable(rq))
+		return NULL;
+
+	return _pick_next_task_rt(rq);
+}
+
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
        update_curr_rt(rq);
@@ -2479,6 +2487,8 @@ const struct sched_class rt_sched_class
        .check_preempt_curr	= check_preempt_curr_rt,

        .pick_next_task		= pick_next_task_rt,
+	.peek_next_task         = peek_next_task_rt,
+
        .put_prev_task		= put_prev_task_rt,
        .set_next_task          = set_next_task_rt,

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2621155393c..7cd3b8682375 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1811,6 +1811,7 @@ struct sched_class {
        void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);

        struct task_struct *(*pick_next_task)(struct rq *rq);
+	struct task_struct *(*peek_next_task)(struct rq *rq);

        void (*put_prev_task)(struct rq *rq, struct task_struct *p);
        void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
