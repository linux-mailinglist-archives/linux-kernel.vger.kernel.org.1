Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43F2779D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIXT7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:59:41 -0400
Received: from foss.arm.com ([217.140.110.172]:53964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIXT7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:59:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FF171045;
        Thu, 24 Sep 2020 12:59:40 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3716D3F73B;
        Thu, 24 Sep 2020 12:59:38 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <20200921163845.830487105@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 8/9] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <20200921163845.830487105@infradead.org>
Date:   Thu, 24 Sep 2020 20:59:33 +0100
Message-ID: <jhj3637lzdm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/09/20 17:36, Peter Zijlstra wrote:
> +struct set_affinity_pending {
> +	refcount_t		refs;
> +	struct completion	done;
> +	struct cpu_stop_work	stop_work;
> +	struct migration_arg	arg;
> +};
> +
> +static int move_task(struct rq *rq, struct rq_flags *rf, struct task_struct *p,
> +		     int dest_cpu, unsigned int flags)
> +{
> +	struct set_affinity_pending my_pending, *pending = NULL;
> +	struct migration_arg arg = {
> +		.task = p,
> +		.dest_cpu = dest_cpu,
> +	};
> +
> +	if (!(flags & SCA_MIGRATE_ENABLE)) {
> +		/* serialized by p->pi_lock */
> +		if (!p->migration_pending) {
> +			refcount_set(&my_pending.refs, 1);
> +			init_completion(&my_pending.done);
> +			p->migration_pending = &my_pending;
> +		} else {
> +			pending = p->migration_pending;
> +			refcount_inc(&pending->refs);
> +		}
> +	}
> +	pending = p->migration_pending;
> +	/*
> +	 * - !MIGRATE_ENABLE:
> +	 *   we'll have installed a pending if there wasn't one already.
> +	 *
> +	 * - MIGRATE_ENABLE:
> +	 *   we're here because the current CPU isn't matching anymore,
> +	 *   the only way that can happen is because of a concurrent
> +	 *   set_cpus_allowed_ptr() call, which should then still be
> +	 *   pending completion.
> +	 *
> +	 * Either way, we really should have a @pending here.
> +	 */
> +	if (WARN_ON_ONCE(!pending))
> +		return -EINVAL;
> +
> +	arg.done = &pending->done;
> +
> +	if (flags & SCA_MIGRATE_ENABLE) {
> +
> +		task_rq_unlock(rq, p, rf);
> +		pending->arg = arg;
> +		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> +				    &pending->arg, &pending->stop_work);
> +
> +		return 0;
> +	}
> +
> +	if (task_running(rq, p) || p->state == TASK_WAKING) {
> +
> +		task_rq_unlock(rq, p, rf);
> +		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> +

Shouldn't we check for is_migrate_disabled(p) before doing any of that?
migration_cpu_stop() does check for it, is there something that prevents us
from acting on it earlier than that?

> +	} else {
> +		bool complete = false;
> +
> +		if (!is_migration_disabled(p)) {
> +			if (task_on_rq_queued(p))
> +				rq = move_queued_task(rq, rf, p, dest_cpu);
> +
> +			p->migration_pending = NULL;
> +			complete = true;
> +		}
> +		task_rq_unlock(rq, p, rf);
> +
> +		if (complete)
> +			complete_all(&pending->done);
> +	}
> +
> +	wait_for_completion(&pending->done);
> +
> +	if (refcount_dec_and_test(&pending->refs))
> +		wake_up_var(&pending->refs);
> +
> +	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
> +
> +	return 0;
> +}
> +
>  /*
>   * Change a given task's CPU affinity. Migrate the thread to a
>   * proper CPU and schedule it away if the CPU it's executing on
> @@ -2025,19 +2138,8 @@ static int __set_cpus_allowed_ptr(struct
>       if (cpumask_test_cpu(task_cpu(p), new_mask))
>               goto out;

I think this needs a cancellation of any potential pending migration
requests. Consider a task P0 running on CPU0:

   P0                     P1                               P2

   migrate_disable();
   <preempt>
                          set_cpus_allowed_ptr(P0, CPU1);
                          // waits for completion
                                                           set_cpus_allowed_ptr(P0, CPU0);
                                                           // Already good, no waiting for completion
   <resumes>
   migrate_enable();
   // task_cpu(p) allowed, no move_task()

AIUI in this scenario P1 would stay forever waiting. I *think* this can be
cured by making this function slightly more hideous:

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 01113e6f941f..829334f00f7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2102,6 +2102,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
                                  u32 flags)
 {
        const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	struct set_affinity_pending *pending;
+	bool cancel_pending = false;
        unsigned int dest_cpu;
        struct rq_flags rf;
        struct rq *rq;
@@ -2158,14 +2160,20 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
        }

        /* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask))
+	if (cpumask_test_cpu(task_cpu(p), new_mask)) {
+		cancel_pending = true;
                goto out;
+	}

        return move_task(rq, &rf, p, dest_cpu, flags);

 out:
+	pending = p->migration_pending;
        task_rq_unlock(rq, p, &rf);

+	if (cancel_pending && pending)
+		complete_all(&pending->done);
+
        return ret;
 }

---

>
> -	if (task_running(rq, p) || p->state == TASK_WAKING) {
> -		struct migration_arg arg = { p, dest_cpu };
> -		/* Need help from migration thread: drop lock and wait. */
> -		task_rq_unlock(rq, p, &rf);
> -		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> -		return 0;
> -	} else if (task_on_rq_queued(p)) {
> -		/*
> -		 * OK, since we're going to drop the lock immediately
> -		 * afterwards anyway.
> -		 */
> -		rq = move_queued_task(rq, &rf, p, dest_cpu);
> -	}
> +	return move_task(rq, &rf, p, dest_cpu, flags);
> +
>  out:
>       task_rq_unlock(rq, p, &rf);
>
