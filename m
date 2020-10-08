Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE8287269
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgJHKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729450AbgJHKTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47BDD3D26AD12A724D0D;
        Thu,  8 Oct 2020 18:19:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 18:19:00 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <james.clark@arm.com>,
        <linux-imx@nxp.com>
Subject: [PATCH RFC v4 08/13] perf metricgroup: Fix uncore metric expressions
Date:   Thu, 8 Oct 2020 18:15:16 +0800
Message-ID: <1602152121-240367-9-git-send-email-john.garry@huawei.com>
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

From: Ian Rogers <irogers@google.com>

A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
and uncore_imc/case_count_write/. These events open 6 events per socket
with pmu names of uncore_imc_[0-5]. The current metric setup code in
find_evsel_group assumes one ID will map to 1 event to be recorded in
metric_events. For events with multiple matches, the first event is
recorded in metric_events (avoiding matching >1 event with the same
name) and the evlist_used updated so that duplicate events aren't
removed when the evlist has unused events removed.

Before this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

             41.14 MiB  uncore_imc/cas_count_read/
     1,002,614,251 ns   duration_time

       1.002614251 seconds time elapsed

After this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

            157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
            126.97 MiB  uncore_imc/cas_count_write/
     1,003,019,728 ns   duration_time

Erroneous duplication introduced in:
commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").

Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 75 ++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ab5030fcfed4..d948a7f910cf 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -150,6 +150,18 @@ static void expr_ids__exit(struct expr_ids *ids)
 		free(ids->id[i].id);
 }
 
+static bool contains_event(struct evsel **metric_events, int num_events,
+			const char *event_name)
+{
+	int i;
+
+	for (i = 0; i < num_events; i++) {
+		if (!strcmp(metric_events[i]->name, event_name))
+			return true;
+	}
+	return false;
+}
+
 /**
  * Find a group of events in perf_evlist that correpond to those from a parsed
  * metric expression. Note, as find_evsel_group is called in the same order as
@@ -180,7 +192,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	int i = 0, matched_events = 0, events_to_match;
 	const int idnum = (int)hashmap__size(&pctx->ids);
 
-	/* duration_time is grouped separately. */
+	/*
+	 * duration_time is always grouped separately, when events are grouped
+	 * (ie has_constraint is false) then ignore it in the matching loop and
+	 * add it to metric_events at the end.
+	 */
 	if (!has_constraint &&
 	    hashmap__find(&pctx->ids, "duration_time", (void **)&val_ptr))
 		events_to_match = idnum - 1;
@@ -207,23 +223,20 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				sizeof(struct evsel *) * idnum);
 			current_leader = ev->leader;
 		}
-		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
-			if (has_constraint) {
-				/*
-				 * Events aren't grouped, ensure the same event
-				 * isn't matched from two groups.
-				 */
-				for (i = 0; i < matched_events; i++) {
-					if (!strcmp(ev->name,
-						    metric_events[i]->name)) {
-						break;
-					}
-				}
-				if (i != matched_events)
-					continue;
-			}
+		/*
+		 * Check for duplicate events with the same name. For example,
+		 * uncore_imc/cas_count_read/ will turn into 6 events per socket
+		 * on skylakex. Only the first such event is placed in
+		 * metric_events. If events aren't grouped then this also
+		 * ensures that the same event in different sibling groups
+		 * aren't both added to metric_events.
+		 */
+		if (contains_event(metric_events, matched_events, ev->name))
+			continue;
+		/* Does this event belong to the parse context? */
+		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr))
 			metric_events[matched_events++] = ev;
-		}
+
 		if (matched_events == events_to_match)
 			break;
 	}
@@ -239,7 +252,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	}
 
 	if (matched_events != idnum) {
-		/* Not whole match */
+		/* Not a whole match */
 		return NULL;
 	}
 
@@ -247,8 +260,32 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 
 	for (i = 0; i < idnum; i++) {
 		ev = metric_events[i];
-		ev->metric_leader = ev;
+		/* Don't free the used events. */
 		set_bit(ev->idx, evlist_used);
+		/*
+		 * The metric leader points to the identically named event in
+		 * metric_events.
+		 */
+		ev->metric_leader = ev;
+		/*
+		 * Mark two events with identical names in the same group (or
+		 * globally) as being in use as uncore events may be duplicated
+		 * for each pmu. Set the metric leader of such events to be the
+		 * event that appears in metric_events.
+		 */
+		evlist__for_each_entry_continue(perf_evlist, ev) {
+			/*
+			 * If events are grouped then the search can terminate
+			 * when then group is left.
+			 */
+			if (!has_constraint &&
+			    ev->leader != metric_events[i]->leader)
+				break;
+			if (!strcmp(metric_events[i]->name, ev->name)) {
+				set_bit(ev->idx, evlist_used);
+				ev->metric_leader = metric_events[i];
+			}
+		}
 	}
 
 	return metric_events[0];
-- 
2.26.2

