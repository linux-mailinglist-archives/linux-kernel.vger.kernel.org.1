Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC3231BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgG2JT3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jul 2020 05:19:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47057 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbgG2JT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-2hhu4faLMIOcG8UNfWh9Rg-1; Wed, 29 Jul 2020 05:19:23 -0400
X-MC-Unique: 2hhu4faLMIOcG8UNfWh9Rg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA0BC1005510;
        Wed, 29 Jul 2020 09:19:20 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB4C56931E;
        Wed, 29 Jul 2020 09:19:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 02/19] perf metric: Add expr__add_id function
Date:   Wed, 29 Jul 2020 11:18:51 +0200
Message-Id: <20200729091908.1378911-3-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the expr__add_id() function to data for ID with zero value, which is
used when scanning the expression for IDs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.c | 31 +++++++++++++++++++++++++------
 tools/perf/util/expr.h |  1 +
 tools/perf/util/expr.y |  2 +-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 578a173d4873..9228f60e2a20 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -32,6 +32,26 @@ static bool key_equal(const void *key1, const void *key2,
 	return !strcmp((const char *)key1, (const char *)key2);
 }
 
+/* Caller must make sure id is allocated */
+int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
+{
+	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
+	char *old_key = NULL;
+	int ret;
+
+	data_ptr = malloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+
+	ret = hashmap__set(&ctx->ids, id, data_ptr,
+			   (const void **)&old_key, (void **)&old_data);
+	if (ret)
+		free(data_ptr);
+	free(old_key);
+	free(old_data);
+	return ret;
+}
+
 /* Caller must make sure id is allocated */
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 {
@@ -39,12 +59,11 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	char *old_key = NULL;
 	int ret;
 
-	if (val != 0.0) {
-		data_ptr = malloc(sizeof(*data_ptr));
-		if (!data_ptr)
-			return -ENOMEM;
-		data_ptr->val = val;
-	}
+	data_ptr = malloc(sizeof(*data_ptr));
+	if (!data_ptr)
+		return -ENOMEM;
+	data_ptr->val = val;
+
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
 	if (ret)
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 21fe5bd85718..ac32cda42006 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -26,6 +26,7 @@ struct expr_scanner_ctx {
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__ctx_clear(struct expr_parse_ctx *ctx);
+int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
 int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2b3420ea6ec..8befe4a46f87 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -69,7 +69,7 @@ all_other: all_other other
 
 other: ID
 {
-	expr__add_id_val(ctx, $1, 0.0);
+	expr__add_id(ctx, $1);
 }
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
-- 
2.25.4

