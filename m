Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67A72784BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgIYKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:09:36 -0400
Received: from foss.arm.com ([217.140.110.172]:41034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgIYKJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:09:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEBC41045;
        Fri, 25 Sep 2020 03:09:35 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0280E3F718;
        Fri, 25 Sep 2020 03:09:33 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <20200921163845.830487105@infradead.org> <jhj3637lzdm.mognet@arm.com> <20200925090528.GV2628@hirez.programming.kicks-ass.net> <20200925095615.GA2651@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 8/9] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <20200925095615.GA2651@hirez.programming.kicks-ass.net>
Date:   Fri, 25 Sep 2020 11:09:31 +0100
Message-ID: <jhjzh5ekw10.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/09/20 10:56, Peter Zijlstra wrote:
> On Fri, Sep 25, 2020 at 11:05:28AM +0200, Peter Zijlstra wrote:
>> On Thu, Sep 24, 2020 at 08:59:33PM +0100, Valentin Schneider wrote:
>> > > @@ -2025,19 +2138,8 @@ static int __set_cpus_allowed_ptr(struct
>> > >       if (cpumask_test_cpu(task_cpu(p), new_mask))
>> > >               goto out;
>> >
>> > I think this needs a cancellation of any potential pending migration
>> > requests. Consider a task P0 running on CPU0:
>> >
>> >    P0                     P1                               P2
>> >
>> >    migrate_disable();
>> >    <preempt>
>> >                           set_cpus_allowed_ptr(P0, CPU1);
>> >                           // waits for completion
>> >                                                            set_cpus_allowed_ptr(P0, CPU0);
>> >                                                            // Already good, no waiting for completion
>> >    <resumes>
>> >    migrate_enable();
>> >    // task_cpu(p) allowed, no move_task()
>> >
>> > AIUI in this scenario P1 would stay forever waiting.
>>
>
>> The other approach is trying to handle that last condition in
>> move_task(), but I'm quite sure that's going to be aweful too :/
>
> Something like so perhaps?
>

That looks somewhat sane (not pretty, but we're past that :-)). I was
trying something similar in __set_cpus_allowed_ptr() itself, but this
condenses the completion / refcount logic in one place, so fewer
headaches.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2039,6 +2039,10 @@ static int move_task(struct rq *rq, stru
>       if (WARN_ON_ONCE(!pending))
>               return -EINVAL;
>
> +	/* Can the task run on the task's current CPU? If so, we're done */
> +	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
> +		goto easy;
> +
>       arg.done = &pending->done;
>
>       if (flags & SCA_MIGRATE_ENABLE) {
> @@ -2063,6 +2067,7 @@ static int move_task(struct rq *rq, stru
>                       if (task_on_rq_queued(p))
>                               rq = move_queued_task(rq, rf, p, dest_cpu);
>
> +easy:
>                       p->migration_pending = NULL;
>                       complete = true;
>               }
> @@ -2151,10 +2156,6 @@ static int __set_cpus_allowed_ptr(struct
>                       p->nr_cpus_allowed != 1);
>       }
>
> -	/* Can the task run on the task's current CPU? If so, we're done */
> -	if (cpumask_test_cpu(task_cpu(p), new_mask))
> -		goto out;
> -
>       return move_task(rq, &rf, p, dest_cpu, flags);
>
>  out:
