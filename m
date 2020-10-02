Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192992813DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgJBNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:16:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:6588 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgJBNQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:16:21 -0400
IronPort-SDR: 7MwdVxEVHHCltoCmBRgqZItCRfDUz+GJIDUlUjgyYLg8fIyitZ6zSoHA5jQJRd1fvtS+ZueduW
 WGm9MZRA84qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="150780754"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="150780754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 06:16:14 -0700
IronPort-SDR: 4e2vX31CQZITosRCOSPAx5m+ccIFxxvKmqmY2sYLyMMURNJxpKRVHNjt1PBxnLfOpoYqb4efDB
 x67brY+Rq4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="515156772"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2020 06:16:13 -0700
Received: from [10.254.99.126] (kliang2-MOBL.ccr.corp.intel.com [10.254.99.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BDEBC580601;
        Fri,  2 Oct 2020 06:16:12 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel: Fix n_metric for the canceled group
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kim.phillips@amd.com
References: <20200930142935.13482-1-kan.liang@linux.intel.com>
 <20201002110258.GV2628@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <fd79f565-2b5b-027a-eb46-b251e9cc9f18@linux.intel.com>
Date:   Fri, 2 Oct 2020 09:16:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002110258.GV2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2020 7:02 AM, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 07:29:35AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> When a group that has TopDown members is failed to be scheduled, any
>> later TopDown groups will not return valid values.
>>
>> Here is an example.
>>
>> A background perf that occupies all the GP counters and the fixed
>> counter 1.
>>   $perf stat -e "{cycles,cycles,cycles,cycles,cycles,cycles,cycles,
>>                   cycles,cycles}:D" -a
>>
>> A user monitors a TopDown group. It works well, because the fixed
>> counter 3 and the PERF_METRICS are available.
>>   $perf stat -x, --topdown -- ./workload
>>     retiring,bad speculation,frontend bound,backend bound,
>>     18.0,16.1,40.4,25.5,
>>
>> Then the user tries to monitor a group that has TopDown members.
>> Because of the cycles event, the group is failed to be scheduled.
>>   $perf stat -x, -e '{slots,topdown-retiring,topdown-be-bound,
>>                       topdown-fe-bound,topdown-bad-spec,cycles}'
>>                       -- ./workload
>>      <not counted>,,slots,0,0.00,,
>>      <not counted>,,topdown-retiring,0,0.00,,
>>      <not counted>,,topdown-be-bound,0,0.00,,
>>      <not counted>,,topdown-fe-bound,0,0.00,,
>>      <not counted>,,topdown-bad-spec,0,0.00,,
>>      <not counted>,,cycles,0,0.00,,
>>
>> The user tries to monitor a TopDown group again. It doesn't work anymore.
>>   $perf stat -x, --topdown -- ./workload
>>
>>      ,,,,,
>>
>> In a txn, cancel_txn() is to truncate the event_list for a canceled
>> group and update the number of events added in this transaction.
>> However, the number of TopDown events added in this transaction is not
>> updated. The kernel will probably fail to add new Topdown events.
>>
>> Check if the canceled group has Topdown events. If so, subtract the
>> TopDown events from n_metric accordingly.
>>
>> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
>> Reported-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/core.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 0f3d01562ded..4cb3ccbe2d62 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2017,6 +2017,7 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
>>   {
>>   	unsigned int txn_flags;
>>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	int i;
>>   
>>   	WARN_ON_ONCE(!cpuc->txn_flags);	/* no txn in flight */
>>   
>> @@ -2031,6 +2032,15 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
>>   	 */
>>   	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
>>   	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
>> +
>> +	/* Subtract Topdown events in the canceled group from n_metric */
>> +	if (x86_pmu.intel_cap.perf_metrics && cpuc->n_metric) {
>> +		for (i = 0; i < cpuc->n_txn; i++) {
>> +			if (is_metric_event(cpuc->event_list[i + cpuc->n_events]))
>> +				__this_cpu_dec(cpu_hw_events.n_metric);
>> +		}
>> +		WARN_ON_ONCE(__this_cpu_read(cpu_hw_events.n_metric) < 0);
>> +	}
>>   	perf_pmu_enable(pmu);
>>   }
> 
> 
> Urgh, I'd much rather we add n_txn_metric. But also, while looking at
> this, don't we have the same problem with n_pair ?
> 
> Something like this perhaps...
> 

Sure. For the perf metric, the below patch fixes the problem.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 757e49755e7c..9b7792c0b6fb 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1066,6 +1066,7 @@ static int add_nr_metric_event(struct cpu_hw_events *cpuc,
>   		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
>   			return -EINVAL;
>   		cpuc->n_metric++;
> +		cpuc->n_txn_metric++;
>   	}
>   
>   	return 0;
> @@ -1089,8 +1090,10 @@ static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
>   		return -EINVAL;
>   
>   	cpuc->event_list[n] = event;
> -	if (is_counter_pair(&event->hw))
> +	if (is_counter_pair(&event->hw)) {
>   		cpuc->n_pair++;
> +		cpuc->n_txn_pair++;
> +	}
>   
>   	return 0;
>   }
> @@ -2062,6 +2065,8 @@ static void x86_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
>   
>   	perf_pmu_disable(pmu);
>   	__this_cpu_write(cpu_hw_events.n_txn, 0);
> +	__this_cpu_write(cpu_hw_events.n_txn_metric, 0);
> +	__this_cpu_write(cpu_hw_events.n_txn_pair, 0);
>   }
>   
>   /*
> @@ -2087,6 +2092,8 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
>   	 */
>   	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
>   	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
> +	__this_cpu_sub(cpu_hw_events.n_metric, __this_cpu_read(cpu_hw_events.n_txn_metric));
> +	__this_cpu_sub(cpu_hw_events.n_pair, __this_cpu_read(cpu_hw_events.n_txn_pair));
>   	perf_pmu_enable(pmu);
>   }
>   
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 345442410a4d..6348105b6d30 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -235,6 +235,8 @@ struct cpu_hw_events {
>   					     they've never been enabled yet */
>   	int			n_txn;    /* the # last events in the below arrays;
>   					     added in the current transaction */
> +	int			n_txn_metric;
> +	int			n_txn_pair;
>   	int			assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
>   	u64			tags[X86_PMC_IDX_MAX];
>   
> 
