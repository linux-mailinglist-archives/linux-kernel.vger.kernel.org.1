Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7C2C93B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgLAAN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387960AbgLAAN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:13:29 -0500
Received: from localhost.localdomain (mtl93-h04-176-174-252-224.dsl.sta.abo.bbox.fr [176.174.252.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948A520857;
        Tue,  1 Dec 2020 00:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606781568;
        bh=Up1ltsRsGVw6mpXdvWqRVOpmEWbr/mQ6EFSCNGdYf68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i702fe6iyT0V/7yK3Cp65Navxg32C/pLv8suGZq9hKfRflSwWgbMhmtfA6dSoUbal
         BT/ndIe7JhSkAkz+0qFXxLfdl5U3BjrUTDrUW3QiqcmaAWStr91mUJnYbtInTZyY0z
         Re08Jm6Nwxo4/K1HcWYt+izvnOcb0/Hix0lPDyBE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq offset incrementation
Date:   Tue,  1 Dec 2020 01:12:25 +0100
Message-Id: <20201201001226.65107-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201001226.65107-1-frederic@kernel.org>
References: <20201201001226.65107-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ time entry is currently accounted before HARDIRQ_OFFSET or
SOFTIRQ_OFFSET are incremented. This is convenient to decide to which
index the cputime to account is dispatched.

Unfortunately it prevents tick_irq_enter() from being called under
HARDIRQ_OFFSET because tick_irq_enter() has to be called before the IRQ
entry accounting due to the necessary clock catch up. As a result we
don't benefit from appropriate lockdep coverage on tick_irq_enter().

To prepare for fixing this, move the IRQ entry cputime accounting after
the preempt offset is incremented. This requires the cputime dispatch
code to handle the extra offset.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/hardirq.h |  4 ++--
 include/linux/vtime.h   | 10 ++++----
 kernel/sched/cputime.c  | 53 +++++++++++++++++++++++++++++++----------
 kernel/softirq.c        |  2 +-
 4 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 754f67ac4326..02499c10fbf7 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -32,9 +32,9 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()					\
 	do {						\
+		preempt_count_add(HARDIRQ_OFFSET);	\
+		lockdep_hardirq_enter();		\
 		account_irq_enter_time(current);	\
-		preempt_count_add(HARDIRQ_OFFSET);	\
-		lockdep_hardirq_enter();		\
 	} while (0)
 
 /*
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index f827b38c3bb7..cad8ff530273 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -96,21 +96,23 @@ static inline void vtime_flush(struct task_struct *tsk) { }
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-extern void irqtime_account_irq(struct task_struct *tsk);
+extern void irqtime_account_enter(struct task_struct *tsk);
+extern void irqtime_account_exit(struct task_struct *tsk);
 #else
-static inline void irqtime_account_irq(struct task_struct *tsk) { }
+static inline void irqtime_account_enter(struct task_struct *tsk) { }
+static inline void irqtime_account_exit(struct task_struct *tsk) { }
 #endif
 
 static inline void account_irq_enter_time(struct task_struct *tsk)
 {
 	vtime_account_irq_enter(tsk);
-	irqtime_account_irq(tsk);
+	irqtime_account_enter(tsk);
 }
 
 static inline void account_irq_exit_time(struct task_struct *tsk)
 {
 	vtime_account_irq_exit(tsk);
-	irqtime_account_irq(tsk);
+	irqtime_account_exit(tsk);
 }
 
 #endif /* _LINUX_KERNEL_VTIME_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 3675452f6029..44bd774af37d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -43,23 +43,48 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_end(&irqtime->sync);
 }
 
-/*
- * Called before incrementing preempt_count on {soft,}irq_enter
- * and before decrementing preempt_count on {soft,}irq_exit.
- */
-void irqtime_account_irq(struct task_struct *curr)
+static s64 irqtime_get_delta(struct irqtime *irqtime)
 {
-	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	int cpu = smp_processor_id();
 	s64 delta;
-	int cpu;
 
-	if (!sched_clock_irqtime)
-		return;
-
-	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
 
+	return delta;
+}
+
+/* Called after incrementing preempt_count on {soft,}irq_enter */
+void irqtime_account_enter(struct task_struct *curr)
+{
+	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	u64 delta;
+
+	if (!sched_clock_irqtime)
+		return;
+
+	delta = irqtime_get_delta(irqtime);
+	/*
+	 * We do not account for softirq time from ksoftirqd here.
+	 * We want to continue accounting softirq time to ksoftirqd thread
+	 * in that case, so as not to confuse scheduler with a special task
+	 * that do not consume any time, but still wants to run.
+	 */
+	if ((irq_count() == (SOFTIRQ_OFFSET | HARDIRQ_OFFSET)) &&
+	    curr != this_cpu_ksoftirqd())
+		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
+}
+
+/* Called before decrementing preempt_count on {soft,}irq_exit */
+void irqtime_account_exit(struct task_struct *curr)
+{
+	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	u64 delta;
+
+	if (!sched_clock_irqtime)
+		return;
+
+	delta = irqtime_get_delta(irqtime);
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
 	 * We want to continue accounting softirq time to ksoftirqd thread
@@ -427,9 +452,11 @@ void vtime_task_switch(struct task_struct *prev)
  */
 void vtime_account_irq_enter(struct task_struct *tsk)
 {
-	if (hardirq_count()) {
+	WARN_ON_ONCE(in_task());
+
+	if (hardirq_count() > HARDIRQ_OFFSET) {
 		vtime_account_hardirq(tsk);
-	} else if (in_serving_softirq()) {
+	} else if (hardirq_count() && in_serving_softirq()) {
 		vtime_account_softirq(tsk);
 	} else if (is_idle_task(tsk)) {
 		vtime_account_idle(tsk);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 617009ccd82c..24254c41bb7c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -315,9 +315,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
-	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	account_irq_enter_time(current);
 	in_hardirq = lockdep_softirq_start();
 
 restart:
-- 
2.25.1

