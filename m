Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5029719C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750733AbgJWOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465295AbgJWOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:04 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD2B21527;
        Fri, 23 Oct 2020 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464423;
        bh=GJ9Yrftno530GDDd7RNaX/nsB38HEW1zHyBZIOe1/ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=si1MDXdunj2sKH+VBaHrWqsoxMTkFQ8aGmF4xuc+qjkT3xtK/U1weixMnJ/xVq5Lx
         fNRrTXJ+u482gXSgy4Uj56pfKwR1ydMejt5gpxpoVVr5+0o44TuHZcsa/ZC3ivOpTn
         bWreDhnB0d95dcBOuoENS0MKJDbpEHGLODAXE/+U=
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
Subject: [PATCH 03/16] rcu: Provide basic callback offloading state machine bits
Date:   Fri, 23 Oct 2020 16:46:36 +0200
Message-Id: <20201023144649.53046-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need to be able to runtime offload and de-offload the processing
of callback for a given CPU. In order to support a smooth transition
from unlocked local processing (softirq/rcuc) to locked offloaded
processing (rcuop/rcuog) and the reverse, provide the necessary bits and
documentation for the state machine that will carry up all the steps to
enforce correctness while serving callbacks processing all along.

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
 include/linux/rcu_segcblist.h | 115 +++++++++++++++++++++++++++++++++-
 kernel/rcu/rcu_segcblist.c    |   1 +
 kernel/rcu/rcu_segcblist.h    |  12 +++-
 kernel/rcu/tree.c             |   3 +
 4 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index dca2f39ee67f..8a0d3a211e7c 100644
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
+ *  | allowing nocb_timer to be armed.                                        |
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
index e6522fa54311..a96511b7cc98 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -172,6 +172,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
 	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index fc98761e3ee9..575896a2518b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -80,8 +80,16 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
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
index dc1e578644df..3b7adc9cc068 100644
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
2.25.1

