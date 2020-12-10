Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B822D5613
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgLJJFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:05:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:6076 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgLJJFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:05:35 -0500
IronPort-SDR: 56HbneG6yRDgeoyccD+7LGCbk2zzrd7gkewNst/gxGtXtZ1kCPRTwngEuVy7nQJd9vk0emeObB
 G64w/DLWWGYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="170712738"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="170712738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 01:03:49 -0800
IronPort-SDR: MsTWgopju0+U046tZ6ykKF6KHzjXRVPcnmkAkXfmOxeG2m9o4AMKAafRyTon8fh//YMC7qRyoB
 XZry69/0W65A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="408450112"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2020 01:03:46 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        ak@linux.intel.com, alexander.antonov@linux.intel.com
Subject: [PATCH 1/5] perf stat: Add AGGR_IIO_STACK mode
Date:   Thu, 10 Dec 2020 12:03:36 +0300
Message-Id: <20201210090340.14358-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding AGGR_IIO_STACK mode to be able to distinguish aggr_mode
for IIO stacks in following patches.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/builtin-stat.c                           |  5 ++++-
 .../util/scripting-engines/trace-event-python.c     |  2 +-
 tools/perf/util/stat-display.c                      | 13 +++++++++++--
 tools/perf/util/stat.c                              |  3 ++-
 tools/perf/util/stat.h                              |  1 +
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f15b2f8aa14d..e3ff55de4f7a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1309,6 +1309,7 @@ static int perf_stat_init_aggr_mode(void)
 		break;
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
+	case AGGR_IIO_STACK:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -1499,6 +1500,7 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
+	case AGGR_IIO_STACK:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -2216,7 +2218,8 @@ int cmd_stat(int argc, const char **argv)
 	 * --per-thread is aggregated per thread, we dont mix it with cpu mode
 	 */
 	if (((stat_config.aggr_mode != AGGR_GLOBAL &&
-	      stat_config.aggr_mode != AGGR_THREAD) || nr_cgroups) &&
+	      stat_config.aggr_mode != AGGR_THREAD &&
+	      stat_config.aggr_mode != AGGR_IIO_STACK) || nr_cgroups) &&
 	    !target__has_cpu(&target)) {
 		fprintf(stderr, "both cgroup and no-aggregation "
 			"modes only available in system-wide mode\n");
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c83c2c6564e0..e8b472faeae4 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1401,7 +1401,7 @@ static void python_process_stat(struct perf_stat_config *config,
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
-	if (config->aggr_mode == AGGR_GLOBAL) {
+	if (config->aggr_mode == AGGR_GLOBAL || config->aggr_mode == AGGR_IIO_STACK) {
 		process_stat(counter, -1, -1, tstamp,
 			     &counter->counts->aggr);
 		return;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4b57c0c07632..3bfcdb80443a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -133,6 +133,7 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 		break;
 	case AGGR_GLOBAL:
+	case AGGR_IIO_STACK:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -330,7 +331,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_NONE)
 		return id;
 
-	if (config->aggr_mode == AGGR_GLOBAL)
+	if (config->aggr_mode == AGGR_GLOBAL || config->aggr_mode == AGGR_IIO_STACK)
 		return 0;
 
 	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
@@ -424,6 +425,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	if (config->csv_output && !config->metric_only) {
 		static int aggr_fields[] = {
 			[AGGR_GLOBAL] = 0,
+			[AGGR_IIO_STACK] = 0,
 			[AGGR_THREAD] = 1,
 			[AGGR_NONE] = 1,
 			[AGGR_SOCKET] = 2,
@@ -906,6 +908,7 @@ static int aggr_header_lens[] = {
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
 	[AGGR_GLOBAL] = 0,
+	[AGGR_IIO_STACK] = 0,
 };
 
 static const char *aggr_header_csv[] = {
@@ -914,7 +917,8 @@ static const char *aggr_header_csv[] = {
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_GLOBAL] 	=	""
+	[AGGR_GLOBAL]	=	"",
+	[AGGR_IIO_STACK] =	"port,"
 };
 
 static void print_metric_headers(struct perf_stat_config *config,
@@ -1001,6 +1005,9 @@ static void print_interval(struct perf_stat_config *config,
 			if (!metric_only)
 				fprintf(output, "                  counts %*s events\n", unit_width, "unit");
 			break;
+		case AGGR_IIO_STACK:
+			fprintf(output, "#           time    port        ");
+			break;
 		case AGGR_GLOBAL:
 		default:
 			fprintf(output, "#           time");
@@ -1246,6 +1253,8 @@ perf_evlist__print_counters(struct evlist *evlist,
 			}
 		}
 		break;
+	case AGGR_IIO_STACK:
+		break;
 	case AGGR_UNSET:
 	default:
 		break;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index bd0decd6d753..6a655f909587 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -363,6 +363,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 		break;
 	case AGGR_GLOBAL:
+	case AGGR_IIO_STACK:
 		aggr->val += count->val;
 		aggr->ena += count->ena;
 		aggr->run += count->run;
@@ -424,7 +425,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (ret)
 		return ret;
 
-	if (config->aggr_mode != AGGR_GLOBAL)
+	if (config->aggr_mode != AGGR_GLOBAL && config->aggr_mode != AGGR_IIO_STACK)
 		return 0;
 
 	if (!counter->snapshot)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 05adf8165025..d053ebd44ae3 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -50,6 +50,7 @@ enum aggr_mode {
 	AGGR_DIE,
 	AGGR_CORE,
 	AGGR_THREAD,
+	AGGR_IIO_STACK,
 	AGGR_UNSET,
 	AGGR_NODE,
 };
-- 
2.19.1

