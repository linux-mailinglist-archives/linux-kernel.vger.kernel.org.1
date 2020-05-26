Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFD1AAFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411160AbgDORbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411118AbgDORbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB6D215A4;
        Wed, 15 Apr 2020 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971863;
        bh=1qeWbvW4fL8yBq/JttGNQkhQoEYzZoDIwEEDOavZlfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1zB/vhmI/s9OYca/hrjhIKQRoI2wk4/1aXm+CFZMyTVC9s+nuBcdSucEz1hl3+UO
         wm+2yl060/u7zs1OxxZFKM3D6A0PY6fLxVA28cg1dB+HCuHRPGvpvEp9ra1dKQl5ND
         hvMe//EruatZajsFboEOdt0bGWDjI8sRdbwPkNao=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/18] rcutorture: Add flag to produce non-busy-wait task stalls
Date:   Wed, 15 Apr 2020 10:30:48 -0700
Message-Id: <20200415173100.9927-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit aids testing of RCU task stall warning messages by adding
an rcutorture.stall_cpu_block module parameter that results in the
induced stall sleeping within the RCU read-side critical section.
Spinning with interrupts disabled is still available via the
rcutorture.stall_cpu_irqsoff module parameter, and specifying neither
of these two module parameters will spin with preemption disabled.

Note that sleeping (as opposed to preemption) results in additional
complaints from RCU at context-switch time, so yet more testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/rcu/rcutorture.c                         | 17 +++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8..ad12b39 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4210,6 +4210,11 @@
 			Duration of CPU stall (s) to test RCU CPU stall
 			warnings, zero to disable.
 
+	rcutorture.stall_cpu_block= [KNL]
+			Sleep while stalling if set.  This will result
+			in warnings from preemptible RCU in addition
+			to any other stall-related activity.
+
 	rcutorture.stall_cpu_holdoff= [KNL]
 			Time to wait (s) after boot before inducing stall.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d0345d1..60dc368 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -114,6 +114,7 @@ torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
 torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
+torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
@@ -1548,6 +1549,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "test_boost=%d/%d test_boost_interval=%d "
 		 "test_boost_duration=%d shutdown_secs=%d "
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
+		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
@@ -1556,6 +1558,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 test_boost, cur_ops->can_boost,
 		 test_boost_interval, test_boost_duration, shutdown_secs,
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
+		 stall_cpu_block,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff);
 }
@@ -1611,6 +1614,7 @@ static int rcutorture_booster_init(unsigned int cpu)
  */
 static int rcu_torture_stall(void *args)
 {
+	int idx;
 	unsigned long stop_at;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
@@ -1622,21 +1626,22 @@ static int rcu_torture_stall(void *args)
 	if (!kthread_should_stop()) {
 		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
-		rcu_read_lock();
+		idx = cur_ops->readlock();
 		if (stall_cpu_irqsoff)
 			local_irq_disable();
-		else
+		else if (!stall_cpu_block)
 			preempt_disable();
 		pr_alert("rcu_torture_stall start on CPU %d.\n",
-			 smp_processor_id());
+			 raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
-			continue;  /* Induce RCU CPU stall warning. */
+			if (stall_cpu_block)
+				schedule_timeout_uninterruptible(HZ);
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
-		else
+		else if (!stall_cpu_block)
 			preempt_enable();
-		rcu_read_unlock();
+		cur_ops->readunlock(idx);
 		pr_alert("rcu_torture_stall end.\n");
 	}
 	torture_shutdown_absorb("rcu_torture_stall");
-- 
2.9.5

