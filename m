Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDCE2D5B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbgLJNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:23:31 -0500
Received: from foss.arm.com ([217.140.110.172]:41514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389111AbgLJNXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:23:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC10C31B;
        Thu, 10 Dec 2020 05:22:43 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E34E3F718;
        Thu, 10 Dec 2020 05:22:43 -0800 (PST)
Date:   Thu, 10 Dec 2020 13:22:42 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210132242.GA8683@arm.com>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thursday 10 Dec 2020 at 12:48:20 (+0530), Viresh Kumar wrote:
> Every time I have stumbled upon this routine, I get confused with the
> way 'have_policy' is used and I have to dig in to understand why is it
> so.
> 
> Here is an attempt to make it easier to understand, and hopefully it is
> an improvement. This is based on the logic that amu_fie_cpus will be
> empty if cpufreq policy wasn't available for any CPU.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Ionela, I think it would be even better to do this over this patch
> 
> -       /*
> -        * If none of the CPUs have cpufreq support, we only enable
> -        * the use of the AMU feature for FIE if all CPUs support AMU.
> -        * Otherwise, enable_policy_freq_counters has already enabled
> -        * policy cpus.
> -        */
> -       if (cpumask_empty(amu_fie_cpus) &&
> -           cpumask_equal(valid_cpus, cpu_present_mask))
> +       /* Overwrite amu_fie_cpus if all CPUs support AMU */
> +       if (cpumask_equal(valid_cpus, cpu_present_mask))
>                 cpumask_copy(amu_fie_cpus, cpu_present_mask);
> 

Yes, I was just about to suggest this, reading the patch below.

> This will also take care of the case where the cpufreq policy isn't
> there for a small group of CPUs, which do have AMUs enabled for them.
> (This doesn't normally happen though).
> 
> ---
>  arch/arm64/kernel/topology.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index f6faa697e83e..7f7d8de325b6 100644
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
> @@ -245,17 +242,18 @@ static int __init init_amu_fie(void)
>  			continue;
>  
>  		cpumask_set_cpu(cpu, valid_cpus);
> -		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
> +		enable_policy_freq_counters(cpu, valid_cpus);
>  	}
>  
>  	/*
> -	 * If we are not restricted by cpufreq policies, we only enable
> +	 * If none of the CPUs have cpufreq support, we only enable
>  	 * the use of the AMU feature for FIE if all CPUs support AMU.
>  	 * Otherwise, enable_policy_freq_counters has already enabled
>  	 * policy cpus.
>  	 */
> -	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
> -		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
> +	if (cpumask_empty(amu_fie_cpus) &&
> +	    cpumask_equal(valid_cpus, cpu_present_mask))
> +		cpumask_copy(amu_fie_cpus, cpu_present_mask);
>  

Yes, if you really don't like the have_policy variable, I would go for
your suggestion in the commit message for this condition and the removal
of the comment. In the form of the comment here it creates more confusion,
but your suggestion in the commit message hides all involvement of
policies in enable_policy_freq_counters().

Thanks,
Ionela.


>  	if (!cpumask_empty(amu_fie_cpus)) {
>  		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
