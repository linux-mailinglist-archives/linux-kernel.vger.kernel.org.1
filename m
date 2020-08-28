Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE85255325
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 04:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgH1Cx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 22:53:27 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33578 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgH1CxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:53:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U736P4w_1598583196;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U736P4w_1598583196)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 10:53:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] block: Move blk_mq_bio_list_merge() into blk-merge.c
Date:   Fri, 28 Aug 2020 10:52:55 +0800
Message-Id: <0a9d1c89bae7225969b8a3cba2417ed63d27266c.1598580324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
References: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the blk_mq_bio_list_merge() into blk-merge.c and
rename it as a generic name.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-merge.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.c   | 46 +---------------------------------------------
 block/blk.h            |  2 ++
 block/kyber-iosched.c  |  2 +-
 include/linux/blk-mq.h |  2 --
 5 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3aa2de5..b09e9fc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1052,3 +1052,47 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 
 	return false;
 }
+
+/*
+ * Iterate list of requests and see if we can merge this bio with any
+ * of them.
+ */
+bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
+			struct bio *bio, unsigned int nr_segs)
+{
+	struct request *rq;
+	int checked = 8;
+
+	list_for_each_entry_reverse(rq, list, queuelist) {
+		bool merged = false;
+
+		if (!checked--)
+			break;
+
+		if (!blk_rq_merge_ok(rq, bio))
+			continue;
+
+		switch (blk_try_merge(rq, bio)) {
+		case ELEVATOR_BACK_MERGE:
+			if (blk_mq_sched_allow_merge(q, rq, bio))
+				merged = bio_attempt_back_merge(rq, bio,
+						nr_segs);
+			break;
+		case ELEVATOR_FRONT_MERGE:
+			if (blk_mq_sched_allow_merge(q, rq, bio))
+				merged = bio_attempt_front_merge(rq, bio,
+						nr_segs);
+			break;
+		case ELEVATOR_DISCARD_MERGE:
+			merged = bio_attempt_discard_merge(q, rq, bio);
+			break;
+		default:
+			continue;
+		}
+
+		return merged;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(blk_bio_list_merge);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d2790e5..82acff9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -392,50 +392,6 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
 /*
- * Iterate list of requests and see if we can merge this bio with any
- * of them.
- */
-bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
-			   struct bio *bio, unsigned int nr_segs)
-{
-	struct request *rq;
-	int checked = 8;
-
-	list_for_each_entry_reverse(rq, list, queuelist) {
-		bool merged = false;
-
-		if (!checked--)
-			break;
-
-		if (!blk_rq_merge_ok(rq, bio))
-			continue;
-
-		switch (blk_try_merge(rq, bio)) {
-		case ELEVATOR_BACK_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_back_merge(rq, bio,
-						nr_segs);
-			break;
-		case ELEVATOR_FRONT_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_front_merge(rq, bio,
-						nr_segs);
-			break;
-		case ELEVATOR_DISCARD_MERGE:
-			merged = bio_attempt_discard_merge(q, rq, bio);
-			break;
-		default:
-			continue;
-		}
-
-		return merged;
-	}
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
-
-/*
  * Reverse check our software queue for entries that we could potentially
  * merge with. Currently includes a hand-wavy stop count of 8, to not spend
  * too much time checking for merges.
@@ -449,7 +405,7 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 
 	lockdep_assert_held(&ctx->lock);
 
-	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
+	if (blk_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
 		ctx->rq_merged++;
 		return true;
 	}
diff --git a/block/blk.h b/block/blk.h
index 49e2928..d6152d2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -177,6 +177,8 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 		struct bio *bio);
 bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
+bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
+			struct bio *bio, unsigned int nr_segs);
 
 void blk_account_io_start(struct request *req);
 void blk_account_io_done(struct request *req, u64 now);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index a38c5ab..6d4ba0e 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -573,7 +573,7 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
 	bool merged;
 
 	spin_lock(&kcq->lock);
-	merged = blk_mq_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
+	merged = blk_bio_list_merge(hctx->queue, rq_list, bio, nr_segs);
 	spin_unlock(&kcq->lock);
 
 	return merged;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9d2d5ad..21a02e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -489,8 +489,6 @@ static inline int blk_mq_request_completed(struct request *rq)
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
-bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
-			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
1.8.3.1

