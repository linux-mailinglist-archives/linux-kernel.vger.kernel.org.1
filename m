Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FC273926
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgIVDOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:14:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbgIVDO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:14:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 87DC96CE8889B44836E5;
        Tue, 22 Sep 2020 11:14:26 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 11:14:19 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <huawei.libin@huawei.com>
Subject: [PATCH 0/2] perf stat: Unbreak perf stat with ARMv8 PMU events
Date:   Tue, 22 Sep 2020 11:13:44 +0800
Message-ID: <20200922031346.15051-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, perf-stat with armv8_pmu events with a workload is broken.
This patch set just fixes that.

Before the patch set:
[root@localhost hulk]# tools/perf/perf stat  -e armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls > /dev/null
Segmentation fault

After the patch set:
[root@localhost hulk]# tools/perf/perf stat  -e armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls > /dev/null

 Performance counter stats for 'ls':

            39,882      armv8_pmuv3_0/ll_cache_rd/                                   
             9,639      armv8_pmuv3_0/ll_cache_miss_rd/                                   

       0.001416690 seconds time elapsed

       0.001469000 seconds user
       0.000000000 seconds sys

Wei Li (2):
  perf stat: Fix segfault when counting armv8 PMU events
  perf stat: Unbreak perf stat with armv8 PMU events

 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/perf/builtin-stat.c                | 37 ++++++++++++++++--------
 tools/perf/util/evlist.c                 | 23 ++++++++++++++-
 3 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.17.1

