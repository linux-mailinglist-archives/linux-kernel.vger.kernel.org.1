Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA92F84E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbhAOS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbhAOS6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:58:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9B6223A59;
        Fri, 15 Jan 2021 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610737050;
        bh=ubSchHFfs/qCr4Ke/aA8FHIkXhcJD2i9OX6kJpRO3XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKCBnyQOAfZ8K3m97HqA47rrGJPNUafnM2ZB/EFOb7F2ZsrJNYtSmCi+ZE6m9/GBh
         yW06mAEj06dKWpQ0b1UMjNFyxOmk5wh7M21BOR6DN9ie4s/DbaT68NUwVelPRktNa0
         FPnKm87SIvUWkXufESMBDV5zHGb+T7cvOJKsx9YuX1798qkvMDUBpuTuM3beAkw9s5
         xtUqU3J0B7Z2jN/YPQl8HWnRwsl4x7wM4G72CwX8wmltOoW36iAxpAU4kZCIaD0wXx
         eVFEJxX+bqQp4dbXQ8iEdmCU2SlfH7bVLKd7N2rs6kxmrGt/6D0SGIC2WN7EgeSFc2
         mIJd/lwLz/tUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 215BC40522; Fri, 15 Jan 2021 15:58:03 -0300 (-03)
Date:   Fri, 15 Jan 2021 15:58:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] libperf tests: Avoid uninitialized variable warning.
Message-ID: <20210115185803.GC457607@kernel.org>
References: <20210114212304.4018119-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114212304.4018119-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 14, 2021 at 01:23:04PM -0800, Ian Rogers escreveu:
> The variable bf is read (for a write call) without being initialized
> triggering a memory sanitizer warning. Use bf in the read and switch the
> write to reading from a string.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/lib/perf/tests/test-evlist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 6d8ebe0c2504..1b225fe34a72 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -208,7 +208,6 @@ static int test_mmap_thread(void)
>  	char path[PATH_MAX];
>  	int id, err, pid, go_pipe[2];
>  	union perf_event *event;
> -	char bf;
>  	int count = 0;
>  
>  	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
> @@ -229,6 +228,7 @@ static int test_mmap_thread(void)
>  	pid = fork();
>  	if (!pid) {
>  		int i;
> +		char bf;
>  
>  		read(go_pipe[0], &bf, 1);
>  
> @@ -266,7 +266,7 @@ static int test_mmap_thread(void)
>  	perf_evlist__enable(evlist);
>  
>  	/* kick the child and wait for it to finish */
> -	write(go_pipe[1], &bf, 1);
> +	write(go_pipe[1], "A", 1);
>  	waitpid(pid, NULL, 0);
>  
>  	/*
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

-- 

- Arnaldo
