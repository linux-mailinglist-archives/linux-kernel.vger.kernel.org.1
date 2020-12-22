Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDC2E0D25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgLVQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgLVQQW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:16:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2908B23105;
        Tue, 22 Dec 2020 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608653741;
        bh=nnBXHt9vnr33JSMrmV2ByU1sUIIDzbFUIZWLcwHgTQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHb+xtUCX+WGmk+FtngMNy6cj//jKyQG27OljZTZnW7r6rjXLSk5qXWLyjsjj6gO4
         igmKKzu8xUVMzDDcYqS/oE6KgolmLDNDf/QhgywEuDJbPcIJxSSmI3v5JgXCf5G34t
         HSkbBxVAqpxYYKTuep4WKFpBPAqrkKxMYIc9xRQj9u1YisRnALQHiV+F1U2PZbY95s
         cyzcrXKwg0A83egt0j47C3wVjRh60o4vpgwndTFLX/vpSU+Q8aJcDDXxmnmh71+v+Y
         n7VZZcACL49l/5gjf7mGEb1z2Ig6GaIr9zRETeSFt+CYt3nXy0PA/PNUzzgf7Py+vP
         T1v7IaPM7Qh1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B8AE411E9; Tue, 22 Dec 2020 13:15:55 -0300 (-03)
Date:   Tue, 22 Dec 2020 13:15:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Create '--add-default' option to append
 default list
Message-ID: <20201222161555.GD433286@kernel.org>
References: <20201222011131.12326-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222011131.12326-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 22, 2020 at 09:11:31AM +0800, Jin Yao escreveu:
> The event default list includes the most common events which are widely
> used by users. But with -e option, the current perf only counts the events
> assigned by -e option. Users may want to collect some extra events with
> the default list. For this case, users have to manually add all the events
> from the default list. It's inconvenient. Also, users may don't know how to
> get the default list.
> 
> It's better to add a new option to append default list to the -e events.
> The new option is '--add-default'.
> 
> Before:
> 
> root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>               2.05 Joules power/energy-pkg/
> 
>        1.000857974 seconds time elapsed
> 
> After:
> 
> root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a --add-default -- sleep 1

I thought about:

    perf stat -e +power/energy-pkg/ -a -- sleep 1

Which would have its counterpart:

    perf stat -e -cycles -0a --sleep 1

To remove an event from the defaults, perhaps to deal with some specific
hardware where the default or what is in -d, -dd, -ddd, etc can't all be
counted. I.e. - and + would remove or add from whaver list was there at
that point.

- Arnaldo
 
>  Performance counter stats for 'system wide':
> 
>               2.10 Joules power/energy-pkg/         #    0.000 K/sec
>           8,009.89 msec   cpu-clock                 #    7.995 CPUs utilized
>                140        context-switches          #    0.017 K/sec
>                  9        cpu-migrations            #    0.001 K/sec
>                 66        page-faults               #    0.008 K/sec
>         10,671,929        cycles                    #    0.001 GHz
>          4,736,880        instructions              #    0.44  insn per cycle
>            942,951        branches                  #    0.118 M/sec
>             76,096        branch-misses             #    8.07% of all branches
> 
>        1.001809960 seconds time elapsed
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 5 +++++
>  tools/perf/builtin-stat.c              | 4 +++-
>  tools/perf/util/stat.h                 | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 5d4a673d7621..75a83c2e4dc5 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -438,6 +438,11 @@ convenient for post processing.
>  --summary::
>  Print summary for interval mode (-I).
>  
> +--add-default::
> +The default event list includes the most common events which are widely
> +used by users. But with -e option, the perf only counts the events assigned
> +by -e option. This options appends the default event list to the -e events.
> +
>  EXAMPLES
>  --------
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 89c32692f40c..6ac7b946f9a7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1173,6 +1173,8 @@ static struct option stat_options[] = {
>  		       "print summary for interval mode"),
>  	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
>  			"don't print output (useful with record)"),
> +	OPT_BOOLEAN(0, "add-default", &stat_config.add_default,
> +		       "add default events"),
>  #ifdef HAVE_LIBPFM
>  	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>  		"libpfm4 event selector. use 'perf list' to list available events",
> @@ -1755,7 +1757,7 @@ static int add_default_attributes(void)
>  		free(str);
>  	}
>  
> -	if (!evsel_list->core.nr_entries) {
> +	if (!evsel_list->core.nr_entries || stat_config.add_default) {
>  		if (target__has_cpu(&target))
>  			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
>  
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 9979b4b100f2..6ccc6936348c 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -123,6 +123,7 @@ struct perf_stat_config {
>  	bool			 metric_no_merge;
>  	bool			 stop_read_counter;
>  	bool			 quiet;
> +	bool			 add_default;
>  	FILE			*output;
>  	unsigned int		 interval;
>  	unsigned int		 timeout;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
