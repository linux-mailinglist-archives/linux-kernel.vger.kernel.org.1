Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE11FC914
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 10:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFQImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 04:42:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:41178 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFQImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:42:19 -0400
IronPort-SDR: caG6HPTLXi2+qer1q2221r1UP9uLFdzKvyMUTvqcu9Q8kB9eRJNfxF+a/2SQyu9GHa0gEpd8rK
 B0NC2C35ywbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:42:18 -0700
IronPort-SDR: HqtkOXXxfARW5VNTB+CfbUCqgLEsAWxV0I8YeKzLoPIG0FzWYi8KpGFIk7HjWWwDo8dcw31rn7
 XHPUIsnlUhLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="277208314"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 01:42:18 -0700
Received: from [10.249.225.191] (abudanko-mobl.ccr.corp.intel.com [10.249.225.191])
        by linux.intel.com (Postfix) with ESMTP id E8B81580223;
        Wed, 17 Jun 2020 01:42:15 -0700 (PDT)
Subject: [PATCH v8 10/13] perf stat: introduce --control fd:ctl-fd[,ack-fd]
 options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Organization: Intel Corp.
Message-ID: <38b206d9-0038-be6f-66bb-eecbf82016e6@linux.intel.com>
Date:   Wed, 17 Jun 2020 11:42:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --control fd:ctl-fd[,ack-fd] options to pass open file
descriptors numbers from command line. Extend perf-stat.txt file
with --control fd:ctl-fd[,ack-fd] options description. Document
possible usage model introduced by --control fd:ctl-fd[,ack-fd]
options by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 39 ++++++++++++++++++++++++++
 tools/perf/builtin-stat.c              | 38 +++++++++++++++++++++++++
 tools/perf/util/stat.h                 |  2 ++
 3 files changed, 79 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9f32f6cd558d..c9bfefc051fb 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,6 +176,45 @@ with it.  --append may be used here.  Examples:
      3>results  perf stat --log-fd 3          -- $cmd
      3>>results perf stat --log-fd 3 --append -- $cmd
 
+--control fd:ctl-fd[,ack-fd]
+Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
+'disable': disable events). Measurements can be started with events disabled using
+--delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
+to synchronize with the controlling process. Example of bash shell script to enable and
+disable events during measurements:
+
+#!/bin/bash
+
+ctl_dir=/tmp/
+
+ctl_fifo=${ctl_dir}perf_ctl.fifo
+test -p ${ctl_fifo} && unlink ${ctl_fifo}
+mkfifo ${ctl_fifo}
+exec {ctl_fd}<>${ctl_fifo}
+
+ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
+test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
+mkfifo ${ctl_ack_fifo}
+exec {ctl_fd_ack}<>${ctl_ack_fifo}
+
+perf stat -D -1 -e cpu-cycles -a -I 1000       \
+          --control fd:${ctl_fd},${ctl_fd_ack} \
+          -- sleep 30 &
+perf_pid=$!
+
+sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
+sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
+
+exec {ctl_fd_ack}>&-
+unlink ${ctl_ack_fifo}
+
+exec {ctl_fd}>&-
+unlink ${ctl_fifo}
+
+wait -n ${perf_pid}
+exit $?
+
+
 --pre::
 --post::
 	Pre and post measurement hooks, e.g.:
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cc56d71a3ed5..4cb29b40b860 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -188,6 +188,8 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -1032,6 +1034,33 @@ static int parse_metric_groups(const struct option *opt,
 					 &stat_config.metric_events);
 }
 
+static int parse_control_option(const struct option *opt,
+				const char *str,
+				int unset __maybe_unused)
+{
+	char *comma = NULL, *endptr = NULL;
+	struct perf_stat_config *config = (struct perf_stat_config *)opt->value;
+
+	if (strncmp(str, "fd:", 3))
+		return -EINVAL;
+
+	config->ctl_fd = strtoul(&str[3], &endptr, 0);
+	if (endptr == &str[3])
+		return -EINVAL;
+
+	comma = strchr(str, ',');
+	if (comma) {
+		if (endptr != comma)
+			return -EINVAL;
+
+		config->ctl_fd_ack = strtoul(comma + 1, &endptr, 0);
+		if (endptr == comma + 1 || *endptr != '\0')
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1133,6 +1162,10 @@ static struct option stat_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
+	OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd]",
+		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
+		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.",
+		      parse_control_option),
 	OPT_END()
 };
 
@@ -2304,6 +2337,9 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGALRM, skip_signal);
 	signal(SIGABRT, skip_signal);
 
+	if (evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack))
+		goto out;
+
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
@@ -2323,6 +2359,8 @@ int cmd_stat(int argc, const char **argv)
 	if (!forever && status != -1 && (!interval || stat_config.summary))
 		print_counters(NULL, argc, argv);
 
+	evlist__finalize_ctlfd(evsel_list);
+
 	if (STAT_RECORD) {
 		/*
 		 * We synthesize the kernel mmap record just so that older tools
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 626421ef35c2..06f0baabe775 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -133,6 +133,8 @@ struct perf_stat_config {
 	struct perf_cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	int			 ctl_fd;
+	int			 ctl_fd_ack;
 };
 
 void perf_stat__set_big_num(int set);
-- 
2.24.1


