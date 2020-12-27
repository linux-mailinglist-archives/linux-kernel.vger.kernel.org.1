Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5037D2E3091
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 10:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgL0JQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 04:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0JQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 04:16:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E9C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:16:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id p22so7199378edu.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=o+RIfSJpV6x/LUaKS6y5k0OXQozoS5egY960UtNZ30g=;
        b=dcJjQQG7DpWc06CldrPgvSrXkVlNwLygDmrtcf/qnvEgdxhg22rJhvdeokfeClKo6M
         orFJAUVmrLqfI5Fork/0HsBxM5Rv95cFlxTqCygXGhVrpJLJfzcd7rKLtkRHUJTxwjH1
         HV0ZYFr4coRRtYQM4x0XKFABrLk3Q5tDZfKpw61bSGF8Jx9IEl3D68sjJQJLVUaugpFk
         B+cKVv/iH+/ecqgaLQva/9MWl+4ifJkAcd0bHmHOq+fldo0siP3xAqfUXJlbMMDKFO3T
         8NBay1cAfKytYCM7sP0q/L2g+0jh0tTmdeOSQvjpvnMgQQhqwV+mXTlPZ7oWkxS/jgPL
         btDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=o+RIfSJpV6x/LUaKS6y5k0OXQozoS5egY960UtNZ30g=;
        b=ltbC4UM1vAcOTcEsuzLREGHiyq9wOL+kbWLLkEVheCaJiukbEkXdnxXiFoEgH7GcQp
         gNwnyeg9bb5HmE4vCk0dNKpb9gAa19gSUnERUCnER8apRWxvj5IV4KvxQpnT7mQ+r/Ni
         qeUkGNFjZfTOaSu4af54j4l7Glr5Nk5jAe9KqMdx395oB04uyxKL9uKH1BolbHGL4Mrm
         stwsGIPBc/nYwyHHWx2UF2wDdyeLfIw4uquicviRai5fjq3hu9h35De4USrjY/1XPA1X
         R0LjIeixA8aCF1chl4WQMeCXTHkIeb4VOJVCM9LL0/WtPPMG5rDoKQ8GshpfZRDGKi7H
         5/eQ==
X-Gm-Message-State: AOAM532Mc4SFcimAXbUhpxCVmzOoCvBXryOJ5o+YAb+U8zH87Q9MEuS/
        MZwmdsILGBe+vZZEOfIgRG8HWAVXnXU=
X-Google-Smtp-Source: ABdhPJybFUKnlokJa4znNN0tm5lgrQmNOt7dqaq1diKsVQPzBAiX4bQSwstN8deGVL87GVkHBd7F3w==
X-Received: by 2002:a05:6402:22b4:: with SMTP id cx20mr38062772edb.262.1609060564353;
        Sun, 27 Dec 2020 01:16:04 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c25sm15712902ejx.39.2020.12.27.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:16:03 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Dec 2020 10:16:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] scheduler fix
Message-ID: <20201227091601.GA1564184@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-12-27

   # HEAD: ae7927023243dcc7389b2d59b16c09cbbeaecc36 sched: Optimize finish_lock_switch()

Fix a context switch performance regression.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      sched: Optimize finish_lock_switch()


 kernel/sched/core.c  | 40 +++++++++++++++-------------------------
 kernel/sched/sched.h | 13 +++++--------
 2 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7af80c3fce12..0ca7d2dc16d5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3985,15 +3985,20 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
+static void balance_push(struct rq *rq);
+
+struct callback_head balance_push_callback = {
+	.next = NULL,
+	.func = (void (*)(struct callback_head *))balance_push,
+};
+
 static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
 {
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_held(&rq->lock);
-	if (head) {
+	if (head)
 		rq->balance_callback = NULL;
-		rq->balance_flags &= ~BALANCE_WORK;
-	}
 
 	return head;
 }
@@ -4014,21 +4019,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 	}
 }
 
-static void balance_push(struct rq *rq);
-
-static inline void balance_switch(struct rq *rq)
-{
-	if (likely(!rq->balance_flags))
-		return;
-
-	if (rq->balance_flags & BALANCE_PUSH) {
-		balance_push(rq);
-		return;
-	}
-
-	__balance_callbacks(rq);
-}
-
 #else
 
 static inline void __balance_callbacks(struct rq *rq)
@@ -4044,10 +4034,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
 {
 }
 
-static inline void balance_switch(struct rq *rq)
-{
-}
-
 #endif
 
 static inline void
@@ -4075,7 +4061,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	balance_switch(rq);
+	__balance_callbacks(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -7256,6 +7242,10 @@ static void balance_push(struct rq *rq)
 
 	lockdep_assert_held(&rq->lock);
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
+	/*
+	 * Ensure the thing is persistent until balance_push_set(.on = false);
+	 */
+	rq->balance_callback = &balance_push_callback;
 
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
@@ -7305,9 +7295,9 @@ static void balance_push_set(int cpu, bool on)
 
 	rq_lock_irqsave(rq, &rf);
 	if (on)
-		rq->balance_flags |= BALANCE_PUSH;
+		rq->balance_callback = &balance_push_callback;
 	else
-		rq->balance_flags &= ~BALANCE_PUSH;
+		rq->balance_callback = NULL;
 	rq_unlock_irqrestore(rq, &rf);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f5acb6c5ce49..12ada79d40f3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -975,7 +975,6 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
-	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1226,6 +1225,8 @@ struct rq_flags {
 #endif
 };
 
+extern struct callback_head balance_push_callback;
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -1243,9 +1244,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-#endif
 #ifdef CONFIG_SMP
-	SCHED_WARN_ON(rq->balance_callback);
+	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+#endif
 #endif
 }
 
@@ -1408,9 +1409,6 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
-#define BALANCE_WORK	0x01
-#define BALANCE_PUSH	0x02
-
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1418,13 +1416,12 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
+	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
-	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
