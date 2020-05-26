Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0C1CA89F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 12:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHKvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 06:51:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:50075 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEHKvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:51:52 -0400
IronPort-SDR: Q+U4Aw9qWIt1TAN4be0c+yHLt8iCRqFjM5Of5X+BP4rhKvL9BubZXjQjT6KoZPVuOwqoHOP4oy
 6y81uK0vefpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:51:51 -0700
IronPort-SDR: ddCjPLqKGeiWg57rKJV35iHC4of3juabETYh2G83YQ9VZjpuDCPvZA4dDHbpJQbDFlDhhY3j0o
 g6+e1Tu0/f5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="264267373"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 03:51:51 -0700
Received: from [10.249.224.104] (abudanko-mobl.ccr.corp.intel.com [10.249.224.104])
        by linux.intel.com (Postfix) with ESMTP id DBDC25805B4;
        Fri,  8 May 2020 03:51:49 -0700 (PDT)
Subject: [PATCH v3 6/9] perf stat: introduce --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
Organization: Intel Corp.
Message-ID: <18cebbec-088e-b000-c556-5ecf99414f04@linux.intel.com>
Date:   Fri, 8 May 2020 13:51:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
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
 tools/perf/builtin-stat.c              | 10 +++++++
 tools/perf/util/stat.h                 |  2 ++
 3 files changed, 52 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3b91b30d7672..7f7a0019fbfc 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -164,6 +164,46 @@ with it.  --append may be used here.  Examples:
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
index abea82a1ba24..88055aaf670f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -187,6 +187,8 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1
 };
 
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
@@ -984,6 +986,10 @@ static struct option stat_options[] = {
 		    "Use with 'percore' event qualifier to show the event "
 		    "counts of one hardware thread by sum up total hardware "
 		    "threads of same physical core"),
+	OPT_INTEGER(0, "ctl-fd", &stat_config.ctl_fd,
+		    "Listen on fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events)"),
+	OPT_INTEGER(0, "ctl-fd-ack", &stat_config.ctl_fd_ack,
+		    "Send control command completion ('ack') to fd ack descriptor"),
 	OPT_END()
 };
 
@@ -2180,6 +2186,8 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGALRM, skip_signal);
 	signal(SIGABRT, skip_signal);
 
+	evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack);
+
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
@@ -2199,6 +2207,8 @@ int cmd_stat(int argc, const char **argv)
 	if (!forever && status != -1 && !interval)
 		print_counters(NULL, argc, argv);
 
+	evlist__finalize_ctlfd(evsel_list);
+
 	if (STAT_RECORD) {
 		/*
 		 * We synthesize the kernel mmap record just so that older tools
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 027b9dcd902f..0b0fa3a2cde2 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -130,6 +130,8 @@ struct perf_stat_config {
 	struct perf_cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	int			 ctl_fd;
+	int			 ctl_fd_ack;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.24.1


