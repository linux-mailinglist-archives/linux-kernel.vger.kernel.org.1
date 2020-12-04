Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0A2CECE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgLDLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:16:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8662 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgLDLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:16:25 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnVTh4qS9z15XVZ;
        Fri,  4 Dec 2020 19:14:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 19:14:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <irogers@google.com>
CC:     <qiangqing.zhang@nxp.com>, <kjain@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <kan.liang@linux.intel.com>, <kim.phillips@amd.com>,
        <ak@linux.intel.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v6 08/10] perf metricgroup: Support printing metric groups for system PMUs
Date:   Fri, 4 Dec 2020 19:10:14 +0800
Message-ID: <1607080216-36968-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
References: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently printing metricgroups for core- or uncore-based events matched
by CPUID is supported.

Extend this for system events.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 64 ++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4c6a686b08eb..abc5d0e28d0f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -559,6 +559,49 @@ static int metricgroup__print_pmu_event(struct pmu_event *pe,
 	return 0;
 }
 
+struct metricgroup_print_sys_idata {
+	struct strlist *metriclist;
+	bool metricgroups;
+	char *filter;
+	bool raw;
+	bool details;
+	struct rblist *groups;
+};
+
+typedef int (*metricgroup_sys_event_iter_fn)(struct pmu_event *pe, void *);
+
+struct metricgroup_iter_data {
+	metricgroup_sys_event_iter_fn fn;
+	void *data;
+};
+
+static int metricgroup__sys_event_iter(struct pmu_event *pe, void *data)
+{
+	struct metricgroup_iter_data *d = data;
+	struct perf_pmu *pmu = NULL;
+
+	if (!pe->metric_expr || !pe->compat)
+		return 0;
+
+	while ((pmu = perf_pmu__scan(pmu))) {
+
+		if (!pmu->id || strcmp(pmu->id, pe->compat))
+			continue;
+
+		return d->fn(pe, d->data);
+	}
+
+	return 0;
+}
+
+static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
+{
+	struct metricgroup_print_sys_idata *d = data;
+
+	return metricgroup__print_pmu_event(pe, d->metricgroups, d->filter, d->raw,
+				     d->details, d->groups, d->metriclist);
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
@@ -569,9 +612,6 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
 
-	if (!map)
-		return;
-
 	if (!metricgroups) {
 		metriclist = strlist__new(NULL, NULL);
 		if (!metriclist)
@@ -582,7 +622,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
-	for (i = 0; ; i++) {
+	for (i = 0; map; i++) {
 		pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
@@ -595,6 +635,22 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			return;
 	}
 
+	{
+		struct metricgroup_iter_data data = {
+			.fn = metricgroup__print_sys_event_iter,
+			.data = (void *) &(struct metricgroup_print_sys_idata){
+				.metriclist = metriclist,
+				.metricgroups = metricgroups,
+				.filter = filter,
+				.raw = raw,
+				.details = details,
+				.groups = &groups,
+			},
+		};
+
+		pmu_for_each_sys_event(metricgroup__sys_event_iter, &data);
+	}
+
 	if (!filter || !rblist__empty(&groups)) {
 		if (metricgroups && !raw)
 			printf("\nMetric Groups:\n\n");
-- 
2.26.2

