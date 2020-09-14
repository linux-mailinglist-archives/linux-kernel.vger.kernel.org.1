Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D085269140
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgINQFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:05:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90C220EDD;
        Mon, 14 Sep 2020 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099530;
        bh=lIpDRC7U1HEdZPN4rQQ5mhC9Pr0/b9wbrQb1f+asyps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SF0ITn3kBpcYx+VnP4+tztuY83KSCPl2P/ql4ILIOkZ3xgajzXzVLP7PLZJfWbRw0
         58q/mmIAWR/GxZebJrz0Hc9mfwmiPdc2x8H8dnFsDMVjdJcPigExAU+LES1XDlGK6T
         Ck/ByWoGfCnujxG/1UjZ2YBCf9Bi/BPDITKqDf3c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E97D740D3D; Mon, 14 Sep 2020 13:05:27 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:05:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 10/26] perf tools: Enable mmap3 map event when supported
Message-ID: <20200914160527.GI160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-11-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-11-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:02:57PM +0200, Jiri Olsa escreveu:
> Enabling mmap3 map event when supported and adding
> its disable fallback when it fails.
> 
> Also adding mmap3 bit to verbose open output:

This should check if the user disabled build id collection, i.e. if its
not something the user is interest on.

- Arnaldo
 
>   $ perf record -vv kill
>   perf_event_attr:
>     size                             120
>     { sample_period, sample_freq }   4000
>     ...
>     bpf_event                        1
>     mmap3                            1
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evsel.c                   | 9 ++++++++-
>  tools/perf/util/evsel.h                   | 1 +
>  tools/perf/util/perf_event_attr_fprintf.c | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 14baf8542b40..c2cc9b4b30bf 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1065,6 +1065,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	attr->task  = track;
>  	attr->mmap  = track;
>  	attr->mmap2 = track && !perf_missing_features.mmap2;
> +	attr->mmap3 = track && !perf_missing_features.mmap3;
>  	attr->comm  = track;
>  	/*
>  	 * ksymbol is tracked separately with text poke because it needs to be
> @@ -1657,6 +1658,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		evsel->core.attr.bpf_event = 0;
>  	if (perf_missing_features.branch_hw_idx)
>  		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
> +	if (perf_missing_features.mmap3)
> +		evsel->core.attr.mmap3 = 0;
>  retry_sample_id:
>  	if (perf_missing_features.sample_id_all)
>  		evsel->core.attr.sample_id_all = 0;
> @@ -1770,7 +1773,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -        if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
> +	if (!perf_missing_features.mmap3 && evsel->core.attr.mmap3) {
> +		perf_missing_features.mmap3 = true;
> +		pr_debug2("switching off mmap3\n");
> +		goto fallback_missing_features;
> +	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
>  		perf_missing_features.cgroup = true;
>  		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
>  		goto out_close;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 35e3f6d66085..d49922b22eca 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -119,6 +119,7 @@ struct perf_missing_features {
>  	bool sample_id_all;
>  	bool exclude_guest;
>  	bool mmap2;
> +	bool mmap3;
>  	bool cloexec;
>  	bool clockid;
>  	bool clockid_wrong;
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index e67a227c0ce7..3c52c081693d 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -134,6 +134,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(bpf_event, p_unsigned);
>  	PRINT_ATTRf(aux_output, p_unsigned);
>  	PRINT_ATTRf(cgroup, p_unsigned);
> +	PRINT_ATTRf(mmap3, p_unsigned);
>  
>  	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
>  	PRINT_ATTRf(bp_type, p_unsigned);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
