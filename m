Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311EE2FE094
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbhAUEZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:25:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:39167 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbhAUEX3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:23:29 -0500
IronPort-SDR: MuMF6/wtv+lKRWdsbC3o1XwNVKEYnPweQjUz3swnqkuCvTKcImlzoRPTcypUXZV6RJXyq6ElNH
 hI5jupV6PV7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158395239"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="158395239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 20:21:42 -0800
IronPort-SDR: ECKXBGBtW8XJceGcFi7lob4Vj/NmY2rJZYvqgy2GhqcXm7+mvNgpmAroo3/K+6O+/9X2LLhfIL
 SOey16jmD8Jw==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="385142858"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 20:21:39 -0800
Subject: Re: [PATCH v7] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20210118040521.31003-1-yao.jin@linux.intel.com>
 <20210120220735.GE1798087@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <dd75cc3f-9440-c33b-cea3-529134c33e80@linux.intel.com>
Date:   Thu, 21 Jan 2021 12:21:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120220735.GE1798087@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/21/2021 6:07 AM, Jiri Olsa wrote:
> On Mon, Jan 18, 2021 at 12:05:21PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index 8ce1479c98f0..5aba8fa92386 100644
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
>> @@ -276,15 +277,27 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>>   static void zero_per_pkg(struct evsel *counter)
>>   {
>>   	if (counter->per_pkg_mask)
>> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
>> +		hashmap__clear(counter->per_pkg_mask);
>> +}
>> +
>> +static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
>> +{
>> +	return (size_t)key & 0xffff;
>> +}
>> +
>> +static bool pkg_id_equal(const void *key1, const void *key2,
>> +			 void *ctx __maybe_unused)
>> +{
>> +	return (size_t)key1 == (size_t)key2;
>>   }
>>   
>>   static int check_per_pkg(struct evsel *counter,
>>   			 struct perf_counts_values *vals, int cpu, bool *skip)
>>   {
>> -	unsigned long *mask = counter->per_pkg_mask;
>> +	struct hashmap *mask = counter->per_pkg_mask;
>>   	struct perf_cpu_map *cpus = evsel__cpus(counter);
>> -	int s;
>> +	int s, d, ret = 0;
>> +	size_t key;
> 
> please use uint32_t to make it obvious
> 

Maybe we have to use size_t for better support for 32 bits and 64 bits platforms.

typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);

It defines size_t for hashmap_hash_fn.

I will explain more at below.

>>   
>>   	*skip = false;
>>   
>> @@ -295,7 +308,7 @@ static int check_per_pkg(struct evsel *counter,
>>   		return 0;
>>   
>>   	if (!mask) {
>> -		mask = zalloc(cpu__max_cpu());
>> +		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>>   		if (!mask)
>>   			return -ENOMEM;
>>   
>> @@ -317,8 +330,21 @@ static int check_per_pkg(struct evsel *counter,
>>   	if (s < 0)
>>   		return -1;
>>   
>> -	*skip = test_and_set_bit(s, mask) == 1;
>> -	return 0;
>> +	/*
>> +	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
>> +	 * We use hashmap(socket, die) to check the used socket+die pair.
>> +	 */
>> +	d = cpu_map__get_die(cpus, cpu, NULL).die;
>> +	if (d < 0)
>> +		return -1;
>> +
>> +	key = (size_t)d << 16 | s;
> 
> I'm not sure about the socket number bounds, but I guess we should at
> least check that it's not over the limit
> 
> how hard would it be to allocate key values and keep the uint64_t?
> 

I'm considering to use conditional compilation for supporting 32 bits platform and 64 bits platform.

#if BITS_PER_LONG == 64
#define KEY_SHIFT  32
#else
#define KEY_SHIFT  16
#endif

static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
{
        return (size_t)key & (~0ul >> KEY_SHIFT);
}

static bool pkg_id_equal(const void *key1, const void *key2,
                         void *ctx __maybe_unused)
{
        return (size_t)key1 == (size_t)key2;
}

mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
d = cpu_map__get_die(cpus, cpu, NULL).die;
key = (size_t)d << KEY_SHIFT | s;	/* s is socket id */
if (hashmap__find(mask, (void *)key, NULL))
	*skip = true;
else
	ret = hashmap__add(mask, (void *)key, (void *)1);

If we use 'unsigned long' to replace 'size_t', it reports the build error for 32 bits:

stat.c:320:23: warning: passing argument 1 of ‘hashmap__new’ from incompatible pointer type 
[-Wincompatible-pointer-types]
    mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
                        ^~~~~~~~~~~
In file included from stat.c:16:
hashmap.h:75:17: note: expected ‘hashmap_hash_fn’ {aka ‘unsigned int (*)(const void *, void *)’} but 
argument is of type ‘long unsigned int (*)(const void *, void *)’

If we use "unsigned int", it's not good for 64 bits. So I still use 'size_t' in this patch.

Any comments for this idea (using conditional compilation)?

Thanks
Jin Yao

> thanks,
> jirka
> 
