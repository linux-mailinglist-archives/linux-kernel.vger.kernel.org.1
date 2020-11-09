Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923602ABF35
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgKIOtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:49:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:22626 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbgKIOte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:49:34 -0500
IronPort-SDR: AJ7c/7E0QRPyVPbJxwkFOZYUlcrlBRlt/cbUCupaOoyhNfBCnNJxXQQwVt/OPGKEsay+7iPj7h
 rO+1/Df4M4fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="233979530"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="233979530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 06:49:33 -0800
IronPort-SDR: 9y1jn983TpczPBZeJ+0uq/18TUdzT3RfaPJ/P2hvqATKG2pgKWBu5rCaBM1oVCa4ZnkEV9URBz
 CyzIyR95EPpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="530766937"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 09 Nov 2020 06:49:33 -0800
Received: from [10.251.16.60] (kliang2-MOBL.ccr.corp.intel.com [10.251.16.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 84A3058096C;
        Mon,  9 Nov 2020 06:49:32 -0800 (PST)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
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
Message-ID: <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
Date:   Mon, 9 Nov 2020 09:49:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109110405.GN2651@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2020 6:04 AM, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 10:52:35AM +0100, Peter Zijlstra wrote:
>> On Fri, Nov 06, 2020 at 01:29:33PM -0800, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Sometimes the PMU internal buffers have to be flushed for per-CPU events
>>> during a context switch, e.g., large PEBS. Otherwise, the perf tool may
>>> report samples in locations that do not belong to the process where the
>>> samples are processed in, because PEBS does not tag samples with PID/TID.
>>>
>>> The current code only flush the buffers for a per-task event. It doesn't
>>> check a per-CPU event.
>>>
>>> Add a new event state flag, PERF_ATTACH_SCHED_CB, to indicate that the
>>> PMU internal buffers have to be flushed for this event during a context
>>> switch.
>>>
>>> Add sched_cb_entry and perf_sched_cb_usages back to track the PMU/cpuctx
>>> which is required to be flushed.
>>>
>>> Only need to invoke the sched_task() for per-CPU events in this patch.
>>> The per-task events have been handled in perf_event_context_sched_in/out
>>> already.
>>>
>>> Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
>>
>> Are you sure? In part this patch looks like a revert of:
>>
>>    44fae179ce73a26733d9e2d346da4e1a1cb94647
>>    556cccad389717d6eb4f5a24b45ff41cad3aaabf
> 

The patch tries to fix a long term PEBS bug with per-CPU event. It's not 
a revert. I think we still want to keep the optimization for per-task 
event with 44fae179ce73 and 556cccad3897.

Here is the story.

- When the large PEBS was introduced (9c964efa4330), the sched_task() 
should be invoked to flush the PEBS buffer in each context switch. 
However, The perf_sched_events in account_event() is not updated 
accordingly. The perf_event_task_sched_* never be invoked for a pure 
per-CPU context. Only per-task event works.
    At that time, the perf_pmu_sched_task() is outside of 
perf_event_context_sched_in/out. It means that perf has to double 
perf_pmu_disable() for per-task event.


- The recent optimization (44fae179ce73 and 556cccad3897) only optimize 
the per-task event by moving the sched_task() into 
perf_event_context_sched_in/out. So perf only need to invoke 
perf_pmu_disable() once.
   But it doesn't fix the issue in a pure per-CPU context. The per-CPU 
events are still broken.


- The patch 1 tries to fix broken per-CPU events. The CPU context cannot 
be retrieved from the task->perf_event_ctxp. So it has to be tracked in 
the sched_cb_list. Yes, the code is very similar to the original codes, 
but it is actually the new code for per-CPU events. The optimization for 
per-task events is still kept.
   For the case, which has both a CPU context and a task context, yes, 
the __perf_pmu_sched_task() in this patch is not invoked. Because the 
sched_task() only need to be invoked once in a context switch. The 
sched_task() will be eventually invoked in the task context.


- The following patch 3 tries to optimize the sched_task() further.
   - We handle the per-CPU event and per-task event in different places. 
In a pure per-task context, we don't need to go through the 
sched_cb_list. We can get the information from task->perf_event_ctxp. We 
introduce a flag to distinguish them.
   - For most of the cases, we don't need to invoke the sched_task() in 
both sched in and sched out. We also introduce a flag for PMUs to avoid 
unnecessary calls.


All the implementation and optimization are generic. For example, for 
power, the BHRB entries are reset in context switch in. They can also 
benefit from the optimization.


> *groan*... I think I might've made a mistake with those two patches. I
> assumed the whole cpuctx->task_ctx thing was relevant, it is not.
> 
> As per perf_sched_cb_{inc,dec}(struct pmu *), the thing we care about is
> that the *PMU* gets a context switch callback, we don't give a crap
> about the actual task context. Except that LBR code does, but I'm
> thinking that started the whole confusion -- and I'm still not sure it's
> actually correct either.
> 
> Now,.. how did we end up with the above two patches anyway... /me frobs
> around in the inbox... Ah! that daft user RDPMC thing. I wanted to avoid
> yet another pmu::method().
> 
> Hmm.. and the reason I proposed that change is because we'd end up with
> the sched_cb for every context switch now, not just large-pebs and or
> lbr crud. And this form avoids the double perf_pmu_disable() and all
> that.

With the patch set,  I think the double perf_pmu_disable() is still avoided.

> 
> Maybe we can frob x86_pmu_enable()...

Could you please elaborate?

Thanks,
Kan

