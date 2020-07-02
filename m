Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF17212914
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGBQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 12:11:20 -0400
Received: from foss.arm.com ([217.140.110.172]:39468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGBQLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:11:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B131FB;
        Thu,  2 Jul 2020 09:11:19 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8083F71E;
        Thu,  2 Jul 2020 09:11:18 -0700 (PDT)
References: <20200702144258.19326-1-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
In-reply-to: <20200702144258.19326-1-vincent.guittot@linaro.org>
Date:   Thu, 02 Jul 2020 17:11:15 +0100
Message-ID: <jhjh7up99ss.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/20 15:42, Vincent Guittot wrote:
> task_h_load() can return 0 in some situations like running stress-ng
> mmapfork, which forks thousands of threads, in a sched group on a 224 cores
> system. The load balance doesn't handle this correctly because
> env->imbalance never decreases and it will stop pulling tasks only after
> reaching loop_max, which can be equal to the number of running tasks of
> the cfs. Make sure that imbalance will be decreased by at least 1.
>
> misfit task is the other feature that doesn't handle correctly such
> situation although it's probably more difficult to face the problem
> because of the smaller number of CPUs and running tasks on heterogenous
> system.
>
> We can't simply ensure that task_h_load() returns at least one because it
> would imply to handle underrun in other places.

Nasty one, that...

Random thought: isn't that the kind of thing we have scale_load() and
scale_load_down() for? There's more uses of task_h_load() than I would like
for this, but if we upscale its output (or introduce an upscaled variant),
we could do something like:

---
detach_tasks()
{
        long imbalance = env->imbalance;

        if (env->migration_type == migrate_load)
                imbalance = scale_load(imbalance);

        while (!list_empty(tasks)) {
                /* ... */
                switch (env->migration_type) {
                case migrate_load:
                        load = task_h_load_upscaled(p);
                        /* ... usual bits here ...*/
                        lsub_positive(&env->imbalance, load);
                        break;
                        /* ... */
                }

                if (!scale_load_down(env->imbalance))
                        break;
        }
}
---

It's not perfect, and there's still the misfit situation to sort out -
still, do you think this is something we could go towards?

>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6fab1d17c575..62747c24aa9e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4049,7 +4049,13 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>               return;
>       }
>
> -	rq->misfit_task_load = task_h_load(p);
> +	/*
> +	 * Make sure that misfit_task_load will not be null even if
> +	 * task_h_load() returns 0. misfit_task_load is only used to select
> +	 * rq with highest load so adding 1 will not modify the result
> +	 * of the comparison.
> +	 */
> +	rq->misfit_task_load = task_h_load(p) + 1;
>  }
>
>  #else /* CONFIG_SMP */
> @@ -7664,6 +7670,16 @@ static int detach_tasks(struct lb_env *env)
>                           env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>                               goto next;
>
> +			/*
> +			 * Depending of the number of CPUs and tasks and the
> +			 * cgroup hierarchy, task_h_load() can return a null
> +			 * value. Make sure that env->imbalance decreases
> +			 * otherwise detach_tasks() will stop only after
> +			 * detaching up to loop_max tasks.
> +			 */
> +			if (!load)
> +				load = 1;
> +
>                       env->imbalance -= load;
>                       break;
