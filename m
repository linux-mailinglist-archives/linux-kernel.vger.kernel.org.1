Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7D2ACAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgKJCMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:12:30 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54457 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKJCMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:12:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UEpi23S_1604974339;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UEpi23S_1604974339)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Nov 2020 10:12:28 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Reorder throttle_cfs_rq() path
Date:   Tue, 10 Nov 2020 10:11:59 +0800
Message-Id: <f11dd2e3ab35cc538e2eb57bf0c99b6eaffce127.1604973978.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for
leaf_cfs_rq list") does in unthrottle_cfs_rq(), throttle_cfs_rq()
can also use the same pattern as dequeue_task_fair().

There is no functional changes.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e3..27a69af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4779,25 +4779,37 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
-			break;
+			goto done;
 
-		if (dequeue) {
-			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
-		} else {
-			update_load_avg(qcfs_rq, se, 0);
-			se_update_runnable(se);
-		}
+		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
-		if (qcfs_rq->load.weight)
-			dequeue = 0;
+		if (qcfs_rq->load.weight) {
+			/* Avoid re-evaluating load for this entity: */
+			se = parent_entity(se);
+			break;
+		}
 	}
 
-	if (!se)
-		sub_nr_running(rq, task_delta);
+	for_each_sched_entity(se) {
+		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+		/* throttled entity or throttle-on-deactivate */
+		if (!se->on_rq)
+			goto done;
+
+		update_load_avg(qcfs_rq, se, 0);
+		se_update_runnable(se);
 
+		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+	}
+
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, task_delta);
+
+done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
-- 
2.9.5

