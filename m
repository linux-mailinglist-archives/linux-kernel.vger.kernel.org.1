Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF42C5AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404433AbgKZRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404073AbgKZRkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:40:40 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DFB2075A;
        Thu, 26 Nov 2020 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412439;
        bh=TmmdI4B3flnIqKH60F95/+76DKklNRzSzOacx4YZK2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0wSS2NjExl0yMl+tSFiwjuhaBvJvlXmqLSY+j8xrqL0tzA1Ueu0BY4xJ/I6CsAx/
         TrHyNj4sumIgzxS+74GCrrEsSsfWfK3Goqb84SCf0AyOJpalR/i1URfxJiYmZkCHP3
         o8+/rmkt9gDSN7TZ8biiX/EOcGcyV3tBG3n5sf84=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 040A640E29; Thu, 26 Nov 2020 14:40:36 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:40:36 -0300
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
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 25/25] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201126174036.GG53384@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-26-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-26-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:26PM +0100, Jiri Olsa escreveu:

> Adding --buildid-mmap option to enable build id in mmap2 events.  It
> will only work if there's kernel support for that and it disables
> build id cache (implies --no-buildid).
 
> It's also possible to enable it permanently via config option in
> ~.perfconfig file:
 
>   [record]
>   build-id=mmap
 
> Also added build_id bit in the verbose output for perf_event_attr:
 
>   # perf record --buildid-mmap -vv
>   ...
>   perf_event_attr:
>     type                             1
>     size                             120
>     ...
>     build_id                         1
 
> Adding also missing text_poke bit.
 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

<SNIP>

> @@ -2554,6 +2557,8 @@ static struct option __record_options[] = {
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
>  		    "Record build-id of all DSOs regardless of hits"),
> +	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> +		    "Record build-id in map events"),

Stephane, do you think it would be a problem to use
perf_can_record_build_id() at tool start and if it says that we can get
those mmaps with build ids use it by default? Older perf tools would get
that new bit and bogus values for that maj/min/ino_generation things,
people noticing such problems would either update their tools or ask for
the use of --no-buildid-mmap in 'perf record' sessions.

The problem I see is that this is important information to have by
default, forcing the user to add more and more command line opt-in
options doesn't seem interesting.

Having it as a .perfconfig variable helps, but then we at some point
need to start shipping some example .perfconfig to enable all these new
features so that the user can, with just one step, have all the modern
goodies.

- Arnaldo

>  	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
>  		    "append timestamp to output filename"),
>  	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> @@ -2657,6 +2662,21 @@ int cmd_record(int argc, const char **argv)
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
> index 1cad6051d8b0..749d806ee1d1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1170,10 +1170,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
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
