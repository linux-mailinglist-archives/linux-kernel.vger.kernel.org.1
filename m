Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A961272418
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIUMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgIUMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:44:11 -0400
Received: from lenoir.home (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E8EF21789;
        Mon, 21 Sep 2020 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600692250;
        bh=vwRe2gGvhbwUeBuyIKKM2UpbQLF3+cP5zN15dU/2qno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlnGTafiPfCEmpGnOxl99Mu7wxmpfPxXvuiINgYc+RsYm/gIy+va3fke7aLGndRS7
         gHvEVp82DUp9hwpovWLW2+HQiz5xDVF7b8y71ZAfjMOdbsv6hfWN1Ca/ET3ByOVaSq
         XZoO0HPxkMjhqoEesoTZRaESBIknAilOwIIjjyIc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH 06/12] rcu: Re-offload support
Date:   Mon, 21 Sep 2020 14:43:45 +0200
Message-Id: <20200921124351.24035-7-frederic@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921124351.24035-1-frederic@kernel.org>
References: <20200921124351.24035-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to re-offload the callbacks processing of an rdp, we must clear
SEGCBLIST_SOFTIRQ_ONLY, set SEGCBLIST_OFFLOADED and notify the CB and GP
kthreads so that they both set their own bit flag and start processing
the callbacks remotely. The re-offloading worker is then notified that
it can stop processing the callbacks locally.

Ordering must be carefully enforced so that the callbacks that used to
be processed locally without locking must have their latest updates
visible by the time they get processed by the kthreads.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcupdate.h |   2 +
 kernel/rcu/tree_plugin.h | 123 +++++++++++++++++++++++++++++++++++----
 2 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44ddee921441..4749f743398a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -97,9 +97,11 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+void rcu_nocb_cpu_offload(int cpu);
 void rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline void rcu_nocb_cpu_offload(int cpu) { }
 static inline void rcu_nocb_cpu_deoffload(int cpu) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e4e7e7c4bfb6..eceef6dade9a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1900,6 +1900,20 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
 
+/*
+ * Check if we ignore this rdp.
+ *
+ * We check that without holding the nocb lock but
+ * we make sure not to miss a freshly offloaded rdp
+ * with the current ordering:
+ *
+ *  rdp_offload_toggle()        nocb_gp_enabled_cb()
+ * -------------------------   ----------------------------
+ *    WRITE flags                 LOCK nocb_gp_lock
+ *    LOCK nocb_gp_lock           READ/WRITE nocb_gp_sleep
+ *    READ/WRITE nocb_gp_sleep    UNLOCK nocb_gp_lock
+ *    UNLOCK nocb_gp_lock         READ flags
+ */
 static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
 {
 	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
@@ -1912,6 +1926,11 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 	struct rcu_segcblist *cblist = &rdp->cblist;
 
 	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
+			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_GP);
+			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+				*needwake_state = true;
+		}
 		return true;
 	} else {
 		/*
@@ -1974,6 +1993,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
 			continue; /* No callbacks here, try next. */
 		}
 		if (bypass_ncbs) {
@@ -2025,6 +2046,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		}
 		if (needwake_gp)
 			rcu_gp_kthread_wake();
+		if (needwake_state)
+			swake_up_one(&rdp->nocb_state_wq);
 	}
 
 	my_rdp->nocb_gp_bypass = bypass;
@@ -2130,6 +2153,11 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	WRITE_ONCE(rdp->nocb_cb_sleep, true);
 
 	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB)) {
+			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_CB);
+			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
+				needwake_state = true;
+		}
 		if (rcu_segcblist_ready_cbs(cblist))
 			WRITE_ONCE(rdp->nocb_cb_sleep, false);
 	} else {
@@ -2225,29 +2253,28 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
-static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+static void rdp_offload_toggle(struct rcu_data *rdp,
+			       bool offload, unsigned long flags)
+	__releases(rdp->nocb_lock)
 {
-	unsigned long flags;
 	struct rcu_node *rnp = rdp->mynode;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
-	bool wake_cb = false, wake_gp = false;
+	bool wake_gp = false;
 
-	printk("De-offloading %d\n", rdp->cpu);
-
-	rcu_nocb_lock_irqsave(rdp, flags);
 	raw_spin_lock_rcu_node(rnp);
-	rcu_segcblist_offload(cblist, false);
+	rcu_segcblist_offload(cblist, offload);
 	raw_spin_unlock_rcu_node(rnp);
 
-	if (rdp->nocb_cb_sleep) {
+	if (rdp->nocb_cb_sleep)
 		rdp->nocb_cb_sleep = false;
-		wake_cb = true;
-	}
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	if (wake_cb)
-		swake_up_one(&rdp->nocb_cb_wq);
+	/*
+	 * Ignore former value of nocb_cb_sleep and force wake up as it could
+	 * have been spuriously set to false already.
+	 */
+	swake_up_one(&rdp->nocb_cb_wq);
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 	if (rdp_gp->nocb_gp_sleep) {
@@ -2258,7 +2285,17 @@ static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 
 	if (wake_gp)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
+}
 
+static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+
+	printk("De-offloading %d\n", rdp->cpu);
+
+	rcu_nocb_lock_irqsave(rdp, flags);
+	rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
@@ -2296,6 +2333,68 @@ void rcu_nocb_cpu_deoffload(int cpu)
 	mutex_unlock(&rcu_state.barrier_mutex);
 }
 
+static void __rcu_nocb_rdp_offload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+
+	printk("Offloading %d\n", rdp->cpu);
+	/*
+	 * Can't use rcu_nocb_lock_irqsave() while we are in
+	 * SEGCBLIST_SOFTIRQ_ONLY mode.
+	 */
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	/*
+	 * We didn't take the nocb lock while working on the
+	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
+	 * Every modifications that have been done previously on
+	 * rdp->cblist must be visible remotely by the nocb kthreads
+	 * upon wake up after reading the cblist flags.
+	 *
+	 * The layout against nocb_lock enforces that ordering:
+	 *
+	 *  __rcu_nocb_rdp_offload()   nocb_cb_wait()/nocb_gp_wait()
+	 * -------------------------   ----------------------------
+	 *      WRITE callbacks           rcu_nocb_lock()
+	 *      rcu_nocb_lock()           READ flags
+	 *      WRITE flags               READ callbacks
+	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
+	 */
+	rdp_offload_toggle(rdp, true, flags);
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
+			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+}
+
+static long rcu_nocb_rdp_offload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	__rcu_nocb_rdp_offload(rdp);
+
+	return 0;
+}
+
+void rcu_nocb_cpu_offload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		if (cpu_online(cpu)) {
+			work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+		} else {
+			__rcu_nocb_rdp_offload(rdp);
+		}
+		cpumask_set_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+}
+
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-- 
2.28.0

