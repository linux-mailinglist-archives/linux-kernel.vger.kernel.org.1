Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807391AB091
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441476AbgDOSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441394AbgDOSTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED3C21D80;
        Wed, 15 Apr 2020 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974794;
        bh=0JX18i7A6Mkw9uwmznAG4kREwK5uHyCAvzVobItOgZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB52hffyDih4Gcv31etQ/cW8b9unrpy8mRe0vEH7hZQsrnBfGEWkPy7R12EgB7CMq
         wt+MnXZ8Rn0FBEyen5/cUy8bq4KKpThRE4VXVzKHyAkfoDIv8WRxT0nJtAHZzVwk8M
         jT3Y9b76ZXzb1/PT/Do3ObmG83cNwIqlHwn11ew0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 31/38] rcu-tasks: Make RCU tasks trace also wait for idle tasks
Date:   Wed, 15 Apr 2020 11:19:34 -0700
Message-Id: <20200415181941.11653-31-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit scans the CPUs, adding each CPU's idle task to the list of
tasks that need quiescent states.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1888a49..6bd9bfe 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -15,7 +15,7 @@ struct rcu_tasks;
 typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
 typedef void (*pregp_func_t)(void);
 typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
-typedef void (*postscan_func_t)(void);
+typedef void (*postscan_func_t)(struct list_head *hop);
 typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
@@ -331,7 +331,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rcu_read_unlock();
 
 	set_tasks_gp_state(rtp, RTGS_POST_SCAN_TASKLIST);
-	rtp->postscan_func();
+	rtp->postscan_func(&holdouts);
 
 	/*
 	 * Each pass through the following loop scans the list of holdout
@@ -415,7 +415,7 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 }
 
 /* Processing between scanning taskslist and draining the holdout list. */
-void rcu_tasks_postscan(void)
+void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
 	 * Wait for tasks that are in the process of exiting.  This
@@ -932,9 +932,17 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 	trc_wait_for_one_reader(t, hop);
 }
 
-/* Do intermediate processing between task and holdout scans. */
-static void rcu_tasks_trace_postscan(void)
+/*
+ * Do intermediate processing between task and holdout scans and
+ * pick up the idle tasks.
+ */
+static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		rcu_tasks_trace_pertask(idle_task(cpu), hop);
+
 	// Re-enable CPU hotplug now that the tasklist scan has completed.
 	cpus_read_unlock();
 
-- 
2.9.5

