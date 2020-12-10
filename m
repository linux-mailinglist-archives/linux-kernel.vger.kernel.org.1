Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA72D58F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgLJLKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:10:02 -0500
Received: from foss.arm.com ([217.140.110.172]:35616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732271AbgLJLJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:09:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5C630E;
        Thu, 10 Dec 2020 03:09:08 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABE13F718;
        Thu, 10 Dec 2020 03:09:08 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:09:06 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Avoid the
 static_branch_{enable|disable} dance
Message-ID: <20201210110906.GA5300@arm.com>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <10396de8046ada347d681eb84ea4dc6ec27e1742.1607593250.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10396de8046ada347d681eb84ea4dc6ec27e1742.1607593250.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Dec 2020 at 15:12:25 (+0530), Viresh Kumar wrote:
> Avoid the static_branch_enable() and static_branch_disable() dance by
> redoing the code in a different way. We will be fully invariant here
> only if amu_fie_cpus is set with all present CPUs, use that instead of
> yet another call to topology_scale_freq_invariant().
> 
> This also avoids running rest of the routine if we enabled the static
> branch, followed by a disable.
> 
> Also make the first call to topology_scale_freq_invariant() just when we
> need it, instead of at the top of the routine. This makes it further
> clear on why we need it, i.e. just around enabling AMUs use here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 7f7d8de325b6..6dedc6ee91cf 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -221,7 +221,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
>  
>  static int __init init_amu_fie(void)
>  {
> -	bool invariance_status = topology_scale_freq_invariant();
> +	bool invariance_status;
>  	cpumask_var_t valid_cpus;
>  	int ret = 0;
>  	int cpu;
> @@ -255,18 +255,15 @@ static int __init init_amu_fie(void)
>  	    cpumask_equal(valid_cpus, cpu_present_mask))
>  		cpumask_copy(amu_fie_cpus, cpu_present_mask);
>  
> -	if (!cpumask_empty(amu_fie_cpus)) {
> -		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> -			cpumask_pr_args(amu_fie_cpus));
> -		static_branch_enable(&amu_fie_key);
> -	}

This check verifies if there are *any* CPUs for which AMUs can be used for
FIE (!empty mask) -> enable static key.

> +	/* Disallow partial use of counters for frequency invariance */
> +	if (!cpumask_equal(amu_fie_cpus, cpu_present_mask))
> +		goto free_valid_mask;
>  

The replacement verifies if *all* present CPUs support AMUs for FIE and
only then it enables the static key.

Ionela.

> -	/*
> -	 * If the system is not fully invariant after AMU init, disable
> -	 * partial use of counters for frequency invariance.
> -	 */
> -	if (!topology_scale_freq_invariant())
> -		static_branch_disable(&amu_fie_key);
> +	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> +		cpumask_pr_args(amu_fie_cpus));
> +
> +	invariance_status = topology_scale_freq_invariant();
> +	static_branch_enable(&amu_fie_key);
>  
>  	/*
>  	 * Task scheduler behavior depends on frequency invariance support,
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
