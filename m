Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F316D252641
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 06:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHZE3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 00:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHZE3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:29:15 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4921C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:29:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c67so572826qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=e2sthLChL56CJC3JcU1bN90aRQyj9LySBce8eSFPDRQ=;
        b=ZfeljoJgdAap9byIHIint/gzU7sEuB5x4h9+SYb3crYeFbbA1NFL/brKFik8vIK3a3
         yD1QdgacNapvaxAScMoJnauD+D9rPVRgDB8vm6DloZuXRnOffHJggPmxqGj0QlLuuJLs
         LwHFOv/WTd6z9j4jsx46jrKTCMA7PlUfws5gD+LIdbThT3IkYwXoh0Ml6ivqPRbkwOEf
         pCOWWiZHc0LI+mzaJaiuSTKFnSiw8JuAigKuIjY0c2Ja3l5QW1R516rYft1866NqLkJI
         OJjehycNrf9BnYd7JQwjpraqZmlorSd0KgdXDCeBvYk7bDA6Y7FhQvnC6+XbTTNWRryL
         QaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=e2sthLChL56CJC3JcU1bN90aRQyj9LySBce8eSFPDRQ=;
        b=OH2LQWn30eonzLdTpVSUY8YBGYMCUXiMgNp5Jud7ku9NhiOw/cHoKQi8fqp1uXCIBG
         R5COfP76Dlfa0H66RDrBWYE/bU7IV+p8niXLf0i+3aHM2v6+1WEXc9BHpSUKKWV7zM6T
         ejLYHi5yLHy8pC4MlYY+JJprVeKMirgTXwshvmQCMElPi+AHmGSpqq3wiz/MHQD1rKy3
         9PIUqjvO3+iVMEBf6/iLI6kBjEPt4GUhMZbBysdZ203PIGEJ3vdpJiYdjiqNB0ldV6nJ
         ePj8/m5Vjl1Az/rIGjcEA1Z6hvivqIqa3ZzYieC1ORjHpz+eqSlteEziEDG8iZqcxLUS
         Is9A==
X-Gm-Message-State: AOAM531xTms53VHMyEdQInDHtBFOiF7zZsNdCjoCu9o3POFzubhTUyeG
        QUc7aubR7P3kY6pZmOJ/lGzm1L8/pPaJ
X-Google-Smtp-Source: ABdhPJwhtThJ2l1VTxtlAD92hKu424560dbu+JG7twten6GlJpZWpVn3f4xWeSGiL+y3Vsq6zjYGqtDK6S0t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:f849:: with SMTP id
 g9mr12698699qvo.80.1598416154530; Tue, 25 Aug 2020 21:29:14 -0700 (PDT)
Date:   Tue, 25 Aug 2020 21:29:09 -0700
Message-Id: <20200826042910.1902374-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 1/2] perf expr: Force encapsulation on expr_id_data
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves some undefined behavior where variables in
expr_id_data were accessed (for debugging) without being defined. To
better enforce the tagged union behavior, the struct is moved into
expr.c and accessors provided. Tag values (kinds) are explicitly
identified.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c        | 64 ++++++++++++++++++++++++++++++-----
 tools/perf/util/expr.h        | 17 +++-------
 tools/perf/util/expr.y        |  2 +-
 tools/perf/util/metricgroup.c |  4 +--
 4 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 53482ef53c41..1ca0992db86b 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -17,6 +17,25 @@
 extern int expr_debug;
 #endif
 
+struct expr_id_data {
+	union {
+		double val;
+		struct {
+			double val;
+			const char *metric_name;
+			const char *metric_expr;
+		} ref;
+		struct expr_id	*parent;
+	};
+
+	enum {
+		EXPR_ID_DATA__VALUE,
+		EXPR_ID_DATA__REF,
+		EXPR_ID_DATA__REF_VALUE,
+		EXPR_ID_DATA__PARENT,
+	} kind;
+};
+
 static size_t key_hash(const void *key, void *ctx __maybe_unused)
 {
 	const char *str = (const char *)key;
@@ -48,6 +67,7 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
 		return -ENOMEM;
 
 	data_ptr->parent = ctx->parent;
+	data_ptr->kind = EXPR_ID_DATA__PARENT;
 
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -69,7 +89,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	if (!data_ptr)
 		return -ENOMEM;
 	data_ptr->val = val;
-	data_ptr->is_ref = false;
+	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -114,8 +134,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	 */
 	data_ptr->ref.metric_name = ref->metric_name;
 	data_ptr->ref.metric_expr = ref->metric_expr;
-	data_ptr->ref.counted = false;
-	data_ptr->is_ref = true;
+	data_ptr->kind = EXPR_ID_DATA__REF;
 
 	ret = hashmap__set(&ctx->ids, name, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
@@ -148,17 +167,30 @@ int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
 
 	data = *datap;
 
-	pr_debug2("lookup: is_ref %d, counted %d, val %f: %s\n",
-		  data->is_ref, data->ref.counted, data->val, id);
-
-	if (data->is_ref && !data->ref.counted) {
-		data->ref.counted = true;
+	switch (data->kind) {
+	case EXPR_ID_DATA__VALUE:
+		pr_debug2("lookup(%s): val %f\n", id, data->val);
+		break;
+	case EXPR_ID_DATA__PARENT:
+		pr_debug2("lookup(%s): parent %s\n", id, data->parent->id);
+		break;
+	case EXPR_ID_DATA__REF:
+		pr_debug2("lookup(%s): ref metric name %s\n", id,
+			data->ref.metric_name);
 		pr_debug("processing metric: %s ENTRY\n", id);
-		if (expr__parse(&data->val, ctx, data->ref.metric_expr, 1)) {
+		data->kind = EXPR_ID_DATA__REF_VALUE;
+		if (expr__parse(&data->ref.val, ctx, data->ref.metric_expr, 1)) {
 			pr_debug("%s failed to count\n", id);
 			return -1;
 		}
 		pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
+		break;
+	case EXPR_ID_DATA__REF_VALUE:
+		pr_debug2("lookup(%s): ref val %f metric name %s\n", id,
+			data->ref.val, data->ref.metric_name);
+		break;
+	default:
+		assert(0);  /* Unreachable. */
 	}
 
 	return 0;
@@ -241,3 +273,17 @@ int expr__find_other(const char *expr, const char *one,
 
 	return ret;
 }
+
+double expr_id_data__value(const struct expr_id_data *data)
+{
+	if (data->kind == EXPR_ID_DATA__VALUE)
+		return data->val;
+	assert(data->kind == EXPR_ID_DATA__REF_VALUE);
+	return data->ref.val;
+}
+
+struct expr_id *expr_id_data__parent(struct expr_id_data *data)
+{
+	assert(data->kind == EXPR_ID_DATA__PARENT);
+	return data->parent;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index fc2b5e824a66..dcf8d19b83c8 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -23,19 +23,7 @@ struct expr_parse_ctx {
 	struct expr_id	*parent;
 };
 
-struct expr_id_data {
-	union {
-		double val;
-		struct {
-			const char *metric_name;
-			const char *metric_expr;
-			bool counted;
-		} ref;
-		struct expr_id	*parent;
-	};
-
-	bool is_ref;
-};
+struct expr_id_data;
 
 struct expr_scanner_ctx {
 	int start_token;
@@ -57,4 +45,7 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 int expr__find_other(const char *expr, const char *one,
 		struct expr_parse_ctx *ids, int runtime);
 
+double expr_id_data__value(const struct expr_id_data *data);
+struct expr_id *expr_id_data__parent(struct expr_id_data *data);
+
 #endif
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index d34b370391c6..b2ada8f8309a 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -93,7 +93,7 @@ expr:	  NUMBER
 						YYABORT;
 					}
 
-					$$ = data->val;
+					$$ = expr_id_data__value(data);
 					free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..339bfb19a10b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -786,7 +786,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	if (ret)
 		return ret;
 
-	p = data->parent;
+	p = expr_id_data__parent(data);
 
 	while (p->parent) {
 		if (!strcmp(p->id, id)) {
@@ -807,7 +807,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	}
 
 	p->id     = strdup(id);
-	p->parent = data->parent;
+	p->parent = expr_id_data__parent(data);
 	*parent   = p;
 
 	return p->id ? 0 : -ENOMEM;
-- 
2.28.0.297.g1956fa8f8d-goog

