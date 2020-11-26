Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB62C5754
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbgKZOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:47:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:21356 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390791AbgKZOr0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:47:26 -0500
IronPort-SDR: 9OTxOvQy8YX6HC239ylqHr41GsiQQpxl97l9kAUU8G9oIPpnJBce91ZOGwzC+q1Gbi7UiB0MVJ
 3Qji7P+Gr/Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="233896910"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="233896910"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 06:47:25 -0800
IronPort-SDR: XPauXJs9zmHbfOZknqA7ZOCOM9iBy9yfZPOl5Fa4dd5HnY01dJjGtfOgiJICA19WpOb+dAddz5
 2sd+e+24iy7A==
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="547740730"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.211.14]) ([10.254.211.14])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 06:47:21 -0800
Subject: Re: [PATCH] perf script: Fix overrun issue for dynamically-allocated
 pmu type number
To:     Adrian Hunter <adrian.hunter@intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20201126032425.19226-1-yao.jin@linux.intel.com>
 <e72c243b-a50f-510b-5e21-10c3a38176db@intel.com>
 <8509ed3b-378f-5ee0-5a3e-bbd8cb9d86c4@linux.intel.com>
 <2f48d37f-d7d5-8e61-0894-44b57b61cd88@intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9e2e2552-ac94-96e6-9a34-90c9252d419e@linux.intel.com>
Date:   Thu, 26 Nov 2020 22:47:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2f48d37f-d7d5-8e61-0894-44b57b61cd88@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 11/26/2020 4:36 PM, Adrian Hunter wrote:
> On 26/11/20 9:06 am, Jin, Yao wrote:
>> Hi Adrian,
>>
>> On 11/26/2020 2:51 PM, Adrian Hunter wrote:
>>> On 26/11/20 5:24 am, Jin Yao wrote:
>>>> When unpacking the event which is from dynamic pmu, the array
>>>> output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
>>>> SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
>>>> PERF_TYPE_MAX + 1).
>>>>
>>>> /* In builtin-script.c */
>>>> process_event()
>>>> {
>>>>      unsigned int type = output_type(attr->type);
>>>>
>>>>      if (output[type].fields == 0)
>>>>          return;
>>>> }
>>>>
>>>> output[10] is overrun.
>>>>
>>>> Create a type OUTPUT_TYPE_OTHER for dynamic pmu events, then
>>>> output_type(attr->type) will return OUTPUT_TYPE_OTHER here.
>>>>
>>>> Note that if PERF_TYPE_MAX ever changed, then there would be a conflict
>>>> between old perf.data files that had a dynamicaliy allocated PMU number
>>>> that would then be the same as a fixed PERF_TYPE.
>>>>
>>>> Example:
>>>>
>>>> perf record --switch-events -C 0 -e
>>>> "{cpu-clock,uncore_imc/data_reads/,uncore_imc/data_writes/}:SD" -a --
>>>> sleep 1
>>>> perf script
>>>>
>>>> Before:
>>>>            swapper     0 [000] 1479253.987551:     277766
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.987797:     246709
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.988127:     329883
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.988273:     146393
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.988523:     249977
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.988877:     354090
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.989023:     145940
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.989383:     359856
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1479253.989523:     140082
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>
>>>> After:
>>>>            swapper     0 [000] 1397040.402011:     272384
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1397040.402011:       5396
>>>> uncore_imc/data_reads/:
>>>>            swapper     0 [000] 1397040.402011:        967
>>>> uncore_imc/data_writes/:
>>>>            swapper     0 [000] 1397040.402259:     249153
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1397040.402259:       7231
>>>> uncore_imc/data_reads/:
>>>>            swapper     0 [000] 1397040.402259:       1297
>>>> uncore_imc/data_writes/:
>>>>            swapper     0 [000] 1397040.402508:     249108
>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>            swapper     0 [000] 1397040.402508:       5333
>>>> uncore_imc/data_reads/:
>>>>            swapper     0 [000] 1397040.402508:       1008
>>>> uncore_imc/data_writes/:
>>>>
>>>> Fixes: 1405720d4f26 ("perf script: Add 'synth' event type for synthesized
>>>> events")
>>>
>>> It does not look to me like the problem was introduced by that commit.  Are
>>> you sure this Fixes tag is correct?
>>>
>>
>> Commit 1405720d4f26 added the change:
>>
>> @@ -1215,8 +1253,9 @@ static void process_event(struct perf_script *script,
>>   {
>>          struct thread *thread = al->thread;
>>          struct perf_event_attr *attr = &evsel->attr;
>> +       unsigned int type = output_type(attr->type);
>>
>> -       if (output[attr->type].fields == 0)
>> +       if (output[type].fields == 0)
>>                  return;
> 
> That is a nop if attr->type != PERF_TYPE_SYNTH
> Given that PERF_TYPE_SYNTH is (INT_MAX + 1), it is a nop for all kernel
> dynamically allocated PMU numbers.
> 
>>
>> But of course, we can also say the original "output[attr->type].fields"
>> introduced the issue, I'm not sure. Maybe Arnaldo can help to make the
>> decision. :)
> 
> I think perf script has always had this problem.
> 

Since perf-script has always had this problem, I'm OK to remove the fixes tag from the patch 
description.

Thanks
Jin Yao
