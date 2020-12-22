Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C22DB765
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgLPAEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:04:46 -0500
Received: from foss.arm.com ([217.140.110.172]:43886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgLPAEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:04:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E1F91FB;
        Tue, 15 Dec 2020 16:03:51 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027563F718;
        Tue, 15 Dec 2020 16:03:50 -0800 (PST)
Date:   Wed, 16 Dec 2020 00:03:49 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20201216000349.GA5299@arm.com>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 15 Dec 2020 at 11:04:16 (+0530), Viresh Kumar wrote:
> The AMU counters won't get used today if the cpufreq driver is built as
> a module as the amu core requires everything to be ready by late init.
> 
> Fix that properly by registering for cpufreq policy notifier. Note that
> the amu core don't have any cpufreq dependency after the first time
> CPUFREQ_CREATE_POLICY notifier is called for all the CPUs. And so we
> don't need to do anything on the CPUFREQ_REMOVE_POLICY notifier. And for
> the same reason we check if the CPUs are already parsed in the beginning
> of amu_fie_setup() and skip if that is true. Alternatively we can shoot
> a work from there to unregister the notifier instead, but that seemed
> too much instead of this simple check.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3:
> - This is a new patch.
> 
> Ionela,
> 
> I don't have a way to test the AMU stuff, will it be possible for you to
> give it a try ?
> 

My best AMU test setup is a hacked Juno :). A few runs with different
"AMU settings" showed everything works nicely. I'll continue reviewing
and testing tomorrow as I want to test with CPPC and on some models as
well.

>  arch/arm64/kernel/topology.c | 88 +++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 57267d694495..0fc2b32ddb45 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -199,64 +199,33 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
>  	return 0;
>  }
>  
> -static inline void
> -enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
> -{
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -
> -	if (!policy) {
> -		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
> -		return;
> -	}
> -
> -	if (cpumask_subset(policy->related_cpus, valid_cpus))
> -		cpumask_or(amu_fie_cpus, policy->related_cpus,
> -			   amu_fie_cpus);
> -
> -	cpufreq_cpu_put(policy);
> -}
> -
>  static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
>  #define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
>  
> -static int __init init_amu_fie(void)
> +static void amu_fie_setup(const struct cpumask *cpus)
>  {
> -	cpumask_var_t valid_cpus;
>  	bool invariant;
> -	int ret = 0;
>  	int cpu;
>  
> -	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> -		ret = -ENOMEM;
> -		goto free_valid_mask;
> -	}
> +	/* We are already set since the last insmod of cpufreq driver */
> +	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> +		return;
>  
> -	for_each_present_cpu(cpu) {
> +	for_each_cpu(cpu, cpus) {
>  		if (!freq_counters_valid(cpu) ||
>  		    freq_inv_set_max_ratio(cpu,
>  					   cpufreq_get_hw_max_freq(cpu) * 1000,
>  					   arch_timer_get_rate()))
> -			continue;
> -
> -		cpumask_set_cpu(cpu, valid_cpus);
> -		enable_policy_freq_counters(cpu, valid_cpus);
> +			return;
>  	}
>  
> -	/* Overwrite amu_fie_cpus if all CPUs support AMU */
> -	if (cpumask_equal(valid_cpus, cpu_present_mask))
> -		cpumask_copy(amu_fie_cpus, cpu_present_mask);
> -
> -	if (cpumask_empty(amu_fie_cpus))
> -		goto free_valid_mask;
> +	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
>  
>  	invariant = topology_scale_freq_invariant();
>  
>  	/* We aren't fully invariant yet */
>  	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> -		goto free_valid_mask;
> +		return;
>  
>  	static_branch_enable(&amu_fie_key);
>  

If we are cpufreq invariant, we'll reach this point and the following
pr_info, even if not all CPUs have been checked, which (at this late
hour) I think it's functionally fine.

But we get prints like:

[    2.665918] AMU: CPUs[0-3]: counters will be used for FIE.
[    2.666293] AMU: CPUs[0-5]: counters will be used for FIE.

For two policies this is fine (although confusing) but if we had more
CPUs and more policies, it would be too many lines.

I'm not sure if there's a better way of fixing this other than keeping
track of all visited CPUs and printing this line when all online CPUs
have been visited.

> @@ -271,13 +240,48 @@ static int __init init_amu_fie(void)
>  	 */
>  	if (!invariant)
>  		rebuild_sched_domains_energy();
> +}
> +
> +static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> +				 void *data)
> +{
> +	struct cpufreq_policy *policy = data;
> +
> +	if (val == CPUFREQ_CREATE_POLICY)
> +		amu_fie_setup(policy->related_cpus);
> +

Is is guaranteed that cpuinfo.max_freq is always set at this point?

I have a vague recollection of a scenario where cpuinfo.max_freq could
be populated later in case the driver needs to talk to firmware to
obtain this value.

The setup above will fail if the CPU's max frequency cannot be obtained.

Thanks,
Ionela.

> +	/*
> +	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> +	 * counters don't have any dependency on cpufreq driver once we have
> +	 * initialized AMU support and enabled invariance. The AMU counters will
> +	 * keep on working just fine in the absence of the cpufreq driver, and
> +	 * for the CPUs for which there are no counters availalbe, the last set
> +	 * value of freq_scale will remain valid as that is the frequency those
> +	 * CPUs are running at.
> +	 */
> +
> +	return 0;
> +}
> +
> +static struct notifier_block init_amu_fie_notifier = {
> +	.notifier_call = init_amu_fie_callback,
> +};
> +
> +static int __init init_amu_fie(void)
> +{
> +	int ret;
> +
> +	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> +		return -ENOMEM;
>  
> -free_valid_mask:
> -	free_cpumask_var(valid_cpus);
> +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> +					CPUFREQ_POLICY_NOTIFIER);
> +	if (ret)
> +		free_cpumask_var(amu_fie_cpus);
>  
>  	return ret;
>  }
> -late_initcall_sync(init_amu_fie);
> +core_initcall(init_amu_fie);
>  
>  bool arch_freq_counters_available(const struct cpumask *cpus)
>  {
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
