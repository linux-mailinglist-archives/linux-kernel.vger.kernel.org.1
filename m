Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF626EA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRBai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:30:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgIRBai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:30:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B80F0FF0C86E8A2A2705;
        Fri, 18 Sep 2020 09:30:35 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:30:26 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>
Subject: [PATCH v2] perf metric: Code cleanup with map_for_each_event()
Date:   Fri, 18 Sep 2020 09:29:48 +0800
Message-ID: <20200918012948.2798-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have introduced map_for_each_event() to walk the 'pmu_events_map',
clean up metricgroup__print() and metricgroup__has_metric() with it.

Signed-off-by: Wei Li <liwei391@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
v1 -> v2:
 - Move map_for_each_metric() after match_metric() to avoid potential
   use-before-declare.
---
 tools/perf/util/metricgroup.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..50ee36437b99 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -374,6 +374,17 @@ static bool match_metric(const char *n, const char *list)
 	return false;
 }
 
+#define map_for_each_event(__pe, __idx, __map)				\
+	for (__idx = 0, __pe = &__map->table[__idx];			\
+	     __pe->name || __pe->metric_group || __pe->metric_name;	\
+	     __pe = &__map->table[++__idx])
+
+#define map_for_each_metric(__pe, __idx, __map, __metric)		\
+	map_for_each_event(__pe, __idx, __map)				\
+		if (__pe->metric_expr &&				\
+		    (match_metric(__pe->metric_group, __metric) ||	\
+		     match_metric(__pe->metric_name, __metric)))
+
 struct mep {
 	struct rb_node nd;
 	const char *name;
@@ -475,12 +486,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
-	for (i = 0; ; i++) {
+	map_for_each_event(pe, i, map) {
 		const char *g;
-		pe = &map->table[i];
 
-		if (!pe->name && !pe->metric_group && !pe->metric_name)
-			break;
 		if (!pe->metric_expr)
 			continue;
 		g = pe->metric_group;
@@ -745,17 +753,6 @@ static int __add_metric(struct list_head *metric_list,
 	return 0;
 }
 
-#define map_for_each_event(__pe, __idx, __map)				\
-	for (__idx = 0, __pe = &__map->table[__idx];			\
-	     __pe->name || __pe->metric_group || __pe->metric_name;	\
-	     __pe = &__map->table[++__idx])
-
-#define map_for_each_metric(__pe, __idx, __map, __metric)		\
-	map_for_each_event(__pe, __idx, __map)				\
-		if (__pe->metric_expr &&				\
-		    (match_metric(__pe->metric_group, __metric) ||	\
-		     match_metric(__pe->metric_name, __metric)))
-
 static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
 {
 	struct pmu_event *pe;
@@ -1092,11 +1089,7 @@ bool metricgroup__has_metric(const char *metric)
 	if (!map)
 		return false;
 
-	for (i = 0; ; i++) {
-		pe = &map->table[i];
-
-		if (!pe->name && !pe->metric_group && !pe->metric_name)
-			break;
+	map_for_each_event(pe, i, map) {
 		if (!pe->metric_expr)
 			continue;
 		if (match_metric(pe->metric_name, metric))
-- 
2.17.1

