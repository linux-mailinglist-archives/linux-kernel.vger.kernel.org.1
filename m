Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3F26A508
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIOMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgIOMTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:19:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A012074B;
        Tue, 15 Sep 2020 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600172354;
        bh=YXYUanWvBGw2X19aqKabXivhglWunbEw9s6rUh5EpfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwCOh6/F4tDXjMcsoZ9eHicP5Hi34xR9d5wo86Ef2XrjZkHsPQk/x414hInYPVWT9
         9I7deiSCUcDTA9vwOXf6+6HQO0Lb2wSsnkQ748aycIWtF56RtjyXBx3GmEhMN9v5VY
         pPnIySXCYspSDavu90oEQVpuYwtEmaAdB42NVa7c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15D0240D3D; Tue, 15 Sep 2020 09:19:12 -0300 (-03)
Date:   Tue, 15 Sep 2020 09:19:12 -0300
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
Subject: Re: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
Message-ID: <20200915121912.GF720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-6-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031819.386559-6-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 12:18:13PM +0900, Namhyung Kim escreveu:
> The evsel->unit borrows a pointer of pmu event or alias instead of
> owns a string.  But tool event (duration_time) passes a result of
> strdup() caused a leak.
> 
> It was found by ASAN during metric test:

Thanks, applied.
 
>   Direct leak of 210 byte(s) in 70 object(s) allocated from:
>     #0 0x7fe366fca0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
>     #1 0x559fbbcc6ea3 in add_event_tool util/parse-events.c:414
>     #2 0x559fbbcc6ea3 in parse_events_add_tool util/parse-events.c:1414
>     #3 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
>     #4 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
>     #5 0x559fbbcc95da in __parse_events util/parse-events.c:2141
>     #6 0x559fbbc28555 in check_parse_id tests/pmu-events.c:406
>     #7 0x559fbbc28555 in check_parse_id tests/pmu-events.c:393
>     #8 0x559fbbc28555 in check_parse_cpu tests/pmu-events.c:415
>     #9 0x559fbbc28555 in test_parsing tests/pmu-events.c:498
>     #10 0x559fbbc0109b in run_test tests/builtin-test.c:410
>     #11 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
>     #12 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
>     #13 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
>     #14 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
>     #15 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
>     #16 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
>     #17 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
>     #18 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Fixes: f0fbb114e3025 ("perf stat: Implement duration_time as a proper event")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index b35e4bb1cecb..ece321ccf599 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -416,7 +416,7 @@ static int add_event_tool(struct list_head *list, int *idx,
>  		return -ENOMEM;
>  	evsel->tool_event = tool_event;
>  	if (tool_event == PERF_TOOL_DURATION_TIME)
> -		evsel->unit = strdup("ns");
> +		evsel->unit = "ns";
>  	return 0;
>  }
>  
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 

- Arnaldo
