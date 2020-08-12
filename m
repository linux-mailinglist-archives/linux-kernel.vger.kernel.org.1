Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8464324313C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 00:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHLW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 18:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgHLW5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB25A22B43;
        Wed, 12 Aug 2020 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273055;
        bh=CW/aiQFmNWSWU6f2QI56vpnzZ0xECq7LXPOVqeXxrh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CF18Bh5zZd1ef4p5C5HDp8ufrUjEmyeKyoVdapM3e1bCEUAObxp5rBWTv1jo2/oWv
         ukvFHokvenfhcEC0SGMBzh4/JWHzYQzyMHgp4/NUl3tPFPwXlnHWAhF0cHLUnvhU/g
         fnyIA3vfrdyiBFhSPhtHk1XIlY6e3ME39sq2UpRE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/12] rcu: Attempt QS when CPU discovers GP for strict GPs
Date:   Wed, 12 Aug 2020 15:57:27 -0700
Message-Id: <20200812225732.20068-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

A given CPU normally notes a new grace period during one RCU_SOFTIRQ,
but avoids reporting the corresponding quiescent state until some later
RCU_SOFTIRQ.  This leisurly approach improves efficiency by increasing
the number of update requests served by each grace period, but is not
what is needed for kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y.

This commit therefore adds a new rcu_strict_gp_check_qs() function
which, in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, simply enters and
immediately exist an RCU read-side critical section.  If the CPU is
in a quiescent state, the rcu_read_unlock() will attempt to report an
immediate quiescent state.  This rcu_strict_gp_check_qs() function is
invoked from note_gp_changes(), so that a CPU just noticing a new grace
period might immediately report a quiescent state for that grace period.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 08cc91c..4353a1a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1557,6 +1557,19 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 }
 
 /*
+ * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, attempt to generate a
+ * quiescent state.  This is intended to be invoked when the CPU notices
+ * a new grace period.
+ */
+static void rcu_strict_gp_check_qs(void)
+{
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
+		rcu_read_lock();
+		rcu_read_unlock();
+	}
+}
+
+/*
  * Update CPU-local rcu_data state to record the beginnings and ends of
  * grace periods.  The caller must hold the ->lock of the leaf rcu_node
  * structure corresponding to the current CPU, and must have irqs disabled.
@@ -1626,6 +1639,7 @@ static void note_gp_changes(struct rcu_data *rdp)
 	}
 	needwake = __note_gp_changes(rnp, rdp);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	rcu_strict_gp_check_qs();
 	if (needwake)
 		rcu_gp_kthread_wake();
 }
-- 
2.9.5

