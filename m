Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C97258008
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgHaSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgHaSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E3621473;
        Mon, 31 Aug 2020 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896883;
        bh=XuNRlE4Rb0hSRg+c1QEP6KvYYPtwrQlse4WEUThoF08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVsn4QKbGl8/6t9B+WYZHaAz6y7ogmQcU7lI/9NfiITH7Q8P7m4Zmzwo2oCo4V2f4
         DW5nEwhNCgvfoRKjbVa3uceSQCnyKHJpA2YxQ6jRrY3JArVbrqGn/y43lSWPUOo8r3
         9vZmTPGpi4GM20gkstYQk6hIFP8M5H6Kp/0Sp3eU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/24] rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
Date:   Mon, 31 Aug 2020 11:01:03 -0700
Message-Id: <20200831180116.32690-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that sysfs can change the value of rcu_divisor at any time, this
commit adds a READ_ONCE to the sole access to that variable.  While in
the area, this commit also adds bounds checking, clamping the value to
a shift that makes sense for a signed long.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acc926f..1dca14c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2362,6 +2362,7 @@ int rcutree_dead_cpu(unsigned int cpu)
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
+	int div;
 	unsigned long flags;
 	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
@@ -2390,7 +2391,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
-	bl = max(rdp->blimit, pending >> rcu_divisor);
+	div = READ_ONCE(rcu_divisor);
+	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
+	bl = max(rdp->blimit, pending >> div);
 	if (unlikely(bl > 100))
 		tlimit = local_clock() + rcu_resched_ns;
 	trace_rcu_batch_start(rcu_state.name,
-- 
2.9.5

