Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAD2FA08D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390843AbhARM54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:57:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:55726 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391672AbhARM5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:57:00 -0500
IronPort-SDR: FgJxmI0q2kJ4nEnP0rbxmOkt83/ngO5aj//sHYTZ/I+NSu/CXCIk9NyJkLf6ic9GbSqhBZb1u5
 7Wpeq88Pa++Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="263604585"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="263604585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 04:55:06 -0800
IronPort-SDR: uiCCPJXHRSHq2VyOPUupq8bkNIwcymzM8rOIO1b/zAXiA0a1K3NU4tCoo6F359wkDNxgXapQkG
 nGbrWyklWHXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="406210843"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2021 04:55:04 -0800
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210115100855.23679-1-mgorman@techsingularity.net>
 <20210115100855.23679-6-mgorman@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <05522d03-e86d-420e-4e88-f098d9a22908@linux.intel.com>
Date:   Mon, 18 Jan 2021 20:55:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115100855.23679-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/15 18:08, Mel Gorman wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Both select_idle_core() and select_idle_cpu() do a loop over the same
> cpumask. Observe that by clearing the already visited CPUs, we can
> fold the iteration and iterate a core at a time.
> 
> All we need to do is remember any non-idle CPU we encountered while
> scanning for an idle core. This way we'll only iterate every CPU once.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 97 +++++++++++++++++++++++++++------------------
>  1 file changed, 59 insertions(+), 38 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 12e08da90024..6c0f841e9e75 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6006,6 +6006,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>  	return new_cpu;
>  }
>  
> +static inline int __select_idle_cpu(struct task_struct *p, int core, struct cpumask *cpus)

Sorry if I missed anything, why p and cpus are needed here?

> +{
> +	if (available_idle_cpu(core) || sched_idle_cpu(core))
> +		return core;
> +
> +	return -1;
> +}
> +
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
> @@ -6066,40 +6074,34 @@ void __update_idle_core(struct rq *rq)
>   * there are no idle cores left in the system; tracked through
>   * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
>   */
> -static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
> -	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -	int core, cpu;
> +	bool idle = true;
> +	int cpu;
>  
>  	if (!static_branch_likely(&sched_smt_present))
> -		return -1;
> -
> -	if (!test_idle_cores(target, false))
> -		return -1;
> -
> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +		return __select_idle_cpu(p, core, cpus);
>  
> -	for_each_cpu_wrap(core, cpus, target) {
> -		bool idle = true;
> -
> -		for_each_cpu(cpu, cpu_smt_mask(core)) {
> -			if (!available_idle_cpu(cpu)) {
> -				idle = false;
> -				break;
> +	for_each_cpu(cpu, cpu_smt_mask(core)) {
> +		if (!available_idle_cpu(cpu)) {
> +			idle = false;
> +			if (*idle_cpu == -1) {
> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +					*idle_cpu = cpu;
> +					break;
> +				}
> +				continue;
>  			}
> +			break;
>  		}
> -
> -		if (idle)
> -			return core;
> -
> -		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> +		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> +			*idle_cpu = cpu;
>  	}
>  
> -	/*
> -	 * Failed to find an idle core; stop looking for one.
> -	 */
> -	set_idle_cores(target, 0);
> +	if (idle)
> +		return core;
>  
> +	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>  	return -1;
>  }
>  
> @@ -6107,9 +6109,18 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>  
>  #define sched_smt_weight	1
>  
> -static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> +static inline void set_idle_cores(int cpu, int val)
>  {
> -	return -1;
> +}
> +
> +static inline bool test_idle_cores(int cpu, bool def)
> +{
> +	return def;
> +}
> +
> +static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> +{
> +	return __select_idle_cpu(p, core, cpus);
>  }
>  
>  #endif /* CONFIG_SCHED_SMT */
> @@ -6124,10 +6135,11 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +	bool smt = test_idle_cores(target, false);
> +	int this = smp_processor_id();
>  	struct sched_domain *this_sd;
>  	u64 time;
> -	int this = smp_processor_id();
> -	int cpu, nr = INT_MAX;
>  
>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6135,7 +6147,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>  
> -	if (sched_feat(SIS_PROP)) {
> +	if (sched_feat(SIS_PROP) && !smt) {
Is it possible the system does have a idle core, but I still don't want to scan the entire llc domain?

>  		u64 avg_cost, avg_idle, span_avg;
>  
>  		/*
> @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
>  			return -1;

It looks like nr only makes sense when smt = false now, can it be moved into else branch below?

> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -			break;
> +		if (smt) {
> +			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +			if ((unsigned int)i < nr_cpumask_bits)
> +				return i;

What if the last idle core is selected here, should we set_idle_cores false before return?

> +
> +		} else {
> +			i = __select_idle_cpu(p, cpu, cpus);
> +			if ((unsigned int)i < nr_cpumask_bits) {
> +				idle_cpu = i;
> +				break;
> +			}
> +		}
>  	}
>  
> -	if (sched_feat(SIS_PROP)) {
> +	if (smt)
> +		set_idle_cores(this, false);
> +
> +	if (sched_feat(SIS_PROP) && !smt) {
>  		time = cpu_clock(this) - time;
>  		update_avg(&this_sd->avg_scan_cost, time);
>  	}
>  
> -	return cpu;
> +	return idle_cpu;
>  }
>  
>  /*
> @@ -6297,10 +6322,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if (!sd)
>  		return target;
>  
> -	i = select_idle_core(p, sd, target);
> -	if ((unsigned)i < nr_cpumask_bits)
> -		return i;
> -
>  	i = select_idle_cpu(p, sd, target);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
> 

