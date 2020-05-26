Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42BD1AAF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410810AbgDORUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406325AbgDORTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:19:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C9A21582;
        Wed, 15 Apr 2020 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971193;
        bh=IyE3J/aTncSnyBZoBTczzrzsDLGlsCLLRR03z4J6/vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+IUYiHk0oQMGWvA/pp771ct6T/H8yTvm8u3NRf7e311xflhb3NujVALTBRSwAgmL
         trb20dupx0l5hAbWl+wSNDdetOo7CA8JwPoo5x4ydpYAa0xUzNwFfNJrWrYgxSJyPp
         NBZg1GD9kKcx6o3jaeCA+HpLbCKOsDOAqDkv5bUs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH tip/core/rcu 4/4] rcu: Add rcu_gp_might_be_stalled()
Date:   Wed, 15 Apr 2020 10:19:50 -0700
Message-Id: <20200415171950.9424-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171924.GA9270@paulmck-ThinkPad-P72>
References: <20200415171924.GA9270@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds rcu_gp_might_be_stalled(), which returns true if there
is some reason to believe that the RCU grace period is stalled.  The use
case is where an RCU free-memory path needs to allocate memory in order
to free it, a situation that should be avoided where possible.

But where it is necessary, there is always the alternative of using
synchronize_rcu() to wait for a grace period in order to avoid the
allocation.  And if the grace period is stalled, allocating memory to
asynchronously wait for it is a bad idea of epic proportions: Far better
to let others use the memory, because these others might actually be
able to free that memory before the grace period ends.

Thus, rcu_gp_might_be_stalled() can be used to help decide whether
allocating memory on an RCU free path is a semi-reasonable course
of action.

Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  1 +
 include/linux/rcutree.h |  1 +
 kernel/rcu/tree_stall.h | 40 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 045c28b..dbf5ac4 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -87,6 +87,7 @@ static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
+static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 45f3f66..fbc2627 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -39,6 +39,7 @@ void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
+bool rcu_gp_might_be_stalled(void);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..4dede00 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -15,10 +15,12 @@
 int sysctl_panic_on_rcu_stall __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
-#define RCU_STALL_DELAY_DELTA	       (5 * HZ)
+#define RCU_STALL_DELAY_DELTA		(5 * HZ)
 #else
-#define RCU_STALL_DELAY_DELTA	       0
+#define RCU_STALL_DELAY_DELTA		0
 #endif
+#define RCU_STALL_MIGHT_DIV		8
+#define RCU_STALL_MIGHT_MIN		(2 * HZ)
 
 /* Limit-check stall timeouts specified at boottime and runtime. */
 int rcu_jiffies_till_stall_check(void)
@@ -40,6 +42,36 @@ int rcu_jiffies_till_stall_check(void)
 }
 EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
 
+/**
+ * rcu_gp_might_be_stalled - Is it likely that the grace period is stalled?
+ *
+ * Returns @true if the current grace period is sufficiently old that
+ * it is reasonable to assume that it might be stalled.  This can be
+ * useful when deciding whether to allocate memory to enable RCU-mediated
+ * freeing on the one hand or just invoking synchronize_rcu() on the other.
+ * The latter is preferable when the grace period is stalled.
+ *
+ * Note that sampling of the .gp_start and .gp_seq fields must be done
+ * carefully to avoid false positives at the beginnings and ends of
+ * grace periods.
+ */
+bool rcu_gp_might_be_stalled(void)
+{
+	unsigned long d = rcu_jiffies_till_stall_check() / RCU_STALL_MIGHT_DIV;
+	unsigned long j = jiffies;
+
+	if (d < RCU_STALL_MIGHT_MIN)
+		d = RCU_STALL_MIGHT_MIN;
+	smp_mb(); // jiffies before .gp_seq to avoid false positives.
+	if (!rcu_gp_in_progress())
+		return false;
+	// Long delays at this point avoids false positive, but a delay
+	// of ULONG_MAX/4 jiffies voids your no-false-positive warranty.
+	smp_mb(); // .gp_seq before second .gp_start
+	// And ditto here.
+	return !time_before(j, READ_ONCE(rcu_state.gp_start) + d);
+}
+
 /* Don't do RCU CPU stall warnings during long sysrq printouts. */
 void rcu_sysrq_start(void)
 {
@@ -104,8 +136,8 @@ static void record_gp_stall_check_time(void)
 
 	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
-	/* Record ->gp_start before ->jiffies_stall. */
-	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
+	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
+	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
 }
-- 
2.9.5

