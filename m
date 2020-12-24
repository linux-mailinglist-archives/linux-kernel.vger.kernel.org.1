Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20782E2761
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgLXNdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:33:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:16208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgLXNdJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:33:09 -0500
IronPort-SDR: ROg/clxo9AvwTUpLuRmuH+GxUp44MLIE5Ql7g3MTfDK6Aym5EHyrEsC8YSkXSuPAqEQVVh8ArQ
 IJTethLkkf0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="176298776"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="176298776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 05:31:21 -0800
IronPort-SDR: dMOWlYPDbJzcb/x8Pa0VjK1F4WbJiVQnJyQnse+FjxvypV+gFFibCibwntfEIE0aniwa94T2Nb
 YGOlWlMFjCpg==
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="374411709"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.29.136]) ([10.255.29.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 05:31:16 -0800
Subject: Re: [PATCH v2] perf stat: Fix wrong skipping for per-die aggregation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        ying.huang@intel.com
References: <20201224125404.16268-1-yao.jin@linux.intel.com>
 <20201224132605.GE477817@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d4e7a365-fb98-9dc2-2fd5-107a51f3979f@linux.intel.com>
Date:   Thu, 24 Dec 2020 21:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201224132605.GE477817@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 12/24/2020 9:26 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 24, 2020 at 08:54:04PM +0800, Jin Yao escreveu:
>> Uncore becomes die-scope on Xeon Cascade Lake-AP and perf has supported
>> --per-die aggregation yet.
>>
>> One issue is found in check_per_pkg() for uncore events running on
>> AP system. On cascade Lake-AP, we have:
>>
>> S0-D0
>> S0-D1
>> S1-D0
>> S1-D1
> 
> So, I applied a series that refactors the perf stat aggregation code and
> your patch albeit applying cleanly, doesn't compile:
> 
>    CC       /tmp/build/perf/util/topdown.o
> util/stat.c: In function ‘check_per_pkg’:
> util/stat.c:348:6: error: incompatible types when assigning to type ‘int’ from type ‘struct aggr_cpu_id’
>    348 |  d = cpu_map__get_die(cpus, cpu, NULL);
>        |      ^~~~~~~~~~~~~~~~
> make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/util/stat.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> 
> 
> I'm still testing this to push publicly to my perf/core branch, but I'll
> push now to tmp.perf/core and you can go from there, ok?
> 

That's OK for me.

> This is what you should find there, just pushed:
> 
> 8d4852b468c38168 (HEAD -> perf/core, five/perf/core) perf stat aggregation: Add separate thread member
> b993381779da406c perf stat aggregation: Add separate core member
> ba2ee166d92b2010 perf stat aggregation: Add separate die member
> 1a270cb6b3cc1866 perf stat aggregation: Add separate socket member
> fcd83a35dd93b89d perf stat aggregation: Add separate node member
> ff5232956e074994 perf stat aggregation: Start using cpu_aggr_id in map
> d526e1a033e03ec4 perf cpumap: Drop in cpu_aggr_map struct
> cea6575fdccfc062 perf cpumap: Add new map type for aggregation
> 2760f5a14fe7aa46 perf stat: Replace aggregation ID with a struct
> fa265e59b81a09fa perf cpumap: Add new struct for cpu aggregation
> 91585846f105ef2e perf cpumap: Use existing allocator to avoid using malloc
> 23331eeb731a503a perf tests: Improve topology test to check all aggregation types
> b27d20ab1c6a1a77 perf tools: Update s390's syscall.tbl copy from the kernel sources
> c5ef52944a2d8001 perf tools: Update powerpc's syscall.tbl copy from the kernel sources
> 22ffc3f5598d2a51 perf s390: Move syscall.tbl check into check-headers.sh
> [acme@quaco perf]$
> 
> - Arnaldo
>   

BTW, do you think if this patchset also needs to replace the "struct perf_cpu_map" in "struct 
perf_evsel"? Otherwise the evsel->cpus will be inconsistent, right?

struct perf_evsel {
     ...
     struct perf_cpu_map    *cpus;
     struct perf_cpu_map    *own_cpus;
     ...
};

Thanks
Jin Yao

>> But in check_per_pkg(), S0-D1 and S1-D1 are skipped because the
>> mask bits for S0 and S1 have been set for S0-D0 and S1-D0. It doesn't
>> check die_id. So the counting for S0-D1 and S1-D1 are set to zero.
>> That's not correct.
>>
>> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>>       1.001460963 S0-D0           1            1317376 Bytes llc_misses.mem_read
>>       1.001460963 S0-D1           1             998016 Bytes llc_misses.mem_read
>>       1.001460963 S1-D0           1             970496 Bytes llc_misses.mem_read
>>       1.001460963 S1-D1           1            1291264 Bytes llc_misses.mem_read
>>       2.003488021 S0-D0           1            1082048 Bytes llc_misses.mem_read
>>       2.003488021 S0-D1           1            1919040 Bytes llc_misses.mem_read
>>       2.003488021 S1-D0           1             890752 Bytes llc_misses.mem_read
>>       2.003488021 S1-D1           1            2380800 Bytes llc_misses.mem_read
>>       3.005613270 S0-D0           1            1126080 Bytes llc_misses.mem_read
>>       3.005613270 S0-D1           1            2898176 Bytes llc_misses.mem_read
>>       3.005613270 S1-D0           1             870912 Bytes llc_misses.mem_read
>>       3.005613270 S1-D1           1            3388608 Bytes llc_misses.mem_read
>>       4.007627598 S0-D0           1            1124608 Bytes llc_misses.mem_read
>>       4.007627598 S0-D1           1            3884416 Bytes llc_misses.mem_read
>>       4.007627598 S1-D0           1             921088 Bytes llc_misses.mem_read
>>       4.007627598 S1-D1           1            4451840 Bytes llc_misses.mem_read
>>       5.001479927 S0-D0           1             963328 Bytes llc_misses.mem_read
>>       5.001479927 S0-D1           1            4831936 Bytes llc_misses.mem_read
>>       5.001479927 S1-D0           1             895104 Bytes llc_misses.mem_read
>>       5.001479927 S1-D1           1            5496640 Bytes llc_misses.mem_read
>>
>>  From above output, we can see S0-D1 and S1-D1 don't report the interval
>> values, they are continued to grow. That's because check_per_pkg() wrongly
>> decides to use zero counts for S0-D1 and S1-D1.
>>
>> So in check_per_pkg(), we should use hashmap(socket,die) to decide if
>> the cpu counts needs to skip. Only considering socket is not enough.
>>
>> Now with this patch,
>>
>> root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
>>       1.001617187 S0-D0           1             952768 Bytes llc_misses.mem_read
>>       1.001617187 S0-D1           1             849152 Bytes llc_misses.mem_read
>>       1.001617187 S1-D0           1             854912 Bytes llc_misses.mem_read
>>       1.001617187 S1-D1           1             948672 Bytes llc_misses.mem_read
>>       2.004138021 S0-D0           1            1200256 Bytes llc_misses.mem_read
>>       2.004138021 S0-D1           1             899840 Bytes llc_misses.mem_read
>>       2.004138021 S1-D0           1             898752 Bytes llc_misses.mem_read
>>       2.004138021 S1-D1           1            1039424 Bytes llc_misses.mem_read
>>       3.006463971 S0-D0           1            1029056 Bytes llc_misses.mem_read
>>       3.006463971 S0-D1           1             894336 Bytes llc_misses.mem_read
>>       3.006463971 S1-D0           1             905088 Bytes llc_misses.mem_read
>>       3.006463971 S1-D1           1            1042880 Bytes llc_misses.mem_read
>>       4.008831441 S0-D0           1             920576 Bytes llc_misses.mem_read
>>       4.008831441 S0-D1           1             877248 Bytes llc_misses.mem_read
>>       4.008831441 S1-D0           1             883968 Bytes llc_misses.mem_read
>>       4.008831441 S1-D1           1             967168 Bytes llc_misses.mem_read
>>       5.001441349 S0-D0           1             864704 Bytes llc_misses.mem_read
>>       5.001441349 S0-D1           1             827456 Bytes llc_misses.mem_read
>>       5.001441349 S1-D0           1             829632 Bytes llc_misses.mem_read
>>       5.001441349 S1-D1           1             925760 Bytes llc_misses.mem_read
>>
>> On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
>> is not changed.
>>
>> Reported-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c |  4 ++-
>>   tools/perf/util/evsel.h |  3 +-
>>   tools/perf/util/stat.c  | 61 +++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index c26ea82220bd..9715ed9b03f6 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -45,6 +45,7 @@
>>   #include "string2.h"
>>   #include "memswap.h"
>>   #include "util.h"
>> +#include "hashmap.h"
>>   #include "../perf-sys.h"
>>   #include "util/parse-branch-options.h"
>>   #include <internal/xyarray.h>
>> @@ -1377,7 +1378,8 @@ void evsel__exit(struct evsel *evsel)
>>   	zfree(&evsel->group_name);
>>   	zfree(&evsel->name);
>>   	zfree(&evsel->pmu_name);
>> -	zfree(&evsel->per_pkg_mask);
>> +	hashmap__free(evsel->per_pkg_mask);
>> +	evsel->per_pkg_mask = NULL;
>>   	zfree(&evsel->metric_events);
>>   	perf_evsel__object.fini(evsel);
>>   }
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index cd1d8dd43199..951628943fd0 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -17,6 +17,7 @@ struct cgroup;
>>   struct perf_counts;
>>   struct perf_stat_evsel;
>>   union perf_event;
>> +struct hashmap;
>>   
>>   typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>>   
>> @@ -110,7 +111,7 @@ struct evsel {
>>   	bool			merged_stat;
>>   	bool			reset_group;
>>   	bool			errored;
>> -	unsigned long		*per_pkg_mask;
>> +	struct hashmap		*per_pkg_mask;
>>   	struct evsel		*leader;
>>   	struct list_head	config_terms;
>>   	int			err;
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index 1e125e39ff84..15db4bda1266 100644
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
>> @@ -275,16 +276,39 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>>   
>>   static void zero_per_pkg(struct evsel *counter)
>>   {
>> -	if (counter->per_pkg_mask)
>> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
>> +	struct hashmap_entry *entry;
>> +	size_t bkt;
>> +
>> +	if (counter->per_pkg_mask) {
>> +		hashmap__for_each_entry(counter->per_pkg_mask, entry, bkt) {
>> +			bool *used = (bool *)entry->value;
>> +
>> +			*used = false;
>> +		}
>> +	}
>> +}
>> +
>> +static size_t id_hash(const void *key, void *ctx __maybe_unused)
>> +{
>> +	int socket = (int64_t)key >> 32;
>> +
>> +	return socket;
>> +}
>> +
>> +static bool id_equal(const void *key1, const void *key2,
>> +		     void *ctx __maybe_unused)
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
>> +	bool *used;
>>   
>>   	*skip = false;
>>   
>> @@ -295,7 +319,7 @@ static int check_per_pkg(struct evsel *counter,
>>   		return 0;
>>   
>>   	if (!mask) {
>> -		mask = zalloc(cpu__max_cpu());
>> +		mask = hashmap__new(id_hash, id_equal, NULL);
>>   		if (!mask)
>>   			return -ENOMEM;
>>   
>> @@ -317,7 +341,32 @@ static int check_per_pkg(struct evsel *counter,
>>   	if (s < 0)
>>   		return -1;
>>   
>> -	*skip = test_and_set_bit(s, mask) == 1;
>> +	/*
>> +	 * On multi-die system, 0 < die_id < 256. On no-die system, die_id = 0.
>> +	 * We use hashmap(socket, die) to check the used socket+die pair.
>> +	 */
>> +	d = cpu_map__get_die(cpus, cpu, NULL);
>> +	if (d < 0)
>> +		return -1;
>> +
>> +	key = (uint64_t)s << 32 | (d & 0xff);
>> +	if (hashmap__find(mask, (void *)key, (void **)&used)) {
>> +		if (*used)
>> +			*skip = true;
>> +		*used = true;
>> +	} else {
>> +		used = zalloc(sizeof(*used));
>> +		if (!used)
>> +			return -1;
>> +
>> +		*used = true;
>> +		ret = hashmap__add(mask, (void *)key, used);
>> +		if (ret) {
>> +			free(used);
>> +			return -1;
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.17.1
>>
> 
