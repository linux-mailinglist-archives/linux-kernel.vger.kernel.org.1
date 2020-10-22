Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A80295D29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896972AbgJVLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:06:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2896921AbgJVLGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:06:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2C2113F2C3E99FEF65CA;
        Thu, 22 Oct 2020 19:06:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 22 Oct 2020 19:05:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <irogers@google.com>, <yao.jin@linux.intel.com>,
        <yeyunfeng@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 2/2] perf jevents: Add test for arch std events
Date:   Thu, 22 Oct 2020 19:02:27 +0800
Message-ID: <1603364547-197086-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
References: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there was an undetected breakage for std arch event support.

Add support in "PMU events" testcase to detect such breakages.

For this, the "test" arch needs has support added to process std arch
events. And a test event is added for the test, ifself.

Also add a few code comments to help understand the code a bit better.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../perf/pmu-events/arch/test/arch-std-events.json |  8 ++++++++
 .../perf/pmu-events/arch/test/test_cpu/cache.json  |  5 +++++
 tools/perf/pmu-events/jevents.c                    |  4 ++++
 tools/perf/tests/pmu-events.c                      | 14 ++++++++++++++
 4 files changed, 31 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/test/arch-std-events.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/cache.json

diff --git a/tools/perf/pmu-events/arch/test/arch-std-events.json b/tools/perf/pmu-events/arch/test/arch-std-events.json
new file mode 100644
index 000000000000..43f6f729d6ae
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/arch-std-events.json
@@ -0,0 +1,8 @@
+[
+    {
+        "PublicDescription": "Attributable Level 3 cache access, read",
+        "EventCode": "0x40",
+        "EventName": "L3_CACHE_RD",
+        "BriefDescription": "L3 cache access, read"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/cache.json b/tools/perf/pmu-events/arch/test/test_cpu/cache.json
new file mode 100644
index 000000000000..036d0efdb2bb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/cache.json
@@ -0,0 +1,5 @@
+[
+    {
+	 "ArchStdEvent": "L3_CACHE_RD"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 7326c14c4623..72cfa3b5046d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1162,6 +1162,10 @@ int main(int argc, char *argv[])
 
 	sprintf(ldirname, "%s/test", start_dirname);
 
+	rc = nftw(ldirname, preprocess_arch_std_files, maxfds, 0);
+	if (rc)
+		goto err_processing_std_arch_event_dir;
+
 	rc = nftw(ldirname, process_one_file, maxfds, 0);
 	if (rc)
 		goto err_processing_dir;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index d3517a74d95e..ad2b21591275 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -14,8 +14,10 @@
 #include "util/parse-events.h"
 
 struct perf_pmu_test_event {
+	/* used for matching against events from generated pmu-events.c */
 	struct pmu_event event;
 
+	/* used for matching against event aliases */
 	/* extra events for aliases */
 	const char *alias_str;
 
@@ -78,6 +80,17 @@ static struct perf_pmu_test_event test_cpu_events[] = {
 		.alias_str = "umask=0,(null)=0x30d40,event=0x3a",
 		.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 	},
+	{
+		.event = {
+			.name = "l3_cache_rd",
+			.event = "event=0x40",
+			.desc = "L3 cache access, read",
+			.long_desc = "Attributable Level 3 cache access, read",
+			.topic = "cache",
+		},
+		.alias_str = "event=0x40",
+		.alias_long_desc = "Attributable Level 3 cache access, read",
+	},
 	{ /* sentinel */
 		.event = {
 			.name = NULL,
@@ -357,6 +370,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 }
 
 
+/* Test that aliases generated are as expected */
 static int test_aliases(void)
 {
 	struct perf_pmu *pmu = NULL;
-- 
2.26.2

