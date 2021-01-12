Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E552F3FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395057AbhALW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395029AbhALW72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:59:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B22C0617A3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:18 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d6so2319735plr.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T+7yj9tUVip2lBODTehWsL2UJpckgzebTv3QLqXLE6g=;
        b=mo1wCX4eNj2EvUQYY2pu7KlvWM8nLZWL7x4JX1pWrks2FL5YhKysvP8e7vYPkvC50g
         v5H6vp3sT8hvjXGY9ZHa1P61/5JbvQMkyr1VK5hmghURKPX55fOiyRMFEwqxNG0o0fVX
         ljaf+X9YIHSyM9HTGdWhjQDpi2ncJv+4/PasuRxpGBllelkkb4P+x/BRL36jsGFEUiYq
         JwJzJ03bb7Qx14GFt/I49DpMrk1C4EAOWjnvWzB8yGJEIgIZlQaRTwGbq1NaENI1+Rsv
         NVWtfSEWe+y8iBptqMvMRIs2P1wIyw77m97XlZziEfSEgvZNWan/ulAj58s8ufRoPBvW
         KZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T+7yj9tUVip2lBODTehWsL2UJpckgzebTv3QLqXLE6g=;
        b=iKCXHE9ZAafzCTcdE3aRvOcakZ1wfdOag4P2q1ccKwSGvY6Iq/t5bFomqVfutMEjA8
         OyykXdaeQLhtrw6SS61CBHIih6Yoi6VmQ19qtUwVoNIQwgSbwIVW3nS5yo7AN+KclnH8
         +93Ba+ym8TUOXf3j8m6sLban8IKPjZXZ5c4akE1S1PsPVn9ahQKHDCa58rLj6Ke2xxY0
         NAXcsKt05/OJgvIQRQ0gunxqFSOhNyiLiYDSOQc4aW6QkhisD3K34QK9JbptAJPwRwkv
         XnqOfF1syvueZE5lSQO0H1xDhNivnPm2MQsMT5SgyTk1SagwXZwPsVHDj3Yvwmyg8WHr
         GhwQ==
X-Gm-Message-State: AOAM531+HJBNFzeXvBkoOUi7rNY24FN4CJ0VDDdelz2PZ8B9qOamvDqU
        r5TExAijIBg1cmPVhPyvb4QN5wq8++OZ
X-Google-Smtp-Source: ABdhPJxERoXS972b9Br6SMQSg2kAk+jMfoSZvlmJzEZiqjCE73+CVaHCC0pi1LJ0iOSC51+jMXiUEDZOmtwE
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:902:9a03:b029:dc:31af:8dc2 with SMTP
 id v3-20020a1709029a03b02900dc31af8dc2mr1212924plp.39.1610492297677; Tue, 12
 Jan 2021 14:58:17 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:58:02 -0800
In-Reply-To: <20210112225802.2613039-1-irogers@google.com>
Message-Id: <20210112225802.2613039-6-irogers@google.com>
Mime-Version: 1.0
References: <20210112225802.2613039-1-irogers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v6 5/5] perf metric: Don't compute unused events.
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
 tools/perf/util/expr.c  |  10 +-
 tools/perf/util/expr.h  |   1 -
 tools/perf/util/expr.l  |   9 --
 tools/perf/util/expr.y  | 340 ++++++++++++++++++++++++++++++----------
 5 files changed, 283 insertions(+), 94 deletions(-)

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
index 1adb6cd202e0..e9396a309fb7 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -325,14 +325,14 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 		free(cur->value);
 	}
 	hashmap__free(ctx->ids);
+	free(ctx);
 }
 
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
@@ -352,7 +352,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	expr_set_debug(1, scanner);
 #endif
 
-	ret = expr_parse(val, ctx, scanner);
+	ret = expr_parse(val, ctx, compute_ids, scanner);
 
 	expr__flush_buffer(buffer, scanner);
 	expr__delete_buffer(buffer, scanner);
@@ -363,13 +363,13 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
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
index f201889d1136..0d08b34285ba 100644
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
2.30.0.284.gd98b1dd5eaa7-goog

