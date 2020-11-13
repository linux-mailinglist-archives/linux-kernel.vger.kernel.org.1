Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C802B17A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKMI6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:58:43 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54211 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgKMI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:58:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UFAepvk_1605257910;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAepvk_1605257910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 16:58:36 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/rtmutex: remove useless parameter for rt_mutex_proxy_unlock
Date:   Fri, 13 Nov 2020 16:58:12 +0800
Message-Id: <1605257895-5536-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter 'proxy_owner' isn't used, so could be removed.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Darren Hart <dvhart@infradead.org> 
Cc: Will Deacon <will@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/futex.c                  | 2 +-
 kernel/locking/rtmutex.c        | 3 +--
 kernel/locking/rtmutex_common.h | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index f8614ef4ff31..347deedcfd0e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -796,7 +796,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 			list_del_init(&pi_state->list);
 			raw_spin_unlock(&owner->pi_lock);
 		}
-		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
+		rt_mutex_proxy_unlock(&pi_state->pi_mutex);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 50fa521fe767..f196045f2857 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1721,8 +1721,7 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
  * possible because it belongs to the pi_state which is about to be freed
  * and it is not longer visible to other tasks.
  */
-void rt_mutex_proxy_unlock(struct rt_mutex *lock,
-			   struct task_struct *proxy_owner)
+void rt_mutex_proxy_unlock(struct rt_mutex *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
 	rt_mutex_set_owner(lock, NULL);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index d1d62f942be2..ca6fb489007b 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -133,8 +133,7 @@ enum rtmutex_chainwalk {
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
-extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
-				  struct task_struct *proxy_owner);
+extern void rt_mutex_proxy_unlock(struct rt_mutex *lock);
 extern void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
-- 
2.29.GIT

