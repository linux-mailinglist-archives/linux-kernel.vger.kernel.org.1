Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAFB2FAE32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbhASAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:51:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:48528 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732808AbhASAvp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:51:45 -0500
IronPort-SDR: L87LnFWIwdanQv6Quz8d9Kw0w8U9zFdf5D4RYwMG90vLh5r0ubinpzn0GesiHFtyeyLBnO/rCj
 N0w/gcWZ185g==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="176290975"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="176290975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 16:49:57 -0800
IronPort-SDR: E6wtFFaIku3AzslxS651+GFazQ8xrTMwUZbFMyUtMQJCa07GRnXSMpKQ0o/PE1UuuTpatxP8MT
 UKsWgHt/0pRg==
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="426287838"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 16:49:54 -0800
Subject: Re: [PATCH v2] perf script: Fix overrun issue for
 dynamically-allocated pmu type number
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20201209005828.21302-1-yao.jin@linux.intel.com>
 <3fcdc860-d858-0166-de23-34fc6fe5c1cd@intel.com>
 <18fde68f-0d24-5bcb-38e1-11dcf6f70bc1@linux.intel.com>
Message-ID: <934aa658-1147-8882-99c2-68561b42d63d@linux.intel.com>
Date:   Tue, 19 Jan 2021 08:49:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <18fde68f-0d24-5bcb-38e1-11dcf6f70bc1@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Jiri,

On 12/25/2020 9:10 AM, Jin, Yao wrote:
> Hi Arnaldo, Jiri,
> 
> On 12/11/2020 2:10 PM, Adrian Hunter wrote:
>> On 9/12/20 2:58 am, Jin Yao wrote:
>>> When unpacking the event which is from dynamic pmu, the array
>>> output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
>>> SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
>>> PERF_TYPE_MAX + 1).
>>>
>>> /* In builtin-script.c */
>>> process_event()
>>> {
>>>          unsigned int type = output_type(attr->type);
>>>
>>>          if (output[type].fields == 0)
>>>                  return;
>>> }
>>>
>>> output[10] is overrun.
>>>
>>> Create a type OUTPUT_TYPE_OTHER for dynamic pmu events, then
>>> output_type(attr->type) will return OUTPUT_TYPE_OTHER here.
>>>
>>> Note that if PERF_TYPE_MAX ever changed, then there would be a conflict
>>> between old perf.data files that had a dynamicaliy allocated PMU number
>>> that would then be the same as a fixed PERF_TYPE.
>>>
>>> Example:
>>>
>>> perf record --switch-events -C 0 -e 
>>> "{cpu-clock,uncore_imc/data_reads/,uncore_imc/data_writes/}:SD" -a -- sleep 1
>>> perf script
>>>
>>> Before:
>>>           swapper     0 [000] 1479253.987551:     277766               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.987797:     246709               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.988127:     329883               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.988273:     146393               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.988523:     249977               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.988877:     354090               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.989023:     145940               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.989383:     359856               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1479253.989523:     140082               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>
>>> After:
>>>           swapper     0 [000] 1397040.402011:     272384               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1397040.402011:       5396  uncore_imc/data_reads/:
>>>           swapper     0 [000] 1397040.402011:        967 uncore_imc/data_writes/:
>>>           swapper     0 [000] 1397040.402259:     249153               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1397040.402259:       7231  uncore_imc/data_reads/:
>>>           swapper     0 [000] 1397040.402259:       1297 uncore_imc/data_writes/:
>>>           swapper     0 [000] 1397040.402508:     249108               cpu-clock:  
>>> ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>>>           swapper     0 [000] 1397040.402508:       5333  uncore_imc/data_reads/:
>>>           swapper     0 [000] 1397040.402508:       1008 uncore_imc/data_writes/:
>>>
>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
> 
> Can this patch be accepted? :)
> 
> Thanks
> Jin Yao
> 

Can this bug fix be accepted or anything else I need to improve?

Thanks
Jin Yao
