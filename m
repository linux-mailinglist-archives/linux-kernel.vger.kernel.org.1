Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777D12DA6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 04:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgLODif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 22:38:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:20811 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgLODiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:38:25 -0500
IronPort-SDR: zxaYf55MEynG2ESS5Cm1+u9Io0fRzn8GhxGcUiboorL7BMwKUkgWHwx357Yuk8dOEb4ZW/aqtb
 eV9JpubLPvuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174929745"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="174929745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 19:36:39 -0800
IronPort-SDR: gA0/KtfqVgSUqvHYRUw0Hbv2zHiYM3zKDsZMvmi+fYGPoYKTBGH6ed4l0vLsnICWehndUpmNWI
 KgOrIlzwaqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="383023280"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2020 19:36:36 -0800
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
To:     Peter Zijlstra <peterz@infradead.org>, mgorman@techsingularity.net,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com, benbjiang@gmail.com
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
Date:   Tue, 15 Dec 2020 11:36:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201214170017.877557652@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/15 0:48, Peter Zijlstra wrote:
> We compute the average cost of the total scan, but then use it as a
> per-cpu scan cost when computing the scan proportion. Fix this by
> properly computing a per-cpu scan cost.
> 
> This also fixes a bug where we would terminate early (!--nr, case) and
> not account that cost at all.

I'm a bit worried this may introduce a regression under heavy load.
The overhead of adding another cpu_clock() and calculation becomes 
significant when sis_scan is throttled by nr.

I'm not sure if it's a good idea to not account the scan cost at all
when sis_scan is throttled, that is, remove the first cpu_clock() as
well. The avg scan cost remains the value when the system is not very
busy, and when the load comes down and span avg idle > span avg cost,
we account the cost again. This should make select_idle_cpu() a bit
faster when the load is very high.

Thanks,
-Aubrey
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6144,10 +6144,10 @@ static inline int select_idle_smt(struct
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	int cpu, loops = 1, nr = INT_MAX;
> +	int this = smp_processor_id();
>  	struct sched_domain *this_sd;
>  	u64 time;
> -	int this = smp_processor_id();
> -	int cpu, nr = INT_MAX;
>  
>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6175,14 +6175,19 @@ static int select_idle_cpu(struct task_s
>  	}
>  
>  	for_each_cpu_wrap(cpu, cpus, target) {
> -		if (!--nr)
> -			return -1;
>  		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>  			break;
> +
> +		if (loops >= nr) {
> +			cpu = -1;
> +			break;
> +		}
> +		loops++;
>  	}
>  
>  	if (sched_feat(SIS_PROP)) {
>  		time = cpu_clock(this) - time;
> +		time = div_u64(time, loops);
>  		update_avg(&this_sd->avg_scan_cost, time);
>  	}
>  
> 
> 

