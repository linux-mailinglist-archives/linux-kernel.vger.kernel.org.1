Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697D92E33E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgL1DTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:19:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9999 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgL1DTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:19:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D42n13hnVzhXwt;
        Mon, 28 Dec 2020 11:18:13 +0800 (CST)
Received: from huawei.com (10.175.112.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 28 Dec 2020
 11:19:00 +0800
From:   Xiangyang Yu <yuxiangyang4@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] locking/qspinlock: Modify comments to adapt to code modification.
Date:   Mon, 28 Dec 2020 11:18:55 +0800
Message-ID: <20201228031855.1991595-1-yuxiangyang4@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'pv_wait_head_or_lock' comment is not modified in
commit 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock'
into 'struct qspinlock'"). Fix it.

Signed-off-by: Xiangyang Yu <yuxiangyang4@huawei.com>
---
 kernel/locking/qspinlock_paravirt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21aa0722..0b7ecf4eb8b8 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -393,7 +393,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 }
 
 /*
- * Wait for l->locked to become clear and acquire the lock;
+ * Wait for lock->locked to become clear and acquire the lock;
  * halt the vcpu after a short spin.
  * __pv_queued_spin_unlock() will wake us.
  *
@@ -447,9 +447,9 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 			 * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
 			 * we'll be sure to be able to observe our hash entry.
 			 *
-			 *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
-			 *       MB                           RMB
-			 * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
+			 *   [S] <hash>                    [Rmw] lock->locked == _Q_SLOW_VAL
+			 *       MB                              RMB
+			 * [RmW] lock->locked = _Q_SLOW_VAL  [L] <unhash>
 			 *
 			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
 			 */
-- 
2.23.0

