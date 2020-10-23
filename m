Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579F52971A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465294AbgJWOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465275AbgJWOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:46:59 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD6C21D47;
        Fri, 23 Oct 2020 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464418;
        bh=z9DjhHcx1h9LmI4SgL9WsL2Mn3vD51gyc60iS7+ChRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnXbY++iJCuSrScbKZvaX85/aGqTuzVagluHR/Rvzf/XAizNueVkl/5/NtNmtZj3C
         GwYN+nzbTRFMvkqQGXWSN2ctziIcmGvrMChtushv5x+VXM0KdVVziIfI4WGn7iA9C4
         CsJt4Svhxi6Fo6oDgwLDX8YQQFhzgTPwl7Vrky3k=
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
Subject: [PATCH 01/16] rcu: Implement rcu_segcblist_is_offloaded() config dependent
Date:   Fri, 23 Oct 2020 16:46:34 +0200
Message-Id: <20201023144649.53046-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplify the usage of this API and avoid checking the kernel
config from the callers.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          | 21 +++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293afc07b8..492262bcb591 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -62,7 +62,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef85d69..dc1e578644df 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1603,8 +1603,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2048,8 +2047,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		    rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2248,8 +2246,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2417,8 +2414,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
 	unsigned long flags;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
@@ -2675,8 +2671,7 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2978,8 +2973,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3712,8 +3706,7 @@ static int rcu_pending(int user)
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
-	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-- 
2.25.1

