Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12532F3FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406203AbhALXF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbhALXF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:05:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F340C0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:04:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e137so331761ybf.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NZGhhQ1WmURZLPYQaFdIwi6uY+HUsUqdF3KhZiR4NcQ=;
        b=nbhKV63a6LGq5lSX/eIagyLBEUxPnNOzUo65EPr5JDZx1bCakl5n6Smjw8PnlCbmz+
         xmsVKHr7KDjMNNxw5jhd2/zrOjP7kV92fRJ4K39ULKyPVPO9kg1NKGslQOqVrbZZmbTK
         hHwCp5JNkdNv8J+f/LmC8FMna4jK6dlMZIbyphML7Wb8XaE/clrfHzmpKPgIUYQuZRdk
         W4vuhh2BvPoc+UXBujhARPAht1b2eeVE3FBz4XEW7K8WJxXfW1U/ZveuynQF9kMFKNpe
         i0p3eDov3oUFcWVAEKc67caK5hTH2qYm5TXi42bOfDlyTicwD5zBn0FA7kkyS81ALcgc
         Y5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NZGhhQ1WmURZLPYQaFdIwi6uY+HUsUqdF3KhZiR4NcQ=;
        b=sglO61FmcxDNktF0wwCA6fXsuVv4l/iEpD2uYQvudKVcYolG6WIUYxpASfAHEYLFEV
         cx9hs90K29gFPHT1zkFbbsn0m+1PR1AlyCZoU2AbBpE3meHmFpYOC12GcDmVPhm6P0jY
         206BywnTDhOY6l9BwrPuOhMgQCT8YlAWWkYBmPpER1ZdsXgn0Bkfvaa3MikcrcO1ovMx
         WpA/sUYDNwrDRboJOko/j5/NZpZHnc/l/Tt+EE1v2GzyN8l9cyOUShMLGaRVdQYBDkcw
         mKSJKB05rPYJ2tjD4F4kOIUbPDs+1Yk4a0ounyWpJLv7hJtn2ZRjKjygCGri3dKz0/7f
         I9WA==
X-Gm-Message-State: AOAM532sjmVe0nIDRVPo0fOyY0xNUb9eNIay2kjxjw0lVRTJr5hdycXM
        KCJeCGlqeZVvZc/fD+BbpYaUfhdDC1Un
X-Google-Smtp-Source: ABdhPJzM9xl4PnsWD94/UaPOqgPzUwmrKL7nTchzFKA3eAJE3zmr7u3EewMqIXp64QyeJMtj4blF9Fu0I2iz
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:aa87:: with SMTP id
 t7mr2507977ybi.233.1610492684262; Tue, 12 Jan 2021 15:04:44 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:04:32 -0800
In-Reply-To: <20210112230434.2631593-1-irogers@google.com>
Message-Id: <20210112230434.2631593-4-irogers@google.com>
Mime-Version: 1.0
References: <20210112230434.2631593-1-irogers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v7 3/5] perf metric: Rename expr__find_other.
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
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A later change will remove the notion of other, rename the function to
expr__find_ids as this is what it populates.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 26 +++++++++++++-------------
 tools/perf/tests/pmu-events.c |  9 ++++-----
 tools/perf/util/expr.c        |  4 ++--
 tools/perf/util/expr.h        |  2 +-
 tools/perf/util/metricgroup.c |  2 +-
 tools/perf/util/stat-shadow.c |  6 +++---
 6 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index b0a3b5fd0c00..7ccb97c73347 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -64,25 +64,25 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	expr__ctx_clear(ctx);
-	TEST_ASSERT_VAL("find other",
-			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO",
-					 ctx, 1) == 0);
-	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 3);
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAR",
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
+					ctx, 1) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAZ",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAZ",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BOZO",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BOZO",
 						    (void **)&val_ptr));
 
 	expr__ctx_clear(ctx);
-	TEST_ASSERT_VAL("find other",
-			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
-					 NULL, ctx, 3) == 0);
-	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT1,param=3/",
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
+					NULL, ctx, 3) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3/",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT2,param=3/",
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
 	expr__ctx_free(ctx);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index cf5afd126934..d14a42406549 100644
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
index 7b1c06772a49..adf16bb7571a 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -288,8 +288,8 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
 }
 
-int expr__find_other(const char *expr, const char *one,
-		     struct expr_parse_ctx *ctx, int runtime)
+int expr__find_ids(const char *expr, const char *one,
+		   struct expr_parse_ctx *ctx, int runtime)
 {
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 00b941cfe6a6..955d5adb7ca4 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -43,7 +43,7 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 		     struct expr_id_data **datap);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime);
-int expr__find_other(const char *expr, const char *one,
+int expr__find_ids(const char *expr, const char *one,
 		struct expr_parse_ctx *ids, int runtime);
 
 double expr_id_data__value(const struct expr_id_data *data);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 014c0fd7d670..69cfd717ab05 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -851,7 +851,7 @@ static int __add_metric(struct list_head *metric_list,
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
2.30.0.284.gd98b1dd5eaa7-goog

