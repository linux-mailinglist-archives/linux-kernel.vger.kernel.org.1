Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCD287267
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgJHKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729455AbgJHKTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8DC4EFA4D04FC51DDE90;
        Thu,  8 Oct 2020 18:19:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 18:19:01 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <james.clark@arm.com>,
        <linux-imx@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v4 10/13] perf metricgroup: Split up metricgroup__print()
Date:   Thu, 8 Oct 2020 18:15:18 +0800
Message-ID: <1602152121-240367-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To aid supporting system event metric groups, break up the function
metricgroup__print() into a part which iterates metrics and a part which
actually "prints" the metric.

No functional change intended.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 124 +++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 82ba3638f48c..1102391cafeb 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -491,6 +491,72 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 		putchar('\n');
 }
 
+static int metricgroup__print_pmu_event(struct pmu_event *pe,
+                                        bool metricgroups, char *filter,
+                                        bool raw, bool details,
+                                        struct rblist *groups,
+                                        struct strlist *metriclist)
+{
+	const char *g;
+	char *omg, *mg;
+
+	g = pe->metric_group;
+	if (!g && pe->metric_name) {
+		if (pe->name)
+			return 0;
+		g = "No_group";
+	}
+
+	if (!g)
+		return 0;
+
+	mg = strdup(g);
+
+	if (!mg)
+		return -ENOMEM;
+	omg = mg;
+	while ((g = strsep(&mg, ";")) != NULL) {
+		struct mep *me;
+		char *s;
+
+		g = skip_spaces(g);
+		if (*g == 0)
+			g = "No_group";
+		if (filter && !strstr(g, filter))
+			continue;
+		if (raw)
+			s = (char *)pe->metric_name;
+		else {
+			if (asprintf(&s, "%s\n%*s%s]",
+				     pe->metric_name, 8, "[", pe->desc) < 0)
+				return -1;
+			if (details) {
+				if (asprintf(&s, "%s\n%*s%s]",
+					     s, 8, "[", pe->metric_expr) < 0)
+					return -1;
+			}
+		}
+
+		if (!s)
+			continue;
+
+		if (!metricgroups) {
+			strlist__add(metriclist, s);
+		} else {
+			me = mep_lookup(groups, g);
+			if (!me)
+				continue;
+			strlist__add(me->metrics, s);
+		}
+
+		if (!raw)
+			free(s);
+	}
+	free(omg);
+
+	return 0;
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
@@ -515,66 +581,16 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
 	for (i = 0; ; i++) {
-		const char *g;
 		pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
 			break;
 		if (!pe->metric_expr)
 			continue;
-		g = pe->metric_group;
-		if (!g && pe->metric_name) {
-			if (pe->name)
-				continue;
-			g = "No_group";
-		}
-		if (g) {
-			char *omg;
-			char *mg = strdup(g);
-
-			if (!mg)
-				return;
-			omg = mg;
-			while ((g = strsep(&mg, ";")) != NULL) {
-				struct mep *me;
-				char *s;
-
-				g = skip_spaces(g);
-				if (*g == 0)
-					g = "No_group";
-				if (filter && !strstr(g, filter))
-					continue;
-				if (raw)
-					s = (char *)pe->metric_name;
-				else {
-					if (asprintf(&s, "%s\n%*s%s]",
-						     pe->metric_name, 8, "[", pe->desc) < 0)
-						return;
-
-					if (details) {
-						if (asprintf(&s, "%s\n%*s%s]",
-							     s, 8, "[", pe->metric_expr) < 0)
-							return;
-					}
-				}
-
-				if (!s)
-					continue;
-
-				if (!metricgroups) {
-					strlist__add(metriclist, s);
-				} else {
-					me = mep_lookup(&groups, g);
-					if (!me)
-						continue;
-					strlist__add(me->metrics, s);
-				}
-
-				if (!raw)
-					free(s);
-			}
-			free(omg);
-		}
+		if (metricgroup__print_pmu_event(pe, metricgroups, filter,
+						 raw, details, &groups,
+						 metriclist) < 0)
+			return;
 	}
 
 	if (metricgroups && !raw)
-- 
2.26.2

