Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8425A2B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 03:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIBBpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 21:45:53 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41467 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgIBBpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:45:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U7fvce._1599011133;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U7fvce._1599011133)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Sep 2020 09:45:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, dan.carpenter@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove a duplicative condition
Date:   Wed,  2 Sep 2020 09:45:25 +0800
Message-Id: <24364e6dfe7905d4f823ab932f927e2d30858c5c.1599010968.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicative condition to remove below cppcheck warnings:

"warning: Redundant condition: sched_allow_merge. '!A || (A && B)' is
equivalent to '!A || B' [redundantCondition]"

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-merge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 80c9744..6ed7158 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -996,13 +996,11 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 
 	switch (blk_try_merge(rq, bio)) {
 	case ELEVATOR_BACK_MERGE:
-		if (!sched_allow_merge ||
-		    (sched_allow_merge && blk_mq_sched_allow_merge(q, rq, bio)))
+		if (!sched_allow_merge || blk_mq_sched_allow_merge(q, rq, bio))
 			return bio_attempt_back_merge(rq, bio, nr_segs);
 		break;
 	case ELEVATOR_FRONT_MERGE:
-		if (!sched_allow_merge ||
-		    (sched_allow_merge && blk_mq_sched_allow_merge(q, rq, bio)))
+		if (!sched_allow_merge || blk_mq_sched_allow_merge(q, rq, bio))
 			return bio_attempt_front_merge(rq, bio, nr_segs);
 		break;
 	case ELEVATOR_DISCARD_MERGE:
-- 
1.8.3.1

