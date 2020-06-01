Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31761EA099
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFAJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:13:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgFAJNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:13:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67979171002AB7AD6DC3;
        Mon,  1 Jun 2020 17:12:59 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 17:12:52 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>
Subject: [PATCH] ubi: check kthread_should_stop() after the setting of task state
Date:   Mon, 1 Jun 2020 17:12:31 +0800
Message-ID: <20200601091231.3794350-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A detach hung is possible when a race occurs between the detach process
and the ubi background thread. The following sequences outline the race:

  ubi thread: if (list_empty(&ubi->works)...

  ubi detach: set_bit(KTHREAD_SHOULD_STOP, &kthread->flags)
              => by kthread_stop()
              wake_up_process()
              => ubi thread is still running, so 0 is returned

  ubi thread: set_current_state(TASK_INTERRUPTIBLE)
              schedule()
              => ubi thread will never be scheduled again

  ubi detach: wait_for_completion()
              => hung task!

To fix that, we need to check kthread_should_stop() after we set the
task state, so the ubi thread will either see the stop bit and exit or
the task state is reset to runnable such that it isn't scheduled out
indefinitely.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <Stable@vger.kernel.org>
Fixes: 801c135ce73d5df1ca ("UBI: Unsorted Block Images")
Reported-by: syzbot+853639d0cb16c31c7a14@syzkaller.appspotmail.com
---
 drivers/mtd/ubi/wl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 5146cce5fe32..a4d4343053d7 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1628,6 +1628,19 @@ int ubi_thread(void *u)
 		    !ubi->thread_enabled || ubi_dbg_is_bgt_disabled(ubi)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock(&ubi->wl_lock);
+
+			/*
+			 * Check kthread_should_stop() after we set the task
+			 * state to guarantee that we either see the stop bit
+			 * and exit or the task state is reset to runnable such
+			 * that it's not scheduled out indefinitely and detects
+			 * the stop bit at kthread_should_stop().
+			 */
+			if (kthread_should_stop()) {
+				set_current_state(TASK_RUNNING);
+				break;
+			}
+
 			schedule();
 			continue;
 		}
-- 
2.25.4

