Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304C2DAC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgLOLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:54:09 -0500
Received: from foss.arm.com ([217.140.110.172]:36430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgLOLyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:54:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8682130E;
        Tue, 15 Dec 2020 03:53:23 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A8183F66E;
        Tue, 15 Dec 2020 03:53:22 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:53:21 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] arm64: topology: Reorder init_amu_fie() a bit
Message-ID: <20201215115321.GA25331@arm.com>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <87d517c24630494afd9ba5769c2e2b10ee1d3f5d.1608010334.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d517c24630494afd9ba5769c2e2b10ee1d3f5d.1608010334.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Dec 2020 at 11:04:15 (+0530), Viresh Kumar wrote:
> This patch does a couple of optimizations in init_amu_fie(), like early
> exits from paths where we don't need to continue any further, avoid the
> enable/disable dance, moving the calls to
> topology_scale_freq_invariant() just when we need them, instead of at
> the top of the routine, and avoiding calling it for the third time.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3:
> - Skipped the enable/disable dance.
> - No need to call topology_scale_freq_invariant() multiple times.
> 
>  arch/arm64/kernel/topology.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index ebadc73449f9..57267d694495 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -221,8 +221,8 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
>  
>  static int __init init_amu_fie(void)
>  {
> -	bool invariance_status = topology_scale_freq_invariant();
>  	cpumask_var_t valid_cpus;
> +	bool invariant;
>  	int ret = 0;
>  	int cpu;
>  
> @@ -249,18 +249,19 @@ static int __init init_amu_fie(void)
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
>  
> -	/*
> -	 * If the system is not fully invariant after AMU init, disable
> -	 * partial use of counters for frequency invariance.
> -	 */
> -	if (!topology_scale_freq_invariant())
> -		static_branch_disable(&amu_fie_key);
> +	invariant = topology_scale_freq_invariant();
> +
> +	/* We aren't fully invariant yet */
> +	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> +		goto free_valid_mask;
> +
> +	static_branch_enable(&amu_fie_key);
> +
> +	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> +		cpumask_pr_args(amu_fie_cpus));
>  
>  	/*
>  	 * Task scheduler behavior depends on frequency invariance support,
> @@ -268,7 +269,7 @@ static int __init init_amu_fie(void)
>  	 * a result of counter initialisation and use, retrigger the build of
>  	 * scheduling domains to ensure the information is propagated properly.
>  	 */
> -	if (invariance_status != topology_scale_freq_invariant())
> +	if (!invariant)
>  		rebuild_sched_domains_energy();
>  
>  free_valid_mask:
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

Looks good!

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
