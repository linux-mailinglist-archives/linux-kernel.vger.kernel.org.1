Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFA1AB0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416715AbgDOSXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441373AbgDOSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8D921775;
        Wed, 15 Apr 2020 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974788;
        bh=rbRByjaGsuOpTa9qP5IJ2JcoNu5IZVQh0K93MG0arIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLS+XmrQnY4Augji7dpvqomfLpUcFcAWlUL0ckIgdXE9mSeH9o4/qB1X8xlngJoBn
         n3kwl6VGcfde5YWE8SboE8ByT9z4FBEwcOJkZRBB/PU+O0RoFF9h8fNV45+F53unfz
         tmJk10jqGmhqwxkBq8jzeVDDVPqhItTCTP6EyIfM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 14/38] rcu-tasks: Code movement to allow more Tasks RCU variants
Date:   Wed, 15 Apr 2020 11:19:17 -0700
Message-Id: <20200415181941.11653-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit does nothing but move rcu_tasks_wait_gp() up to a new section
for common code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 122 +++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 344426e..d8b09d5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -213,6 +213,69 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 ////////////////////////////////////////////////////////////////////////
 //
+// Shared code between task-list-scanning variants of Tasks RCU.
+
+/* Wait for one RCU-tasks grace period. */
+static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
+{
+	struct task_struct *g, *t;
+	unsigned long lastreport;
+	LIST_HEAD(holdouts);
+	int fract;
+
+	rtp->pregp_func();
+
+	/*
+	 * There were callbacks, so we need to wait for an RCU-tasks
+	 * grace period.  Start off by scanning the task list for tasks
+	 * that are not already voluntarily blocked.  Mark these tasks
+	 * and make a list of them in holdouts.
+	 */
+	rcu_read_lock();
+	for_each_process_thread(g, t)
+		rtp->pertask_func(t, &holdouts);
+	rcu_read_unlock();
+
+	rtp->postscan_func();
+
+	/*
+	 * Each pass through the following loop scans the list of holdout
+	 * tasks, removing any that are no longer holdouts.  When the list
+	 * is empty, we are done.
+	 */
+	lastreport = jiffies;
+
+	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
+	fract = 10;
+
+	for (;;) {
+		bool firstreport;
+		bool needreport;
+		int rtst;
+
+		if (list_empty(&holdouts))
+			break;
+
+		/* Slowly back off waiting for holdouts */
+		schedule_timeout_interruptible(HZ/fract);
+
+		if (fract > 1)
+			fract--;
+
+		rtst = READ_ONCE(rcu_task_stall_timeout);
+		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
+		if (needreport)
+			lastreport = jiffies;
+		firstreport = true;
+		WARN_ON(signal_pending(current));
+		rtp->holdouts_func(&holdouts, needreport, &firstreport);
+	}
+
+	rtp->postgp_func();
+}
+
+////////////////////////////////////////////////////////////////////////
+//
 // Simple variant of RCU whose quiescent states are voluntary context
 // switch, cond_resched_rcu_qs(), user-space execution, and idle.
 // As such, grace periods can take one good long time.  There are no
@@ -333,65 +396,6 @@ static void rcu_tasks_postgp(void)
 	synchronize_rcu();
 }
 
-/* Wait for one RCU-tasks grace period. */
-static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
-{
-	struct task_struct *g, *t;
-	unsigned long lastreport;
-	LIST_HEAD(holdouts);
-	int fract;
-
-	rtp->pregp_func();
-
-	/*
-	 * There were callbacks, so we need to wait for an RCU-tasks
-	 * grace period.  Start off by scanning the task list for tasks
-	 * that are not already voluntarily blocked.  Mark these tasks
-	 * and make a list of them in holdouts.
-	 */
-	rcu_read_lock();
-	for_each_process_thread(g, t)
-		rtp->pertask_func(t, &holdouts);
-	rcu_read_unlock();
-
-	rtp->postscan_func();
-
-	/*
-	 * Each pass through the following loop scans the list of holdout
-	 * tasks, removing any that are no longer holdouts.  When the list
-	 * is empty, we are done.
-	 */
-	lastreport = jiffies;
-
-	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
-	fract = 10;
-
-	for (;;) {
-		bool firstreport;
-		bool needreport;
-		int rtst;
-
-		if (list_empty(&holdouts))
-			break;
-
-		/* Slowly back off waiting for holdouts */
-		schedule_timeout_interruptible(HZ/fract);
-
-		if (fract > 1)
-			fract--;
-
-		rtst = READ_ONCE(rcu_task_stall_timeout);
-		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
-		if (needreport)
-			lastreport = jiffies;
-		firstreport = true;
-		WARN_ON(signal_pending(current));
-		rtp->holdouts_func(&holdouts, needreport, &firstreport);
-	}
-
-	rtp->postgp_func();
-}
-
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
-- 
2.9.5

