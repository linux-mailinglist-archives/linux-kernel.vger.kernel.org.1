Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0362A9644
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgKFMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7602 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgKFMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:11 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC3M4gzLvMK;
        Fri,  6 Nov 2020 20:39:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:40:00 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <linux-imx@nxp.com>,
        <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v5 10/13] perf metricgroup: Split up metricgroup__print()
Date:   Fri, 6 Nov 2020 20:35:50 +0800
Message-ID: <1604666153-4187-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
References: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
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
index da979dd50809..64fbb96eb7b5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -493,6 +493,72 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
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
@@ -517,66 +583,16 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
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
 
 	if (!filter || !rblist__empty(&groups)) {
-- 
2.26.2

