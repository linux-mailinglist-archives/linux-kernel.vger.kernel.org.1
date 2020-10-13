Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1426128CDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJMML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgJMML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:11:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D01A22227;
        Tue, 13 Oct 2020 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591116;
        bh=hqi4TDcMww2xkK2y7+nf4KOu3bRAfoi8PMh8F33W22U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RB9/urR5DElHDQrIZ0H+wvi/EjE3jE5osihe4mNoCx1CEGUNPJ0/rgF/fEUhr7Jvu
         Hyz+mSBHBVcYvd1MZLSaiqTWyvqqKu8lxTiYj6gUs+ebWnr7uBX+8jxDxWVLNv2vTO
         BXTAkpEVeatdjHxt5R1t9ZpIk6yWeSlxV5w8L+tM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B0DF403AC; Tue, 13 Oct 2020 09:11:54 -0300 (-03)
Date:   Tue, 13 Oct 2020 09:11:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET v4 0/6] perf inject: Speed build-id injection
Message-ID: <20201013121154.GA560293@kernel.org>
References: <20201012070214.2074921-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012070214.2074921-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 12, 2020 at 04:02:08PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> This is the new version of speed up build-id injection.  As this is
> to improve performance, I've added a benchmark for it.  Please look at
> the usage in the first commit.
> 
> By default, it measures average processing time of 100 MMAP2 events
> and 10000 SAMPLE events.  Below is the current result on my laptop.
> 
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 25.789 msec (+- 0.202 msec)
>     Average time per event: 2.528 usec (+- 0.020 usec)
>     Average memory usage: 8411 KB (+- 7 KB)
> 
> With this patchset applied, it got this:
> 
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 20.838 msec (+- 0.093 msec)
>     Average time per event: 2.043 usec (+- 0.009 usec)
>     Average memory usage: 8261 KB (+- 0 KB)
>     Average build-id-all injection took: 19.361 msec (+- 0.118 msec)
>     Average time per event: 1.898 usec (+- 0.012 usec)
>     Average memory usage: 7440 KB (+- 0 KB)
> 
> 
> Real usecases might be different as it depends on the number of
> mmap/sample events as well as how many DSOs are actually hit.
> 
> The benchmark result now includes memory footprint in terms of maximum
> RSS.  Also I've update the benchmark code to use timestamp so that it
> can be queued to the ordered_events (and flushed at the end).  It's
> also important how well it sorts the input events in the queue so I
> randomly chose a timestamp at the beginning of each MMAP event
> injection to resemble actual behavior.
> 
> As I said in other thread, perf inject currently doesn't flush the
> input events and processes all at the end.  This gives a good speedup
> but spends more memory (in proprotion to the input size).  While the
> build-id-all injection bypasses the queue so it uses less memory as
> well as faster processing.  The downside is that it'll mark all DSOs
> as hit so later processing steps (like perf report) likely handle them
> unnecessarily.

Thanks, tested and applied, first patchkit I process using that b4 tool,
cool!

- Arnaldo
 
> 
> This code is available at 'perf/inject-speedup-v4' branch on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> 
> Changes from v3:
>  - add timestamp to the synthesized events in the benchmark
>  - add a separate thread to read pipe in the benchmark
> 
> Changes from v2:
>  - fix benchmark to read required data
>  - add Acked-by from Jiri and Ian
>  - pass map flag to check huge pages  (Jiri)
>  - add comments on some functions  (Ian)
>  - show memory (max-RSS) usage in the benchmark  (Ian)
>  - drop build-id marking patch at the last  (Adrian)
> 
> 
> Namhyung Kim (6):
>   perf bench: Add build-id injection benchmark
>   perf inject: Add missing callbacks in perf_tool
>   perf inject: Enter namespace when reading build-id
>   perf inject: Do not load map/dso when injecting build-id
>   perf inject: Add --buildid-all option
>   perf bench: Run inject-build-id with --buildid-all option too
> 
>  tools/perf/Documentation/perf-inject.txt |   6 +-
>  tools/perf/bench/Build                   |   1 +
>  tools/perf/bench/bench.h                 |   1 +
>  tools/perf/bench/inject-buildid.c        | 457 +++++++++++++++++++++++
>  tools/perf/builtin-bench.c               |   1 +
>  tools/perf/builtin-inject.c              | 199 ++++++++--
>  tools/perf/util/build-id.h               |   4 +
>  tools/perf/util/map.c                    |  17 +-
>  tools/perf/util/map.h                    |  14 +
>  9 files changed, 645 insertions(+), 55 deletions(-)
>  create mode 100644 tools/perf/bench/inject-buildid.c
> 
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
> 
> *** BLURB HERE ***
> 
> Namhyung Kim (6):
>   perf bench: Add build-id injection benchmark
>   perf inject: Add missing callbacks in perf_tool
>   perf inject: Enter namespace when reading build-id
>   perf inject: Do not load map/dso when injecting build-id
>   perf inject: Add --buildid-all option
>   perf bench: Run inject-build-id with --buildid-all option too
> 
>  tools/perf/Documentation/perf-inject.txt |   6 +-
>  tools/perf/bench/Build                   |   1 +
>  tools/perf/bench/bench.h                 |   1 +
>  tools/perf/bench/inject-buildid.c        | 476 +++++++++++++++++++++++
>  tools/perf/builtin-bench.c               |   1 +
>  tools/perf/builtin-inject.c              | 199 ++++++++--
>  tools/perf/util/build-id.h               |   4 +
>  tools/perf/util/map.c                    |  17 +-
>  tools/perf/util/map.h                    |  14 +
>  9 files changed, 664 insertions(+), 55 deletions(-)
>  create mode 100644 tools/perf/bench/inject-buildid.c
> 
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

-- 

- Arnaldo
