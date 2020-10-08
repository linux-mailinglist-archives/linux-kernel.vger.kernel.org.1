Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8210287262
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgJHKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729429AbgJHKTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3A9AE72BBB8AC51F64F6;
        Thu,  8 Oct 2020 18:19:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 18:18:58 +0800
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
Subject: [PATCH RFC v4 04/13] perf pmu: Add pmu_add_sys_aliases()
Date:   Thu, 8 Oct 2020 18:15:12 +0800
Message-ID: <1602152121-240367-5-git-send-email-john.garry@huawei.com>
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

Add pmu_add_sys_aliases() to add system PMU events aliases.

For adding system PMU events, iterate through all the events for all SoC
event tables in pmu_sys_event_tables[].

Matches must satisfy both:
- PMU identifier matches event "compat" value
- event "Unit" member must match, same as uncore event aliases matched by
  CPUID

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  2 ++
 2 files changed, 80 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cbeda45ce578..44ef28302fc7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -812,6 +812,83 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	pmu_add_cpu_aliases_map(head, pmu, map);
 }
 
+void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
+{
+	int i = 0;
+
+	while (1) {
+		struct pmu_sys_events *event_table;
+		int j = 0;
+
+		event_table = &pmu_sys_event_tables[i++];
+
+		if (!event_table->table)
+			break;
+
+		while (1) {
+			struct pmu_event *pe = &event_table->table[j++];
+			int ret;
+
+			if (!pe->name && !pe->metric_group && !pe->metric_name)
+				break;
+
+			ret = fn(pe, data);
+			if (ret)
+				break;
+		}
+	}
+}
+
+struct pmu_sys_event_iter_data {
+	struct list_head *head;
+	struct perf_pmu *pmu;
+};
+
+static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
+{
+	struct pmu_sys_event_iter_data *idata = data;
+	struct perf_pmu *pmu = idata->pmu;
+
+	if (!pe->name) {
+		if (pe->metric_group || pe->metric_name)
+			return 0;
+		return -EINVAL;
+	}
+
+	if (!pe->compat || !pe->pmu)
+		return 0;
+
+	if (!strcmp(pmu->id, pe->compat) &&
+	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
+		__perf_pmu__new_alias(idata->head, NULL,
+				      (char *)pe->name,
+				      (char *)pe->desc,
+				      (char *)pe->event,
+				      (char *)pe->long_desc,
+				      (char *)pe->topic,
+				      (char *)pe->unit,
+				      (char *)pe->perpkg,
+				      (char *)pe->metric_expr,
+				      (char *)pe->metric_name,
+				      (char *)pe->deprecated);
+	}
+
+	return 0;
+}
+
+static void pmu_add_sys_aliases(struct list_head *head, struct perf_pmu *pmu)
+{
+	struct pmu_sys_event_iter_data idata = {
+		.head = head,
+		.pmu = pmu,
+	};
+
+	if (!pmu->id)
+		return;
+
+	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, &idata);
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -867,6 +944,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
+	pmu_add_sys_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index d4366e8e79df..8164388478c6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -117,6 +117,8 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
+typedef int (*pmu_sys_event_iter_fn)(struct pmu_event *pe, void *data);
+void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
-- 
2.26.2

