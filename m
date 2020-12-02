Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD12CB5DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgLBHlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgLBHlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:41:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3FC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:40:08 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b4so629502plr.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tz/5zZnlYQL7dRp04DjEhMIhE8kUjTgh/wD3tuIaA9k=;
        b=t+vexPxUqTi4KJp6u0Wl3yQRxDyqf9PhrbJ8yVKZAwEsAvmkTh2Ee26QvLPmU0ASX2
         lHHh/e2gGg0n5N36nk6H2ikt8jdo9F1gUE3pkaWjjSmqJGCGA0KljtleljmVUgZ2M2T0
         AjJic11RU5yHBcs6uPwrEN0Wzc1yAALzcIrQqN9WGk/Sld5YLARXwlhssSa94OyC2Ixh
         kWv7BCmZ6V8VI4nJoqRZ30Ymtb8xom7NApIeMZe4uK3bZ9XcWRvuvZajTtTrhWjx1xqV
         xG9bVvcB9kwwClr+WKqsgcRWtXK2BECrAyX6O1qSWOZpVtHStyyG8lKkuL4SNhpoIvff
         qZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tz/5zZnlYQL7dRp04DjEhMIhE8kUjTgh/wD3tuIaA9k=;
        b=C4nGWCFNjnYzJA04u/4HAy1EVX71IczMb89kvzpBxCmqdfMFC2hZrLzRBlP4WWOsz2
         oRBZPVsLC2XqpGogOd8/GQxiySoPDfR0V03TVEeiXc37WrccfkyokoKCzgwp4dIde38J
         XbwMhZhumpbSGUuWOY8x/T8ldmjnwNGX6VUj0sWIjtNKDkhoWTNhhKkw/xMeNFlAccci
         6LKewkCGbUaBFW3YEIX2OxlrM2IrnI37orzpchpwm8PCxXwkbryialuL53eJjfNuuCfc
         UH8DRZkeq+iFT2T3ukuoc3iBm+NTC/4+RmwQjU/DDzQ5JN9gTNexWftgTMCpUyBe0hFE
         rzBw==
X-Gm-Message-State: AOAM531OIrVpnGb+UMTL5UMSWbY2TOnOzjnBHZ0H8ELuZ6NHfKyiCZcA
        W8HplYak18NldgYWBWV8pirSCQw1Vg0P
X-Google-Smtp-Source: ABdhPJzYoDQwF6c9VPuoQHY7mJVDISsLTBox/GiJ45SFYR+Bmwgl1PESb8jRjj2LkACA0sGPFbdhaZuIRy7r
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr173967pja.0.1606894806882; Tue, 01 Dec 2020 23:40:06 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:39:53 -0800
In-Reply-To: <20201202073953.3811709-1-irogers@google.com>
Message-Id: <20201202073953.3811709-6-irogers@google.com>
Mime-Version: 1.0
References: <20201202073953.3811709-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 5/5] perf metric: Don't compute unused events.
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

For a metric like:
  EVENT1 if #smt_on else EVENT2

currently EVENT1 and EVENT2 will be measured and then when the metric is
reported EVENT1 or EVENT2 will be printed depending on the value from
smt_on() during the expr parsing. Computing both events is unnecessary and
can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies the expression parsing code by:
 - getting rid of the "other" parsing and introducing a boolean argument
   to say whether ids should be computed or not.
 - expressions are changed so that a pair of value and ids are returned.
 - when computing the metric value the ids are unused.
 - when computing the ids, constant values and smt_on are assigned to
   the value.
 - If the value is from an event ID then the event is added to the ids
   hashmap and the value set to bottom (encoded as NAN).
 - Typically operators union IDs for their inputs and set the value to
   bottom, however, if the inputs are constant then these are computed and
   propagated as the value.
 - If the input is constant to certain operators like:
 IDS1 if CONST else IDS2
   then the result will be either IDS1 or IDS2 depending on CONST (which
   may be evaluated from an entire expression), and so IDS1 or IDS2 may
   be discarded avoiding events from being programmed.
 - The ids at the end of parsing are added to the context.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c |  17 ++
 tools/perf/util/expr.c  |   9 +-
 tools/perf/util/expr.h  |   1 -
 tools/perf/util/expr.l  |   9 --
 tools/perf/util/expr.y  | 340 ++++++++++++++++++++++++++++++----------
 5 files changed, 282 insertions(+), 94 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 1c881bea7fca..5cab5960b257 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/smt.h"
 #include "tests.h"
 #include <stdlib.h>
 #include <string.h>
@@ -132,6 +133,22 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3/",
 						    (void **)&val_ptr));
 
+	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("EVENT1 if #smt_on else EVENT2",
+				NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+						  smt_on() ? "EVENT1" : "EVENT2",
+						  (void **)&val_ptr));
+
+	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("1.0 if EVENT1 > 100.0 else 1.0",
+				NULL, ctx, 0) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
 	expr__ctx_free(ctx);
 
 	return 0;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1adb6cd202e0..28aaa50c6c68 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -329,10 +329,9 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 
 static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
-	      int start, int runtime)
+	      bool compute_ids, int runtime)
 {
 	struct expr_scanner_ctx scanner_ctx = {
-		.start_token = start,
 		.runtime = runtime,
 	};
 	YY_BUFFER_STATE buffer;
@@ -352,7 +351,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	expr_set_debug(1, scanner);
 #endif
 
-	ret = expr_parse(val, ctx, scanner);
+	ret = expr_parse(val, ctx, compute_ids, scanner);
 
 	expr__flush_buffer(buffer, scanner);
 	expr__delete_buffer(buffer, scanner);
@@ -363,13 +362,13 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 		const char *expr, int runtime)
 {
-	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
+	return __expr__parse(final_val, ctx, expr, /*compute_ids=*/false, runtime) ? -1 : 0;
 }
 
 int expr__find_ids(const char *expr, const char *one,
 		   struct expr_parse_ctx *ctx, int runtime)
 {
-	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
+	int ret = __expr__parse(NULL, ctx, expr, /*compute_ids=*/true, runtime);
 
 	if (one)
 		expr__del_id(ctx, one);
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 62d3ae5ddfba..cefeb2c8d85e 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,7 +26,6 @@ struct expr_parse_ctx {
 struct expr_id_data;
 
 struct expr_scanner_ctx {
-	int start_token;
 	int runtime;
 };
 
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 13e5e3c75f56..702fdf6456ca 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -91,15 +91,6 @@ symbol		({spec}|{sym})+
 %%
 	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
 
-	{
-		int start_token = sctx->start_token;
-
-		if (sctx->start_token) {
-			sctx->start_token = 0;
-			return start_token;
-		}
-	}
-
 d_ratio		{ return D_RATIO; }
 max		{ return MAX; }
 min		{ return MIN; }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 41c9cd4efadd..907fe135c080 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,43 +1,55 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <assert.h>
 #include <math.h>
-#include <stdio.h>
-#include "util.h"
 #include "util/debug.h"
-#include <stdlib.h> // strtod()
+#include "smt.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
-#include "smt.h"
-#include <string.h>
-
-static double d_ratio(double val0, double val1)
-{
-	if (val1 == 0) {
-		return 0;
-	}
-	return  val0 / val1;
-}
-
 %}
 
 %define api.pure full
 
 %parse-param { double *final_val }
 %parse-param { struct expr_parse_ctx *ctx }
+%parse-param { bool compute_ids }
 %parse-param {void *scanner}
 %lex-param {void* scanner}
 
 %union {
 	double	 num;
 	char	*str;
+	struct ids {
+		/*
+		 * When creating ids, holds the working set of event ids. NULL
+		 * implies the set is empty.
+		 */
+		struct hashmap *ids;
+		/*
+		 * The metric value. When not creating ids this is the value
+		 * read from a counter, a constant or some computed value. When
+		 * creating ids the value is either a constant or BOTTOM. NAN is
+		 * used as the special BOTTOM value, representing a "set of all
+		 * values" case. Consider:
+		 *   1.0 if event1 > 50.0 else 2.0
+		 * The set of values {1.0, 2.0} is possible from this
+		 * expression, but we conservatively use BOTTOM to say any value
+		 * is possible. By tracking constants an expression like:
+		 *   1.0 if event1 > 50.0 else 1.0
+		 * can avoid computing event1 as only the value 1.0 is a
+		 * possible value.
+		 * It is much more likely we're evaluating:
+		 *   EVENT1 if #smt_on else EVENT2
+		 * where we don't want to compute two events, but we track
+		 * constants in a more general framework to allow for more
+		 * complicated expressions.
+		 */
+		double val;
+	} ids;
 }
 
-%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
-%token <num> NUMBER
-%token <str> ID
-%destructor { free ($$); } <str>
-%token MIN MAX IF ELSE SMT_ON D_RATIO
+%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -46,81 +58,251 @@ static double d_ratio(double val0, double val1)
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
-%type <num> expr if_expr
+%type <num> NUMBER
+%type <str> ID
+%destructor { free ($$); } <str>
+%type <ids> expr if_expr
+%destructor { ids__free($$.ids); } <ids>
 
 %{
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
+		       bool compute_ids __maybe_unused,
 		       void *scanner,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
 }
 
+/*
+ * During compute ids, the special "bottom" value uses NAN to represent the set
+ * of all values. NAN is selected as it isn't a useful constant value.
+ */
+#define BOTTOM NAN
+
+/* During computing ids, does val represent a constant (non-BOTTOM) value? */
+static bool is_const(double val)
+{
+	return isfinite(val);
+}
+
+static struct ids union_expr(struct ids ids1, struct ids ids2)
+{
+	struct ids result = {
+		.val = BOTTOM,
+		.ids = ids__union(ids1.ids, ids2.ids),
+	};
+	return result;
+}
+
+/*
+ * If we're not computing ids or $1 and $3 are constants, compute the new
+ * constant value using OP. Its invariant that there are no ids.  If computing
+ * ids for non-constants union the set of IDs that must be computed.
+ */
+#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
+		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
+		RESULT.ids = NULL;					\
+	} else {							\
+	        RESULT = union_expr(LHS, RHS);				\
+	}
+
+#define BINARY_OP(RESULT, OP, LHS, RHS)					\
+	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
+		assert(LHS.ids == NULL);				\
+		assert(RHS.ids == NULL);				\
+		RESULT.val = LHS.val OP RHS.val;			\
+		RESULT.ids = NULL;					\
+	} else {							\
+	        RESULT = union_expr(LHS, RHS);				\
+	}
+
 %}
 %%
 
-start:
-EXPR_PARSE all_expr
-|
-EXPR_OTHER all_other
+start: if_expr
+{
+	if (compute_ids)
+		ctx->ids = ids__union($1.ids, ctx->ids);
 
-all_other: all_other other
-|
+	if (final_val)
+		*final_val = $1.val;
+}
+;
+
+if_expr: expr IF expr ELSE expr
+{
+	if (fpclassify($3.val) == FP_ZERO) {
+		/*
+		 * The IF expression evaluated to 0 so treat as false, take the
+		 * ELSE and discard everything else.
+		 */
+		$$.val = $5.val;
+		$$.ids = $5.ids;
+		ids__free($1.ids);
+		ids__free($3.ids);
+	} else if (!compute_ids || is_const($3.val)) {
+		/*
+		 * If ids aren't computed then treat the expression as true. If
+		 * ids are being computed and the IF expr is a non-zero
+		 * constant, then also evaluate the true case.
+		 */
+		$$.val = $1.val;
+		$$.ids = $1.ids;
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else if ($1.val == $5.val) {
+		/*
+		 * LHS == RHS, so both are an identical constant. No need to
+		 * evaluate any events.
+		 */
+		$$.val = $1.val;
+		$$.ids = NULL;
+		ids__free($1.ids);
+		ids__free($3.ids);
+		ids__free($5.ids);
+	} else {
+		/*
+		 * Value is either the LHS or RHS and we need the IF expression
+		 * to compute it.
+		 */
+		$$ = union_expr($1, union_expr($3, $5));
+	}
+}
+| expr
+;
 
-other: ID
+expr: NUMBER
 {
-	expr__add_id(ctx, $1);
-}
-|
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-|
-'<' | '>' | D_RATIO
-
-all_expr: if_expr			{ *final_val = $1; }
-	;
-
-if_expr:
-	expr IF expr ELSE expr { $$ = $3 ? $1 : $5; }
-	| expr
-	;
-
-expr:	  NUMBER
-	| ID			{
-					struct expr_id_data *data;
-
-					$$ = NAN;
-					if (expr__resolve_id(ctx, $1, &data) == 0)
-						$$ = expr_id_data__value(data);
-
-					free($1);
-				}
-	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-	| expr '&' expr		{ $$ = (long)$1 & (long)$3; }
-	| expr '^' expr		{ $$ = (long)$1 ^ (long)$3; }
-	| expr '<' expr		{ $$ = $1 < $3; }
-	| expr '>' expr		{ $$ = $1 > $3; }
-	| expr '+' expr		{ $$ = $1 + $3; }
-	| expr '-' expr		{ $$ = $1 - $3; }
-	| expr '*' expr		{ $$ = $1 * $3; }
-	| expr '/' expr		{ if ($3 == 0) {
-					pr_debug("division by zero\n");
-					YYABORT;
-				  }
-				  $$ = $1 / $3;
-	                        }
-	| expr '%' expr		{ if ((long)$3 == 0) {
-					pr_debug("division by zero\n");
-					YYABORT;
-				  }
-				  $$ = (long)$1 % (long)$3;
-	                        }
-	| '-' expr %prec NEG	{ $$ = -$2; }
-	| '(' if_expr ')'	{ $$ = $2; }
-	| MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
-	| MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
-	| SMT_ON		 { $$ = smt_on() > 0; }
-	| D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
-	;
+	$$.val = $1;
+	$$.ids = NULL;
+}
+| ID
+{
+	if (!compute_ids) {
+		/*
+		 * Compute the event's value from ID. If the ID isn't known then
+		 * it isn't used to compute the formula so set to NAN.
+		 */
+		struct expr_id_data *data;
+
+		$$.val = NAN;
+		if (expr__resolve_id(ctx, $1, &data) == 0)
+			$$.val = expr_id_data__value(data);
+
+		$$.ids = NULL;
+		free($1);
+	} else {
+		/*
+		 * Set the value to BOTTOM to show that any value is possible
+		 * when the event is computed. Create a set of just the ID.
+		 */
+		$$.val = BOTTOM;
+		$$.ids = ids__new();
+		if (!$$.ids || ids__insert($$.ids, $1, ctx->parent))
+			YYABORT;
+	}
+}
+| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
+| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
+| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
+| expr '<' expr { BINARY_OP($$, <, $1, $3); }
+| expr '>' expr { BINARY_OP($$, >, $1, $3); }
+| expr '+' expr { BINARY_OP($$, +, $1, $3); }
+| expr '-' expr { BINARY_OP($$, -, $1, $3); }
+| expr '*' expr { BINARY_OP($$, *, $1, $3); }
+| expr '/' expr
+{
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = $1.val / $3.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($1, $3);
+	}
+}
+| expr '%' expr
+{
+	if (fpclassify($3.val) == FP_ZERO) {
+		pr_debug("division by zero\n");
+		YYABORT;
+	} else if (!compute_ids || (is_const($1.val) && is_const($3.val))) {
+		assert($1.ids == NULL);
+		assert($3.ids == NULL);
+		$$.val = (long)$1.val % (long)$3.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($1, $3);
+	}
+}
+| D_RATIO '(' expr ',' expr ')'
+{
+	if (fpclassify($5.val) == FP_ZERO) {
+		/*
+		 * Division by constant zero always yields zero and no events
+		 * are necessary.
+		 */
+		assert($5.ids == NULL);
+		$$.val = 0.0;
+		$$.ids = NULL;
+		ids__free($3.ids);
+	} else if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val / $5.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($3, $5);
+	}
+}
+| '-' expr %prec NEG
+{
+	$$.val = -$2.val;
+	$$.ids = $2.ids;
+}
+| '(' if_expr ')'
+{
+	$$ = $2;
+}
+| MIN '(' expr ',' expr ')'
+{
+	if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val < $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($3, $5);
+	}
+}
+| MAX '(' expr ',' expr ')'
+{
+	if (!compute_ids || (is_const($3.val) && is_const($5.val))) {
+		assert($3.ids == NULL);
+		assert($5.ids == NULL);
+		$$.val = $3.val > $5.val ? $3.val : $5.val;
+		$$.ids = NULL;
+	} else {
+		/* LHS and/or RHS need computing from event IDs so union. */
+		$$ = union_expr($3, $5);
+	}
+}
+| SMT_ON
+{
+	$$.val = smt_on() > 0 ? 1.0 : 0.0;
+	$$.ids = NULL;
+}
+;
 
 %%
-- 
2.29.2.454.gaff20da3a2-goog

