Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7681F99FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgFOOUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 10:20:37 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59686 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729733AbgFOOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:20:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U.foqgV_1592230772;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0U.foqgV_1592230772)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jun 2020 22:20:33 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Optimize dequeue_task_fair()
Date:   Mon, 15 Jun 2020 22:16:16 +0800
Message-Id: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at enqueue_task_fair and dequeue_task_fair, it occurred
to me that dequeue_task_fair can also be optimized as Vincent described
in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").

dequeue_throttle label can ensure se not to be NULL, and se is
always NULL when reaching root level.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbcb2f7..e6be952 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5614,10 +5614,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
-dequeue_throttle:
-	if (!se)
-		sub_nr_running(rq, 1);
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, 1);
 
+dequeue_throttle:
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
-- 
2.9.5

