Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180152D5316
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgLJFTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:19:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:55322 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgLJFTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:19:54 -0500
IronPort-SDR: rxy2SVqDq4P3mQtF/ScCN/j0mjoDcV/Gfn1Zg/Bjn1V/g6QSYtaPcVc9mebfJZGHn9EQ76jcAG
 3lm6B/tIX1zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="154005495"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="154005495"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 21:18:08 -0800
IronPort-SDR: vYiZw4aafPvsqj01p2l/4jFqU3PZ7yefYFIVT1kHVMg21klL1Sp8S2BnPTtUrFf6MMeb1Ymj7F
 Y2kPKlMvxhPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="368633393"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 21:18:06 -0800
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under
 SIS_PROP
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-3-mgorman@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <1963d0ca-054c-19f9-94e0-d019a2e8e259@linux.intel.com>
Date:   Thu, 10 Dec 2020 13:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201208153501.1467-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/8 23:34, Mel Gorman wrote:
> As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
> even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
> check and while we are at it, exclude the cost of initialising the CPU
> mask from the average scan cost.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ac7b34e7372b..5c41875aec23 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	if (!this_sd)
>  		return -1;
>  
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
>  	if (sched_feat(SIS_PROP)) {
>  		u64 avg_cost, avg_idle, span_avg;
>  
> @@ -6168,11 +6170,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  			nr = div_u64(span_avg, avg_cost);
>  		else
>  			nr = 4;
> -	}
> -
> -	time = cpu_clock(this);
>  
> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +		time = cpu_clock(this);
> +	}
>  
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
>			return -1;

I thought about this again and here seems not to be consistent:
- even if nr reduces to 0, shouldn't avg_scan_cost be updated as well before return -1?
- if avg_scan_cost is not updated because nr is throttled, the first 
	time = cpu_clock(this);
  can be optimized. As nr is calculated and we already know which of the weight of cpumask and nr is greater.

Thanks,
-Aubrey
