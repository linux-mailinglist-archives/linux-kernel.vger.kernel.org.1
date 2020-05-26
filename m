Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DB1AB096
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 20:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416613AbgDOSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 14:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441390AbgDOSTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3709521D7E;
        Wed, 15 Apr 2020 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974793;
        bh=UO3WByAAqSt8jn5gbLdZE3ZNnlcVOlaOuQAnjDZEPJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppt+ZpzxhCoJLfVuTUXJ0wKpiG7oT0ffMJAywVmAVlENScS6bTsWl9jq9fzr2CelH
         +c5LSm7eHv85NwKd+Ir2XSxE2L2ImoUEXXMYieekpyomEdck9K0yt2bHRjx9LtQWcF
         sKQQHYxoOjWnEKfsgehnUnPiFym2AtfiQvoLqbCY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 28/38] rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
Date:   Wed, 15 Apr 2020 11:19:31 -0700
Message-Id: <20200415181941.11653-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_read_unlock_trace() can invoke rcu_read_unlock_trace_special(),
which in turn can call wake_up().  Therefore, if any scheduler lock is
held across a call to rcu_read_unlock_trace(), self-deadlock can occur.
This commit therefore uses the irq_work facility to defer the wake_up()
to a clean environment where no scheduler locks will be held.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
[ paulmck: Update #includes for m68k per kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 12 +++++++++++-
 kernel/rcu/update.c |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3eed886..0cdeeb3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -729,6 +729,16 @@ void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
 
+/*
+ * This irq_work handler allows rcu_read_unlock_trace() to be invoked
+ * while the scheduler locks are held.
+ */
+static void rcu_read_unlock_iw(struct irq_work *iwp)
+{
+	wake_up(&trc_wait);
+}
+static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
+
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
@@ -742,7 +752,7 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_nesting, nesting);
 	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
-		wake_up(&trc_wait);
+		irq_work_queue(&rcu_tasks_trace_iw);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c579934..b1f07a0 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -41,6 +41,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/kprobes.h>
 #include <linux/slab.h>
+#include <linux/irq_work.h>
 
 #define CREATE_TRACE_POINTS
 
-- 
2.9.5

