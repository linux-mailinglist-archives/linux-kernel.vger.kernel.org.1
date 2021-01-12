Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8522F2C36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392926AbhALKG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390409AbhALKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610445902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlDpu4dN4eJIQ4lDN8BNeBYB1Uy/GfSqhDP7Yzilrg0=;
        b=RtKH3WNpifyiwU44/U7q6ZmPyDw/1/5yVHYTFm+TzJ3zJrrCKYncXadbBVNk6R4A5AcSqU
        u+rhbwyQykrH4eH6uf+dQ5V4BEdZF5fQjR/Wayv+A3GsZxsNwvsL8f+7u39gU5lS1Olhz/
        EVkaxGXpm5r6rI6dybhbo0bnEmdREhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-ogRCyP4LO4mrzcnFv_fcyA-1; Tue, 12 Jan 2021 05:04:57 -0500
X-MC-Unique: ogRCyP4LO4mrzcnFv_fcyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4390801AAB;
        Tue, 12 Jan 2021 10:04:55 +0000 (UTC)
Received: from krava (unknown [10.40.195.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 697E25D9DB;
        Tue, 12 Jan 2021 10:04:53 +0000 (UTC)
Date:   Tue, 12 Jan 2021 11:04:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v4] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210112100452.GA1273297@krava>
References: <20210105023615.5761-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105023615.5761-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 10:36:15AM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 8ce1479c98f0..a658e0ffaf2a 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -13,6 +13,7 @@
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "thread_map.h"
> +#include "hashmap.h"
>  #include <linux/zalloc.h>
>  
>  void update_stats(struct stats *stats, u64 val)
> @@ -276,15 +277,29 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>  static void zero_per_pkg(struct evsel *counter)
>  {
>  	if (counter->per_pkg_mask)
> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
> +		hashmap__clear(counter->per_pkg_mask);
> +}
> +
> +static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
> +{
> +	int socket = (int64_t)key >> 32;
> +
> +	return socket;

could be just simple return right, why the variable?

> +}
> +
> +static bool pkg_id_equal(const void *key1, const void *key2,
> +			 void *ctx __maybe_unused)
> +{
> +	return (int64_t)key1 == (int64_t)key2;
>  }
>  
>  static int check_per_pkg(struct evsel *counter,
>  			 struct perf_counts_values *vals, int cpu, bool *skip)
>  {
> -	unsigned long *mask = counter->per_pkg_mask;
> +	struct hashmap *mask = counter->per_pkg_mask;
>  	struct perf_cpu_map *cpus = evsel__cpus(counter);
> -	int s;
> +	int s, d, ret;
> +	uint64_t key;
>  
>  	*skip = false;
>  
> @@ -295,7 +310,7 @@ static int check_per_pkg(struct evsel *counter,
>  		return 0;
>  
>  	if (!mask) {
> -		mask = zalloc(cpu__max_cpu());
> +		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>  		if (!mask)
>  			return -ENOMEM;
>  
> @@ -317,7 +332,23 @@ static int check_per_pkg(struct evsel *counter,
>  	if (s < 0)
>  		return -1;
>  
> -	*skip = test_and_set_bit(s, mask) == 1;
> +	/*
> +	 * On multi-die system, 0 < die_id < 256. On no-die system, die_id = 0.
> +	 * We use hashmap(socket, die) to check the used socket+die pair.
> +	 */
> +	d = cpu_map__get_die(cpus, cpu, NULL).die;
> +	if (d < 0)
> +		return -1;
> +
> +	key = (uint64_t)s << 32 | (d & 0xff);

why the masking for d? also I thought it could be bigger than 256

would it better to do it the other way around?

   die << 32 | socket


> +	if (hashmap__find(mask, (void *)key, NULL)) {
> +		*skip = true;
> +	} else {
> +		ret = hashmap__add(mask, (void *)key, (void *)1);
> +		if (ret)
> +			return -1;

you could 'return ret' at the end and skip this extra check

thanks,
jirka

> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

