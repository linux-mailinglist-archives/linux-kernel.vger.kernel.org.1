Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790E12B8CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKSITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:19:22 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B591C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:19:20 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id r9so6948791lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IeUV2Um0o1u1mteeDM9Wou+hxe6z4F5MBUvTtjNCuM=;
        b=kYVU3OmHLFI+EcAGzmjAtFxJC2ojtC4RTGilwmd15klcb/XAHpcJoBzjdClayzhoiW
         NWUHjUiYinaNL1zD2UgiSTwwKnBPhB0dm0IykCCDANWD2d0suhZy09H4CRbWeB2deJL6
         hI7m/ruwfbL3KhuCnpwJbcceejWZL0/6gTL5YQ4v0Vq38HK1yTBmMpKLknshnEEEb8qh
         8uaJy869JUHXd45LtAvoK99A4V1umSudKCtCQW0x5og6jB4C1KcJPuNsfSl/OBPMjIut
         n1VatxH+GRVHa2FW9esY61gqe/gKekrtPIk+UZIptfEoD61k8bM3vL/lJ015dBsAgblI
         d5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IeUV2Um0o1u1mteeDM9Wou+hxe6z4F5MBUvTtjNCuM=;
        b=WFzxDqXbtkJJBrwWfwByW4R7zomvqiyZKfpb9x6i4pRGlBABnwmn4ut3wyYwMeSgwU
         kaIU8g2E0KEmfo4Koa3IN+tx/G+J2LKLwMx7IwR971wRowUjolGDcnZ1TB17zAaKLwUb
         Xfs0IZxZNaLaXT1D/fduunkfA7tabXjkwqwvdoODPN2SwRZz9mbuOFSh0Pn/Bl9O0i5/
         ZGbjp5T9k9E6AMsqZ/2Nah8wCF0AfbGh4DA37oS8Xp3oyspZKx9z6CV+gtmug61AfqYX
         TKX5cXBQcE/zz1UChvjbMtjC8zi0NEnAwnvb7fx4cG0hZKpHwLP0LvQQ6kJAF8WP9UV5
         nqIQ==
X-Gm-Message-State: AOAM532ocRm8MvPwOVqqD8hlopSuULOWcLKiBcBgbkljZQ3EcqBAcbzR
        aYcJPNsSSV2U9Pv2hokdeBkuJ0juIH74yHWFQnA5gA==
X-Google-Smtp-Source: ABdhPJyUfXth3EWqIFEkO+S7vYWva/EeM8KJ07Z5jQuU79Vyalfm4EFSundjDfqAZlAv2hWY2q9f2K6cr/vc7QBHnQY=
X-Received: by 2002:a19:6a07:: with SMTP id u7mr5789831lfu.252.1605773958666;
 Thu, 19 Nov 2020 00:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20201116200428.47359-1-aubrey.li@linux.intel.com>
 <CAKfTPtD_Q1riUBm1S5=bGgmMsoi64_33Turs_W+v9eiqJn=wyA@mail.gmail.com> <9d840684-95ad-ece9-8068-29ea72fb61b7@linux.intel.com>
In-Reply-To: <9d840684-95ad-ece9-8068-29ea72fb61b7@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Nov 2020 09:19:07 +0100
Message-ID: <CAKfTPtDuypRFH1hnLsMEwZV1-Zb4dcd8gwtuuZU11hi4_Aepyw@mail.gmail.com>
Subject: Re: [RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 02:34, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> Hi Vincent,
>
> On 2020/11/18 21:36, Vincent Guittot wrote:
> > On Wed, 18 Nov 2020 at 04:48, Aubrey Li <aubrey.li@linux.intel.com> wrote:
> >>
> >> From: Aubrey Li <aubrey.li@intel.com>
> >>
> >> Add idle cpumask to track idle cpus in sched domain. When a CPU
> >> enters idle, if the idle driver indicates to stop tick, this CPU
> >> is set in the idle cpumask to be a wakeup target. And if the CPU
> >> is not in idle, the CPU is cleared in idle cpumask during scheduler
> >> tick to ratelimit idle cpumask update.
> >>
> >> When a task wakes up to select an idle cpu, scanning idle cpumask
> >> has low cost than scanning all the cpus in last level cache domain,
> >> especially when the system is heavily loaded.
> >>
> >> Benchmarks were tested on a x86 4 socket system with 24 cores per
> >> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
> >> schbench have no notable change, uperf has:
> >>
> >> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
> >>
> >>   threads       baseline-avg    %std    patch-avg       %std
> >>   96            1               0.83    1.23            3.27
> >>   144           1               1.03    1.67            2.67
> >>   192           1               0.69    1.81            3.59
> >>   240           1               2.84    1.51            2.67
> >>
> >> Cc: Mel Gorman <mgorman@suse.de>
> >> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> Cc: Qais Yousef <qais.yousef@arm.com>
> >> Cc: Valentin Schneider <valentin.schneider@arm.com>
> >> Cc: Jiang Biao <benbjiang@gmail.com>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >> ---
> >>  include/linux/sched/topology.h | 13 +++++++++
> >>  kernel/sched/core.c            |  2 ++
> >>  kernel/sched/fair.c            | 52 +++++++++++++++++++++++++++++++++-
> >>  kernel/sched/idle.c            |  7 +++--
> >>  kernel/sched/sched.h           |  2 ++
> >>  kernel/sched/topology.c        |  3 +-
> >>  6 files changed, 74 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> >> index 820511289857..b47b85163607 100644
> >> --- a/include/linux/sched/topology.h
> >> +++ b/include/linux/sched/topology.h
> >> @@ -65,8 +65,21 @@ struct sched_domain_shared {
> >>         atomic_t        ref;
> >>         atomic_t        nr_busy_cpus;
> >>         int             has_idle_cores;
> >> +       /*
> >> +        * Span of all idle CPUs in this domain.
> >> +        *
> >> +        * NOTE: this field is variable length. (Allocated dynamically
> >> +        * by attaching extra space to the end of the structure,
> >> +        * depending on how many CPUs the kernel has booted up with)
> >> +        */
> >> +       unsigned long   idle_cpus_span[];
> >>  };
> >>
> >> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> >> +{
> >> +       return to_cpumask(sds->idle_cpus_span);
> >> +}
> >> +
> >>  struct sched_domain {
> >>         /* These fields must be setup */
> >>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index b1e0da56abca..c86ae0495163 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -3994,6 +3994,7 @@ void scheduler_tick(void)
> >>         rq_lock(rq, &rf);
> >>
> >>         update_rq_clock(rq);
> >> +       update_idle_cpumask(rq, false);
> >>         thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> >>         update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> >>         curr->sched_class->task_tick(rq, curr, 0);
> >> @@ -7192,6 +7193,7 @@ void __init sched_init(void)
> >>                 rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
> >>  #endif
> >>  #endif /* CONFIG_SMP */
> >> +               rq->last_idle_state = 1;
> >>                 hrtick_rq_init(rq);
> >>                 atomic_set(&rq->nr_iowait, 0);
> >>         }
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 48a6d442b444..d67fba5e406b 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6145,7 +6145,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >>
> >>         time = cpu_clock(this);
> >>
> >> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >> +       /*
> >> +        * sched_domain_shared is set only at shared cache level,
> >> +        * this works only because select_idle_cpu is called with
> >> +        * sd_llc.
> >> +        */
> >> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
> >>
> >>         for_each_cpu_wrap(cpu, cpus, target) {
> >>                 if (!--nr)
> >> @@ -6807,6 +6812,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >>  }
> >>  #endif /* CONFIG_SMP */
> >>
> >> +/*
> >> + * Update cpu idle state and record this information
> >> + * in sd_llc_shared->idle_cpus_span.
> >> + */
> >> +void update_idle_cpumask(struct rq *rq, bool set_idle)
> >> +{
> >> +       struct sched_domain *sd;
> >> +       int cpu = cpu_of(rq);
> >> +       int idle_state;
> >> +
> >> +       /*
> >> +        * If called from scheduler tick, only update
> >> +        * idle cpumask if the CPU is busy, as idle
> >> +        * cpumask is also updated on idle entry.
> >> +        *
> >> +        */
> >> +       if (!set_idle && idle_cpu(cpu))
> >> +               return;
> >> +       /*
> >> +        * Also set SCHED_IDLE cpu in idle cpumask to
> >> +        * allow SCHED_IDLE cpu as a wakeup target
> >> +        */
> >> +       idle_state = set_idle || sched_idle_cpu(cpu);
> >> +       /*
> >> +        * No need to update idle cpumask if the state
> >> +        * does not change.
> >> +        */
> >> +       if (rq->last_idle_state == idle_state)
> >> +               return;
> >> +
> >> +       rcu_read_lock();
> >> +       sd = rcu_dereference(per_cpu(sd_llc, cpu));
> >> +       if (!sd || !sd->shared)
> >> +               goto unlock;
> >> +
> >> +       if (idle_state)
> >> +               cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> >> +       else
> >> +               cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> >> +
> >> +       rq->last_idle_state = idle_state;
> >> +unlock:
> >> +       rcu_read_unlock();
> >> +}
> >> +
> >>  static unsigned long wakeup_gran(struct sched_entity *se)
> >>  {
> >>         unsigned long gran = sysctl_sched_wakeup_granularity;
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index f324dc36fc43..0bd83c00c22a 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -164,7 +164,7 @@ static void cpuidle_idle_call(void)
> >>
> >>         if (cpuidle_not_available(drv, dev)) {
> >>                 tick_nohz_idle_stop_tick();
> >> -
> >> +               update_idle_cpumask(this_rq(), true);
> >>                 default_idle_call();
> >>                 goto exit_idle;
> >>         }
> >> @@ -205,9 +205,10 @@ static void cpuidle_idle_call(void)
> >>                  */
> >>                 next_state = cpuidle_select(drv, dev, &stop_tick);
> >>
> >> -               if (stop_tick || tick_nohz_tick_stopped())
> >> +               if (stop_tick || tick_nohz_tick_stopped()) {
> >> +                       update_idle_cpumask(this_rq(), true);
> >>                         tick_nohz_idle_stop_tick();
> >
> > please keep same ordering here and above
> > tick_nohz_idle_stop_tick();
> > update_idle_cpumask(this_rq(), true);
>
> okay, will do, thanks!
>
> >
> > Also, it might be good to call update_idle_cpumask everywhere
> > tick_nohz_idle_stop_tick is called. For example S2Idle case should
> > also set the mask
>
> Hmm, I did think about this, but not sure what's the point here to
> set the mask when the whole system suspend to idle and all user space
> are forzen?

when system is in suspend to idle state, the cpu is idle. Would be
good to set it in the mask so it can be used after the resume without
waiting for an idle load balance to pull task if any

>
> Also tick_nohz_idle_stop_tick is called when cpu is offline in cpuidle_idle_call,
> I think adding an offlined cpu to idle cpumask may not be right.

Yes, should be not set when offlining the cpu

>
> >
> >
> >> -               else
> >> +               } else
> >
> > Also add { } in the else
> >
>
> Thanks, will added it.
>
> -Aubrey
