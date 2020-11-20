Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4822BA894
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgKTLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgKTLJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:09:29 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985DFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:09:29 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so7545568pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cx/VeP/69F/4myVeK603V6gjyoOCkj1KmOc9oSKvjSY=;
        b=Bv2/D9zkziTr6argm9KMsev1NP0xZqfG8zpbZbxSuTiMGY+5pV1rZlWynZuFwuOX5o
         q05smyOI0vqMBBqVqAPzU1Vp7bHLXyQQiCeB3j5xa8gVlvdnqZ8Dk+2/l21vJBwsiRkk
         pNSgpEnRaVB6tOEFMvFTGHKEcRb+Qphre9HUNXazywaM0bwpOgrvhrvS1veoUgb/jTdA
         40H/nSpejTz+fCmWqIEp11iSW/AZF0KYe8RmZppM8HdgMVUxwhUWIUMMz4V6NgcsMw9T
         2WsVj5GGlMzGJ3/P8eFojE/GPE6VzhmSAZ71zXDOAYy4/C9+iyw0jW2rfcpgvPt7HLA9
         UIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cx/VeP/69F/4myVeK603V6gjyoOCkj1KmOc9oSKvjSY=;
        b=Co3cBfrUXiE35oQyu7G2LdJ34+sdGqNZF//wbG5ywTao+F0MoUHg/9oTBBIG3jRYvJ
         7IF0Ll5oq0h1TOD5Y44Jd+U19ioS/3gJtRLIBLOsIV/pHVZiEoY+ZToQI2IPJSR2IbSv
         +3n85KbhwuIIZ5HyDmFwJTIRXrRIdiCBKOVzbIv8MNiirAVqzFjOUUlSI0MGDidOBB/j
         kUD8HD++9cB1HzfbOQ4/HJAfA2w3r1n6Fl9p4qsnOLJR69sUZu2dErEBfC2Jrs+FC03s
         QJtU3uNcm13IkQ/UkNBPDP/uzuNLk0htpPz0rg1XetIQ66R6CrRWQoqqD4YfYZ2M209u
         VUGg==
X-Gm-Message-State: AOAM532rVwwKY0/j3cguyumQG/NLs64/NAV8XoCv+OUzzHKSfbzxkZpr
        2NZjGQwQ7qYcqjY+ZgFPY4A=
X-Google-Smtp-Source: ABdhPJw+QF+uub6z6ubzyV5Umbs8snzgBq9ReE60wDQWDusiEZn1u5SrknEr/rTkeN3p4PjHEBXhnw==
X-Received: by 2002:a17:90b:508:: with SMTP id r8mr4974126pjz.151.1605870568983;
        Fri, 20 Nov 2020 03:09:28 -0800 (PST)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id j25sm3139148pfa.199.2020.11.20.03.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:09:28 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 20 Nov 2020 20:09:16 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v3 08/12] perf record: introduce --threads=<spec> command
 line option
Message-ID: <20201120110916.GG94830@google.com>
References: <e9a74675-7323-14f4-ce60-32fa1e019111@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9a74675-7323-14f4-ce60-32fa1e019111@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:20:26PM +0300, Alexey Budankov wrote:
> 
> Provide --threads option in perf record command line interface.
> The option can have a value in the form of masks that specify
> cpus to be monitored with data streaming threads and its layout
> in system topology. The masks can be filtered using cpu mask
> provided via -C option.
> 
> The specification value can be user defined list of masks. Masks
> separated by colon define cpus to be monitored by one thread and
> affinity mask of that thread is separated by slash. For example:
> <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
> specifies parallel threads layout that consists of two threads
> with corresponding assigned cpus to be monitored.
> 
> The specification value can be a string e.g. "cpu", "core" or
> "socket" meaning creation of data streaming thread for every
> cpu or core or socket to monitor distinct cpus or cpus grouped
> by core or socket.
> 
> The option provided with no or empty value defaults to per-cpu
> parallel threads layout creating data streaming thread for every
> cpu being monitored.
> 
> Feature design and implementation are based on prototypes [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
[SNIP]
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f5e5175da6a1..fd0587d636b2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3097,6 +3173,17 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
>  		set_bit(cpus->map[c], mask->bits);
>  }
>  
> +static void record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, char *mask_spec)
> +{
> +	struct perf_cpu_map *cpus;
> +
> +	cpus = perf_cpu_map__new(mask_spec);
> +	if (cpus) {
> +		record__mmap_cpu_mask_init(mask, cpus);
> +		free(cpus);

Would be better to use perf_cpu_map__put().


> +	}
> +}
> +
>  static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
>  {
>  	int t, ret;
> @@ -3116,6 +3203,196 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
>  
>  	return 0;
>  }
> +
> +static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int t, ret, nr_cpus = perf_cpu_map__nr(cpus);
> +
> +	ret = record__alloc_thread_masks(rec, nr_cpus, cpu__max_cpu());
> +	if (ret)
> +		return ret;
> +
> +	rec->nr_threads = nr_cpus;
> +	pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		set_bit(cpus->map[t], rec->thread_masks[t].maps.bits);
> +		pr_debug("thread_masks[%d]: maps mask [%d]\n", t, cpus->map[t]);
> +		set_bit(cpus->map[t], rec->thread_masks[t].affinity.bits);
> +		pr_debug("thread_masks[%d]: affinity mask [%d]\n", t, cpus->map[t]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_map *cpus,
> +					  char **maps_spec, char **affinity_spec, u32 nr_spec)
> +{
> +	u32 s;
> +	int ret, nr_threads = 0;
> +	struct mmap_cpu_mask cpus_mask;
> +	struct thread_mask thread_mask, full_mask;
> +
> +	ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu());
> +	if (ret)
> +		return ret;
> +	record__mmap_cpu_mask_init(&cpus_mask, cpus);
> +	ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +	if (ret)
> +		return ret;
> +	ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu());
> +	if (ret)
> +		return ret;
> +	record__thread_mask_clear(&full_mask);
> +
> +	for (s = 0; s < nr_spec; s++) {
> +		record__thread_mask_clear(&thread_mask);
> +
> +		record__mmap_cpu_mask_init_spec(&thread_mask.maps, maps_spec[s]);
> +		record__mmap_cpu_mask_init_spec(&thread_mask.affinity, affinity_spec[s]);
> +
> +		if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
> +				cpus_mask.bits, thread_mask.maps.nbits) ||
> +		    !bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
> +				cpus_mask.bits, thread_mask.affinity.nbits))
> +			continue;
> +
> +		ret = record__thread_mask_intersects(&thread_mask, &full_mask);
> +		if (ret)
> +			return ret;
> +		record__thread_mask_or(&full_mask, &full_mask, &thread_mask);
> +
> +		rec->thread_masks = realloc(rec->thread_masks,
> +					    (nr_threads + 1) * sizeof(struct thread_mask));
> +		if (!rec->thread_masks) {
> +			pr_err("Failed to allocate thread masks\n");
> +			return -ENOMEM;

It'll leak previous rec->thread_masks as well as cpu/thread/full masks.


> +		}
> +		rec->thread_masks[nr_threads] = thread_mask;
> +		pr_debug("thread_masks[%d]: addr=", nr_threads);
> +		mmap_cpu_mask__scnprintf(&rec->thread_masks[nr_threads].maps, "maps");
> +		pr_debug("thread_masks[%d]: addr=", nr_threads);
> +		mmap_cpu_mask__scnprintf(&rec->thread_masks[nr_threads].affinity, "affinity");
> +		nr_threads++;
> +		ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +		if (ret)
> +			return ret;
> +	}
> +
> +	rec->nr_threads = nr_threads;
> +	pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
> +
> +	record__mmap_cpu_mask_free(&cpus_mask);
> +	record__thread_mask_free(&thread_mask);
> +	record__thread_mask_free(&full_mask);
> +
> +	return 0;
> +}
> +
> +static int record__init_thread_core_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int ret;
> +	struct cpu_topology *topo;
> +
> +	topo = cpu_topology__new();
> +	if (!topo)
> +		return -EINVAL;
> +
> +	ret = record__init_thread_masks_spec(rec, cpus, topo->thread_siblings,
> +					     topo->thread_siblings, topo->thread_sib);
> +	cpu_topology__delete(topo);
> +
> +	return ret;
> +}
> +
> +static int record__init_thread_socket_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int ret;
> +	struct cpu_topology *topo;
> +
> +	topo = cpu_topology__new();
> +	if (!topo)
> +		return -EINVAL;
> +
> +	ret = record__init_thread_masks_spec(rec, cpus, topo->core_siblings,
> +					     topo->core_siblings, topo->core_sib);
> +	cpu_topology__delete(topo);
> +
> +	return ret;
> +}
> +
> +static int record__init_thread_numa_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	u32 s;
> +	int ret;
> +	char **spec;
> +	struct numa_topology *topo;
> +
> +	topo = numa_topology__new();
> +	if (!topo)
> +		return -EINVAL;
> +	spec = zalloc(topo->nr * sizeof(char *));
> +	if (!spec)
> +		return -ENOMEM;

Will leak topo.


> +	for (s = 0; s < topo->nr; s++)
> +		spec[s] = topo->nodes[s].cpus;
> +
> +	ret = record__init_thread_masks_spec(rec, cpus, spec, spec, topo->nr);
> +
> +	zfree(&spec);
> +
> +	numa_topology__delete(topo);
> +
> +	return ret;
> +}
> +
> +static int record__init_thread_user_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int t, ret;
> +	u32 s, nr_spec = 0;
> +	char **maps_spec = NULL, **affinity_spec = NULL;
> +	char *spec, *spec_ptr, *user_spec, *mask, *mask_ptr;
> +
> +	for (t = 0, user_spec = (char *)rec->opts.threads_user_spec; ;t++, user_spec = NULL) {
> +		spec = strtok_r(user_spec, ":", &spec_ptr);
> +		if (spec == NULL)
> +			break;
> +		pr_debug(" spec[%d]: %s\n", t, spec);
> +		mask = strtok_r(spec, "/", &mask_ptr);
> +		if (mask == NULL)
> +			break;
> +		pr_debug("  maps mask: %s\n", mask);
> +		maps_spec = realloc(maps_spec, (nr_spec + 1) * sizeof(char *));
> +		if (!maps_spec) {
> +			pr_err("Failed to realloc maps_spec\n");
> +			return -ENOMEM;

Likewise, you can use a temp variable and bail out to free all
existing specs.

> +		}
> +		maps_spec[nr_spec] = strdup(mask);
> +		mask = strtok_r(NULL, "/", &mask_ptr);
> +		if (mask == NULL)
> +			break;
> +		pr_debug("  affinity mask: %s\n", mask);
> +		affinity_spec = realloc(affinity_spec, (nr_spec + 1) * sizeof(char *));
> +		if (!maps_spec) {
> +			pr_err("Failed to realloc affinity_spec\n");
> +			return -ENOMEM;

Ditto.

Thanks,
Namhyung


> +		}
> +		affinity_spec[nr_spec] = strdup(mask);
> +		nr_spec++;
> +	}
> +
> +	ret = record__init_thread_masks_spec(rec, cpus, maps_spec, affinity_spec, nr_spec);
> +
> +	for (s = 0; s < nr_spec; s++) {
> +		free(maps_spec[s]);
> +		free(affinity_spec[s]);
> +	}
> +	free(affinity_spec);
> +	free(maps_spec);
> +
> +	return ret;
> +}
> +
>  static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
>  {
>  	int ret;
> @@ -3133,9 +3410,33 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
>  
>  static int record__init_thread_masks(struct record *rec)
>  {
> +	int ret = 0;
>  	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
>  
> -	return record__init_thread_default_masks(rec, cpus);
> +	if (!record__threads_enabled(rec))
> +		return record__init_thread_default_masks(rec, cpus);
> +
> +	switch (rec->opts.threads_spec) {
> +	case THREAD_SPEC__CPU:
> +		ret = record__init_thread_cpu_masks(rec, cpus);
> +		break;
> +	case THREAD_SPEC__CORE:
> +		ret = record__init_thread_core_masks(rec, cpus);
> +		break;
> +	case THREAD_SPEC__SOCKET:
> +		ret = record__init_thread_socket_masks(rec, cpus);
> +		break;
> +	case THREAD_SPEC__NUMA:
> +		ret = record__init_thread_numa_masks(rec, cpus);
> +		break;
> +	case THREAD_SPEC__USER:
> +		ret = record__init_thread_user_masks(rec, cpus);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
>  }
>  
>  static int record__fini_thread_masks(struct record *rec)
> @@ -3361,7 +3662,10 @@ int cmd_record(int argc, const char **argv)
>  
>  	err = record__init_thread_masks(rec);
>  	if (err) {
> -		pr_err("record__init_thread_masks failed, error %d\n", err);
> +		if (err > 0)
> +			pr_err("ERROR: parallel data streaming masks (--threads) intersect.\n");
> +		else
> +			pr_err("record__init_thread_masks failed, error %d\n", err);
>  		goto out;
>  	}
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 9c13a39cc58f..7f64ff5da2b2 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -75,6 +75,7 @@ struct record_opts {
>  	int	      ctl_fd_ack;
>  	bool	      ctl_fd_close;
>  	int	      threads_spec;
> +	const char    *threads_user_spec;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.24.1
> 
> 
