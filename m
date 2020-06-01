Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672F61EA76D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFAP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:58:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:57197 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFAP6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:58:25 -0400
IronPort-SDR: nKnL9GXgNdV7y1eR79tXKRO4yaLnrkVrYkmDWmke23NxWzkpwXo3N6yMK/gGonyo/BMl8c272k
 XrQ4rZdPwBgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 08:58:24 -0700
IronPort-SDR: MjXikgx+FgiPhATo4dDoBGA/8PaAOvSGuW8QPX9BBFThLnLJb83rY9OTd8ZMdHdz0hatxNby7j
 n0yb0XyI8yrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="347081992"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2020 08:58:24 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 81706580646;
        Mon,  1 Jun 2020 08:58:22 -0700 (PDT)
Subject: [PATCH v5 08/13] perf stat: extend -D,--delay option with -1 value
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9a0ef5c9-e66c-bd64-5f9d-ef3d4a135e66@linux.intel.com>
Date:   Mon, 1 Jun 2020 18:58:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend -D,--delay option with -1 value to start monitoring with
events disabled to be enabled later by enable command provided
via control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++--
 tools/perf/builtin-stat.c              | 18 ++++++++++++++----
 tools/perf/util/evlist.h               |  3 +++
 tools/perf/util/stat.h                 |  2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b029ee728a0b..9f32f6cd558d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -238,8 +238,9 @@ mode, use --per-node in addition to -a. (system-wide).
 
 -D msecs::
 --delay msecs::
-After starting the program, wait msecs before measuring. This is useful to
-filter out the startup phase of the program, which is often very different.
+After starting the program, wait msecs before measuring (-1: start with events
+disabled). This is useful to filter out the startup phase of the program,
+which is often very different.
 
 -T::
 --transaction::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8eeaf92912d8..d0ddaa5fac96 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -441,16 +441,26 @@ static bool process_timeout(bool timeout, unsigned int interval, int *times)
 
 static void enable_counters(void)
 {
-	if (stat_config.initial_delay)
+	if (stat_config.initial_delay < 0) {
+		pr_info(EVLIST_DISABLED_MSG);
+		return;
+	}
+
+	if (stat_config.initial_delay > 0) {
+		pr_info(EVLIST_DISABLED_MSG);
 		usleep(stat_config.initial_delay * USEC_PER_MSEC);
+	}
 
 	/*
 	 * We need to enable counters only if:
 	 * - we don't have tracee (attaching to task or cpu)
 	 * - we have initial delay configured
 	 */
-	if (!target__none(&target) || stat_config.initial_delay)
+	if (!target__none(&target) || stat_config.initial_delay) {
 		evlist__enable(evsel_list);
+		if (stat_config.initial_delay > 0)
+			pr_info(EVLIST_ENABLED_MSG);
+	}
 }
 
 static void disable_counters(void)
@@ -1007,8 +1017,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per thread", AGGR_THREAD),
 	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
 		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
-		     "ms to wait before starting measurement after program start"),
+	OPT_INTEGER('D', "delay", &stat_config.initial_delay,
+		    "ms to wait before starting measurement after program start (-1: start with events disabled)"),
 	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
 			"Only print computed metrics. No raw values", enable_metric_only),
 	OPT_BOOLEAN(0, "metric-no-group", &stat_config.metric_no_group,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bccf0a970371..7c3726a685f5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -377,4 +377,7 @@ int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 
+#define EVLIST_ENABLED_MSG "Events enabled\n"
+#define EVLIST_DISABLED_MSG "Events disabled\n"
+
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f75ae679eb28..626421ef35c2 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -116,7 +116,7 @@ struct perf_stat_config {
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-	unsigned int		 initial_delay;
+	int			 initial_delay;
 	unsigned int		 unit_width;
 	unsigned int		 metric_only_len;
 	int			 times;
-- 
2.24.1

