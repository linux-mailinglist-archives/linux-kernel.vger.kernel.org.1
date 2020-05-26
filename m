Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE51B78C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDXPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:03:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63708C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:03:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x16so8055758pgi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Xkkqj+5WLu8COiZ/TfgDWy2Txx9eTlxx/bJwpEwcEjo=;
        b=g9YIPlk5dCl7/qwmHnLf22yWze7QUqAwpoSl+oVbHvnY2+hjpeJjnrnRjKcAAEFhSP
         aBeSs0bhg2EqhXVymdS2LzknKnlCnEMd6oEM0IONu6/hDEP3UNk65ApKCS7bGaz8K/Hj
         LTHzeHAhYYsmU854WZitshEO7A/UeYTli83jA7Tsw+WsnLbF3p3SEYA86lHBNxmQxAeG
         YOipft3BY574XW7iYWLsr+6/Sw9242uTZ9OYLyD6t2KUhUsqiIA3bqDAVc/StlOVAexv
         PBrwqzjpRjqP0UALMzsPPNwtUhp/Qr98pg/VCVcFvghDKLXJtiBj3L3apf2P6p14snbO
         mamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Xkkqj+5WLu8COiZ/TfgDWy2Txx9eTlxx/bJwpEwcEjo=;
        b=WhCOhUC/x+9uuEftGcwkxeY/2vbr7d+JPoEaxZNs8P30V8lVJ9azNb1W2J8tLI6xaq
         iODFwMzD+fb4kO7779eDFR+UFigUPJ7TWGUApK/XsmJvLmFrh+z45MqT9MbA5gBrd00H
         4pHqJSnhbcki/f7G65o02RsTgcerOjqmKlLl264SIACAA6DgfuwKDLEpne9kdvzlE/v1
         85J7o4KGqQX6RnBvZ6swPLsKKegMAe0w9I7r2QtuL60YKqcN89gbEFi4HakxskAW5Y0h
         ftSmAUlpMAATKSbJgY9rrPgxZCJX3A7g584d2gAEEbfESPL6ZWfV6rRI3AfPExzN2uoD
         DQWg==
X-Gm-Message-State: AGi0PuZQA9t7L4LgxsyWXmZ6XHDtfsikYkLh2Ksi17h2SvoMQzHiBDvQ
        MjpCi1rdsYo7vJXTvFXYrzXWCsYU0A==
X-Google-Smtp-Source: APiQypIeQr9l6rGMJxKwS/oF3yYj1Ak/i9u0uke+OPUcjKK3YwmwqocKr1AZrI6/LebqOsh7bpRFt+/L5w==
X-Received: by 2002:a17:90a:1a46:: with SMTP id 6mr6502072pjl.111.1587740606455;
 Fri, 24 Apr 2020 08:03:26 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:03:21 -0700
Message-Id: <20200424150321.38617-1-sqazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3] block: Limit number of items taken from the I/O scheduler
 in one go
From:   Salman Qazi <sqazi@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flushes bypass the I/O scheduler and get added to hctx->dispatch
in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
hctx->run_work work item and is past the point in
blk_mq_sched_dispatch_requests where hctx->dispatch is checked.

The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
because the I/O scheduler can feed an arbitrary number of commands.

Since we have only one hctx->run_work, the commands waiting in
hctx->dispatch will wait an arbitrary length of time for run_work to be
rerun.

A similar phenomenon exists with dispatches from the software queue.

The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
blk_mq_do_dispatch_ctx and return from the run_work handler and let it
rerun.

Signed-off-by: Salman Qazi <sqazi@google.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
Changes since v2:

* Added helper function __blk_mq_sched_dispatch_requests to remove goto
* Replaced bool return value with int, using -EAGAIN to restart
* Changes to comment formatting

 block/blk-mq-sched.c | 64 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74cedea56034..a86a34580772 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -84,12 +84,16 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * be run again.  This is necessary to avoid starving flushes.
  */
-static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	int ret = 0;
 
 	do {
 		struct request *rq;
@@ -97,6 +101,11 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = -EAGAIN;
+			break;
+		}
+
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -113,6 +122,8 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 */
 		list_add(&rq->queuelist, &rq_list);
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+
+	return ret;
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -130,16 +141,25 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * to be run again.  This is necessary to avoid starving flushes.
  */
-static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	int ret = 0;
 
 	do {
 		struct request *rq;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = -EAGAIN;
+			break;
+		}
+
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
@@ -165,21 +185,17 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
+	return ret;
 }
 
-void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
+	int ret = 0;
 	LIST_HEAD(rq_list);
 
-	/* RCU or SRCU read lock is needed before checking quiesced flag */
-	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
-		return;
-
-	hctx->run++;
-
 	/*
 	 * If we have previous entries on our dispatch list, grab them first for
 	 * more fair dispatch.
@@ -208,19 +224,41 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
-				blk_mq_do_dispatch_sched(hctx);
+				ret = blk_mq_do_dispatch_sched(hctx);
 			else
-				blk_mq_do_dispatch_ctx(hctx);
+				ret = blk_mq_do_dispatch_ctx(hctx);
 		}
 	} else if (has_sched_dispatch) {
-		blk_mq_do_dispatch_sched(hctx);
+		ret = blk_mq_do_dispatch_sched(hctx);
 	} else if (hctx->dispatch_busy) {
 		/* dequeue request one by one from sw queue if queue is busy */
-		blk_mq_do_dispatch_ctx(hctx);
+		ret = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
 		blk_mq_dispatch_rq_list(q, &rq_list, false);
 	}
+
+	return ret;
+}
+
+void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+
+	/* RCU or SRCU read lock is needed before checking quiesced flag */
+	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
+		return;
+
+	hctx->run++;
+
+	/*
+	 * A return of -EAGAIN is an indication that hctx->dispatch is not
+	 * empty and we must run again in order to avoid starving flushes.
+	 */
+	if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN) {
+		if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN)
+			blk_mq_run_hw_queue(hctx, true);
+	}
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.26.2.303.gf8c07b1a785-goog

