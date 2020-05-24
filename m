Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83701E03BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgEXWmu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 May 2020 18:42:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388521AbgEXWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:49 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-_sMYe6SQPlWCc_nssQ11zw-1; Sun, 24 May 2020 18:42:46 -0400
X-MC-Unique: _sMYe6SQPlWCc_nssQ11zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DB0BFC1;
        Sun, 24 May 2020 22:42:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFEE15D788;
        Sun, 24 May 2020 22:42:42 +0000 (UTC)
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
Subject: [PATCH 07/14] perf tools: Factor out parse_groups function
Date:   Mon, 25 May 2020 00:42:12 +0200
Message-Id: <20200524224219.234847-8-jolsa@kernel.org>
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

Factor out the parse_groups function, it will be used
for new test interface coming in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9e21aa767e41..d72a565ec483 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -709,14 +709,12 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 	}
 }
 
-int metricgroup__parse_groups(const struct option *opt,
-			      const char *str,
-			      bool metric_no_group,
-			      bool metric_no_merge,
-			      struct rblist *metric_events)
+static int parse_groups(struct evlist *perf_evlist, const char *str,
+			bool metric_no_group,
+			bool metric_no_merge,
+			struct rblist *metric_events)
 {
 	struct parse_events_error parse_error;
-	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct strbuf extra_events;
 	LIST_HEAD(group_list);
 	int ret;
@@ -742,6 +740,18 @@ int metricgroup__parse_groups(const struct option *opt,
 	return ret;
 }
 
+int metricgroup__parse_groups(const struct option *opt,
+			      const char *str,
+			      bool metric_no_group,
+			      bool metric_no_merge,
+			      struct rblist *metric_events)
+{
+	struct evlist *perf_evlist = *(struct evlist **)opt->value;
+
+	return parse_groups(perf_evlist, str, metric_no_group,
+			    metric_no_merge, metric_events);
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
-- 
2.25.4

