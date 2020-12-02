Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DD2CB253
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgLBB2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:28:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:54096 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgLBB2e (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:28:34 -0500
IronPort-SDR: jh4HsifZ7sn9yBtHQUhAKtDPtx/0i7S2kVyN+pHL9eAej+zialJwD8SMQRnursG4ppztOE55ZC
 /tXfWKshZrTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152192088"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="152192088"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 17:26:53 -0800
IronPort-SDR: zbtpVvVWDKLZMVPKsmDFStAP+RtKlFxCBe/7cFutG7uo0mAI01xDq7HlJYREb5eSiIf06MYAqO
 PLVWNH3roQ6Q==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="549819071"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 17:26:50 -0800
Subject: Re: [PATCH] perf script: Fix overrun issue for dynamically-allocated
 pmu type number
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20201126032425.19226-1-yao.jin@linux.intel.com>
 <e72c243b-a50f-510b-5e21-10c3a38176db@intel.com>
 <8509ed3b-378f-5ee0-5a3e-bbd8cb9d86c4@linux.intel.com>
 <2f48d37f-d7d5-8e61-0894-44b57b61cd88@intel.com>
 <9e2e2552-ac94-96e6-9a34-90c9252d419e@linux.intel.com>
Message-ID: <8b973b8a-a563-a5e0-71b4-a8b4aa5d7308@linux.intel.com>
Date:   Wed, 2 Dec 2020 09:26:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <9e2e2552-ac94-96e6-9a34-90c9252d419e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 11/26/2020 10:47 PM, Jin, Yao wrote:
> Hi Adrian,
> 
> On 11/26/2020 4:36 PM, Adrian Hunter wrote:
>> On 26/11/20 9:06 am, Jin, Yao wrote:
>>> Hi Adrian,
>>>
>>> On 11/26/2020 2:51 PM, Adrian Hunter wrote:
>>>> On 26/11/20 5:24 am, Jin Yao wrote:
>>>>> When unpacking the event which is from dynamic pmu, the array
>>>>> output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
>>>>> SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
>>>>> PERF_TYPE_MAX + 1).
>>>>>
>>>>> /* In builtin-script.c */
>>>>> process_event()
>>>>> {
>>>>>      unsigned int type = output_type(attr->type);
>>>>>
>>>>>      if (output[type].fields == 0)
>>>>>          return;
>>>>> }
>>>>>
>>>>> output[10] is overrun.
>>>>>
>>>>> Create a type OUTPUT_TYPE_OTHER for dynamic pmu events, then
>>>>> output_type(attr->type) will return OUTPUT_TYPE_OTHER here.
>>>>>
>>>>> Note that if PERF_TYPE_MAX ever changed, then there would be a conflict
>>>>> between old perf.data files that had a dynamicaliy allocated PMU number
>>>>> that would then be the same as a fixed PERF_TYPE.
>>>>>
>>>>> Example:
>>>>>
>>>>> perf record --switch-events -C 0 -e
>>>>> "{cpu-clock,uncore_imc/data_reads/,uncore_imc/data_writes/}:SD" -a --
>>>>> sleep 1
>>>>> perf script
>>>>>
>>>>> Before:
>>>>>            swapper     0 [000] 1479253.987551:     277766
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.987797:     246709
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.988127:     329883
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.988273:     146393
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.988523:     249977
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.988877:     354090
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.989023:     145940
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.989383:     359856
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1479253.989523:     140082
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>
>>>>> After:
>>>>>            swapper     0 [000] 1397040.402011:     272384
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1397040.402011:       5396
>>>>> uncore_imc/data_reads/:
>>>>>            swapper     0 [000] 1397040.402011:        967
>>>>> uncore_imc/data_writes/:
>>>>>            swapper     0 [000] 1397040.402259:     249153
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1397040.402259:       7231
>>>>> uncore_imc/data_reads/:
>>>>>            swapper     0 [000] 1397040.402259:       1297
>>>>> uncore_imc/data_writes/:
>>>>>            swapper     0 [000] 1397040.402508:     249108
>>>>> cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>>>            swapper     0 [000] 1397040.402508:       5333
>>>>> uncore_imc/data_reads/:
>>>>>            swapper     0 [000] 1397040.402508:       1008
>>>>> uncore_imc/data_writes/:
>>>>>
>>>>> Fixes: 1405720d4f26 ("perf script: Add 'synth' event type for synthesized
>>>>> events")
>>>>
>>>> It does not look to me like the problem was introduced by that commit.  Are
>>>> you sure this Fixes tag is correct?
>>>>
>>>
>>> Commit 1405720d4f26 added the change:
>>>
>>> @@ -1215,8 +1253,9 @@ static void process_event(struct perf_script *script,
>>>   {
>>>          struct thread *thread = al->thread;
>>>          struct perf_event_attr *attr = &evsel->attr;
>>> +       unsigned int type = output_type(attr->type);
>>>
>>> -       if (output[attr->type].fields == 0)
>>> +       if (output[type].fields == 0)
>>>                  return;
>>
>> That is a nop if attr->type != PERF_TYPE_SYNTH
>> Given that PERF_TYPE_SYNTH is (INT_MAX + 1), it is a nop for all kernel
>> dynamically allocated PMU numbers.
>>
>>>
>>> But of course, we can also say the original "output[attr->type].fields"
>>> introduced the issue, I'm not sure. Maybe Arnaldo can help to make the
>>> decision. :)
>>
>> I think perf script has always had this problem.
>>
> 
> Since perf-script has always had this problem, I'm OK to remove the fixes tag from the patch 
> description.
> 
> Thanks
> Jin Yao

Can I get your ACK if the fixes tag is removed from this patch?

Do I need to post a new version which just removes the fixes tag?

Thanks
Jin Yao
