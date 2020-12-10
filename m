Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0D2D5C77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbgLJNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:55:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:27662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389693AbgLJNyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:54:45 -0500
IronPort-SDR: ntkaPtSXewFE98clTtmitxRGRKLTkdGz4EvraC0viGRr5fnQWHcEAF7NALmRRVQXerLzonTIEa
 5WNoVphJPHwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="192575535"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="192575535"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 05:52:58 -0800
IronPort-SDR: ZStQ1AgXe6lBjTh/ZnAJvZPJ6Ns85GGM1gpvricQyi6dzKGOaZ5RhVw7Q4ny6a3QfJ+b18WjBi
 RwIsgygl89RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="319263118"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2020 05:52:58 -0800
Received: from [10.254.75.173] (kliang2-MOBL.ccr.corp.intel.com [10.254.75.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9FE5B580720;
        Thu, 10 Dec 2020 05:52:56 -0800 (PST)
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com>
 <20201201172903.GT3040@hirez.programming.kicks-ass.net>
 <CAM9d7ciukm4RAH+44YWhZRummKzk1HTbnZ0Sc4Xd5ZyCo=x0xQ@mail.gmail.com>
 <CAM9d7ciBO=cmgnBVJWpyJ75VHjoxuEA=ck=V1+k8KRBkh23+nw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c868c6f7-c89f-ecc5-b771-2701b6029788@linux.intel.com>
Date:   Thu, 10 Dec 2020 08:52:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciBO=cmgnBVJWpyJ75VHjoxuEA=ck=V1+k8KRBkh23+nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2020 2:13 AM, Namhyung Kim wrote:
> Hi Peter and Kan,
> 
> How can we move this forward?

Hi Namhyung,

Thanks for the test. The changes look good to me.

Hi Peter,

Should we resend the patch set for further review?


Thanks,
Kan


> 
> Thanks,
> Namhyung
> 
> On Fri, Dec 4, 2020 at 4:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hi Peter,
>>
>> On Wed, Dec 2, 2020 at 2:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Mon, Nov 30, 2020 at 11:38:42AM -0800, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Some calls to sched_task() in a context switch can be avoided. For
>>>> example, large PEBS only requires flushing the buffer in context switch
>>>> out. The current code still invokes the sched_task() for large PEBS in
>>>> context switch in.
>>>
>>> I still hate this one, how's something like this then?
>>> Which I still don't really like.. but at least its simpler.
>>>
>>> (completely untested, may contain spurious edits, might ICE the
>>> compiler and set your pets on fire if it doesn't)
>>
>> I've tested this version... and it worked well besides the optimization.. :)
>>
>> [SNIP]
>>> +static void context_sched_task(struct perf_cpu_context *cpuctx,
>>> +                              struct perf_event_context *ctx,
>>> +                              bool sched_in)
>>> +{
>>> +       struct pmu *pmu = ctx->pmu;
>>> +
>>> +       if (cpuctx->sched_cb_dir[sched_in] && pmu->sched_task)
>>> +               pmu->sched_task(ctx, false);
>>
>> applied: s/false/sched_in/
>>
>>
>>> +}
>>> +
>>>   static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>>>                                           struct task_struct *next)
>>>   {
>>> @@ -3424,9 +3433,7 @@ static void perf_event_context_sched_out
>>>                          WRITE_ONCE(next_ctx->task, task);
>>>
>>>                          perf_pmu_disable(pmu);
>>> -
>>> -                       if (cpuctx->sched_cb_usage && pmu->sched_task)
>>> -                               pmu->sched_task(ctx, false);
>>> +                       context_sched_task(cpuctx, ctx, false);
>>>
>>>                          /*
>>>                           * PMU specific parts of task perf context can require
>>> @@ -3465,8 +3472,7 @@ static void perf_event_context_sched_out
>>>                  raw_spin_lock(&ctx->lock);
>>>                  perf_pmu_disable(pmu);
>>>
>>> -               if (cpuctx->sched_cb_usage && pmu->sched_task)
>>> -                       pmu->sched_task(ctx, false);
>>> +               context_sched_task(cpuctx, ctx, false);
>>>                  task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
>>>
>>>                  perf_pmu_enable(pmu);
>>
>> [SNIP]
>>> @@ -3563,8 +3582,7 @@ void __perf_event_task_sched_out(struct
>>>   {
>>>          int ctxn;
>>>
>>> -       if (__this_cpu_read(perf_sched_cb_usage))
>>> -               perf_pmu_sched_task(task, next, false);
>>> +       perf_pmu_sched_task(task, next, false);
>>
>> I think the reason is this change.  It now calls perf_pmu_sched_task()
>> without checking the counter.  And this is for per-cpu events.
>>
>>>
>>>          if (atomic_read(&nr_switch_events))
>>>                  perf_event_switch(task, next, false);
>>> @@ -3828,8 +3846,7 @@ static void perf_event_context_sched_in(
>>>                  cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>>          perf_event_sched_in(cpuctx, ctx, task);
>>>
>>> -       if (cpuctx->sched_cb_usage && pmu->sched_task)
>>> -               pmu->sched_task(cpuctx->task_ctx, true);
>>> +       context_sched_task(cpuctx, ctx, true);
>>>
>>>          perf_pmu_enable(pmu);
>>>
>>> @@ -3875,8 +3892,7 @@ void __perf_event_task_sched_in(struct t
>>>          if (atomic_read(&nr_switch_events))
>>>                  perf_event_switch(task, prev, true);
>>>
>>> -       if (__this_cpu_read(perf_sched_cb_usage))
>>> -               perf_pmu_sched_task(prev, task, true);
>>> +       perf_pmu_sched_task(prev, task, true);
>>
>> Ditto.
>>
>>>   }
>>>
>>>   static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
>>
>> So I made a change like below.. and it could bring the optimization back.
>>
>> Thanks,
>> Namhyung
>>
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 9107e7c3ccfb..a30243a9fab5 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3528,6 +3528,9 @@ static void __perf_pmu_sched_task(struct
>> perf_cpu_context *cpuctx, bool sched_in
>>   {
>>          struct pmu *pmu;
>>
>> +       if (!cpuctx->sched_cb_dir[sched_in])
>> +               return;
>> +
>>          pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */
>>
>>          if (WARN_ON_ONCE(!pmu->sched_task))
