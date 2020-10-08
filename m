Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9724287268
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgJHKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729456AbgJHKTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B641D4A210B3E43E0DC;
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
Subject: [PATCH RFC v4 11/13] perf metricgroup: Support printing metric groups for system PMUs
Date:   Thu, 8 Oct 2020 18:15:19 +0800
Message-ID: <1602152121-240367-12-git-send-email-john.garry@huawei.com>
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

Currently printing metricgroups for core- or uncore-based events matched
by CPUID is supported.

Extend this for system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 62 +++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1102391cafeb..03f811eb600b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -557,6 +557,49 @@ static int metricgroup__print_pmu_event(struct pmu_event *pe,
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
@@ -567,9 +610,6 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
 
-	if (!map)
-		return;
-
 	if (!metricgroups) {
 		metriclist = strlist__new(NULL, NULL);
 		if (!metriclist)
@@ -593,6 +633,22 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
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
 	if (metricgroups && !raw)
 		printf("\nMetric Groups:\n\n");
 	else if (metrics && !raw)
-- 
2.26.2

