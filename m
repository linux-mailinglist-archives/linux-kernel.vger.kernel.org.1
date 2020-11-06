Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3962A992E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgKFQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:11:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:1190 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgKFQL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:11:58 -0500
IronPort-SDR: 2aTMCUxLpKwONbTH3J0/oZzQm4WxNQQgpO6KWfNZ6ttjTbEfXebrUOmrQEY4IWf0wPz3DTeRkE
 C4pClBBEnc8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="166053886"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="166053886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 08:11:58 -0800
IronPort-SDR: G8lMRuo9asDkmtRvxLPrTy7tjCVp3OtUm68LsMut1mjjWap9XcBsFTvo1KJ4kckNXx32pPNRkm
 wkqtwTWZ8hNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="307250011"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2020 08:11:58 -0800
Received: from [10.252.128.248] (kliang2-MOBL.ccr.corp.intel.com [10.252.128.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3311958073D;
        Fri,  6 Nov 2020 08:11:57 -0800 (PST)
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
 <84bc6e54-eed8-5230-ad76-7c637613a3ec@linux.intel.com>
 <CAM9d7cgQHN0sLb4Oro0+aMQsLrgx+XUnSMB1RWAnayodXPkdPw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4567fdf9-2420-d893-fdda-a2de276ab691@linux.intel.com>
Date:   Fri, 6 Nov 2020 11:11:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgQHN0sLb4Oro0+aMQsLrgx+XUnSMB1RWAnayodXPkdPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2020 7:53 PM, Namhyung Kim wrote:
> On Fri, Nov 6, 2020 at 4:01 AM Liang, Kan<kan.liang@linux.intel.com>  wrote:
>>
>>
>> On 11/5/2020 10:45 AM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Thu, Nov 5, 2020 at 11:47 PM Liang, Kan<kan.liang@linux.intel.com>  wrote:
>>>>
>>>>
>>>> On 11/2/2020 9:52 AM, Namhyung Kim wrote:
>>>>> If an event associated with a PMU which has a sched_task callback,
>>>>> it should be called regardless of cpu/task context.  For example,
>>>>
>>>> I don't think it's necessary. We should call it when we have to.
>>>> Otherwise, it just waste cycles.
>>>> Shouldn't the patch 2 be enough?
>>> I'm not sure, without this patch __perf_event_task_sched_in/out
>>> cannot be called for per-cpu events (w/o cgroups)  IMHO.
>>> And I could not find any other place to check the
>>> perf_sched_cb_usages.
>>>
>> Yes, it should a bug for large PEBS, and it should has always been there
>> since the large PEBS was introduced. I just tried some older kernels
>> (before recent change). Large PEBS is not flushed with per-cpu events.
>>
>> But from your description, it looks like the issue is only found after
>> recent change. Could you please double check if the issue can also be
>> reproduced before the recent change?
> Yep, actually Gabriel reported this problem on v4.4 kernel.

Thanks for the confirm.

So large PEBS never works with per-cpu events. :(
I will send a new patch set to address the issue.

Thanks,
Kan
