Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0204E30459A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392104AbhAZRoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:44:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:6423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389548AbhAZIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:08:31 -0500
IronPort-SDR: M4dcpBfB4pZutfbylaIpyQ8k6Jfo7aGUqWaChpOYJp9XhBJArhmEV/1tYWaiihOD3/vt1YLwJk
 mVHEPJT0GgAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264688804"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264688804"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:06:29 -0800
IronPort-SDR: 6blULLh7h+eU5AemzX0LCrSRvFarvDxSndk9fBBOg3hdomN6/gqi2mV7dFDTTYr+RqvyaHv5+s
 7CCMY9S+LvYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="572855830"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2021 00:06:26 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v3 2/5] perf stat: Basic support for iostat in perf
Date:   Tue, 26 Jan 2021 11:06:16 +0300
Message-Id: <20210126080619.30275-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
References: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic flow for a new iostat mode in perf. Mode is intended to
provide four I/O performance metrics per each PCIe root port: Inbound Read,
Inbound Write, Outbound Read, Outbound Write.

The actual code to compute the metrics and attribute it to
root port is in follow-on patches.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/builtin-stat.c      | 31 ++++++++++++++++++++++++++
 tools/perf/util/iostat.h       | 32 +++++++++++++++++++++++++++
 tools/perf/util/stat-display.c | 40 +++++++++++++++++++++++++++++++++-
 tools/perf/util/stat-shadow.c  | 11 +++++++++-
 tools/perf/util/stat.h         |  1 +
 5 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/iostat.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 60fdb6a0805f..66c913692120 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -65,6 +65,7 @@
 #include "util/target.h"
 #include "util/time-utils.h"
 #include "util/top.h"
+#include "util/iostat.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -186,6 +187,7 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.iostat_run		= false,
 };
 
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
@@ -723,6 +725,14 @@ static int parse_metric_groups(const struct option *opt,
 	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
+__weak int iostat_parse(const struct option *opt __maybe_unused,
+			 const char *str __maybe_unused,
+			 int unset __maybe_unused)
+{
+	pr_err("iostat mode is not supported\n");
+	return -1;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -803,6 +813,8 @@ static struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "root port",
+			    "measure PCIe metrics per root port", iostat_parse),
 	OPT_END()
 };
 
@@ -1131,6 +1143,12 @@ __weak void arch_topdown_group_warn(void)
 {
 }
 
+__weak int iostat_list(struct evlist *evlist __maybe_unused,
+			struct perf_stat_config *config __maybe_unused)
+{
+	return 0;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1682,6 +1700,10 @@ static void setup_system_wide(int forks)
 	}
 }
 
+__weak void iostat_release(struct evlist *evlist __maybe_unused)
+{
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	const char * const stat_usage[] = {
@@ -1858,6 +1880,12 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.iostat_run) {
+		status = iostat_list(evsel_list, &stat_config);
+		if (status || !stat_config.iostat_run)
+			goto out;
+	}
+
 	if (add_default_attributes())
 		goto out;
 
@@ -2008,6 +2036,9 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
+	if (stat_config.iostat_run)
+		iostat_release(evsel_list);
+
 	zfree(&stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
new file mode 100644
index 000000000000..b34ebedfd5e6
--- /dev/null
+++ b/tools/perf/util/iostat.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * perf iostat
+ *
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
+ */
+
+#ifndef _IOSTAT_H
+#define _IOSTAT_H
+
+#include <subcmd/parse-options.h>
+#include "util/stat.h"
+#include "util/parse-events.h"
+#include "util/evlist.h"
+
+struct option;
+struct perf_stat_config;
+struct evlist;
+struct timespec;
+
+int iostat_parse(const struct option *opt, const char *str,
+		 int unset __maybe_unused);
+void iostat_prefix(struct perf_stat_config *config, struct evlist *evlist,
+		   char *prefix, struct timespec *ts);
+void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+			 struct perf_stat_output_ctx *out);
+int iostat_list(struct evlist *evlist, struct perf_stat_config *config);
+void iostat_release(struct evlist *evlist);
+
+#endif /* _IOSTAT_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index db1bec115d0b..de78cf6962b9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 #include "cgroup.h"
 #include <api/fs/fs.h>
+#include "iostat.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -302,6 +303,11 @@ static void print_metric_header(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	char tbuf[1024];
 
+	/* In case of iostat, print metric header for first root port only */
+	if (config->iostat_run &&
+	    os->evsel->priv != os->evsel->evlist->selected->priv)
+		return;
+
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
@@ -936,6 +942,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 			fputs("time,", config->output);
 		fputs(aggr_header_csv[config->aggr_mode], config->output);
 	}
+	if (config->iostat_run && !config->interval && !config->csv_output)
+		fprintf(config->output, "   port         ");
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
@@ -954,6 +962,13 @@ static void print_metric_headers(struct perf_stat_config *config,
 	fputc('\n', config->output);
 }
 
+__weak void iostat_prefix(struct perf_stat_config *config __maybe_unused,
+			  struct evlist *evlist __maybe_unused,
+			  char *prefix __maybe_unused,
+			  struct timespec *ts __maybe_unused)
+{
+}
+
 static void print_interval(struct perf_stat_config *config,
 			   struct evlist *evlist,
 			   char *prefix, struct timespec *ts)
@@ -966,7 +981,10 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
+	if (!config->iostat_run)
+		sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec,
+						ts->tv_nsec,
+						config->csv_sep);
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
@@ -996,6 +1014,7 @@ static void print_interval(struct perf_stat_config *config,
 				fprintf(output, "                  counts %*s events\n", unit_width, "unit");
 			break;
 		case AGGR_PCIE_PORT:
+			fprintf(output, "#           time    port        ");
 			break;
 		case AGGR_GLOBAL:
 		default:
@@ -1174,6 +1193,10 @@ perf_evlist__print_counters(struct evlist *evlist,
 	int interval = config->interval;
 	struct evsel *counter;
 	char buf[64], *prefix = NULL;
+	void *perf_device = NULL;
+
+	if (config->iostat_run)
+		evlist->selected = evlist__first(evlist);
 
 	if (interval)
 		print_interval(config, evlist, prefix = buf, ts);
@@ -1222,6 +1245,21 @@ perf_evlist__print_counters(struct evlist *evlist,
 		}
 		break;
 	case AGGR_PCIE_PORT:
+		counter = evlist__first(evlist);
+		perf_evlist__set_selected(evlist, counter);
+		iostat_prefix(config, evlist, prefix = buf, ts);
+		fprintf(config->output, "%s", prefix);
+		evlist__for_each_entry(evlist, counter) {
+			perf_device = evlist->selected->priv;
+			if (perf_device && perf_device != counter->priv) {
+				perf_evlist__set_selected(evlist, counter);
+				iostat_prefix(config, evlist, prefix, ts);
+				fprintf(config->output, "\n%s", prefix);
+			}
+			print_counter_aggr(config, counter, prefix);
+			if ((counter->idx + 1) == evlist->core.nr_entries)
+				fputc('\n', config->output);
+		}
 		break;
 	case AGGR_UNSET:
 	default:
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..083a450c6dc7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -9,6 +9,7 @@
 #include "expr.h"
 #include "metricgroup.h"
 #include <linux/zalloc.h>
+#include "iostat.h"
 
 /*
  * AGGR_GLOBAL: Use CPU 0
@@ -814,6 +815,12 @@ static void generic_metric(struct perf_stat_config *config,
 		zfree(&pctx.ids[i].name);
 }
 
+__weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
+				struct evsel *evsel __maybe_unused,
+				struct perf_stat_output_ctx *out __maybe_unused)
+{
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int cpu,
@@ -829,7 +836,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	struct metric_event *me;
 	int num = 1;
 
-	if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
+	if (config->iostat_run) {
+		iostat_print_metric(config, evsel, out);
+	} else if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 		if (total) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c7544c28c02a..c2a2b28effd6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -107,6 +107,7 @@ struct perf_stat_config {
 	bool			 big_num;
 	bool			 no_merge;
 	bool			 walltime_run_table;
+	bool			 iostat_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.19.1

