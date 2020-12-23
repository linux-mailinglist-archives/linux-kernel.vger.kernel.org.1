Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6E2E1C79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgLWNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:05:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:28524 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgLWNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:05:17 -0500
IronPort-SDR: ZCAKMwng81xhcKffDKr0UzsR420ocXg0KflTDi0iBr8j3AXMuPHR0cfQ+3zzl4RHVs32wL8mPn
 +xkp7r2fweWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="155801783"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="155801783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 05:03:32 -0800
IronPort-SDR: wFbrQF8A2YW3nGVQyGLP3dL5AxD+dfPIGMv6ZCmKKH+mPCZLlIb0dbGMj7tTsxuL3idsAKgVrQ
 nhFhMvNNgtxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="393087770"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2020 05:03:29 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v2 3/6] perf stat: Basic support for iiostat in perf
Date:   Wed, 23 Dec 2020 16:03:17 +0300
Message-Id: <20201223130320.3930-4-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic flow for a new iiostat mode in perf. Mode is intended to
provide four I/O performance metrics per each IIO stack: Inbound Read,
Inbound Write, Outbound Read, Outbound Write.

The actual code to compute the metrics and attribute it to
evsel::perf_device is in follow-on patches.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/builtin-stat.c      | 33 ++++++++++++++++++++++++++++-
 tools/perf/util/iiostat.h      | 33 +++++++++++++++++++++++++++++
 tools/perf/util/stat-display.c | 38 +++++++++++++++++++++++++++++++++-
 tools/perf/util/stat-shadow.c  | 11 +++++++++-
 tools/perf/util/stat.h         |  1 +
 5 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/iiostat.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 72f9d0aa3f96..14c3da136927 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -67,6 +67,7 @@
 #include "util/top.h"
 #include "util/affinity.h"
 #include "util/pfm.h"
+#include "util/iiostat.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -198,7 +199,8 @@ static struct perf_stat_config stat_config = {
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
 	.ctl_fd			= -1,
-	.ctl_fd_ack		= -1
+	.ctl_fd_ack		= -1,
+	.iiostat_run		= false,
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -1073,6 +1075,14 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
+__weak int iiostat_parse(const struct option *opt __maybe_unused,
+			 const char *str __maybe_unused,
+			 int unset __maybe_unused)
+{
+	pr_err("iiostat mode is not supported\n");
+	return -1;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1185,6 +1195,8 @@ static struct option stat_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK_OPTARG(0, "iiostat", &evsel_list, &stat_config, "root port",
+			    "measure PCIe metrics per IIO stack", iiostat_parse),
 	OPT_END()
 };
 
@@ -1509,6 +1521,12 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+__weak int iiostat_show_root_ports(struct evlist *evlist __maybe_unused,
+				   struct perf_stat_config *config __maybe_unused)
+{
+	return 0;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -2054,6 +2072,10 @@ static void setup_system_wide(int forks)
 	}
 }
 
+__weak void iiostat_delete_root_ports(struct evlist *evlist __maybe_unused)
+{
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	const char * const stat_usage[] = {
@@ -2230,6 +2252,12 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.iiostat_run) {
+		status = iiostat_show_root_ports(evsel_list, &stat_config);
+		if (status || !stat_config.iiostat_run)
+			goto out;
+	}
+
 	if (add_default_attributes())
 		goto out;
 
@@ -2406,6 +2434,9 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
+	if (stat_config.iiostat_run)
+		iiostat_delete_root_ports(evsel_list);
+
 	zfree(&stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
diff --git a/tools/perf/util/iiostat.h b/tools/perf/util/iiostat.h
new file mode 100644
index 000000000000..8d4226df9975
--- /dev/null
+++ b/tools/perf/util/iiostat.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * perf iiostat
+ *
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
+ */
+
+#ifndef _IIOSTAT_H
+#define _IIOSTAT_H
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
+int iiostat_parse(const struct option *opt, const char *str,
+		  int unset __maybe_unused);
+void iiostat_prefix(struct perf_stat_config *config, struct evlist *evlist,
+		    char *prefix, struct timespec *ts);
+void iiostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+			  struct perf_stat_output_ctx *out);
+int iiostat_show_root_ports(struct evlist *evlist,
+			    struct perf_stat_config *config);
+void iiostat_delete_root_ports(struct evlist *evlist);
+
+#endif /* _IIOSTAT_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3bfcdb80443a..9eb8484e8b90 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -17,6 +17,7 @@
 #include "cgroup.h"
 #include <api/fs/fs.h>
 #include "util.h"
+#include "iiostat.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -310,6 +311,12 @@ static void print_metric_header(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	char tbuf[1024];
 
+	/* In case of iiostat, print metric header for first perf_device only */
+	if (os->evsel->perf_device && os->evsel->evlist->selected->perf_device &&
+	    config->iiostat_run &&
+	    os->evsel->perf_device != os->evsel->evlist->selected->perf_device)
+		return;
+
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
@@ -942,6 +949,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 			fputs("time,", config->output);
 		fputs(aggr_header_csv[config->aggr_mode], config->output);
 	}
+	if (config->iiostat_run && !config->interval && !config->csv_output)
+		fprintf(config->output, "   port         ");
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
@@ -959,6 +968,13 @@ static void print_metric_headers(struct perf_stat_config *config,
 	fputc('\n', config->output);
 }
 
+__weak void iiostat_prefix(struct perf_stat_config *config __maybe_unused,
+			    struct evlist *evlist __maybe_unused,
+			    char *prefix __maybe_unused,
+			    struct timespec *ts __maybe_unused)
+{
+}
+
 static void print_interval(struct perf_stat_config *config,
 			   struct evlist *evlist,
 			   char *prefix, struct timespec *ts)
@@ -971,7 +987,8 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
+	if (!config->iiostat_run)
+		sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
@@ -1205,6 +1222,10 @@ perf_evlist__print_counters(struct evlist *evlist,
 	int interval = config->interval;
 	struct evsel *counter;
 	char buf[64], *prefix = NULL;
+	void *device = NULL;
+
+	if (config->iiostat_run)
+		evlist->selected = evlist__first(evlist);
 
 	if (interval)
 		print_interval(config, evlist, prefix = buf, ts);
@@ -1254,6 +1275,21 @@ perf_evlist__print_counters(struct evlist *evlist,
 		}
 		break;
 	case AGGR_IIO_STACK:
+		counter = evlist__first(evlist);
+		perf_evlist__set_selected(evlist, counter);
+		iiostat_prefix(config, evlist, prefix = buf, ts);
+		fprintf(config->output, "%s", prefix);
+		evlist__for_each_entry(evlist, counter) {
+			device = evlist->selected->perf_device;
+			if (device && device != counter->perf_device) {
+				perf_evlist__set_selected(evlist, counter);
+				iiostat_prefix(config, evlist, prefix, ts);
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
index 901265127e36..c5851ceb4c6b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -9,6 +9,7 @@
 #include "expr.h"
 #include "metricgroup.h"
 #include <linux/zalloc.h>
+#include "iiostat.h"
 
 /*
  * AGGR_GLOBAL: Use CPU 0
@@ -919,6 +920,12 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 	return ratio;
 }
 
+__weak void iiostat_print_metric(struct perf_stat_config *config __maybe_unused,
+				  struct evsel *evsel __maybe_unused,
+				  struct perf_stat_output_ctx *out __maybe_unused)
+{
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int cpu,
@@ -934,7 +941,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	struct metric_event *me;
 	int num = 1;
 
-	if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
+	if (config->iiostat_run) {
+		iiostat_print_metric(config, evsel, out);
+	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 		if (total) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index d053ebd44ae3..a072dfe3dbbf 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -118,6 +118,7 @@ struct perf_stat_config {
 	bool			 walltime_run_table;
 	bool			 all_kernel;
 	bool			 all_user;
+	bool			 iiostat_run;
 	bool			 percore_show_thread;
 	bool			 summary;
 	bool			 metric_no_group;
-- 
2.19.1

