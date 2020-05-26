Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F81AAF34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416384AbgDORL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410721AbgDORLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94CB8221E8;
        Wed, 15 Apr 2020 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970660;
        bh=rDKR/hSwatUCdAEQE0XfuCsLUdK+nCykoTq5S51nKBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aecgMlbItxypM+h8Gdhr72rmmQJ97yyk6awFWKekwMUn3d0Q8NLHmq5b3J6qJL10e
         TzqEudltUY+eP8A45SJSKc54YBR8QNg2VO3z6U6wLnH08E3R1pYsegkyivwFEX/Dvj
         eAHaq3pwC3ExW43NgCVAPAkn/bXXTfIJp/ArIut4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/19] rcu: Mark rcu_state.gp_seq to detect more concurrent writes
Date:   Wed, 15 Apr 2020 10:10:49 -0700
Message-Id: <20200415171054.9013-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state structure's gp_seq field is only to be modified by the RCU
grace-period kthread, which is single-threaded.  This commit therefore
enlists KCSAN's help in enforcing this restriction.  This commit applies
KCSAN-specific primitives, so cannot go upstream until KCSAN does.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7c734b2..09ccc29 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1230,7 +1230,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1519,6 +1519,7 @@ static bool rcu_gp_init(void)
 	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
@@ -1805,6 +1806,7 @@ static void rcu_gp_cleanup(void)
 	/* Declare grace period done, trace first to use old GP number. */
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	rcu_state.gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
-- 
2.9.5

