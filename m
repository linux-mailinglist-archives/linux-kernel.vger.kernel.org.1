Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9322536E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGSSOk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jul 2020 14:14:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52139 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgGSSOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-yt021HRGMG6mL4rgCiouxQ-1; Sun, 19 Jul 2020 14:14:29 -0400
X-MC-Unique: yt021HRGMG6mL4rgCiouxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E70106B242;
        Sun, 19 Jul 2020 18:14:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E739174F6C;
        Sun, 19 Jul 2020 18:14:24 +0000 (UTC)
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
Subject: [PATCH 19/19] perf metric: Rename group_list to metric_list
Date:   Sun, 19 Jul 2020 20:13:20 +0200
Message-Id: <20200719181320.785305-20-jolsa@kernel.org>
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

Following the previous change that rename egroup
to metric, there's no reason to call the list
'group_list' anymore, renaming it to metric_list.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9d5fff36042d..6f179b9903a0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -639,7 +639,7 @@ int __weak arch_get_runtimeparam(void)
 	return 1;
 }
 
-static int __add_metric(struct list_head *group_list,
+static int __add_metric(struct list_head *metric_list,
 			struct pmu_event *pe,
 			bool metric_no_group,
 			int runtime,
@@ -726,13 +726,13 @@ static int __add_metric(struct list_head *group_list,
 	if (m->metric_refs_cnt)
 		return 0;
 
-	if (list_empty(group_list))
-		list_add(&m->nd, group_list);
+	if (list_empty(metric_list))
+		list_add(&m->nd, metric_list);
 	else {
 		struct list_head *pos;
 
 		/* Place the largest groups at the front. */
-		list_for_each_prev(pos, group_list) {
+		list_for_each_prev(pos, metric_list) {
 			struct metric *old = list_entry(pos, struct metric, nd);
 
 			if (hashmap__size(&m->pctx.ids) <=
@@ -813,7 +813,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	return p->id ? 0 : -ENOMEM;
 }
 
-static int add_metric(struct list_head *group_list,
+static int add_metric(struct list_head *metric_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **mp,
@@ -822,7 +822,7 @@ static int add_metric(struct list_head *group_list,
 
 static int resolve_metric(struct metric *m,
 			  bool metric_no_group,
-			  struct list_head *group_list,
+			  struct list_head *metric_list,
 			  struct pmu_events_map *map,
 			  struct expr_ids *ids)
 {
@@ -854,7 +854,7 @@ static int resolve_metric(struct metric *m,
 			expr__del_id(&m->pctx, cur->key);
 
 			/* ... and it gets resolved to the parent context. */
-			ret = add_metric(group_list, pe, metric_no_group, &m, parent, ids);
+			ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
 			if (ret)
 				return ret;
 
@@ -869,7 +869,7 @@ static int resolve_metric(struct metric *m,
 	return 0;
 }
 
-static int add_metric(struct list_head *group_list,
+static int add_metric(struct list_head *metric_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **m,
@@ -881,7 +881,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent, ids);
+		ret = __add_metric(metric_list, pe, metric_no_group, 1, m, parent, ids);
 	} else {
 		int j, count;
 
@@ -889,11 +889,11 @@ static int add_metric(struct list_head *group_list,
 
 		/* This loop is added to create multiple
 		 * events depend on count value and add
-		 * those events to group_list.
+		 * those events to metric_list.
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent, ids);
+			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
 		}
 	}
 
@@ -902,7 +902,7 @@ static int add_metric(struct list_head *group_list,
 
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
-				   struct list_head *group_list,
+				   struct list_head *metric_list,
 				   struct pmu_events_map *map)
 
 {
@@ -948,14 +948,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		}
 	}
 
-	list_splice(&list, group_list);
+	list_splice(&list, metric_list);
 	expr_ids__exit(&ids);
 	return 0;
 }
 
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
-					struct list_head *group_list,
+					struct list_head *metric_list,
 					struct pmu_events_map *map)
 {
 	char *llist, *nlist, *p;
@@ -971,7 +971,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 	while ((p = strsep(&llist, ",")) != NULL) {
 		ret = metricgroup__add_metric(p, metric_no_group, events,
-					      group_list, map);
+					      metric_list, map);
 		if (ret == -EINVAL) {
 			fprintf(stderr, "Cannot find metric or group `%s'\n",
 					p);
@@ -996,11 +996,11 @@ static void metric__free_refs(struct metric *metric)
 	}
 }
 
-static void metricgroup__free_metrics(struct list_head *group_list)
+static void metricgroup__free_metrics(struct list_head *metric_list)
 {
 	struct metric *m, *tmp;
 
-	list_for_each_entry_safe (m, tmp, group_list, nd) {
+	list_for_each_entry_safe (m, tmp, metric_list, nd) {
 		metric__free_refs(m);
 		expr__ctx_clear(&m->pctx);
 		list_del_init(&m->nd);
@@ -1017,13 +1017,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 {
 	struct parse_events_error parse_error;
 	struct strbuf extra_events;
-	LIST_HEAD(group_list);
+	LIST_HEAD(metric_list);
 	int ret;
 
 	if (metric_events->nr_entries == 0)
 		metricgroup__rblist_init(metric_events);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &extra_events, &group_list, map);
+					   &extra_events, &metric_list, map);
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
@@ -1034,10 +1034,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		goto out;
 	}
 	strbuf_release(&extra_events);
-	ret = metricgroup__setup_events(&group_list, metric_no_merge,
+	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
-	metricgroup__free_metrics(&group_list);
+	metricgroup__free_metrics(&metric_list);
 	return ret;
 }
 
-- 
2.25.4

