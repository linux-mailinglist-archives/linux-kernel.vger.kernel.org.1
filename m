Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867762D9877
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407879AbgLNM67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:58:59 -0500
Received: from foss.arm.com ([217.140.110.172]:47126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgLNM6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:58:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B58091FB;
        Mon, 14 Dec 2020 04:57:52 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D7FE3F66B;
        Mon, 14 Dec 2020 04:57:52 -0800 (PST)
Date:   Mon, 14 Dec 2020 12:57:50 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] arm64: topology: Avoid the have_policy check
Message-ID: <20201214125750.GA15405@arm.com>
References: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Dec 2020 at 21:59:22 (+0530), Viresh Kumar wrote:
> Every time I have stumbled upon this routine, I get confused with the
> way 'have_policy' is used and I have to dig in to understand why is it
> so. Here is an attempt to make it easier to understand, and hopefully it
> is an improvement.
> 
> The 'have_policy' check was just an optimization to avoid writing
> to amu_fie_cpus in case we don't have to, but that optimization itself
> is creating more confusion than the real work. Lets just do that if all
> the CPUs support AMUs. It is much cleaner that way.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Skip the have_policy check altogether
> - Updated subject and log
> 
>  arch/arm64/kernel/topology.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index f6faa697e83e..ebadc73449f9 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -199,14 +199,14 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
>  	return 0;
>  }
>  
> -static inline bool
> +static inline void
>  enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  
>  	if (!policy) {
>  		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
> -		return false;
> +		return;
>  	}
>  
>  	if (cpumask_subset(policy->related_cpus, valid_cpus))
> @@ -214,8 +214,6 @@ enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
>  			   amu_fie_cpus);
>  
>  	cpufreq_cpu_put(policy);
> -
> -	return true;
>  }
>  
>  static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
> @@ -225,7 +223,6 @@ static int __init init_amu_fie(void)
>  {
>  	bool invariance_status = topology_scale_freq_invariant();
>  	cpumask_var_t valid_cpus;
> -	bool have_policy = false;
>  	int ret = 0;
>  	int cpu;
>  
> @@ -245,17 +242,12 @@ static int __init init_amu_fie(void)
>  			continue;
>  
>  		cpumask_set_cpu(cpu, valid_cpus);
> -		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
> +		enable_policy_freq_counters(cpu, valid_cpus);
>  	}
>  
> -	/*
> -	 * If we are not restricted by cpufreq policies, we only enable
> -	 * the use of the AMU feature for FIE if all CPUs support AMU.
> -	 * Otherwise, enable_policy_freq_counters has already enabled
> -	 * policy cpus.
> -	 */
> -	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
> -		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
> +	/* Overwrite amu_fie_cpus if all CPUs support AMU */
> +	if (cpumask_equal(valid_cpus, cpu_present_mask))
> +		cpumask_copy(amu_fie_cpus, cpu_present_mask);
>  
>  	if (!cpumask_empty(amu_fie_cpus)) {
>  		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks,
Ionela.
