Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB102FA5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406448AbhARQMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406137AbhARQDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0BFD22AAA;
        Mon, 18 Jan 2021 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985750;
        bh=+lfSZ5tOaljhVV0P7oTiKXcaWUG1K8AW8T73Qid1DRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwG8uG+m8feySQzxmh91yP21LP6NgqrKnPcTLWshSsSw5PZlBpyNFyOBCPjvbl03P
         cUImnnSBIVYOr7lNJAZ4R/ng/jCPxtbwLbrz02lbjVi3U1qXMyai/uPfGn6CTwrVxB
         1PRAF3M8Pru1p2t5Ag4l7wBaLAOHaO6ycuUNMGy41UsKODTOfZQwSzNqbmv9TgJ2R8
         JWbcq/1JPYnyamPZY0WqWQdykqOe5Zv6qTVyL15e7FlTkLrgMj8CWTeUHZwmodV2Lh
         12E9fksF4XImyGyW2jYZuYmFSGcxyMvT3P0pnOdRZNPpPPueemolL5Tn7fzUTt7YVI
         RH1XAJ5U5/yyQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87B8540CE2; Mon, 18 Jan 2021 13:02:28 -0300 (-03)
Date:   Mon, 18 Jan 2021 13:02:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 03/22] perf tools: Add debug_set_display_time function
Message-ID: <20210118160228.GC12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 02, 2021 at 11:04:22PM +0100, Jiri Olsa escreveu:
> Allow to display time in perf debug output via new
> debug_set_display_time function.
> 
> It will be used in perf daemon command to get verbose
> output into log file.
> 
> The debug time format is:
> 
>   [2020-12-03 18:25:31.822152] affinity: SYS
>   [2020-12-03 18:25:31.822164] mmap flush: 1
>   [2020-12-03 18:25:31.822175] comp level: 0
>   [2020-12-03 18:25:32.002047] mmap size 528384B

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/debug.c | 34 +++++++++++++++++++++++++++++++---
>  tools/perf/util/debug.h |  1 +
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 50fd6a4be4e0..dc148b08814b 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -10,6 +10,7 @@
>  #include <api/debug.h>
>  #include <linux/kernel.h>
>  #include <linux/time64.h>
> +#include <sys/time.h>
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
>  #endif
> @@ -31,21 +32,48 @@ int debug_ordered_events;
>  static int redirect_to_stderr;
>  int debug_data_convert;
>  static FILE *debug_file;
> +bool debug_display_time;
>  
>  void debug_set_file(FILE *file)
>  {
>  	debug_file = file;
>  }
>  
> +void debug_set_display_time(bool set)
> +{
> +	debug_display_time = set;
> +}
> +
> +static int fprintf_time(FILE *file)
> +{
> +	struct timeval tod;
> +	struct tm ltime;
> +	char date[64];
> +
> +	if (!debug_display_time)
> +		return 0;
> +
> +	if (gettimeofday(&tod, NULL) != 0)
> +		return 0;
> +
> +	if (localtime_r(&tod.tv_sec, &ltime) == NULL)
> +		return 0;
> +
> +	strftime(date, sizeof(date),  "%F %H:%M:%S", &ltime);
> +	return fprintf(file, "[%s.%06lu] ", date, tod.tv_usec);
> +}
> +
>  int veprintf(int level, int var, const char *fmt, va_list args)
>  {
>  	int ret = 0;
>  
>  	if (var >= level) {
> -		if (use_browser >= 1 && !redirect_to_stderr)
> +		if (use_browser >= 1 && !redirect_to_stderr) {
>  			ui_helpline__vshow(fmt, args);
> -		else
> -			ret = vfprintf(debug_file, fmt, args);
> +		} else {
> +			ret = fprintf_time(debug_file);
> +			ret += vfprintf(debug_file, fmt, args);
> +		}
>  	}
>  
>  	return ret;
> diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> index 43f712295645..48f631966067 100644
> --- a/tools/perf/util/debug.h
> +++ b/tools/perf/util/debug.h
> @@ -64,6 +64,7 @@ int veprintf(int level, int var, const char *fmt, va_list args);
>  
>  int perf_debug_option(const char *str);
>  void debug_set_file(FILE *file);
> +void debug_set_display_time(bool set);
>  void perf_debug_setup(void);
>  int perf_quiet_option(void);
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
