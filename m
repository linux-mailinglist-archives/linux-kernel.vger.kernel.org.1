Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9441E03BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 00:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbgEXWm7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 May 2020 18:42:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388591AbgEXWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:57 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-EMpbr4X4NdaSpCI7Rg6UXw-1; Sun, 24 May 2020 18:42:51 -0400
X-MC-Unique: EMpbr4X4NdaSpCI7Rg6UXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B852E107ACCA;
        Sun, 24 May 2020 22:42:49 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD8F5D788;
        Sun, 24 May 2020 22:42:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 08/14] perf tools: Add metricgroup__parse_groups_test function
Date:   Mon, 25 May 2020 00:42:13 +0200
Message-Id: <20200524224219.234847-9-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding metricgroup__parse_groups_test function. It will
be used as test's interface to metric parsing in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 11 +++++++++++
 tools/perf/util/metricgroup.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d72a565ec483..e2b4c621700c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -752,6 +752,17 @@ int metricgroup__parse_groups(const struct option *opt,
 			    metric_no_merge, metric_events);
 }
 
+int metricgroup__parse_groups_test(struct evlist *evlist,
+				   struct pmu_events_map *map,
+				   const char *str,
+				   bool metric_no_group,
+				   bool metric_no_merge,
+				   struct rblist *metric_events)
+{
+	return parse_groups(evlist, str, metric_no_group,
+			    metric_no_merge, true, metric_events, map);
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 287850bcdeca..426c824e20bf 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -7,8 +7,10 @@
 #include <stdbool.h>
 
 struct evsel;
+struct evlist;
 struct option;
 struct rblist;
+struct pmu_events_map;
 
 struct metric_event {
 	struct rb_node nd;
@@ -34,6 +36,13 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
 
+int metricgroup__parse_groups_test(struct evlist *evlist,
+				   struct pmu_events_map *map,
+				   const char *str,
+				   bool metric_no_group,
+				   bool metric_no_merge,
+				   struct rblist *metric_events);
+
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
-- 
2.25.4

