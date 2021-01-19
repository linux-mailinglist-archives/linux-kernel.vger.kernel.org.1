Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4E2FB729
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbhASKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:21:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11417 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389653AbhASKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:09:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DKkq13K2Mzj8Y0;
        Tue, 19 Jan 2021 18:07:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 19 Jan 2021 18:08:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] perf metricgroup: Fix system PMU metrics
Date:   Tue, 19 Jan 2021 18:04:15 +0800
Message-ID: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim reports that getting "perf stat" for multiple system PMU metrics
segfaults:
./perf stat -a -I 1000 -M imx8mm_ddr_write.all,imx8mm_ddr_write.all
Segmentation fault

While the same works without issue for a single metric.

The logic in metricgroup__add_metric_sys_event_iter() is broken, in that
add_metric() @m argument should be NULL for each new metric. Fix by not
passing a holder for that, and rather make local in
metricgroup__add_metric_sys_event_iter().

Fixes: be335ec28efa ("perf metricgroup: Support adding metrics for system PMUs")
Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee94d3e8dd65..2e60ee170abc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -766,7 +766,6 @@ int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
 struct metricgroup_add_iter_data {
 	struct list_head *metric_list;
 	const char *metric;
-	struct metric **m;
 	struct expr_ids *ids;
 	int *ret;
 	bool *has_match;
@@ -1058,12 +1057,13 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
 						  void *data)
 {
 	struct metricgroup_add_iter_data *d = data;
+	struct metric *m = NULL;
 	int ret;
 
 	if (!match_pe_metric(pe, d->metric))
 		return 0;
 
-	ret = add_metric(d->metric_list, pe, d->metric_no_group, d->m, NULL, d->ids);
+	ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
 	if (ret)
 		return ret;
 
@@ -1114,7 +1114,6 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				.metric_list = &list,
 				.metric = metric,
 				.metric_no_group = metric_no_group,
-				.m = &m,
 				.ids = &ids,
 				.has_match = &has_match,
 				.ret = &ret,
-- 
2.26.2

