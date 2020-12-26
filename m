Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6922E2E48
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLZNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 08:55:37 -0500
Received: from foss.arm.com ([217.140.110.172]:45670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgLZNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 08:55:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56810101E;
        Sat, 26 Dec 2020 05:54:50 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED1C3F6CF;
        Sat, 26 Dec 2020 05:54:48 -0800 (PST)
Date:   Sat, 26 Dec 2020 13:54:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 15/19] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201226135445.gkxfn5lmbxhblnj4@e107158-lin>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.499155098@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023102347.499155098@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

Apologies for the late comments on the patch.

On 10/23/20 12:12, Peter Zijlstra wrote:

[...]

> + * When a preempted task becomes elegible to run under the ideal model (IOW it
> + * becomes one of the M highest priority tasks), it might still have to wait
> + * for the preemptee's migrate_disable() section to complete. Thereby suffering
> + * a reduction in bandwidth in the exact duration of the migrate_disable()
> + * section.
> + *
> + * Per this argument, the change from preempt_disable() to migrate_disable()
> + * gets us:
> + *
> + * - a higher priority tasks gains reduced wake-up latency; with preempt_disable()
> + *   it would have had to wait for the lower priority task.
> + *
> + * - a lower priority tasks; which under preempt_disable() could've instantly
> + *   migrated away when another CPU becomes available, is now constrained
> + *   by the ability to push the higher priority task away, which might itself be
> + *   in a migrate_disable() section, reducing it's available bandwidth.
> + *
> + * IOW it trades latency / moves the interference term, but it stays in the
> + * system, and as long as it remains unbounded, the system is not fully
> + * deterministic.

The idea makes sense but I'm worried about some implementation details.

Specifically:

	* There's no guarantee the target CPU we're pushing to doesn't have
	  a lower priority task in migration_disabled too. So we could end up
	  having to push the task again. Although unlikely in practice, but as
	  I see it the worst case scenario is unbounded here. The planets could
	  align perfectly for the higher priority task to spend the majority of
	  its time migrating between cpus that have low priority RT tasks in
	  migration_disabled regions.

	  We need to track migration disabled at rq level to fix this.
	  It might be necessary to track the priority levels that are in
	  migration_disabled too :-/

	* Since this is a voluntary migration, I think we should ensure it is
	  restricted to cpus_share_cache() to guarantee the price is minimal
	  and acceptable.

	* The push is done via the stopper task; which will steal run time
	  and could contribute to worst case latency. I think it'd fine in
	  practice, but PREEMPT_RT folks will know better.

I think the combined effect of above could end up throwing off RT system
designers who could find their high-priority-hard-RT task is missing its
deadline to be nice to lower priority tasks who go often to migration_disabled
regions.

I seem to remember Clark saying in last LPC that few us latency is not unheard
of now.

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

The task_rq(p) could have left the migration_disabled region by now too. If we
track that at rq level we could be able to do last minute check to bale out of
this voluntary push.

I think we should check that the lowest_rq is not in migration_disabled region
too otherwise the same task could end up here again.

Need to think more about it, but we might be able to get away with verifying
task_rq(p)->curr and lowest_rq->curr aren't in migration disabled. The only
worry I can think of now is that rq->curr is a similar task to this one. That
is: a higher priority task that has preempted a migration_disabled region.

Verifying that task_cpu(p) and lowest_rq->cpu are in the same llc will help
avoid a costly migration. After all this is a voluntary migration.

Once we do all these bale outs; we might need to rate limit another PULL
triggering this continuously. Need to dig more into that.

> +	if (task_rq(p) == rq) {
> +		deactivate_task(rq, p, 0);
> +		set_task_cpu(p, lowest_rq->cpu);
> +		activate_task(lowest_rq, p, 0);
> +		resched_curr(lowest_rq);
> +	}
> +
> +	double_unlock_balance(rq, lowest_rq);
> +
> +out_unlock:
> +	rq->push_busy = false;
> +	raw_spin_unlock(&rq->lock);
> +	raw_spin_unlock_irq(&p->pi_lock);
> +
> +	put_task_struct(p);
> +	return 0;
> +}

[...]

> +static inline struct task_struct *get_push_task(struct rq *rq)
> +{
> +	struct task_struct *p = rq->curr;

Shouldn't we verify the class of the task here? The RT task in migration
disabled could have been preempted by a dl or stopper task. Similarly, the dl
task could have been preempted by a stopper task.

I don't think an RT task should be allowed to push a dl task under any
circumstances?

Cheers

--
Qais Yousef

> +
> +	lockdep_assert_held(&rq->lock);
> +
> +	if (rq->push_busy)
> +		return NULL;
> +
> +	if (p->nr_cpus_allowed == 1)
> +		return NULL;
> +
> +	rq->push_busy = true;
> +	return get_task_struct(p);
> +}
> +
> +extern int push_cpu_stop(void *arg);
> +
>  #endif
>  
>  #ifdef CONFIG_CPU_IDLE
> 
> 
