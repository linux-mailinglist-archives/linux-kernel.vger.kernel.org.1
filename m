Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69E272412
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgIUMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgIUMoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:44:08 -0400
Received: from lenoir.home (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793E9218AC;
        Mon, 21 Sep 2020 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600692247;
        bh=vQ/n6/WcAMXHM8m21CBb157y5TJ0Ll3fjqKn3WzjjNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3q8gInaYKd/meZ7UZYuqDI61s5r0lTfIoyUe2jB3ChMwBqS2nSCZUFGqWneczGft
         CUDCgqXHe2c4zpdxGRgjU5QKMqnweGTbexPiCTIRVeOJDWKTXmmTixrTtCV5z88Yyo
         /hpqYRwevt7QZ2AvE4C0sa/2hTd0/4VGLkMhMAt4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH 04/12] rcu: De-offloading CB kthread
Date:   Mon, 21 Sep 2020 14:43:43 +0200
Message-Id: <20200921124351.24035-5-frederic@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921124351.24035-1-frederic@kernel.org>
References: <20200921124351.24035-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to de-offload the callbacks processing of an rdp, we must clear
SEGCBLIST_OFFLOAD and notify the CB kthread so that it clears its own
bit flag and goes to sleep to stop handling callbacks. The GP kthread
will also be notified the same way. Whoever acknowledges and clears its
own bit last must notify the de-offloading worker so that it can resume
the de-offloading while being sure that callbacks won't be handled
remotely anymore.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcupdate.h   |   2 +
 kernel/rcu/rcu_segcblist.c |  10 ++-
 kernel/rcu/rcu_segcblist.h |   2 +-
 kernel/rcu/tree.h          |   1 +
 kernel/rcu/tree_plugin.h   | 124 ++++++++++++++++++++++++++++++++-----
 5 files changed, 119 insertions(+), 20 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46db61f7..44ddee921441 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -97,8 +97,10 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+void rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline void rcu_nocb_cpu_deoffload(int cpu) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /**
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 31cc27ee98d8..b70032d77025 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -170,10 +170,14 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  * Mark the specified rcu_segcblist structure as offloaded.  This
  * structure must be empty.
  */
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
-	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
-	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
+	if (offload) {
+		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
+		rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
+	} else {
+		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
+	}
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 575896a2518b..00ebeb8d39b7 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -105,7 +105,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
+void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c96ae351688b..5b37f7103b0d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -198,6 +198,7 @@ struct rcu_data {
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
+	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
 	atomic_t nocb_lock_contended;	/* Contention experienced. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5be5269..3ea43c75c7a3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2052,6 +2052,17 @@ static int rcu_nocb_gp_kthread(void *arg)
 	return 0;
 }
 
+static inline bool nocb_cb_can_run(struct rcu_data *rdp)
+{
+	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_CB;
+	return rcu_segcblist_test_flags(&rdp->cblist, flags);
+}
+
+static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
+{
+	return nocb_cb_can_run(rdp) && !READ_ONCE(rdp->nocb_cb_sleep);
+}
+
 /*
  * Invoke any ready callbacks from the corresponding no-CBs CPU,
  * then, if there are no more, wait for more to appear.
@@ -2061,7 +2072,9 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	unsigned long cur_gp_seq;
 	unsigned long flags;
 	bool needwake_gp = false;
+	bool needwake_state = false;
 	struct rcu_node *rnp = rdp->mynode;
+	struct rcu_segcblist *cblist = &rdp->cblist;
 
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
@@ -2071,32 +2084,50 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
-	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
 	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
-	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		if (needwake_gp)
-			rcu_gp_kthread_wake();
-		return;
-	}
 
-	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 	WRITE_ONCE(rdp->nocb_cb_sleep, true);
+
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		if (rcu_segcblist_ready_cbs(cblist))
+			WRITE_ONCE(rdp->nocb_cb_sleep, false);
+	} else {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We won't touch the callbacks and keep sleeping until we ever
+		 * get re-offloaded.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_CB);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
+			needwake_state = true;
+	}
+
+	if (rdp->nocb_cb_sleep)
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
+
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 	if (needwake_gp)
 		rcu_gp_kthread_wake();
-	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
-				 !READ_ONCE(rdp->nocb_cb_sleep));
-	if (!smp_load_acquire(&rdp->nocb_cb_sleep)) { /* VVV */
+
+	if (needwake_state)
+		swake_up_one(&rdp->nocb_state_wq);
+
+	do {
+		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
+						    nocb_cb_wait_cond(rdp));
+
 		/* ^^^ Ensure CB invocation follows _sleep test. */
-		return;
-	}
-	WARN_ON(signal_pending(current));
-	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+		if (smp_load_acquire(&rdp->nocb_cb_sleep)) {
+			WARN_ON(signal_pending(current));
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
+		}
+	} while (!nocb_cb_can_run(rdp));
 }
 
 /*
@@ -2158,6 +2189,65 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
+static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+{
+	unsigned long flags;
+	struct rcu_node *rnp = rdp->mynode;
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	bool wake_cb = false;
+
+	printk("De-offloading %d\n", rdp->cpu);
+
+	rcu_nocb_lock_irqsave(rdp, flags);
+	raw_spin_lock_rcu_node(rnp);
+	rcu_segcblist_offload(cblist, false);
+	raw_spin_unlock_rcu_node(rnp);
+
+	if (rdp->nocb_cb_sleep) {
+		rdp->nocb_cb_sleep = false;
+		wake_cb = true;
+	}
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
+	if (wake_cb)
+		swake_up_one(&rdp->nocb_cb_wq);
+
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
+}
+
+static long rcu_nocb_rdp_deoffload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	__rcu_nocb_rdp_deoffload(rdp);
+
+	return 0;
+}
+
+void rcu_nocb_cpu_deoffload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	if (rdp == rdp->nocb_gp_rdp) {
+		pr_info("Can't deoffload an rdp GP leader (yet)\n");
+		return;
+	}
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		if (cpu_online(cpu)) {
+			work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
+		} else {
+			__rcu_nocb_rdp_deoffload(rdp);
+		}
+		cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+}
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -2200,7 +2290,8 @@ void __init rcu_init_nohz(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
-		rcu_segcblist_offload(&rdp->cblist);
+		rcu_segcblist_offload(&rdp->cblist, true);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
 	}
 	rcu_organize_nocb_kthreads();
 }
@@ -2210,6 +2301,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 	init_swait_queue_head(&rdp->nocb_cb_wq);
 	init_swait_queue_head(&rdp->nocb_gp_wq);
+	init_swait_queue_head(&rdp->nocb_state_wq);
 	raw_spin_lock_init(&rdp->nocb_lock);
 	raw_spin_lock_init(&rdp->nocb_bypass_lock);
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
-- 
2.28.0

