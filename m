Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1033043BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbhAZQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:23:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:22920 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392864AbhAZQXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:23:15 -0500
IronPort-SDR: AWLXCPma6Ex1pHJUisyRTzLD1VqL41gF7ND/Y1t61afODmam3X+9Sw235+RII8A24BljqeBb0Y
 OEy6YukLM+Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="264751108"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264751108"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 08:21:24 -0800
IronPort-SDR: 71bB2xu2lj1b31rvA/hp4TtsFp1SGDz6arxVTeLjP8+4PzJECTDVtga2zRndSPIwZ6+ZzGUOCi
 Ld9HJeCkZZNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356764277"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2021 08:21:24 -0800
Received: from [10.254.127.77] (kliang2-MOBL.ccr.corp.intel.com [10.254.127.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0EFE858010C;
        Tue, 26 Jan 2021 08:21:22 -0800 (PST)
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
 <YBA3V59bsOA9j/wj@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0272153e-f2a5-67df-9402-16d3cc118713@linux.intel.com>
Date:   Tue, 26 Jan 2021 11:21:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBA3V59bsOA9j/wj@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2021 10:37 AM, Peter Zijlstra wrote:
> On Tue, Jan 19, 2021 at 12:38:22PM -0800, kan.liang@linux.intel.com wrote:
>> @@ -1577,9 +1668,20 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>>   	}
>>   
>>   	if (format_size & PEBS_DATACFG_MEMINFO) {
>> +		if (sample_type & PERF_SAMPLE_WEIGHT) {
>> +			u64 weight = meminfo->latency;
>> +
>> +			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
>> +				weight >>= PEBS_CACHE_LATENCY_OFFSET;
>> +			data->weight = weight & PEBS_LATENCY_MASK ?:
>>   				intel_get_tsx_weight(meminfo->tsx_tuning);
>> +		}
>> +
>> +		if (sample_type & PERF_SAMPLE_WEIGHT_EXT) {
>> +			data->weight_ext.val = 0;
>> +			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
>> +				data->weight_ext.instr_latency = meminfo->latency & PEBS_LATENCY_MASK;
>> +		}
>>   
>>   		if (sample_type & PERF_SAMPLE_DATA_SRC)
>>   			data->data_src.val = get_data_src(event, meminfo->aux);
> 
> Talk to me about that SAMPLE_WEIGHT stuff.... I'm not liking it.
> 
> Sure you want multiple dimensions, but urgh.
> 
> Also, afaict, as proposed you're wasting 80/128 bits. That is, all data
> you want to export fits in a single u64 and yet you're using two, which
> is mighty daft.
> 
> Sure, pebs::lat / pebs_meminfo::latency is defined as a u64, but you
> can't tell me that that is ever actually more than 4G cycles. Even the
> TSX block latency is u32.
> 
> So how about defining SAMPLE_WEIGHT_STRUCT which uses the exact same
> data as SAMPLE_WEIGHT but unions it with a struct. I'm not sure if we
> want:
> 
> union sample_weight {
> 	u64 weight;
> 
> 	struct {
> 		u32	low_dword;
> 		u32	high_dword;
> 	};
> 
> 	/* or */
> 
> 	struct {
> 		u32	low_dword;
> 		u16	high_word;
> 		u16	higher_word;
> 	};
> };
> 
> Then have the core code enforce SAMPLE_WEIGHT ^ SAMPLE_WEIGHT_STRUCT and
> make the existing code never set the high dword.

So the kernel will only accept either SAMPLE_WEIGHT type or 
SAMPLE_WEIGHT_STRUCT type. It should error out if both types are set, right?

I will check if u32 is enough for meminfo::latency on the previous 
platforms.

Thanks,
Kan
