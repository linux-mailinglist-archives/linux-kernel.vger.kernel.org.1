Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8058E2CBC32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgLBL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388463AbgLBL6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:58:39 -0500
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
Subject: [PATCH 3/5] sched/vtime: Consolidate IRQ time accounting
Date:   Wed,  2 Dec 2020 12:57:30 +0100
Message-Id: <20201202115732.27827-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202115732.27827-1-frederic@kernel.org>
References: <20201202115732.27827-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3 architectures implementing CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
all have their own version of irq time accounting that dispatch the
cputime to the appropriate index: hardirq, softirq, system, idle,
guest... from an all-in-one function.

Instead of having these ad-hoc versions, move the cputime destination
dispatch decision to the core code and leave only the actual per-index
cputime accounting to the architecture.

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
 arch/ia64/kernel/time.c    | 20 +++++++++----
 arch/powerpc/kernel/time.c | 58 +++++++++++++++++++++++++++-----------
 arch/s390/kernel/vtime.c   | 51 ++++++++++++++++++++++-----------
 include/linux/vtime.h      | 16 ++++-------
 kernel/sched/cputime.c     | 13 ++++++---
 5 files changed, 106 insertions(+), 52 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f37bfaf..733e0e3324b8 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -138,12 +138,8 @@ void vtime_account_kernel(struct task_struct *tsk)
 	struct thread_info *ti = task_thread_info(tsk);
 	__u64 stime = vtime_delta(tsk);
 
-	if ((tsk->flags & PF_VCPU) && !irq_count())
+	if (tsk->flags & PF_VCPU)
 		ti->gtime += stime;
-	else if (hardirq_count())
-		ti->hardirq_time += stime;
-	else if (in_serving_softirq())
-		ti->softirq_time += stime;
 	else
 		ti->stime += stime;
 }
@@ -156,6 +152,20 @@ void vtime_account_idle(struct task_struct *tsk)
 	ti->idle_time += vtime_delta(tsk);
 }
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->softirq_time += vtime_delta(tsk);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->hardirq_time += vtime_delta(tsk);
+}
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 static irqreturn_t
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 74efe46f5532..cf3f8db7e0e3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -311,12 +311,11 @@ static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
 	return stime_scaled;
 }
 
-static unsigned long vtime_delta(struct task_struct *tsk,
+static unsigned long vtime_delta(struct cpu_accounting_data *acct,
 				 unsigned long *stime_scaled,
 				 unsigned long *steal_time)
 {
 	unsigned long now, stime;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
 
 	WARN_ON_ONCE(!irqs_disabled());
 
@@ -331,29 +330,30 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	return stime;
 }
 
-void vtime_account_kernel(struct task_struct *tsk)
+static void vtime_delta_kernel(struct cpu_accounting_data *acct,
+			       unsigned long *stime, unsigned long *stime_scaled)
 {
-	unsigned long stime, stime_scaled, steal_time;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
+	unsigned long steal_time;
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
-
-	stime -= min(stime, steal_time);
+	*stime = vtime_delta(acct, stime_scaled, &steal_time);
+	*stime -= min(*stime, steal_time);
 	acct->steal_time += steal_time;
+}
 
-	if ((tsk->flags & PF_VCPU) && !irq_count()) {
+void vtime_account_kernel(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	unsigned long stime, stime_scaled;
+
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
+
+	if (tsk->flags & PF_VCPU) {
 		acct->gtime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
 #endif
 	} else {
-		if (hardirq_count())
-			acct->hardirq_time += stime;
-		else if (in_serving_softirq())
-			acct->softirq_time += stime;
-		else
-			acct->stime += stime;
-
+		acct->stime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
 #endif
@@ -366,10 +366,34 @@ void vtime_account_idle(struct task_struct *tsk)
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
+	stime = vtime_delta(acct, &stime_scaled, &steal_time);
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_account_irq_field(struct cpu_accounting_data *acct,
+				    unsigned long *field)
+{
+	unsigned long stime, stime_scaled;
+
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
+	*field += stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	acct->stime_scaled += stime_scaled;
+#endif
+}
+
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->softirq_time);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->hardirq_time);
+}
+
 static void vtime_flush_scaled(struct task_struct *tsk,
 			       struct cpu_accounting_data *acct)
 {
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index ebd8e5655789..5aaa2ca6a928 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -222,31 +222,50 @@ void vtime_flush(struct task_struct *tsk)
 	S390_lowcore.avg_steal_timer = avg_steal;
 }
 
-/*
- * Update process times based on virtual cpu times stored by entry.S
- * to the lowcore fields user_timer, system_timer & steal_clock.
- */
-void vtime_account_kernel(struct task_struct *tsk)
+static u64 vtime_delta(void)
 {
-	u64 timer;
+	u64 timer = S390_lowcore.last_update_timer;
 
-	timer = S390_lowcore.last_update_timer;
 	S390_lowcore.last_update_timer = get_vtimer();
-	timer -= S390_lowcore.last_update_timer;
 
-	if ((tsk->flags & PF_VCPU) && (irq_count() == 0))
-		S390_lowcore.guest_timer += timer;
-	else if (hardirq_count())
-		S390_lowcore.hardirq_timer += timer;
-	else if (in_serving_softirq())
-		S390_lowcore.softirq_timer += timer;
+	return timer - S390_lowcore.last_update_timer;
+}
+
+/*
+ * Update process times based on virtual cpu times stored by entry.S
+ * to the lowcore fields user_timer, system_timer & steal_clock.
+ */
+void vtime_account_kernel(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	if (tsk->flags & PF_VCPU)
+		S390_lowcore.guest_timer += delta;
 	else
-		S390_lowcore.system_timer += timer;
+		S390_lowcore.system_timer += delta;
 
-	virt_timer_forward(timer);
+	virt_timer_forward(delta);
 }
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.softirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.hardirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca062db3..6c9867419615 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -83,16 +83,12 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq_enter(struct task_struct *tsk);
-static inline void vtime_account_irq_exit(struct task_struct *tsk)
-{
-	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_kernel(tsk);
-}
+extern void vtime_account_irq(struct task_struct *tsk);
+extern void vtime_account_softirq(struct task_struct *tsk);
+extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq_enter(struct task_struct *tsk) { }
-static inline void vtime_account_irq_exit(struct task_struct *tsk) { }
+static inline void vtime_account_irq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
@@ -105,13 +101,13 @@ static inline void irqtime_account_irq(struct task_struct *tsk) { }
 
 static inline void account_irq_enter_time(struct task_struct *tsk)
 {
-	vtime_account_irq_enter(tsk);
+	vtime_account_irq(tsk);
 	irqtime_account_irq(tsk);
 }
 
 static inline void account_irq_exit_time(struct task_struct *tsk)
 {
-	vtime_account_irq_exit(tsk);
+	vtime_account_irq(tsk);
 	irqtime_account_irq(tsk);
 }
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2783162542b1..02163d4260d7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -417,13 +417,18 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_irq(struct task_struct *tsk)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
-	    !in_interrupt() && is_idle_task(tsk))
+	if (hardirq_count()) {
+		vtime_account_hardirq(tsk);
+	} else if (in_serving_softirq()) {
+		vtime_account_softirq(tsk);
+	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
+		   is_idle_task(tsk)) {
 		vtime_account_idle(tsk);
-	else
+	} else {
 		vtime_account_kernel(tsk);
+	}
 }
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
-- 
2.25.1

