Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704BF245B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgHQEJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 00:09:39 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33828 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgHQEJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:09:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5xKxWW_1597637374;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U5xKxWW_1597637374)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 12:09:34 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/5] block: Remove redundant blk_mq_sched_allow_merge() validation
Date:   Mon, 17 Aug 2020 12:09:16 +0800
Message-Id: <b9d51f4bc9f0ff4ec3b8fb7fa6dc366afd69290e.1597637287.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only software queue and kyber IO scheduler will call blk_mq_bio_list_merge()
to merge a bio, and kyber IO scheduler did not implement the ops->allow_merge().
Thus we can remove the redundant blk_mq_sched_allow_merge() in
blk_mq_bio_list_merge() function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-sched.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a19cdf1..bf62b34 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -403,14 +403,10 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 		switch (blk_try_merge(rq, bio)) {
 		case ELEVATOR_BACK_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_back_merge(rq, bio,
-						nr_segs);
+			merged = bio_attempt_back_merge(rq, bio, nr_segs);
 			break;
 		case ELEVATOR_FRONT_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_front_merge(rq, bio,
-						nr_segs);
+			merged = bio_attempt_front_merge(rq, bio, nr_segs);
 			break;
 		case ELEVATOR_DISCARD_MERGE:
 			merged = bio_attempt_discard_merge(q, rq, bio);
-- 
1.8.3.1

