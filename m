Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070AE2EA367
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbhAECjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:39:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:10750 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbhAECjS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:39:18 -0500
IronPort-SDR: KK6qr/6Ah4NFIVr/lVIQl99x2HZCXnz2zr4DERM+3G3MwXHGIldKQvjEGYJyfJE0Vl2EZjoTwK
 glfpR6Qyow/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156825929"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156825929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:37:32 -0800
IronPort-SDR: 2/jvqHM0K80S/gzaKhqWgTgjnVFP3NZ17iwTyoX8sIV65GbRefLvOkRsbqt9elM7JQFC1Gwlz6
 /NMcAo7ILrPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="395110061"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2021 18:37:28 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4] perf stat: Fix wrong skipping for per-die aggregation
Date:   Tue,  5 Jan 2021 10:36:15 +0800
Message-Id: <20210105023615.5761-1-yao.jin@linux.intel.com>
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

So in check_per_pkg(), we should use hashmap(socket,die) to decide if
the cpu counts needs to skip. Only considering socket is not enough.

Now with this patch,

root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
     1.001617187 S0-D0           1             952768 Bytes llc_misses.mem_read
     1.001617187 S0-D1           1             849152 Bytes llc_misses.mem_read
     1.001617187 S1-D0           1             854912 Bytes llc_misses.mem_read
     1.001617187 S1-D1           1             948672 Bytes llc_misses.mem_read
     2.004138021 S0-D0           1            1200256 Bytes llc_misses.mem_read
     2.004138021 S0-D1           1             899840 Bytes llc_misses.mem_read
     2.004138021 S1-D0           1             898752 Bytes llc_misses.mem_read
     2.004138021 S1-D1           1            1039424 Bytes llc_misses.mem_read
     3.006463971 S0-D0           1            1029056 Bytes llc_misses.mem_read
     3.006463971 S0-D1           1             894336 Bytes llc_misses.mem_read
     3.006463971 S1-D0           1             905088 Bytes llc_misses.mem_read
     3.006463971 S1-D1           1            1042880 Bytes llc_misses.mem_read
     4.008831441 S0-D0           1             920576 Bytes llc_misses.mem_read
     4.008831441 S0-D1           1             877248 Bytes llc_misses.mem_read
     4.008831441 S1-D0           1             883968 Bytes llc_misses.mem_read
     4.008831441 S1-D1           1             967168 Bytes llc_misses.mem_read
     5.001441349 S0-D0           1             864704 Bytes llc_misses.mem_read
     5.001441349 S0-D1           1             827456 Bytes llc_misses.mem_read
     5.001441349 S1-D0           1             829632 Bytes llc_misses.mem_read
     5.001441349 S1-D1           1             925760 Bytes llc_misses.mem_read

On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
is not changed.

Reported-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4:
 v3 used unnecessary bool allocatioin. v4 just uses the hash value '(void *)1'.

 v4 is compiled ok with tmp.perf/core.
 
v3:
 Since for some cpumap functions, the return type is changed from 'int' to
 'struct aggr_cpu_id', the patch needs to be updated as well.

 before:
   d = cpu_map__get_die()

 after:
   d = cpu_map__get_die().die

 v3 is compiled ok with tmp.perf/core.

v2:
 Use hashmap to check the used socket+die pair.

 tools/perf/util/evsel.c |  4 +++-
 tools/perf/util/evsel.h |  3 ++-
 tools/perf/util/stat.c  | 41 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c26ea82220bd..9715ed9b03f6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -45,6 +45,7 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util.h"
+#include "hashmap.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
@@ -1377,7 +1378,8 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
-	zfree(&evsel->per_pkg_mask);
+	hashmap__free(evsel->per_pkg_mask);
+	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd1d8dd43199..951628943fd0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -17,6 +17,7 @@ struct cgroup;
 struct perf_counts;
 struct perf_stat_evsel;
 union perf_event;
+struct hashmap;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
@@ -110,7 +111,7 @@ struct evsel {
 	bool			merged_stat;
 	bool			reset_group;
 	bool			errored;
-	unsigned long		*per_pkg_mask;
+	struct hashmap		*per_pkg_mask;
 	struct evsel		*leader;
 	struct list_head	config_terms;
 	int			err;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8ce1479c98f0..a658e0ffaf2a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -13,6 +13,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
+#include "hashmap.h"
 #include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
@@ -276,15 +277,29 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
+		hashmap__clear(counter->per_pkg_mask);
+}
+
+static size_t pkg_id_hash(const void *key, void *ctx __maybe_unused)
+{
+	int socket = (int64_t)key >> 32;
+
+	return socket;
+}
+
+static bool pkg_id_equal(const void *key1, const void *key2,
+			 void *ctx __maybe_unused)
+{
+	return (int64_t)key1 == (int64_t)key2;
 }
 
 static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
-	unsigned long *mask = counter->per_pkg_mask;
+	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
-	int s;
+	int s, d, ret;
+	uint64_t key;
 
 	*skip = false;
 
@@ -295,7 +310,7 @@ static int check_per_pkg(struct evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(cpu__max_cpu());
+		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
 		if (!mask)
 			return -ENOMEM;
 
@@ -317,7 +332,23 @@ static int check_per_pkg(struct evsel *counter,
 	if (s < 0)
 		return -1;
 
-	*skip = test_and_set_bit(s, mask) == 1;
+	/*
+	 * On multi-die system, 0 < die_id < 256. On no-die system, die_id = 0.
+	 * We use hashmap(socket, die) to check the used socket+die pair.
+	 */
+	d = cpu_map__get_die(cpus, cpu, NULL).die;
+	if (d < 0)
+		return -1;
+
+	key = (uint64_t)s << 32 | (d & 0xff);
+	if (hashmap__find(mask, (void *)key, NULL)) {
+		*skip = true;
+	} else {
+		ret = hashmap__add(mask, (void *)key, (void *)1);
+		if (ret)
+			return -1;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

