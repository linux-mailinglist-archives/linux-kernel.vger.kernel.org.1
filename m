Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCB1D26BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 07:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgENFi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 01:38:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:62468 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENFix (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:38:53 -0400
IronPort-SDR: IW9Qi4IUFYkmhNOdpkmgf4Rl686owWbKVHyKPRpeSBssmpOS+UcF1qA8aMnQ7dAOFKOMGe0rIE
 ecrqp9+Rrd0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 22:38:53 -0700
IronPort-SDR: XWvgmLmzzM5w0vEwuLbdOrjYifEog/5IPN1eLytFZKtoF/P1gkfyOh3SlUKR8Z+XffTu06OCr/
 mOmAOvGvU6qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="287289083"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2020 22:38:51 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 5/5] perf stat: Report summary for interval mode
Date:   Thu, 14 May 2020 13:36:38 +0800
Message-Id: <20200514053638.3736-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514053638.3736-1-yao.jin@linux.intel.com>
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf-stat supports to print counts at regular interval (-I),
but it's not very easy for user to get the overall statistics.

The patch uses 'evsel->prev_raw_counts' to get counts for summary.
Copy the counts to 'evsel->counts' after printing the interval results.
Next, we just follow the non-interval processing.

Let's see some examples,

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

 v5:
 ---
 Call perf_evlist__save_aggr_prev_raw_counts to save aggr value
 to first member of prev_raw_counts for AGGR_GLOBAL. Then next,
 perf_stat_process_counter can create aggr values from per cpu
 values.

 v4:
 ---
 Move affinity setup and read_counter_cpu to a new function
 read_affinity_counters. It's only called when stat_config.summary
 is not set.

 v3:
 ---
 Use evsel->prev_raw_counts for summary counts

 v2:
 ---
 Rebase to perf/core branch

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 31 ++++++++++++++++++++++++++++---
 tools/perf/util/stat.c    |  2 +-
 tools/perf/util/stat.h    |  1 +
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f3b3a59ac7d2..24deed746325 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -314,14 +314,14 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 	return 0;
 }
 
-static void read_counters(struct timespec *rs)
+static int read_affinity_counters(struct timespec *rs)
 {
 	struct evsel *counter;
 	struct affinity affinity;
 	int i, ncpus, cpu;
 
 	if (affinity__setup(&affinity) < 0)
-		return;
+		return -1;
 
 	ncpus = perf_cpu_map__nr(evsel_list->core.all_cpus);
 	if (!target__has_cpu(&target) || target__has_per_thread(&target))
@@ -341,6 +341,15 @@ static void read_counters(struct timespec *rs)
 		}
 	}
 	affinity__cleanup(&affinity);
+	return 0;
+}
+
+static void read_counters(struct timespec *rs)
+{
+	struct evsel *counter;
+
+	if (!stat_config.summary && (read_affinity_counters(rs) < 0))
+		return;
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (counter->err)
@@ -394,6 +403,7 @@ static void runtime_stat_reset(struct perf_stat_config *config)
 static void process_interval(void)
 {
 	struct timespec ts, rs;
+	struct stats walltime_nsecs_stats_bak;
 
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
@@ -407,9 +417,11 @@ static void process_interval(void)
 			pr_err("failed to write stat round event\n");
 	}
 
+	walltime_nsecs_stats_bak = walltime_nsecs_stats;
 	init_stats(&walltime_nsecs_stats);
 	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
 	print_counters(&rs, 0, NULL);
+	walltime_nsecs_stats = walltime_nsecs_stats_bak;
 }
 
 static void enable_counters(void)
@@ -765,6 +777,19 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	update_stats(&walltime_nsecs_stats, t1 - t0);
 
+	if (interval) {
+		stat_config.interval = 0;
+		stat_config.summary = true;
+
+		if (stat_config.aggr_mode == AGGR_GLOBAL)
+			perf_evlist__save_aggr_prev_raw_counts(evsel_list);
+
+		perf_evlist__copy_prev_raw_counts(evsel_list);
+		perf_evlist__reset_prev_raw_counts(evsel_list);
+		runtime_stat_reset(&stat_config);
+		perf_stat__reset_shadow_per_stat(&rt_stat);
+	}
+
 	/*
 	 * Closing a group leader splits the group, and as we only disable
 	 * group leaders, results in remaining events becoming enabled. To
@@ -2159,7 +2184,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (!forever && status != -1 && !interval)
+	if (!forever && status != -1 && (!interval || stat_config.summary))
 		print_counters(NULL, argc, argv);
 
 	if (STAT_RECORD) {
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index fbabdd5b9b62..481543c422a7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -398,7 +398,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	 * interval mode, otherwise overall avg running
 	 * averages will be shown for each interval.
 	 */
-	if (config->interval) {
+	if (config->interval || config->summary) {
 		for (i = 0; i < 3; i++)
 			init_stats(&ps->res_stats[i]);
 	}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 18ead55756cc..a5604a20bdca 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -110,6 +110,7 @@ struct perf_stat_config {
 	bool			 all_kernel;
 	bool			 all_user;
 	bool			 percore_show_thread;
+	bool			 summary;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

