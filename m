Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269AB2B1322
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMARS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgKMARM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:17:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:17:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w79so5186920pfc.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OPBATifPVPWFX/xMXsSqqfS3gvyf/xB3r4Q/9mgsE2Y=;
        b=qPIZmmyD7BdKN2fB1iFPQDCy02OFT26S8vGNdD4jVacH7JAxrmYV/qV3sEZRVth6/X
         MBjROq/bRpZzYZDep6pTMbRh4OdNBT6ksGnRWRbkVus1CpymOiZCaxfg4avOPskUdOOu
         uxwAaStfZWfN6PRRsqIErUnJUl5ZfKznHCKiMzDwaQl/PCqRxd8Z4LHziJOqrZsrh3S4
         YN17k90MG4Gi7ZHgUwPof0hMH3Ewi96x5YPkhYZS9/ySH9K5/YNRiWnfKVwJcWusErN0
         MNxB+8r9ILTTWI+eMgQawckKBhDCpi21SLi9vhhwyw2IgacEJiT8V/DPsS1F/AT8G7uw
         Q3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OPBATifPVPWFX/xMXsSqqfS3gvyf/xB3r4Q/9mgsE2Y=;
        b=PCdDioA9FctIEGDOuOkbP1zLY6NWCHryhDQNkd83moTYnqeBYFABXsxW0tr5FYBGiv
         wfd13+mHX+x8ioNkagh9FMrrrW7Ol6WHZqPpg60iijWGKOOhQZgz4+h1RgqhvcYcqqx4
         INJB1cUJuizj83a0BtTDuOTE1HoYmync/Nv7vbDPxYI3N/1wH050QUBDVE+qYJ8+exqX
         B0v9qRXEelyZsZkgtmWKJrwbdBX6PVrQFQOn9XQaIVtH3RG5YN14u9rdw4T6EpB+LdvM
         Uc9obMuYWlB1WRWZBNVhhwepXEg9VE3Ph7liNhYu0GxLVChOeVqnYtEvJ1pScJahKq5r
         gkIw==
X-Gm-Message-State: AOAM533ra7KfnOaX/ojg1671R8xr7SlGK5/dzv6+w594JocDdwjdjxz9
        GbRaW1U4KF37dh7LKxCOx1mM3/bZA/ju
X-Google-Smtp-Source: ABdhPJymQceonSUGRmf4Nn/fFAiQzE//YTe1Gv0MFUaLQnIa7OfMkxkZCoUbU/i5x7wIbT5IEhQg/hASWJBZ
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:aa7:96a3:0:b029:18b:9eea:dd38 with SMTP id
 g3-20020aa796a30000b029018b9eeadd38mr1756747pfk.37.1605226621590; Thu, 12 Nov
 2020 16:17:01 -0800 (PST)
Date:   Thu, 12 Nov 2020 16:16:49 -0800
In-Reply-To: <20201113001651.544348-1-irogers@google.com>
Message-Id: <20201113001651.544348-4-irogers@google.com>
Mime-Version: 1.0
References: <20201113001651.544348-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 3/5] perf metric: Rename expr__find_other.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A later change will remove the notion of other, rename the function to
expr__find_ids as this is what it populated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 8 ++++----
 tools/perf/tests/pmu-events.c | 9 ++++-----
 tools/perf/util/expr.c        | 4 ++--
 tools/perf/util/expr.h        | 2 +-
 tools/perf/util/metricgroup.c | 2 +-
 tools/perf/util/stat-shadow.c | 6 +++---
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index b0a3b5fd0c00..9d7032041318 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -65,8 +65,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find other",
-			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO",
-					 ctx, 1) == 0);
+			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
+					ctx, 1) == 0);
 	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 3);
 	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAR",
 						    (void **)&val_ptr));
@@ -77,8 +77,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find other",
-			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
-					 NULL, ctx, 3) == 0);
+			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
+					NULL, ctx, 3) == 0);
 	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 2);
 	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT1,param=3/",
 						    (void **)&val_ptr));
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 294daf568bb6..3ac70fa31379 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -502,9 +502,8 @@ static int test_parsing(void)
 			if (!pe->metric_expr)
 				continue;
 			expr__ctx_clear(ctx);
-			if (expr__find_other(pe->metric_expr, NULL, ctx, 0)
-				  < 0) {
-				expr_failure("Parse other failed", map, pe);
+			if (expr__find_ids(pe->metric_expr, NULL, ctx, 0) < 0) {
+				expr_failure("Parse find ids failed", map, pe);
 				ret++;
 				continue;
 			}
@@ -559,8 +558,8 @@ static int metric_parse_fake(const char *str)
 	pr_debug("parsing '%s'\n", str);
 
 	ctx = expr__ctx_new();
-	if (expr__find_other(str, NULL, ctx, 0) < 0) {
-		pr_err("expr__find_other failed\n");
+	if (expr__find_ids(str, NULL, ctx, 0) < 0) {
+		pr_err("expr__find_ids failed\n");
 		return -1;
 	}
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index a3bb802acace..0a3cc073c9e0 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -251,8 +251,8 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
 }
 
-int expr__find_other(const char *expr, const char *one,
-		     struct expr_parse_ctx *ctx, int runtime)
+int expr__find_ids(const char *expr, const char *one,
+		   struct expr_parse_ctx *ctx, int runtime)
 {
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 863b975baeb2..8a6ce628511d 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -55,7 +55,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
-int expr__find_other(const char *expr, const char *one,
+int expr__find_ids(const char *expr, const char *one,
 		struct expr_parse_ctx *ids, int runtime);
 
 #endif
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7c3b267def9d..b4c70a4275d9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -761,7 +761,7 @@ static int __add_metric(struct list_head *metric_list,
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_other(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
+	if (expr__find_ids(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
 		if (m->metric_refs_cnt == 0) {
 			expr__ctx_free(m->pctx);
 			free(m);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index bea7b5c6b1c0..91bb7245f8b1 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -357,9 +357,9 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 		expr__ctx_clear(ctx);
 		metric_events = counter->metric_events;
 		if (!metric_events) {
-			if (expr__find_other(counter->metric_expr,
-					     counter->name,
-					     ctx, 1) < 0)
+			if (expr__find_ids(counter->metric_expr,
+					   counter->name,
+					   ctx, 1) < 0)
 				continue;
 
 			metric_events = calloc(sizeof(struct evsel *),
-- 
2.29.2.299.gdc1121823c-goog

