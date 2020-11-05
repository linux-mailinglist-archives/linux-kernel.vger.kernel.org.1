Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261172A8778
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbgKETjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:39:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:40478 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKETjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:39:54 -0500
IronPort-SDR: 8FdmzU6hP8yXlRP9GPBr/4YC0tNGYfPNiAXwigLWoUFpm3kY7B6H/HKq6iYOY602+KG9qUjyYN
 Tm4QVjvE/Sbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="165939042"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="165939042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 11:39:53 -0800
IronPort-SDR: j+4FzYHP3eJmpNv4FhcOF9bLPH/+4jSBaoo3antggYAyURMNOJvw8DBIqBHwVJqw5FNa6hBjjP
 ZdI3GRx5cyaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="321336175"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2020 11:39:53 -0800
Received: from [10.254.97.216] (kliang2-MOBL.ccr.corp.intel.com [10.254.97.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5EECB58073D;
        Thu,  5 Nov 2020 11:39:52 -0800 (PST)
Subject: Re: [RFC 2/2] perf/core: Invoke pmu::sched_task callback for per-cpu
 events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
References: <20201102145221.309001-1-namhyung@kernel.org>
 <20201102145221.309001-3-namhyung@kernel.org>
 <03ba0d07-45bb-0849-1843-915b6873478f@linux.intel.com>
 <CAM9d7cgwmXmyUd4Y==F120BsAx2iWw6h9D+BB6D_FDw1-7SxBw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bd97ab7c-039c-b968-3008-8bcd51700c8c@linux.intel.com>
Date:   Thu, 5 Nov 2020 14:39:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgwmXmyUd4Y==F120BsAx2iWw6h9D+BB6D_FDw1-7SxBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2020 10:54 AM, Namhyung Kim wrote:
>> -void perf_sched_cb_inc(struct pmu *pmu)
>> +void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
>>    {
>>          struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
>>
>> -       if (!cpuctx->sched_cb_usage++)
>> -               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
>> +       cpuctx->sched_cb_usage++;
>>
>> -       this_cpu_inc(perf_sched_cb_usages);
>> +       if (systemwide) {
>> +               this_cpu_inc(perf_sched_cb_usages);
>> +               list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
> You need to check the value and make sure it's added only once.

Right, maybe we have to add a new variable for that.


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
index a1b91f2de264..14f936385cc8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -875,6 +875,7 @@ struct perf_cpu_context {

  	struct list_head		sched_cb_entry;
  	int				sched_cb_usage;
+	int				sched_cb_sw_usage;

  	int				online;
  	/*
@@ -967,8 +968,8 @@ extern const struct perf_event_attr 
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
index 66a9bd71f3da..af75859c9138 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3484,22 +3484,32 @@ static void perf_event_context_sched_out(struct 
task_struct *task, int ctxn,

  static DEFINE_PER_CPU(struct list_head, sched_cb_list);

-void perf_sched_cb_dec(struct pmu *pmu)
+void perf_sched_cb_dec(struct pmu *pmu, bool systemwide)
  {
  	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);

+	--cpuctx->sched_cb_usage;
+
+	if (!systemwide)
+		return;
+
  	this_cpu_dec(perf_sched_cb_usages);

-	if (!--cpuctx->sched_cb_usage)
+	if (!--cpuctx->sched_cb_sw_usage)
  		list_del(&cpuctx->sched_cb_entry);
  }


-void perf_sched_cb_inc(struct pmu *pmu)
+void perf_sched_cb_inc(struct pmu *pmu, bool systemwide)
  {
  	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);

-	if (!cpuctx->sched_cb_usage++)
+	cpuctx->sched_cb_usage++;
+
+	if (!systemwide)
+		return;
+
+	if (!cpuctx->sched_cb_sw_usage++)
  		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));

  	this_cpu_inc(perf_sched_cb_usages);



Thanks,
Kan
