Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2D1C2235
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 04:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgEBCJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 22:09:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:30459 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgEBCJD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 22:09:03 -0400
IronPort-SDR: SQjDdxC+NdguVE7POl+jqGSbxj8r29pNDvLBiFE/bw4kOkQfN75/rVZxJCfDezFx82xZ19et33
 E05KAiNkXZaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 19:09:03 -0700
IronPort-SDR: m9F+HImyFtQViKo59Bw5bZKswYhiV7lG/khJaR9cFAhHHDWH+C7Tz0pkmbAaFImQytwU70IM7I
 zoquMbnGwMgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="283348203"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 19:09:00 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/2] perf stat: Support overall statistics for interval mode
Date:   Sat,  2 May 2020 10:07:03 +0800
Message-Id: <20200502020705.19295-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf-stat supports to print counts at regular interval (-I),
but it's not very easy for user to get the overall statistics.

With this patchset, it supports to report the summary at the end of
interval output.

For example,

 root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
 #           time             counts unit events
      1.000412064          2,281,114      cycles
      2.001383658          2,547,880      cycles

  Performance counter stats for 'system wide':

          4,828,994      cycles

        2.002860349 seconds time elapsed

 root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
 #           time             counts unit events
      1.000389902          1,536,093      cycles
      1.000389902            420,226      instructions              #    0.27  insn per cycle
      2.001433453          2,213,952      cycles
      2.001433453            735,465      instructions              #    0.33  insn per cycle

  Performance counter stats for 'system wide':

          3,750,045      cycles
          1,155,691      instructions              #    0.31  insn per cycle

        2.003023361 seconds time elapsed

 root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
 #           time             counts unit events
      1.000435121            905,303      inst_retired.any          #      2.9 CPI
      1.000435121          2,663,333      cycles
      1.000435121            914,702      inst_retired.any          #      0.3 IPC
      1.000435121          2,676,559      cpu_clk_unhalted.thread
      2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
      2.001615941          3,551,357      cycles
      2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
      2.001615941          3,551,044      cpu_clk_unhalted.thread

  Performance counter stats for 'system wide':

          2,856,395      inst_retired.any          #      2.2 CPI
          6,214,690      cycles
          2,865,539      inst_retired.any          #      0.5 IPC
          6,227,603      cpu_clk_unhalted.thread

        2.003403078 seconds time elapsed

 v2:
 ---
 Rebase to perf/core branch

Jin Yao (2):
  perf evsel: Create counts for collecting summary data
  perf stat: Report summary for interval mode

 tools/perf/builtin-stat.c | 14 ++++++-
 tools/perf/util/evsel.c   | 10 ++++-
 tools/perf/util/evsel.h   |  1 +
 tools/perf/util/stat.c    | 77 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  5 +++
 5 files changed, 103 insertions(+), 4 deletions(-)

-- 
2.17.1

