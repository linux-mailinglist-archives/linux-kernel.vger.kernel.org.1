Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A22F9B14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbhARIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:16:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:4440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbhARIQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:16:31 -0500
IronPort-SDR: GphGWMlzH8kAydya9wJEiZxu1AsdefYRmDK3KwkMiJ+O3Qy9lrIRlpm11ft4deyFlXoB23MVFN
 pcgw62Ai1dFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="178858764"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="178858764"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 00:14:41 -0800
IronPort-SDR: XIDnbbshtYmYF2VwX7P7oQN9JVWobXBnovfjFlRsfyUKaVCXYqBI7skhFdp6fjRbyjZjFATABq
 bdJoxLQJ2EmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="406148235"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2021 00:14:37 -0800
Subject: Re: [PATCH 3/5] sched/fair: Make select_idle_cpu() proportional to
 cores
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210115100855.23679-1-mgorman@techsingularity.net>
 <20210115100855.23679-4-mgorman@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <f9036411-39d0-2c28-aec5-5e185d01d3f0@linux.intel.com>
Date:   Mon, 18 Jan 2021 16:14:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115100855.23679-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/15 18:08, Mel Gorman wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Instead of calculating how many (logical) CPUs to scan, compute how
> many cores to scan.
> 
> This changes behaviour for anything !SMT2.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/core.c  | 18 +++++++++++++-----
>  kernel/sched/fair.c  | 12 ++++++++++--
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 15d2562118d1..ada8faac2e4d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7444,11 +7444,19 @@ int sched_cpu_activate(unsigned int cpu)
>  	balance_push_set(cpu, false);
>  
>  #ifdef CONFIG_SCHED_SMT
> -	/*
> -	 * When going up, increment the number of cores with SMT present.
> -	 */
> -	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> -		static_branch_inc_cpuslocked(&sched_smt_present);
> +	do {
> +		int weight = cpumask_weight(cpu_smt_mask(cpu));
> +
> +		if (weight > sched_smt_weight)
> +			sched_smt_weight = weight;
> +
> +		/*
> +		 * When going up, increment the number of cores with SMT present.
> +		 */
> +		if (weight == 2)
> +			static_branch_inc_cpuslocked(&sched_smt_present);
> +
> +	} while (0);
>  #endif
>  	set_cpu_active(cpu, true);
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8d8e185cf3b..0811e2fe4f19 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6010,6 +6010,8 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
>  
> +int sched_smt_weight __read_mostly = 1;
> +
>  static inline void set_idle_cores(int cpu, int val)
>  {
>  	struct sched_domain_shared *sds;
> @@ -6124,6 +6126,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>  
>  #else /* CONFIG_SCHED_SMT */
>  
> +#define sched_smt_weight	1
> +
>  static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	return -1;
> @@ -6136,6 +6140,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>  
>  #endif /* CONFIG_SCHED_SMT */
>  
> +#define sis_min_cores		2
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		avg_cost = this_sd->avg_scan_cost + 1;
>  
>  		span_avg = sd->span_weight * avg_idle;
> -		if (span_avg > 4*avg_cost)
> +		if (span_avg > sis_min_cores*avg_cost)
>  			nr = div_u64(span_avg, avg_cost);
>  		else
> -			nr = 4;
> +			nr = sis_min_cores;
> +
> +		nr *= sched_smt_weight;

Is it better to put this into an inline wrapper to hide sched_smt_weight if !CONFIG_SCHED_SMT?

Thanks,
-Aubrey
