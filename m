Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408F9273CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVH64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:58:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:58:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600761533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JmFHK5z7ujEuwKVrgO4MHq1YiGmjkkuIPDbjOQQvsJ4=;
        b=NrEXTpZHmVCRYVAVVqshCSslJpDY5iXhuje2En6NtW+GY9w/Ldj6Q3ASBx2i4N7KrmEQHr
        ASGsU1CmzjeA4zcCZbc2xqCzKFuYTYf4p54hlTWLKaz2p56uQwToNcx+ZUzk6f3eY6xR4y
        9JlW4GhtjhaNCqmT/PbACX5BRarogVR/tU0qjlPJrF2SQqOnI6Vj/NOCtt7kQcMqsYwhGH
        N1sdDNtFM7Eh4G06l4Q2agOlbxyMwGj+86kfKv2og+kHxNzzkhy8LmQQaBo0Pb1a1e6ok/
        G4nQP7x2vgF3Rcc4OEE1Ts9eMYHOjKzxGJI5tQtXhOAxoLGsNloGCteWeIGf7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600761533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JmFHK5z7ujEuwKVrgO4MHq1YiGmjkkuIPDbjOQQvsJ4=;
        b=iKj+AdT7WQjN61Jz+HZSyr4/IyQ8ReoeY2f3RD9q8o/mUJB5WRefHVLouP4HsXV4MOEHqA
        GHerjTklkpqLpeDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: x86/irq: Make run_on_irqstack_cond() typesafe
Date:   Tue, 22 Sep 2020 09:58:52 +0200
Message-ID: <87pn6eb5tv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sami reported that run_on_irqstack_cond() requires the caller to cast
functions to mismatching types, which trips indirect call Control-Flow
Integrity (CFI) in Clang.

Instead of disabling CFI on that function, provide proper helpers for
the three call variants. The actual ASM code stays the same as that is
out of reach.

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Fixes: 931b94145981 ("x86/entry: Provide helpers for executing on the irqstack")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c          |    2 -
 arch/x86/entry/entry_64.S        |    2 +
 arch/x86/include/asm/idtentry.h  |    2 -
 arch/x86/include/asm/irq_stack.h |   69 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/irq.c            |    2 -
 arch/x86/kernel/irq_64.c         |    2 -
 6 files changed, 67 insertions(+), 12 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -299,7 +299,7 @@ static void __xen_pv_evtchn_do_upcall(vo
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
-	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, NULL, regs);
+	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 	instrumentation_begin();
 
 	set_irq_regs(old_regs);
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -762,6 +762,8 @@ SYM_CODE_END(.Lbad_gs)
  * rdx: Function argument (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
+SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
+SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
 	 * unwinder to handle the stack switch.
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -242,7 +242,7 @@ static void __##func(struct pt_regs *reg
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_on_irqstack_cond(__##func, regs, regs);			\
+	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -12,20 +12,50 @@ static __always_inline bool irqstack_act
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
+static inline void __run_on_irqstack(void (*func)(void), void *arg) { }
+static inline void __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
+					    struct pt_regs *regs) { }
+static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
+					 struct irq_desc *desc) { }
 #endif /* !CONFIG_X86_64 */
 
 static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
@@ -37,17 +67,40 @@ static __always_inline bool irq_needs_ir
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
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -227,7 +227,7 @@ static __always_inline void handle_irq(s
 				       struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_X86_64))
-		run_on_irqstack_cond(desc->handle_irq, desc, regs);
+		run_irq_on_irqstack_cond(desc->handle_irq, desc, regs);
 	else
 		__handle_irq(desc, regs);
 }
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -74,5 +74,5 @@ int irq_init_percpu_irqstack(unsigned in
 
 void do_softirq_own_stack(void)
 {
-	run_on_irqstack_cond(__do_softirq, NULL, NULL);
+	run_on_irqstack_cond(__do_softirq, NULL);
 }
