Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0D28C7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbgJMEZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:25:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:4973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgJMEZR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:25:17 -0400
IronPort-SDR: sBUxtOczoOjLmKwyCk6SeAZBX6wB9QaAGx95NpbNE4wqLgXxqZX9fT+ak+M/+QyBgLfB6x/NFo
 RkU+81LBBu7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165957743"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165957743"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 21:25:15 -0700
IronPort-SDR: HFuXtPBYWM4vxnA+vU9OJhmxa+2UFOrZytghh+2W79bbkffwW+YIrkb6p0GCoGYWhAIk3oFSaD
 WwbDbmwWyDIw==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="530236523"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.215.179]) ([10.254.215.179])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 21:25:12 -0700
Subject: Re: [PATCH v8 0/7] perf: Stream comparison
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20201009022845.13141-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0bb78298-1f27-c535-2468-2c8abd5b31aa@linux.intel.com>
Date:   Tue, 13 Oct 2020 12:25:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201009022845.13141-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, Hi Arnaldo,

How about v8 series? V6 got ACK from Jiri and I updated the series to v8 according to Arnaldo's 
comments. Please let me know if there are still some issues for this version then I can continue 
improving the patchset.

Thanks
Jin Yao

On 10/9/2020 10:28 AM, Jin Yao wrote:
> Sometimes, a small change in a hot function reducing the cycles of
> this function, but the overall workload doesn't get faster. It is
> interesting where the cycles are moved to.
> 
> What it would like is to diff before/after streams. The stream is the
> branch history which is aggregated by the branch records from perf
> samples. For example, the callchains aggregated from the branch records.
> By browsing the hot stream, we can understand the hot code path.
> 
> By browsing the hot streams, we can understand the hot code path.
> By comparing the cycles variation of same streams between old perf
> data and new perf data, we can understand if the cycles are moved
> to other codes.
> 
> The before stream is the stream in perf.data.old. The after stream
> is the stream in perf.data.
> 
> Diffing before/after streams compares top N hottest streams between
> two perf data files.
> 
> If all entries of one stream in perf.data.old are fully matched with
> all entries of another stream in perf.data, we think two streams
> are matched, otherwise the streams are not matched.
> 
> For example,
> 
>     cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
> --------------------------              --------------------------
>               main div.c:39                           main div.c:39
>               main div.c:44                           main div.c:44
> 
> The above streams are matched and we can see for the same streams the
> cycles (1) are equal and the callchain hit percents are slightly changed
> (26.80% vs. 27.30%). That's expected.
> 
> Now let's see example.
> 
> perf record -b ...      Generate perf.data.old with branch data
> perf record -b ...      Generate perf.data with branch data
> perf diff --stream
> 
> [ Matched hot streams ]
> 
> hot chain pair 1:
>              cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
>          ---------------------------              --------------------------
>                        main div.c:39                           main div.c:39
>                        main div.c:44                           main div.c:44
> 
> hot chain pair 2:
>             cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
>          ---------------------------              --------------------------
>            __random_r random_r.c:360               __random_r random_r.c:360
>            __random_r random_r.c:388               __random_r random_r.c:388
>            __random_r random_r.c:388               __random_r random_r.c:388
>            __random_r random_r.c:380               __random_r random_r.c:380
>            __random_r random_r.c:357               __random_r random_r.c:357
>                __random random.c:293                   __random random.c:293
>                __random random.c:293                   __random random.c:293
>                __random random.c:291                   __random random.c:291
>                __random random.c:291                   __random random.c:291
>                __random random.c:291                   __random random.c:291
>                __random random.c:288                   __random random.c:288
>                       rand rand.c:27                          rand rand.c:27
>                       rand rand.c:26                          rand rand.c:26
>                             rand@plt                                rand@plt
>                             rand@plt                                rand@plt
>                compute_flag div.c:25                   compute_flag div.c:25
>                compute_flag div.c:22                   compute_flag div.c:22
>                        main div.c:40                           main div.c:40
>                        main div.c:40                           main div.c:40
>                        main div.c:39                           main div.c:39
> 
> hot chain pair 3:
>               cycles: 9, hits: 4.48%                  cycles: 6, hits: 4.51%
>          ---------------------------              --------------------------
>            __random_r random_r.c:360               __random_r random_r.c:360
>            __random_r random_r.c:388               __random_r random_r.c:388
>            __random_r random_r.c:388               __random_r random_r.c:388
>            __random_r random_r.c:380               __random_r random_r.c:380
> 
> [ Hot streams in old perf data only ]
> 
> hot chain 1:
>              cycles: 18, hits: 6.75%
>           --------------------------
>            __random_r random_r.c:360
>            __random_r random_r.c:388
>            __random_r random_r.c:388
>            __random_r random_r.c:380
>            __random_r random_r.c:357
>                __random random.c:293
>                __random random.c:293
>                __random random.c:291
>                __random random.c:291
>                __random random.c:291
>                __random random.c:288
>                       rand rand.c:27
>                       rand rand.c:26
>                             rand@plt
>                             rand@plt
>                compute_flag div.c:25
>                compute_flag div.c:22
>                        main div.c:40
> 
> hot chain 2:
>              cycles: 29, hits: 2.78%
>           --------------------------
>                compute_flag div.c:22
>                        main div.c:40
>                        main div.c:40
>                        main div.c:39
> 
> [ Hot streams in new perf data only ]
> 
> hot chain 1:
>                                                       cycles: 4, hits: 4.54%
>                                                   --------------------------
>                                                                main div.c:42
>                                                        compute_flag div.c:28
> 
> hot chain 2:
>                                                       cycles: 5, hits: 3.51%
>                                                   --------------------------
>                                                                main div.c:39
>                                                                main div.c:44
>                                                                main div.c:42
>                                                        compute_flag div.c:28
>   
>   v8:
>   ---
>   Rebase to perf/core
> 
>   v7:
>   ---
>   Create a new struct evlist_streams which contains ev_streams and
>   nr_evsel, so we don't need to pass nr_evsel in stream related functions.
> 
>   Rename functions for better coding style.
> 
>   v6:
>   ---
>   Rebase to perf/core
> 
>   v5:
>   ---
>   1. Remove enum stream_type
>   2. Rebase to perf/core
> 
>   v4:
>   ---
>   The previous version is too big and very hard for review.
> 
>   1. v4 removes the code which supports the source line mapping
>      table and remove the source line based comparison. Now we
>      only supports the basic functionality of stream comparison.
> 
>   2. Refactor the code in a generic way.
> 
>   v3:
>   ---
>   v2 has 14 patches, it's hard to review.
>   v3 is only 7 patches for basic stream comparison.
> 
> Jin Yao (7):
>    perf util: Create streams
>    perf util: Get the evsel_streams by evsel_idx
>    perf util: Compare two streams
>    perf util: Link stream pair
>    perf util: Calculate the sum of total streams hits
>    perf util: Report hot streams
>    perf diff: Support hot streams comparison
> 
>   tools/perf/Documentation/perf-diff.txt |   4 +
>   tools/perf/builtin-diff.c              | 119 ++++++++-
>   tools/perf/util/Build                  |   1 +
>   tools/perf/util/callchain.c            |  99 +++++++
>   tools/perf/util/callchain.h            |   9 +
>   tools/perf/util/stream.c               | 342 +++++++++++++++++++++++++
>   tools/perf/util/stream.h               |  41 +++
>   7 files changed, 602 insertions(+), 13 deletions(-)
>   create mode 100644 tools/perf/util/stream.c
>   create mode 100644 tools/perf/util/stream.h
> 
