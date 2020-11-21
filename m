Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A242BBC92
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKUDL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKUDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:11:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:11:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v12so14408494ybi.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=o4vdiukrTIT9r2uZUpqqjbgpOYXnl64hK50Yn+dYnRE=;
        b=Np6PzfKEVyYxLQCNatd2XoYOPmmsVZxiqOp3BMA9F/ZaAciItbgmtiPP4ZQ1Ra9M1Q
         xgB8PKe4jaVWYqUmWjcxY19YK4w2IGM/+Dyg3CFJuMdcZezEGC5HYlN8HVG+PNUFbv6j
         dUZ6PCEhq62ItUKt8mzno8UCidLYtWR0rdXmZzRMXLn+W9Uug9R5FJvbn3YwhrDhrAAv
         GFC4Wkwoa7Ia9SivQSHMc3NVx6onBPNnhQmRDjkFdvNP6Kz+laTG6WNVWzQekFpnFvbp
         0k1ym4RHmkv+qG29v8Mkohl2kdgDhxoWwgHINEy96MyhTZuAms9MkPploW29tEyDrGSk
         4Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o4vdiukrTIT9r2uZUpqqjbgpOYXnl64hK50Yn+dYnRE=;
        b=CvQIsoJUOjDPMpwJW4vm9Bcl6RscMEl6A3IyZivJZkCngu8wXYjw91q7f3cu9NgdlE
         uJQbA/Vg39FwDUTUf56eed0TDc6l33IZ1F5FP4lz7MTeq+uXhGDfqX61SkpsolSmRSn3
         dw2gtJcnigW9s8MZLYuoAoPdAMjar31C3bct4F7S5/qckhB92Zotq5zDINMY4lybe+G8
         czD4xvIoRbqmCuXWvlCxDmwGwBb3c+f/YT0U9wpmwhMEFphGx+4Ks6ToGcqng3L5RwzC
         rgJ36V9SOswkUNB5pE++XexVa0414Rv4F4tC3liHk039heSksteGoxUdCDtdX6SJ8il/
         HzaA==
X-Gm-Message-State: AOAM531Kkjy2lP7mBpY9HIFnbzJvvWgcjlUsn81XjFJ3vKxeHWcCtUq6
        3QyeBb/GF60pBkrUo8wPfZyiEMCms1Fi
X-Google-Smtp-Source: ABdhPJxUAZn6u8ePsOztNXmHIDPphdE8yIlHuHlvMMyfo4MiLJPI7CZfF16sAfjzZPL44tqonfw7RPY6z8/t
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:848e:: with SMTP id
 v14mr23871615ybk.153.1605928285103; Fri, 20 Nov 2020 19:11:25 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:11:15 -0800
In-Reply-To: <20201121031119.3554769-1-irogers@google.com>
Message-Id: <20201121031119.3554769-2-irogers@google.com>
Mime-Version: 1.0
References: <20201121031119.3554769-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 1/5] perf metric: Restructure struct expr_parse_ctx.
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

A later change to parsing the ids out (in expr__find_other) will
potentially drop hashmaps and so it is more convenient to move
expr_parse_ctx to have a hashmap pointer rather than a struct value. As
this pointer must be freed, rather than just going out of scope,
add expr__ctx_new and expr__ctx_free to manage expr_parse_ctx memory.
Adjust use of struct expr_parse_ctx accordingly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 81 ++++++++++++++++++-----------------
 tools/perf/tests/pmu-events.c | 37 +++++++++-------
 tools/perf/util/expr.c        | 38 ++++++++++++----
 tools/perf/util/expr.h        |  5 ++-
 tools/perf/util/metricgroup.c | 44 ++++++++++---------
 tools/perf/util/stat-shadow.c | 50 +++++++++++++--------
 6 files changed, 151 insertions(+), 104 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 4d01051951cd..b0a3b5fd0c00 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -22,67 +22,70 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	const char *p;
 	double val;
 	int ret;
-	struct expr_parse_ctx ctx;
+	struct expr_parse_ctx *ctx;
 
-	expr__ctx_init(&ctx);
-	expr__add_id_val(&ctx, strdup("FOO"), 1);
-	expr__add_id_val(&ctx, strdup("BAR"), 2);
+	ctx = expr__ctx_new();
+	TEST_ASSERT_VAL("expr__ctx_new", ctx);
+	expr__add_id_val(ctx, strdup("FOO"), 1);
+	expr__add_id_val(ctx, strdup("BAR"), 2);
 
-	ret = test(&ctx, "1+1", 2);
-	ret |= test(&ctx, "FOO+BAR", 3);
-	ret |= test(&ctx, "(BAR/2)%2", 1);
-	ret |= test(&ctx, "1 - -4",  5);
-	ret |= test(&ctx, "(FOO-1)*2 + (BAR/2)%2 - -4",  5);
-	ret |= test(&ctx, "1-1 | 1", 1);
-	ret |= test(&ctx, "1-1 & 1", 0);
-	ret |= test(&ctx, "min(1,2) + 1", 2);
-	ret |= test(&ctx, "max(1,2) + 1", 3);
-	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
-	ret |= test(&ctx, "1.1 + 2.1", 3.2);
-	ret |= test(&ctx, ".1 + 2.", 2.1);
-	ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
-	ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
-	ret |= test(&ctx, "1.1 < 2.2", 1);
-	ret |= test(&ctx, "2.2 > 1.1", 1);
-	ret |= test(&ctx, "1.1 < 1.1", 0);
-	ret |= test(&ctx, "2.2 > 2.2", 0);
-	ret |= test(&ctx, "2.2 < 1.1", 0);
-	ret |= test(&ctx, "1.1 > 2.2", 0);
+	ret = test(ctx, "1+1", 2);
+	ret |= test(ctx, "FOO+BAR", 3);
+	ret |= test(ctx, "(BAR/2)%2", 1);
+	ret |= test(ctx, "1 - -4",  5);
+	ret |= test(ctx, "(FOO-1)*2 + (BAR/2)%2 - -4",  5);
+	ret |= test(ctx, "1-1 | 1", 1);
+	ret |= test(ctx, "1-1 & 1", 0);
+	ret |= test(ctx, "min(1,2) + 1", 2);
+	ret |= test(ctx, "max(1,2) + 1", 3);
+	ret |= test(ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(ctx, "1.1 + 2.1", 3.2);
+	ret |= test(ctx, ".1 + 2.", 2.1);
+	ret |= test(ctx, "d_ratio(1, 2)", 0.5);
+	ret |= test(ctx, "d_ratio(2.5, 0)", 0);
+	ret |= test(ctx, "1.1 < 2.2", 1);
+	ret |= test(ctx, "2.2 > 1.1", 1);
+	ret |= test(ctx, "1.1 < 1.1", 0);
+	ret |= test(ctx, "2.2 > 2.2", 0);
+	ret |= test(ctx, "2.2 < 1.1", 0);
+	ret |= test(ctx, "1.1 > 2.2", 0);
 
-	if (ret)
+	if (ret) {
+		expr__ctx_free(ctx);
 		return ret;
+	}
 
 	p = "FOO/0";
-	ret = expr__parse(&val, &ctx, p, 1);
+	ret = expr__parse(&val, ctx, p, 1);
 	TEST_ASSERT_VAL("division by zero", ret == -1);
 
 	p = "BAR/";
-	ret = expr__parse(&val, &ctx, p, 1);
+	ret = expr__parse(&val, ctx, p, 1);
 	TEST_ASSERT_VAL("missing operand", ret == -1);
 
-	expr__ctx_clear(&ctx);
+	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find other",
 			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO",
-					 &ctx, 1) == 0);
-	TEST_ASSERT_VAL("find other", hashmap__size(&ctx.ids) == 3);
-	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "BAR",
+					 ctx, 1) == 0);
+	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 3);
+	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAR",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "BAZ",
+	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BAZ",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "BOZO",
+	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "BOZO",
 						    (void **)&val_ptr));
 
-	expr__ctx_clear(&ctx);
+	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find other",
 			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
-					 NULL, &ctx, 3) == 0);
-	TEST_ASSERT_VAL("find other", hashmap__size(&ctx.ids) == 2);
-	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "EVENT1,param=3/",
+					 NULL, ctx, 3) == 0);
+	TEST_ASSERT_VAL("find other", hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT1,param=3/",
 						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "EVENT2,param=3/",
+	TEST_ASSERT_VAL("find other", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
-	expr__ctx_clear(&ctx);
+	expr__ctx_free(ctx);
 
 	return 0;
 }
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ad2b21591275..294daf568bb6 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -478,9 +478,14 @@ static int test_parsing(void)
 	struct pmu_event *pe;
 	int i, j, k;
 	int ret = 0;
-	struct expr_parse_ctx ctx;
+	struct expr_parse_ctx *ctx;
 	double result;
 
+	ctx = expr__ctx_new();
+	if (!ctx) {
+		pr_debug("expr__ctx_new failed");
+		return TEST_FAIL;
+	}
 	i = 0;
 	for (;;) {
 		map = &pmu_events_map[i++];
@@ -496,8 +501,8 @@ static int test_parsing(void)
 				break;
 			if (!pe->metric_expr)
 				continue;
-			expr__ctx_init(&ctx);
-			if (expr__find_other(pe->metric_expr, NULL, &ctx, 0)
+			expr__ctx_clear(ctx);
+			if (expr__find_other(pe->metric_expr, NULL, ctx, 0)
 				  < 0) {
 				expr_failure("Parse other failed", map, pe);
 				ret++;
@@ -510,22 +515,22 @@ static int test_parsing(void)
 			 * make them unique.
 			 */
 			k = 1;
-			hashmap__for_each_entry((&ctx.ids), cur, bkt)
-				expr__add_id_val(&ctx, strdup(cur->key), k++);
+			hashmap__for_each_entry(ctx->ids, cur, bkt)
+				expr__add_id_val(ctx, strdup(cur->key), k++);
 
-			hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+			hashmap__for_each_entry(ctx->ids, cur, bkt) {
 				if (check_parse_cpu(cur->key, map == cpus_map,
 						   pe))
 					ret++;
 			}
 
-			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
+			if (expr__parse(&result, ctx, pe->metric_expr, 0)) {
 				expr_failure("Parse failed", map, pe);
 				ret++;
 			}
-			expr__ctx_clear(&ctx);
 		}
 	}
+	expr__ctx_free(ctx);
 	/* TODO: fail when not ok */
 	return ret == 0 ? TEST_OK : TEST_SKIP;
 }
@@ -544,7 +549,7 @@ static struct test_metric metrics[] = {
 
 static int metric_parse_fake(const char *str)
 {
-	struct expr_parse_ctx ctx;
+	struct expr_parse_ctx *ctx;
 	struct hashmap_entry *cur;
 	double result;
 	int ret = -1;
@@ -553,8 +558,8 @@ static int metric_parse_fake(const char *str)
 
 	pr_debug("parsing '%s'\n", str);
 
-	expr__ctx_init(&ctx);
-	if (expr__find_other(str, NULL, &ctx, 0) < 0) {
+	ctx = expr__ctx_new();
+	if (expr__find_other(str, NULL, ctx, 0) < 0) {
 		pr_err("expr__find_other failed\n");
 		return -1;
 	}
@@ -565,23 +570,23 @@ static int metric_parse_fake(const char *str)
 	 * make them unique.
 	 */
 	i = 1;
-	hashmap__for_each_entry((&ctx.ids), cur, bkt)
-		expr__add_id_val(&ctx, strdup(cur->key), i++);
+	hashmap__for_each_entry(ctx->ids, cur, bkt)
+		expr__add_id_val(ctx, strdup(cur->key), i++);
 
-	hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		if (check_parse_fake(cur->key)) {
 			pr_err("check_parse_fake failed\n");
 			goto out;
 		}
 	}
 
-	if (expr__parse(&result, &ctx, str, 1))
+	if (expr__parse(&result, ctx, str, 1))
 		pr_err("expr__parse failed\n");
 	else
 		ret = 0;
 
 out:
-	expr__ctx_clear(&ctx);
+	expr__ctx_free(ctx);
 	return ret;
 }
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index a850fd0be3ee..e0623d38e6ee 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -73,7 +73,7 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
 	data_ptr->parent = ctx->parent;
 	data_ptr->kind = EXPR_ID_DATA__PARENT;
 
-	ret = hashmap__set(&ctx->ids, id, data_ptr,
+	ret = hashmap__set(ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	if (ret)
 		free(data_ptr);
@@ -95,7 +95,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	data_ptr->val = val;
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
-	ret = hashmap__set(&ctx->ids, id, data_ptr,
+	ret = hashmap__set(ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	if (ret)
 		free(data_ptr);
@@ -140,7 +140,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	data_ptr->ref.metric_expr = ref->metric_expr;
 	data_ptr->kind = EXPR_ID_DATA__REF;
 
-	ret = hashmap__set(&ctx->ids, name, data_ptr,
+	ret = hashmap__set(ctx->ids, name, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	if (ret)
 		free(data_ptr);
@@ -156,7 +156,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data)
 {
-	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
+	return hashmap__find(ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
 int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
@@ -205,15 +205,23 @@ void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
 	struct expr_id_data *old_val = NULL;
 	char *old_key = NULL;
 
-	hashmap__delete(&ctx->ids, id,
+	hashmap__delete(ctx->ids, id,
 			(const void **)&old_key, (void **)&old_val);
 	free(old_key);
 	free(old_val);
 }
 
-void expr__ctx_init(struct expr_parse_ctx *ctx)
+struct expr_parse_ctx *expr__ctx_new(void)
 {
-	hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
+	struct expr_parse_ctx *ctx;
+
+	ctx = malloc(sizeof(struct expr_parse_ctx));
+	if (!ctx)
+		return NULL;
+
+	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
+	ctx->parent = NULL;
+	return ctx;
 }
 
 void expr__ctx_clear(struct expr_parse_ctx *ctx)
@@ -221,11 +229,23 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx)
 	struct hashmap_entry *cur;
 	size_t bkt;
 
-	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+		free((char *)cur->key);
+		free(cur->value);
+	}
+	hashmap__clear(ctx->ids);
+}
+
+void expr__ctx_free(struct expr_parse_ctx *ctx)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		free((char *)cur->key);
 		free(cur->value);
 	}
-	hashmap__clear(&ctx->ids);
+	hashmap__free(ctx->ids);
 }
 
 static int
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index dcf8d19b83c8..00b941cfe6a6 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -19,7 +19,7 @@ struct expr_id {
 };
 
 struct expr_parse_ctx {
-	struct hashmap	 ids;
+	struct hashmap	*ids;
 	struct expr_id	*parent;
 };
 
@@ -30,8 +30,9 @@ struct expr_scanner_ctx {
 	int runtime;
 };
 
-void expr__ctx_init(struct expr_parse_ctx *ctx);
+struct expr_parse_ctx *expr__ctx_new(void);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+void expr__ctx_free(struct expr_parse_ctx *ctx);
 void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 81d201c8b833..342dcccb860f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -118,7 +118,7 @@ struct metric_ref_node {
 
 struct metric {
 	struct list_head nd;
-	struct expr_parse_ctx pctx;
+	struct expr_parse_ctx *pctx;
 	const char *metric_name;
 	const char *metric_expr;
 	const char *metric_unit;
@@ -190,7 +190,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	struct evsel *ev, *current_leader = NULL;
 	struct expr_id_data *val_ptr;
 	int i = 0, matched_events = 0, events_to_match;
-	const int idnum = (int)hashmap__size(&pctx->ids);
+	const int idnum = (int)hashmap__size(pctx->ids);
 
 	/*
 	 * duration_time is always grouped separately, when events are grouped
@@ -198,7 +198,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	 * add it to metric_events at the end.
 	 */
 	if (!has_constraint &&
-	    hashmap__find(&pctx->ids, "duration_time", (void **)&val_ptr))
+	    hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
 		events_to_match = idnum - 1;
 	else
 		events_to_match = idnum;
@@ -234,7 +234,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		if (contains_event(metric_events, matched_events, ev->name))
 			continue;
 		/* Does this event belong to the parse context? */
-		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr))
+		if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
 			metric_events[matched_events++] = ev;
 
 		if (matched_events == events_to_match)
@@ -313,12 +313,12 @@ static int metricgroup__setup_events(struct list_head *groups,
 		struct metric_ref *metric_refs = NULL;
 
 		metric_events = calloc(sizeof(void *),
-				hashmap__size(&m->pctx.ids) + 1);
+				hashmap__size(m->pctx->ids) + 1);
 		if (!metric_events) {
 			ret = -ENOMEM;
 			break;
 		}
-		evsel = find_evsel_group(perf_evlist, &m->pctx,
+		evsel = find_evsel_group(perf_evlist, m->pctx,
 					 metric_no_merge,
 					 m->has_constraint, metric_events,
 					 evlist_used);
@@ -606,7 +606,7 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 	size_t bkt;
 	bool no_group = true, has_duration = false;
 
-	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		pr_debug("found event %s\n", (const char *)cur->key);
 		/*
 		 * Duration time maps to a software event and can make
@@ -637,7 +637,7 @@ static void metricgroup__add_metric_non_group(struct strbuf *events,
 	size_t bkt;
 	bool first = true;
 
-	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		if (!first)
 			strbuf_addf(events, ",");
 		strbuf_addf(events, "%s", (const char *)cur->key);
@@ -703,7 +703,11 @@ static int __add_metric(struct list_head *metric_list,
 		if (!m)
 			return -ENOMEM;
 
-		expr__ctx_init(&m->pctx);
+		m->pctx = expr__ctx_new();
+		if (!m->pctx) {
+			free(m);
+			return -ENOMEM;
+		}
 		m->metric_name = pe->metric_name;
 		m->metric_expr = pe->metric_expr;
 		m->metric_unit = pe->unit;
@@ -751,15 +755,15 @@ static int __add_metric(struct list_head *metric_list,
 
 	/* Force all found IDs in metric to have us as parent ID. */
 	WARN_ON_ONCE(!parent);
-	m->pctx.parent = parent;
+	m->pctx->parent = parent;
 
 	/*
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_other(pe->metric_expr, NULL, &m->pctx, runtime) < 0) {
+	if (expr__find_other(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
 		if (m->metric_refs_cnt == 0) {
-			expr__ctx_clear(&m->pctx);
+			expr__ctx_free(m->pctx);
 			free(m);
 			*mp = NULL;
 		}
@@ -782,8 +786,8 @@ static int __add_metric(struct list_head *metric_list,
 		list_for_each_prev(pos, metric_list) {
 			struct metric *old = list_entry(pos, struct metric, nd);
 
-			if (hashmap__size(&m->pctx.ids) <=
-			    hashmap__size(&old->pctx.ids))
+			if (hashmap__size(m->pctx->ids) <=
+			    hashmap__size(old->pctx->ids))
 				break;
 		}
 		list_add(&m->nd, pos);
@@ -829,7 +833,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	 * if we already processed 'id', if we did, it's recursion
 	 * and we fail.
 	 */
-	ret = expr__get_id(&m->pctx, id, &data);
+	ret = expr__get_id(m->pctx, id, &data);
 	if (ret)
 		return ret;
 
@@ -884,7 +888,7 @@ static int __resolve_metric(struct metric *m,
 	 */
 	do {
 		all = true;
-		hashmap__for_each_entry((&m->pctx.ids), cur, bkt) {
+		hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
 			struct expr_id *parent;
 			struct pmu_event *pe;
 
@@ -898,7 +902,7 @@ static int __resolve_metric(struct metric *m,
 
 			all = false;
 			/* The metric key itself needs to go out.. */
-			expr__del_id(&m->pctx, cur->key);
+			expr__del_id(m->pctx, cur->key);
 
 			/* ... and it gets resolved to the parent context. */
 			ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
@@ -1005,10 +1009,10 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 		if (m->has_constraint) {
 			metricgroup__add_metric_non_group(events,
-							  &m->pctx);
+							  m->pctx);
 		} else {
 			metricgroup__add_metric_weak_group(events,
-							   &m->pctx);
+							   m->pctx);
 		}
 	}
 
@@ -1071,7 +1075,7 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
 
 	list_for_each_entry_safe (m, tmp, metric_list, nd) {
 		metric__free_refs(m);
-		expr__ctx_clear(&m->pctx);
+		expr__ctx_free(m->pctx);
 		list_del_init(&m->nd);
 		free(m);
 	}
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 901265127e36..bea7b5c6b1c0 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <math.h>
 #include <stdio.h>
 #include "evsel.h"
 #include "stat.h"
 #include "color.h"
+#include "debug.h"
 #include "pmu.h"
 #include "rblist.h"
 #include "evlist.h"
@@ -335,12 +337,16 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 {
 	struct evsel *counter, *leader, **metric_events, *oc;
 	bool found;
-	struct expr_parse_ctx ctx;
+	struct expr_parse_ctx *ctx;
 	struct hashmap_entry *cur;
 	size_t bkt;
 	int i;
 
-	expr__ctx_init(&ctx);
+	ctx = expr__ctx_new();
+	if (!ctx) {
+		pr_debug("expr__ctx_new failed");
+		return;
+	}
 	evlist__for_each_entry(evsel_list, counter) {
 		bool invalid = false;
 
@@ -348,25 +354,25 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 		if (!counter->metric_expr)
 			continue;
 
-		expr__ctx_clear(&ctx);
+		expr__ctx_clear(ctx);
 		metric_events = counter->metric_events;
 		if (!metric_events) {
 			if (expr__find_other(counter->metric_expr,
 					     counter->name,
-					     &ctx, 1) < 0)
+					     ctx, 1) < 0)
 				continue;
 
 			metric_events = calloc(sizeof(struct evsel *),
-					       hashmap__size(&ctx.ids) + 1);
+					       hashmap__size(ctx->ids) + 1);
 			if (!metric_events) {
-				expr__ctx_clear(&ctx);
+				expr__ctx_free(ctx);
 				return;
 			}
 			counter->metric_events = metric_events;
 		}
 
 		i = 0;
-		hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+		hashmap__for_each_entry(ctx->ids, cur, bkt) {
 			const char *metric_name = (const char *)cur->key;
 
 			found = false;
@@ -418,7 +424,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 			counter->metric_expr = NULL;
 		}
 	}
-	expr__ctx_clear(&ctx);
+	expr__ctx_free(ctx);
 }
 
 static double runtime_stat_avg(struct runtime_stat *st,
@@ -793,7 +799,6 @@ static int prepare_metric(struct evsel **metric_events,
 	char *n, *pn;
 	int i, j, ret;
 
-	expr__ctx_init(pctx);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -854,17 +859,22 @@ static void generic_metric(struct perf_stat_config *config,
 			   struct runtime_stat *st)
 {
 	print_metric_t print_metric = out->print_metric;
-	struct expr_parse_ctx pctx;
+	struct expr_parse_ctx *pctx;
 	double ratio, scale;
 	int i;
 	void *ctxp = out->ctx;
 
-	i = prepare_metric(metric_events, metric_refs, &pctx, cpu, st);
-	if (i < 0)
+	pctx = expr__ctx_new();
+	if (!pctx)
 		return;
 
+	i = prepare_metric(metric_events, metric_refs, pctx, cpu, st);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return;
+	}
 	if (!metric_events[i]) {
-		if (expr__parse(&ratio, &pctx, metric_expr, runtime) == 0) {
+		if (expr__parse(&ratio, pctx, metric_expr, runtime) == 0) {
 			char *unit;
 			char metric_bf[64];
 
@@ -900,22 +910,26 @@ static void generic_metric(struct perf_stat_config *config,
 			     (metric_name ? metric_name : name) : "", 0);
 	}
 
-	expr__ctx_clear(&pctx);
+	expr__ctx_free(pctx);
 }
 
 double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
 {
-	struct expr_parse_ctx pctx;
+	struct expr_parse_ctx *pctx;
 	double ratio = 0.0;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
+	pctx = expr__ctx_new();
+	if (!pctx)
+		return NAN;
+
+	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu, st) < 0)
 		goto out;
 
-	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
+	if (expr__parse(&ratio, pctx, mexp->metric_expr, 1))
 		ratio = 0.0;
 
 out:
-	expr__ctx_clear(&pctx);
+	expr__ctx_free(pctx);
 	return ratio;
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

