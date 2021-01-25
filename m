Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223EC303646
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbhAZGIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:08:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11492 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbhAYMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:52:52 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPV8k4bwpzjD7W;
        Mon, 25 Jan 2021 20:50:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 20:51:49 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] perf test: Add parse-metric memory bandwidth testcase
Date:   Mon, 25 Jan 2021 20:47:22 +0800
Message-ID: <1611578842-5749-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event duration_time in a metric expression requires special handling.

Improve test coverage by including a metric whose expression includes
duration_time. The actual metric is a copied from the L1D_Cache_Fill_BW
metric on my broadwell machine.

Signed-off-by: John Garry <john.garry@huawei.com>
---
Based on acme perf/core + "perf metricgroup: Fix for metrics containing duration_time"

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index ce7be37f0d88..6dc1db1626ad 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -69,6 +69,10 @@ static struct pmu_event pme_test[] = {
 	.metric_expr	= "1/m3",
 	.metric_name	= "M3",
 },
+{
+	.metric_expr	= "64 * l1d.replacement / 1000000000 / duration_time",
+	.metric_name	= "L1D_Cache_Fill_BW",
+},
 {
 	.name	= NULL,
 }
@@ -107,6 +111,8 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
 	evlist__for_each_entry(evlist, evsel) {
 		count = find_value(evsel->name, vals);
 		perf_stat__update_shadow_stats(evsel, count, 0, st);
+		if (!strcmp(evsel->name, "duration_time"))
+			update_stats(&walltime_nsecs_stats, count);
 	}
 }
 
@@ -321,6 +327,23 @@ static int test_recursion_fail(void)
 	return 0;
 }
 
+static int test_memory_bandwidth(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "l1d.replacement", .val = 4000000 },
+		{ .event = "duration_time",  .val = 200000000 },
+		{ .event = NULL, },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("L1D_Cache_Fill_BW", vals, &ratio) == 0);
+	TEST_ASSERT_VAL("L1D_Cache_Fill_BW, wrong ratio",
+			1.28 == ratio);
+
+	return 0;
+}
+
 static int test_metric_group(void)
 {
 	double ratio1, ratio2;
@@ -353,5 +376,6 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
 	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
 	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
+	TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
 	return 0;
 }
-- 
2.26.2

