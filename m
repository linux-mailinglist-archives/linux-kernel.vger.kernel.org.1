Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3601291818
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgJRPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:51:19 -0400
Received: from foss.arm.com ([217.140.110.172]:37842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgJRPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:51:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DB7A30E;
        Sun, 18 Oct 2020 08:51:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 416B93F66B;
        Sun, 18 Oct 2020 08:51:15 -0700 (PDT)
References: <20201015110532.738127234@infradead.org> <20201015110923.910090294@infradead.org> <jhjlfg6qqum.mognet@arm.com> <BN8PR12MB29784D239007D0D6CA3F4F2A9A010@BN8PR12MB2978.namprd12.prod.outlook.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     ouwen210@hotmail.com
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH v3 10/19] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <BN8PR12MB29784D239007D0D6CA3F4F2A9A010@BN8PR12MB2978.namprd12.prod.outlook.com>
Date:   Sun, 18 Oct 2020 16:51:10 +0100
Message-ID: <jhjimb7r0r5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 18/10/20 10:46, ouwen wrote:
> On Fri, Oct 16, 2020 at 01:48:17PM +0100, Valentin Schneider wrote:
>> ---
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a5b6eac07adb..1ebf653c2c2f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1859,6 +1859,13 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>>  	return rq;
>>  }
>>  
>> +struct set_affinity_pending {
>> +	refcount_t		refs;
>> +	struct completion	done;
>> +	struct cpu_stop_work	stop_work;
>> +	struct migration_arg	arg;
>> +};
>> +
>>  /*
>>   * migration_cpu_stop - this will be executed by a highprio stopper thread
>>   * and performs thread migration by bumping thread off CPU then
>> @@ -1866,6 +1873,7 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>>   */
>>  static int migration_cpu_stop(void *data)
>>  {
>> +	struct set_affinity_pending *pending;
>>  	struct migration_arg *arg = data;
>>  	struct task_struct *p = arg->task;
>>  	struct rq *rq = this_rq();
>> @@ -1886,13 +1894,22 @@ static int migration_cpu_stop(void *data)
>>  
>>  	raw_spin_lock(&p->pi_lock);
>>  	rq_lock(rq, &rf);
>> +
>> +	if (arg->done)
>
> If I'm not wrong(always likely), arg->done is point to the installed
> pending's done of the first task that calling sca. It should not be
> NULL because it is a pointer to the stack address not related to the
> content in the stack.
>

Correct; here I'm using it as an indicator of whether migration_cpu_stop()
was invoked by SCA with a pending affinity request. I'll admit it's icky,
I'd prefer having an explicit flag to check against.

>> +		pending = container_of(arg->done, struct set_affinity_pending, done);
>>  	/*
>>  	 * If task_rq(p) != rq, it cannot be migrated here, because we're
>>  	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
>>  	 * we're holding p->pi_lock.
>>  	 */
>>  	if (task_rq(p) == rq) {
>> -		if (is_migration_disabled(p))
>> +		/*
>> +		 * An affinity update may have raced with us.
>> +		 * p->migration_pending could now be NULL, or could be pointing
>> +		 * elsewhere entirely.
>> +		 */
>> +		if (is_migration_disabled(p) ||
>> +		    (arg->done && p->migration_pending != pending))
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> p->migration_pending can be set on the random task's stack but the
> address is possible to be the same with the previous pending. It's
> very very unlikely. But I'm also totally failed.
>

Do you mean if we encounter the above race, but on top of that a new
pending gets installed that has the *same* address as the previous one?

That would mean that the task which installed that first pending got out of
affine_move_task() and *back into it*, with the same stack depth, before the
stopper got to run & grab the task_rq_lock. I also thought about this, but
am unsure how far to push the paranoia.


Side thought: don't we need to NULL p->migration_pending in __sched_fork()?

> I can't realize anything that time, but now I just give this noise.
> Use refcount_add/dec on MIGRATE_ENABLE path to prevent that not sure
> yet.
>

One annoying thing is that in that path we can't wait on the refcount
reaching 0, since migrate_{disable, enable}() disable preemption.
(the stopper is only schedule()'d upon reenabling preemption in
migrate_enable()).

Including the stopper callback in the refcount chain would probably reduce
future headaches, but it's not as straightforward.


>>  			goto out;
>>  
>>  		if (task_on_rq_queued(p))
>> @@ -2024,13 +2041,6 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>>  	__do_set_cpus_allowed(p, new_mask, 0);
>>  }
>>  
>> -struct set_affinity_pending {
>> -	refcount_t		refs;
>> -	struct completion	done;
>> -	struct cpu_stop_work	stop_work;
>> -	struct migration_arg	arg;
>> -};
>> -
>>  /*
>>   * This function is wildly self concurrent; here be dragons.
>>   *

