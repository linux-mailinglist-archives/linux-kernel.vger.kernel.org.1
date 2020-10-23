Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB22971A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750779AbgJWOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbgJWOrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:20 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98B9223EA;
        Fri, 23 Oct 2020 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464439;
        bh=/shH/6x5lyzFB31h/j/4CRuAm8RphdCa0gXlIB9G3dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oX5AA2tV9UpUuIS9+u9j4S3WxyLcWOZYxSJbYtmOnehj3cvHR32R+8j1m9QoUAlKl
         PF/GqYIuAC2fOgkPEr3qvMsAnQG1chq5yUudmhqJ5CxjUuT5YlbmzIwTuFCeeQvAD4
         3fMB7Q8UYL91NbOXHBvfwt5cckjqaokWvZV9BQRk=
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
Subject: [PATCH 09/16] rcu: Shutdown nocb timer on de-offloading
Date:   Fri, 23 Oct 2020 16:46:42 +0200
Message-Id: <20201023144649.53046-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the nocb timer can't fire anymore before we reach the final
de-offload state. Spuriously waking up the GP kthread is no big deal but
we must prevent from executing the timer callback without nocb locking.

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
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 8047102be878..5a4e23782340 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -256,6 +256,7 @@ struct rcu_data {
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
+#define RCU_NOCB_WAKE_OFF	-1
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE		1
 #define RCU_NOCB_WAKE_FORCE	2
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c0474e985f44..c44b83b79196 100644
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
@@ -2340,6 +2342,12 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
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
 
@@ -2396,6 +2404,8 @@ static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	/* Re-enable nocb timer */
+	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 	/*
 	 * We didn't take the nocb lock while working on the
 	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
-- 
2.25.1

