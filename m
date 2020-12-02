Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D322CBC31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgLBL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgLBL6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:58:34 -0500
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
Subject: [PATCH 2/5] s390/vtime: Use the generic IRQ entry accounting
Date:   Wed,  2 Dec 2020 12:57:29 +0100
Message-Id: <20201202115732.27827-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202115732.27827-1-frederic@kernel.org>
References: <20201202115732.27827-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390 has its own version of IRQ entry accounting because it doesn't
account the idle time the same way the other architectures do. Only
the actual idle sleep time is accounted as idle time, the rest of the
idle task execution is accounted as system time.

Make the generic IRQ entry accounting aware of architectures that have
their own way of accounting idle time and convert s390 to use it.

This prepares s390 to get involved in further consolidations of IRQ
time accounting.

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
 arch/Kconfig                  |  7 ++++++-
 arch/s390/Kconfig             |  1 +
 arch/s390/include/asm/vtime.h |  1 -
 arch/s390/kernel/vtime.c      |  4 ----
 kernel/sched/cputime.c        | 13 ++-----------
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..0f151b49c7b7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -627,6 +627,12 @@ config HAVE_TIF_NOHZ
 config HAVE_VIRT_CPU_ACCOUNTING
 	bool
 
+config HAVE_VIRT_CPU_ACCOUNTING_IDLE
+	bool
+	help
+	  Architecture has its own way to account idle CPU time and therefore
+	  doesn't implement vtime_account_idle().
+
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
@@ -641,7 +647,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_GEN
 	  some 32-bit arches may require multiple accesses, so proper
 	  locking is needed to protect against concurrent accesses.
 
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4a2a12be04c9..6f1fdcd3b5db 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -181,6 +181,7 @@ config S390
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
 	select MODULES_USE_ELF_RELA
diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index 3622d4ebc73a..fac6a67988eb 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,7 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_ACCOUNT
 #define __ARCH_HAS_VTIME_TASK_SWITCH
 
 #endif /* _S390_VTIME_H */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index f9f2a11958a5..ebd8e5655789 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -247,10 +247,6 @@ void vtime_account_kernel(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
-void vtime_account_irq_enter(struct task_struct *tsk)
-__attribute__((alias("vtime_account_kernel")));
-
-
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 61ce9f9bf0a3..2783162542b1 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -417,23 +417,14 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-/*
- * Archs that account the whole time spent in the idle task
- * (outside irq) as idle time can rely on this and just implement
- * vtime_account_kernel() and vtime_account_idle(). Archs that
- * have other meaning of the idle time (s390 only includes the
- * time spent by the CPU when it's in low power mode) must override
- * vtime_account().
- */
-#ifndef __ARCH_HAS_VTIME_ACCOUNT
 void vtime_account_irq_enter(struct task_struct *tsk)
 {
-	if (!in_interrupt() && is_idle_task(tsk))
+	if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
+	    !in_interrupt() && is_idle_task(tsk))
 		vtime_account_idle(tsk);
 	else
 		vtime_account_kernel(tsk);
 }
-#endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
-- 
2.25.1

