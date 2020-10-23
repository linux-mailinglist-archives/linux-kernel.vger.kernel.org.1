Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA22971A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbgJWOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbgJWOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:30 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2600321D47;
        Fri, 23 Oct 2020 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464449;
        bh=yRKCwn9GsqzFOHTN8PIJL9z3UqebQQ2YbRzGZmEaHRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ6BQdzo5xOyfCd6tucME8UdIeddccQ5t5zosfSJVGWuPG4XOzOGMVMPac8nUshhR
         JSjjIejgU9UQ6ne9G6fypiEMw3XsDSxCvkejZflOUBMknqed/FaupNiPlPjgR/eIDf
         73pG2rxMP1Tfnzblmw+bPbJfAJjaliRpxN6r8nIE=
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
Subject: [PATCH 13/16] rcu: Process batch locally as long as offloading isn't complete
Date:   Fri, 23 Oct 2020 16:46:46 +0200
Message-Id: <20201023144649.53046-14-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the offloading or de-offloading process, make sure to process
the callbacks batch locally whenever the segcblist isn't entirely
offloaded. This enforces callback service processing while we are still
in intermediate (de-)offloading state.

FIXME: Note that __call_rcu_core() isn't called during these intermediate
states. Some pieces there may still be necessary.

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
 kernel/rcu/rcu_segcblist.h | 12 ++++++++++++
 kernel/rcu/tree.c          |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 00ebeb8d39b7..f7da3d535888 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -92,6 +92,18 @@ static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 	return false;
 }
 
+static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rsclp)
+{
+	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
+
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
+		if ((rsclp->flags & flags) == flags)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Are all segments following the specified segment of the specified
  * rcu_segcblist structure empty of callbacks?  (The specified
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35834ce2d042..45fad6977bea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2674,6 +2674,7 @@ static __latent_entropy void rcu_core(void)
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2703,7 +2704,7 @@ static __latent_entropy void rcu_core(void)
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist) &&
+	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
 	    likely(READ_ONCE(rcu_scheduler_fully_active)))
 		rcu_do_batch(rdp);
 
-- 
2.25.1

