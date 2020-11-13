Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6A2B17A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKMI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:58:39 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39734 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgKMI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:58:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFAepvk_1605257910;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAepvk_1605257910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 16:58:35 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/rtmutex: add missed kernel-doc markup
Date:   Fri, 13 Nov 2020 16:58:11 +0800
Message-Id: <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix the following issues:
kernel/locking/rtmutex.c:1612: warning: Function parameter or member
'lock' not described in '__rt_mutex_futex_unlock'
kernel/locking/rtmutex.c:1612: warning: Function parameter or member
'wake_q' not described in '__rt_mutex_futex_unlock'
kernel/locking/rtmutex.c:1675: warning: Function parameter or member
'name' not described in '__rt_mutex_init'
kernel/locking/rtmutex.c:1675: warning: Function parameter or member
'key' not described in '__rt_mutex_init'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Will Deacon <will@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/locking/rtmutex.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cfdd5b93264d..50fa521fe767 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1604,8 +1604,11 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /**
- * Futex variant, that since futex variants do not use the fast-path, can be
- * simple and will not need to retry.
+ * __rt_mutex_futex_unlock - Futex variant, that since futex variants
+ * do not use the fast-path, can be simple and will not need to retry.
+ *
+ * @lock: the rt_mutex to be unlocked
+ * @wake_q: wake queue head from which get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 				    struct wake_q_head *wake_q)
@@ -1665,6 +1668,8 @@ EXPORT_SYMBOL_GPL(rt_mutex_destroy);
  * __rt_mutex_init - initialize the rt lock
  *
  * @lock: the rt lock to be initialized
+ * @name: the lock name used for debug
+ * @key: the lock class key used for debug
  *
  * Initialize the rt lock to unlocked state.
  *
-- 
2.29.GIT

