Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27982E03B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgLVBOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:14:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:54243 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLVBOj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:14:39 -0500
IronPort-SDR: udrqtVEqTgTB36cycWahhkaW3gZWwLaWKJRFzdCOJuW0txnlCEheYfjVL67jzoyLtTL6p2ZWA1
 cazhDb7UDIaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="172294901"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="172294901"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 17:12:53 -0800
IronPort-SDR: 5NerGmi6vRw0ccm/IvvxcyqIcwStvzpcwYQXA/uBsGAHMe0NFzIG/zCYag13p563XhDyiZeIfb
 7bOQ8+qZh/9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="389575797"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 21 Dec 2020 17:12:51 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Create '--add-default' option to append default list
Date:   Tue, 22 Dec 2020 09:11:31 +0800
Message-Id: <20201222011131.12326-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event default list includes the most common events which are widely
used by users. But with -e option, the current perf only counts the events
assigned by -e option. Users may want to collect some extra events with
the default list. For this case, users have to manually add all the events
from the default list. It's inconvenient. Also, users may don't know how to
get the default list.

It's better to add a new option to append default list to the -e events.
The new option is '--add-default'.

Before:

root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1

 Performance counter stats for 'system wide':

              2.05 Joules power/energy-pkg/

       1.000857974 seconds time elapsed

After:

root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a --add-default -- sleep 1

 Performance counter stats for 'system wide':

              2.10 Joules power/energy-pkg/         #    0.000 K/sec
          8,009.89 msec   cpu-clock                 #    7.995 CPUs utilized
               140        context-switches          #    0.017 K/sec
                 9        cpu-migrations            #    0.001 K/sec
                66        page-faults               #    0.008 K/sec
        10,671,929        cycles                    #    0.001 GHz
         4,736,880        instructions              #    0.44  insn per cycle
           942,951        branches                  #    0.118 M/sec
            76,096        branch-misses             #    8.07% of all branches

       1.001809960 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 5 +++++
 tools/perf/builtin-stat.c              | 4 +++-
 tools/perf/util/stat.h                 | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5d4a673d7621..75a83c2e4dc5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -438,6 +438,11 @@ convenient for post processing.
 --summary::
 Print summary for interval mode (-I).
 
+--add-default::
+The default event list includes the most common events which are widely
+used by users. But with -e option, the perf only counts the events assigned
+by -e option. This options appends the default event list to the -e events.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 89c32692f40c..6ac7b946f9a7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1173,6 +1173,8 @@ static struct option stat_options[] = {
 		       "print summary for interval mode"),
 	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
 			"don't print output (useful with record)"),
+	OPT_BOOLEAN(0, "add-default", &stat_config.add_default,
+		       "add default events"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
@@ -1755,7 +1757,7 @@ static int add_default_attributes(void)
 		free(str);
 	}
 
-	if (!evsel_list->core.nr_entries) {
+	if (!evsel_list->core.nr_entries || stat_config.add_default) {
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 9979b4b100f2..6ccc6936348c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -123,6 +123,7 @@ struct perf_stat_config {
 	bool			 metric_no_merge;
 	bool			 stop_read_counter;
 	bool			 quiet;
+	bool			 add_default;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

