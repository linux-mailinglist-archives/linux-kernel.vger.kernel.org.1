Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EFD1AAF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410747AbgDORLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410714AbgDORK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DC121D7D;
        Wed, 15 Apr 2020 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970658;
        bh=DQWTvjwnLmiCUalD0XDh/DYIC8pSGj8yRWhtzs+grG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdszHhMt3nNLyzjKCYkrwkUc+iB93Ncr2T/qpHjl0w497k0w12iNnJL+rajNCZ5TR
         At7G1e3d1sVuNA1iG/qnYwArW92SmtZolgy9wgDpsXIfPaCDMd/YTnaky4+PUHu92Z
         Ei353dYQI5tkBmwboNXXu5mQUDfMJ/O2N9E5Mg4s=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/19] rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks
Date:   Wed, 15 Apr 2020 10:10:42 -0700
Message-Id: <20200415171054.9013-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->boost_tasks field is read locklessly, so this
commit adds the WRITE_ONCE() to an update in order to provide proper
documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ed6bb46..664d0aa 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -505,7 +505,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
 			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
 			if (&t->rcu_node_entry == rnp->boost_tasks)
-				rnp->boost_tasks = np;
+				WRITE_ONCE(rnp->boost_tasks, np);
 		}
 
 		/*
@@ -1082,7 +1082,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	     rnp->qsmask == 0 &&
 	     (ULONG_CMP_GE(jiffies, rnp->boost_time) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
-			rnp->boost_tasks = rnp->gp_tasks;
+			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		rcu_wake_cond(rnp->boost_kthread_task,
 			      READ_ONCE(rnp->boost_kthread_status));
-- 
2.9.5

