Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8A2880CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 05:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgJIDpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 23:45:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:18827 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731532AbgJIDpP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 23:45:15 -0400
IronPort-SDR: IG4CYRA63/JtoHRFrRXNlFuKSH642CkojHw5OZHcd7yFw/zg9JByfxtVCEJzSLQJR9ALx1YkLj
 NW8OizXf/tGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="165553263"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="165553263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:45:14 -0700
IronPort-SDR: OxDg/RPzUZE4xSwe8YBv3E35Ujzo9tDfmBso8XG/aMgrUJlbRN38mq37Zp26oLePabzQ93l6Zw
 G4Zxsf4UgNpA==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="528755643"
Received: from unknown (HELO [10.238.4.83]) ([10.238.4.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:45:11 -0700
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to
 v1.08
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
        Ian Rogers <irogers@google.com>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com>
 <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
 <20200925180527.GA2883319@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <05b5dd0f-6f0b-a98a-f72d-e5d34141a39e@linux.intel.com>
Date:   Fri, 9 Oct 2020 11:45:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925180527.GA2883319@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 9/26/2020 2:05 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 23, 2020 at 09:25:06AM +0800, Jin, Yao escreveu:
>> On 9/23/2020 3:42 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Sep 22, 2020 at 11:19:17AM +0800, Jin Yao escreveu:
>>>> - Update CascadelakeX events to v1.08.
>>>> - Update CascadelakeX JSON metrics from TMAM 4.0.
> 
>>>> Other fixes:
>>>> - Add NO_NMI_WATCHDOG metric constraint to Backend_Bound
>>>> - Change 'MB/sec' to 'MB' in UNC_M_PMM_BANDWIDTH.
> 
>>> [acme@five perf]$ am /wb/1.patch
>>> Applying: perf vendor events: Update CascadelakeX events to v1.08
>>> error: patch fragment without header at line 283: @@ -213,14 +220,14 @@
>>> Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08
>>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>>> When you have resolved this problem, run "git am --continue".
>>> If you prefer to skip this patch, run "git am --skip" instead.
>>> To restore the original branch and stop patching, run "git am --abort".
>>> [acme@five perf]$ git am --abort
>>> [acme@five perf]$ set -o vi
>>> [acme@five perf]$ patch -p1 < /wb/1.patch
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
>>> Hunk #7 FAILED at 87.
>>> 1 out of 7 hunks FAILED -- saving rejects to file tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/other.json
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
>>> patching file tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
>>> [acme@five perf]$
> 
>>> [acme@five perf]$ head tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
>>> --- tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
>>> +++ tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
>>> @@ -87,86 +70,110 @@
>>>            "MetricName": "CLKS"
>>>        },
>>>        {
>>> -        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
>>> +        "BriefDescription": "Total issue-pipeline slots (per-Physical Core till ICL; per-Logical Processor ICL onward)",
>>>            "MetricExpr": "4 * cycles",
>>>            "MetricGroup": "TopDownL1",
>>> [acme@five perf]$ wc -l tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
>>> 133 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
>>> [acme@five perf]$
> 
>>> Can you please check?
> 
>> I applied the patch on latest perf/core, it seemed OK.
> 
>> # git log --oneline
>> 4cbdb1c21926 (HEAD -> perf/core) perf vendor events: Update CascadelakeX events to v1.08
>> b1f815c479c1 (tag: perf-tools-tests-v5.10-2020-09-10, origin/perf/core) perf vendor events power9:
>> Add hv_24x7 core level metric events
>> f5a489dc8189 perf metricgroup: Pass pmu_event structure as a parameter for
>> arch_get_runtimeparam() 560ccbc4a52c perf jevents: Add support for parsing
>> perchip/percore events ...
>   
>> I strongly suspect that part of patch content is truncated by mail system.
>   
>> Let me resend the patch as attachment. Sorry about that!
> 
> Thanks, it now works, but then... You forgot to add the Cc: entries for
> all the people in your actual e-mail Cc: list, and also the
> Reviewed-by: from Andy, I had to do it all manually, so when I applied
> your attachments with 'git am' I needed to go on and manually collect
> all the Cc, Reviewed-by and Acked-by tags.
> 

Sorry for replying so late!

I realized I forgot to add CC/To list in the attached patches. Very sorry about that! :(

> This complicates things, slows me down, doesn't scale. While I do all
> this manual stuff normally, I don't think this can continue, and its not
> something specific to you, submitters have to pay attention to these
> details. Or tools.
>

Sorry for bringing troubles to you.

> Things like b4 help with this and probably have to take into account
> attachments as well, that is why I'm adding Konstantin to the Cc: list
> of this message.
> 

Let me learn b4... but as Konstantin said in another thread, it's complicated too.

Anyway, for this case, I will take care in future. At least, I will check and add CC/To list to the 
attached patch.

Thanks
Jin Yao

> Konstantin, is this case covered? I.e. patches that get botched and then
> require attachments to be sent to then gets processed?
> 
> Thanks, applied.
> 
> - Arnaldo
> 
