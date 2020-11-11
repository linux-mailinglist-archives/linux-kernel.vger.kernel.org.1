Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601D02AF950
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKKTyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:54:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:19427 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKTyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:54:08 -0500
IronPort-SDR: Cn/GHU4V5fXmapfaCVy2vn8wOxIMj3M9sxonWrXFBBXcV8hJ08CCBg3zy2Megn7/21DkJtf+uF
 0EjWTyJcgPKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="157984676"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="157984676"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 11:54:07 -0800
IronPort-SDR: OUMZNIbaRk2N52sXGiZ8ntvwb5iWdzrX6HEiU37fZB/VQqJyvLQgHOo7A6Pu4bnWqe1hibtSn0
 cWQ0ljN2cDJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="428918388"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2020 11:54:07 -0800
Received: from [10.254.99.45] (kliang2-MOBL.ccr.corp.intel.com [10.254.99.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1CB04580B99;
        Wed, 11 Nov 2020 11:54:06 -0800 (PST)
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
 <20201111162509.GW2611@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2dc483f6-7b29-c42b-13a4-4c549d720aa2@linux.intel.com>
Date:   Wed, 11 Nov 2020 14:54:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111162509.GW2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2020 11:25 AM, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:
> 
>> - When the large PEBS was introduced (9c964efa4330), the sched_task() should
>> be invoked to flush the PEBS buffer in each context switch. However, The
>> perf_sched_events in account_event() is not updated accordingly. The
>> perf_event_task_sched_* never be invoked for a pure per-CPU context. Only
>> per-task event works.
>>     At that time, the perf_pmu_sched_task() is outside of
>> perf_event_context_sched_in/out. It means that perf has to double
>> perf_pmu_disable() for per-task event.
> 
>> - The patch 1 tries to fix broken per-CPU events. The CPU context cannot be
>> retrieved from the task->perf_event_ctxp. So it has to be tracked in the
>> sched_cb_list. Yes, the code is very similar to the original codes, but it
>> is actually the new code for per-CPU events. The optimization for per-task
>> events is still kept.
>>    For the case, which has both a CPU context and a task context, yes, the
>> __perf_pmu_sched_task() in this patch is not invoked. Because the
>> sched_task() only need to be invoked once in a context switch. The
>> sched_task() will be eventually invoked in the task context.
> 
> The thing is; your first two patches rely on PERF_ATTACH_SCHED_CB and
> only set that for large pebs. Are you sure the other users (Intel LBR
> and PowerPC BHRB) don't need it?

I didn't set it for LBR, because the perf_sched_events is always enabled 
for LBR. But, yes, we should explicitly set the PERF_ATTACH_SCHED_CB 
for LBR.

	if (has_branch_stack(event))
		inc = true;

> 
> If they indeed do not require the pmu::sched_task() callback for CPU
> events, then I still think the whole perf_sched_cb_{inc,dec}() interface

No, LBR requires the pmu::sched_task() callback for CPU events.

Now, The LBR registers have to be reset in sched in even for CPU events.

To fix the shorter LBR callstack issue for CPU events, we also need to 
save/restore LBRs in pmu::sched_task().
https://lore.kernel.org/lkml/1578495789-95006-4-git-send-email-kan.liang@linux.intel.com/

> is confusing at best.
> 
> Can't we do something like this instead?
> 
I think the below patch may have two issues.
- PERF_ATTACH_SCHED_CB is required for LBR (maybe PowerPC BHRB as well) now.
- We may disable the large PEBS later if not all PEBS events support 
large PEBS. The PMU need a way to notify the generic code to decrease 
the nr_sched_task.

The current related code in Intel PMU is as below.

static void
pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
		  struct perf_event *event, bool add)
{
	struct pmu *pmu = event->ctx->pmu;
	/*
	 * Make sure we get updated with the first PEBS
	 * event. It will trigger also during removal, but
	 * that does not hurt:
	 */
	bool update = cpuc->n_pebs == 1;

	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
		if (!needed_cb)
			perf_sched_cb_inc(pmu);
		else
			perf_sched_cb_dec(pmu);

		update = true;
	}

Thanks,
Kan

> ---
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 546cc89217bb..672d6f039fce 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3565,8 +3565,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>   		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
>   			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>   			if (!(event->attr.sample_type &
> -			      ~intel_pmu_large_pebs_flags(event)))
> +			      ~intel_pmu_large_pebs_flags(event))) {
>   				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
> +				event->attach_state |= PERF_ATTACH_SCHED_CB;
> +			}
>   		}
>   		if (x86_pmu.pebs_aliases)
>   			x86_pmu.pebs_aliases(event);
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 9a38f579bc76..af9ee539c179 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -606,6 +606,7 @@ struct swevent_hlist {
>   #define PERF_ATTACH_TASK	0x04
>   #define PERF_ATTACH_TASK_DATA	0x08
>   #define PERF_ATTACH_ITRACE	0x10
> +#define PERF_ATTACH_SCHED_CB	0x20
>   
>   struct perf_cgroup;
>   struct perf_buffer;
> @@ -817,6 +818,7 @@ struct perf_event_context {
>   	int				is_active;
>   	int				nr_stat;
>   	int				nr_freq;
> +	int				nr_sched_task;
>   	int				rotate_disable;
>   	/*
>   	 * Set when nr_events != nr_active, except tolerant to events not
> @@ -872,7 +874,7 @@ struct perf_cpu_context {
>   	struct list_head		cgrp_cpuctx_entry;
>   #endif
>   
> -	int				sched_cb_usage;
> +	struct list_head		sched_cb_entry;
>   
>   	int				online;
>   	/*
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d2f3ca792936..0a5dfed6bb46 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -384,6 +384,7 @@ static DEFINE_MUTEX(perf_sched_mutex);
>   static atomic_t perf_sched_count;
>   
>   static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
> +static DEFINE_PER_CPU(int, perf_sched_cb_usage);
>   static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
>   
>   static atomic_t nr_mmap_events __read_mostly;
> @@ -2292,6 +2293,12 @@ event_sched_out(struct perf_event *event,
>   		perf_event_ctx_deactivate(ctx);
>   	if (event->attr.freq && event->attr.sample_freq)
>   		ctx->nr_freq--;
> +	if (event->attach_state & PERF_ATTACH_SCHED_CB) {
> +		if (!--ctx->nr_sched_task && &cpuctx->ctx == ctx) {
> +			list_del(&cpuctx->sched_cb_entry);
> +			this_cpu_dec(perf_sched_cb_usage);
> +		}
> +	}
>   	if (event->attr.exclusive || !cpuctx->active_oncpu)
>   		cpuctx->exclusive = 0;
>   
> @@ -2564,6 +2571,12 @@ event_sched_in(struct perf_event *event,
>   		perf_event_ctx_activate(ctx);
>   	if (event->attr.freq && event->attr.sample_freq)
>   		ctx->nr_freq++;
> +	if (event->attach_state & PERF_ATTACH_SCHED_CB) {
> +		if (!ctx->nr_sched_task++ && &cpuctx->ctx == ctx) {
> +			list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
> +			this_cpu_inc(perf_sched_cb_usage);
> +		}
> +	}
>   
>   	if (event->attr.exclusive)
>   		cpuctx->exclusive = 1;
> @@ -3424,7 +3437,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>   
>   			perf_pmu_disable(pmu);
>   
> -			if (cpuctx->sched_cb_usage && pmu->sched_task)
> +			if (ctx->nr_sched_task)
>   				pmu->sched_task(ctx, false);
>   
>   			/*
> @@ -3464,7 +3477,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>   		raw_spin_lock(&ctx->lock);
>   		perf_pmu_disable(pmu);
>   
> -		if (cpuctx->sched_cb_usage && pmu->sched_task)
> +		if (ctx->nr_sched_task)
>   			pmu->sched_task(ctx, false);
>   		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
>   
> @@ -3473,20 +3486,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>   	}
>   }
>   
> -void perf_sched_cb_dec(struct pmu *pmu)
> -{
> -	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> -
> -	--cpuctx->sched_cb_usage;
> -}
> -
> -
> -void perf_sched_cb_inc(struct pmu *pmu)
> -{
> -	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> -
> -	cpuctx->sched_cb_usage++;
> -}
> +static DEFINE_PER_CPU(struct list_head, sched_cb_list);
>   
>   /*
>    * This function provides the context switch callback to the lower code
> @@ -3514,6 +3514,24 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
>   	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>   }
>   
> +static void perf_pmu_sched_task(struct task_struct *prev,
> +				struct task_struct *next,
> +				bool sched_in)
> +{
> +	struct perf_cpu_context *cpuctx;
> +
> +	if (prev == next)
> +		return;
> +
> +	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
> +		/* will be handled in perf_event_context_sched_in/out */
> +		if (cpuctx->task_ctx)
> +			continue;
> +
> +		__perf_pmu_sched_task(cpuctx, sched_in);
> +	}
> +}
> +
>   static void perf_event_switch(struct task_struct *task,
>   			      struct task_struct *next_prev, bool sched_in);
>   
> @@ -3536,6 +3554,9 @@ void __perf_event_task_sched_out(struct task_struct *task,
>   {
>   	int ctxn;
>   
> +	if (__this_cpu_read(perf_sched_cb_usage))
> +		perf_pmu_sched_task(task, next, false);
> +
>   	if (atomic_read(&nr_switch_events))
>   		perf_event_switch(task, next, false);
>   
> @@ -3772,7 +3793,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
>   
>   	cpuctx = __get_cpu_context(ctx);
>   	if (cpuctx->task_ctx == ctx) {
> -		if (cpuctx->sched_cb_usage)
> +		if (ctx->nr_sched_task)
>   			__perf_pmu_sched_task(cpuctx, true);
>   		return;
>   	}
> @@ -3798,8 +3819,8 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
>   		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>   	perf_event_sched_in(cpuctx, ctx, task);
>   
> -	if (cpuctx->sched_cb_usage && pmu->sched_task)
> -		pmu->sched_task(cpuctx->task_ctx, true);
> +	if (ctx->nr_sched_task)
> +		pmu->sched_task(ctx, true);
>   
>   	perf_pmu_enable(pmu);
>   
> @@ -3844,6 +3865,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
>   
>   	if (atomic_read(&nr_switch_events))
>   		perf_event_switch(task, prev, true);
> +
> +	if (__this_cpu_read(perf_sched_cb_usage))
> +		perf_pmu_sched_task(prev, task, true);
>   }
>   
>   static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
> @@ -4668,7 +4692,7 @@ static void unaccount_event(struct perf_event *event)
>   	if (event->parent)
>   		return;
>   
> -	if (event->attach_state & PERF_ATTACH_TASK)
> +	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
>   		dec = true;
>   	if (event->attr.mmap || event->attr.mmap_data)
>   		atomic_dec(&nr_mmap_events);
> @@ -11195,7 +11219,7 @@ static void account_event(struct perf_event *event)
>   	if (event->parent)
>   		return;
>   
> -	if (event->attach_state & PERF_ATTACH_TASK)
> +	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
>   		inc = true;
>   	if (event->attr.mmap || event->attr.mmap_data)
>   		atomic_inc(&nr_mmap_events);
> @@ -12987,6 +13011,7 @@ static void __init perf_event_init_all_cpus(void)
>   #ifdef CONFIG_CGROUP_PERF
>   		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
>   #endif
> +		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
>   	}
>   }
>   
> 
