Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB921AB083
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441444AbgDOSUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441400AbgDOST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0053721D95;
        Wed, 15 Apr 2020 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974796;
        bh=T8ZpnoFPTorEfwySTOpXKyiisPDpDzNaQhys7ajKGgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2wSORErAfhN0V4vLKRBdePJTsXjKq0mAaU1YhlkVwzwawSjXfnlkG9Qp+oswriuf
         QURzzdX7BzWHGvyZ+CzZgWxDesqijaCV6T56+gxHIRqXZT9ItpXkb+OB1dDPAWPKnk
         Tue9dEzVQ9HsqOZUyuY31a0l1rPL6WkUvPkF1GnQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 36/38] rcu-tasks: Allow standalone use of TASKS_{TRACE_,}RCU
Date:   Wed, 15 Apr 2020 11:19:39 -0700
Message-Id: <20200415181941.11653-36-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit allows TASKS_TRACE_RCU to be used independently of TASKS_RCU
and vice versa.

[ paulmck: Fix conditional compilation per kbuild test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e600d29..234847f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -244,27 +244,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 	smp_mb(); /* Ensure others see full kthread. */
 }
 
-/* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
-{
-	preempt_disable();
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-	preempt_enable();
-}
-
-static void exit_tasks_rcu_finish_trace(struct task_struct *t);
-
-/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
-{
-	struct task_struct *t = current;
-
-	preempt_disable();
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
-	preempt_enable();
-	exit_tasks_rcu_finish_trace(t);
-}
-
 #ifndef CONFIG_TINY_RCU
 
 /*
@@ -303,7 +282,9 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		s);
 }
 
-#ifdef CONFIG_TASKS_RCU
+static void exit_tasks_rcu_finish_trace(struct task_struct *t);
+
+#if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -374,6 +355,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rtp->postgp_func(rtp);
 }
 
+#endif /* #if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU) */
+
+#ifdef CONFIG_TASKS_RCU
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Simple variant of RCU whose quiescent states are voluntary context
@@ -577,8 +562,29 @@ static void show_rcu_tasks_classic_gp_kthread(void)
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
 
+/* Do the srcu_read_lock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+{
+	preempt_disable();
+	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	preempt_enable();
+}
+
+/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
+{
+	struct task_struct *t = current;
+
+	preempt_disable();
+	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
+	preempt_enable();
+	exit_tasks_rcu_finish_trace(t);
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU */
 static void show_rcu_tasks_classic_gp_kthread(void) { }
+void exit_tasks_rcu_start(void) { }
+void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
@@ -1071,7 +1077,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 }
 
 /* Report any needed quiescent state for this exiting task. */
-void exit_tasks_rcu_finish_trace(struct task_struct *t)
+static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
 	WRITE_ONCE(t->trc_reader_checked, true);
 	WARN_ON_ONCE(t->trc_reader_nesting);
@@ -1166,7 +1172,7 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 }
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
-void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
+static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
-- 
2.9.5

