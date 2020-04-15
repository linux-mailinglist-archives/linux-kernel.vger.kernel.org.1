Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F01AAF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410802AbgDORUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404707AbgDORTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:19:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF69214D8;
        Wed, 15 Apr 2020 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971193;
        bh=ovMKnAPlzYZnKPMk0z75BaaEyMP8JPyVH/ZRsJypP4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ZZU2jx0dKEUvOrUu8gv7eFb8LeXCpuHC/ov/AcBUdT8WCImTZBxbps9PfXSzyudb
         +nLiJl6oLu+1upHxH8Rk3sPRNsbpaNq/dkAkLxHXsMzp1v6nxGes1FxYE6C6mM9Uqq
         5q70S7cVrcJa0bwehMJdakk+68yU4Uv6d7/dhq1A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] rcu/tree: Count number of batched kfree_rcu() locklessly
Date:   Wed, 15 Apr 2020 10:19:49 -0700
Message-Id: <20200415171950.9424-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171924.GA9270@paulmck-ThinkPad-P72>
References: <20200415171924.GA9270@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

We can relax the correctness of counting of number of queued objects in
favor of not hurting performance, by locklessly sampling per-cpu
counters. This should be Ok since under high memory pressure, it should not
matter if we are off by a few objects while counting. The shrinker will
still do the reclaim.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Remove unused "flags" variable. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 05dcbf8..aef587e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2939,7 +2939,7 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				krcp->head = NULL;
 			}
 
-			krcp->count = 0;
+			WRITE_ONCE(krcp->count, 0);
 
 			/*
 			 * One work is per one batch, so there are two "free channels",
@@ -3077,7 +3077,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		krcp->head = head;
 	}
 
-	krcp->count++;
+	WRITE_ONCE(krcp->count, krcp->count + 1);
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -3097,15 +3097,13 @@ static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
-	unsigned long flags, count = 0;
+	unsigned long count = 0;
 
 	/* Snapshot count of all CPUs */
 	for_each_online_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->count;
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		count += READ_ONCE(krcp->count);
 	}
 
 	return count;
-- 
2.9.5

