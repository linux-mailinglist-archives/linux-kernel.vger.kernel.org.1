Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAD32CBC33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbgLBL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388463AbgLBL6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:58:42 -0500
From:   Frederic Weisbecker <frederic@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq offset incrementation
Date:   Wed,  2 Dec 2020 12:57:31 +0100
Message-Id: <20201202115732.27827-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202115732.27827-1-frederic@kernel.org>
References: <20201202115732.27827-1-frederic@kernel.org>
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
 include/linux/vtime.h   | 34 ++++++++++++++++++++++++----------
 kernel/sched/cputime.c  | 18 +++++++++++-------
 kernel/softirq.c        |  6 +++---
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 754f67ac4326..7c9d6a2d7e90 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -32,9 +32,9 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
 		lockdep_hardirq_enter();		\
+		account_hardirq_enter(current);		\
 	} while (0)
 
 /*
@@ -62,8 +62,8 @@ void irq_enter_rcu(void);
  */
 #define __irq_exit()					\
 	do {						\
+		account_hardirq_exit(current);		\
 		lockdep_hardirq_exit();			\
-		account_irq_exit_time(current);		\
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 6c9867419615..041d6524d144 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -83,32 +83,46 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq(struct task_struct *tsk);
+extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq(struct task_struct *tsk) { }
+static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
+static inline void vtime_account_softirq(struct task_struct *tsk) { }
+static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-extern void irqtime_account_irq(struct task_struct *tsk);
+extern void irqtime_account_irq(struct task_struct *tsk, unsigned int offset);
 #else
-static inline void irqtime_account_irq(struct task_struct *tsk) { }
+static inline void irqtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 #endif
 
-static inline void account_irq_enter_time(struct task_struct *tsk)
+static inline void account_softirq_enter(struct task_struct *tsk)
 {
-	vtime_account_irq(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_irq(tsk, SOFTIRQ_OFFSET);
+	irqtime_account_irq(tsk, SOFTIRQ_OFFSET);
 }
 
-static inline void account_irq_exit_time(struct task_struct *tsk)
+static inline void account_softirq_exit(struct task_struct *tsk)
 {
-	vtime_account_irq(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_softirq(tsk);
+	irqtime_account_irq(tsk, 0);
+}
+
+static inline void account_hardirq_enter(struct task_struct *tsk)
+{
+	vtime_account_irq(tsk, HARDIRQ_OFFSET);
+	irqtime_account_irq(tsk, HARDIRQ_OFFSET);
+}
+
+static inline void account_hardirq_exit(struct task_struct *tsk)
+{
+	vtime_account_hardirq(tsk);
+	irqtime_account_irq(tsk, 0);
 }
 
 #endif /* _LINUX_KERNEL_VTIME_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 02163d4260d7..5f611658eeab 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -44,12 +44,13 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 }
 
 /*
- * Called before incrementing preempt_count on {soft,}irq_enter
+ * Called after incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
  */
-void irqtime_account_irq(struct task_struct *curr)
+void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	unsigned int pc;
 	s64 delta;
 	int cpu;
 
@@ -59,6 +60,7 @@ void irqtime_account_irq(struct task_struct *curr)
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
+	pc = preempt_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -66,9 +68,9 @@ void irqtime_account_irq(struct task_struct *curr)
 	 * in that case, so as not to confuse scheduler with a special task
 	 * that do not consume any time, but still wants to run.
 	 */
-	if (hardirq_count())
+	if (pc & HARDIRQ_MASK)
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
@@ -417,11 +419,13 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-void vtime_account_irq(struct task_struct *tsk)
+void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	if (hardirq_count()) {
+	unsigned int pc = preempt_count() - offset;
+
+	if (pc & HARDIRQ_OFFSET) {
 		vtime_account_hardirq(tsk);
-	} else if (in_serving_softirq()) {
+	} else if (pc & SOFTIRQ_OFFSET) {
 		vtime_account_softirq(tsk);
 	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
 		   is_idle_task(tsk)) {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 617009ccd82c..b8f42b3ba8ca 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -315,10 +315,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
-	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
 	in_hardirq = lockdep_softirq_start();
+	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
@@ -365,8 +365,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		wakeup_softirqd();
 	}
 
+	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	account_irq_exit_time(current);
 	__local_bh_enable(SOFTIRQ_OFFSET);
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
@@ -418,7 +418,7 @@ static inline void __irq_exit_rcu(void)
 #else
 	lockdep_assert_irqs_disabled();
 #endif
-	account_irq_exit_time(current);
+	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
-- 
2.25.1

