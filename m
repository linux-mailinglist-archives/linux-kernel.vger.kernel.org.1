Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162241C89F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEGMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 08:02:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbgEGMCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AA14637066ECD14BF777;
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
Subject: [PATCH RFC v3 11/12] perf metricgroup: Support printing metric groups for system PMUs
Date:   Thu, 7 May 2020 19:57:50 +0800
Message-ID: <1588852671-61996-12-git-send-email-john.garry@huawei.com>
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

Currently only metricgroups for core- or uncore-based events is supported.
Extend this for system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 66 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 31e97e24c2b0..ecf14aa01a59 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -377,6 +377,51 @@ static void metricgroup__print_pmu_event(struct pmu_event *pe,
 	}
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
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
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
+	metricgroup__print_pmu_event(pe, d->metricgroups, d->filter, d->raw,
+				     d->details, d->groups, d->metriclist);
+
+	return 0;
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
@@ -387,9 +432,6 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
 
-	if (!map)
-		return;
-
 	if (!metricgroups) {
 		metriclist = strlist__new(NULL, NULL);
 		if (!metriclist)
@@ -400,7 +442,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
-	for (i = 0; ; i++) {
+	for (i = 0; map; i++) {
 		pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
@@ -412,6 +454,22 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 					     details, &groups, metriclist);
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
 	if (metricgroups && !raw)
 		printf("\nMetric Groups:\n\n");
 	else if (metrics && !raw)
-- 
2.16.4

