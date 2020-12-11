Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0582D7936
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437886AbgLKP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:27:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:36443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437910AbgLKP0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:26:48 -0500
IronPort-SDR: uLCQgdA3G0ZcVHGQXafmHMZl63b2Tep8zPiZ152nn/54brVk3jfVeTievyodQsPBzEJ1YJy6zk
 tDX8cJkmTIRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="174558879"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="174558879"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 07:24:55 -0800
IronPort-SDR: wP8pGSnHdLEd1F4GbmYIJm0l3mK79VRnSMcYW+XqSyOqC5eHnraG0Yc+u673ZhYtJdKwJCCpDV
 VZo0CS44CFAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="371651190"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2020 07:24:51 -0800
Subject: Re: [RFC PATCH v8] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
References: <20201210014359.183771-1-aubrey.li@linux.intel.com>
 <CAKfTPtAVC-ZJYexcYvVdO5gOJ2aXKzRpjLC797xoh5n4TWGU=Q@mail.gmail.com>
 <26c69935-e53d-32dc-0366-a1fb7f3c3d56@linux.intel.com>
 <CAKfTPtCrMAft5t8BrLxgLVoaLHoAmhTp3zgeB8Cu-7+fMSd2zw@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <698a61bf-6eea-8725-95c0-a5ea811e2bb4@linux.intel.com>
Date:   Fri, 11 Dec 2020 23:24:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCrMAft5t8BrLxgLVoaLHoAmhTp3zgeB8Cu-7+fMSd2zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/11 23:22, Vincent Guittot wrote:
> On Fri, 11 Dec 2020 at 16:19, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/12/11 23:07, Vincent Guittot wrote:
>>> On Thu, 10 Dec 2020 at 02:44, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>>>
>>>> Add idle cpumask to track idle cpus in sched domain. Every time
>>>> a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
>>>> target. And if the CPU is not in idle, the CPU is cleared in idle
>>>> cpumask during scheduler tick to ratelimit idle cpumask update.
>>>>
>>>> When a task wakes up to select an idle cpu, scanning idle cpumask
>>>> has lower cost than scanning all the cpus in last level cache domain,
>>>> especially when the system is heavily loaded.
>>>>
>>>> Benchmarks including hackbench, schbench, uperf, sysbench mysql and
>>>> kbuild have been tested on a x86 4 socket system with 24 cores per
>>>> socket and 2 hyperthreads per core, total 192 CPUs, no regression
>>>> found.
>>>>
>>>> v7->v8:
>>>> - refine update_idle_cpumask, no functionality change
>>>> - fix a suspicious RCU usage warning with CONFIG_PROVE_RCU=y
>>>>
>>>> v6->v7:
>>>> - place the whole idle cpumask mechanism under CONFIG_SMP
>>>>
>>>> v5->v6:
>>>> - decouple idle cpumask update from stop_tick signal, set idle CPU
>>>>   in idle cpumask every time the CPU enters idle
>>>>
>>>> v4->v5:
>>>> - add update_idle_cpumask for s2idle case
>>>> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
>>>>   idle_cpumask() everywhere
>>>>
>>>> v3->v4:
>>>> - change setting idle cpumask from every idle entry to tickless idle
>>>>   if cpu driver is available
>>>> - move clearing idle cpumask to scheduler_tick to decouple nohz mode
>>>>
>>>> v2->v3:
>>>> - change setting idle cpumask to every idle entry, otherwise schbench
>>>>   has a regression of 99th percentile latency
>>>> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>>>>   idle cpumask is ratelimited in the idle exiting path
>>>> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target
>>>>
>>>> v1->v2:
>>>> - idle cpumask is updated in the nohz routines, by initializing idle
>>>>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>>>>   behavior
>>>>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Mel Gorman <mgorman@suse.de>
>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>>> Cc: Qais Yousef <qais.yousef@arm.com>
>>>> Cc: Valentin Schneider <valentin.schneider@arm.com>
>>>> Cc: Jiang Biao <benbjiang@gmail.com>
>>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>>
>>> This version looks good to me. I don't see regressions of v5 anymore
>>> and see some improvements on heavy cases
>>
>> v5 or v8?
> 
> the v8 looks good to me and I don't see the regressions that I have
> seen with the v5 anymore
> 
Sounds great, thanks, :)

> 
>>
>>>
>>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>>>
>>>> ---
>>>>  include/linux/sched/topology.h | 13 ++++++++++
>>>>  kernel/sched/core.c            |  2 ++
>>>>  kernel/sched/fair.c            | 45 +++++++++++++++++++++++++++++++++-
>>>>  kernel/sched/idle.c            |  5 ++++
>>>>  kernel/sched/sched.h           |  4 +++
>>>>  kernel/sched/topology.c        |  3 ++-
>>>>  6 files changed, 70 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>>>> index 820511289857..b47b85163607 100644
>>>> --- a/include/linux/sched/topology.h
>>>> +++ b/include/linux/sched/topology.h
>>>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>>>>         atomic_t        ref;
>>>>         atomic_t        nr_busy_cpus;
>>>>         int             has_idle_cores;
>>>> +       /*
>>>> +        * Span of all idle CPUs in this domain.
>>>> +        *
>>>> +        * NOTE: this field is variable length. (Allocated dynamically
>>>> +        * by attaching extra space to the end of the structure,
>>>> +        * depending on how many CPUs the kernel has booted up with)
>>>> +        */
>>>> +       unsigned long   idle_cpus_span[];
>>>>  };
>>>>
>>>> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
>>>> +{
>>>> +       return to_cpumask(sds->idle_cpus_span);
>>>> +}
>>>> +
>>>>  struct sched_domain {
>>>>         /* These fields must be setup */
>>>>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index c4da7e17b906..b136e2440ea4 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -4011,6 +4011,7 @@ void scheduler_tick(void)
>>>>
>>>>  #ifdef CONFIG_SMP
>>>>         rq->idle_balance = idle_cpu(cpu);
>>>> +       update_idle_cpumask(cpu, rq->idle_balance);
>>>>         trigger_load_balance(rq);
>>>>  #endif
>>>>  }
>>>> @@ -7186,6 +7187,7 @@ void __init sched_init(void)
>>>>                 rq->idle_stamp = 0;
>>>>                 rq->avg_idle = 2*sysctl_sched_migration_cost;
>>>>                 rq->max_idle_balance_cost = sysctl_sched_migration_cost;
>>>> +               rq->last_idle_state = 1;
>>>>
>>>>                 INIT_LIST_HEAD(&rq->cfs_tasks);
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index c0c4d9ad7da8..25f36ecfee54 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6146,7 +6146,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>>>
>>>>         time = cpu_clock(this);
>>>>
>>>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>> +       /*
>>>> +        * sched_domain_shared is set only at shared cache level,
>>>> +        * this works only because select_idle_cpu is called with
>>>> +        * sd_llc.
>>>> +        */
>>>> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
>>>>
>>>>         for_each_cpu_wrap(cpu, cpus, target) {
>>>>                 if (!--nr)
>>>> @@ -6806,6 +6811,44 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>>>
>>>>         return newidle_balance(rq, rf) != 0;
>>>>  }
>>>> +
>>>> +/*
>>>> + * Update cpu idle state and record this information
>>>> + * in sd_llc_shared->idle_cpus_span.
>>>> + *
>>>> + * This function is called with interrupts disabled.
>>>> + */
>>>> +void update_idle_cpumask(int cpu, bool idle)
>>>> +{
>>>> +       struct sched_domain *sd;
>>>> +       struct rq *rq = cpu_rq(cpu);
>>>> +       int idle_state;
>>>> +
>>>> +       /*
>>>> +        * Also set SCHED_IDLE cpu in idle cpumask to
>>>> +        * allow SCHED_IDLE cpu as a wakeup target.
>>>> +        */
>>>> +       idle_state = idle || sched_idle_cpu(cpu);
>>>> +       /*
>>>> +        * No need to update idle cpumask if the state
>>>> +        * does not change.
>>>> +        */
>>>> +       if (rq->last_idle_state == idle_state)
>>>> +               return;
>>>> +       /*
>>>> +        * Called with irq disabled, rcu protection is not needed.
>>>> +        */
>>>> +       sd = per_cpu(sd_llc, cpu);
>>>> +       if (unlikely(!sd))
>>>> +               return;
>>>> +
>>>> +       if (idle_state)
>>>> +               cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
>>>> +       else
>>>> +               cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
>>>> +
>>>> +       rq->last_idle_state = idle_state;
>>>> +}
>>>>  #endif /* CONFIG_SMP */
>>>>
>>>>  static unsigned long wakeup_gran(struct sched_entity *se)
>>>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>>>> index f324dc36fc43..2c517d6a061a 100644
>>>> --- a/kernel/sched/idle.c
>>>> +++ b/kernel/sched/idle.c
>>>> @@ -257,6 +257,11 @@ static void do_idle(void)
>>>>                         cpuhp_report_idle_dead();
>>>>                         arch_cpu_idle_dead();
>>>>                 }
>>>> +               /*
>>>> +                * The CPU is about to go idle, set it in idle cpumask
>>>> +                * to be a wake up target.
>>>> +                */
>>>> +               update_idle_cpumask(cpu, true);
>>>>
>>>>                 arch_cpu_idle_enter();
>>>>
>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>> index 8d1ca65db3b0..4041d5a10de5 100644
>>>> --- a/kernel/sched/sched.h
>>>> +++ b/kernel/sched/sched.h
>>>> @@ -976,6 +976,7 @@ struct rq {
>>>>
>>>>         unsigned char           nohz_idle_balance;
>>>>         unsigned char           idle_balance;
>>>> +       unsigned char           last_idle_state;
>>>>
>>>>         unsigned long           misfit_task_load;
>>>>
>>>> @@ -1516,6 +1517,8 @@ static inline unsigned int group_first_cpu(struct sched_group *group)
>>>>
>>>>  extern int group_balance_cpu(struct sched_group *sg);
>>>>
>>>> +void update_idle_cpumask(int cpu, bool idle);
>>>> +
>>>>  #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_SYSCTL)
>>>>  void register_sched_domain_sysctl(void);
>>>>  void dirty_sched_domain_sysctl(int cpu);
>>>> @@ -1536,6 +1539,7 @@ extern void flush_smp_call_function_from_idle(void);
>>>>
>>>>  #else /* !CONFIG_SMP: */
>>>>  static inline void flush_smp_call_function_from_idle(void) { }
>>>> +static inline void update_idle_cpumask(int cpu, bool idle) { }
>>>>  #endif
>>>>
>>>>  #include "stats.h"
>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>> index 1bd7e3af904f..541bd3a7de4d 100644
>>>> --- a/kernel/sched/topology.c
>>>> +++ b/kernel/sched/topology.c
>>>> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
>>>>                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>>>>                 atomic_inc(&sd->shared->ref);
>>>>                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
>>>> +               cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
>>>>         }
>>>>
>>>>         sd->private = sdd;
>>>> @@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>>>>
>>>>                         *per_cpu_ptr(sdd->sd, j) = sd;
>>>>
>>>> -                       sds = kzalloc_node(sizeof(struct sched_domain_shared),
>>>> +                       sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
>>>>                                         GFP_KERNEL, cpu_to_node(j));
>>>>                         if (!sds)
>>>>                                 return -ENOMEM;
>>>> --
>>>> 2.25.1
>>>>
>>

