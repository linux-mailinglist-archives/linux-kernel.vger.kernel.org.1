Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3942F2C6AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgK0Rc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgK0Rc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:32:29 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4844B208D5;
        Fri, 27 Nov 2020 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606498348;
        bh=y7pZjK6D6viaEN3Bl1PpoDAzFWvUIb7VUvmvPP4NPCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8xURzJHl33qK3wz6q9xrhrWQPSAYGFUkOUEIGPPLaJURDR25kipWeB0kZc5cv5F/
         daWib4pMyMYB5lcQ8SiRLPLveV+wAc+SAai+jcp/WuYEEG/O97wJJfm9mkkBPBdVPF
         hcyedWSRvFRV3yCvYX8jPs6e70VeYwe7k/u8tYas=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A77D40D0D; Fri, 27 Nov 2020 14:32:26 -0300 (-03)
Date:   Fri, 27 Nov 2020 14:32:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Sam Xi <xyzsam@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 1/2] perf stat: Use proper cpu for shadow stats
Message-ID: <20201127173226.GO70905@kernel.org>
References: <20201127041404.390276-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127041404.390276-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 27, 2020 at 01:14:03PM +0900, Namhyung Kim escreveu:
> Currently perf stat shows some metrics (like IPC) for defined events.
> But when no aggregation mode is used (-A option), it shows incorrect
> values since it used a value from a different cpu.
> 
> Before:
> 
>   $ perf stat -aA -e cycles,instructions sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0      116,057,380      cycles
>   CPU1       86,084,722      cycles
>   CPU2       99,423,125      cycles
>   CPU3       98,272,994      cycles
>   CPU0       53,369,217      instructions      #    0.46  insn per cycle
>   CPU1       33,378,058      instructions      #    0.29  insn per cycle
>   CPU2       58,150,086      instructions      #    0.50  insn per cycle
>   CPU3       40,029,703      instructions      #    0.34  insn per cycle
> 
>        1.001816971 seconds time elapsed
> 
> So the IPC for CPU1 should be 0.38 (= 33,378,058 / 86,084,722)
> but it was 0.29 (= 33,378,058 / 116,057,380) and so on.
> 
> After:
> 
>   $ perf stat -aA -e cycles,instructions sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   CPU0      109,621,384      cycles
>   CPU1      159,026,454      cycles
>   CPU2       99,460,366      cycles
>   CPU3      124,144,142      cycles
>   CPU0       44,396,706      instructions      #    0.41  insn per cycle
>   CPU1      120,195,425      instructions      #    0.76  insn per cycle
>   CPU2       44,763,978      instructions      #    0.45  insn per cycle
>   CPU3       69,049,079      instructions      #    0.56  insn per cycle
> 
>        1.001910444 seconds time elapsed

Thanks, applied, the new 'perf test' entry in 2/2 will be merged into
perf/core, as it isn't purely a fix,

- Arnaldo
 
> Reported-by: Sam Xi <xyzsam@google.com>
> Fixes: 44d49a600259 ("perf stat: Support metrics in --per-core/socket mode")
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 4b57c0c07632..a963b5b8eb72 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -324,13 +324,10 @@ static int first_shadow_cpu(struct perf_stat_config *config,
>  	struct evlist *evlist = evsel->evlist;
>  	int i;
>  
> -	if (!config->aggr_get_id)
> -		return 0;
> -
>  	if (config->aggr_mode == AGGR_NONE)
>  		return id;
>  
> -	if (config->aggr_mode == AGGR_GLOBAL)
> +	if (!config->aggr_get_id)
>  		return 0;
>  
>  	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 

-- 

- Arnaldo
