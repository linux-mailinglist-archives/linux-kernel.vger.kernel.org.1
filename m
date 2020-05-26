Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF681D5D11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgEPAMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 20:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbgEPAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED280C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPR-0002NH-FY; Sat, 16 May 2020 02:10:33 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id DF98DFF834;
        Sat, 16 May 2020 02:10:32 +0200 (CEST)
Message-Id: <20200515235126.522540101@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:08 +0200
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
Subject: [patch V6 21/37] x86/entry: Add IRQENTRY_IRQ macro
References: <20200515234547.710474468@linutronix.de>
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


Provide a seperate IDTENTRY macro for device interrupts. Similar to
IDTENTRY_ERRORCODE with the addition of invoking irq_enter/exit_rcu() and
providing the errorcode as a 'u8' argument to the C function, which
truncates the sign extended vector number.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ce113d5613b6..5ad4893ac31c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -751,6 +751,20 @@ SYM_CODE_START(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
 
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+SYM_CODE_START_LOCAL(asm_\cfunc)
+	ASM_CLAC
+	SAVE_ALL switch_stacks=1
+	ENCODE_FRAME_POINTER
+	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
+	call	\cfunc
+	jmp	handle_exception_return
+SYM_CODE_END(asm_\cfunc)
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9c8529035e58..613f606e6dbf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -528,6 +528,20 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * Interrupt entry/exit.
+ *
+ + The interrupt stubs push (vector) onto the stack, which is the error_code
+ * position of idtentry exceptions, and jump to one of the two idtentry points
+ * (common/spurious).
+ *
+ * common_interrupt is a hotpath, align it to a cache line
+ */
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+	idtentry \vector asm_\cfunc \cfunc has_error_code=1
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1fad257372e3..5ea35a9f4562 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -163,6 +163,49 @@ __visible noinstr void func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
 __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
 
+/**
+ * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
+ *			  points (common/spurious)
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_ERRORCODE()
+ */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * The vector number is pushed by the low level entry stub and handed
+ * to the function as error_code argument which needs to be truncated
+ * to an u8 because the push is sign extending.
+ *
+ * On 64bit dtentry_enter/exit() are invoked in the ASM entry code before
+ * and after switching to the interrupt stack. On 32bit this happens in C.
+ *
+ * irq_enter/exit_rcu() are invoked before the function body and the
+ * KVM L1D flush request is set.
+ */
+#define DEFINE_IDTENTRY_IRQ(func)					\
+static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
+									\
+__visible noinstr void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	idtentry_enter(regs);						\
+	instrumentation_begin();					\
+	irq_enter_rcu();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	__##func (regs, (u8)error_code);				\
+	irq_exit_rcu();							\
+	lockdep_hardirq_exit();						\
+	instrumentation_end();						\
+	idtentry_exit(regs);						\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
 #ifdef CONFIG_X86_64
 /**
@@ -295,6 +338,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
 	DECLARE_IDTENTRY_ERRORCODE(vector, func)
 
+/* Entries for common/spurious (device) interrupts */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	idtentry_irq vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func

