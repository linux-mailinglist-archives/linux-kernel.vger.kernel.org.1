Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778172A8295
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgKEPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:49:28 -0500
Received: from foss.arm.com ([217.140.110.172]:35986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgKEPt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:49:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B028B14BF;
        Thu,  5 Nov 2020 07:49:27 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240113F718;
        Thu,  5 Nov 2020 07:49:26 -0800 (PST)
References: <20201105075021.1302386-1-juri.lelli@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH] sched/deadline: Fix priority inheritance with multiple scheduling classes
In-reply-to: <20201105075021.1302386-1-juri.lelli@redhat.com>
Date:   Thu, 05 Nov 2020 15:49:19 +0000
Message-ID: <jhja6vvztvk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Juri,

On 05/11/20 07:50, Juri Lelli wrote:
> He also provided a simple reproducer creating the situation below:
>
>  So the execution order of locking steps are the following
>  (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
>  are mutexes that are enabled * with priority inheritance.)
>
>  Time moves forward as this timeline goes down:
>
>  N1              N2               D1
>  |               |                |
>  |               |                |
>  Lock(M1)        |                |
>  |               |                |
>  |             Lock(M2)           |
>  |               |                |
>  |               |              Lock(M2)
>  |               |                |
>  |             Lock(M1)           |
>  |             (!!bug triggered!) |
>
> Daniel reported a similar situation as well, by just letting ksoftirqd
> run with DEADLINE (and eventually block on a mutex).
>
> Problem is that boosted entities (Priority Inheritance) use static
> DEADLINE parameters of the top priority waiter. However, there might be
> cases where top waiter could be a non-DEADLINE entity that is currently
> boosted by a DEADLINE entity from a different lock chain (i.e., nested
> priority chains involving entities of non-DEADLINE classes). In this
> case, top waiter static DEADLINE parameters could be null (initialized
> to 0 at fork()) and replenish_dl_entity() would hit a BUG().
>

IIUC, rt_mutex_get_top_task(N1) == N2, and N2->dl->deadline = 0, which
makes enqueue_task_dl() unhappy. And that happens because, unlike p->prio,
DL parameters aren't properly propagated through the chain(s).

> Fix this by keeping track of the original donor and using its parameters
> when a task is boosted.
>
> Reported-by: Glenn Elliott <glenn@aurora.tech>
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>
> ---
>
> This is actually a v2 attempt (didn't keep $SUBJECT since it's quite
> different than v1 [1]) to fix this problem.
>
> v1 was admittedly pretty ugly. Hope this looks slightly better (even
> though there is of course overhead associated to the additional
> pointer).
>
> Again, the proper way to fix this is by proxy execution. But, I don't
> think we are yet there and this problem needs a quick band-aid.
>
> One could probably also think to complicate the present approach and
> actually perform accounting using donor's dynamic parameters, but I fear
> it would be of little benefit since it would still bring all the
> problems associated to affinities. So, I'd propose let's try to fix all
> this properly with proxy and just avoid crashes in the meantime.
>

For my own sake, what affinity problems are you thinking of?

With proxy exec we have this "funny" dance of shoving the entire blocked-on
chain on a single runqueue to get the right selection out of
pick_next_task(), and that needs to deal with affinity (i.e. move the task
back to a sensible rq once it becomes runnable).

With the current PI, the waiting tasks are blocked and enqueued in the
pi_waiters tree, so as I see it affinity shouldn't matter; what am I
missing / not seeing? Is that related to bandwidth handling?

> 1 - 20191112075056.19971-1-juri.lelli@redhat.com
> ---
>  include/linux/sched.h   |  9 +++++
>  kernel/sched/core.c     | 13 ++++++--
>  kernel/sched/deadline.c | 74 ++++++++++++++++++++---------------------
>  3 files changed, 56 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 063cd120b459..db29ab492181 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -571,6 +571,15 @@ struct sched_dl_entity {
>        * time.
>        */
>       struct hrtimer inactive_timer;
> +
> +#ifdef CONFIG_RT_MUTEXES
> +	/*
> +	 * Priority Inheritance. When a DEADLINE scheduling entity is boosted
> +	 * pi_se points to the donor, otherwise points to the dl_se it belongs
> +	 * to (the original one/itself).
> +	 */
> +	struct sched_dl_entity *pi_se;
> +#endif
>  };
>
>  #ifdef CONFIG_UCLAMP_TASK
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6f533bb7d3b9..e10aba6c363d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4908,19 +4908,26 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>                   (pi_task && dl_prio(pi_task->prio) &&
>                    dl_entity_preempt(&pi_task->dl, &p->dl))) {
>                       p->dl.dl_boosted = 1;
> +			p->dl.pi_se = pi_task->dl.pi_se;
>                       queue_flag |= ENQUEUE_REPLENISH;
> -		} else
> +		} else {
>                       p->dl.dl_boosted = 0;
> +			p->dl.pi_se = &p->dl;
> +		}
>               p->sched_class = &dl_sched_class;
>       } else if (rt_prio(prio)) {
> -		if (dl_prio(oldprio))
> +		if (dl_prio(oldprio)) {
>                       p->dl.dl_boosted = 0;
> +			p->dl.pi_se = &p->dl;
> +		}
>               if (oldprio < prio)
>                       queue_flag |= ENQUEUE_HEAD;
>               p->sched_class = &rt_sched_class;
>       } else {
> -		if (dl_prio(oldprio))
> +		if (dl_prio(oldprio)) {
>                       p->dl.dl_boosted = 0;
> +			p->dl.pi_se = &p->dl;
> +		}

With this change, do we still need sched_dl_entity.dl_boosted? AIUI this
could become

  bool is_dl_boosted(struct sched_dl_entity *dl_se)
  {
          return pi_of(dl_se) != dl_se;
  }

>               if (rt_prio(oldprio))
>                       p->rt.timeout = 0;
>               p->sched_class = &fair_sched_class;
