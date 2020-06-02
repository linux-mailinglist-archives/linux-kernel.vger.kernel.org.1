Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAC1EC491
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgFBVsd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jun 2020 17:48:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728451AbgFBVs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:48:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-HfKlUvPPPCKe_7CimpWc5g-1; Tue, 02 Jun 2020 17:48:23 -0400
X-MC-Unique: HfKlUvPPPCKe_7CimpWc5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF70A835B40;
        Tue,  2 Jun 2020 21:48:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5C0478EF7;
        Tue,  2 Jun 2020 21:48:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 09/13] perf tools: Factor out prepare_metric function
Date:   Tue,  2 Jun 2020 23:47:37 +0200
Message-Id: <20200602214741.1218986-10-jolsa@kernel.org>
In-Reply-To: <20200602214741.1218986-1-jolsa@kernel.org>
References: <20200602214741.1218986-1-jolsa@kernel.org>
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

Factoring out prepare_metric function so it can
be used in test interface coming in following
changes.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/stat-shadow.c | 53 ++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index a7c13a88ecb9..27be7ce2fff4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -730,25 +730,16 @@ static void print_smi_cost(struct perf_stat_config *config,
 	out->print_metric(config, out->ctx, NULL, "%4.0f", "SMI#", smi_num);
 }
 
-static void generic_metric(struct perf_stat_config *config,
-			   const char *metric_expr,
-			   struct evsel **metric_events,
-			   char *name,
-			   const char *metric_name,
-			   const char *metric_unit,
-			   int runtime,
-			   int cpu,
-			   struct perf_stat_output_ctx *out,
-			   struct runtime_stat *st)
+static int prepare_metric(struct evsel **metric_events,
+			  struct expr_parse_ctx *pctx,
+			  int cpu,
+			  struct runtime_stat *st)
 {
-	print_metric_t print_metric = out->print_metric;
-	struct expr_parse_ctx pctx;
-	double ratio, scale;
-	int i;
-	void *ctxp = out->ctx;
+	double scale;
 	char *n, *pn;
+	int i;
 
-	expr__ctx_init(&pctx);
+	expr__ctx_init(pctx);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -771,7 +762,7 @@ static void generic_metric(struct perf_stat_config *config,
 
 		n = strdup(metric_events[i]->name);
 		if (!n)
-			return;
+			return -ENOMEM;
 		/*
 		 * This display code with --no-merge adds [cpu] postfixes.
 		 * These are not supported by the parser. Remove everything
@@ -782,11 +773,35 @@ static void generic_metric(struct perf_stat_config *config,
 			*pn = 0;
 
 		if (metric_total)
-			expr__add_id(&pctx, n, metric_total);
+			expr__add_id(pctx, n, metric_total);
 		else
-			expr__add_id(&pctx, n, avg_stats(stats)*scale);
+			expr__add_id(pctx, n, avg_stats(stats)*scale);
 	}
 
+	return i;
+}
+
+static void generic_metric(struct perf_stat_config *config,
+			   const char *metric_expr,
+			   struct evsel **metric_events,
+			   char *name,
+			   const char *metric_name,
+			   const char *metric_unit,
+			   int runtime,
+			   int cpu,
+			   struct perf_stat_output_ctx *out,
+			   struct runtime_stat *st)
+{
+	print_metric_t print_metric = out->print_metric;
+	struct expr_parse_ctx pctx;
+	double ratio, scale;
+	int i;
+	void *ctxp = out->ctx;
+
+	i = prepare_metric(metric_events, &pctx, cpu, st);
+	if (i < 0)
+		return;
+
 	if (!metric_events[i]) {
 		if (expr__parse(&ratio, &pctx, metric_expr, runtime) == 0) {
 			char *unit;
-- 
2.25.4

