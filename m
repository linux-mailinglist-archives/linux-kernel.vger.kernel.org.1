Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97B2FBE68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbhASR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbhASPAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:00:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEC3C207B1;
        Tue, 19 Jan 2021 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611068367;
        bh=tiqOZbdeRVwIG8uLJZ4PlcIKtaMjPFbMWgzud1ja+8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tdqef2iIhRh7XgHtM5xZqd8/eNHR04qxIjqU7cp5zKn5NeR7I3hNcl3XmJxLNcllg
         u3Qb+KenWuPoQ8YHZ9CrzFYmDRaQsTW4j8zlRw+RBKvO51rGoxQnKkGcxOzKmIgE9d
         ztpA6XQKf+bkqGvtUlJ9Lu0VqeWKK5Q1IwK35fGEAQeLj0OQFLEJjRg3LViHkSNG4Z
         T7VsSJfqoxqPgDMHq35o7ZNP2PqHHWj4jRlhZuygByjtWcuOqgjZIBgQ/F+Z0o0nhI
         eBbyCp3lOFxRwsZIV8CuqLR0Dzgn2wIamiBk6g+8glnLZvS5947QLjNWTtnAQMhSm4
         sOSVBGeFyho8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FD1140CE2; Tue, 19 Jan 2021 11:59:22 -0300 (-03)
Date:   Tue, 19 Jan 2021 11:59:22 -0300
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
Message-ID: <20210119145922.GL12699@kernel.org>
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
> 
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

  78    12.70 ubuntu:18.04-x-sparc64        : FAIL sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0

util/debug.c: In function 'fprintf_time':
util/debug.c:63:32: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type '__suseconds_t {aka int}' [-Werror=format=]
  return fprintf(file, "[%s.%06lu] ", date, tod.tv_usec);
                            ~~~~^           ~~~~~~~~~~~
                            %06u

I'll try to fix it.

- Arnaldo

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
