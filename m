Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A526C861
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIPSre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:47:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727957AbgIPSrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:47:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 773A81CA08F761B2D03B;
        Wed, 16 Sep 2020 18:50:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 18:50:01 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <acme@kernel.org>, <ak@linux.intel.com>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH V2 RESEND] perf stat: Fix the ratio comments of miss-events
Date:   Wed, 16 Sep 2020 18:48:51 +0800
Message-ID: <1600253331-10535-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
iTLB cache and LL-cache. Take L1-dcache for example, miss ratio is
caculated as "L1-dcache-load-misses/L1-dcache-loads". So
"of all L1-dcache hits" is unsuitable to describe it, and
"of all L1-dcache accesses" seems better.

The comments of L1-icache, dTLB cache, iTLB cache and LL-cache are
fixed in the same way.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-shadow.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e1ba6c1..ee3c404 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -517,7 +517,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);

-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache accesses", ratio);
 }

 static void print_l1_icache_misses(struct perf_stat_config *config,
@@ -538,7 +538,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache accesses", ratio);
 }

 static void print_dtlb_cache_misses(struct perf_stat_config *config,
@@ -558,7 +558,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache accesses", ratio);
 }

 static void print_itlb_cache_misses(struct perf_stat_config *config,
@@ -578,7 +578,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache accesses", ratio);
 }

 static void print_ll_cache_misses(struct perf_stat_config *config,
@@ -598,7 +598,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache accesses", ratio);
 }

 /*
@@ -918,7 +918,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
 			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
@@ -928,7 +928,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
 			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
@@ -938,7 +938,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
 			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
@@ -948,7 +948,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
 			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
@@ -958,7 +958,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
 			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
 		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);

--
2.8.1

