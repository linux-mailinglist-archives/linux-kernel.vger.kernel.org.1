Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D574E2F406D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbhAMAoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:44:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:32711 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbhAMAnq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:43:46 -0500
IronPort-SDR: 05Pgf308bvC9AzpW60l0XhG4s2bKur5i0aC5Aun6/6cGpGTEqeS0FfO9OnnMsNyjH+dYlw4dkX
 NpZShOETil2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="175548296"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="175548296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 16:42:00 -0800
IronPort-SDR: xm80uJzFWdo4c2Bj8uSE9MoKXNd2A96Kd/I8AQxau2VSKF6gfqBtHIKoVnV7oCv+fn+S1c5Ft3
 L6YmJnDP8xlw==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="381641805"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 16:41:56 -0800
Subject: Re: [PATCH v4] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20210105023615.5761-1-yao.jin@linux.intel.com>
 <20210112100452.GA1273297@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <05e6bb37-0193-341d-3460-f5eb1d04bd05@linux.intel.com>
Date:   Wed, 13 Jan 2021 08:41:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112100452.GA1273297@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/12/2021 6:04 PM, Jiri Olsa wrote:
> On Tue, Jan 05, 2021 at 10:36:15AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index 8ce1479c98f0..a658e0ffaf2a 100644
>> --- a/tools/perf/util/stat.c
>> +++ b/tools/perf/util/stat.c
>> @@ -13,6 +13,7 @@
>>   #include "evlist.h"
>>   #include "evsel.h"
>>   #include "thread_map.h"
>> +#include "hashmap.h"
>>   #include <linux/zalloc.h>
>>   
>>   void update_stats(struct stats *stats, u64 val)
>> @@ -276,15 +277,29 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>>   static void zero_per_pkg(struct evsel *counter)
>>   {
>>   	if (counter->per_pkg_mask)
>> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
>> +		hashmap__clear(counter->per_pkg_mask);
>> +}
>> +
>> +static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
>> +{
>> +	int socket = (int64_t)key >> 32;
>> +
>> +	return socket;
> 
> could be just simple return right, why the variable?
> 

Sure, just simple return should be OK.

>> +}
>> +
>> +static bool pkg_id_equal(const void *key1, const void *key2,
>> +			 void *ctx __maybe_unused)
>> +{
>> +	return (int64_t)key1 == (int64_t)key2;
>>   }
>>   
>>   static int check_per_pkg(struct evsel *counter,
>>   			 struct perf_counts_values *vals, int cpu, bool *skip)
>>   {
>> -	unsigned long *mask = counter->per_pkg_mask;
>> +	struct hashmap *mask = counter->per_pkg_mask;
>>   	struct perf_cpu_map *cpus = evsel__cpus(counter);
>> -	int s;
>> +	int s, d, ret;
>> +	uint64_t key;
>>   
>>   	*skip = false;
>>   
>> @@ -295,7 +310,7 @@ static int check_per_pkg(struct evsel *counter,
>>   		return 0;
>>   
>>   	if (!mask) {
>> -		mask = zalloc(cpu__max_cpu());
>> +		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>>   		if (!mask)
>>   			return -ENOMEM;
>>   
>> @@ -317,7 +332,23 @@ static int check_per_pkg(struct evsel *counter,
>>   	if (s < 0)
>>   		return -1;
>>   
>> -	*skip = test_and_set_bit(s, mask) == 1;
>> +	/*
>> +	 * On multi-die system, 0 < die_id < 256. On no-die system, die_id = 0.
>> +	 * We use hashmap(socket, die) to check the used socket+die pair.
>> +	 */
>> +	d = cpu_map__get_die(cpus, cpu, NULL).die;
>> +	if (d < 0)
>> +		return -1;
>> +
>> +	key = (uint64_t)s << 32 | (d & 0xff);
> 
> why the masking for d? also I thought it could be bigger than 256
> 

I remember in previous perf tool it would show a warning "The die id number is too big" if die_id > 
256 and cpu_map__get_die() returned -1. See commit db5742b6849e ("perf stat: Support per-die 
aggregation").

But now the die_id checking is removed.

> would it better to do it the other way around?
> 
>     die << 32 | socket
> 

I think this way is OK, thanks! I will use it in v5.

> 
>> +	if (hashmap__find(mask, (void *)key, NULL)) {
>> +		*skip = true;
>> +	} else {
>> +		ret = hashmap__add(mask, (void *)key, (void *)1);
>> +		if (ret)
>> +			return -1;
> 
> you could 'return ret' at the end and skip this extra check
> 

Yes, define int ret = 0 and just 'return ret' at the end of function.

Thanks
Jin Yao

> thanks,
> jirka
> 
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.17.1
>>
> 
