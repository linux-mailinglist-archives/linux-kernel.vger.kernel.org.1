Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5D2F9DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbhARLUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389986AbhARLOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:14:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:13:46 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p13so17835082ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbmVLHsIQvH768wf2R1mZs5dO33OOj40odymyUc+uBM=;
        b=Fr4k1GKw8YMKg96FddfGv1xGA1HPAL4J2ssMuwkpnrijXcbjkQ/m9iRxFBk7zav7uy
         Hu8RwzGtsJ5NgkwYeVEv+AJzEHOhv5y2zgp4NkRKIDvC/KOQrSQFvGc+KVGB8B8KGZA2
         1OH0EAoTm87AsS2GAht62WvGiTo5ifAHWWZAz31Ba7lXLpmHc1Z/Oh/bs8czm1HfQ6M2
         ETkLZ08Z0ZRArJvEa0AMup1U3kqSPkOWzOEiDQS6J8yMxaN64EIL0OsQYzaVuFR98uIu
         6HDhhTqt7TgeqPrKv08izF+dhArq0s65p+jTV3kR0JEiC9gfxG4jKJqcSWjmlubCfr65
         3a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbmVLHsIQvH768wf2R1mZs5dO33OOj40odymyUc+uBM=;
        b=odAHEB0OI0G1nskvQfP1OdUxIQZduTfXi9qUdq9Efi2rcAagYJ3DD+5bxja4110lo6
         C59Yz044UO7xtLqdDBmSTlGGI/ACHJvEs8rNp7YvgadM0K/KkcN4yNfJNBz3WV+99T1U
         uKicPjRa02EfdpMkqEWF+iQ5PgCHNA5TSx1ObU1I76Rtt8g6mvdig8N2nWrdvvNQSAmW
         0FDkEXXBPb/2UAJrizWErnWutZrmA7AHwXuPO6XyAGOFnAb68Oi+vaXNf291CssDr84C
         OknZHxnGBT9q64pQwuFxCDJtXsmrmUp1rfGrcIaqO3ZCcTbqpIwV9kVzBKvzPz1HxjN2
         pUpQ==
X-Gm-Message-State: AOAM530adMNsaYwFCxF9fWGajgFy5/CZ00G4/rQX96nzrVVpETs0i+/C
        ObE0g+fXlUza2D2MzqsR0A0JODl7lYyMAgp2jLt5IA==
X-Google-Smtp-Source: ABdhPJwj2ggYR+kHbG/GQ2rVX2ne2KZSmE6y9MK4t6iSFLVXi5zT7kj2eoBjc/x8Mrsix0IwZaUPyQQgGb5i/LDZcyI=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr9791335ljk.299.1610968425091;
 Mon, 18 Jan 2021 03:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20210115203632.34396-1-song.bao.hua@hisilicon.com>
In-Reply-To: <20210115203632.34396-1-song.bao.hua@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Jan 2021 12:13:33 +0100
Message-ID: <CAKfTPtAbbMEGQjVbNw-Z3O-Bh9-JKaHy4J2snwp5RwxSNXqz-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: first try to fix the scheduling impact of
 NUMA diameter > 2
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 at 21:42, Barry Song <song.bao.hua@hisilicon.com> wrote:
>
> This patch is a follow-up of the 3-hops issue reported by Valentin Schneider:
> [1] https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com/
> [2] https://lore.kernel.org/lkml/20201110184300.15673-1-valentin.schneider@arm.com/
>
> Here is a brief summary of the background:
> For a NUMA system with 3-hops, sched_group for NUMA 2-hops could be not a
> subset of sched_domain.
> For example, for a system with the below topology(two cpus in each NUMA
> node):
> node   0   1   2   3
>   0:  10  12  20  22
>   1:  12  10  22  24
>   2:  20  22  10  12
>   3:  22  24  12  10
>
> For CPU0, domain-2 will span 0-5, but its group will span 0-3, 4-7.
> 4-7 isn't a subset of 0-5.
>
> CPU0 attaching sched-domain(s):
>  domain-0: span=0-1 level=MC
>   groups: 0:{ span=0 cap=989 }, 1:{ span=1 cap=1016 }
>   domain-1: span=0-3 level=NUMA
>    groups: 0:{ span=0-1 cap=2005 }, 2:{ span=2-3 cap=2028 }
>    domain-2: span=0-5 level=NUMA
>     groups: 0:{ span=0-3 cap=4033 }, 4:{ span=4-7 cap=3909 }
>  ERROR: groups don't span domain->span
>     domain-3: span=0-7 level=NUMA
>      groups: 0:{ span=0-5 mask=0-1 cap=6062 }, 6:{ span=4-7 mask=6-7 cap=3928 }
>
> All other cpus also have the same issue: sched_group could be not a subset
> of sched_domain.
>
> Here I am trying to figure out the scheduling impact of this issue from
> two aspects:
> 1. find busiest cpu in load_balance
> 2. find idlest cpu in fork/exec/wake balance

Would be better to fix the error in the sched domain topology instead
of hacking the load balance to compensate the topology problem

>
> For case 1, load_balance() seems to be handling this issue correctly as it only
> fills cpus in sched_domain to the cpus of lb_env. Also, find_busiest_group()
> and find_busiest_queue() will result in scanning cpus within env.cpus only:
>
> static int load_balance(int this_cpu, struct rq *this_rq,
>                         struct sched_domain *sd, enum cpu_idle_type idle,
>                         int *continue_balancing)
> {`
>         ...
>
>         struct lb_env env = {
>                 ...
>                 .cpus           = cpus,
>                 .fbq_type       = all,
>                 .tasks          = LIST_HEAD_INIT(env.tasks),
>         };
>
>         /* added by barry: only cpus in sched_domain are put in lb_env */
>         cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>         ...
>         /*
>          * added by barry: the below functions are only scanning cpus
>          * in env.cpus
>          */
>         group = find_busiest_group(&env);
>         ...
>
>         busiest = find_busiest_queue(&env, group);
>         ...
> }
>
> But one thing which looks wrong is that update_sg_lb_stats() is only counting
> tasks in sched_domain, but sgs->group_capacity and sgs->group_weight are
> counting all cpus in the sched_group. Then finally, update_sg_lb_stats()
> uses the load of cpus which are in the sched_domain to calculate group_type
> and avg_load which can be seriously underestimated. This is explained in
> detail as the comments added by me in the code:
>
> static inline void update_sg_lb_stats()
> {
>         int i, nr_running, local_group;
>
>         /* added by barry: here it only counts cpu in the sched_domain */
>         for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>                 ...
>                 sgs->group_load += cpu_load(rq);
>                 sgs->group_util += cpu_util(i);
>                 sgs->group_runnable += cpu_runnable(rq);
>                 sgs->sum_h_nr_running += rq->cfs.h_nr_running;
>                 nr_running = rq->nr_running;
>                 sgs->sum_nr_running += nr_running;
>                 ...
>         }
>
>         ...
>         /* added by barry: here it count all cpus which might not be in the domain */
>         sgs->group_capacity = group->sgc->capacity;
>
>         sgs->group_weight = group->group_weight;
>
>         /* added by barry: finally the group_type and avg_load could be wrong */
>
>         sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>
>         if (sgs->group_type == group_overloaded)
>                 sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
>                 sgs->group_capacity;
>         ...
> }
> For example, if we have 2 cpus in sched_domain and  4 cpus in sched_group, the
> code is using the load of 2 cpus to calculate the group_type and avg_load of 4
> cpus, the sched_group is likely to get much lower load than the real case.
> This patch fixed it by only counting cpus within sched_domain for group_capacity
> and group_weight.
>
> For case 2, find_idlest_group() and find_idlest_group_cpu() don't use sched_domain
> for scanning at all. They are scanning all cpus in the sched_group though sched_group
> isn't a subset of sched_domain. So they can result in picking an idle cpu outside
> the sched_domain but inside the sched_group.
> This patch moved to only scan cpus within the sched_domain, which would be similar
> with load_balance().
>
> For this moment, this is pretty much PoC code to get feedback.
>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  kernel/sched/fair.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..f183dba4961e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5901,7 +5901,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
>   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
>   */
>  static int
> -find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
> +find_idlest_group_cpu(struct sched_domain *sd, struct sched_group *group, struct task_struct *p, int this_cpu)
>  {
>         unsigned long load, min_load = ULONG_MAX;
>         unsigned int min_exit_latency = UINT_MAX;
> @@ -5916,6 +5916,10 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>
>         /* Traverse only the allowed CPUs */
>         for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> +               /* when sched_group isn't a subset of sched_domain */
> +               if (!cpumask_test_cpu(i, sched_domain_span(sd)))
> +                       continue;
> +
>                 if (sched_idle_cpu(i))
>                         return i;
>
> @@ -5984,7 +5988,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>                         continue;
>                 }
>
> -               new_cpu = find_idlest_group_cpu(group, p, cpu);
> +               new_cpu = find_idlest_group_cpu(sd, group, p, cpu);
>                 if (new_cpu == cpu) {
>                         /* Now try balancing at a lower domain level of 'cpu': */
>                         sd = sd->child;
> @@ -8416,6 +8420,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
>                         env->flags |= LBF_NOHZ_AGAIN;
>
> +               sgs->group_capacity += capacity_of(i);
> +               sgs->group_weight++;
>                 sgs->group_load += cpu_load(rq);
>                 sgs->group_util += cpu_util(i);
>                 sgs->group_runnable += cpu_runnable(rq);
> @@ -8462,10 +8468,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 sgs->group_asym_packing = 1;
>         }
>
> -       sgs->group_capacity = group->sgc->capacity;
> -
> -       sgs->group_weight = group->group_weight;
> -
>         sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>
>         /* Computing avg_load makes sense only when group is overloaded */
> @@ -8688,10 +8690,12 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>
>         memset(sgs, 0, sizeof(*sgs));
>
> -       for_each_cpu(i, sched_group_span(group)) {
> +       for_each_cpu_and(i, sched_group_span(group), sched_domain_span(sd)) {
>                 struct rq *rq = cpu_rq(i);
>                 unsigned int local;
>
> +               sgs->group_capacity += capacity_of(i);
> +               sgs->group_weight++;
>                 sgs->group_load += cpu_load_without(rq, p);
>                 sgs->group_util += cpu_util_without(i, p);
>                 sgs->group_runnable += cpu_runnable_without(rq, p);
> @@ -8715,10 +8719,6 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>                 sgs->group_misfit_task_load = 1;
>         }
>
> -       sgs->group_capacity = group->sgc->capacity;
> -
> -       sgs->group_weight = group->group_weight;
> -
>         sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
>
>         /*
> --
> 2.25.1
>
