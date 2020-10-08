Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1D28726B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgJHKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729429AbgJHKTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85115EC064D8AB59D417;
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
Subject: [PATCH RFC v4 09/13] perf metricgroup: Hack a fix for aliases when covering multiple PMUs
Date:   Thu, 8 Oct 2020 18:15:17 +0800
Message-ID: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
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

Function find_evsel_group() seems broken for aliases covering multiple
PMUs, as dicussed at:

https://lore.kernel.org/lkml/CAP-5=fUy6FOszNRwJF6ZNpqQSSyrnLPV6GbkEcZMqAhUp3X0ZA@mail.gmail.com/

For now, hack a fix which I only know works for me.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d948a7f910cf..82ba3638f48c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -213,7 +213,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		/* Ignore event if already used and merging is disabled. */
 		if (metric_no_merge && test_bit(ev->idx, evlist_used))
 			continue;
-		if (!has_constraint && ev->leader != current_leader) {
+		if (!has_constraint && (!current_leader || strcmp(current_leader->name, ev->leader->name))) {
 			/*
 			 * Start of a new group, discard the whole match and
 			 * start again.
@@ -279,7 +279,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 * when then group is left.
 			 */
 			if (!has_constraint &&
-			    ev->leader != metric_events[i]->leader)
+			    strcmp(ev->leader->name, metric_events[i]->leader->name))
 				break;
 			if (!strcmp(metric_events[i]->name, ev->name)) {
 				set_bit(ev->idx, evlist_used);
-- 
2.26.2

