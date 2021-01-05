Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672FF2EA36D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbhAECmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:42:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:18699 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbhAECmF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:42:05 -0500
IronPort-SDR: Dpx/lcJzUpNBeVAJJziSTVuzSU8Xt0S68y7FXe4p8AUvC0x+17Wb2Bsh+eRLkzmYgFBglT4hL1
 4EPS0FVnkuWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164742610"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="164742610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:40:19 -0800
IronPort-SDR: 6ZdMQWZb2adVbzi/neRDymoOID2mVcchdMfi48V/Pito9Bl+sKWPN3KGSbPDQ0hDgwdJHPVzxo
 KM+nXjkDsL0A==
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="350181166"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:40:13 -0800
Subject: Re: [PATCH v3] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20201225010409.29441-1-yao.jin@linux.intel.com>
 <20210104101504.GA878104@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8de398fa-61c6-368c-33fc-a3fbfd25d881@linux.intel.com>
Date:   Tue, 5 Jan 2021 10:40:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210104101504.GA878104@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/4/2021 6:15 PM, Jiri Olsa wrote:
> On Fri, Dec 25, 2020 at 09:04:09AM +0800, Jin Yao wrote:
> 
> SNIP
> 
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
> 
> please use more descriptive names, pkg_id_hash/pkg_id_equal or such
> 

Corrected in v4.

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
>> +	d = cpu_map__get_die(cpus, cpu, NULL).die;
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
> 
> hum, what's the point of having extra bool value? once the
> item is in the hashtab, we have the answer
> 
> I think you can add item to hashtab with '1' value and get
> rid of that bool allocation
> 
> zero_per_pkg will be just removing all items from hashtab
> 
> jirka
> 

Thanks for the suggestion! Yes, we don't need the bool value allocation here, it's unnecessary.

I just post the v4. Please help to take a look.

Thanks
Jin Yao
