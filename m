Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD06258022
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgHaSDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgHaSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B06121548;
        Mon, 31 Aug 2020 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896882;
        bh=1xaEATgxVssMo8h40PwAundYZZ+vcxu3i/w1PXTLMjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPRgrEuDfiRl2NCyQlI7gIrzFRX38r5iDcewFZDLkIYkMZ96EynY1w5bHmwNh4P45
         epl+t+fAUU2QiuN+dJTxwKkigEt2w2k964+2Kg6wbZ2freYryN3tQhypTFQZJkB+uh
         6yrN3gxo3LFghBdU2hy5DPxRAJz0iuffjdvWvh6E=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/24] nocb: Remove show_rcu_nocb_state() false positive printout
Date:   Mon, 31 Aug 2020 11:01:02 -0700
Message-Id: <20200831180116.32690-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_data structure's ->nocb_timer field is used to defer wakeups of
the corresponding no-CBs CPU's grace-period kthread ("rcuog*"), and that
structure's ->nocb_defer_wakeup field is used to track such deferral.
This means that the show_rcu_nocb_state() printing an error when those
fields are set for a CPU not corresponding to a no-CBs grace-period
kthread is erroneous.

This commit therefore switches the check from ->nocb_timer to
->nocb_bypass_timer and removes the check of ->nocb_defer_wakeup.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bbc0c07..4d63ee3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2411,10 +2411,9 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		return;
 
 	waslocked = raw_spin_is_locked(&rdp->nocb_gp_lock);
-	wastimer = timer_pending(&rdp->nocb_timer);
+	wastimer = timer_pending(&rdp->nocb_bypass_timer);
 	wassleep = swait_active(&rdp->nocb_gp_wq);
-	if (!rdp->nocb_defer_wakeup && !rdp->nocb_gp_sleep &&
-	    !waslocked && !wastimer && !wassleep)
+	if (!rdp->nocb_gp_sleep && !waslocked && !wastimer && !wassleep)
 		return;  /* Nothing untowards. */
 
 	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
-- 
2.9.5

