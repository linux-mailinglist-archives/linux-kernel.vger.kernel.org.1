Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE271AB036
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411580AbgDOR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416569AbgDOR4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:56:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3426221556;
        Wed, 15 Apr 2020 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973377;
        bh=D8ed2PhUR/zT6L02123gyeYZA8qQ3iGfhTtELgeSi6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6qddKPvqYR+uuApYtZRklP30Cxtd6Umr2TqMifcUsavOEAfbh68D8drKu6dgD9mx
         hiYpLtaakKvjFkjTOI0D0uDD6deZT7hZ0xGwu7Ki5w7HQs7oNORpX3oOTRFIiuKo/l
         +WcqiQ5x5inpUb29jF7hFMe/vX6i4YLVipYgvSfE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/6] rcu: Don't set nesting depth negative in rcu_preempt_deferred_qs()
Date:   Wed, 15 Apr 2020 10:56:11 -0700
Message-Id: <20200415175614.10837-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415175543.GA10416@paulmck-ThinkPad-P72>
References: <20200415175543.GA10416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Now that RCU flavors have been consolidated, an RCU-preempt
rcu_read_unlock() in an interrupt or softirq handler cannot possibly
end the RCU read-side critical section.  Consider the old vulnerability
involving rcu_preempt_deferred_qs() being invoked within such a handler
that interrupted an extended RCU read-side critical section, in which
a wakeup might be invoked with a scheduler lock held.  Because
rcu_read_unlock_special() no longer does wakeups in such situations,
it is no longer necessary for rcu_preempt_deferred_qs() to set the
nesting level negative.

This commit therfore removes this recursion-protection code from
rcu_preempt_deferred_qs().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fix typo in commit log per Steve Rostedt. ]
---
 kernel/rcu/tree_plugin.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ccad776..263c766 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -569,16 +569,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = rcu_preempt_depth() >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
-	if (couldrecurse)
-		rcu_preempt_depth_set(rcu_preempt_depth() - RCU_NEST_BIAS);
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
-	if (couldrecurse)
-		rcu_preempt_depth_set(rcu_preempt_depth() + RCU_NEST_BIAS);
 }
 
 /*
-- 
2.9.5

