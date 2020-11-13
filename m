Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA92B1D43
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgKMOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:25:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKMOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:30 -0500
Message-Id: <20201113141733.974214480@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0UTeqwKc93bYeYTKZ9eNkJ81wNDHGHkvSAl8j8+Yj5Q=;
        b=jv2EEflphEE3CebcE72q1RNivrgP3cY6CABEy6b2ZgZLZDSvbL+oeMi5wEZugM4xGCuqu7
        iA1kifAro0LVNSxg7SiHdTE4/VJI8sHguJCBvTJoX3AfamxiI8P7XO1BHBKk/yTWSS/Lhn
        SwwaIxFQ2VxUKsJMvA4DG6XeplBDsVoiQFOT/ceQWIaU/pKJr7zagt96VnJrFHNQxNvihF
        kAEReD5i/Fx180ZHUtX/TWNbSqTV/8OF/HEfMjOnDHgs4pz85Q5Rg1CD63euT6nGQbFfsi
        EN8ORThOKeZm4WBytizPIltx9HExbUBbfnT3JCYNTd8gjAileLVA9vl7kainFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0UTeqwKc93bYeYTKZ9eNkJ81wNDHGHkvSAl8j8+Yj5Q=;
        b=9fpm5+miuJxrT+jze0aGitkbirAatyttDigNLtfzZs+AU5LOUy0Evsyi9vnWdaCR1KDuYI
        Vmu6Q7I4ArxJjlBQ==
Date:   Fri, 13 Nov 2020 15:02:18 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 11/19] softirq: Move related code into one section
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for adding a RT aware variant of softirq serialization and
processing move related code into one section so the necessary #ifdeffery
is reduced to one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |  107 +++++++++++++++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,13 @@ static bool ksoftirqd_running(unsigned l
 		!__kthread_should_park(tsk);
 }
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+DEFINE_PER_CPU(int, hardirqs_enabled);
+DEFINE_PER_CPU(int, hardirq_context);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
+#endif
+
 /*
  * preempt_count and SOFTIRQ_OFFSET usage:
  * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
@@ -102,17 +109,11 @@ static bool ksoftirqd_running(unsigned l
  * softirq and whether we just have bh disabled.
  */
 
+#ifdef CONFIG_TRACE_IRQFLAGS
 /*
- * This one is for softirq.c-internal use,
- * where hardirqs are disabled legitimately:
+ * This is for softirq.c-internal use, where hardirqs are disabled
+ * legitimately:
  */
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-DEFINE_PER_CPU(int, hardirqs_enabled);
-DEFINE_PER_CPU(int, hardirq_context);
-EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
-EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
-
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -203,6 +204,50 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void invoke_softirq(void)
+{
+	if (ksoftirqd_running(local_softirq_pending()))
+		return;
+
+	if (!force_irqthreads) {
+#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
+		/*
+		 * We can safely execute softirq on the current stack if
+		 * it is the irq stack, because it should be near empty
+		 * at this stage.
+		 */
+		__do_softirq();
+#else
+		/*
+		 * Otherwise, irq_exit() is called on the task stack that can
+		 * be potentially deep already. So call softirq in its own stack
+		 * to prevent from any overrun.
+		 */
+		do_softirq_own_stack();
+#endif
+	} else {
+		wakeup_softirqd();
+	}
+}
+
+asmlinkage __visible void do_softirq(void)
+{
+	__u32 pending;
+	unsigned long flags;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	pending = local_softirq_pending();
+
+	if (pending && !ksoftirqd_running(pending))
+		do_softirq_own_stack();
+
+	local_irq_restore(flags);
+}
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -327,24 +372,6 @@ asmlinkage __visible void __softirq_entr
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
-asmlinkage __visible void do_softirq(void)
-{
-	__u32 pending;
-	unsigned long flags;
-
-	if (in_interrupt())
-		return;
-
-	local_irq_save(flags);
-
-	pending = local_softirq_pending();
-
-	if (pending && !ksoftirqd_running(pending))
-		do_softirq_own_stack();
-
-	local_irq_restore(flags);
-}
-
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -371,32 +398,6 @@ void irq_enter(void)
 	irq_enter_rcu();
 }
 
-static inline void invoke_softirq(void)
-{
-	if (ksoftirqd_running(local_softirq_pending()))
-		return;
-
-	if (!force_irqthreads) {
-#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
-		/*
-		 * We can safely execute softirq on the current stack if
-		 * it is the irq stack, because it should be near empty
-		 * at this stage.
-		 */
-		__do_softirq();
-#else
-		/*
-		 * Otherwise, irq_exit() is called on the task stack that can
-		 * be potentially deep already. So call softirq in its own stack
-		 * to prevent from any overrun.
-		 */
-		do_softirq_own_stack();
-#endif
-	} else {
-		wakeup_softirqd();
-	}
-}
-
 static inline void tick_irq_exit(void)
 {
 #ifdef CONFIG_NO_HZ_COMMON

