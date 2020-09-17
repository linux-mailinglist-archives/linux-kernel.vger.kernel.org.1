Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196326D993
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIQKvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgIQKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4298C061797
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:52 -0700 (PDT)
Message-Id: <20200917101624.523565851@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IBSm78oEW+z/x33e/v7oybEZl5m4El5FBJv8IR+3shQ=;
        b=bNSCuhNk17hjP5REnTRvk3Er1ehjNZ2cvdSsvWyYlpGj3UyuNwusiHWRvCj+PfmtscREqT
        y/yvMbwVSdONRFkW2BIKXydcuWX84DbzmOTgxQENZ6yKm7R//js361lYLxN+NnuqZCdMs3
        Gx4/jI4xg6JFMryvw84EekgrgVSDqT+MKI+oltZVMrxAG3hd4yYMPw5wKVqYfSnyxqxONV
        MW4nHEgbysfzSVTYTOqakeolKtKGdGXzWSucev3sW5mWMoKuK08RoQSe/rVwb3BXsKzITU
        P4t0MnkDSADD05S760nB6tW4CMgu7tj29ZbZAJSXiH6xBx6mIawwB1L08RcZsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IBSm78oEW+z/x33e/v7oybEZl5m4El5FBJv8IR+3shQ=;
        b=prd+O+VQb9yHr/mN6XKS2rZjyCwbd5mWVCjKoNNjh5bRrHxvcA1dobsztM4xluJomR351/
        HXDEaNmWBHK4LzBA==
Date:   Thu, 17 Sep 2020 11:42:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [patch 06/10] sched: Add task components for migration control
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming RT migrate_enable/disable() support will track migrate
disabled state in task_struct.

Add a new migration_ctrl struct to hold all necessary information and add
the required initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched.h |   30 +++++++++++++++++++++++++++---
 init/init_task.c      |    3 +++
 kernel/fork.c         |    1 +
 kernel/sched/debug.c  |    4 ++++
 4 files changed, 35 insertions(+), 3 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -628,6 +628,20 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+struct task_migration_ctrl {
+	struct mutex			mutex;
+	int				disable_cnt;
+};
+
+#define INIT_TASK_MIGRATION_CTRL_INITIALIZER				\
+{									\
+	.mutex = __MUTEX_INITIALIZER(init_task.migration_ctrl.mutex),	\
+}
+#else /* CONFIG_PREEMPT_RT && CONFIG_SMP */
+struct task_migration_ctrl { };
+#endif /* !(CONFIG_PREEMPT_RT && CONFIG_SMP) */
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -713,6 +727,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+	struct task_migration_ctrl	migration_ctrl;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -1865,7 +1880,7 @@ static __always_inline bool need_resched
 }
 
 /*
- * Wrappers for p->thread_info->cpu access. No-op on UP.
+ * Various SMP helper functions. No-ops on UP.
  */
 #ifdef CONFIG_SMP
 
@@ -1880,7 +1895,14 @@ static inline unsigned int task_cpu(cons
 
 extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
 
-#else
+static inline void task_migration_ctrl_init(struct task_struct *p)
+{
+#ifdef CONFIG_PREEMPT_RT
+	mutex_init(&p->migration_ctrl.mutex);
+#endif
+}
+
+#else /* CONFIG_SMP */
 
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
@@ -1891,7 +1913,9 @@ static inline void set_task_cpu(struct t
 {
 }
 
-#endif /* CONFIG_SMP */
+static inline void task_migration_ctrl_init(struct task_struct *p) { }
+
+#endif /* !CONFIG_SMP */
 
 /*
  * In order to reduce various lock holder preemption latencies provide an
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -209,6 +209,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	.migration_ctrl = INIT_TASK_MIGRATION_CTRL_INITIALIZER,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2119,6 +2119,7 @@ static __latent_entropy struct task_stru
 #ifdef CONFIG_BLOCK
 	p->plug = NULL;
 #endif
+	task_migration_ctrl_init(p);
 	futex_init_task(p);
 
 	/*
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -958,6 +958,10 @@ void proc_sched_show_task(struct task_st
 		P(dl.runtime);
 		P(dl.deadline);
 	}
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT)
+	P(migration_ctrl.disable_cnt);
+	P(nr_cpus_allowed);
+#endif
 #undef PN_SCHEDSTAT
 #undef P_SCHEDSTAT
 

