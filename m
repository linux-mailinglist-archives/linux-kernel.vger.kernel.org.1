Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD82AC57A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgKITwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:52:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:50692 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbgKITwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:52:06 -0500
IronPort-SDR: ta/XfLNxQvwgHJJ/K8ovNsYmI0TIgWzIzTpF/JUcPQpzfYB68ohF9qLp26XZVkTNrunBfvIGWR
 xYK2ZrXq8Tdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="234028378"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="234028378"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:52:06 -0800
IronPort-SDR: zzMUeXx4/CX4g14b8qsQbgnkQY6vTPSxofBrGUehwIFtHmg8KBBhTuSmeUhu8qFCXwdmwgo7UD
 2EbdVgFDikzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="355824600"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2020 11:52:05 -0800
Received: from [10.251.16.60] (kliang2-MOBL.ccr.corp.intel.com [10.251.16.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D010D580AE3;
        Mon,  9 Nov 2020 11:52:03 -0800 (PST)
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net>
 <20201109110405.GN2651@hirez.programming.kicks-ass.net>
 <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
 <20201109173300.GM2611@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <464c6219-ff34-7470-d941-fe6560cb9e56@linux.intel.com>
Date:   Mon, 9 Nov 2020 14:52:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109173300.GM2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2020 12:33 PM, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:
>>> Maybe we can frob x86_pmu_enable()...
>>
>> Could you please elaborate?
> 
> Something horrible like this. It will detect the first time we enable
> the PMU on a new task (IOW we did a context switch) and wipe the
> counters when user RDPMC is on...
>

Oh, you mean the RDPMC patch. It should be doable, but I think 
sched_task() may be a better place, especially with the new optimization 
(patch 3). We can set PERF_SCHED_CB_SW_IN bit for the case, so we only 
do the check for per-task events in sched in.

It looks like the below patch has to unconditionally do the check (even 
for the non-RDPMC cases), which should be unnecessary.

Anyway, I think the RDPMC patch should depend on the implementation of 
the sched_task(). We may have further discussion when the design of 
sched_task() is finalized.


Thanks,
Kan

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 77b963e5e70a..d862927baaef 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1289,6 +1289,15 @@ static void x86_pmu_enable(struct pmu *pmu)
>   		perf_events_lapic_init();
>   	}
>   
> +	if (cpuc->current != current) {
> +		struct mm_struct *mm = current->mm;
> +
> +		cpuc->current = current;
> +
> +		if (mm && atomic_read(&mm->context.perf_rdpmc_allowed))
> +			wipe_dirty_counters();
> +	}
> +
>   	cpuc->enabled = 1;
>   	barrier();
>   
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 7895cf4c59a7..d16118cb3bd0 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -248,6 +248,8 @@ struct cpu_hw_events {
>   	unsigned int		txn_flags;
>   	int			is_fake;
>   
> +	void			*current;
> +
>   	/*
>   	 * Intel DebugStore bits
>   	 */
> 
