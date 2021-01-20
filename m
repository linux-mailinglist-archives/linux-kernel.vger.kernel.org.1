Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193B82FDC98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhATW1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbhATWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611180465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HKTGvlB5508sq1Vw3juT+Gu/KQ2NtNf397mXTHTqHIg=;
        b=DhTHPgIfTkF0JBNfG0qgASu8qwZRzCSZLacQ2UZEWPcX0CA4ARJOSohB7beooYMQ2JsOwi
        +Vw98sMfUToswOTYt1ZVcxH46XgdQr9DOi4NVk7MWH2q7bLZtoZrPQpWtGdRSL9/lqblXS
        jE0NjfoLzH/NwCnH5RFM4sDAdmn7Owo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-xIOkXQrVOiua3yusp6ERYw-1; Wed, 20 Jan 2021 17:07:41 -0500
X-MC-Unique: xIOkXQrVOiua3yusp6ERYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7528C59;
        Wed, 20 Jan 2021 22:07:39 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 182435C8A7;
        Wed, 20 Jan 2021 22:07:36 +0000 (UTC)
Date:   Wed, 20 Jan 2021 23:07:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v7] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210120220735.GE1798087@krava>
References: <20210118040521.31003-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118040521.31003-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:05:21PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 8ce1479c98f0..5aba8fa92386 100644
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
> @@ -276,15 +277,27 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>  static void zero_per_pkg(struct evsel *counter)
>  {
>  	if (counter->per_pkg_mask)
> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
> +		hashmap__clear(counter->per_pkg_mask);
> +}
> +
> +static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
> +{
> +	return (size_t)key & 0xffff;
> +}
> +
> +static bool pkg_id_equal(const void *key1, const void *key2,
> +			 void *ctx __maybe_unused)
> +{
> +	return (size_t)key1 == (size_t)key2;
>  }
>  
>  static int check_per_pkg(struct evsel *counter,
>  			 struct perf_counts_values *vals, int cpu, bool *skip)
>  {
> -	unsigned long *mask = counter->per_pkg_mask;
> +	struct hashmap *mask = counter->per_pkg_mask;
>  	struct perf_cpu_map *cpus = evsel__cpus(counter);
> -	int s;
> +	int s, d, ret = 0;
> +	size_t key;

please use uint32_t to make it obvious

>  
>  	*skip = false;
>  
> @@ -295,7 +308,7 @@ static int check_per_pkg(struct evsel *counter,
>  		return 0;
>  
>  	if (!mask) {
> -		mask = zalloc(cpu__max_cpu());
> +		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
>  		if (!mask)
>  			return -ENOMEM;
>  
> @@ -317,8 +330,21 @@ static int check_per_pkg(struct evsel *counter,
>  	if (s < 0)
>  		return -1;
>  
> -	*skip = test_and_set_bit(s, mask) == 1;
> -	return 0;
> +	/*
> +	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
> +	 * We use hashmap(socket, die) to check the used socket+die pair.
> +	 */
> +	d = cpu_map__get_die(cpus, cpu, NULL).die;
> +	if (d < 0)
> +		return -1;
> +
> +	key = (size_t)d << 16 | s;

I'm not sure about the socket number bounds, but I guess we should at
least check that it's not over the limit

how hard would it be to allocate key values and keep the uint64_t?

thanks,
jirka

