Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE16296831
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374162AbgJWAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:54:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:53246 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900876AbgJWAyL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:54:11 -0400
IronPort-SDR: o6sX6t8mKSTLJ00hSm3IEb6jVnl7szro6SpmY5L079u95yZe59UwscsBbVjMc5D3vgL9PJksVw
 K55sE5hGhZ1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="229247596"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="229247596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 17:54:09 -0700
IronPort-SDR: swHK9eY0ASrKYZrtdpr+3Tj0kJB3cpK4Ssb9GH0u/YUwawn5WtSnjDPhl1SUvNoyMi2S0FlgxC
 zcyixqgPMGjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="423282924"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2020 17:54:05 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX
Date:   Fri, 23 Oct 2020 08:53:34 +0800
Message-Id: <20201023005334.7869-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ian reports an issue that the metric DRAM_BW_Use often remains 0.

The metric expression for DRAM_BW_Use on CLX/SKX:

"( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time"

The counts of uncore_imc/cas_count_read/ and uncore_imc/cas_count_write/
are scaled up by 64, that is to turn a count of cache lines into bytes,
the count is then divided by 1000000000 to give GB.

However, the counts of uncore_imc/cas_count_read/ and
uncore_imc/cas_count_write/ have been scaled yet.

The scale values are from sysfs, such as
/sys/devices/uncore_imc_0/events/cas_count_read.scale.
It's 6.103515625e-5 (64 / 1024.0 / 1024.0).

So if we use original metric expression, the result is not correct.

But the difficulty is, for SKL client, the counts are not scaled.

The metric expression for DRAM_BW_Use on SKL:

"64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000"

root@kbl-ppc:~# perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

               190      arb/event=0x84,umask=0x1/ #     1.86 DRAM_BW_Use
        29,093,178      arb/event=0x81,umask=0x1/
     1,000,703,287 ns   duration_time

       1.000703287 seconds time elapsed

The result is expected.

So the easy way is just change the metric expression for CLX/SKX.
This patch changes the metric expression to:

"( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time"

1048576 = 1024 * 1024.

Before (tested on CLX):

root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

            765.35 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
              5.42 MiB  uncore_imc/cas_count_write/
        1001515088 ns   duration_time

       1.001515088 seconds time elapsed

After:

root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

            767.95 MiB  uncore_imc/cas_count_read/ #     0.80 DRAM_BW_Use
              5.02 MiB  uncore_imc/cas_count_write/
        1001900010 ns   duration_time

       1.001900010 seconds time elapsed

Fixes: 038d3b53c284 ("perf vendor events intel: Update CascadelakeX events to v1.08")
Fixes: b5ff7f2799a4 ("perf vendor events: Update SkylakeX events to v1.21")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index de3193552277..00f4fcffa815 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -329,7 +329,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index f31794d3b926..0dd8b13b5cfb 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -323,7 +323,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW;SoC",
         "MetricName": "DRAM_BW_Use"
     },
-- 
2.17.1

