Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92A258026
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgHaSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgHaSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A4020E65;
        Mon, 31 Aug 2020 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896882;
        bh=NnGBpXZSq43kSLTyDI5C4JhFIRLf2MDu2t6S3WvNpMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xoxcJ1hEipPyQBXUNQoix5s52okU3v66/+hDxo/vDOaksDOFWDjAtoNoktp5TOf1l
         j/YXMwojSX7SHU/RMUhypVUrd1ijYQUYAnnZlhWiKW3aLcD77s4EpCQuceK5rkkbul
         Swj/ibwBMRo2/EObs9Aj79WyrTuosFm+pStBkHUg=
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
Subject: [PATCH tip/core/rcu 09/24] rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp()
Date:   Mon, 31 Aug 2020 11:01:01 -0700
Message-Id: <20200831180116.32690-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

Originally, the call to rcu_preempt_blocked_readers_cgp() from
force_qs_rnp() had to be conditioned on CONFIG_PREEMPT_RCU=y, as in
commit a77da14ce9af ("rcu: Yet another fix for preemption and CPU
hotplug").  However, there is now a CONFIG_PREEMPT_RCU=n definition of
rcu_preempt_blocked_readers_cgp() that unconditionally returns zero, so
invoking it is now safe.  In addition, the CONFIG_PREEMPT_RCU=n definition
of rcu_initiate_boost() simply releases the rcu_node structure's ->lock,
which is what happens when the "if" condition evaluates to false.

This commit therefore drops the IS_ENABLED(CONFIG_PREEMPT_RCU) check,
so that rcu_initiate_boost() is called only in CONFIG_PREEMPT_RCU=y
kernels when there are readers blocking the current grace period.
This does not change the behavior, but reduces code-reader confusion by
eliminating non-CONFIG_PREEMPT_RCU=y calls to rcu_initiate_boost().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4770d77..acc926f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2533,8 +2533,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
-			    rcu_preempt_blocked_readers_cgp(rnp)) {
+			if (rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
 				 * are all zero.  But we might need to
-- 
2.9.5

