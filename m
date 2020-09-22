Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAE273925
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIVDO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:14:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbgIVDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:14:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8F50736975DDAE624B91;
        Tue, 22 Sep 2020 11:14:26 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 11:14:20 +0800
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
Subject: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu events
Date:   Tue, 22 Sep 2020 11:13:45 +0800
Message-ID: <20200922031346.15051-2-liwei391@huawei.com>
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

When executing perf stat with armv8_pmu events with a workload, it will
report a segfault as result.

(gdb) bt
#0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
    cpu=<optimized out>) at evsel.c:122
#1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
#2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
#3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
    argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
    at builtin-stat.c:929
#4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
    argc=1) at builtin-stat.c:947
#5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
#6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
    argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
#7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
    argv=argv@entry=0xfffffaea2f90) at perf.c:364
#8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
    argv=<synthetic pointer>) at perf.c:408
#9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538

After debugging, i found the root reason is that the xyarray fd is created
by evsel__open_per_thread() ignoring the cpu passed in
create_perf_stat_counter(), while the evsel' cpumap is assigned as the
corresponding PMU's cpumap in __add_event(). Thus, the xyarray fd is created
with ncpus of dummy cpumap and an out of bounds 'cpu' index will be used in
perf_evsel__close_fd_cpu().

To address this, add a flag to mark this situation and avoid using the
affinity technique when closing/enabling/disabling events.

Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
Fixes: 704e2f5b700d ("perf stat: Use affinity for enabling/disabling events")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/perf/builtin-stat.c                |  3 +++
 tools/perf/util/evlist.c                 | 23 ++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 2d0fa02b036f..c02d7e583846 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -17,6 +17,7 @@ struct perf_evlist {
 	struct list_head	 entries;
 	int			 nr_entries;
 	bool			 has_user_cpus;
+	bool			 open_per_thread;
 	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*all_cpus;
 	struct perf_thread_map	*threads;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fddc97cac984..6e6ceacce634 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -725,6 +725,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (group)
 		perf_evlist__set_leader(evsel_list);
 
+	if (!(target__has_cpu(&target) && !target__has_per_thread(&target)))
+		evsel_list->core.open_per_thread = true;
+
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e3fa3bf7498a..bf8a3ccc599f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -383,6 +383,15 @@ void evlist__disable(struct evlist *evlist)
 	int cpu, i, imm = 0;
 	bool has_imm = false;
 
+	if (evlist->core.open_per_thread) {
+		evlist__for_each_entry(evlist, pos) {
+			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__disable(pos);
+		}
+		goto out;
+	}
+
 	if (affinity__setup(&affinity) < 0)
 		return;
 
@@ -414,6 +423,7 @@ void evlist__disable(struct evlist *evlist)
 		pos->disabled = true;
 	}
 
+out:
 	evlist->enabled = false;
 }
 
@@ -423,6 +433,15 @@ void evlist__enable(struct evlist *evlist)
 	struct affinity affinity;
 	int cpu, i;
 
+	if (evlist->core.open_per_thread) {
+		evlist__for_each_entry(evlist, pos) {
+			if (!evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__enable(pos);
+		}
+		goto out;
+	}
+
 	if (affinity__setup(&affinity) < 0)
 		return;
 
@@ -444,6 +463,7 @@ void evlist__enable(struct evlist *evlist)
 		pos->disabled = false;
 	}
 
+out:
 	evlist->enabled = true;
 }
 
@@ -1223,9 +1243,10 @@ void evlist__close(struct evlist *evlist)
 
 	/*
 	 * With perf record core.cpus is usually NULL.
+	 * Or perf stat may open events per-thread.
 	 * Use the old method to handle this for now.
 	 */
-	if (!evlist->core.cpus) {
+	if (evlist->core.open_per_thread || !evlist->core.cpus) {
 		evlist__for_each_entry_reverse(evlist, evsel)
 			evsel__close(evsel);
 		return;
-- 
2.17.1

