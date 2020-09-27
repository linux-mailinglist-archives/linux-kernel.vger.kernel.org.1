Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4227A18C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI0PIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0PIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 11:08:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 08:08:54 -0700 (PDT)
Date:   Sun, 27 Sep 2020 15:06:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601219332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ve/eliBOOrDy+dHmJqpwEZEajfXiPS6UllUys+7R5bA=;
        b=1m+l8+qpVAgX1Iu02zkc+BcD8ACfzfcTCViWpGQM5Qjw02oqTwBJgQ3kEL1xMj/IYRc33p
        b37mvrHJnec8gVyouUOdF5tn02789nE/qpQRwkbG68IXTHj5NebBeSMnYh6DtOXQmGi5uu
        cESX0Q3WmeyxqhbsDBkWhOQv3cdC8d/Ws+0bcIGQ13t7TjemyvARIkcaItAVOkl6jiI1Gk
        JCoNO3FG2u8Inl+18LHZ8NYdXvo4GFVhfXWe8vnpQpRZDhrv2hBM2rOgvzzo4+6nlk3Lms
        3J3DGyqFsTYhdyPHlWgTGOxXip1J7/KRvHKaTBGqcNbXBlMvGp/gRV5z4lySPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601219332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ve/eliBOOrDy+dHmJqpwEZEajfXiPS6UllUys+7R5bA=;
        b=qm452fC8C3UzUBsrgqJBQj266a8iwo/nDOmnmFqHW7AuXjTCURn4VIxF57hhkh3l8dH6nY
        lHT0k46XNQNbf1AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.9-rc7
References: <160121922194.23623.5568205948074131939.tglx@nanos>
Message-ID: <160121922315.23623.17643308720426244416.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-09-27

up to:  86a82ae0b509: x86/ioapic: Unbreak check_timer()


Two fixes for the x86 interrupt code:

  - Unbreak the magic 'search the timer interrupt' logic in IO/APIC code
    which got wreckaged when the core interrupt code made the state
    tracking logic stricter. That caused the interrupt line to stay masked
    after switching from IO/APIC to PIC delivery mode, which obviously
    prevents interrupts from being delivered.

  - Make run_on_irqstack_code() typesafe. The function argument is a void
    pointer which is then casted to 'void (*fun)(void *). This breaks
    Control Flow Integrity checking in clang. Use proper helper functions
    for the three variants reuqired.

Thanks,

	tglx

------------------>
Thomas Gleixner (2):
      x86/irq: Make run_on_irqstack_cond() typesafe
      x86/ioapic: Unbreak check_timer()


 arch/x86/entry/common.c          |  2 +-
 arch/x86/entry/entry_64.S        |  2 ++
 arch/x86/include/asm/idtentry.h  |  2 +-
 arch/x86/include/asm/irq_stack.h | 69 +++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/apic/io_apic.c   |  1 +
 arch/x86/kernel/irq.c            |  2 +-
 arch/x86/kernel/irq_64.c         |  2 +-
 7 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 2f84c7ca74ea..870efeec8bda 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -299,7 +299,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
-	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, NULL, regs);
+	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 	instrumentation_begin();
 
 	set_irq_regs(old_regs);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 70dea9337816..d977079a7d02 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -682,6 +682,8 @@ SYM_CODE_END(.Lbad_gs)
  * rdx: Function argument (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
+SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
+SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
 	 * unwinder to handle the stack switch.
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a43366191212..a0638640f1ed 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -242,7 +242,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_on_irqstack_cond(__##func, regs, regs);			\
+	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 4ae66f097101..775816965c6a 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -12,20 +12,50 @@ static __always_inline bool irqstack_active(void)
 	return __this_cpu_read(irq_count) != -1;
 }
 
-void asm_call_on_stack(void *sp, void *func, void *arg);
+void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
+void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
+			      struct pt_regs *regs);
+void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
+			   struct irq_desc *desc);
 
-static __always_inline void __run_on_irqstack(void *func, void *arg)
+static __always_inline void __run_on_irqstack(void (*func)(void))
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
 	__this_cpu_add(irq_count, 1);
-	asm_call_on_stack(tos - 8, func, arg);
+	asm_call_on_stack(tos - 8, func, NULL);
+	__this_cpu_sub(irq_count, 1);
+}
+
+static __always_inline void
+__run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
+			 struct pt_regs *regs)
+{
+	void *tos = __this_cpu_read(hardirq_stack_ptr);
+
+	__this_cpu_add(irq_count, 1);
+	asm_call_sysvec_on_stack(tos - 8, func, regs);
+	__this_cpu_sub(irq_count, 1);
+}
+
+static __always_inline void
+__run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
+		      struct irq_desc *desc)
+{
+	void *tos = __this_cpu_read(hardirq_stack_ptr);
+
+	__this_cpu_add(irq_count, 1);
+	asm_call_irq_on_stack(tos - 8, func, desc);
 	__this_cpu_sub(irq_count, 1);
 }
 
 #else /* CONFIG_X86_64 */
 static inline bool irqstack_active(void) { return false; }
-static inline void __run_on_irqstack(void *func, void *arg) { }
+static inline void __run_on_irqstack(void (*func)(void)) { }
+static inline void __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
+					    struct pt_regs *regs) { }
+static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
+					 struct irq_desc *desc) { }
 #endif /* !CONFIG_X86_64 */
 
 static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
@@ -37,17 +67,40 @@ static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
 	return !user_mode(regs) && !irqstack_active();
 }
 
-static __always_inline void run_on_irqstack_cond(void *func, void *arg,
+
+static __always_inline void run_on_irqstack_cond(void (*func)(void),
 						 struct pt_regs *regs)
 {
-	void (*__func)(void *arg) = func;
+	lockdep_assert_irqs_disabled();
+
+	if (irq_needs_irq_stack(regs))
+		__run_on_irqstack(func);
+	else
+		func();
+}
+
+static __always_inline void
+run_sysvec_on_irqstack_cond(void (*func)(struct pt_regs *regs),
+			    struct pt_regs *regs)
+{
+	lockdep_assert_irqs_disabled();
 
+	if (irq_needs_irq_stack(regs))
+		__run_sysvec_on_irqstack(func, regs);
+	else
+		func(regs);
+}
+
+static __always_inline void
+run_irq_on_irqstack_cond(void (*func)(struct irq_desc *desc), struct irq_desc *desc,
+			 struct pt_regs *regs)
+{
 	lockdep_assert_irqs_disabled();
 
 	if (irq_needs_irq_stack(regs))
-		__run_on_irqstack(__func, arg);
+		__run_irq_on_irqstack(func, desc);
 	else
-		__func(arg);
+		func(desc);
 }
 
 #endif
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 779a89e31c4c..21f9c7f11779 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2243,6 +2243,7 @@ static inline void __init check_timer(void)
 	legacy_pic->init(0);
 	legacy_pic->make_irq(0);
 	apic_write(APIC_LVT0, APIC_DM_EXTINT);
+	legacy_pic->unmask(0);
 
 	unlock_ExtINT_logic();
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 181060247e3c..c5dd50369e2f 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -227,7 +227,7 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 				       struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_X86_64))
-		run_on_irqstack_cond(desc->handle_irq, desc, regs);
+		run_irq_on_irqstack_cond(desc->handle_irq, desc, regs);
 	else
 		__handle_irq(desc, regs);
 }
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 1b4fe93a86c5..440eed558558 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -74,5 +74,5 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 
 void do_softirq_own_stack(void)
 {
-	run_on_irqstack_cond(__do_softirq, NULL, NULL);
+	run_on_irqstack_cond(__do_softirq, NULL);
 }

