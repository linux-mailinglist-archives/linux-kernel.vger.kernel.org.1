Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8324F2C36A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKYCPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKYCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:15:53 -0500
Received: from localhost.localdomain (unknown [94.238.200.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776D020DD4;
        Wed, 25 Nov 2020 02:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606270551;
        bh=Suu6mgJBAQlljNCK2ZYjbLM+HpopsISk+RGJihezMz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbIX5jtBuJGhUWHQ3PXZ+mf9VuhMumKRfPieEbTuAErpJpJPv36GPpdwn6aDVGjbN
         /EVu/86Ids2FapmO4hhF+GIHuWM+vTBIuc8ZbN1GlB4u/I3DPFZYiXAxmzYaZeC6wg
         qDgRhJHEsSPj0ato704q82CDaUg5g7tQ5NS+JyEE=
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
Subject: [RFC PATCH 1/4] sched/vtime: Consolidate IRQ time accounting
Date:   Wed, 25 Nov 2020 03:15:39 +0100
Message-Id: <20201125021542.30237-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125021542.30237-1-frederic@kernel.org>
References: <20201125021542.30237-1-frederic@kernel.org>
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

For now only ia64 and powerpc are handled. s390 will need a slightly
different treatment.

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
 arch/ia64/kernel/time.c    | 22 ++++++++++----
 arch/powerpc/kernel/time.c | 60 +++++++++++++++++++++++++++-----------
 arch/s390/kernel/vtime.c   | 15 ++++++----
 include/linux/vtime.h      |  8 ++---
 kernel/sched/cputime.c     | 21 +++++++++++--
 5 files changed, 92 insertions(+), 34 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f37bfaf..3fd1daf5bc09 100644
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
@@ -156,6 +152,22 @@ void vtime_account_idle(struct task_struct *tsk)
 	ti->idle_time += vtime_delta(tsk);
 }
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->softirq_time += vtime_delta(tsk);
+}
+EXPORT_SYMBOL_GPL(vtime_account_softirq);
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->hardirq_time += vtime_delta(tsk);
+}
+EXPORT_SYMBOL_GPL(vtime_account_hardirq);
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 static irqreturn_t
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 74efe46f5532..6b9496d615b2 100644
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
@@ -366,10 +366,36 @@ void vtime_account_idle(struct task_struct *tsk)
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
+	stime = vtime_delta(acct, &stime_scaled, &steal_time);
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_account_irq(struct cpu_accounting_data *acct,
+			      unsigned long *field)
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
+	vtime_account_irq(acct, &acct->softirq_time);
+}
+EXPORT_SYMBOL_GPL(vtime_account_softirq);
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq(acct, &acct->hardirq_time);
+}
+EXPORT_SYMBOL_GPL(vtime_account_hardirq);
+
 static void vtime_flush_scaled(struct task_struct *tsk,
 			       struct cpu_accounting_data *acct)
 {
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 8df10d3c8f6c..9fce2ca1b448 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -226,7 +226,7 @@ void vtime_flush(struct task_struct *tsk)
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	u64 timer;
 
@@ -245,12 +245,17 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 
 	virt_timer_forward(timer);
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-
-void vtime_account_kernel(struct task_struct *tsk)
-__attribute__((alias("vtime_account_irq_enter")));
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_irq_enter(struct task_struct *tsk)
+__attribute__((alias("vtime_account_kernel")));
+EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
+
+void vtime_account_irq_exit(struct task_struct *tsk)
+__attribute__((alias("vtime_account_kernel")));
+EXPORT_SYMBOL_GPL(vtime_account_irq_exit);
+
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca062db3..f827b38c3bb7 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -84,11 +84,9 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 extern void vtime_account_irq_enter(struct task_struct *tsk);
-static inline void vtime_account_irq_exit(struct task_struct *tsk)
-{
-	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_kernel(tsk);
-}
+extern void vtime_account_irq_exit(struct task_struct *tsk);
+extern void vtime_account_softirq(struct task_struct *tsk);
+extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 static inline void vtime_account_irq_enter(struct task_struct *tsk) { }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d2300452..a042250ecbfe 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -429,12 +429,29 @@ void vtime_task_switch(struct task_struct *prev)
 #ifndef __ARCH_HAS_VTIME_ACCOUNT
 void vtime_account_irq_enter(struct task_struct *tsk)
 {
-	if (!in_interrupt() && is_idle_task(tsk))
+	if (hardirq_count()) {
+		vtime_account_hardirq(tsk);
+	} else if (in_serving_softirq()) {
+		vtime_account_softirq(tsk);
+	} else if (is_idle_task(tsk)) {
 		vtime_account_idle(tsk);
-	else
+	} else {
 		vtime_account_kernel(tsk);
+	}
 }
 EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
+
+void vtime_account_irq_exit(struct task_struct *tsk)
+{
+	WARN_ON_ONCE(in_task());
+
+	if (hardirq_count()) {
+		vtime_account_hardirq(tsk);
+	} else if (in_serving_softirq()) {
+		vtime_account_softirq(tsk);
+	}
+}
+EXPORT_SYMBOL_GPL(vtime_account_irq_exit);
 #endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
-- 
2.25.1

