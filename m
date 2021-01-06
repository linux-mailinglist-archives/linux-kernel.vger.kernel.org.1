Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC442EB90B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAFEtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbhAFEth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:49:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096E022D71;
        Wed,  6 Jan 2021 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908535;
        bh=LaCgiZP9vejc56otFJ7dgXSgGqWJkqPSfYsS5/A5Ufk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXznyIXz+k3+KwsGGJcuZeErRs1eLxHTDNjdW9jP3tLprxRioybcuaCio/d6JR1Ev
         f/tJlrRwUAWNdYD4j1Yi/y6Vszt273Sw+ECPPUOWGnInvG5Rc8X7E4n0NzHCXeOhKz
         dq13bQtP14oQCClsj4Mol9CPq0eBMsAcVH0VBkS+RzNn/BB6+Bud5jpE8nTGsxgOJJ
         r7uvTkFUoFAx7S/Rx0UIove4THSQ9zWqtA347I8XI+sb75xIDfn5aY0pcQWm2NTc1V
         QG6zRdg9kwUZR6JeDj7TLenJdS8oqlPq6SpkaHGgjpQU0uVnRjmFjkB9PBk4ekhcFY
         mVueQsP5AGqUg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/21] rcu/nocb: Provide basic callback offloading state machine bits
Date:   Tue,  5 Jan 2021 20:48:34 -0800
Message-Id: <20210106044853.20812-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Offloading and de-offloading RCU callback processes must be done
carefully.  There must never be a time at which callback processing is
disabled because the task driving the offloading or de-offloading might be
preempted or otherwise stalled at that point in time, which would result
in OOM due to calbacks piling up indefinitely.  This implies that there
will be times during which a given CPU's callbacks might be concurrently
invoked by both that CPU's RCU_SOFTIRQ handler (or, equivalently, that
CPU's rcuc kthread) and by that CPU's rcuo kthread.

This situation could fatally confuse both rcu_barrier() and the
CPU-hotplug offlining process, so these must be excluded during any
concurrent-callback-invocation period.  In addition, during times of
concurrent callback invocation, changes to ->cblist must be protected
both as needed for RCU_SOFTIRQ and as needed for the rcuo kthread.

This commit therefore defines and documents the states for a state
machine that coordinates offloading and deoffloading.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 115 +++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/rcu_segcblist.c    |   1 +
 kernel/rcu/rcu_segcblist.h    |  12 ++++-
 kernel/rcu/tree.c             |   3 ++
 4 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 4714b02..8afe886 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -63,8 +63,121 @@ struct rcu_cblist {
 #define RCU_NEXT_TAIL		3
 #define RCU_CBLIST_NSEGS	4
 
+
+/*
+ *                     ==NOCB Offloading state machine==
+ *
+ *
+ *  ----------------------------------------------------------------------------
+ *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                                                                          |
+ *  |  Callbacks processed by rcu_core() from softirqs or local                |
+ *  |  rcuc kthread, without holding nocb_lock.                                |
+ *  ----------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *  ----------------------------------------------------------------------------
+ *  |                        SEGCBLIST_OFFLOADED                               |
+ *  |                                                                          |
+ *  | Callbacks processed by rcu_core() from softirqs or local                 |
+ *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads,     |
+ *  | allowing nocb_timer to be armed.                                         |
+ *  ----------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *                        -----------------------------------
+ *                        |                                 |
+ *                        v                                 v
+ *  ---------------------------------------  ----------------------------------|
+ *  |        SEGCBLIST_OFFLOADED |        |  |     SEGCBLIST_OFFLOADED |       |
+ *  |        SEGCBLIST_KTHREAD_CB         |  |     SEGCBLIST_KTHREAD_GP        |
+ *  |                                     |  |                                 |
+ *  |                                     |  |                                 |
+ *  | CB kthread woke up and              |  | GP kthread woke up and          |
+ *  | acknowledged SEGCBLIST_OFFLOADED.   |  | acknowledged SEGCBLIST_OFFLOADED|
+ *  | Processes callbacks concurrently    |  |                                 |
+ *  | with rcu_core(), holding            |  |                                 |
+ *  | nocb_lock.                          |  |                                 |
+ *  ---------------------------------------  -----------------------------------
+ *                        |                                 |
+ *                        -----------------------------------
+ *                                         |
+ *                                         v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
+ *  |   handling callbacks.                                                    |
+ *  ----------------------------------------------------------------------------
+ */
+
+
+
+/*
+ *                       ==NOCB De-Offloading state machine==
+ *
+ *
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
+ *  |   ignores callbacks.                                                     |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *                     -----------------------------------
+ *                     |                                 |
+ *                     v                                 v
+ *  ---------------------------------------------------------------------------|
+ *  |                                                                          |
+ *  |        SEGCBLIST_KTHREAD_CB         |       SEGCBLIST_KTHREAD_GP         |
+ *  |                                     |                                    |
+ *  | GP kthread woke up and              |   CB kthread woke up and           |
+ *  | acknowledged the fact that          |   acknowledged the fact that       |
+ *  | SEGCBLIST_OFFLOADED got cleared.    |   SEGCBLIST_OFFLOADED got cleared. |
+ *  |                                     |   The CB kthread goes to sleep     |
+ *  | The callbacks from the target CPU   |   until it ever gets re-offloaded. |
+ *  | will be ignored from the GP kthread |                                    |
+ *  | loop.                               |                                    |
+ *  ----------------------------------------------------------------------------
+ *                      |                                 |
+ *                      -----------------------------------
+ *                                      |
+ *                                      v
+ *  ----------------------------------------------------------------------------
+ *  |                                   0                                      |
+ *  |                                                                          |
+ *  | Callbacks processed by rcu_core() from softirqs or local                 |
+ *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
+ *  | Flush pending nocb_timer. Flush nocb bypass callbacks.                   |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  ----------------------------------------------------------------------------
+ *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                                                                          |
+ *  |  Callbacks processed by rcu_core() from softirqs or local                |
+ *  |  rcuc kthread, without holding nocb_lock.                                |
+ *  ----------------------------------------------------------------------------
+ */
 #define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_OFFLOADED	BIT(1)
+#define SEGCBLIST_SOFTIRQ_ONLY	BIT(1)
+#define SEGCBLIST_KTHREAD_CB	BIT(2)
+#define SEGCBLIST_KTHREAD_GP	BIT(3)
+#define SEGCBLIST_OFFLOADED	BIT(4)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 406c67b..ae3010a 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -266,6 +266,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
 	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index ff372db..e05952ab 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -83,8 +83,16 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED);
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
+		/*
+		 * Complete de-offloading happens only when SEGCBLIST_SOFTIRQ_ONLY
+		 * is set.
+		 */
+		if (!rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
+			return true;
+	}
+
+	return false;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8086c04..7cfc2e8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -83,6 +83,9 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+#ifdef CONFIG_RCU_NOCB_CPU
+	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
+#endif
 };
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
-- 
2.9.5

