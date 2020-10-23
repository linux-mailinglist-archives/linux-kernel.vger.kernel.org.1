Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDB2971A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbgJWOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbgJWOrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:17 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BF02463D;
        Fri, 23 Oct 2020 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464436;
        bh=UsiYJI2YlbC1/sQRx3MvtVEr3vWhXr0FR/bA1gG1oq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlQeySZWS6ZcHVl2DVvczGWB7rLpAXDw6b8R+j39hd2NVKGe9CIegzoBe7f2IAScl
         p+CbXjSiWQuUO8/uNFa+yzSzY51hL2og7cOteA07nYWBV0GZ7jMDmaS9O+btFrb4Zl
         4OLDxG4W9GEKARN03fhQPu0t3dsM3+Q7x/RYHokw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 08/16] rcu: Re-offload support
Date:   Fri, 23 Oct 2020 16:46:41 +0200
Message-Id: <20201023144649.53046-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
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
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 include/linux/rcupdate.h |   2 +
 kernel/rcu/tree_plugin.h | 157 +++++++++++++++++++++++++++++++++------
 2 files changed, 138 insertions(+), 21 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bf8eb02411c2..f5ad5d0051c4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -104,9 +104,11 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+int rcu_nocb_cpu_offload(int cpu);
 int rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
 static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 432ab20722ff..c0474e985f44 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1928,6 +1928,20 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
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
@@ -1940,6 +1954,11 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
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
@@ -2003,6 +2022,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
 			continue; /* No callbacks here, try next. */
 		}
 		if (bypass_ncbs) {
@@ -2054,6 +2075,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		}
 		if (needwake_gp)
 			rcu_gp_kthread_wake();
+		if (needwake_state)
+			swake_up_one(&rdp->nocb_state_wq);
 	}
 
 	my_rdp->nocb_gp_bypass = bypass;
@@ -2159,6 +2182,11 @@ static void nocb_cb_wait(struct rcu_data *rdp)
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
@@ -2254,37 +2282,28 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
-static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+static int rdp_offload_toggle(struct rcu_data *rdp,
+			       bool offload, unsigned long flags)
+	__releases(rdp->nocb_lock)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
-	bool wake_cb = false, wake_gp = false;
 	struct rcu_node *rnp = rdp->mynode;
-	unsigned long flags;
+	bool wake_gp = false;
 
-	printk("De-offloading %d\n", rdp->cpu);
-
-	rcu_nocb_lock_irqsave(rdp, flags);
-	/*
-	 * If there are still pending work offloaded, the offline
-	 * CPU won't help much handling them.
-	 */
-	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		return -EBUSY;
-	}
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
@@ -2296,10 +2315,32 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	if (wake_gp)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
 
+	return 0;
+}
+
+static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+	int ret;
+
+	printk("De-offloading %d\n", rdp->cpu);
+
+	rcu_nocb_lock_irqsave(rdp, flags);
+	/*
+	 * If there are still pending work offloaded, the offline
+	 * CPU won't help much handling them.
+	 */
+	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return -EBUSY;
+	}
+
+	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	return 0;
+	return ret;
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
@@ -2336,6 +2377,80 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	return ret;
 }
 
+static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * For now we only support re-offload, ie: the rdp must have been
+	 * offloaded on boot first.
+	 */
+	if (!rdp->nocb_gp_rdp)
+		return -EINVAL;
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
+	ret = rdp_offload_toggle(rdp, true, flags);
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
+			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+
+	return ret;
+}
+
+static long rcu_nocb_rdp_offload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	return __rcu_nocb_rdp_offload(rdp);
+}
+
+int rcu_nocb_cpu_offload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int ret = 0;
+
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		if (cpu_online(cpu)) {
+			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+		} else {
+			ret = __rcu_nocb_rdp_offload(rdp);
+		}
+		if (!ret)
+			cpumask_set_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+
+	return ret;
+}
+
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-- 
2.25.1

