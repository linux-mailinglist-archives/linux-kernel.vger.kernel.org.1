Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC6258028
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgHaSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgHaSBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:21 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E68214DB;
        Mon, 31 Aug 2020 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896881;
        bh=tZR2A3lVSdYKcsNK/jg5ppYK+cxjeUefRU6Fal4T1+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HddxuTBEu513gHOumDghphNKW3tHVto/W2NN4yOfvbbhvp60/09bXm6G5p8dX01nl
         kORMg08osLf65rHnsZzcEhKcWuW8IVl7x02ohfJeHLrPwNVF12s+7rVvXu5PVrO0Cc
         r1xTt9wRAjUByjjpbPZAzNtLXDggLJ6aI6c+tsEY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/24] rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period tracepoint
Date:   Mon, 31 Aug 2020 11:00:58 -0700
Message-Id: <20200831180116.32690-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

During acceleration of CB, the rsp's gp_seq is rcu_seq_snap'd. This is
the value used for acceleration - it is the value of gp_seq at which it
is safe the execute all callbacks in the callback list.

The rdp's gp_seq is not very useful for this scenario. Make
rcu_grace_period report the gp_seq_req instead as it allows one to
reason about how the acceleration works.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eb36779..8969120 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1483,9 +1483,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+
 	return ret;
 }
 
-- 
2.9.5

