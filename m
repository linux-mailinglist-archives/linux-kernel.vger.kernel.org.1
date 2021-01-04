Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67BE2E8F67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 03:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbhADCVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 21:21:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:44472 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbhADCVf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 21:21:35 -0500
IronPort-SDR: k1plfpJwNzWU4ZNzzs6oL2EAtBbHeKujvmdr8ZQI1Re6IpxKTJB8jcnH6d9LmTT0CQAgQoZDbH
 LAmuEzA4zMcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="164606408"
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="164606408"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 18:19:49 -0800
IronPort-SDR: DKOgNdj9NVI6OnSLf5n/e2xLntJZbSdMUSt9fIdzKVwh7Oc58gUeA9FqzapR0MtXuUC7g6JnwP
 uMCU+LY99ivQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="461783425"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2021 18:19:46 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf stat: Append to default list if use -e +event
Date:   Mon,  4 Jan 2021 10:18:37 +0800
Message-Id: <20210104021837.30473-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default event list includes the most common events which are widely
used by users. But with -e option, the current perf only counts the events
assigned by -e option. Users may want to collect some extra events with
the default list. For this case, users have to manually add all the events
from the default list. It's inconvenient. Also, users may don't know how to
get the default list.

Now it supports a simple syntax: -e +event

The prefix '+' tells perf to append this event (or event list) to default
event list.

Before:

root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1

 Performance counter stats for 'system wide':

              2.04 Joules power/energy-pkg/

       1.000863884 seconds time elapsed

After:

root@kbl-ppc:~# ./perf stat -e +power/energy-pkg/ -a -- sleep 1

 Performance counter stats for 'system wide':

              2.11 Joules +power/energy-pkg/        #    0.000 K/sec
          8,007.17 msec   cpu-clock                 #    7.993 CPUs utilized
               125        context-switches          #    0.016 K/sec
                 8        cpu-migrations            #    0.001 K/sec
                 2        page-faults               #    0.000 K/sec
         8,520,084        cycles                    #    0.001 GHz
         2,808,302        instructions              #    0.33  insn per cycle
           555,427        branches                  #    0.069 M/sec
            59,005        branch-misses             #   10.62% of all branches

       1.001832003 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v2:
   We just use a simple syntax: -e +event to append the -e event
   to default list.

 v1: 
   Create a new option '--add-default' to append -e event to
   default list.

 tools/perf/Documentation/perf-stat.txt |  1 +
 tools/perf/builtin-stat.c              |  3 ++-
 tools/perf/util/evlist.c               | 10 ++++++++++
 tools/perf/util/evlist.h               |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5d4a673d7621..f60af902b8e1 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -63,6 +63,7 @@ report::
 	Multiple PMU instances are typical for uncore PMUs, so the prefix
 	'uncore_' is also ignored when performing this match.
 
+	If the prefix '+' is used, the event is appended to default event list.
 
 -i::
 --no-inherit::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8cc24967bc27..8400953473ef 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1763,7 +1763,8 @@ static int add_default_attributes(void)
 		free(str);
 	}
 
-	if (!evsel_list->core.nr_entries) {
+	if (!evsel_list->core.nr_entries ||
+	    evlist__append_default_list(evsel_list)) {
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05363a7247c4..fceef4e57964 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2010,3 +2010,13 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	}
 	return NULL;
 }
+
+bool evlist__append_default_list(struct evlist *evlist)
+{
+	struct evsel *first = evlist__first(evlist);
+
+	if (first->name && first->name[0] == '+')
+		return true;
+
+	return false;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1aae75895dea..54592bd22bc2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -353,4 +353,5 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
+bool evlist__append_default_list(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.17.1

