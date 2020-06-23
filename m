Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AFD20457A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbgFWAdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbgFWAdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:33:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E8520842;
        Tue, 23 Jun 2020 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872414;
        bh=VHZgVEAhwsSJM7OX7oYiFoaSmczrxXr+ctheCpQ/cf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2w/wIcmKKBf1bacnTl6KzKrr7Rem2HCwLia0IR+jUECSbcu28G7B5C6VRk5AJJZ3
         OfZ4kSYQrdPJWkPVpNbomldJc5pqboBy2I/istDYEAqxraL0lvIbzgyeSJ5Tl1irDa
         gRgNY1EWHtn6maletYvFadLHra5rULL+xDl1hvSk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] srcu: Avoid local_irq_save() before acquiring spinlock_t
Date:   Mon, 22 Jun 2020 17:33:32 -0700
Message-Id: <20200623003333.26611-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003310.GA26539@paulmck-ThinkPad-P72>
References: <20200623003310.GA26539@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

SRCU disables interrupts to get a stable per-CPU pointer and then
acquires the spinlock which is in the per-CPU data structure. The
release uses spin_unlock_irqrestore(). While this is correct on a non-RT
kernel, this conflicts with the RT semantics because the spinlock is
converted to a 'sleeping' spinlock. Sleeping locks can obviously not be
acquired with interrupts disabled.

Acquire the per-CPU pointer `ssp->sda' without disabling preemption and
then acquire the spinlock_t of the per-CPU data structure. The lock will
ensure that the data is consistent.

The added call to check_init_srcu_struct() is now needed because a
statically defined srcu_struct may remain uninitialized until this
point and the newly introduced locking operation requires an initialized
spinlock_t.

This change was tested for four hours with 8*SRCU-N and 8*SRCU-P without
causing any warnings.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8ff71e5..c100acf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -777,14 +777,15 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long t;
 	unsigned long tlast;
 
+	check_init_srcu_struct(ssp);
 	/* If the local srcu_data structure has callbacks, not idle.  */
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
-		local_irq_restore(flags);
+		spin_unlock_irqrestore_rcu_node(sdp, flags);
 		return false; /* Callbacks already present, so not idle. */
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
 	 * No local callbacks, so probabalistically probe global state.
@@ -864,9 +865,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	}
 	rhp->func = func;
 	idx = srcu_read_lock(ssp);
-	local_irq_save(flags);
-	sdp = this_cpu_ptr(ssp->sda);
-	spin_lock_rcu_node(sdp);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
 	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
-- 
2.9.5

