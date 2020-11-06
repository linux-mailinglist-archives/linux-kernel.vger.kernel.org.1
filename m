Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A042A9649
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKFMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6751 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgKFMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:14 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CSKjJ59FVzkfkc;
        Fri,  6 Nov 2020 20:40:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:40:01 +0800
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
Subject: [PATCH RFC v5 12/13] perf metricgroup: Support adding metrics for system PMUs
Date:   Fri, 6 Nov 2020 20:35:52 +0800
Message-ID: <1604666153-4187-13-git-send-email-john.garry@huawei.com>
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

Currently adding metrics for core- or uncore-based events matched by CPUID
is supported.

Extend this for system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 59 +++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e0445ebf59e5..af7a5a65646a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -415,6 +415,12 @@ static bool match_metric(const char *n, const char *list)
 	return false;
 }
 
+static bool match_pe_metric(struct pmu_event *pe, const char *metric)
+{
+	return match_metric(pe->metric_group, metric) ||
+	       match_metric(pe->metric_name, metric);
+}
+
 struct mep {
 	struct rb_node nd;
 	const char *name;
@@ -757,6 +763,16 @@ int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
 	return 1;
 }
 
+struct metricgroup_add_iter_data {
+	struct list_head *metric_list;
+	const char *metric;
+	struct metric **m;
+	bool metric_no_group;
+	struct expr_ids *ids;
+	bool *has_match;
+	int *ret;
+};
+
 static int __add_metric(struct list_head *metric_list,
 			struct pmu_event *pe,
 			bool metric_no_group,
@@ -867,7 +883,7 @@ static int __add_metric(struct list_head *metric_list,
 }
 
 #define map_for_each_event(__pe, __idx, __map)				\
-	for (__idx = 0, __pe = &__map->table[__idx];			\
+	if (__map) for (__idx = 0, __pe = &__map->table[__idx];		\
 	     __pe->name || __pe->metric_group || __pe->metric_name;	\
 	     __pe = &__map->table[++__idx])
 
@@ -1037,6 +1053,29 @@ static int add_metric(struct list_head *metric_list,
 	return ret;
 }
 
+static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
+						  void *data)
+{
+	struct metricgroup_add_iter_data *d = data;
+	int ret;
+
+	if (!match_pe_metric(pe, d->metric))
+		return 0;
+
+	ret = add_metric(d->metric_list, pe, d->metric_no_group, d->m, NULL, d->ids);
+	if (ret)
+		return ret;
+
+	ret = resolve_metric(d->metric_no_group,
+				     d->metric_list, NULL, d->ids);
+	if (ret)
+		return ret;
+
+	*(d->has_match) = true;
+
+	return *d->ret;
+}
+
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *metric_list,
@@ -1067,6 +1106,22 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 			goto out;
 	}
 
+	{
+		struct metricgroup_iter_data data = {
+			.fn = metricgroup__add_metric_sys_event_iter,
+			.data = (void *) &(struct metricgroup_add_iter_data) {
+				.metric_list = &list,
+				.metric = metric,
+				.metric_no_group = metric_no_group,
+				.m = &m,
+				.ids = &ids,
+				.has_match = &has_match,
+				.ret = &ret,
+			},
+		};
+
+		pmu_for_each_sys_event(metricgroup__sys_event_iter, &data);
+	}
 	/* End of pmu events. */
 	if (!has_match) {
 		ret = -EINVAL;
@@ -1193,8 +1248,6 @@ int metricgroup__parse_groups(const struct option *opt,
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 
-	if (!map)
-		return 0;
 
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, map);
-- 
2.26.2

