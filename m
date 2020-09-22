Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39094273927
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIVDOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:14:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbgIVDOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:14:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 97E30C202CA77BABC662;
        Tue, 22 Sep 2020 11:14:31 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 11:14:21 +0800
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
Subject: [PATCH 2/2] perf stat: Unbreak perf stat with armv8_pmu events
Date:   Tue, 22 Sep 2020 11:13:46 +0800
Message-ID: <20200922031346.15051-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922031346.15051-1-liwei391@huawei.com>
References: <20200922031346.15051-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the segfault is fixed, perf-stat with armv8_pmu events with a
workload is still broken:

[root@localhost hulk]# tools/perf/perf stat -e armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls > /dev/null

 Performance counter stats for 'ls':

     <not counted>      armv8_pmuv3_0/ll_cache_rd/                                     (0.00%)
     <not counted>      armv8_pmuv3_0/ll_cache_miss_rd/                                     (0.00%)

       0.002052670 seconds time elapsed

       0.000000000 seconds user
       0.002086000 seconds sys

In fact, while the event will be opened per-thread,
create_perf_stat_counter() is called as many times as the count of cpu
in the evlist's cpumap, and lost all the file descriptors except the
last one. If this counter is not scheduled during the period of time,
it will be "not counted".

Add the process to don't open the needless events in such situation.

Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-stat.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6e6ceacce634..9a43b3de26d1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -712,6 +712,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity affinity;
 	int i, cpu;
 	bool second_pass = false;
+	bool open_per_thread = false;
 
 	if (forks) {
 		if (perf_evlist__prepare_workload(evsel_list, &target, argv, is_pipe,
@@ -726,16 +727,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__set_leader(evsel_list);
 
 	if (!(target__has_cpu(&target) && !target__has_per_thread(&target)))
-		evsel_list->core.open_per_thread = true;
+		evsel_list->core.open_per_thread = open_per_thread = true;
 
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
 	evlist__for_each_cpu (evsel_list, i, cpu) {
-		affinity__set(&affinity, cpu);
+		if (!open_per_thread)
+			affinity__set(&affinity, cpu);
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (evsel__cpu_iter_skip(counter, cpu))
+			if (!open_per_thread && evsel__cpu_iter_skip(counter, cpu))
 				continue;
 			if (counter->reset_group || counter->errored)
 				continue;
@@ -753,7 +755,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				if ((errno == EINVAL || errno == EBADF) &&
 				    counter->leader != counter &&
 				    counter->weak_group) {
-					perf_evlist__reset_weak_group(evsel_list, counter, false);
+					perf_evlist__reset_weak_group(evsel_list, counter,
+							open_per_thread);
 					assert(counter->reset_group);
 					second_pass = true;
 					continue;
@@ -773,6 +776,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			}
 			counter->supported = true;
 		}
+
+		if (open_per_thread)
+			break;
 	}
 
 	if (second_pass) {
@@ -782,20 +788,22 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		 */
 
 		evlist__for_each_cpu(evsel_list, i, cpu) {
-			affinity__set(&affinity, cpu);
-			/* First close errored or weak retry */
-			evlist__for_each_entry(evsel_list, counter) {
-				if (!counter->reset_group && !counter->errored)
-					continue;
-				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
-					continue;
-				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
+			if (!open_per_thread) {
+				affinity__set(&affinity, cpu);
+				/* First close errored or weak retry */
+				evlist__for_each_entry(evsel_list, counter) {
+					if (!counter->reset_group && !counter->errored)
+						continue;
+					if (evsel__cpu_iter_skip_no_inc(counter, cpu))
+						continue;
+					perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
+				}
 			}
 			/* Now reopen weak */
 			evlist__for_each_entry(evsel_list, counter) {
 				if (!counter->reset_group && !counter->errored)
 					continue;
-				if (evsel__cpu_iter_skip(counter, cpu))
+				if (!open_per_thread && evsel__cpu_iter_skip(counter, cpu))
 					continue;
 				if (!counter->reset_group)
 					continue;
@@ -817,6 +825,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				}
 				counter->supported = true;
 			}
+			if (open_per_thread)
+				break;
 		}
 	}
 	affinity__cleanup(&affinity);
-- 
2.17.1

