Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5A1AB07E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898340AbgDOSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441043AbgDOSTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602D821582;
        Wed, 15 Apr 2020 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974785;
        bh=c5tWnocDc5au1/G7gjOm+z+uCidBAVAit2WkiuH7E+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TocJkcjWa2QZtViILT4Hq2VqrS7rcNj+6oxmr0Mrwi5DZxz78A8FMC+oq9BsMU+AM
         7j0i2AxiLZ6tXNPuDWXEzspcDKH0npySad9T3wlkcWOA6M3B/qv1IH8r9qL4NBXlb/
         0CrW8vW2/ySd4PLuNK+e9hT346gi+W2Wdpr63CnM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 06/38] rcu-tasks: Create struct to hold state information
Date:   Wed, 15 Apr 2020 11:19:09 -0700
Message-Id: <20200415181941.11653-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates an rcu_tasks struct to hold state information for
RCU Tasks.  This is a preparation commit for adding additional flavors
of Tasks RCU, each of which would have its own rcu_tasks struct.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 73 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index be8d179..5ccfe0d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -7,6 +7,30 @@
 
 #ifdef CONFIG_TASKS_RCU
 
+/**
+ * Definition for a Tasks-RCU-like mechanism.
+ * @cbs_head: Head of callback list.
+ * @cbs_tail: Tail pointer for callback list.
+ * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
+ * @cbs_lock: Lock protecting callback list.
+ * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
+ */
+struct rcu_tasks {
+	struct rcu_head *cbs_head;
+	struct rcu_head **cbs_tail;
+	struct wait_queue_head cbs_wq;
+	raw_spinlock_t cbs_lock;
+	struct task_struct *kthread_ptr;
+};
+
+#define DEFINE_RCU_TASKS(name)						\
+static struct rcu_tasks name =						\
+{									\
+	.cbs_tail = &name.cbs_head,					\
+	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(name.cbs_wq),		\
+	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(name.cbs_lock),		\
+}
+
 /*
  * Simple variant of RCU whose quiescent states are voluntary context
  * switch, cond_resched_rcu_qs(), user-space execution, and idle.
@@ -18,12 +42,7 @@
  * rates from multiple CPUs.  If this is required, per-CPU callback lists
  * will be needed.
  */
-
-/* Global list of callbacks and associated lock. */
-static struct rcu_head *rcu_tasks_cbs_head;
-static struct rcu_head **rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
-static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
+DEFINE_RCU_TASKS(rcu_tasks);
 
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
@@ -33,8 +52,6 @@ DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
 
-static struct task_struct *rcu_tasks_kthread_ptr;
-
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
@@ -57,17 +74,18 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
 {
 	unsigned long flags;
 	bool needwake;
+	struct rcu_tasks *rtp = &rcu_tasks;
 
 	rhp->next = NULL;
 	rhp->func = func;
-	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-	needwake = !rcu_tasks_cbs_head;
-	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
-	rcu_tasks_cbs_tail = &rhp->next;
-	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+	raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+	needwake = !rtp->cbs_head;
+	WRITE_ONCE(*rtp->cbs_tail, rhp);
+	rtp->cbs_tail = &rhp->next;
+	raw_spin_unlock_irqrestore(&rtp->cbs_lock, flags);
 	/* We can't create the thread unless interrupts are enabled. */
-	if (needwake && READ_ONCE(rcu_tasks_kthread_ptr))
-		wake_up(&rcu_tasks_cbs_wq);
+	if (needwake && READ_ONCE(rtp->kthread_ptr))
+		wake_up(&rtp->cbs_wq);
 }
 EXPORT_SYMBOL_GPL(call_rcu_tasks);
 
@@ -169,10 +187,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_head *list;
 	struct rcu_head *next;
 	LIST_HEAD(rcu_tasks_holdouts);
+	struct rcu_tasks *rtp = arg;
 	int fract;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_FLAG_RCU);
+	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
 
 	/*
 	 * Each pass through the following loop makes one check for
@@ -183,17 +203,17 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	for (;;) {
 
 		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-		list = rcu_tasks_cbs_head;
-		rcu_tasks_cbs_head = NULL;
-		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+		list = rtp->cbs_head;
+		rtp->cbs_head = NULL;
+		rtp->cbs_tail = &rtp->cbs_head;
+		raw_spin_unlock_irqrestore(&rtp->cbs_lock, flags);
 
 		/* If there were none, wait a bit and start over. */
 		if (!list) {
-			wait_event_interruptible(rcu_tasks_cbs_wq,
-						 READ_ONCE(rcu_tasks_cbs_head));
-			if (!rcu_tasks_cbs_head) {
+			wait_event_interruptible(rtp->cbs_wq,
+						 READ_ONCE(rtp->cbs_head));
+			if (!rtp->cbs_head) {
 				WARN_ON(signal_pending(current));
 				schedule_timeout_interruptible(HZ/10);
 			}
@@ -211,7 +231,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 *
 		 * This synchronize_rcu() also dispenses with the
 		 * need for a memory barrier on the first store to
-		 * ->rcu_tasks_holdout, as it forces the store to happen
+		 * t->rcu_tasks_holdout, as it forces the store to happen
 		 * after the beginning of the grace period.
 		 */
 		synchronize_rcu();
@@ -278,7 +298,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			firstreport = true;
 			WARN_ON(signal_pending(current));
 			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-						rcu_tasks_holdout_list) {
+						 rcu_tasks_holdout_list) {
 				check_holdout_task(t, needreport, &firstreport);
 				cond_resched();
 			}
@@ -325,11 +345,10 @@ static int __init rcu_spawn_tasks_kthread(void)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, NULL, "rcu_tasks_kthread");
+	t = kthread_run(rcu_tasks_kthread, &rcu_tasks, "rcu_tasks_kthread");
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
 	smp_mb(); /* Ensure others see full kthread. */
-	WRITE_ONCE(rcu_tasks_kthread_ptr, t);
 	return 0;
 }
 core_initcall(rcu_spawn_tasks_kthread);
-- 
2.9.5

