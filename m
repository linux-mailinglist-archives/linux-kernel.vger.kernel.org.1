Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF991BF395
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgD3IzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 04:55:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgD3IzC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:55:02 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CEC775679C5665417D60;
        Thu, 30 Apr 2020 09:55:00 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.178) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 09:54:59 +0100
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
To:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>
CC:     <acme@kernel.org>, <jolsa@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <Linux-kernel@vger.kernel.org>, <ak@linux.intel.com>,
        <kan.liang@intel.com>, <yao.jin@intel.com>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <66b84e3f-f7d8-bb65-616e-d159a509a439@huawei.com>
Date:   Thu, 30 Apr 2020 09:54:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200430084529.GC1681583@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.178]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 09:45, Jiri Olsa wrote:
> On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
>> A big uncore event group is split into multiple small groups which
>> only include the uncore events from the same PMU. This has been
>> supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
>> uncore event aliases in small groups properly").
>>
>> If the event's PMU name starts to repeat, it must be a new event.
>> That can be used to distinguish the leader from other members.
>> But now it only compares the pointer of pmu_name
>> (leader->pmu_name == evsel->pmu_name).
>>
>> If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
>> the event list is:
>>
>> evsel->name					evsel->pmu_name
>> ---------------------------------------------------------------
>> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_4 (as leader)
>> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_2
>> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_0
>> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_5
>> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_3
>> unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_1
>> unc_iio_data_req_of_cpu.mem_write.part1		uncore_iio_4
>> ......
>>
>> For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
>> "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
>> It's not a new leader for this PMU.
>>
>> But if we use "(leader->pmu_name == evsel->pmu_name)", the check
>> would be failed and the event is stored to leaders[] as a new
>> PMU leader.
>>
>> So this patch uses strcmp to compare the PMU name between events.
>>
>> Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> looks good, any chance we could have automated test
> for this uncore leader setup logic? like maybe the way
> John did the pmu-events tests? like test will trigger
> only when there's the pmu/events in the system
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka

Hi jirka,

JFYI, this is effectively the same patch as I mentioned to you, which 
was a fix for the same WARN:

https://lore.kernel.org/linux-arm-kernel/1587120084-18990-2-git-send-email-john.garry@huawei.com/

but I found that it "fixed" d4953f7ef1a2 ("perf parse-events: Fix 3 use 
after frees found with clang ASANutil/parse-events.c"), based on bisect 
breakage

cheers

> 
> 
>> ---
>>   tools/perf/util/parse-events.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 10107747b361..786eddb6a097 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1629,12 +1629,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>>   		 * event. That can be used to distinguish the leader from
>>   		 * other members, even they have the same event name.
>>   		 */
>> -		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
>> +		if ((leader != evsel) &&
>> +		    !strcmp(leader->pmu_name, evsel->pmu_name)) {
>>   			is_leader = false;
>>   			continue;
>>   		}
>> -		/* The name is always alias name */
>> -		WARN_ON(strcmp(leader->name, evsel->name));
>>   
>>   		/* Store the leader event for each PMU */
>>   		leaders[nr_pmu++] = (uintptr_t) evsel;
>> -- 
>> 2.17.1
>>
> 
> .
> 

