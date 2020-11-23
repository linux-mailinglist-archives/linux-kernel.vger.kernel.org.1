Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D32C0244
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKWJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgKWJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:27:57 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:27:55 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so17173736ljo.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXfqNiD9vwMyrPpclbch5b8eJxe/mgQzKRPZo76okjA=;
        b=KLu91vbn6V+vDG2NLPwma7DcB2LnTxCuiqf80D7qMZ82dsmoLf0QNmjEzOzf/59a2i
         pvSxmEUstLUYUckF4qSVxrJj5W4SW0IUKVIIkgttfj+Cb+I6E3mTVuCKSALwp5C6H4dy
         AqV0eKkkCT5v2FtIwQky1YRWU1yThFZ37YctPSuJC71oDgdmnDwTeV4Cl9FSIfTrwErJ
         wVsmaFBW4/gm8PQe4vGGyKlbcv6+MxMz/XCY3q5rFhER+XF3LztVMUiQf71LzMKJgAVT
         H91G/bJzndOSB2ddPuC2k0Tk5vNSTeHvIs04gE00zRX6nZUDAlYR55aW3fvj2GTpSiPK
         85kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXfqNiD9vwMyrPpclbch5b8eJxe/mgQzKRPZo76okjA=;
        b=aP2ayZU1GjyJe4xIDGf2ioR3w3TZkulNeQI4ZDiTnsEObCVk0tjQqtBVx5VKqlFEGW
         IVjeKdgZ6u5NcUfp6GLgstt8uOiQDqsa7v7T7ZNBkS3yq0xSwzYjdflDPPOXlDDw7LcM
         8sbUAV9L6UrObuSSsMQchJ3SRon6mVICNf8LDFbevV4/EuNbJMmsFZDggRMdzinWb3cZ
         I/aRu9aTorAqJ1hXZXe7phGRbm0ueRE9oDQMjY3Q0EHrCHrnBnOjJswe3mQCsSEjbEg/
         eANsm5az55f3ERqbgGjX1kbKqnalnrSzcW1emAbttNkCRhtGL0fyMD56hXlqKcPaZcds
         V9nA==
X-Gm-Message-State: AOAM530Oe9Hvg1EeFumexNDYbUTkg4IkZWzqOw05+nJMzfK019feJplw
        NMpjuvvC7/srjAYiair2SZy0wKb2Iia5OJo5ugXvzQ==
X-Google-Smtp-Source: ABdhPJwdjC0i0Pv9d+EKZzBcMQghBiT0S55SI6A9Z6ChvLYYGhsexOJIbP14cnvsRJDNbUKF4PbpfjSmQSGz/uGY4IY=
X-Received: by 2002:a2e:8050:: with SMTP id p16mr13506053ljg.69.1606123674132;
 Mon, 23 Nov 2020 01:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
In-Reply-To: <20201118043113.53128-1-aubrey.li@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 Nov 2020 10:27:42 +0100
Message-ID: <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Aubrey Li <aubrey.li@linux.intel.com>
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
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> Add idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, if the idle driver indicates to stop tick, this CPU
> is set in the idle cpumask to be a wakeup target. And if the CPU
> is not in idle, the CPU is cleared in idle cpumask during scheduler
> tick to ratelimit idle cpumask update.
>
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
>
> Benchmarks were tested on a x86 4 socket system with 24 cores per
> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
> schbench have no notable change, uperf has:
>
> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
>
>   threads       baseline-avg    %std    patch-avg       %std
>   96            1               0.83    1.23            3.27
>   144           1               1.03    1.67            2.67
>   192           1               0.69    1.81            3.59
>   240           1               2.84    1.51            2.67
>
> v4->v5:
> - add update_idle_cpumask for s2idle case
> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
>   idle_cpumask() everywhere
>
> v3->v4:
> - change setting idle cpumask from every idle entry to tickless idle
>   if cpu driver is available.

Could you remind me why you did this change ? Clearing the cpumask is
done during the tick to rate limit the number of updates of the
cpumask but It's not clear for me why you have associated the set with
the tick stop condition too.

This change means that a cpu will not be part of the idle mask if the
tick is not stopped. On some arm/arm64 platforms, the tick stops only
if the idle duration is expected to be higher than 1-2ms which starts
to be significantly long. Also, the cpuidle governor can easily
mis-predict a short idle duration whereas it will be finally a long
idle duration; In this case, the next tick will correct the situation
and select a deeper state, but this can happen up to 4ms later on
arm/arm64.

So I would prefer to keep trying to set the idle mask everytime the
cpu enters idle. If a tick has not happened between 2 idle phases, the
cpumask will not be updated and the overhead will be mostly testing if
(rq->last_idle_state == idle_state).


> - move clearing idle cpumask to scheduler_tick to decouple nohz mode.
>
> v2->v3:
> - change setting idle cpumask to every idle entry, otherwise schbench
>   has a regression of 99th percentile latency.
> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>   idle cpumask is ratelimited in the idle exiting path.
> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
>
> v1->v2:
> - idle cpumask is updated in the nohz routines, by initializing idle
>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>   behavior.
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jiang Biao <benbjiang@gmail.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  include/linux/sched/topology.h | 13 +++++++++
>  kernel/sched/core.c            |  2 ++
>  kernel/sched/fair.c            | 52 +++++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c            |  8 ++++--
>  kernel/sched/sched.h           |  2 ++
>  kernel/sched/topology.c        |  3 +-
>  6 files changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 820511289857..b47b85163607 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>         atomic_t        ref;
>         atomic_t        nr_busy_cpus;
>         int             has_idle_cores;
> +       /*
> +        * Span of all idle CPUs in this domain.
> +        *
> +        * NOTE: this field is variable length. (Allocated dynamically
> +        * by attaching extra space to the end of the structure,
> +        * depending on how many CPUs the kernel has booted up with)
> +        */
> +       unsigned long   idle_cpus_span[];
>  };
>
> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> +{
> +       return to_cpumask(sds->idle_cpus_span);
> +}
> +
>  struct sched_domain {
>         /* These fields must be setup */
>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b1e0da56abca..c86ae0495163 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3994,6 +3994,7 @@ void scheduler_tick(void)
>         rq_lock(rq, &rf);
>
>         update_rq_clock(rq);
> +       update_idle_cpumask(rq, false);
>         thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
>         update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
>         curr->sched_class->task_tick(rq, curr, 0);
> @@ -7192,6 +7193,7 @@ void __init sched_init(void)
>                 rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
>  #endif
>  #endif /* CONFIG_SMP */
> +               rq->last_idle_state = 1;
>                 hrtick_rq_init(rq);
>                 atomic_set(&rq->nr_iowait, 0);
>         }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48a6d442b444..d67fba5e406b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6145,7 +6145,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         time = cpu_clock(this);
>
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       /*
> +        * sched_domain_shared is set only at shared cache level,
> +        * this works only because select_idle_cpu is called with
> +        * sd_llc.
> +        */
> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
> @@ -6807,6 +6812,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>
> +/*
> + * Update cpu idle state and record this information
> + * in sd_llc_shared->idle_cpus_span.
> + */
> +void update_idle_cpumask(struct rq *rq, bool set_idle)
> +{
> +       struct sched_domain *sd;
> +       int cpu = cpu_of(rq);
> +       int idle_state;
> +
> +       /*
> +        * If called from scheduler tick, only update
> +        * idle cpumask if the CPU is busy, as idle
> +        * cpumask is also updated on idle entry.
> +        *
> +        */
> +       if (!set_idle && idle_cpu(cpu))
> +               return;
> +       /*
> +        * Also set SCHED_IDLE cpu in idle cpumask to
> +        * allow SCHED_IDLE cpu as a wakeup target
> +        */
> +       idle_state = set_idle || sched_idle_cpu(cpu);
> +       /*
> +        * No need to update idle cpumask if the state
> +        * does not change.
> +        */
> +       if (rq->last_idle_state == idle_state)
> +               return;
> +
> +       rcu_read_lock();
> +       sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +       if (!sd || !sd->shared)
> +               goto unlock;
> +
> +       if (idle_state)
> +               cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> +       else
> +               cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> +
> +       rq->last_idle_state = idle_state;
> +unlock:
> +       rcu_read_unlock();
> +}
> +
>  static unsigned long wakeup_gran(struct sched_entity *se)
>  {
>         unsigned long gran = sysctl_sched_wakeup_granularity;
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f324dc36fc43..6f5947673e66 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -163,6 +163,7 @@ static void cpuidle_idle_call(void)
>          */
>
>         if (cpuidle_not_available(drv, dev)) {
> +               update_idle_cpumask(this_rq(), true);
>                 tick_nohz_idle_stop_tick();
>
>                 default_idle_call();
> @@ -193,6 +194,7 @@ static void cpuidle_idle_call(void)
>                         max_latency_ns = dev->forced_idle_latency_limit_ns;
>                 }
>
> +               update_idle_cpumask(this_rq(), true);
>                 tick_nohz_idle_stop_tick();
>
>                 next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> @@ -205,10 +207,12 @@ static void cpuidle_idle_call(void)
>                  */
>                 next_state = cpuidle_select(drv, dev, &stop_tick);
>
> -               if (stop_tick || tick_nohz_tick_stopped())
> +               if (stop_tick || tick_nohz_tick_stopped()) {
> +                       update_idle_cpumask(this_rq(), true);
>                         tick_nohz_idle_stop_tick();
> -               else
> +               } else {
>                         tick_nohz_idle_retain_tick();
> +               }
>
>                 entered_state = call_cpuidle(drv, dev, next_state);
>                 /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8d1ca65db3b0..db460b20217a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1004,6 +1004,7 @@ struct rq {
>         /* This is used to determine avg_idle's max value */
>         u64                     max_idle_balance_cost;
>  #endif /* CONFIG_SMP */
> +       unsigned char           last_idle_state;
>
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>         u64                     prev_irq_time;
> @@ -1088,6 +1089,7 @@ static inline void update_idle_core(struct rq *rq)
>  #else
>  static inline void update_idle_core(struct rq *rq) { }
>  #endif
> +void update_idle_cpumask(struct rq *rq, bool set_idle);
>
>  DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 1bd7e3af904f..541bd3a7de4d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>                 atomic_inc(&sd->shared->ref);
>                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> +               cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
>         }
>
>         sd->private = sdd;
> @@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>
>                         *per_cpu_ptr(sdd->sd, j) = sd;
>
> -                       sds = kzalloc_node(sizeof(struct sched_domain_shared),
> +                       sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
>                                         GFP_KERNEL, cpu_to_node(j));
>                         if (!sds)
>                                 return -ENOMEM;
> --
> 2.25.1
>
