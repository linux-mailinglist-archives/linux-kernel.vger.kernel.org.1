Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC339279E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgI0F5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:57:02 -0400
Received: from mail5.windriver.com ([192.103.53.11]:57278 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbgI0F5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:57:02 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 08R5sfp4024676
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 26 Sep 2020 22:55:26 -0700
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Sat, 26 Sep 2020 22:54:51 -0700
From:   <qiang.zhang@windriver.com>
To:     <tj@kernel.org>, <pmladek@suse.com>, <hdanton@sina.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] kthread_worker: Prevent queuing delayed work from timer_fn when it is being canceled
Date:   Sun, 27 Sep 2020 13:54:49 +0800
Message-ID: <20200927055449.21389-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

There is a small race window when a delayed work is being canceled and
the work still might be queued from the timer_fn:

	CPU0						CPU1
kthread_cancel_delayed_work_sync()
   __kthread_cancel_work_sync()
     __kthread_cancel_work()
        work->canceling++;
					      kthread_delayed_work_timer_fn()
						   kthread_insert_work();

BUG: kthread_insert_work() should not get called when work->canceling
is set.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
--- 
 v1->v2->v3:
 Change the description of the problem and add 'Reviewed-by' tags.

 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..85a2c9b32049 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -897,7 +897,8 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	/* Move the work from worker->delayed_work_list. */
 	WARN_ON_ONCE(list_empty(&work->node));
 	list_del_init(&work->node);
-	kthread_insert_work(worker, work, &worker->work_list);
+	if (!work->canceling)
+		kthread_insert_work(worker, work, &worker->work_list);
 
 	raw_spin_unlock_irqrestore(&worker->lock, flags);
 }
-- 
2.17.1

