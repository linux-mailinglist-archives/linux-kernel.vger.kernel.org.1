Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502DA2EB798
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAFB1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbhAFB1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:27:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B953230FC;
        Wed,  6 Jan 2021 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896379;
        bh=/Nw8vrzy/x+qlYBNj90for1lkgErSVuRhx3BK1hqFJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bF6puBt6GWW31mEPL9X279/7Hw9qDU/hzHJVOB5N699+HLClND4SnHSQ1uj8DNgzU
         +ntBNZUwmH9aT7zoJTAPCEb47UfjHNmqD44DaCcJMMlG1/19eaBOuicb7i0SEluGgB
         YqODRcO7WLB5h9uSrdoO3iDw5b9PTRwbV0ouAxjsm02RevnqmC1v3SPln+vXH0CRwK
         Ke1bdmICXPH3zQweThA11JpPiR20RXEOEVlAY1vj+D4yX1ucohYhhyePaLxtLhuNnm
         +qS2L98ewvHfoPowBtRUcmQiA9IxAIJJ9+PeOtfnbnPJpjrQUwC5bWoy5jxDf6AitE
         xxJ8I5gsMDKrw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/6] rcu/trace: Add tracing for how segcb list changes
Date:   Tue,  5 Jan 2021 17:26:16 -0800
Message-Id: <20210106012617.14122-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106012541.GA13972@paulmck-ThinkPad-P72>
References: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit adds tracing to track how the segcb list changes before/after
acceleration, during queuing and during dequeuing.

This tracing helped discover an optimization that avoided needless GP
requests when no callbacks were accelerated. The tracing overhead is
minimal as each segment's length is now stored in the respective segment.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 26 ++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  9 +++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb..5fc2940 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -505,6 +505,32 @@ TRACE_EVENT_RCU(rcu_callback,
 		  __entry->qlen)
 );
 
+TRACE_EVENT_RCU(rcu_segcb_stats,
+
+		TP_PROTO(struct rcu_segcblist *rs, const char *ctx),
+
+		TP_ARGS(rs, ctx),
+
+		TP_STRUCT__entry(
+			__field(const char *, ctx)
+			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
+			__array(long, seglen, RCU_CBLIST_NSEGS)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->seglen, rs->seglen, RCU_CBLIST_NSEGS * sizeof(long));
+			memcpy(__entry->gp_seq, rs->gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
+
+		),
+
+		TP_printk("%s seglen: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld) "
+			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  __entry->seglen[0], __entry->seglen[1], __entry->seglen[2], __entry->seglen[3],
+			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
+
+);
+
 /*
  * Tracepoint for the registration of a single RCU callback of the special
  * kvfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b0fb654..6bf269c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1495,6 +1495,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1515,6 +1517,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
+
 	return ret;
 }
 
@@ -2471,11 +2475,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
+
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2987,6 +2994,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
+
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
-- 
2.9.5

