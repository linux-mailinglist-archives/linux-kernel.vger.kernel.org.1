Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC452EB91C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhAFEvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbhAFEuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FD0222D75;
        Wed,  6 Jan 2021 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908536;
        bh=dEISglmdP/y6+aJkfA4MfKtQcXA7PTpncXr1ksCBqfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GveaXJ2nGXxoe1Q/p9cESudPwrjZc+YYEnkMDKW0WJbDpxCdLj0SLUtux1yLqmXZR
         iJ3MDiUX1mNICXHEytou232P+3+G4hBA/mkLale9dSSD0XJUZsrFkeFEDml1sKuSLo
         3j8p0G7vLdONrP2ZJm8qoJX3ZiNnZO3xeSGon2wodAxaFLFW9+Pl65InE+kHLvWPWq
         DrnnLUUmV1EPujpJlAyyZ8gh4O55aWxTNMvAwoxTmFZBtJwNKAblaXRRLe4UnMqZxb
         HR3c0FEglUJp9ezl3rY52U4K+P0H8++9NHnp9cOtZWXDdMEvkGiMkXov9ZBB6BiEQX
         xCK0g2WruKOyw==
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
Subject: [PATCH tip/core/rcu 08/21] rcu/nocb: Shutdown nocb timer on de-offloading
Date:   Tue,  5 Jan 2021 20:48:40 -0800
Message-Id: <20210106044853.20812-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit ensures that the nocb timer is shut down before reaching the
final de-offloaded state.  The key goal is to prevent the timer handler
from manipulating the callbacks without the protection of the nocb locks.

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
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e0deb48..5d359b9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,6 +257,7 @@ struct rcu_data {
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
+#define RCU_NOCB_WAKE_OFF	-1
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE		1
 #define RCU_NOCB_WAKE_FORCE	2
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 03ae1ce..c88ad62 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1665,6 +1665,8 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 			       const char *reason)
 {
+	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_OFF)
+		return;
 	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
 		mod_timer(&rdp->nocb_timer, jiffies + 1);
 	if (rdp->nocb_defer_wakeup < waketype)
@@ -2243,7 +2245,7 @@ static int rcu_nocb_cb_kthread(void *arg)
 /* Is a deferred wakeup of rcu_nocb_kthread() required? */
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
 {
-	return READ_ONCE(rdp->nocb_defer_wakeup);
+	return READ_ONCE(rdp->nocb_defer_wakeup) > RCU_NOCB_WAKE_NOT;
 }
 
 /* Do a deferred wakeup of rcu_nocb_kthread(). */
@@ -2337,6 +2339,12 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	/* Make sure nocb timer won't stay around */
+	rcu_nocb_lock_irqsave(rdp, flags);
+	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+	del_timer_sync(&rdp->nocb_timer);
+
 	return ret;
 }
 
@@ -2394,6 +2402,8 @@ static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	/* Re-enable nocb timer */
+	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 	/*
 	 * We didn't take the nocb lock while working on the
 	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
-- 
2.9.5

