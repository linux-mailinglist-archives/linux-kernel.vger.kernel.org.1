Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAC296CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462355AbgJWK0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462262AbgJWKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E461C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0uTBXjeVlI0iHUhVmjriFE6UbVF4vSNqGkV7VU+SB7o=; b=oxlUjh/PI4KXfYrWmXDgpEIVSl
        tGwmCsUQDZL5Ri+VPklRgxhiQeI8tW7yW7RSAc0n1v0YhRzgxPQsTQyVo8Pu+ZmqqvZYrCUn9wLTX
        gTeumcIsgVLyNI1zuPXdzq7qs6rGmQHx7KXSlrF3f4puz/opVrbCQwMvLVgcoHbmjppAIUmbBrQI5
        AOv59zkltgh3oqomPa0o18n2TX+TjYBTavwQZOViIT1bOHGfPEKuTQK/OELtAEzJfq9rbebuioZSr
        QNf+NAz1fYho1aMexFoIT12j2lbrKHJuU7V5inhYC7W7LWJ1+mCFpfRw4OABzjEkale7R7HunxQiT
        OfSFL/XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFn-0002t2-BY; Fri, 23 Oct 2020 10:24:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73EED3060C5;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 38E2529DDA658; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102346.203901269@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 02/19] sched: Fix balance_callback()
References: <20201023101158.088940906@infradead.org>
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


