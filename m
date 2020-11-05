Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27442A8A86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbgKEXMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:12:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:56354 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731965AbgKEXMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:12:24 -0500
IronPort-SDR: MxGYkCWamFzLimN6DYr72QuIFN4zMFBpjZtRNAPaNhaoRHpaB2CfUBlz9dswBk+Y1uC5Pm9tBm
 B/7SidRdyMNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="168693055"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="168693055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 15:12:23 -0800
IronPort-SDR: +twelmeLZZgvFDlsRF4N6G7jVNOhVOzgh4GwjqzLz9G4vHwfsKDsPFrUKpmIF9CHDw5MGmvn3K
 AgyRGZyImG0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="358605167"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2020 15:12:23 -0800
Received: from [10.254.97.216] (kliang2-MOBL.ccr.corp.intel.com [10.254.97.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 958E0580841;
        Thu,  5 Nov 2020 15:12:22 -0800 (PST)
Subject: Re: [RFC 2/2] perf/core: Invoke pmu::sched_task callback for per-cpu
 events
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
References: <20201102145221.309001-1-namhyung@kernel.org>
 <20201102145221.309001-3-namhyung@kernel.org>
 <03ba0d07-45bb-0849-1843-915b6873478f@linux.intel.com>
 <CAM9d7cgwmXmyUd4Y==F120BsAx2iWw6h9D+BB6D_FDw1-7SxBw@mail.gmail.com>
 <bd97ab7c-039c-b968-3008-8bcd51700c8c@linux.intel.com>
 <CABPqkBSJPyE0txSgRzRVucMjd+X1XyUiGe141Kcn1y3v7G9k=g@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d86b24aa-2887-0e29-2221-925acef77f8d@linux.intel.com>
Date:   Thu, 5 Nov 2020 18:12:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CABPqkBSJPyE0txSgRzRVucMjd+X1XyUiGe141Kcn1y3v7G9k=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2020 4:15 PM, Stephane Eranian wrote:
> On Thu, Nov 5, 2020 at 11:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 11/5/2020 10:54 AM, Namhyung Kim wrote:
>>>> -void perf_sched_cb_inc(struct pmu *pmu)
>>>> +void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
>>>>     {
>>>>           struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>>>>
>>>> -       if (!cpuctx->sched_cb_usage++)
>>>> -               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
>>>> +       cpuctx->sched_cb_usage++;
>>>>
>>>> -       this_cpu_inc(perf_sched_cb_usages);
>>>> +       if (systemwide) {
>>>> +               this_cpu_inc(perf_sched_cb_usages);
>>>> +               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
>>> You need to check the value and make sure it's added only once.
>>
>> Right, maybe we have to add a new variable for that.
>>
> Sure, I tend to agree here that we need a narrower scope trigger, only
> when needed, i.e., an event
> or PMU feature that requires ctxsw work. In fact, I am also interested
> in splitting ctxswin and ctswout
> callbacks. The reason is that you have overhead in the way the
> callback is invoked. You may end up
> calling the sched_task on ctxswout when only ctxwin is needed. In
> doing that you pay the cost of
> stopping/starting the PMU for possibly nothing. Stopping the PMU can
> be expensive, like on AMD
> where you need multiple wrmsr.
> 
> So splitting or adding a flag to convey that either CTXSW_IN or
> CTXSW_OUT is needed would help.
> I am suggesting this now given you are adding a flag.
> 

Yes, adding a new flag would avoid the unnecessary PMU stop/restart for 
both per-cpu and per-process event.

How about the patch as below?
(Just did simple test. Should need another patch to split the callback.)

diff --git a/arch/powerpc/perf/core-book3s.c 
b/arch/powerpc/perf/core-book3s.c
index 6586f7e71cfb..e5837fdf82e3 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -370,6 +370,7 @@ static void power_pmu_bhrb_reset(void)
  static void power_pmu_bhrb_enable(struct perf_event *event)
  {
  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
+	int state = PERF_SCHED_CB_SW_IN;

  	if (!ppmu->bhrb_nr)
  		return;
@@ -380,7 +381,11 @@ static void power_pmu_bhrb_enable(struct perf_event 
*event)
  		cpuhw->bhrb_context = event->ctx;
  	}
  	cpuhw->bhrb_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+
+	perf_sched_cb_inc(event->ctx->pmu, state);
  }

  static void power_pmu_bhrb_disable(struct perf_event *event)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 444e5f061d04..f4f9d737ca85 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1019,12 +1019,16 @@ pebs_update_state(bool needed_cb, struct 
cpu_hw_events *cpuc,
  	 * that does not hurt:
  	 */
  	bool update = cpuc->n_pebs == 1;
+	int state = PERF_SCHED_CB_SW_OUT;

  	if (needed_cb != pebs_needs_sched_cb(cpuc)) {
+		if (!(event->attach_state & PERF_ATTACH_TASK))
+			state |= PERF_SCHED_CB_CPU;
+
  		if (!needed_cb)
-			perf_sched_cb_inc(pmu);
+			perf_sched_cb_inc(pmu, state);
  		else
-			perf_sched_cb_dec(pmu);
+			perf_sched_cb_dec(pmu, state);

  		update = true;
  	}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653c5dd2..e4c500580df5 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -660,6 +660,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
  {
  	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int state = PERF_SCHED_CB_SW_IN;

  	if (!x86_pmu.lbr_nr)
  		return;
@@ -693,7 +694,13 @@ void intel_pmu_lbr_add(struct perf_event *event)
  	 */
  	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
  		cpuc->lbr_pebs_users++;
-	perf_sched_cb_inc(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		state |= PERF_SCHED_CB_SW_OUT;
+
+	perf_sched_cb_inc(event->ctx->pmu, state);
  	if (!cpuc->lbr_users++ && !event->total_time_running)
  		intel_pmu_lbr_reset();

@@ -724,6 +731,7 @@ void release_lbr_buffers(void)
  void intel_pmu_lbr_del(struct perf_event *event)
  {
  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int state = 0;

  	if (!x86_pmu.lbr_nr)
  		return;
@@ -740,7 +748,10 @@ void intel_pmu_lbr_del(struct perf_event *event)
  	cpuc->lbr_users--;
  	WARN_ON_ONCE(cpuc->lbr_users < 0);
  	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+
+	if (!(event->attach_state & PERF_ATTACH_TASK))
+		state |= PERF_SCHED_CB_CPU;
+	perf_sched_cb_dec(event->ctx->pmu, state);
  }

  static inline bool vlbr_exclude_host(void)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a1b91f2de264..1556fdbfc615 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -854,6 +854,10 @@ struct perf_event_context {
   */
  #define PERF_NR_CONTEXTS	4

+#define PERF_SCHED_CB_CPU	0x1
+#define PERF_SCHED_CB_SW_IN	0x2
+#define PERF_SCHED_CB_SW_OUT	0x4
+
  /**
   * struct perf_event_cpu_context - per cpu event context structure
   */
@@ -875,6 +879,8 @@ struct perf_cpu_context {

  	struct list_head		sched_cb_entry;
  	int				sched_cb_usage;
+	int				sched_cb_cpu_usage;
+	int				sched_cb_state;

  	int				online;
  	/*
@@ -967,8 +973,8 @@ extern const struct perf_event_attr 
*perf_event_attrs(struct perf_event *event);
  extern void perf_event_print_debug(void);
  extern void perf_pmu_disable(struct pmu *pmu);
  extern void perf_pmu_enable(struct pmu *pmu);
-extern void perf_sched_cb_dec(struct pmu *pmu);
-extern void perf_sched_cb_inc(struct pmu *pmu);
+extern void perf_sched_cb_dec(struct pmu *pmu, int state);
+extern void perf_sched_cb_inc(struct pmu *pmu, int state);
  extern int perf_event_task_disable(void);
  extern int perf_event_task_enable(void);

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 66a9bd71f3da..3a9d017a75b6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3384,6 +3384,34 @@ static void perf_event_sync_stat(struct 
perf_event_context *ctx,
  	}
  }

+static inline bool perf_pmu_sched_in_ctx(struct perf_cpu_context *cpuctx)
+{
+	return !!(cpuctx->sched_cb_state & PERF_SCHED_CB_SW_IN);
+}
+
+static inline bool perf_pmu_sched_out_ctx(struct perf_cpu_context *cpuctx)
+{
+	return !!(cpuctx->sched_cb_state & PERF_SCHED_CB_SW_OUT);
+}
+
+static inline bool perf_pmu_has_sched_task(struct perf_cpu_context 
*cpuctx, bool sched_in)
+{
+	struct pmu *pmu;
+
+	pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */
+
+	if (!pmu->sched_task)
+		return false;
+
+	if (sched_in && perf_pmu_sched_in_ctx(cpuctx))
+		return true;
+
+	if (!sched_in && perf_pmu_sched_out_ctx(cpuctx))
+		return true;
+
+	return false;
+}
+
  static void perf_event_context_sched_out(struct task_struct *task, int 
ctxn,
  					 struct task_struct *next)
  {
@@ -3433,7 +3461,7 @@ static void perf_event_context_sched_out(struct 
task_struct *task, int ctxn,

  			perf_pmu_disable(pmu);

-			if (cpuctx->sched_cb_usage && pmu->sched_task)
+			if (cpuctx->sched_cb_usage && perf_pmu_has_sched_task(cpuctx, false))
  				pmu->sched_task(ctx, false);

  			/*
@@ -3473,7 +3501,7 @@ static void perf_event_context_sched_out(struct 
task_struct *task, int ctxn,
  		raw_spin_lock(&ctx->lock);
  		perf_pmu_disable(pmu);

-		if (cpuctx->sched_cb_usage && pmu->sched_task)
+		if (cpuctx->sched_cb_usage && perf_pmu_has_sched_task(cpuctx, false))
  			pmu->sched_task(ctx, false);
  		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);

@@ -3484,22 +3512,35 @@ static void perf_event_context_sched_out(struct 
task_struct *task, int ctxn,

  static DEFINE_PER_CPU(struct list_head, sched_cb_list);

-void perf_sched_cb_dec(struct pmu *pmu)
+void perf_sched_cb_dec(struct pmu *pmu, int state)
  {
  	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);

+	if (!--cpuctx->sched_cb_usage)
+		cpuctx->sched_cb_state = 0;
+
+	if (!(state & PERF_SCHED_CB_CPU))
+		return;
+
  	this_cpu_dec(perf_sched_cb_usages);

-	if (!--cpuctx->sched_cb_usage)
+	if (!--cpuctx->sched_cb_cpu_usage)
  		list_del(&cpuctx->sched_cb_entry);
  }


-void perf_sched_cb_inc(struct pmu *pmu)
+void perf_sched_cb_inc(struct pmu *pmu, int state)
  {
  	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);

-	if (!cpuctx->sched_cb_usage++)
+	cpuctx->sched_cb_usage++;
+
+	cpuctx->sched_cb_state |= state;
+
+	if (!(state & PERF_SCHED_CB_CPU))
+		return;
+
+	if (!cpuctx->sched_cb_cpu_usage++)
  		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));

  	this_cpu_inc(perf_sched_cb_usages);
@@ -3544,8 +3585,8 @@ static void perf_pmu_sched_task(struct task_struct 
*prev,
  		/* will be handled in perf_event_context_sched_in/out */
  		if (cpuctx->task_ctx)
  			continue;
-
-		__perf_pmu_sched_task(cpuctx, sched_in);
+		if (perf_pmu_has_sched_task(cpuctx, sched_in))
+			__perf_pmu_sched_task(cpuctx, sched_in);
  	}
  }

@@ -3809,7 +3850,8 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,

  	cpuctx = __get_cpu_context(ctx);
  	if (cpuctx->task_ctx == ctx) {
-		if (cpuctx->sched_cb_usage)
+		if (cpuctx->sched_cb_usage &&
+		    (cpuctx->sched_cb_state & PERF_SCHED_CB_SW_IN))
  			__perf_pmu_sched_task(cpuctx, true);
  		return;
  	}
@@ -3835,7 +3877,7 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,
  		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
  	perf_event_sched_in(cpuctx, ctx, task);

-	if (cpuctx->sched_cb_usage && pmu->sched_task)
+	if (cpuctx->sched_cb_usage && perf_pmu_has_sched_task(cpuctx, true))
  		pmu->sched_task(cpuctx->task_ctx, true);

  	perf_pmu_enable(pmu);



Thanks,
Kan

