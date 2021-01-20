Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC732FD58C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbhATQYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:24:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11036 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403848AbhATQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:23:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DLW4f44DqzjB63;
        Thu, 21 Jan 2021 00:21:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 21 Jan 2021 00:22:53 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] perf metricgroup: Fix for metrics containing duration_time
Date:   Thu, 21 Jan 2021 00:18:38 +0800
Message-ID: <1611159518-226883-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Metrics containing duration_time cause a segfault:

$./perf stat -v -M L1D_Cache_Fill_BW sleep 1
Using CPUID GenuineIntel-6-3D-4
metric expr 64 * l1d.replacement / 1000000000 / duration_time for L1D_Cache_Fill_BW
found event duration_time
found event l1d.replacement
adding {l1d.replacement}:W,duration_time
l1d.replacement -> cpu/umask=0x1,(null)=0x1e8483,event=0x51/
Segmentation fault

In commit c2337d67199a ("perf metricgroup: Fix metrics using aliases
covering multiple PMUs"), the logic in find_evsel_group() when iter'ing
events was changed to not only select events in same group, but also for
aliased PMUs.

Checking whether events were for aliased PMUs was done by comparing the
event PMU name. This was not safe for duration_time event, which has no
associated PMU (and no PMU name), so fix by checking if the event PMU name
is set also.

Fixes: c2337d67199a ("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2e60ee170abc..e6d3452031e5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -162,6 +162,14 @@ static bool contains_event(struct evsel **metric_events, int num_events,
 	return false;
 }
 
+static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
+{
+	if (!ev1->pmu_name || !ev2->pmu_name)
+		return false;
+
+	return !strcmp(ev1->pmu_name, ev2->pmu_name);
+}
+
 /**
  * Find a group of events in perf_evlist that correspond to those from a parsed
  * metric expression. Note, as find_evsel_group is called in the same order as
@@ -280,8 +288,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 */
 			if (!has_constraint &&
 			    ev->leader != metric_events[i]->leader &&
-			    !strcmp(ev->leader->pmu_name,
-				    metric_events[i]->leader->pmu_name))
+			    evsel_same_pmu(ev->leader, metric_events[i]->leader))
 				break;
 			if (!strcmp(metric_events[i]->name, ev->name)) {
 				set_bit(ev->idx, evlist_used);
-- 
2.26.2

