Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4F2D98C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439830AbgLNN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439784AbgLNN25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:28:57 -0500
Date:   Mon, 14 Dec 2020 10:28:28 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607952496;
        bh=pEQX7iZK98l3bcWz/kxYd1H8ULpoRp/0e2Gfe5EJZlc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kx/AbBMomhctl9a79sbGXyjL8CyMLEOVQqbwguQTJ3kroSpH5lW3NlD6HebojG59T
         91+w4aXkHc28XlDmqKMqBs2rKJpTyrcB2V+7itsJRLii6woj65oSYZC32Oa9wTYUih
         s0GwCupjkcaSBgdK0IA1J6Zv4AkFB/87KsssDQGMsdzz6Ss9XTmum3qqCqe2rlXcRM
         wDD3n9ifQpwLcL31sEj7pv+ychEJVtgD/KbJaQwjSJ7Y2M1Gbe43QPohWDkerJLhSo
         uvb/bxEsQZhPTnKjFHMFESm8IzJetDa4kFpOHhWn/T/JkbMOkXxXhj5k1P1KHJhwHA
         yg0tk9MYWNmKA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        ak@linux.intel.com, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/5] perf stat: Introduce --iiostat mode to provide I/O
 performance metrics
Message-ID: <20201214132828.GD238399@kernel.org>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 12:03:35PM +0300, Alexander Antonov escreveu:
> Mode is intended to provide four I/O performance metrics in MB per each
> IIO stack:
>  - Inbound Read: I/O devices below IIO stack read from the host memory
>  - Inbound Write: I/O devices below IIO stack write to the host memory
>  - Outbound Read: CPU reads from I/O devices below IIO stack
>  - Outbound Write: CPU writes to I/O devices below IIO stack
> 
> Each metric requiries only one IIO event which increments at every 4B
> transfer in corresponding direction. The formulas to compute metrics
> are generic:
>     #EventCount * 4B / (1024 * 1024)
> 
> Note: --iiostat introduces new perf data aggregation mode - per I/O stack
> hence -e and -M options are not supported.
> 
> Usage examples:

My first thought was: Why not have a 'perf iiostat' subcommand?

You're reusing the aggregation code for 'perf stat' and for that I'd
love to have Ian, Andi, Jiri et all to look at how you implemented it,
but I think having a shorter way of using this would be interesting :-)

- Arnaldo
 
> 1. List all IIO stacks (example for 2-S platform):
>    $ perf stat --iiostat=show

  Would be:

     $ perf iiostat show

>    S0-uncore_iio_0<0000:00>
>    S1-uncore_iio_0<0000:80>
>    S0-uncore_iio_1<0000:17>
>    S1-uncore_iio_1<0000:85>
>    S0-uncore_iio_2<0000:3a>
>    S1-uncore_iio_2<0000:ae>
>    S0-uncore_iio_3<0000:5d>
>    S1-uncore_iio_3<0000:d7>
> 
> 2. Collect metrics for all I/O stacks:
>    $ perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct

     $ perf iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct

>    357708+0 records in
>    357707+0 records out
>    375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
> 
>     Performance counter stats for 'system wide':
> 
>       port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
>    0000:00                    1                    0                    2                    3 
>    0000:80                    0                    0                    0                    0 
>    0000:17               352552                   43                    0                   21 
>    0000:85                    0                    0                    0                    0 
>    0000:3a                    3                    0                    0                    0 
>    0000:ae                    0                    0                    0                    0 
>    0000:5d                    0                    0                    0                    0 
>    0000:d7                    0                    0                    0                    0
> 
> 3. Collect metrics for comma separated list of I/O stacks:
>    $ perf stat --iiostat=0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct

     $ perf iiostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct

>    357708+0 records in
>    357707+0 records out
>    375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
> 
>     Performance counter stats for 'system wide':
> 
>       port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB) 
>    0000:17               358559                   44                    0                   22 
>    0000:3a                    3                    2                    0                    0 
> 
>         197.081983474 seconds time elapsed
> 
> Alexander Antonov (5):
>   perf stat: Add AGGR_IIO_STACK mode
>   perf evsel: Introduce an observed performance device
>   perf stat: Basic support for iiostat in perf stat
>   perf stat: Helper functions for IIO stacks list in iiostat mode
>   perf stat: Enable --iiostat mode for x86 platforms
> 
>  tools/perf/Documentation/perf-stat.txt        |  31 ++
>  tools/perf/arch/x86/util/Build                |   1 +
>  tools/perf/arch/x86/util/iiostat.c            | 460 ++++++++++++++++++
>  tools/perf/builtin-stat.c                     |  38 +-
>  tools/perf/util/evsel.h                       |   1 +
>  tools/perf/util/iiostat.h                     |  33 ++
>  .../scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/stat-display.c                |  51 +-
>  tools/perf/util/stat-shadow.c                 |  11 +-
>  tools/perf/util/stat.c                        |   3 +-
>  tools/perf/util/stat.h                        |   2 +
>  11 files changed, 625 insertions(+), 8 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/iiostat.c
>  create mode 100644 tools/perf/util/iiostat.h
> 
> 
> base-commit: 644bf4b0f7acde641d3db200b4db66977e96c3bd
> -- 
> 2.19.1
> 

-- 

- Arnaldo
