Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FE231BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgG2JTq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jul 2020 05:19:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56085 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727794AbgG2JTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-6ZxECa1WOoiy-NC0TC0F0Q-1; Wed, 29 Jul 2020 05:19:37 -0400
X-MC-Unique: 6ZxECa1WOoiy-NC0TC0F0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38FC0800597;
        Wed, 29 Jul 2020 09:19:35 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A15306931E;
        Wed, 29 Jul 2020 09:19:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/19] perf metric: Add add_metric function
Date:   Wed, 29 Jul 2020 11:18:55 +0200
Message-Id: <20200729091908.1378911-7-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple metric adding logging into add_metric function,
so it can be used from other places in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 62 ++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b37008fc253c..4096be7a7a9e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -625,6 +625,39 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
+static int add_metric(struct list_head *group_list,
+		      struct pmu_event *pe,
+		      bool metric_no_group)
+{
+	int ret = 0;
+
+	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
+
+	if (!strstr(pe->metric_expr, "?")) {
+		ret = __metricgroup__add_metric(group_list,
+						pe,
+						metric_no_group,
+						1);
+	} else {
+		int j, count;
+
+		count = arch_get_runtimeparam();
+
+		/* This loop is added to create multiple
+		 * events depend on count value and add
+		 * those events to group_list.
+		 */
+
+		for (j = 0; j < count && !ret; j++) {
+			ret = __metricgroup__add_metric(
+				group_list, pe,
+				metric_no_group, j);
+		}
+	}
+
+	return ret;
+}
+
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *group_list,
@@ -636,34 +669,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	bool has_match = false;
 
 	map_for_each_metric(pe, i, map, metric) {
-		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 		has_match = true;
 
-		if (!strstr(pe->metric_expr, "?")) {
-			ret = __metricgroup__add_metric(group_list,
-							pe,
-							metric_no_group,
-							1);
-			if (ret)
-				return ret;
-		} else {
-			int j, count;
-
-			count = arch_get_runtimeparam();
-
-			/* This loop is added to create multiple
-			 * events depend on count value and add
-			 * those events to group_list.
-			 */
-
-			for (j = 0; j < count; j++) {
-				ret = __metricgroup__add_metric(
-					group_list, pe,
-					metric_no_group, j);
-				if (ret)
-					return ret;
-			}
-		}
+		ret = add_metric(group_list, pe, metric_no_group);
+		if (ret)
+			return ret;
 	}
 
 	/* End of pmu events. */
-- 
2.25.4

