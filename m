Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7724313A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 00:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHLW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 18:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgHLW5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:37 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65E622BEA;
        Wed, 12 Aug 2020 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273057;
        bh=tdQj/IvKGyp501KGFNfZ9iZJnP8uG6XPd6pg3TN+CVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4xrOQ3L3QLUzlvrII896+fn+z0DDwSmuYV/YG0cT1ps86cUwhykTC2GSifVJIuc/
         N4CwVr8Mzey4/mtIVnmAh/b4EdWb5eH6qQvH5589fjlm5h8V/ts3jKhar/Z0vmjO8h
         pnVrvWuy60B/IeDlkaZAHtAcpGpxe9fSWZ5CSNjY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/12] rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs
Date:   Wed, 12 Aug 2020 15:57:32 -0700
Message-Id: <20200812225732.20068-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The CONFIG_PREEMPT=n instance of rcu_read_unlock is even more
aggressively than that of CONFIG_PREEMPT=y in deferring reporting
quiescent states to the RCU core.  This is just what is wanted in normal
use because it reduces overhead, but the resulting delay is not what
is wanted for kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y.
This commit therefore adds an rcu_read_unlock_strict() function that
checks for exceptional conditions, and reports the newly started
quiescent state if it is safe to do so, also doing a spin-delay if
requested via rcutree.rcu_unlock_delay.  This commit also adds a call
to rcu_read_unlock_strict() from the CONFIG_PREEMPT=n instance of
__rcu_read_unlock().

[ paulmck: Fixed bug located by kernel test robot <lkp@intel.com> ]
Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  7 +++++++
 kernel/rcu/tree.c        |  6 ++++++
 kernel/rcu/tree_plugin.h | 23 +++++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b47d6b6..7c1ceff 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -55,6 +55,12 @@ void __rcu_read_unlock(void);
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_TINY_RCU
+#define rcu_read_unlock_strict() do { } while (0)
+#else
+void rcu_read_unlock_strict(void);
+#endif
+
 static inline void __rcu_read_lock(void)
 {
 	preempt_disable();
@@ -63,6 +69,7 @@ static inline void __rcu_read_lock(void)
 static inline void __rcu_read_unlock(void)
 {
 	preempt_enable();
+	rcu_read_unlock_strict();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ac37343..78852ef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -164,6 +164,12 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+// Add delay to rcu_read_unlock() for strict grace periods.
+static int rcu_unlock_delay;
+#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
+module_param(rcu_unlock_delay, int, 0444);
+#endif
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 25c9ee4..0881aef 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -430,12 +430,6 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 	return !list_empty(&rnp->blkd_tasks);
 }
 
-// Add delay to rcu_read_unlock() for strict grace periods.
-static int rcu_unlock_delay;
-#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
-module_param(rcu_unlock_delay, int, 0444);
-#endif
-
 /*
  * Report deferred quiescent states.  The deferral time can
  * be quite short, for example, in the case of the call from
@@ -785,6 +779,23 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
+ * If strict grace periods are enabled, and if the calling
+ * __rcu_read_unlock() marks the beginning of a quiescent state, immediately
+ * report that quiescent state and, if requested, spin for a bit.
+ */
+void rcu_read_unlock_strict(void)
+{
+	struct rcu_data *rdp;
+
+	if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+		return;
+	rdp = this_cpu_ptr(&rcu_data);
+	rcu_report_qs_rdp(rdp->cpu, rdp);
+	udelay(rcu_unlock_delay);
+}
+
+/*
  * Tell them what RCU they are running.
  */
 static void __init rcu_bootup_announce(void)
-- 
2.9.5

