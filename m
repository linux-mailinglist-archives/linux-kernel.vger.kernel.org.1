Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A93042E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392451AbhAZPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:47:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:18075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391862AbhAZPqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:46:07 -0500
IronPort-SDR: tuTgkDzOTDvkU9rkx4bDoK8rm7fRefZLZ2fcB24VQKNgUT6tpT5FudCSU72fVKD0CdU6jzwAW9
 g4LCZPyUXPtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="167019568"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="167019568"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:44:21 -0800
IronPort-SDR: 31nPmryDhDFzrYPKAHaZgm7mkk35VguibFV9CIvysyinCYzZtuU4p0fNn5F1CIerELJqxjVkfo
 gP9f10eYnlzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="472785979"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2021 07:44:20 -0800
Received: from [10.254.127.77] (kliang2-MOBL.ccr.corp.intel.com [10.254.127.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6FC4658010C;
        Tue, 26 Jan 2021 07:44:19 -0800 (PST)
Subject: Re: [PATCH 03/12] perf/x86/intel: Add perf core PMU support for
 Sapphire Rapids
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-4-git-send-email-kan.liang@linux.intel.com>
 <YBAq11TjpYj2rAot@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4ce07775-1076-0a2d-55be-bea3c7dc63f9@linux.intel.com>
Date:   Tue, 26 Jan 2021 10:44:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBAq11TjpYj2rAot@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2021 9:44 AM, Peter Zijlstra wrote:
> On Tue, Jan 19, 2021 at 12:38:22PM -0800, kan.liang@linux.intel.com wrote:
>> @@ -3671,6 +3853,31 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * To retrieve complete Memory Info of the load latency event, an
>> +	 * auxiliary event has to be enabled simultaneously. Add a check for
>> +	 * the load latency event.
>> +	 *
>> +	 * In a group, the auxiliary event must be in front of the load latency
>> +	 * event. The rule is to simplify the implementation of the check.
>> +	 * That's because perf cannot have a complete group at the moment.
>> +	 */
>> +	if (x86_pmu.flags & PMU_FL_MEM_LOADS_AUX &&
>> +	    (event->attr.sample_type & PERF_SAMPLE_DATA_SRC) &&
>> +	    is_mem_loads_event(event)) {
>> +		struct perf_event *leader = event->group_leader;
>> +		struct perf_event *sibling = NULL;
>> +
>> +		if (!is_mem_loads_aux_event(leader)) {
>> +			for_each_sibling_event(sibling, leader) {
>> +				if (is_mem_loads_aux_event(sibling))
>> +					break;
>> +			}
>> +			if (list_entry_is_head(sibling, &leader->sibling_list, sibling_list))
>> +				return -ENODATA;
>> +		}
>> +	}
>> +
>>   	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
>>   		return 0;
>>   
> 
> I have vague memories of this getting mentioned in a call at some point.
> Pretend I don't know anything and tell me more.
> 

Adding the auxiliary event is for the new data source fields, data block 
& address block. If perf only samples the load latency event, the value 
of the data block & address block fields in a sample is not correct. To 
get the correct value, we have to sample both the auxiliary event and 
the load latency together on SPR. So I add the check in the kernel. I 
also modify the perf mem in the perf tool accordingly.

Thanks,
Kan
