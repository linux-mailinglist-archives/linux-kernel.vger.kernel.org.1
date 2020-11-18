Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615752B758C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKRFDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRFDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:03:47 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41EC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:03:45 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z68so495616pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vGdxQHqtpriKkfthftM5p2GKc/XM2K+zaCfAHe4o9VE=;
        b=PbNwL3SN8jkxJU6aTvWM84Y/M/KjekWLP4CucXxZuWNxCc8mUNUAXKeQkwoSCbHtrC
         rr7AcCp9YAHX27bi77k1nCn43v7l0oy6QdQBvbliqq+A/21tAm9L+MXcGAyL8SNt8IuQ
         u4L11Dt9dvLI5ZmwjC8lEFuFQzNR4+kWstmuDCvraHhi0FZ6B26pBbpFCpbp0pZciz4m
         LXJYkAkk0LShtZ5M66hHxYRIKUyjsajuQ070du91ZjNxzhjMisFtDedBVLLcl+5Mc6L+
         dqXyE8wdJx4som03r3CeXsakFPh6mgFvZVlLgLTHJ3TxsRnZ1qiVnIy8lmfTmnBOsGMR
         9wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vGdxQHqtpriKkfthftM5p2GKc/XM2K+zaCfAHe4o9VE=;
        b=IRUlvDhpUppDn/EBb+lhqM9CWTNYRjfQYThMtu6hVDrOa4Y0zUQoa5wtQVmbAFMbb/
         uHDtsDbyH4Ex+tUOgqOmX8UKmb+A6TsuowF50xB9LrJ7h2qi7l561XVvPvknvzB2urvJ
         GxJOhzg5A7rORqn8fP9UIC2SfRzznGgYHufspclarn9Eg2n97IQ9KSQqYypqbq24kE1B
         6ebNkEusRxoYl9Xd1EfqQ3+hBlDxroCPH8K87+fWiRcLkSyCu4evqzFuTiRgmWEE9ghc
         +CBHVyHZO2Gse2Co8pkakX0gIfXouEaPLCUuX5gRWO5K8swarjkegQLpCJauY2WnozV+
         N8TQ==
X-Gm-Message-State: AOAM533xPFMPf+o3ZiG/JOKPaaFNed7l773Dvi71aKKVRav6tEWJcrFa
        vbms0V9N+eMnN4uSdnIsJMLO0IyzRUJf
X-Google-Smtp-Source: ABdhPJx32TWQrQpd0xiLh2PfwIkaB41Fzsl4VTfOYFyyGG3VEFnW7yAIyELeyu41MOF6WpWqdX5aWnLdKHrA
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:d250:: with SMTP id
 o16mr2339649pjw.25.1605675825201; Tue, 17 Nov 2020 21:03:45 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:03:33 -0800
In-Reply-To: <20201118050335.2347358-1-irogers@google.com>
Message-Id: <20201118050335.2347358-4-irogers@google.com>
Mime-Version: 1.0
References: <20201118050335.2347358-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 3/5] perf metric: Rename expr__find_other.
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
index e0623d38e6ee..a248d14882cc 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -287,8 +287,8 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
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
index 342dcccb860f..0be684bb020f 100644
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

