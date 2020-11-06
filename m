Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDE2A964D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgKFMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7610 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgKFMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC3h66zLvMR;
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
Subject: [PATCH RFC v5 09/13] perf metricgroup: Fix metrics using aliases covering multiple PMUs
Date:   Fri, 6 Nov 2020 20:35:49 +0800
Message-ID: <1604666153-4187-10-git-send-email-john.garry@huawei.com>
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

Support for metric expressions using aliases which cover multiple PMUs is
broken. Consider the following test metric expression:

"MetricExpr": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE * UNC_CBO_XSNP_RESPONSE.MISS_EVICTION"

When used on my broadwell, "perf stat" gives:

unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_1/umask=0x81,event=0x22/
unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_0/umask=0x81,event=0x22/
unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_1/umask=0x41,event=0x22/
unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_0/umask=0x41,event=0x22/
Control descriptor is not initialized
unc_cbo_xsnp_response.miss_eviction: 3645925 1000850523 1000850523
unc_cbo_xsnp_response.miss_xcore: 106850 1000850523 1000850523

 Performance counter stats for 'system wide':

         3,645,925      unc_cbo_xsnp_response.miss_eviction # 389567086250.00 test_metric_inc
           106,850      unc_cbo_xsnp_response.miss_xcore

       1.000883096 seconds time elapsed

Notice that only the results from one PMU are included. Fix the logic of
find_evsel_group() to enable events which apply to multiple PMUs, by
checking if the event pmu_name matches that of the metric event.

With that, "perf stat" now gives:

unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_1/umask=0x81,event=0x22/
unc_cbo_xsnp_response.miss_eviction -> uncore_cbox_0/umask=0x81,event=0x22/
unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_1/umask=0x41,event=0x22/
unc_cbo_xsnp_response.miss_xcore -> uncore_cbox_0/umask=0x41,event=0x22/
Control descriptor is not initialized
unc_cbo_xsnp_response.miss_eviction: 4237983 1000904100 1000904100
unc_cbo_xsnp_response.miss_xcore: 218643 1000904100 1000904100
unc_cbo_xsnp_response.miss_eviction: 4254148 1000902629 1000902629
unc_cbo_xsnp_response.miss_xcore: 213352 1000902629 1000902629

 Performance counter stats for 'system wide':

         4,237,983      unc_cbo_xsnp_response.miss_eviction # 3668558131345.00 test_metric_inc
           218,643      unc_cbo_xsnp_response.miss_xcore
         4,254,148      unc_cbo_xsnp_response.miss_eviction
           213,352      unc_cbo_xsnp_response.miss_xcore

       1.000938151 seconds time elapsed


Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 060454a17293..da979dd50809 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -279,7 +279,9 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 * when then group is left.
 			 */
 			if (!has_constraint &&
-			    ev->leader != metric_events[i]->leader)
+			    ev->leader != metric_events[i]->leader &&
+			    !strcmp(ev->leader->pmu_name,
+				    metric_events[i]->leader->pmu_name))
 				break;
 			if (!strcmp(metric_events[i]->name, ev->name)) {
 				set_bit(ev->idx, evlist_used);
-- 
2.26.2

