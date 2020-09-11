Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C62665F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgIKRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:19:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:44440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgIKO6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 10:58:23 -0400
IronPort-SDR: LyGOcE3YzmBnIk6X2TrhBHaiV/vCjv/AODn0BsRwmESYUdyvpf5zbumODtPfu2u4Yeca//QMQF
 z1XQL+8eT/YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="158802542"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="158802542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 07:51:38 -0700
IronPort-SDR: PLOnmFPXcPsvKi8O2i7Svm0n3Stm/QFrCQXgH9dhvD4YDRogWahxh2O6nLbzvmLDSxgGVisjmI
 ZQyHpe/fCtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="300951420"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2020 07:51:38 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/4] perf record: Support sample-read topdown metric group
Date:   Fri, 11 Sep 2020 07:48:06 -0700
Message-Id: <20200911144808.27603-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911144808.27603-1-kan.liang@linux.intel.com>
References: <20200911144808.27603-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the hardware TopDown metrics feature, sample-read feature should be
supported for a topdown group, e.g., sample a non-topdown event and read
a topdown metric group. But the current perf record code errors out.

For a topdown metric group, the slots event must be the leader of the
group, but the leader slots event doesn't support sampling.

To support sample-read the topdown metric group, use the 2nd event of
the group as the "leader" for the purposes of sampling.

Only the platform with Topdown metic feature supports sample-read the
topdown group. Add arch_topdown_sample_read() to indicate whether the
topdown group supports sample-read.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/topdown.c | 35 ++++++++++++++++++++++++++++++
 tools/perf/util/record.c           |  3 ++-
 tools/perf/util/topdown.c          |  5 +++++
 tools/perf/util/topdown.h          |  2 ++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 597e963fb3e7..2f3d96aa92a5 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include "api/fs/fs.h"
+#include "util/pmu.h"
 #include "util/topdown.h"
 
 /*
@@ -26,3 +27,37 @@ void arch_topdown_group_warn(void)
 		"nmi_watchdog enabled with topdown. May give wrong results.\n"
 		"Disable with echo 0 > /proc/sys/kernel/nmi_watchdog\n");
 }
+
+#define TOPDOWN_SLOTS		0x0400
+
+static bool is_topdown_slots_event(struct evsel *counter)
+{
+	if (!counter->pmu_name)
+		return false;
+
+	if (strcmp(counter->pmu_name, "cpu"))
+		return false;
+
+	if (counter->core.attr.config == TOPDOWN_SLOTS)
+		return true;
+
+	return false;
+}
+
+/*
+ * Check whether a topdown group supports sample-read.
+ *
+ * Only Topdown metic supports sample-read. The slots
+ * event must be the leader of the topdown group.
+ */
+
+bool arch_topdown_sample_read(struct evsel *leader)
+{
+	if (!pmu_have_event("cpu", "slots"))
+		return false;
+
+	if (is_topdown_slots_event(leader))
+		return true;
+
+	return false;
+}
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index a4cc11592f6b..a857a13b0544 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -13,6 +13,7 @@
 #include "util/perf_api_probe.h"
 #include "record.h"
 #include "../perf-sys.h"
+#include "topdown.h"
 
 /*
  * evsel__config_leader_sampling() uses special rules for leader sampling.
@@ -23,7 +24,7 @@ static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evl
 {
 	struct evsel *leader = evsel->leader;
 
-	if (evsel__is_aux_event(leader)) {
+	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader)) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->leader == leader && evsel != evsel->leader)
 				return evsel;
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
index a085b3c77c27..1081b20f9891 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -51,3 +51,8 @@ __weak bool arch_topdown_check_group(bool *warn)
 __weak void arch_topdown_group_warn(void)
 {
 }
+
+__weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
+{
+	return false;
+}
diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
index e3d70e95f4f1..2f0d0b887639 100644
--- a/tools/perf/util/topdown.h
+++ b/tools/perf/util/topdown.h
@@ -1,9 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef TOPDOWN_H
 #define TOPDOWN_H 1
+#include "evsel.h"
 
 bool arch_topdown_check_group(bool *warn);
 void arch_topdown_group_warn(void);
+bool arch_topdown_sample_read(struct evsel *leader);
 
 int topdown_filter_events(const char **attr, char **str, bool use_group);
 
-- 
2.17.1

