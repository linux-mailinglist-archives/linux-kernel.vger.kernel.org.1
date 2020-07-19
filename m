Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399F1225360
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGSSNv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jul 2020 14:13:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33739 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbgGSSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:50 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-hEi9CzqEOlCDcqGOrz6UTg-1; Sun, 19 Jul 2020 14:13:43 -0400
X-MC-Unique: hEi9CzqEOlCDcqGOrz6UTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48D2D18A1DF6;
        Sun, 19 Jul 2020 18:13:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B01F872FC;
        Sun, 19 Jul 2020 18:13:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 05/19] perf metric: Add macros for iterating map events
Date:   Sun, 19 Jul 2020 20:13:06 +0200
Message-Id: <20200719181320.785305-6-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding following macros to iterate events and metric:
  map_for_each_event(__pe, __idx, __map)
    - iterates over all pmu_events_map events
  map_for_each_metric(__pe, __idx, __map, __metric)
    - iterates over all metrics that match __metric argument

and use it in metricgroup__add_metric function. Macros
will be be used from other places in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 77 ++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index df0356ec120d..b37008fc253c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -614,6 +614,17 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 	return 0;
 }
 
+#define map_for_each_event(__pe, __idx, __map)				\
+	for (__idx = 0, __pe = &__map->table[__idx];			\
+	     __pe->name || __pe->metric_group || __pe->metric_name;	\
+	     __pe = &__map->table[++__idx])
+
+#define map_for_each_metric(__pe, __idx, __map, __metric)		\
+	map_for_each_event(__pe, __idx, __map)				\
+		if (__pe->metric_expr &&				\
+		    (match_metric(__pe->metric_group, __metric) ||	\
+		     match_metric(__pe->metric_name, __metric)))
+
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *group_list,
@@ -624,49 +635,41 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	int i, ret;
 	bool has_match = false;
 
-	for (i = 0; ; i++) {
-		pe = &map->table[i];
-
-		if (!pe->name && !pe->metric_group && !pe->metric_name) {
-			/* End of pmu events. */
-			if (!has_match)
-				return -EINVAL;
-			break;
-		}
-		if (!pe->metric_expr)
-			continue;
-		if (match_metric(pe->metric_group, metric) ||
-		    match_metric(pe->metric_name, metric)) {
-			has_match = true;
-			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
-
-			if (!strstr(pe->metric_expr, "?")) {
-				ret = __metricgroup__add_metric(group_list,
-								pe,
-								metric_no_group,
-								1);
-				if (ret)
-					return ret;
-			} else {
-				int j, count;
+	map_for_each_metric(pe, i, map, metric) {
+		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
+		has_match = true;
+
+		if (!strstr(pe->metric_expr, "?")) {
+			ret = __metricgroup__add_metric(group_list,
+							pe,
+							metric_no_group,
+							1);
+			if (ret)
+				return ret;
+		} else {
+			int j, count;
 
-				count = arch_get_runtimeparam();
+			count = arch_get_runtimeparam();
 
-				/* This loop is added to create multiple
-				 * events depend on count value and add
-				 * those events to group_list.
-				 */
+			/* This loop is added to create multiple
+			 * events depend on count value and add
+			 * those events to group_list.
+			 */
 
-				for (j = 0; j < count; j++) {
-					ret = __metricgroup__add_metric(
-						group_list, pe,
-						metric_no_group, j);
-					if (ret)
-						return ret;
-				}
+			for (j = 0; j < count; j++) {
+				ret = __metricgroup__add_metric(
+					group_list, pe,
+					metric_no_group, j);
+				if (ret)
+					return ret;
 			}
 		}
 	}
+
+	/* End of pmu events. */
+	if (!has_match)
+		return -EINVAL;
+
 	list_for_each_entry(eg, group_list, nd) {
 		if (events->len > 0)
 			strbuf_addf(events, ",");
-- 
2.25.4

