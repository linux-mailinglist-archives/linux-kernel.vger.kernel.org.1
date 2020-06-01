Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80711EB015
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgFAUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 16:18:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:29683 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgFAUSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:18:05 -0400
IronPort-SDR: za8B4K5qo962Sl5ac4BOz3Bvub98FGjX6XNyVlOuunpsfumFJiJd95q56uSPhhhkrh5GqC7UHN
 K4epFpCoGtKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 13:18:04 -0700
IronPort-SDR: R2AYj3SccqpOo7YigFgjni9lNXpfOVn5BTssjIdk1GKqYL3M3MRml7uEAwa8uEfH2rozK6j3Ou
 oJdx217LgHBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="303752754"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2020 13:18:04 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id B87DA58002E;
        Mon,  1 Jun 2020 13:18:01 -0700 (PDT)
Subject: [PATCH v6 10/13] perf stat: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2fba84d0-3448-a318-43d7-e2fbb8ccde11@linux.intel.com>
Date:   Mon, 1 Jun 2020 23:17:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
from command line. Extend perf-stat.txt file with --ctl-fd[-ack] options
description. Document possible usage model introduced by --ctl-fd[-ack]
options by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 40 ++++++++++++++++++++++++++
 tools/perf/builtin-stat.c              | 11 +++++++
 tools/perf/util/stat.h                 |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9f32f6cd558d..c4a5d31062ef 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,6 +176,46 @@ with it.  --append may be used here.  Examples:
      3>results  perf stat --log-fd 3          -- $cmd
      3>>results perf stat --log-fd 3 --append -- $cmd
 
+--ctl-fd::
+--ctl-fd-ack::
+
+Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
+'disable': disable events). Optionally send control command completion ('ack') to fd-ack
+descriptor to synchronize with the controlling process. Example of bash shell script
+to enable and disable events during measurements:
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
+perf stat -D -1 -e cpu-cycles -a -I 1000                \
+          --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
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
index 4a197b5eee23..a878e106ead0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -188,6 +188,8 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1
 };
 
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
@@ -1080,6 +1082,10 @@ static struct option stat_options[] = {
 		"libpfm4 event selector. use 'perf list' to list available events",
 		parse_libpfm_events_option),
 #endif
+	OPT_INTEGER(0, "ctl-fd", &stat_config.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &stat_config.ctl_fd_ack,
+		    "Send control command completion ('ack') to fd ack descriptor"),
 	OPT_END()
 };
 
@@ -2249,6 +2255,9 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGALRM, skip_signal);
 	signal(SIGABRT, skip_signal);
 
+	if (evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack))
+		goto out;
+
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
@@ -2268,6 +2277,8 @@ int cmd_stat(int argc, const char **argv)
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

