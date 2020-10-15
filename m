Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0697B28F0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgJOLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgJOLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:09:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AB7C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0uTBXjeVlI0iHUhVmjriFE6UbVF4vSNqGkV7VU+SB7o=; b=bXNkEysSxD2hPRHARnZ6mqmElA
        08Ymxn/SDk7sXGYaCRlMqXFgvYyS097509Ytj5bdLSBcbLlF3QCJL5rKwe3tCOYLSrME7IW8edgbR
        8W1t6Tcm/ckUnC2/fWiYJp/b3dCnlsvPB9p17eaha0M4ede0lhDEQ9ATZKrHYs4TvsYUcLZ6Uet88
        Jnz1+EcOlcAi8F8dTDfFg9ZPBLZniQfvmUcHf+Ozl0VQIPTohYKOUvRE5zgc4Q6jWI5jeVLPt0KgG
        va6icAAZt0pNNMTMDvbLBAd5UYaG13USVjDhYt/TjA7gfHsYuFXZdVRf5Ju7W7FnxeBXXl8Lngm0x
        KwGU3X9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT18d-0007w6-S7; Thu, 15 Oct 2020 11:09:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8977530504E;
        Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6B062235F4444; Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Message-ID: <20201015110923.423818459@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Oct 2020 13:05:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v3 02/19] sched: Fix balance_callback()
References: <20201015110532.738127234@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of balance_callback() has always been to delay executing
balancing operations until the end of the current rq->lock section.
This is because balance operations must often drop rq->lock, and that
isn't safe in general.

However, as noted by Scott, there were a few holes in that scheme;
balance_callback() was called after rq->lock was dropped, which means
another CPU can interleave and touch the callback list.

Rework code to call the balance callbacks before dropping rq->lock
where possible, and otherwise splice the balance list onto a local
stack.

This guarantees that the balance list must be empty when we take
rq->lock. IOW, we'll only ever run our own balance callbacks.

Reported-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |  119 ++++++++++++++++++++++++++++++++-------------------
 kernel/sched/sched.h |    3 +
 2 files changed, 78 insertions(+), 44 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3494,6 +3494,69 @@ static inline void finish_task(struct ta
 #endif
 }
 
+#ifdef CONFIG_SMP
+
+static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	void (*func)(struct rq *rq);
+	struct callback_head *next;
+
+	lockdep_assert_held(&rq->lock);
+
+	while (head) {
+		func = (void (*)(struct rq *))head->func;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+
+		func(rq);
+	}
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	struct callback_head *head = rq->balance_callback;
+
+	lockdep_assert_held(&rq->lock);
+	if (head)
+		rq->balance_callback = NULL;
+
+	return head;
+}
+
+static void __balance_callbacks(struct rq *rq)
+{
+	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	unsigned long flags;
+
+	if (unlikely(head)) {
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		do_balance_callbacks(rq, head);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
+}
+
+#else
+
+static inline void __balance_callbacks(struct rq *rq)
+{
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return NULL;
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+}
+
+#endif
+
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -3519,6 +3582,7 @@ static inline void finish_lock_switch(st
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	__balance_callbacks(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -3660,43 +3724,6 @@ static struct rq *finish_task_switch(str
 	return rq;
 }
 
-#ifdef CONFIG_SMP
-
-/* rq->lock is NOT held, but preemption is disabled */
-static void __balance_callback(struct rq *rq)
-{
-	struct callback_head *head, *next;
-	void (*func)(struct rq *rq);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rq->lock, flags);
-	head = rq->balance_callback;
-	rq->balance_callback = NULL;
-	while (head) {
-		func = (void (*)(struct rq *))head->func;
-		next = head->next;
-		head->next = NULL;
-		head = next;
-
-		func(rq);
-	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
-}
-
-static inline void balance_callback(struct rq *rq)
-{
-	if (unlikely(rq->balance_callback))
-		__balance_callback(rq);
-}
-
-#else
-
-static inline void balance_callback(struct rq *rq)
-{
-}
-
-#endif
-
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
@@ -3716,7 +3743,6 @@ asmlinkage __visible void schedule_tail(
 	 */
 
 	rq = finish_task_switch(prev);
-	balance_callback(rq);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -4532,10 +4558,11 @@ static void __sched notrace __schedule(b
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-		rq_unlock_irq(rq, &rf);
-	}
 
-	balance_callback(rq);
+		rq_unpin_lock(rq, &rf);
+		__balance_callbacks(rq);
+		raw_spin_unlock_irq(&rq->lock);
+	}
 }
 
 void __noreturn do_task_dead(void)
@@ -4946,9 +4973,11 @@ void rt_mutex_setprio(struct task_struct
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-	__task_rq_unlock(rq, &rf);
 
-	balance_callback(rq);
+	rq_unpin_lock(rq, &rf);
+	__balance_callbacks(rq);
+	raw_spin_unlock(&rq->lock);
+
 	preempt_enable();
 }
 #else
@@ -5222,6 +5251,7 @@ static int __sched_setscheduler(struct t
 	int retval, oldprio, oldpolicy = -1, queued, running;
 	int new_effective_prio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
+	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -5460,6 +5490,7 @@ static int __sched_setscheduler(struct t
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
@@ -5468,7 +5499,7 @@ static int __sched_setscheduler(struct t
 	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callback(rq);
+	balance_callbacks(rq, head);
 	preempt_enable();
 
 	return 0;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1221,6 +1221,9 @@ static inline void rq_pin_lock(struct rq
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 #endif
+#ifdef CONFIG_SMP
+	SCHED_WARN_ON(rq->balance_callback);
+#endif
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)


