Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555F92FEC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbhAUNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:48:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:10335 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbhAUNmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:42:02 -0500
IronPort-SDR: BDm+hvbQgVKFxBYwHKtbH66F0Fl2mMQlNEXLgmm0hPVetd37mxDFo2ElkMUIwTU2tHmFKkJ4sI
 uQobqGackTFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243341809"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="243341809"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 05:40:10 -0800
IronPort-SDR: phT0VKuq/+640+SUC7LCxEkEeWs1yTpNk+7GPpDif1e69nfdwxk6DOjK+xpwOUxS5cR3MMFLhA
 pXVnmS24hH0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="407277622"
Received: from ssp-iclu-cdi187.jf.intel.com ([10.54.55.67])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2021 05:40:09 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf stat: Add Topdown metrics events as default events
Date:   Thu, 21 Jan 2021 05:37:52 -0800
Message-Id: <20210121133752.118327-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Topdown Microarchitecture Analysis (TMA) Method is a structured
analysis methodology to identify critical performance bottlenecks in
out-of-order processors. From the Ice Lake and later platforms, the
Topdown information can be retrieved from the dedicated "metrics"
register, which isn't impacted by other events. Also, the Topdown
metrics support both per thread/process and per core measuring.
Adding Topdown metrics events as default events can enrich the default
measuring information, and would not cost any extra multiplexing.

Introduce arch_evlist__add_default_attrs() to allow architecture
specific default events. Add the Topdown metrics events in the X86
specific arch_evlist__add_default_attrs(). Other architectures can
add their own default events later separately.

With the patch,

 $perf stat sleep 1

 Performance counter stats for 'sleep 1':

           0.82 msec task-clock:u              #    0.001 CPUs utilized
              0      context-switches:u        #    0.000 K/sec
              0      cpu-migrations:u          #    0.000 K/sec
             61      page-faults:u             #    0.074 M/sec
        319,941      cycles:u                  #    0.388 GHz
        242,802      instructions:u            #    0.76  insn per cycle
         54,380      branches:u                #   66.028 M/sec
          4,043      branch-misses:u           #    7.43% of all branches
      1,585,555      slots:u                   # 1925.189 M/sec
        238,941      topdown-retiring:u        #     15.0% retiring
        410,378      topdown-bad-spec:u        #     25.8% bad speculation
        634,222      topdown-fe-bound:u        #     39.9% frontend bound
        304,675      topdown-be-bound:u        #     19.2% backend bound

       1.001791625 seconds time elapsed

       0.000000000 seconds user
       0.001572000 seconds sys

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/Build    |  1 +
 tools/perf/arch/x86/util/evlist.c | 15 +++++++++++++++
 tools/perf/builtin-stat.c         |  3 +++
 tools/perf/util/evlist.c          |  5 +++++
 tools/perf/util/evlist.h          |  2 ++
 5 files changed, 26 insertions(+)
 create mode 100644 tools/perf/arch/x86/util/evlist.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 347c39b960eb..ce1ec92fecdc 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += topdown.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += evlist.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
new file mode 100644
index 000000000000..8c6732cc7794
--- /dev/null
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include "util/pmu.h"
+#include "util/evlist.h"
+#include "util/parse-events.h"
+
+#define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
+
+int arch_evlist__add_default_attrs(struct evlist *evlist)
+{
+	if (!pmu_have_event("cpu", "slots"))
+		return 0;
+
+	return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
+}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c054b8d4677..abcdabaf1701 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1827,6 +1827,9 @@ static int add_default_attributes(void)
 		}
 		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
 			return -1;
+
+		if (arch_evlist__add_default_attrs(evsel_list) < 0)
+			return -1;
 	}
 
 	/* Detailed events get appended to the event list: */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05363a7247c4..b38589d8c027 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -303,6 +303,11 @@ int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *a
 	return evlist__add_attrs(evlist, attrs, nr_attrs);
 }
 
+__weak int arch_evlist__add_default_attrs(struct evlist *evlist __maybe_unused)
+{
+	return 0;
+}
+
 struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1aae75895dea..9eba4958a1e9 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -110,6 +110,8 @@ int __evlist__add_default_attrs(struct evlist *evlist,
 #define evlist__add_default_attrs(evlist, array) \
 	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
+int arch_evlist__add_default_attrs(struct evlist *evlist);
+
 int evlist__add_dummy(struct evlist *evlist);
 
 int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
-- 
2.25.1

