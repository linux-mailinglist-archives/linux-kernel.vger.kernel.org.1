Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA01D0207
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 00:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgELWXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 18:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731731AbgELWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:25 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIW-0004vp-PW; Wed, 13 May 2020 00:22:49 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4EA201006A1;
        Wed, 13 May 2020 00:22:48 +0200 (CEST)
Message-Id: <20200512213811.844041484@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:23 +0200
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V5 24/38] x86/entry: Provide IDTENTRY_SYSVEC
References: <20200512210059.056244513@linutronix.de>
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

Provide a IDTENTRY variant for system vectors to consolidate the different
mechanisms to emit the ASM stubs for 32 an 64 bit.

On 64bit this also moves the stack switching from ASM to C code. 32bit will
excute the system vectors w/o stack switching as before.

This comes with two different entry defines:

 - DEFINE_IDTENTRY_SYSVEC:

   Uses the full idtentry path and switches to the interrupt stack before
   invoking the function body.

 - DEFINE_IDTENTRY_SYSVEC_SIMPLE:

   A lightweight variant which avoids the stack switch and uses the
   conditional RCU entry/exit variants to avoid the overhead. Used in
   subsequent changes for converting the reschedule IPI and the KVM
   posted interrupt vectors. All of them are more or less empty
   functions which are also performance sensitive.

   Avoids the overhead of irq time accounting and uses the raw variants
   of __irq_enter/exit() so instrumentation observes the correct preempt
   count state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    4 +
 arch/x86/entry/entry_64.S       |    8 +++
 arch/x86/include/asm/idtentry.h |   86 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -765,6 +765,10 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 SYM_CODE_END(asm_\cfunc)
 .endm
 
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -542,6 +542,14 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * System vectors which invoke their handlers directly and are not
+ * going through the regular common device interrupt handling code.
+ */
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -6,6 +6,9 @@
 #include <asm/trapnr.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/hardirq.h>
+
+#include <asm/irq_stack.h>
 
 void idtentry_enter(struct pt_regs *regs);
 void idtentry_exit(struct pt_regs *regs);
@@ -207,6 +210,85 @@ static __always_inline void __##func(str
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
+/**
+ * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ *
+ * Maps to DECLARE_IDTENTRY().
+ */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+
+/**
+ * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
+ * function body. KVM L1D flush request is set.
+ *
+ * Runs the function on the interrupt stack if the entry hit kernel mode
+ */
+#define DEFINE_IDTENTRY_SYSVEC(func)					\
+static void __##func(struct pt_regs *regs);				\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	idtentry_enter(regs);						\
+	instrumentation_begin();					\
+	irq_enter_rcu();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	if (!irq_needs_irq_stack(regs))					\
+		__##func (regs);					\
+	else								\
+		run_on_irqstack(__##func, regs);			\
+	irq_exit_rcu();							\
+	lockdep_hardirq_exit();						\
+	instrumentation_end();						\
+	idtentry_exit(regs);						\
+}									\
+									\
+static noinline void __##func(struct pt_regs *regs)
+
+/**
+ * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
+ *				   entry points
+ * @func:	Function name of the entry point
+ *
+ * Runs the function on the interrupted stack. No switch to IRQ stack.
+ * Used for 'empty' vectors like reschedule IPI and KVM posted interrupt
+ * vectors.
+ *
+ * Uses conditional RCU and does not invoke irq_enter/exit_rcu() to avoid
+ * the overhead. This is correct vs. NOHZ. If this hits in dynticks idle
+ * then the exit path from the inner idle loop will restart the tick.  If
+ * it hits user mode with ticks off then the scheduler will take care of
+ * restarting it.
+ */
+#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
+static void __##func(struct pt_regs *regs);				\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
+	instrumentation_begin();					\
+	__irq_enter_raw();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	__##func (regs);						\
+	__irq_exit_raw();						\
+	instrumentation_end();						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+}									\
+									\
+static void __##func(struct pt_regs *regs)
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -342,6 +424,10 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_IRQ(vector, func)				\
 	idtentry_irq vector func
 
+/* System vector entries */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	idtentry_sysvec vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func

