Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739912FF197
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbhAURRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:17:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2391 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388382AbhAURQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:16:09 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DM88G1Gjfz67fT6;
        Fri, 22 Jan 2021 01:12:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:15:25 +0100
Received: from [10.210.167.120] (10.210.167.120) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 17:15:23 +0000
Subject: Re: [PATCH] perf metricgroup: Fix for metrics containing
 duration_time
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
References: <1611159518-226883-1-git-send-email-john.garry@huawei.com>
 <CAP-5=fVr0pFpqpev0DW6MMYB1VouH4rL0_wY3_OsbQLS=deJag@mail.gmail.com>
 <26a9e447-b2ef-c459-ebf1-9992ee5c5cd0@huawei.com>
 <CAP-5=fX3C8v02ZbXPGWs1eKrbO5YAddegJuig2B755=Ubd1w1Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4f8d8e1f-c37b-5ba4-7fe4-b46398cf6578@huawei.com>
Date:   Thu, 21 Jan 2021 17:14:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fX3C8v02ZbXPGWs1eKrbO5YAddegJuig2B755=Ubd1w1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.120]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>      >
>      >
>      > Thanks for this, it should be fairly easy to add a test. Could we
>     do this?
> 
>     I don't mind following up with that.

How about this:

---- >8 ----

 From 38e9d5aa07588d552378d97760b6b79f19d59bbd Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Thu, 21 Jan 2021 16:55:17 +0000
Subject: [PATCH] perf test: Add parse-metric memory bandwidth testcase

Event duration_time in a metric expression requires special handling.

Improve test coverage by including a metric whose expression includes
duration_time. The actual metric is copied from the L1D_Cache_Fill_BW
metric on my broadwell machine.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/tests/parse-metric.c 
b/tools/perf/tests/parse-metric.c
index ce7be37f0d88..98b9570c6194 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -11,6 +11,7 @@
  #include "debug.h"
  #include "expr.h"
  #include "stat.h"
+#include <math.h>

  static struct pmu_event pme_test[] = {
  {
@@ -69,6 +70,10 @@ static struct pmu_event pme_test[] = {
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
@@ -107,6 +112,8 @@ static void load_runtime_stat(struct runtime_stat 
*st, struct evlist *evlist,
  	evlist__for_each_entry(evlist, evsel) {
  		count = find_value(evsel->name, vals);
  		perf_stat__update_shadow_stats(evsel, count, 0, st);
+		if (!strcmp(evsel->name, "duration_time"))
+			update_stats(&walltime_nsecs_stats, count);
  	}
  }

@@ -321,6 +328,24 @@ static int test_recursion_fail(void)
  	return 0;
  }

+static int test_memory_bandwidth(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "l1d.replacement", .val = 304334545 },
+		{ .event = "duration_time",  .val = 1001057587 },
+		{ .event = NULL, },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("L1D_Cache_Fill_BW", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("L1D_Cache_Fill_BW, wrong ratio",
+			fabs(ratio - 19.45) < 0.01);
+
+	return 0;
+}
+
  static int test_metric_group(void)
  {
  	double ratio1, ratio2;
@@ -353,5 +378,6 @@ int test__parse_metric(struct test *test 
__maybe_unused, int subtest __maybe_unu
  	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
  	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
  	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
+	TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
  	return 0;
  }
-- 
2.26.2

Cheers,
John
