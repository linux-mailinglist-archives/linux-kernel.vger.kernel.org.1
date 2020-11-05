Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6282A869F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKETB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:01:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:35699 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKETBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:01:25 -0500
IronPort-SDR: FwUHsTCXV8xa6OPZGu8BM46SbLAdZgqxHCqGuTVanmkzaUOdUL4wFUBvRG4Na0qNsbuJG2vCuY
 VBU2xrGFCXjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="168661419"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="168661419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 11:01:25 -0800
IronPort-SDR: MaRlRjzkltKMyyGLMfs4jDPbAZrBOsux8Z5xtqBiRer8+CZgwidYM8dlth8uIL7GO0v8AGk4Wj
 FvqOa9Bz0PZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="353131006"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2020 11:01:25 -0800
Received: from [10.254.97.216] (kliang2-MOBL.ccr.corp.intel.com [10.254.97.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 418F958073D;
        Thu,  5 Nov 2020 11:01:24 -0800 (PST)
Subject: Re: [RFC 1/2] perf/core: Enable sched_task callbacks if PMU has it
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
 <20201102145221.309001-2-namhyung@kernel.org>
 <f92281d1-03ec-a1bc-b54f-e2b867d5b787@linux.intel.com>
 <CAM9d7cgsNEoeotoumY0S9kvn0uc34TOas_3rVRL3VyQ9_VVM5Q@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <84bc6e54-eed8-5230-ad76-7c637613a3ec@linux.intel.com>
Date:   Thu, 5 Nov 2020 14:01:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgsNEoeotoumY0S9kvn0uc34TOas_3rVRL3VyQ9_VVM5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2020 10:45 AM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Nov 5, 2020 at 11:47 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 11/2/2020 9:52 AM, Namhyung Kim wrote:
>>> If an event associated with a PMU which has a sched_task callback,
>>> it should be called regardless of cpu/task context.  For example,
>>
>>
>> I don't think it's necessary. We should call it when we have to.
>> Otherwise, it just waste cycles.
>> Shouldn't the patch 2 be enough?
> 
> I'm not sure, without this patch __perf_event_task_sched_in/out
> cannot be called for per-cpu events (w/o cgroups)  IMHO.
> And I could not find any other place to check the
> perf_sched_cb_usages.
>

Yes, it should a bug for large PEBS, and it should has always been there 
since the large PEBS was introduced. I just tried some older kernels 
(before recent change). Large PEBS is not flushed with per-cpu events.

But from your description, it looks like the issue is only found after 
recent change. Could you please double check if the issue can also be 
reproduced before the recent change?


>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index b458ed3dc81b..aaa0155c4142 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -4696,6 +4696,8 @@ static void unaccount_event(struct perf_event *event)
>>>                dec = true;
>>>        if (has_branch_stack(event))
>>>                dec = true;
>>> +     if (event->pmu->sched_task)
>>> +             dec = true;

I think sched_task is a too big hammer. The 
__perf_event_task_sched_in/out will be invoked even for non-pebs per-cpu 
events, which is not necessary.

Maybe we can introduce a flag to indicate the case. How about the patch 
as below?

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c79748f6921d..953a4bb98330 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3565,8 +3565,10 @@ static int intel_pmu_hw_config(struct perf_event 
*event)
  		if (!(event->attr.freq || (event->attr.wakeup_events && 
!event->attr.watermark))) {
  			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
  			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event)))
+			      ~intel_pmu_large_pebs_flags(event))) {
  				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
+				event->attach_state |= PERF_ATTACH_SCHED_DATA;
+			}
  		}
  		if (x86_pmu.pebs_aliases)
  			x86_pmu.pebs_aliases(event);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0defb526cd0c..3eef7142aa11 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -606,6 +606,7 @@ struct swevent_hlist {
  #define PERF_ATTACH_TASK	0x04
  #define PERF_ATTACH_TASK_DATA	0x08
  #define PERF_ATTACH_ITRACE	0x10
+#define PERF_ATTACH_SCHED_DATA	0x20

  struct perf_cgroup;
  struct perf_buffer;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dba4ea4e648b..a38133b5543a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4675,7 +4675,7 @@ static void unaccount_event(struct perf_event *event)
  	if (event->parent)
  		return;

-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_DATA))
  		dec = true;
  	if (event->attr.mmap || event->attr.mmap_data)
  		atomic_dec(&nr_mmap_events);
@@ -11204,7 +11204,7 @@ static void account_event(struct perf_event *event)
  	if (event->parent)
  		return;

-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_DATA))
  		inc = true;
  	if (event->attr.mmap || event->attr.mmap_data)
  		atomic_inc(&nr_mmap_events);

Thanks,
Kan
