Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923A12A9646
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgKFMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7601 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgKFMkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:13 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC2VztzLvM7;
        Fri,  6 Nov 2020 20:39:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:39:59 +0800
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
Subject: [PATCH RFC v5 08/13] perf evlist: Change perf_evlist__splice_list_tail() ordering
Date:   Fri, 6 Nov 2020 20:35:48 +0800
Message-ID: <1604666153-4187-9-git-send-email-john.garry@huawei.com>
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

Function find_evsel_group() expects events to be ordered such that they
are grouped after their leader.

Modify perf_evlist__splice_list_tail() to guarantee this (ordering).

[Should prob also change the function name]

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/evlist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8bdf3d2c907c..b7e4e6d85d59 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -180,11 +180,22 @@ void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 void perf_evlist__splice_list_tail(struct evlist *evlist,
 				   struct list_head *list)
 {
-	struct evsel *evsel, *temp;
+	while (!list_empty(list)) {
+		struct evsel *evsel, *temp, *leader = NULL;
 
-	__evlist__for_each_entry_safe(list, temp, evsel) {
-		list_del_init(&evsel->core.node);
-		evlist__add(evlist, evsel);
+		__evlist__for_each_entry_safe(list, temp, evsel) {
+			list_del_init(&evsel->core.node);
+			evlist__add(evlist, evsel);
+			leader = evsel;
+			break;
+		}
+
+		__evlist__for_each_entry_safe(list, temp, evsel) {
+			if (evsel->leader == leader) {
+				list_del_init(&evsel->core.node);
+				evlist__add(evlist, evsel);
+			}
+		}
 	}
 }
 
-- 
2.26.2

