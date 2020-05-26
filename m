Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B571AAF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410765AbgDORLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410718AbgDORLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3475221734;
        Wed, 15 Apr 2020 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970659;
        bh=Zn8T0qXMV7YOFTrMGGq/sgMTy5x4U/tVlqKtgx6cd7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcbvyz2nruR/MdSV8jptuHaaAZVLahctHXjaFpbsUDQqrdC0CVOQcozcY8VCubuQQ
         kOTM/+Ffnc20KqtdDoqB7IV8hCfFh2htQ/mkcKoLcfDBhSoPRyLCRMpH2iIajoEgjS
         rdvkTV8q4w+LwQxe9zMk6ZJO7m+NVOd9QOYyPrwM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/19] rcu: Expedite first two FQS scans under callback-overload conditions
Date:   Wed, 15 Apr 2020 10:10:45 -0700
Message-Id: <20200415171054.9013-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Even if some CPUs have excessive numbers of callbacks, RCU's grace-period
kthread will still wait normally between successive force-quiescent-state
scans.  The first two are the most important, as they are the ones that
enlist aid from the scheduler when overloaded.  This commit therefore
omits the wait before the first and the second force-quiescent-state
scan under callback-overload conditions.

This approach was inspired by a discussion with Jeff Roberson.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 19 +++++++++++++++----
 kernel/rcu/tree.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4fd3e0f..7c734b2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1624,12 +1624,16 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
-	/* Someone like call_rcu() requested a force-quiescent-state scan. */
+	// If under overload conditions, force an immediate FQS scan.
+	if (*gfp & RCU_GP_FLAG_OVLD)
+		return true;
+
+	// Someone like call_rcu() requested a force-quiescent-state scan.
 	*gfp = READ_ONCE(rcu_state.gp_flags);
 	if (*gfp & RCU_GP_FLAG_FQS)
 		return true;
 
-	/* The current grace period has completed. */
+	// The current grace period has completed.
 	if (!READ_ONCE(rnp->qsmask) && !rcu_preempt_blocked_readers_cgp(rnp))
 		return true;
 
@@ -1667,13 +1671,15 @@ static void rcu_gp_fqs(bool first_time)
 static void rcu_gp_fqs_loop(void)
 {
 	bool first_gp_fqs;
-	int gf;
+	int gf = 0;
 	unsigned long j;
 	int ret;
 	struct rcu_node *rnp = rcu_get_root();
 
 	first_gp_fqs = true;
 	j = READ_ONCE(jiffies_till_first_fqs);
+	if (rcu_state.cbovld)
+		gf = RCU_GP_FLAG_OVLD;
 	ret = 0;
 	for (;;) {
 		if (!ret) {
@@ -1698,7 +1704,11 @@ static void rcu_gp_fqs_loop(void)
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
-			first_gp_fqs = false;
+			gf = 0;
+			if (first_gp_fqs) {
+				first_gp_fqs = false;
+				gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
+			}
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsend"));
 			cond_resched_tasks_rcu_qs();
@@ -1718,6 +1728,7 @@ static void rcu_gp_fqs_loop(void)
 				j = 1;
 			else
 				j = rcu_state.jiffies_force_qs - j;
+			gf = 0;
 		}
 	}
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9dc2ec0..44edd0a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -359,6 +359,7 @@ struct rcu_state {
 /* Values for rcu_state structure's gp_flags field. */
 #define RCU_GP_FLAG_INIT 0x1	/* Need grace-period initialization. */
 #define RCU_GP_FLAG_FQS  0x2	/* Need grace-period quiescent-state forcing. */
+#define RCU_GP_FLAG_OVLD 0x4	/* Experiencing callback overload. */
 
 /* Values for rcu_state structure's gp_state field. */
 #define RCU_GP_IDLE	 0	/* Initial state and no GP in progress. */
-- 
2.9.5

