Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158226C984
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIPTMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgIPRkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6625E222E8;
        Wed, 16 Sep 2020 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264812;
        bh=NQq1On/fkwKTYqrcq7ShBRprV9UXWEuflauH83OIRvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GORHr6l4BlJj6kWrku14MTLiELS5zPh2+nrpH0zuXLtRoZUSFS33l3GiKoVUlNJPn
         uMVCY5QkxVgs6dddX1GVVW6U/0os1syzplyu3W2FQA14Ne9K/ZvUjGlRZrpIyk9lC/
         N3S7IRd2ZU5FJJRMo+BUwZSCC5kITTFl9LIxjcpg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 827C6400E9; Wed, 16 Sep 2020 11:00:10 -0300 (-03)
Date:   Wed, 16 Sep 2020 11:00:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] perf parse-event: Fix cpu map leaks
Message-ID: <20200916140010.GQ720847@kernel.org>
References: <20200916053131.1001604-1-namhyung@kernel.org>
 <20200916053131.1001604-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916053131.1001604-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 02:31:31PM +0900, Namhyung Kim escreveu:
> Like evlist cpu map, evsel's cpu map should have a proper refcount.
> As it's created with a refcount, we don't need to get an extra count.
> Thanks to Arnaldo for the simpler suggestion.

You forgot this part:


[acme@five perf]$ git diff
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 667cbca1547ac5f6..0154331ea213f166 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -353,7 +353,7 @@ __add_event(struct list_head *list, int *idx,
            const char *cpu_list)
 {
        struct evsel *evsel;
-       struct perf_cpu_map *cpus = pmu ? pmu->cpus :
+       struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
                               cpu_list ? perf_cpu_map__new(cpu_list) : NULL;

        if (init_attr)

Right?

- Arnaldo
 
> This fixes the following ASAN report:
> 
>   Direct leak of 840 byte(s) in 70 object(s) allocated from:
>     #0 0x7fe36703f628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
>     #1 0x559fbbf611ca in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
>     #2 0x559fbbf6229c in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:237
>     #3 0x559fbbcc6c6d in __add_event util/parse-events.c:357
>     #4 0x559fbbcc6c6d in add_event_tool util/parse-events.c:408
>     #5 0x559fbbcc6c6d in parse_events_add_tool util/parse-events.c:1414
>     #6 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
>     #7 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
>     #8 0x559fbbcc95da in __parse_events util/parse-events.c:2141
>     #9 0x559fbbc2788b in check_parse_id tests/pmu-events.c:406
>     #10 0x559fbbc2788b in check_parse_id tests/pmu-events.c:393
>     #11 0x559fbbc2788b in check_parse_fake tests/pmu-events.c:436
>     #12 0x559fbbc2788b in metric_parse_fake tests/pmu-events.c:553
>     #13 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:599
>     #14 0x559fbbc27e2d in test_parsing_fake tests/pmu-events.c:574
>     #15 0x559fbbc0109b in run_test tests/builtin-test.c:410
>     #16 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
>     #17 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
>     #18 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
>     #19 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
>     #20 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
>     #21 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
>     #22 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
>     #23 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308
> 
> And I've failed which commit introduced this bug as the code was
> heavily changed since then. ;-/
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 176a51698a64..204395596381 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -366,7 +366,7 @@ __add_event(struct list_head *list, int *idx,
>  	}
>  
>  	(*idx)++;
> -	evsel->core.cpus   = perf_cpu_map__get(cpus);
> +	evsel->core.cpus = cpus;
>  	evsel->core.own_cpus = perf_cpu_map__get(cpus);
>  	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
>  	evsel->auto_merge_stats = auto_merge_stats;
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
