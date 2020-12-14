Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B076C2D9956
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408065AbgLNOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:01:27 -0500
Received: from foss.arm.com ([217.140.110.172]:47812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgLNOB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:01:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFEC30E;
        Mon, 14 Dec 2020 06:00:40 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DAAF3F66E;
        Mon, 14 Dec 2020 06:00:40 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:00:38 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: topology: Reorder init_amu_fie() a bit
Message-ID: <20201214140038.GB15405@arm.com>
References: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
 <202f775d57bd143602f9100ba3d9619d15d43409.1607617625.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202f775d57bd143602f9100ba3d9619d15d43409.1607617625.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thursday 10 Dec 2020 at 21:59:23 (+0530), Viresh Kumar wrote:
> This patch does a couple of optimizations in init_amu_fie(), like early
> exits from paths where we don't need to continue any further, moving the
> calls to topology_scale_freq_invariant() just when we need
> them, instead of at the top of the routine, and avoiding calling it for
> the third time.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - The enable/disable dance is actually required, just made a bunch of
>   other optimizations to make it look better.
> 
>  arch/arm64/kernel/topology.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index ebadc73449f9..1ebdb667f0d1 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -221,7 +221,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
>  
>  static int __init init_amu_fie(void)
>  {
> -	bool invariance_status = topology_scale_freq_invariant();
> +	bool prev, now;

Nit: can you move this below valid_cpus? It makes the section nicer if
they are in decreasing order of line length.

>  	cpumask_var_t valid_cpus;
>  	int ret = 0;
>  	int cpu;
> @@ -249,18 +249,24 @@ static int __init init_amu_fie(void)
>  	if (cpumask_equal(valid_cpus, cpu_present_mask))
>  		cpumask_copy(amu_fie_cpus, cpu_present_mask);
>  
> -	if (!cpumask_empty(amu_fie_cpus)) {
> -		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> -			cpumask_pr_args(amu_fie_cpus));
> -		static_branch_enable(&amu_fie_key);
> -	}
> +	if (cpumask_empty(amu_fie_cpus))
> +		goto free_valid_mask;
> +
> +	prev = topology_scale_freq_invariant();
> +	static_branch_enable(&amu_fie_key);

I think there could be a potential problem here (it would be unlikely
but why not fix it :) ). It was in the code before your changes.

When we enable amu_fie_key here, topology_scale_freq_tick() could be
called for AMU CPUs, which will compute and set a scale factor. Later
on, if we happen to find the system not invariant, we disable counter
based invariance, but a scale factor might have been set already for a
CPU, which would and should have returned 1024 otherwise (the
initialisation value of freq_scale).


Therefore, while here, you could instead do the following:

cpufreq_inv = cpufreq_supports_freq_invariance();

if (!cpufreq_inv &&
    !cpumask_subset(cpu_online_mask, amu_fie_cpus))
    goto free_valid_mask;

static_branch_enable(&amu_fie_key);

pr_info(..);

if (!cpufreq_inv)
    rebuild_sched_domains_energy();

What do you think?

I can submit this separately, if you don't want the hassle.

Thanks,
Ionela.


> +	now = topology_scale_freq_invariant();
>  
>  	/*
>  	 * If the system is not fully invariant after AMU init, disable
>  	 * partial use of counters for frequency invariance.
>  	 */
> -	if (!topology_scale_freq_invariant())
> +	if (!now) {
>  		static_branch_disable(&amu_fie_key);
> +		goto free_valid_mask;
> +	}
> +
> +	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> +		cpumask_pr_args(amu_fie_cpus));
>  
>  	/*
>  	 * Task scheduler behavior depends on frequency invariance support,
> @@ -268,7 +274,7 @@ static int __init init_amu_fie(void)
>  	 * a result of counter initialisation and use, retrigger the build of
>  	 * scheduling domains to ensure the information is propagated properly.
>  	 */
> -	if (invariance_status != topology_scale_freq_invariant())
> +	if (prev != now)
>  		rebuild_sched_domains_energy();
>  
>  free_valid_mask:
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
