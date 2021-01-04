Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8892E932A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbhADKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbhADKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609755311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mcRb5nb+vVWP8bKhivB1LexBMr6zHZtbLYRKdVRNTQ=;
        b=J1f5KEVL95s2itkUUHyeYIGM5lufMWhynZ4H26oQJFSHqXi7QiWDkG32/AIFt0NSBuARyh
        LbMluUzYJsQejs8cZtcCL0OSH+SUMVXmpeSr2PFFGpiQzVJW0suC1qH+m0MAEO5Fkn1N8W
        U5WLIE3rvOH9xce0ITlo+cTWg7Llsjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-DT3HskndNmqGSCYPd8uFUw-1; Mon, 04 Jan 2021 05:15:09 -0500
X-MC-Unique: DT3HskndNmqGSCYPd8uFUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D44E7107ACE3;
        Mon,  4 Jan 2021 10:15:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3590E61F20;
        Mon,  4 Jan 2021 10:15:05 +0000 (UTC)
Date:   Mon, 4 Jan 2021 11:15:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
Subject: Re: [PATCH v3] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210104101504.GA878104@krava>
References: <20201225010409.29441-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225010409.29441-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 09:04:09AM +0800, Jin Yao wrote:

SNIP

>  void update_stats(struct stats *stats, u64 val)
> @@ -275,16 +276,39 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
>  
>  static void zero_per_pkg(struct evsel *counter)
>  {
> -	if (counter->per_pkg_mask)
> -		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
> +	struct hashmap_entry *entry;
> +	size_t bkt;
> +
> +	if (counter->per_pkg_mask) {
> +		hashmap__for_each_entry(counter->per_pkg_mask, entry, bkt) {
> +			bool *used = (bool *)entry->value;
> +
> +			*used = false;
> +		}
> +	}
> +}
> +
> +static size_t id_hash(const void *key, void *ctx __maybe_unused)
> +{
> +	int socket = (int64_t)key >> 32;
> +
> +	return socket;
> +}
> +
> +static bool id_equal(const void *key1, const void *key2,
> +		     void *ctx __maybe_unused)
> +{
> +	return (int64_t)key1 == (int64_t)key2;
>  }

please use more descriptive names, pkg_id_hash/pkg_id_equal or such

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
> +	bool *used;
>  
>  	*skip = false;
>  
> @@ -295,7 +319,7 @@ static int check_per_pkg(struct evsel *counter,
>  		return 0;
>  
>  	if (!mask) {
> -		mask = zalloc(cpu__max_cpu());
> +		mask = hashmap__new(id_hash, id_equal, NULL);
>  		if (!mask)
>  			return -ENOMEM;
>  
> @@ -317,7 +341,32 @@ static int check_per_pkg(struct evsel *counter,
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
> +	if (hashmap__find(mask, (void *)key, (void **)&used)) {
> +		if (*used)
> +			*skip = true;
> +		*used = true;
> +	} else {
> +		used = zalloc(sizeof(*used));
> +		if (!used)
> +			return -1;

hum, what's the point of having extra bool value? once the
item is in the hashtab, we have the answer

I think you can add item to hashtab with '1' value and get
rid of that bool allocation

zero_per_pkg will be just removing all items from hashtab

jirka

