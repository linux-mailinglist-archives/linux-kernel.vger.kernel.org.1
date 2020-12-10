Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08622D57C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgLJJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:58:21 -0500
Received: from foss.arm.com ([217.140.110.172]:60540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgLJJ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:58:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64CE431B;
        Thu, 10 Dec 2020 01:57:16 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0527D3F718;
        Thu, 10 Dec 2020 01:57:15 -0800 (PST)
Date:   Thu, 10 Dec 2020 09:57:14 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Drop the useless update to per-cpu
 cycles
Message-ID: <20201210095714.GA13331@arm.com>
References: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Dec 2020 at 11:17:40 (+0530), Viresh Kumar wrote:
> The previous call to update_freq_counters_refs() has already updated the
> per-cpu variables, don't overwrite them with the same value again.
> 
> Fixes: 4b9cf23c179a ("arm64: wrap and generalise counter read functions")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index c8308befdb1e..f6faa697e83e 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -314,7 +314,7 @@ void topology_scale_freq_tick(void)
>  
>  	if (unlikely(core_cnt <= prev_core_cnt ||
>  		     const_cnt <= prev_const_cnt))
> -		goto store_and_exit;
> +		return;
>  
>  	/*
>  	 *	    /\core    arch_max_freq_scale
> @@ -331,10 +331,6 @@ void topology_scale_freq_tick(void)
>  
>  	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>  	this_cpu_write(freq_scale, (unsigned long)scale);
> -
> -store_and_exit:
> -	this_cpu_write(arch_core_cycles_prev, core_cnt);
> -	this_cpu_write(arch_const_cycles_prev, const_cnt);
>  }

Right, no need for this anymore!

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thank you for the fix,
Ionela.

>  
>  #ifdef CONFIG_ACPI_CPPC_LIB
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
