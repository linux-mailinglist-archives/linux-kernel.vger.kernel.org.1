Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2729719D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750755AbgJWOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbgJWOrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:15 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D98442192A;
        Fri, 23 Oct 2020 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464433;
        bh=B4aRM6HF+Lln1UdTU9QEeHoy6YwANoQ5Jn0YtRESQ9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSGyd1Lqtxq/GkGGXHhip0n1N9ldamAKqEMU10cWRt12oEas2S3ALc654yyj6vmMc
         KcxlXeI2Yt6tPFxMWNcIzSyCHjCMuUlkrmUyBFXO6lwe3vU83PFbaxlGYm/qZcExZA
         vrx3ng8zsdQ2vWBqmQB8RhzfovA2keWnpxJCVS9c=
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
Subject: [PATCH 07/16] rcu: De-offloading GP kthread
Date:   Fri, 23 Oct 2020 16:46:40 +0200
Message-Id: <20201023144649.53046-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to de-offload the callbacks processing of an rdp, we must clear
SEGCBLIST_OFFLOAD and notify the GP kthread so that it clears its own
bit flag and ignore the target rdp from its loop. The CB kthread
is also notified the same way. Whoever acknowledges and clears its
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
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_plugin.h | 54 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 33e9d53d2181..432ab20722ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1928,6 +1928,33 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
 
+static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
+{
+	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
+
+	return rcu_segcblist_test_flags(&rdp->cblist, flags);
+}
+
+static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		return true;
+	} else {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We will ignore this rdp until it ever gets re-offloaded.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+			*needwake_state = true;
+		return false;
+	}
+}
+
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -1956,8 +1983,17 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
+		bool needwake_state = false;
+		if (!nocb_gp_enabled_cb(rdp))
+			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
+		if (!nocb_gp_update_state(rdp, &needwake_state)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
+			continue;
+		}
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -2221,8 +2257,9 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	bool wake_cb = false, wake_gp = false;
 	struct rcu_node *rnp = rdp->mynode;
-	bool wake_cb = false;
 	unsigned long flags;
 
 	printk("De-offloading %d\n", rdp->cpu);
@@ -2249,9 +2286,19 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	if (wake_cb)
 		swake_up_one(&rdp->nocb_cb_wq);
 
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (rdp_gp->nocb_gp_sleep) {
+		rdp_gp->nocb_gp_sleep = false;
+		wake_gp = true;
+	}
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
+
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
+
 	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
-
+			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
+							SEGCBLIST_KTHREAD_GP));
 	return 0;
 }
 
@@ -2333,6 +2380,7 @@ void __init rcu_init_nohz(void)
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
 		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
 	}
 	rcu_organize_nocb_kthreads();
 }
-- 
2.25.1

