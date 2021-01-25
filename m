Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A63021F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhAYFvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:51:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:10068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbhAYFty (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:49:54 -0500
IronPort-SDR: ETdrO/6LtDV7bOpgb1WFvuEqTg2yuHOwDM8cuLZynuLdXUKGN4i6rHw7QcdsHTyFK3FzRXMiYh
 ufH9+OC7V3mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="179747475"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="179747475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 21:48:00 -0800
IronPort-SDR: t1dOHFYX6g9c4WNELNap3PsYwRyRuP+r1c72rTUbDzZ7BwbYC3m++xVe+rmSo4ARhl+4Eu0h+7
 BG79fagbCmWw==
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="387180608"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 21:47:56 -0800
Subject: Re: [PATCH v7] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20210118040521.31003-1-yao.jin@linux.intel.com>
 <20210120220735.GE1798087@krava>
 <dd75cc3f-9440-c33b-cea3-529134c33e80@linux.intel.com>
 <20210123225709.GB138414@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <de88878b-b184-b1a2-ad91-1069d81c4e53@linux.intel.com>
Date:   Mon, 25 Jan 2021 13:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123225709.GB138414@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/24/2021 6:57 AM, Jiri Olsa wrote:
> On Thu, Jan 21, 2021 at 12:21:36PM +0800, Jin, Yao wrote:
> 
> sNIP
> 
>> mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>> d = cpu_map__get_die(cpus, cpu, NULL).die;
>> key = (size_t)d << KEY_SHIFT | s;	/* s is socket id */
>> if (hashmap__find(mask, (void *)key, NULL))
>> 	*skip = true;
>> else
>> 	ret = hashmap__add(mask, (void *)key, (void *)1);
>>
>> If we use 'unsigned long' to replace 'size_t', it reports the build error for 32 bits:
>>
>> stat.c:320:23: warning: passing argument 1 of ‘hashmap__new’ from
>> incompatible pointer type [-Wincompatible-pointer-types]
>>     mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>>                         ^~~~~~~~~~~
>> In file included from stat.c:16:
>> hashmap.h:75:17: note: expected ‘hashmap_hash_fn’ {aka ‘unsigned int
>> (*)(const void *, void *)’} but argument is of type ‘long unsigned int
>> (*)(const void *, void *)’
>>
>> If we use "unsigned int", it's not good for 64 bits. So I still use 'size_t' in this patch.
>>
>> Any comments for this idea (using conditional compilation)?
> 
> isn't it simpler to allocate the key then? like below
> (just compile tested)
> 
> jirka
> 

Hmm, Each method has advantages and disadvantages.

My method uses conditional compilation but it looks a bit complicated. The advantage is it doesn't 
need to allocate the memory for key.

If you need me to post v8, I'd love to.

Anyway, either method is fine for me. :)

> 
> ---
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 5aba8fa92386..195fda142c98 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -276,19 +276,31 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>   
>   static void zero_per_pkg(struct evsel *counter)
>   {
> -	if (counter->per_pkg_mask)
> +	struct hashmap_entry *cur;
> +	size_t bkt;
> +
> +	if (counter->per_pkg_mask) {
> +		hashmap__for_each_entry(counter->per_pkg_mask, cur, bkt)
> +			free((char *)cur->key);
> +
>   		hashmap__clear(counter->per_pkg_mask);
> +	}
>   }
>   
> -static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
> +static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
>   {
> -	return (size_t)key & 0xffff;
> +	uint64_t *key = (uint64_t*) __key;
> +
> +	return *key & 0xffffffff;
>   }
>   
> -static bool pkg_id_equal(const void *key1, const void *key2,
> +static bool pkg_id_equal(const void *__key1, const void *__key2,
>   			 void *ctx __maybe_unused)
>   {
> -	return (size_t)key1 == (size_t)key2;
> +	uint64_t *key1 = (uint64_t*) __key1;
> +	uint64_t *key2 = (uint64_t*) __key2;
> +
> +	return *key1 == *key2;
>   }
>   
>   static int check_per_pkg(struct evsel *counter,
> @@ -297,7 +309,7 @@ static int check_per_pkg(struct evsel *counter,
>   	struct hashmap *mask = counter->per_pkg_mask;
>   	struct perf_cpu_map *cpus = evsel__cpus(counter);
>   	int s, d, ret = 0;
> -	size_t key;
> +	uint64_t *key;
>   
>   	*skip = false;
>   
> @@ -338,7 +350,11 @@ static int check_per_pkg(struct evsel *counter,
>   	if (d < 0)
>   		return -1;
>   
> -	key = (size_t)d << 16 | s;
> +	key = malloc(sizeof(*key));
> +	if (!key)
> +		return -ENOMEM;
> +
> +	*key = (size_t)d << 32 | s;

Should be "*key = (uint64_t)d << 32 | s;"?

Otherwise on 32 bits system, a build warning is:

stat.c: In function ‘check_per_pkg’:
stat.c:357:19: warning: left shift count >= width of type [-Wshift-count-overflow]
   *key = (size_t)d << 32 | s;

Thanks
Jin Yao

>   	if (hashmap__find(mask, (void *)key, NULL))
>   		*skip = true;
>   	else
> 
