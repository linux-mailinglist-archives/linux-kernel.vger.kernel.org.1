Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71A2B5A50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgKQHdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:33:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7551 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKQHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:33:17 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZyMx4LKyzhZb4;
        Tue, 17 Nov 2020 15:33:01 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 15:33:07 +0800
To:     <tj@kernel.org>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: workqueue: Only kick a worker after thawed or for an unbound
 workqueue
Message-ID: <aaa87d62-b89d-e241-1a6e-01176694616f@huawei.com>
Date:   Tue, 17 Nov 2020 15:32:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In realtime scenario, We do not want to have interference on the
isolated cpu cores. but when invoking alloc_workqueue() for percpu wq
on the housekeeping cpu, it kick a kworker on the isolated cpu.

  alloc_workqueue
    pwq_adjust_max_active
      wake_up_worker

The comment in pwq_adjust_max_active() said:
  "Need to kick a worker after thawed or an unbound wq's
   max_active is bumped"

So it is unnecessary to kick a kworker for percpu wq's when
alloc_workqueue. this patch only kick a worker after thawed or for an
unbound workqueue.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/workqueue.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a..80f7bbd4889f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3696,14 +3696,16 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
 }

 /**
- * pwq_adjust_max_active - update a pwq's max_active to the current setting
+ * pwq_adjust_max_active_and_kick - update a pwq's max_active to the current setting
  * @pwq: target pool_workqueue
+ * @force_kick: force to kick a worker
  *
  * If @pwq isn't freezing, set @pwq->max_active to the associated
  * workqueue's saved_max_active and activate delayed work items
  * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
  */
-static void pwq_adjust_max_active(struct pool_workqueue *pwq)
+static void pwq_adjust_max_active_and_kick(struct pool_workqueue *pwq,
+					bool force_kick)
 {
 	struct workqueue_struct *wq = pwq->wq;
 	bool freezable = wq->flags & WQ_FREEZABLE;
@@ -3733,9 +3735,10 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)

 		/*
 		 * Need to kick a worker after thawed or an unbound wq's
-		 * max_active is bumped.  It's a slow path.  Do it always.
+		 * max_active is bumped.
 		 */
-		wake_up_worker(pwq->pool);
+		if (force_kick || (wq->flags & WQ_UNBOUND))
+			wake_up_worker(pwq->pool);
 	} else {
 		pwq->max_active = 0;
 	}
@@ -3743,6 +3746,11 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }

+static void pwq_adjust_max_active(struct pool_workqueue *pwq)
+{
+	pwq_adjust_max_active_and_kick(pwq, false);
+}
+
 /* initialize newly alloced @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
@@ -5252,7 +5260,7 @@ void thaw_workqueues(void)
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
 		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+			pwq_adjust_max_active_and_kick(pwq, true);
 		mutex_unlock(&wq->mutex);
 	}

-- 
2.18.4
