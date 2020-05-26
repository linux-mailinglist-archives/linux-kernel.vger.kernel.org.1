Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F581C89F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEGMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 08:02:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgEGMCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A036DE4807D337282B8E;
        Thu,  7 May 2020 20:02:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:01:59 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 10/12] perf metricgroup: Split up metricgroup__print()
Date:   Thu, 7 May 2020 19:57:49 +0800
Message-ID: <1588852671-61996-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To aid supporting system event metric groups, break up the function
metricgroup__print() into a part which iterates metrics and a part
which actually "prints" the metric.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 117 ++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d1033756a1bc..31e97e24c2b0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -315,6 +315,68 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 		putchar('\n');
 }
 
+
+static void metricgroup__print_pmu_event(struct pmu_event *pe,
+					 bool metricgroups, char *filter,
+					 bool raw, bool details,
+					 struct rblist *groups,
+					 struct strlist *metriclist)
+{
+	const char *g;
+
+	g = pe->metric_group;
+	if (!g && pe->metric_name) {
+		if (pe->name)
+			return;
+		g = "No_group";
+	}
+
+	if (g) {
+		char *omg;
+		char *mg = strdup(g);
+
+		if (!mg)
+			return;
+		omg = mg;
+		while ((g = strsep(&mg, ";")) != NULL) {
+			struct mep *me;
+			char *s;
+
+			g = skip_spaces(g);
+			if (*g == 0)
+				g = "No_group";
+			if (filter && !strstr(g, filter))
+				continue;
+			if (raw)
+				s = (char *)pe->metric_name;
+			else {
+				if (asprintf(&s, "%s\n%*s%s]", pe->metric_name,
+					     8, "[", pe->desc) < 0)
+					return;
+
+				if (details) {
+					if (asprintf(&s, "%s\n%*s%s]", s, 8,
+						     "[", pe->metric_expr) < 0)
+						return;
+				}
+			}
+
+			if (!s)
+				continue;
+
+			if (!metricgroups) {
+				strlist__add(metriclist, s);
+			} else {
+				me = mep_lookup(groups, g);
+				if (!me)
+					continue;
+				strlist__add(me->metrics, s);
+			}
+		}
+		free(omg);
+	}
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
@@ -339,63 +401,15 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
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
 
-				if (!metricgroups) {
-					strlist__add(metriclist, s);
-				} else {
-					me = mep_lookup(&groups, g);
-					if (!me)
-						continue;
-					strlist__add(me->metrics, s);
-				}
-			}
-			free(omg);
-		}
+		metricgroup__print_pmu_event(pe, metricgroups, filter, raw,
+					     details, &groups, metriclist);
 	}
 
 	if (metricgroups && !raw)
@@ -407,7 +421,8 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 		struct mep *me = container_of(node, struct mep, nd);
 
 		if (metricgroups)
-			printf("%s%s%s", me->name, metrics && !raw ? ":" : "", raw ? " " : "\n");
+			printf("%s%s%s", me->name, metrics && !raw ? ":" : "",
+			       raw ? " " : "\n");
 		if (metrics)
 			metricgroup__print_strlist(me->metrics, raw);
 		next = rb_next(node);
-- 
2.16.4

