Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD25225364
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgGSSOE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jul 2020 14:14:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726892AbgGSSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:03 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-nnIuOP9MPNy63cIIgq_R9A-1; Sun, 19 Jul 2020 14:13:56 -0400
X-MC-Unique: nnIuOP9MPNy63cIIgq_R9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E130D80183C;
        Sun, 19 Jul 2020 18:13:54 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A31B74F6C;
        Sun, 19 Jul 2020 18:13:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 09/19] perf metric: Collect referenced metrics in struct metric_expr
Date:   Sun, 19 Jul 2020 20:13:10 +0200
Message-Id: <20200719181320.785305-10-jolsa@kernel.org>
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

Add referenced metrics into struct metric_expr object,
so they are accessible when computing the metric.

Storing just name and expression itself, so the metric
can be resolved and computed.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d1b2c1aa436f..bb5757b9419d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -83,6 +83,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 	struct metric_expr *expr, *tmp;
 
 	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
+		free(expr->metric_refs);
 		free(expr);
 	}
 
@@ -248,6 +249,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
+		struct metric_ref *metric_refs = NULL;
 
 		metric_events = calloc(sizeof(void *),
 				hashmap__size(&eg->pctx.ids) + 1);
@@ -279,6 +281,36 @@ static int metricgroup__setup_events(struct list_head *groups,
 			free(metric_events);
 			break;
 		}
+
+		/*
+		 * Collect and store collected nested expressions
+		 * for metric processing.
+		 */
+		if (eg->metric_refs_cnt) {
+			struct metric_ref_node *ref;
+
+			metric_refs = zalloc(sizeof(struct metric_ref) * (eg->metric_refs_cnt + 1));
+			if (!metric_refs) {
+				ret = -ENOMEM;
+				free(metric_events);
+				break;
+			}
+
+			i = 0;
+			list_for_each_entry(ref, &eg->metric_refs, list) {
+				/*
+				 * Intentionally passing just const char pointers,
+				 * originally from 'struct pmu_event' object.
+				 * We don't need to change them, so there's no
+				 * need to create our own copy.
+				 */
+				metric_refs[i].metric_name = ref->metric_name;
+				metric_refs[i].metric_expr = ref->metric_expr;
+				i++;
+			}
+		};
+
+		expr->metric_refs = metric_refs;
 		expr->metric_expr = eg->metric_expr;
 		expr->metric_name = eg->metric_name;
 		expr->metric_unit = eg->metric_unit;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 8315bd1a7da4..62623a39cbec 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -18,12 +18,18 @@ struct metric_event {
 	struct list_head head; /* list of metric_expr */
 };
 
+struct metric_ref {
+	const char *metric_name;
+	const char *metric_expr;
+};
+
 struct metric_expr {
 	struct list_head nd;
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_unit;
 	struct evsel **metric_events;
+	struct metric_ref *metric_refs;
 	int runtime;
 };
 
-- 
2.25.4

