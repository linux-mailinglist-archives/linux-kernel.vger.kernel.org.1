Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE0B258007
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHaSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgHaSBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87B421534;
        Mon, 31 Aug 2020 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896882;
        bh=/yTUs0FVay3sAqB0eTJiMOJcG5gY0G1ZMAr1sjY9mug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnwei98lujhVttzUCeKUU0xGi31zidZO/Lm2XPrwytbawfMewQLxQfdY6OMCInimR
         XFXFquMbwxTfPS1jIEqR745GejCR+25BcsaTtSdpuUA2sTX2JIvzDCELIqaSQD2cN4
         eb3rGjzN8wAItKpFxpOqNZiJ+LpDNbfvtfJSYpoY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/24] rcu/tree: Force quiescent state on callback overload
Date:   Mon, 31 Aug 2020 11:01:00 -0700
Message-Id: <20200831180116.32690-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

On callback overload, it is necessary to quickly detect idle CPUs,
and rcu_gp_fqs_check_wake() checks for this condition.  Unfortunately,
the code following the call to this function does not repeat this check,
which means that in reality no actual quiescent-state forcing, instead
only a couple of quick and pointless wakeups at the beginning of the
grace period.

This commit therefore adds a check for the RCU_GP_FLAG_OVLD flag in
the post-wakeup "if" statement in rcu_gp_fqs_loop().

Fixes: 1fca4d12f4637 ("rcu: Expedite first two FQS scans under callback-overload conditions")
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8969120..4770d77 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1884,7 +1884,7 @@ static void rcu_gp_fqs_loop(void)
 			break;
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
-		    (gf & RCU_GP_FLAG_FQS)) {
+		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
-- 
2.9.5

