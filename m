Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062942A8146
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgKEOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:48:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:8769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731263AbgKEOsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:11 -0500
IronPort-SDR: rIsBgqFWbgyLxJt0eS0OgxTuWuWZMRndPx8h3wMDnD+2l2Xp2qhzIKPX8C3bX0rmVKAl+qW+eq
 ex1QhQf6MOvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="166800268"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="166800268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 06:48:08 -0800
IronPort-SDR: 4DZINz9tnz7jPG1NfF/Y8Nl/ukT8yK1dUIL/Xu4AWyEVSXO7ZFtPIAeEQAFavdiR3mvrFtLp/p
 aANgJN8WOi6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="364361415"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2020 06:48:08 -0800
Received: from [10.254.97.216] (kliang2-MOBL.ccr.corp.intel.com [10.254.97.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 489CD58073D;
        Thu,  5 Nov 2020 06:48:07 -0800 (PST)
Subject: Re: [RFC 2/2] perf/core: Invoke pmu::sched_task callback for per-cpu
 events
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
References: <20201102145221.309001-1-namhyung@kernel.org>
 <20201102145221.309001-3-namhyung@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <03ba0d07-45bb-0849-1843-915b6873478f@linux.intel.com>
Date:   Thu, 5 Nov 2020 09:48:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201102145221.309001-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2020 9:52 AM, Namhyung Kim wrote:
> The commit 44fae179ce73 ("perf/core: Pull pmu::sched_task() into
> perf_event_context_sched_out()") moved the pmu::sched_task callback to
> be called for task event context.  But it missed to call it for
> per-cpu events to flush PMU internal buffers (i.e. for PEBS, ...).
> 
> This commit basically reverts the commit but keeps the optimization
> for task events and only add missing calls for cpu events.
> 
> Fixes: 44fae179ce73 ("perf/core: Pull pmu::sched_task() into perf_event_context_sched_out()") > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   include/linux/perf_event.h |  1 +
>   kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++--
>   2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0defb526cd0c..abb70a557cb5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -872,6 +872,7 @@ struct perf_cpu_context {
>   	struct list_head		cgrp_cpuctx_entry;
>   #endif
>   
> +	struct list_head		sched_cb_entry;
>   	int				sched_cb_usage;
>   
>   	int				online;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aaa0155c4142..c04d9a913537 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -383,6 +383,7 @@ static DEFINE_MUTEX(perf_sched_mutex);
>   static atomic_t perf_sched_count;
>   
>   static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
> +static DEFINE_PER_CPU(int, perf_sched_cb_usages);
>   static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
>   
>   static atomic_t nr_mmap_events __read_mostly;
> @@ -3480,11 +3481,16 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>   	}
>   }
>   
> +static DEFINE_PER_CPU(struct list_head, sched_cb_list);
> +
>   void perf_sched_cb_dec(struct pmu *pmu)
>   {
>   	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>   
> -	--cpuctx->sched_cb_usage;
> +	this_cpu_dec(perf_sched_cb_usages);
> +
> +	if (!--cpuctx->sched_cb_usage)
> +		list_del(&cpuctx->sched_cb_entry);
>   }
>   
>   
> @@ -3492,7 +3498,10 @@ void perf_sched_cb_inc(struct pmu *pmu)
>   {
>   	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>   
> -	cpuctx->sched_cb_usage++;
> +	if (!cpuctx->sched_cb_usage++)
> +		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
> +
> +	this_cpu_inc(perf_sched_cb_usages);
>   }
>   
>   /*
> @@ -3521,6 +3530,24 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
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
> @@ -3543,6 +3570,9 @@ void __perf_event_task_sched_out(struct task_struct *task,
>   {
>   	int ctxn;
>   
> +	if (__this_cpu_read(perf_sched_cb_usages))
> +		perf_pmu_sched_task(task, next, false);
> +
>   	if (atomic_read(&nr_switch_events))
>   		perf_event_switch(task, next, false);
>   
> @@ -3850,6 +3880,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
>   
>   	if (atomic_read(&nr_switch_events))
>   		perf_event_switch(task, prev, true);
> +
> +	if (__this_cpu_read(perf_sched_cb_usages))
> +		perf_pmu_sched_task(prev, task, true);
>   }

It looks like the ("perf/core: Pull pmu::sched_task() into 
perf_event_context_sched_in()") is also reverted in the patch.

>   
>   static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
> @@ -12999,6 +13032,7 @@ static void __init perf_event_init_all_cpus(void)
>   #ifdef CONFIG_CGROUP_PERF
>   		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
>   #endif
> +		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
>   	}
>   }
>   
> 

Can we only update the perf_sched_cb_usages and sched_cb_list for 
per-cpu event as below patch (not tested)?

If user only uses the per-process event, we don't need to go through the 
list.


diff --git a/arch/powerpc/perf/core-book3s.c 
b/arch/powerpc/perf/core-book3s.c
index 6586f7e71cfb..63c9b87cab5e 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -380,7 +380,7 @@ static void power_pmu_bhrb_enable(struct perf_event 
*event)
  		cpuhw->bhrb_context = event->ctx;
  	}
  	cpuhw->bhrb_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->ctx->pmu, !(event->attach_state & 
PERF_ATTACH_TASK));
  }

  static void power_pmu_bhrb_disable(struct perf_event *event)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 444e5f061d04..a34b90c7fa6d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1022,9 +1022,9 @@ pebs_update_state(bool needed_cb, struct 
cpu_hw_events *cpuc,

  	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
  		if (!needed_cb)
-			perf_sched_cb_inc(pmu);
+			perf_sched_cb_inc(pmu, !(event->attach_state & PERF_ATTACH_TASK));
  		else
-			perf_sched_cb_dec(pmu);
+			perf_sched_cb_dec(pmu, !(event->attach_state & PERF_ATTACH_TASK));

  		update = true;
  	}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..8d4d02cde3d4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -693,7 +693,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
  	 */
  	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
  		cpuc->lbr_pebs_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->ctx->pmu, !(event->attach_state & 
PERF_ATTACH_TASK));
  	if (!cpuc->lbr_users++ && !event->total_time_running)
  		intel_pmu_lbr_reset();

@@ -740,7 +740,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
  	cpuc->lbr_users--;
  	WARN_ON_ONCE(cpuc->lbr_users < 0);
  	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->ctx->pmu, !(event->attach_state & 
PERF_ATTACH_TASK));
  }

  static inline bool vlbr_exclude_host(void)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index abb70a557cb5..5a02239ca8fd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -966,8 +966,8 @@ extern const struct perf_event_attr 
*perf_event_attrs(struct perf_event *event);
  extern void perf_event_print_debug(void);
  extern void perf_pmu_disable(struct pmu *pmu);
  extern void perf_pmu_enable(struct pmu *pmu);
-extern void perf_sched_cb_dec(struct pmu *pmu);
-extern void perf_sched_cb_inc(struct pmu *pmu);
+extern void perf_sched_cb_dec(struct pmu *pmu, bool systemwide);
+extern void perf_sched_cb_inc(struct pmu *pmu, bool systemwide);
  extern int perf_event_task_disable(void);
  extern int perf_event_task_enable(void);

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e6b98507734a..2d7c07af02f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3484,25 +3484,29 @@ static void perf_event_context_sched_out(struct 
task_struct *task, int ctxn,

  static DEFINE_PER_CPU(struct list_head, sched_cb_list);

-void perf_sched_cb_dec(struct pmu *pmu)
+void perf_sched_cb_dec(struct pmu *pmu, bool systemwide)
  {
  	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);

-	this_cpu_dec(perf_sched_cb_usages);
+	--cpuctx->sched_cb_usage;

-	if (!--cpuctx->sched_cb_usage)
+	if (systemwide) {
+		this_cpu_dec(perf_sched_cb_usages);
  		list_del(&cpuctx->sched_cb_entry);
+	}
  }


-void perf_sched_cb_inc(struct pmu *pmu)
+void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
  {
  	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);

-	if (!cpuctx->sched_cb_usage++)
-		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+	cpuctx->sched_cb_usage++;

-	this_cpu_inc(perf_sched_cb_usages);
+	if (systemwide) {
+		this_cpu_inc(perf_sched_cb_usages);
+		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+	}
  }

  /*

Thanks,
Kan
