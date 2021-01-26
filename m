Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE843042B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406322AbhAZPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:35:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:58872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392811AbhAZPfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:35:15 -0500
IronPort-SDR: x1Q/FBf1CCZr2Vu7F4intRNL5acpjB1gYo/kK3x1AH8XifIZmleINloYIgwBe6Onu0iWvzo1lj
 4Cb6n952mAug==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159693926"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159693926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:33:21 -0800
IronPort-SDR: W7kAfcDQ2+t8EGYvZ/ABt9l24x7pRnATI0btsmXCq4glTZgcvOXYnLGY3qcLuHaehrEFN+suE1
 iVM1xcc9Ve7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="406748156"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2021 07:33:21 -0800
Received: from [10.254.127.77] (kliang2-MOBL.ccr.corp.intel.com [10.254.127.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5A31358010C;
        Tue, 26 Jan 2021 07:33:20 -0800 (PST)
Subject: Re: [PATCH 01/12] perf/core: Add PERF_SAMPLE_WEIGHT_EXT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
 <1611088711-17177-2-git-send-email-kan.liang@linux.intel.com>
 <YBAqYyTuqxsH8tqR@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d018282d-f47d-4382-2538-59c6930a74c3@linux.intel.com>
Date:   Tue, 26 Jan 2021 10:33:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBAqYyTuqxsH8tqR@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2021 9:42 AM, Peter Zijlstra wrote:
> On Tue, Jan 19, 2021 at 12:38:20PM -0800, kan.liang@linux.intel.com wrote:
> 
>> @@ -900,6 +901,13 @@ enum perf_event_type {
>>   	 *	  char			data[size]; } && PERF_SAMPLE_AUX
>>   	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>>   	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
>> +	 *	{ union {
>> +	 *		u64		weight_ext;
>> +	 *		struct {
>> +	 *			u64	instr_latency:16,
>> +	 *				reserved:48;
>> +	 *		};
>> +	 *	} && PERF_SAMPLE_WEIGHT_EXT
>>   	 * };
>>   	 */
>>   	PERF_RECORD_SAMPLE			= 9,
>> @@ -1248,4 +1256,12 @@ struct perf_branch_entry {
>>   		reserved:40;
>>   };
>>   
>> +union perf_weight_ext {
>> +	__u64		val;
>> +	struct {
>> +		__u64	instr_latency:16,
>> +			reserved:48;
>> +	};
>> +};
>> +
>>   #endif /* _UAPI_LINUX_PERF_EVENT_H */
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 55d1879..9363d12 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1903,6 +1903,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
>>   	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
>>   		size += sizeof(data->code_page_size);
>>   
>> +	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
>> +		size += sizeof(data->weight_ext);
>> +
>>   	event->header_size = size;
>>   }
>>   
>> @@ -6952,6 +6955,9 @@ void perf_output_sample(struct perf_output_handle *handle,
>>   			perf_aux_sample_output(event, handle, data);
>>   	}
>>   
>> +	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
>> +		perf_output_put(handle, data->weight_ext);
>> +
>>   	if (!event->attr.watermark) {
>>   		int wakeup_events = event->attr.wakeup_events;
>>   
> 
> This patch is broken and will expose uninitialized kernel stack.
> 

Could we initialize the 'weight_ext' in perf_sample_data_init()?

I understand that we prefer not to set the field in 
perf_sample_data_init() to minimize the cachelines touched.
However, the perf_sample_data_init() should be the most proper place to 
do the initialization. Also, the 'weight' is already initialized in it. 
As an extension, I think the 'weight_ext' should be initialized in it as 
well.

In the perf_prepare_sample(), I think we can only clear the unused 
fields. The [0:15] bits may still leak the data.

Thanks,
Kan
