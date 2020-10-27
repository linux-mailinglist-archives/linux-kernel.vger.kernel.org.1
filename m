Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE229BF02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814716AbgJ0Q7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793958AbgJ0PJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:09:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94A221527;
        Tue, 27 Oct 2020 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811368;
        bh=dfnQ29Bwjxa8Ak1ZqRHzctBvx8PsvFmxe3f9gSdFQCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ier26cMIyP81tqsHUXp4UiuyXYF7UOu1h7cuEg/ecIDHzOKlyhXpc84ozgsuLGybB
         tOErB0BC/kJ/7El96XqxJoSQoKH4F6V1Tk/wzGKWnBKumUH3hpIyjLKwy+PcQjrABa
         BJq4ejASng14+/Kw2NoMPXLVYe0Jy06S2x3oobtM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9A01403C2; Tue, 27 Oct 2020 12:09:25 -0300 (-03)
Date:   Tue, 27 Oct 2020 12:09:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com
Subject: Re: [PATCH 1/2] perf tools: Add --quiet option to perf stat
Message-ID: <20201027150925.GE2479604@kernel.org>
References: <20201027002737.30942-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027002737.30942-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 26, 2020 at 05:27:36PM -0700, Andi Kleen escreveu:
> Add a new --quiet option to perf stat. This is useful with perf stat
> record to write the data only to the perf.data file, which can lower
> measurement overhead because the data doesn't need to be formatted.
> 
> On my 4C desktop:
> 
> % time ./perf stat record  -e $(python -c 'print ",".join(["cycles"]*1000)')  -a -I 1000 sleep 5
> ...
> real    0m5.377s
> user    0m0.238s
> sys     0m0.452s
> % time ./perf stat record --quiet -e $(python -c 'print ",".join(["cycles"]*1000)')  -a -I 1000 sleep 5
> 
> real    0m5.452s
> user    0m0.183s
> sys     0m0.423s
> 
> In this example it cuts the user time by 20%. On systems with more cores
> the savings are higher.

Applied 1/2,

Thanks,

- Arnaldo
 
> Signed-off-by: Andi Kleen <andi@firstfloor.org>
> ---
>  tools/perf/Documentation/perf-stat.txt | 4 ++++
>  tools/perf/builtin-stat.c              | 6 +++++-
>  tools/perf/util/stat.h                 | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 9f9f29025e49..b138dd192423 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -316,6 +316,10 @@ small group that need not have multiplexing is lowered. This option
>  forbids the event merging logic from sharing events between groups and
>  may be used to increase accuracy in this case.
>  
> +--quiet::
> +Don't print output. This is useful with perf stat record below to only
> +write data to the perf.data file.
> +
>  STAT RECORD
>  -----------
>  Stores stat data into perf data file.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b01af171d94f..743fe47e7a88 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -972,6 +972,8 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
>  	/* Do not print anything if we record to the pipe. */
>  	if (STAT_RECORD && perf_stat.data.is_pipe)
>  		return;
> +	if (stat_config.quiet)
> +		return;
>  
>  	perf_evlist__print_counters(evsel_list, &stat_config, &target,
>  				    ts, argc, argv);
> @@ -1171,6 +1173,8 @@ static struct option stat_options[] = {
>  		    "threads of same physical core"),
>  	OPT_BOOLEAN(0, "summary", &stat_config.summary,
>  		       "print summary for interval mode"),
> +	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
> +			"don't print output (useful with record)"),
>  #ifdef HAVE_LIBPFM
>  	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>  		"libpfm4 event selector. use 'perf list' to list available events",
> @@ -2132,7 +2136,7 @@ int cmd_stat(int argc, const char **argv)
>  		goto out;
>  	}
>  
> -	if (!output) {
> +	if (!output && !stat_config.quiet) {
>  		struct timespec tm;
>  		mode = append_file ? "a" : "w";
>  
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 487010c624be..05adf8165025 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -122,6 +122,7 @@ struct perf_stat_config {
>  	bool			 metric_no_group;
>  	bool			 metric_no_merge;
>  	bool			 stop_read_counter;
> +	bool			 quiet;
>  	FILE			*output;
>  	unsigned int		 interval;
>  	unsigned int		 timeout;
> -- 
> 2.28.0
> 

-- 

- Arnaldo
