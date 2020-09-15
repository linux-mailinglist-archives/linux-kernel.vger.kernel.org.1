Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1126A50E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIOMY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIOMSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:18:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A7321973;
        Tue, 15 Sep 2020 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600172297;
        bh=8v64DVAyftKdPimFBnWLzZ3RfUMMy6+f5rrlSrneC2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1gtJxQQXZht4IGu8BSMjsIhGl3YN3yuj64/Q1KPmDiQbOlXk9Iy7l5OR5AJ7wvuZW
         KR1ul9Vp4j7SBImA19YJX9UZKMwL33bhXA8KANXktQ/yKY/apn/UixmF5pa7BY+aPZ
         cmrxvUS+WTghO3/vzvO5FgjWnSQBgPtwR/m1snvA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B40B840D3D; Tue, 15 Sep 2020 09:18:14 -0300 (-03)
Date:   Tue, 15 Sep 2020 09:18:14 -0300
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
Subject: Re: [PATCH 04/11] perf parse-event: Fix cpu map leaks
Message-ID: <20200915121814.GE720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031819.386559-5-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 12:18:12PM +0900, Namhyung Kim escreveu:
> Like evlist cpu map, evsel's cpu map should have proper refcount by
> releasing the original count after creation.

"releasing original count after creation"?

There are two fixes here, one its legit, i.e. when failing to create
the new evsel, if you created the perf_cpu_map, drop the refcount,
which, in this case, will free it since perf_cpu_map__new() sets it to
1.

But what about the other? Humm, I see, since a new refcount is being
obtained, then we need to drop the first.

This all got complicated, perhaps the following patch is simpler?

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c4d2394e2b2dc60f..3dceeacf8669bc5d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -353,18 +353,20 @@ __add_event(struct list_head *list, int *idx,
 	    const char *cpu_list)
 {
 	struct evsel *evsel;
-	struct perf_cpu_map *cpus = pmu ? pmu->cpus :
+	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
 
 	if (init_attr)
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
+	if (!evsel) {
+		perf_cpu_map__put(cpus);
 		return NULL;
+	}
 
 	(*idx)++;
-	evsel->core.cpus   = perf_cpu_map__get(cpus);
+	evsel->core.cpus     = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 

---

I.e. if we're going to share pmu->cpus, grab the necessary refcount at
that point, if we're going to create one (pmu == NULL), then
perf_cpu_map__new() will have the refcount we need (will set it to 1).

Then, if we fail to create the new evsel, we just drop the refcount we
got either from perf_cpu_map__get(pmu->cpus) or from
perf_cpu_map__new(cpu_list) (NULL is ok for __put() operations, that
covers that last ': NULL').

And then, when we go make evsel->core.cpus share that cpu_map, we know
we have the necessary refcount already, right?

No need to later on drop the one obtained previously via:

  evsel->core.cpus   = perf_cpu_map__get(cpus);

And we don't need to drop it later when we want to drop the extra
refcount it gets when pmu == NULL.

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
>  tools/perf/util/parse-events.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c4d2394e2b2d..b35e4bb1cecb 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -360,8 +360,11 @@ __add_event(struct list_head *list, int *idx,
>  		event_attr_init(attr);
>  
>  	evsel = evsel__new_idx(attr, *idx);
> -	if (!evsel)
> +	if (!evsel) {
> +		if (!pmu)
> +			perf_cpu_map__put(cpus);
>  		return NULL;
> +	}
>  
>  	(*idx)++;
>  	evsel->core.cpus   = perf_cpu_map__get(cpus);
> @@ -369,6 +372,8 @@ __add_event(struct list_head *list, int *idx,
>  	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
>  	evsel->auto_merge_stats = auto_merge_stats;
>  
> +	if (!pmu)
> +		perf_cpu_map__put(cpus);
>  	if (name)
>  		evsel->name = strdup(name);
>  
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
