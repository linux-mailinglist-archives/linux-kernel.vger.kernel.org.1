Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5A2DB036
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgLOPh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgLOPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:37:36 -0500
Date:   Tue, 15 Dec 2020 12:37:09 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608046616;
        bh=7jnet3HiVLkL1dD6qE8KR9Mnt/sCfMpAcCbfi62dzZc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mg2Ww3A2733ahgNw7xonKUbod9rq/rQTfNxEQxEmqZU1zVPxcl2rCR8oyZNm7/ZZQ
         8mmEimdmwSCXfwBpAAqYoJAWamNMpTT5WM18Flmjq2AoJEKbWIAQbZQ+yYmaIJsZ9C
         uThNklNXUm3VwfGIpjs4W6uKXvK8QhsyisosBX/TuV+C/y57/nCY9rkkDOGWeehCUF
         R3mkQJF3j7mdC87nO0xFiBM5YMlnY48fBd1iA3Nt8eZrqMI7OIyZCeij23MXqkFNFb
         xdL8R0bUv0q3LL0Ye9jiC0j9o6wGCi0H19n1hOcanri0qDiTp0FKLsqN8FuPKdtwsx
         UTzksTxdhGTAw==
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
Subject: Re: [PATCH 1/8] perf tools: Add debug_set_file function
Message-ID: <20201215153709.GB258566@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212104358.412065-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 12, 2020 at 11:43:51AM +0100, Jiri Olsa escreveu:
> Allow to set debug output file via new debug_set_file function.
> 
> It's called during perf startup in perf_debug_setup to set stderr
> file as default and any perf command can set it later to different
> file.
> 
> It will be used in perf daemon command to get verbose output into
> log file.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/debug.c | 9 ++++++++-
>  tools/perf/util/debug.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 5cda5565777a..50fd6a4be4e0 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -30,6 +30,12 @@ bool dump_trace = false, quiet = false;
>  int debug_ordered_events;
>  static int redirect_to_stderr;
>  int debug_data_convert;
> +static FILE *debug_file;
> +
> +void debug_set_file(FILE *file)
> +{
> +	debug_file = file;
> +}
>  
>  int veprintf(int level, int var, const char *fmt, va_list args)
>  {
> @@ -39,7 +45,7 @@ int veprintf(int level, int var, const char *fmt, va_list args)
>  		if (use_browser >= 1 && !redirect_to_stderr)
>  			ui_helpline__vshow(fmt, args);
>  		else
> -			ret = vfprintf(stderr, fmt, args);
> +			ret = vfprintf(debug_file, fmt, args);
>  	}
>  
>  	return ret;
> @@ -227,6 +233,7 @@ DEBUG_WRAPPER(debug, 1);
>  
>  void perf_debug_setup(void)
>  {
> +	debug_set_file(stderr);
>  	libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug_wrapper);
>  }
>  
> diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> index f1734abd98dd..43f712295645 100644
> --- a/tools/perf/util/debug.h
> +++ b/tools/perf/util/debug.h
> @@ -5,6 +5,7 @@
>  
>  #include <stdarg.h>
>  #include <stdbool.h>
> +#include <stdio.h>
>  #include <linux/compiler.h>
>  
>  extern int verbose;
> @@ -62,6 +63,7 @@ int eprintf_time(int level, int var, u64 t, const char *fmt, ...) __printf(4, 5)
>  int veprintf(int level, int var, const char *fmt, va_list args);
>  
>  int perf_debug_option(const char *str);
> +void debug_set_file(FILE *file);
>  void perf_debug_setup(void);
>  int perf_quiet_option(void);
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
