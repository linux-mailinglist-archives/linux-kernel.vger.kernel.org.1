Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE432B1526
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 05:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKMEkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 23:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKMEkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:40:07 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C260C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:40:07 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d3so3962630plo.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 20:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZdGJKvUHfjSZxccywlZ5NDaKSS3DQHpSVZq8TvPi688=;
        b=hcih0RACqTtBfprylV7K1jR5a9CpJiRd1I2ucaRYRQEgAkr2def95CaB8XEExnbnd+
         Jl7mHBXfgvJp7wwtFEKDUHvWlOqnbpf0whODWDNiZnqHcisuYzM2VV+jj1Qm1Cp64nhq
         rgr2z8aEVrsu3U6sDpQ8c6EwggyHE4qsa9Q0WGNiuXxdIli1GxJL6ZUrcFVZSL8e0kEU
         I3uor/A8cXUv19jX8stOgPzmzY+uhg+VT1SHAVViiRbjarIZRlcxGk2ziyMHFWtGdsxQ
         Yp0qCdhLTDkzhPfPaQp3+47FQWzWBwmg4gs5fxFkgKoXJ7CZoGg9aiRRcJHlrEVUg726
         wltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZdGJKvUHfjSZxccywlZ5NDaKSS3DQHpSVZq8TvPi688=;
        b=K0Fpr1zkpOnraL51vXXtr36YETh2MDjcvPuo7S2RQLzLM5F8m8tb0dh3kinmtJmJR0
         C8uVjFBLQBMx9d+cg3kzGGABS/6DZJpHX6m+gCQL/VKd0jkN49aWuOC+BEE1kbAk8SOE
         AWunrzv6Uk/dmQq6djXX/3LIetoVXTyoj4qNYdsc2EioamTdEuMemtqutce2Lk15zGOF
         42Qjz1+6HGMJyQpHwoCLhG/1a1Vt8EQOLGV+eVc+JIif504WtNLSfpC5uon9E8ncNyvf
         YejUKdKWVbHC8GmmcQIPq4o3pb6Rc5zyS2HkxOx3ZiuTw14qhy0qzycn2gtRVylbHSLl
         Bsew==
X-Gm-Message-State: AOAM5330WBQqTwJBf6Qw1QnVs3zwLE2otQUoZOYyC5pohO1rWgp0aiCe
        Hx3dfsrGlPvTJ/I6PvzdcBeD6vjVvNw=
X-Google-Smtp-Source: ABdhPJyQ4DDgDXvfR5gfXcTSc+wHuPnpDOoDjjVNP/WI+/qUoAwrPnVAKq6fnubUkzyyTSMCrE0P3g==
X-Received: by 2002:a17:902:968f:b029:d8:d0c6:969b with SMTP id n15-20020a170902968fb02900d8d0c6969bmr618769plp.69.1605242406848;
        Thu, 12 Nov 2020 20:40:06 -0800 (PST)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id h14sm8301333pfr.32.2020.11.12.20.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 20:40:06 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 13 Nov 2020 13:40:00 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/24] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201113044000.GC167797@google.com>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-25-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109215415.400153-25-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> Adding --buildid-mmap option to enable build id in mmap2 events.
> It will only work if there's kernel support for that and it disables
> build id cache (implies --no-buildid).
> 
> It's also possible to enable it permanently via config option
> in ~.perfconfig file:
> 
>   [record]
>   build-id=mmap

You also need to update the documentation.

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
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt  |  3 +++
>  tools/perf/builtin-record.c               | 20 ++++++++++++++++++++
>  tools/perf/util/evsel.c                   | 10 ++++++----
>  tools/perf/util/perf_api_probe.c          | 10 ++++++++++
>  tools/perf/util/perf_api_probe.h          |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  1 +
>  tools/perf/util/record.h                  |  1 +
>  7 files changed, 42 insertions(+), 4 deletions(-)
> 
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
> index adf311d15d3d..47bae9d82d43 100644
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
> @@ -2139,6 +2140,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  			rec->no_buildid_cache = true;
>  		else if (!strcmp(value, "skip"))
>  			rec->no_buildid = true;
> +		else if (!strcmp(value, "mmap"))
> +			rec->buildid_mmap = true;
>  		else
>  			return -1;
>  		return 0;
> @@ -2554,6 +2557,8 @@ static struct option __record_options[] = {
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
>  		    "Record build-id of all DSOs regardless of hits"),
> +	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> +		    "Record build-id in map events"),
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

I'm afraid this can make it miss some build-id in the end because of
the possibility of the failure.


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
> index e67a227c0ce7..0f1c62d40a89 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -134,6 +134,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(bpf_event, p_unsigned);
>  	PRINT_ATTRf(aux_output, p_unsigned);
>  	PRINT_ATTRf(cgroup, p_unsigned);
> +	PRINT_ATTRf(build_id, p_unsigned);

You might want to add the missing text_poke bit too. :)

Thanks,
Namhyung

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
