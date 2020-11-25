Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0962C36A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKYCPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKYCPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:15:55 -0500
Received: from localhost.localdomain (unknown [94.238.200.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48452145D;
        Wed, 25 Nov 2020 02:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606270554;
        bh=jEcj9QHX5ILbnXjHCnBLLGq1vfVSqRT5ME/uAmXyd3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8lA/VDNyKjtrXtp/linJer1XDBzrINr2vU+6juS0GnrFYnsvbBpaaWwtq5W1KqM3
         2M0ue90SVl3b7mkPQqkl5L2F3UAjmIEi3RCmP9jgFnrxyGXzABhTdOjN0UEQhZy7xX
         Adz0/UfzsbAw9RLMwpxd9kK2dQ5p2KiJLK7GYHyY=
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
Subject: [RFC PATCH 2/4] s390/vtime: Convert to consolidated IRQ time accounting
Date:   Wed, 25 Nov 2020 03:15:40 +0100
Message-Id: <20201125021542.30237-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125021542.30237-1-frederic@kernel.org>
References: <20201125021542.30237-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390 has its own version of IRQ time accounting because it doesn't
account the idle time the same way the other architectures do. Only
the actual idle sleep time is accounted as idle time, the rest of the
idle task execution is accounted as system time.

However converting it to the consolidated IRQ time accounting is easy:
just keep the current behaviour and redirect generic idle time
accounting to system time accounting.

This removes the need to maintain an ad-hoc implementation of cputime
dispatch decision.

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
 arch/s390/include/asm/vtime.h |  1 -
 arch/s390/kernel/vtime.c      | 57 ++++++++++++++++++++++-------------
 kernel/sched/cputime.c        |  2 --
 3 files changed, 36 insertions(+), 24 deletions(-)

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
index 9fce2ca1b448..09328baeb61d 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -222,39 +222,54 @@ void vtime_flush(struct task_struct *tsk)
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
 
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_idle(struct task_struct *tsk)
 __attribute__((alias("vtime_account_kernel")));
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 
-void vtime_account_irq_exit(struct task_struct *tsk)
-__attribute__((alias("vtime_account_kernel")));
-EXPORT_SYMBOL_GPL(vtime_account_irq_exit);
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.softirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+EXPORT_SYMBOL_GPL(vtime_account_softirq);
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.hardirq_timer += delta;
 
+	virt_timer_forward(delta);
+}
+EXPORT_SYMBOL_GPL(vtime_account_hardirq);
 
 /*
  * Sorted add to a list. List is linear searched until first bigger
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a042250ecbfe..6fa81cc33fec 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -426,7 +426,6 @@ void vtime_task_switch(struct task_struct *prev)
  * time spent by the CPU when it's in low power mode) must override
  * vtime_account().
  */
-#ifndef __ARCH_HAS_VTIME_ACCOUNT
 void vtime_account_irq_enter(struct task_struct *tsk)
 {
 	if (hardirq_count()) {
@@ -452,7 +451,6 @@ void vtime_account_irq_exit(struct task_struct *tsk)
 	}
 }
 EXPORT_SYMBOL_GPL(vtime_account_irq_exit);
-#endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
-- 
2.25.1

