Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0036304593
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393034AbhAZRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:43:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:6417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389504AbhAZIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:08:31 -0500
IronPort-SDR: JnvzVd5uwDrs46B+Wf5IYy3ywPvPu+I99My3tUhG4xRLb3br+i5STKkycRR3HskUr6K/RSeYVB
 hfyTF0f/scCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264688784"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264688784"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:06:26 -0800
IronPort-SDR: Xwih2bPWmqG765NIRZcRi24o/BHM5bVsSqs5Qatjg603lAjwhA4pmrKIduQbTEZOMg0tava6nt
 SmpJ7UgI0HHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="572855797"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2021 00:06:23 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v3 1/5] perf stat: Add AGGR_PCIE_PORT mode
Date:   Tue, 26 Jan 2021 11:06:15 +0300
Message-Id: <20210126080619.30275-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
References: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding AGGR_PCIE_PORT mode to be able to distinguish aggr_mode
for root ports in following patches.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/builtin-stat.c                           |  5 ++++-
 .../util/scripting-engines/trace-event-python.c     |  3 ++-
 tools/perf/util/stat-display.c                      | 13 +++++++++++--
 tools/perf/util/stat.c                              |  4 +++-
 tools/perf/util/stat.h                              |  1 +
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..60fdb6a0805f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -908,6 +908,7 @@ static int perf_stat_init_aggr_mode(void)
 		break;
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
+	case AGGR_PCIE_PORT:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -1072,6 +1073,7 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
+	case AGGR_PCIE_PORT:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -1844,7 +1846,8 @@ int cmd_stat(int argc, const char **argv)
 	 * --per-thread is aggregated per thread, we dont mix it with cpu mode
 	 */
 	if (((stat_config.aggr_mode != AGGR_GLOBAL &&
-	      stat_config.aggr_mode != AGGR_THREAD) || nr_cgroups) &&
+	      stat_config.aggr_mode != AGGR_THREAD &&
+	      stat_config.aggr_mode != AGGR_PCIE_PORT) || nr_cgroups) &&
 	    !target__has_cpu(&target)) {
 		fprintf(stderr, "both cgroup and no-aggregation "
 			"modes only available in system-wide mode\n");
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 5d341efc3237..e604c199f493 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1396,7 +1396,8 @@ static void python_process_stat(struct perf_stat_config *config,
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
-	if (config->aggr_mode == AGGR_GLOBAL) {
+	if (config->aggr_mode == AGGR_GLOBAL ||
+	    config->aggr_mode == AGGR_PCIE_PORT) {
 		process_stat(counter, -1, -1, tstamp,
 			     &counter->counts->aggr);
 		return;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ed3b0ac2f785..db1bec115d0b 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -123,6 +123,7 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 		break;
 	case AGGR_GLOBAL:
+	case AGGR_PCIE_PORT:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -322,7 +323,8 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_NONE)
 		return id;
 
-	if (config->aggr_mode == AGGR_GLOBAL)
+	if (config->aggr_mode == AGGR_GLOBAL ||
+	    config->aggr_mode == AGGR_PCIE_PORT)
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
@@ -416,6 +418,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	if (config->csv_output && !config->metric_only) {
 		static int aggr_fields[] = {
 			[AGGR_GLOBAL] = 0,
+			[AGGR_PCIE_PORT] = 0,
 			[AGGR_THREAD] = 1,
 			[AGGR_NONE] = 1,
 			[AGGR_SOCKET] = 2,
@@ -899,6 +902,7 @@ static int aggr_header_lens[] = {
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
 	[AGGR_GLOBAL] = 0,
+	[AGGR_PCIE_PORT] = 0,
 };
 
 static const char *aggr_header_csv[] = {
@@ -907,7 +911,8 @@ static const char *aggr_header_csv[] = {
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_GLOBAL] 	=	""
+	[AGGR_GLOBAL]	=	"",
+	[AGGR_PCIE_PORT] =	"port,"
 };
 
 static void print_metric_headers(struct perf_stat_config *config,
@@ -990,6 +995,8 @@ static void print_interval(struct perf_stat_config *config,
 			if (!metric_only)
 				fprintf(output, "                  counts %*s events\n", unit_width, "unit");
 			break;
+		case AGGR_PCIE_PORT:
+			break;
 		case AGGR_GLOBAL:
 		default:
 			fprintf(output, "#           time");
@@ -1214,6 +1221,8 @@ perf_evlist__print_counters(struct evlist *evlist,
 			}
 		}
 		break;
+	case AGGR_PCIE_PORT:
+		break;
 	case AGGR_UNSET:
 	default:
 		break;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ebdd130557fb..9ffb97b31710 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -318,6 +318,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 		break;
 	case AGGR_GLOBAL:
+	case AGGR_PCIE_PORT:
 		aggr->val += count->val;
 		aggr->ena += count->ena;
 		aggr->run += count->run;
@@ -377,7 +378,8 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (ret)
 		return ret;
 
-	if (config->aggr_mode != AGGR_GLOBAL)
+	if (config->aggr_mode != AGGR_GLOBAL &&
+	    config->aggr_mode != AGGR_PCIE_PORT)
 		return 0;
 
 	if (!counter->snapshot)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index edbeb2f63e8d..c7544c28c02a 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -46,6 +46,7 @@ enum aggr_mode {
 	AGGR_DIE,
 	AGGR_CORE,
 	AGGR_THREAD,
+	AGGR_PCIE_PORT,
 	AGGR_UNSET,
 };
 
-- 
2.19.1

