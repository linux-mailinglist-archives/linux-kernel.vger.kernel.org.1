Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2BE22535F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGSSNq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Jul 2020 14:13:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53346 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbgGSSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:44 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-1CxV1TFnPgqkaa7s1cofvw-1; Sun, 19 Jul 2020 14:13:39 -0400
X-MC-Unique: 1CxV1TFnPgqkaa7s1cofvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B83E800685;
        Sun, 19 Jul 2020 18:13:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33B5374F6C;
        Sun, 19 Jul 2020 18:13:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 04/19] perf metric: Add expr__del_id function
Date:   Sun, 19 Jul 2020 20:13:05 +0200
Message-Id: <20200719181320.785305-5-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding expr__del_id function to remove ID from hashmap.
It will save us few lines in following changes.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 21 +++++++++++++--------
 tools/perf/util/expr.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4e5a6533dfce..f726211f49d4 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -79,6 +79,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 	return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
 }
 
+void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
+{
+	struct expr_id_data *old_val = NULL;
+	char *old_key = NULL;
+
+	hashmap__delete(&ctx->ids, id,
+			(const void **)&old_key, (void **)&old_val);
+	free(old_key);
+	free(old_val);
+}
+
 void expr__ctx_init(struct expr_parse_ctx *ctx)
 {
 	hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
@@ -136,16 +147,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
 int expr__find_other(const char *expr, const char *one,
 		     struct expr_parse_ctx *ctx, int runtime)
 {
-	struct expr_id_data *old_val = NULL;
-	char *old_key = NULL;
 	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
 
-	if (one) {
-		hashmap__delete(&ctx->ids, one,
-				(const void **)&old_key, (void **)&old_val);
-		free(old_key);
-		free(old_val);
-	}
+	if (one)
+		expr__del_id(ctx, one);
 
 	return ret;
 }
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index f38292fdab19..2462abd0ac65 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,6 +26,7 @@ struct expr_scanner_ctx {
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
-- 
2.25.4

