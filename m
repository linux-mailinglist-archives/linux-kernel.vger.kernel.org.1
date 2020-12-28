Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3F2E3B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404796AbgL1NpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391987AbgL1NpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:45:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91D5D22AAA;
        Mon, 28 Dec 2020 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609163063;
        bh=ecWJIXOObvXjNDuBv9XDqjlS22b4wjf8++7qFbttwes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZpbm6VbzmkfAO/dDhl5/fOyPjVxH6UQOVFLX8FTXTUBp8kd6t6x6xjtWpR+vMnJE
         mRzs+aP9GU5wP0fRQoBI/qP2/zKjmsWHS7Skm8TqAR7Gvac413CPonJfyiuAqxfWD9
         KkGD1jE+7ULBZ3oDJma6mREF5T1ovfSuUwBUEMdB5xJOwyE4aAXMvEZshpopYWC4To
         Eyz6pe63TK5/HKrV6zUh8f8XjJIZjcH6mu0pNc0hC3kmW2kFdlYV1Ye5r67W1Ijq+7
         ZyT0sbzlh0mjzRah2XSZYYvPEXOUjWZoEdd0+Y8Uz4ewG2EPYO1PgvtUjUTxxfRLKy
         GLBULrsFmkp4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B14B411E9; Mon, 28 Dec 2020 10:44:37 -0300 (-03)
Date:   Mon, 28 Dec 2020 10:44:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/15] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201228134437.GC521329@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-16-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214105457.543111-16-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 11:54:57AM +0100, Jiri Olsa escreveu:
> Adding --buildid-mmap option to enable build id in mmap2 events.
> It will only work if there's kernel support for that and it disables
> build id cache (implies --no-buildid).
> 
> It's also possible to enable it permanently via config option
> in ~.perfconfig file:
> 
>   [record]
>   build-id=mmap
> 
> Also added build_id bit in the verbose output for perf_event_attr:
> 
>   # perf record --buildid-mmap -vv
>   ...
>   perf_event_attr:
>     type                             1
>     size                             120
>     ...
>     build_id                         1
> 
> Adding also missing text_poke bit.

I'm moving this to just before the:

  perf tools: Add support to display build id when available in PERF_RECORD_MMAP2 events

So that I can actually print the synthesized/obtained from the kernel
build-ids, i.e. this:

  perf report -D | grep MMAP2 | head -4

Will work at that point.
 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-config.txt  |  3 ++-
>  tools/perf/Documentation/perf-record.txt  |  3 +++
>  tools/perf/builtin-record.c               | 20 ++++++++++++++++++++
>  tools/perf/util/evsel.c                   | 10 ++++++----
>  tools/perf/util/perf_api_probe.c          | 10 ++++++++++
>  tools/perf/util/perf_api_probe.h          |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  2 ++
>  tools/perf/util/record.h                  |  1 +
>  8 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index e3672c5d801b..8a1c6c16821a 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -559,11 +559,12 @@ kmem.*::
>  
>  record.*::
>  	record.build-id::
> -		This option can be 'cache', 'no-cache' or 'skip'.
> +		This option can be 'cache', 'no-cache', 'skip' or 'mmap'.
>  		'cache' is to post-process data and save/update the binaries into
>  		the build-id cache (in ~/.debug). This is the default.
>  		But if this option is 'no-cache', it will not update the build-id cache.
>  		'skip' skips post-processing and does not update the cache.
> +		'mmap' skips post-processing and reads build-ids from MMAP events.
>  
>  	record.call-graph::
>  		This is identical to 'call-graph.record-mode', except it is
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 768888b9326a..1bcf51e24979 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -482,6 +482,9 @@ Specify vmlinux path which has debuginfo.
>  --buildid-all::
>  Record build-id of all DSOs regardless whether it's actually hit or not.
>  
> +--buildid-mmap::
> +Record build ids in mmap2 events, disables build id cache (implies --no-buildid).
> +
>  --aio[=n]::
>  Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default: 1, max: 4).
>  Asynchronous mode is supported only when linking Perf tool with libc library
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d832c108a1ca..f6bfad096756 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -102,6 +102,7 @@ struct record {
>  	bool			no_buildid_cache;
>  	bool			no_buildid_cache_set;
>  	bool			buildid_all;
> +	bool			buildid_mmap;
>  	bool			timestamp_filename;
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
> @@ -2135,6 +2136,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  			rec->no_buildid_cache = true;
>  		else if (!strcmp(value, "skip"))
>  			rec->no_buildid = true;
> +		else if (!strcmp(value, "mmap"))
> +			rec->buildid_mmap = true;
>  		else
>  			return -1;
>  		return 0;
> @@ -2550,6 +2553,8 @@ static struct option __record_options[] = {
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
>  		    "Record build-id of all DSOs regardless of hits"),
> +	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> +		    "Record build-id in map events"),
>  	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
>  		    "append timestamp to output filename"),
>  	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> @@ -2653,6 +2658,21 @@ int cmd_record(int argc, const char **argv)
>  
>  	}
>  
> +	if (rec->buildid_mmap) {
> +		if (!perf_can_record_build_id()) {
> +			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> +			err = -EINVAL;
> +			goto out_opts;
> +		}
> +		pr_debug("Enabling build id in mmap2 events.\n");
> +		/* Enable mmap build id synthesizing. */
> +		symbol_conf.buildid_mmap2 = true;
> +		/* Enable perf_event_attr::build_id bit. */
> +		rec->opts.build_id = true;
> +		/* Disable build id cache. */
> +		rec->no_buildid = true;
> +	}
> +
>  	if (rec->opts.kcore)
>  		rec->data.is_dir = true;
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3dd0eae9810d..191500c1f9f6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1168,10 +1168,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	if (opts->sample_weight)
>  		evsel__set_sample_bit(evsel, WEIGHT);
>  
> -	attr->task  = track;
> -	attr->mmap  = track;
> -	attr->mmap2 = track && !perf_missing_features.mmap2;
> -	attr->comm  = track;
> +	attr->task     = track;
> +	attr->mmap     = track;
> +	attr->mmap2    = track && !perf_missing_features.mmap2;
> +	attr->comm     = track;
> +	attr->build_id = track && opts->build_id;
> +
>  	/*
>  	 * ksymbol is tracked separately with text poke because it needs to be
>  	 * system wide and enabled immediately.
> diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
> index 3840d02f0f7b..829af17a0867 100644
> --- a/tools/perf/util/perf_api_probe.c
> +++ b/tools/perf/util/perf_api_probe.c
> @@ -98,6 +98,11 @@ static void perf_probe_text_poke(struct evsel *evsel)
>  	evsel->core.attr.text_poke = 1;
>  }
>  
> +static void perf_probe_build_id(struct evsel *evsel)
> +{
> +	evsel->core.attr.build_id = 1;
> +}
> +
>  bool perf_can_sample_identifier(void)
>  {
>  	return perf_probe_api(perf_probe_sample_identifier);
> @@ -172,3 +177,8 @@ bool perf_can_aux_sample(void)
>  
>  	return true;
>  }
> +
> +bool perf_can_record_build_id(void)
> +{
> +	return perf_probe_api(perf_probe_build_id);
> +}
> diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
> index d5506a983a94..f12ca55f509a 100644
> --- a/tools/perf/util/perf_api_probe.h
> +++ b/tools/perf/util/perf_api_probe.h
> @@ -11,5 +11,6 @@ bool perf_can_record_cpu_wide(void);
>  bool perf_can_record_switch_events(void);
>  bool perf_can_record_text_poke_events(void);
>  bool perf_can_sample_identifier(void);
> +bool perf_can_record_build_id(void);
>  
>  #endif // __PERF_API_PROBE_H
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index e67a227c0ce7..656a7fddfc26 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -134,6 +134,8 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(bpf_event, p_unsigned);
>  	PRINT_ATTRf(aux_output, p_unsigned);
>  	PRINT_ATTRf(cgroup, p_unsigned);
> +	PRINT_ATTRf(text_poke, p_unsigned);
> +	PRINT_ATTRf(build_id, p_unsigned);
>  
>  	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
>  	PRINT_ATTRf(bp_type, p_unsigned);
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 266760ac9143..609e706f4282 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -49,6 +49,7 @@ struct record_opts {
>  	bool	      no_bpf_event;
>  	bool	      kcore;
>  	bool	      text_poke;
> +	bool	      build_id;
>  	unsigned int  freq;
>  	unsigned int  mmap_pages;
>  	unsigned int  auxtrace_mmap_pages;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
