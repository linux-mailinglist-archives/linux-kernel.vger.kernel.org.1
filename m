Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288AE1C58B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgEEORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730272AbgEEORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B94C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNO-0002aG-Nh; Tue, 05 May 2020 16:16:51 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3F86BFFC8D;
        Tue,  5 May 2020 16:16:50 +0200 (CEST)
Message-Id: <20200505135830.483164478@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:54:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 5 24/31] x86/entry: Convert reschedule interrupt to
 IDTENTRY_RAW
References: <20200505135341.730586321@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler IPI does not need the full interrupt entry handling logic
when the entry is from kernel mode.

Even if tracing is enabled the only requirement is that RCU is watching and
preempt_count has the hardirq bit on.

The NOHZ tick state does not have to be adjusted. If the tick is not
running then the CPU is in idle and the idle exit will restore the
tick. Softinterrupts are not raised here, so handling them on return is not
required either.

User mode entry must go through the regular entry path as it will invoke
the scheduler on return so context tracking needs to be in the correct
state.

Use IDTENTRY_RAW and the RCU conditional variants of idtentry_enter/exit()
to guarantee that RCU is watching even if the IPI hits a RCU idle section.

Remove the tracepoint static key conditional which is incomplete
vs. tracing anyway because e.g. ack_APIC_irq() calls out into
instrumentable code.

Avoid the overhead of irq time accounting and introduce variants of
__irq_enter/exit() so instrumentation observes the correct preempt count
state.

Spare the switch to the interrupt stack as the IPI is not going to use only
a minimal amount of stack space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S                |    4 ---
 arch/x86/include/asm/entry_arch.h        |    3 --
 arch/x86/include/asm/hw_irq.h            |    3 --
 arch/x86/include/asm/idtentry.h          |    1 
 arch/x86/include/asm/trace/common.h      |    4 ---
 arch/x86/include/asm/trace/irq_vectors.h |   17 ------------
 arch/x86/kernel/idt.c                    |    2 -
 arch/x86/kernel/smp.c                    |   41 +++++++++++++++++++++----------
 arch/x86/kernel/tracepoint.c             |   17 ------------
 include/linux/hardirq.h                  |   18 +++++++++++++
 10 files changed, 49 insertions(+), 61 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -957,10 +957,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_SMP
-apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -10,6 +10,3 @@
  * is no hardware IRQ pin equivalent for them, they are triggered
  * through the ICC by us (IPIs)
  */
-#ifdef CONFIG_SMP
-BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-#endif
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -28,9 +28,6 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
 
-/* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void reschedule_interrupt(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -574,6 +574,7 @@ DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI
 #endif
 
 #ifdef CONFIG_SMP
+DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
--- a/arch/x86/include/asm/trace/common.h
+++ b/arch/x86/include/asm/trace/common.h
@@ -5,12 +5,8 @@
 DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
 #define trace_pagefault_enabled()			\
 	static_branch_unlikely(&trace_pagefault_key)
-DECLARE_STATIC_KEY_FALSE(trace_resched_ipi_key);
-#define trace_resched_ipi_enabled()			\
-	static_branch_unlikely(&trace_resched_ipi_key)
 #else
 static inline bool trace_pagefault_enabled(void) { return false; }
-static inline bool trace_resched_ipi_enabled(void) { return false; }
 #endif
 
 #endif
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -10,9 +10,6 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-extern int trace_resched_ipi_reg(void);
-extern void trace_resched_ipi_unreg(void);
-
 DECLARE_EVENT_CLASS(x86_irq_vector,
 
 	TP_PROTO(int vector),
@@ -37,18 +34,6 @@ DEFINE_EVENT_FN(x86_irq_vector, name##_e
 	TP_PROTO(int vector),			\
 	TP_ARGS(vector), NULL, NULL);
 
-#define DEFINE_RESCHED_IPI_EVENT(name)		\
-DEFINE_EVENT_FN(x86_irq_vector, name##_entry,	\
-	TP_PROTO(int vector),			\
-	TP_ARGS(vector),			\
-	trace_resched_ipi_reg,			\
-	trace_resched_ipi_unreg);		\
-DEFINE_EVENT_FN(x86_irq_vector, name##_exit,	\
-	TP_PROTO(int vector),			\
-	TP_ARGS(vector),			\
-	trace_resched_ipi_reg,			\
-	trace_resched_ipi_unreg);
-
 /*
  * local_timer - called when entering/exiting a local timer interrupt
  * vector handler
@@ -99,7 +84,7 @@ TRACE_EVENT_PERF_PERM(irq_work_exit, is_
 /*
  * reschedule - called when entering/exiting a reschedule vector handler
  */
-DEFINE_RESCHED_IPI_EVENT(reschedule);
+DEFINE_IRQ_VECTOR_EVENT(reschedule);
 
 /*
  * call_function - called when entering/exiting a call function interrupt
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -109,7 +109,7 @@ static const __initconst struct idt_data
  */
 static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_SMP
-	INTG(RESCHEDULE_VECTOR,			reschedule_interrupt),
+	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
 	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -222,24 +222,39 @@ static void native_stop_other_cpus(int w
  * Reschedule call back. KVM uses this interrupt to force a cpu out of
  * guest mode
  */
-__visible void __irq_entry smp_reschedule_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_RAW(sysvec_reschedule_ipi)
 {
+	/*
+	 * User mode entry goes through the regular entry_from_user_mode()
+	 * path in both cases otherwise scheduling on return could be
+	 * invoked with the wrong NOHZ_FULL state.
+	 *
+	 * Kernel entry does not require the full sysvec treatment just for
+	 * folding the preempt count.
+	 *
+	 * Even if tracing is enabled the only requirement is that RCU is
+	 * watching and preempt_count has the hardirq bit on.
+	 *
+	 * The NOHZ tick state does not have to be adjusted. If the tick is
+	 * not running then the CPU is in idle and the idle exit will
+	 * restore the tick. Softinterrupts are not raised here, so handling
+	 * them on return is not required either.
+	 */
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);
+
+	instr_begin();
+	__irq_enter_raw();
+	trace_reschedule_entry(RESCHEDULE_VECTOR);
 	ack_APIC_irq();
 	inc_irq_stat(irq_resched_count);
 
-	if (trace_resched_ipi_enabled()) {
-		/*
-		 * scheduler_ipi() might call irq_enter() as well, but
-		 * nested calls are fine.
-		 */
-		irq_enter();
-		trace_reschedule_entry(RESCHEDULE_VECTOR);
-		scheduler_ipi();
-		trace_reschedule_exit(RESCHEDULE_VECTOR);
-		irq_exit();
-		return;
-	}
 	scheduler_ipi();
+
+	trace_reschedule_entry(RESCHEDULE_VECTOR);
+	__irq_exit_raw();
+	instr_end();
+
+	idtentry_exit_cond_rcu(regs, rcu_exit);
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -25,20 +25,3 @@ void trace_pagefault_unreg(void)
 {
 	static_branch_dec(&trace_pagefault_key);
 }
-
-#ifdef CONFIG_SMP
-
-DEFINE_STATIC_KEY_FALSE(trace_resched_ipi_key);
-
-int trace_resched_ipi_reg(void)
-{
-	static_branch_inc(&trace_resched_ipi_key);
-	return 0;
-}
-
-void trace_resched_ipi_unreg(void)
-{
-	static_branch_dec(&trace_resched_ipi_key);
-}
-
-#endif
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -41,6 +41,15 @@ extern void rcu_nmi_exit(void);
 	} while (0)
 
 /*
+ * Like __irq_enter() without time accounting
+ */
+#define __irq_enter_raw()				\
+	do {						\
+		preempt_count_add(HARDIRQ_OFFSET);	\
+		lockdep_hardirq_enter();		\
+	} while (0)
+
+/*
  * Enter irq context (on NO_HZ, update jiffies):
  */
 void irq_enter(void);
@@ -59,6 +68,15 @@ void irq_enter_rcu(void);
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
+/*
+ * Like __irq_exit() without time accounting
+ */
+#define __irq_exit_raw()				\
+	do {						\
+		lockdep_hardirq_exit();			\
+		preempt_count_sub(HARDIRQ_OFFSET);	\
+	} while (0)
+
 /*
  * Exit irq context and process softirqs if needed:
  */

