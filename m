Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D882B0334
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKLK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:57:19 -0500
Received: from foss.arm.com ([217.140.110.172]:47076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKLK5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:57:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE030139F;
        Thu, 12 Nov 2020 02:57:17 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32E8F3F73C;
        Thu, 12 Nov 2020 02:57:16 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:57:13 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201112105713.xz3f52tcvjhk7si5@e107158-lin.cambridge.arm.com>
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/20 23:03, Aubrey Li wrote:
> From: Aubrey Li <aubrey.li@intel.com>
> 
> Added idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, its corresponding bit in the idle cpumask will be set,
> and when the CPU exits idle, its bit will be cleared.
> 
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
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

Did you intend to put the patch version history in the commit message?

I started looking at this last week but got distracted. I see you already got
enough reviews, so my 2p is that I faced some compilation issues:

	aarch64-linux-gnu-ld: kernel/sched/idle.o: in function `set_next_task_idle':
	/mnt/data/src/linux/kernel/sched/idle.c:405: undefined reference to `update_idle_cpumask'
	aarch64-linux-gnu-ld: kernel/sched/fair.o: in function `nohz_balancer_kick':
	/mnt/data/src/linux/kernel/sched/fair.c:10150: undefined reference to `update_idle_cpumask'
	aarch64-linux-gnu-ld: /mnt/data/src/linux/kernel/sched/fair.c:10148: undefined reference to `update_idle_cpumask'

Because of the missing CONFIG_SCHED_SMT in my .config. I think
update_idle_cpumask() should be defined unconditionally.

Thanks

--
Qais Yousef

> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jiang Biao <benbjiang@gmail.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  include/linux/sched/topology.h | 13 ++++++++++
>  kernel/sched/fair.c            | 45 +++++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c            |  1 +
>  kernel/sched/sched.h           |  1 +
>  kernel/sched/topology.c        |  3 ++-
>  5 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index fb11091129b3..43a641d26154 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +	/*
> +	 * Span of all idle CPUs in this domain.
> +	 *
> +	 * NOTE: this field is variable length. (Allocated dynamically
> +	 * by attaching extra space to the end of the structure,
> +	 * depending on how many CPUs the kernel has booted up with)
> +	 */
> +	unsigned long	idle_cpus_span[];
>  };
>  
> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> +{
> +	return to_cpumask(sds->idle_cpus_span);
> +}
> +
>  struct sched_domain {
>  	/* These fields must be setup */
>  	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6b3b59cc51d6..088d1995594f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6023,6 +6023,38 @@ void __update_idle_core(struct rq *rq)
>  	rcu_read_unlock();
>  }
>  
> +static DEFINE_PER_CPU(bool, cpu_idle_state);
> +/*
> + * Update cpu idle state and record this information
> + * in sd_llc_shared->idle_cpus_span.
> + */
> +void update_idle_cpumask(struct rq *rq, bool idle_state)
> +{
> +	struct sched_domain *sd;
> +	int cpu = cpu_of(rq);
> +
> +	/*
> +	 * No need to update idle cpumask if the state
> +	 * does not change.
> +	 */
> +	if (per_cpu(cpu_idle_state, cpu) == idle_state)
> +		return;
> +
> +	per_cpu(cpu_idle_state, cpu) = idle_state;
> +
> +	rcu_read_lock();
> +
> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +	if (!sd || !sd->shared)
> +		goto unlock;
> +	if (idle_state)
> +		cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> +	else
> +		cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> +unlock:
> +	rcu_read_unlock();
> +}
> +
>  /*
>   * Scan the entire LLC domain for idle cores; this dynamically switches off if
>   * there are no idle cores left in the system; tracked through
> @@ -6136,7 +6168,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  
>  	time = cpu_clock(this);
>  
> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +	/*
> +	 * sched_domain_shared is set only at shared cache level,
> +	 * this works only because select_idle_cpu is called with
> +	 * sd_llc.
> +	 */
> +	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
>  
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
> @@ -10070,6 +10107,12 @@ static void nohz_balancer_kick(struct rq *rq)
>  	if (unlikely(rq->idle_balance))
>  		return;
>  
> +	/* The CPU is not in idle, update idle cpumask */
> +	if (unlikely(sched_idle_cpu(cpu))) {
> +		/* Allow SCHED_IDLE cpu as a wakeup target */
> +		update_idle_cpumask(rq, true);
> +	} else
> +		update_idle_cpumask(rq, false);
>  	/*
>  	 * We may be recently in ticked or tickless idle mode. At the first
>  	 * busy tick after returning from idle, we will update the busy stats.
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 1ae95b9150d3..ce1f929d7fbb 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -405,6 +405,7 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
>  {
>  	update_idle_core(rq);
> +	update_idle_cpumask(rq, true);
>  	schedstat_inc(rq->sched_goidle);
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c82857e2e288..2d1655039ed5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1069,6 +1069,7 @@ static inline void update_idle_core(struct rq *rq)
>  #else
>  static inline void update_idle_core(struct rq *rq) { }
>  #endif
> +void update_idle_cpumask(struct rq *rq, bool idle_state);
>  
>  DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9079d865a935..f14a6ef4de57 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
>  		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>  		atomic_inc(&sd->shared->ref);
>  		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> +		cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
>  	}
>  
>  	sd->private = sdd;
> @@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>  
>  			*per_cpu_ptr(sdd->sd, j) = sd;
>  
> -			sds = kzalloc_node(sizeof(struct sched_domain_shared),
> +			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
>  					GFP_KERNEL, cpu_to_node(j));
>  			if (!sds)
>  				return -ENOMEM;
> -- 
> 2.25.1
> 
