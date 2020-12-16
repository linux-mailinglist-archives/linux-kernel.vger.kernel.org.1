Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D522DBBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLPHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:04:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:18954 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgLPHEw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:04:52 -0500
IronPort-SDR: qIjE2qitZNLw1Z27kUBu/KeIjXesWb3J01eNtMM7pWZyvYY7j92VXM0eYsFlLFUAns6Jyj8Zoz
 FI2l8cbBGvMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239113897"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="239113897"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 23:03:05 -0800
IronPort-SDR: okn4Mi24VcvQfo5Vdb1oLnNHNuI4rdXbz5ACQRJrafDv4/WljHRf+BLHrAqMLZsCskdhcyY7RL
 /iMIJXqfcQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="559632470"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 15 Dec 2020 23:03:02 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Fix wrong skipping for per-die aggregation
Date:   Wed, 16 Dec 2020 15:01:46 +0800
Message-Id: <20201216070146.11769-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uncore becomes die-scope on Xeon Cascade Lake-AP and perf has supported
--per-die aggregation yet.

One issue is found in check_per_pkg() for uncore events running on
AP system. On cascade Lake-AP, we have:

S0-D0
S0-D1
S1-D0
S1-D1

But in check_per_pkg(), S0-D1 and S1-D1 are skipped because the
mask bits for S0 and S1 have been set for S0-D0 and S1-D0. It doesn't
check die_id. So the counting for S0-D1 and S1-D1 are set to zero.
That's not correct.

root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
     1.001460963 S0-D0           1            1317376 Bytes llc_misses.mem_read
     1.001460963 S0-D1           1             998016 Bytes llc_misses.mem_read
     1.001460963 S1-D0           1             970496 Bytes llc_misses.mem_read
     1.001460963 S1-D1           1            1291264 Bytes llc_misses.mem_read
     2.003488021 S0-D0           1            1082048 Bytes llc_misses.mem_read
     2.003488021 S0-D1           1            1919040 Bytes llc_misses.mem_read
     2.003488021 S1-D0           1             890752 Bytes llc_misses.mem_read
     2.003488021 S1-D1           1            2380800 Bytes llc_misses.mem_read
     3.005613270 S0-D0           1            1126080 Bytes llc_misses.mem_read
     3.005613270 S0-D1           1            2898176 Bytes llc_misses.mem_read
     3.005613270 S1-D0           1             870912 Bytes llc_misses.mem_read
     3.005613270 S1-D1           1            3388608 Bytes llc_misses.mem_read
     4.007627598 S0-D0           1            1124608 Bytes llc_misses.mem_read
     4.007627598 S0-D1           1            3884416 Bytes llc_misses.mem_read
     4.007627598 S1-D0           1             921088 Bytes llc_misses.mem_read
     4.007627598 S1-D1           1            4451840 Bytes llc_misses.mem_read
     5.001479927 S0-D0           1             963328 Bytes llc_misses.mem_read
     5.001479927 S0-D1           1            4831936 Bytes llc_misses.mem_read
     5.001479927 S1-D0           1             895104 Bytes llc_misses.mem_read
     5.001479927 S1-D1           1            5496640 Bytes llc_misses.mem_read

From above output, we can see S0-D1 and S1-D1 don't report the interval
values, they are continued to grow. That's because check_per_pkg() wrongly
decides to use zero counts for S0-D1 and S1-D1.

So in check_per_pkg(), we should use a pair of die_id + socket_id to
decide if this cpu counts needs to skip. Only considering socket_id is
not enough.

Now with this patch,

root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
     1.001622560 S0-D0           1            1210176 Bytes llc_misses.mem_read
     1.001622560 S0-D1           1             950208 Bytes llc_misses.mem_read
     1.001622560 S1-D0           1             968704 Bytes llc_misses.mem_read
     1.001622560 S1-D1           1            1113280 Bytes llc_misses.mem_read
     2.004399430 S0-D0           1            1258560 Bytes llc_misses.mem_read
     2.004399430 S0-D1           1            1011008 Bytes llc_misses.mem_read
     2.004399430 S1-D0           1            1036544 Bytes llc_misses.mem_read
     2.004399430 S1-D1           1            1237376 Bytes llc_misses.mem_read
     3.006535657 S0-D0           1            1036608 Bytes llc_misses.mem_read
     3.006535657 S0-D1           1             906560 Bytes llc_misses.mem_read
     3.006535657 S1-D0           1             994112 Bytes llc_misses.mem_read
     3.006535657 S1-D1           1            1025472 Bytes llc_misses.mem_read
     4.008934402 S0-D0           1            1005120 Bytes llc_misses.mem_read
     4.008934402 S0-D1           1             882368 Bytes llc_misses.mem_read
     4.008934402 S1-D0           1             961408 Bytes llc_misses.mem_read
     4.008934402 S1-D1           1             988352 Bytes llc_misses.mem_read
     5.001605406 S0-D0           1            1930240 Bytes llc_misses.mem_read
     5.001605406 S0-D1           1            1134272 Bytes llc_misses.mem_read
     5.001605406 S1-D0           1            1531136 Bytes llc_misses.mem_read
     5.001605406 S1-D1           1            2230848 Bytes llc_misses.mem_read

On no-die system, die_id is 0, this patch keeps original behavior unchanged.

Reported-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/cpumap.h |  2 ++
 tools/perf/util/stat.c   | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 3a442f021468..58604c047121 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,6 +7,8 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
+#define CPU_MAP_MAX_DIE	256
+
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 1e125e39ff84..b3fc6e261fe0 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -282,9 +282,9 @@ static void zero_per_pkg(struct evsel *counter)
 static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
-	unsigned long *mask = counter->per_pkg_mask;
+	unsigned long *mask = counter->per_pkg_mask, *l;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
-	int s;
+	int s, d;
 
 	*skip = false;
 
@@ -295,7 +295,7 @@ static int check_per_pkg(struct evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(cpu__max_cpu());
+		mask = zalloc(cpu__max_cpu() * CPU_MAP_MAX_DIE);
 		if (!mask)
 			return -ENOMEM;
 
@@ -317,7 +317,20 @@ static int check_per_pkg(struct evsel *counter,
 	if (s < 0)
 		return -1;
 
-	*skip = test_and_set_bit(s, mask) == 1;
+	d = cpu_map__get_die(cpus, cpu, NULL);
+	if (d < 0)
+		return -1;
+
+	/*
+	 * On multi-die system, die_id < 256. We use a pair
+	 * of socket + die to identify the used bit.
+	 * On no-die system, die_id is 0, l = &mask[0]. It doesn't
+	 * change original "test_and_set_bit(s, mask)" behavior.
+	 */
+	d &= 0xff;
+	l = &mask[d];
+
+	*skip = test_and_set_bit(s, l) == 1;
 	return 0;
 }
 
-- 
2.17.1

