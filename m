Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819631C58CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgEEOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729436AbgEEOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNB-0002Pw-7X; Tue, 05 May 2020 16:16:37 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9E1ABFFC8D;
        Tue,  5 May 2020 16:16:36 +0200 (CEST)
Message-Id: <20200505135829.384803459@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:54 +0200
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
Subject: [patch V4 part 5 13/31] x86/irq: Convey vector as argument and not in ptregs
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

Device interrupts which go through do_IRQ() or the spurious interrupt
handler have their separate entry code on 64 bit for no good reason.

Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
pt_regs. Further the vector number is forced to fit into an u8 and is
complemented and offset by 0x80 so it's in the signed character
range. Otherwise GAS would expand the pushq to a 5 byte instruction for any
vector > 0x7F.

Treat the vector number like an error code and hand it to the C function as
argument. This allows to get rid of the extra entry code in a later step.

Simplify the error code push magic by implementing the pushq imm8 via a
'.byte 0x6a, vector' sequence so GAS is not able to screw it up. As the
pushq imm8 is sign extending the resulting error code needs to be truncated
to 8 bits in C code.

Originally-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Gerst <brgerst@gmail.com>
---
V2: Fix the pushq thinko (Brian)
---
 arch/x86/entry/calling.h          |    5 +++-
 arch/x86/entry/entry_32.S         |   33 +++----------------------------
 arch/x86/entry/entry_64.S         |   40 ++++++--------------------------------
 arch/x86/include/asm/entry_arch.h |    2 -
 arch/x86/include/asm/hw_irq.h     |    1 
 arch/x86/include/asm/idtentry.h   |   40 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/irq.h        |    2 -
 arch/x86/include/asm/traps.h      |    3 +-
 arch/x86/kernel/apic/apic.c       |   31 +++++++++++++++++++++++------
 arch/x86/kernel/idt.c             |    2 -
 arch/x86/kernel/irq.c             |   14 ++++++++-----
 11 files changed, 95 insertions(+), 78 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -339,7 +339,10 @@ For 32-bit we have the following convent
 #endif
 .endm
 
-#endif /* CONFIG_X86_64 */
+#else /* CONFIG_X86_64 */
+# undef		UNWIND_HINT_IRET_REGS
+# define	UNWIND_HINT_IRET_REGS
+#endif /* !CONFIG_X86_64 */
 
 .macro STACKLEAK_ERASE
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1215,40 +1215,15 @@ SYM_FUNC_END(entry_INT80_32)
 #endif
 .endm
 
-/*
- * Build the entry stubs with some assembler magic.
- * We pack 1 stub into every 8-byte block.
- */
-	.align 8
-SYM_CODE_START(irq_entries_start)
-    vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
-	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
-    vector=vector+1
-	jmp	common_interrupt
-	.align	8
-    .endr
-SYM_CODE_END(irq_entries_start)
-
 #ifdef CONFIG_X86_LOCAL_APIC
-	.align 8
-SYM_CODE_START(spurious_entries_start)
-    vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
-	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
-    vector=vector+1
-	jmp	common_spurious
-	.align	8
-    .endr
-SYM_CODE_END(spurious_entries_start)
-
 SYM_CODE_START_LOCAL(common_spurious)
 	ASM_CLAC
-	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
 SYM_CODE_END(common_spurious)
@@ -1261,12 +1236,12 @@ SYM_CODE_END(common_spurious)
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
-	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
-
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
 	call	do_IRQ
 	jmp	ret_from_intr
 SYM_CODE_END(common_interrupt)
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -359,34 +359,6 @@ SYM_CODE_START(ret_from_fork)
 SYM_CODE_END(ret_from_fork)
 .popsection
 
-/*
- * Build the entry stubs with some assembler magic.
- * We pack 1 stub into every 8-byte block.
- */
-	.align 8
-SYM_CODE_START(irq_entries_start)
-    vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
-	UNWIND_HINT_IRET_REGS
-	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
-	jmp	common_interrupt
-	.align	8
-	vector=vector+1
-    .endr
-SYM_CODE_END(irq_entries_start)
-
-	.align 8
-SYM_CODE_START(spurious_entries_start)
-    vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
-	UNWIND_HINT_IRET_REGS
-	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
-	jmp	common_spurious
-	.align	8
-	vector=vector+1
-    .endr
-SYM_CODE_END(spurious_entries_start)
-
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
 	pushq %rax
@@ -756,13 +728,14 @@ SYM_CODE_END(interrupt_entry)
 /* Interrupt entry/exit. */
 
 /*
- * The interrupt stubs push (~vector+0x80) onto the stack and
+ * The interrupt stubs push vector onto the stack and
  * then jump to common_spurious/interrupt.
  */
 SYM_CODE_START_LOCAL(common_spurious)
-	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
+	movq	ORIG_RAX(%rdi), %rsi		/* get vector from stack */
+	movq	$-1, ORIG_RAX(%rdi)		/* no syscall to restart */
 	call	smp_spurious_interrupt		/* rdi points to pt_regs */
 	jmp	ret_from_intr
 SYM_CODE_END(common_spurious)
@@ -771,10 +744,11 @@ SYM_CODE_END(common_spurious)
 /* common_interrupt is a hotpath. Align it */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 SYM_CODE_START_LOCAL(common_interrupt)
-	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
-	call	do_IRQ	/* rdi points to pt_regs */
+	movq	ORIG_RAX(%rdi), %rsi		/* get vector from stack */
+	movq	$-1, ORIG_RAX(%rdi)		/* no syscall to restart */
+	call	do_IRQ				/* rdi points to pt_regs */
 	/* 0(%rsp): old RSP */
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
@@ -1023,7 +997,7 @@ apicinterrupt RESCHEDULE_VECTOR			resche
 #endif
 
 apicinterrupt ERROR_APIC_VECTOR			error_interrupt			smp_error_interrupt
-apicinterrupt SPURIOUS_APIC_VECTOR		spurious_interrupt		smp_spurious_interrupt
+apicinterrupt SPURIOUS_APIC_VECTOR		spurious_apic_interrupt		smp_spurious_apic_interrupt
 
 #ifdef CONFIG_IRQ_WORK
 apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -35,7 +35,7 @@ BUILD_INTERRUPT(kvm_posted_intr_nested_i
 
 BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_apic_interrupt,SPURIOUS_APIC_VECTOR)
 BUILD_INTERRUPT(x86_platform_ipi, X86_PLATFORM_IPI_VECTOR)
 
 #ifdef CONFIG_IRQ_WORK
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -39,6 +39,7 @@ extern asmlinkage void irq_work_interrup
 extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
+extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -336,6 +336,46 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_XEN(vector, func)				\
 	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
 
+/*
+ * ASM code to emit the common vector entry stubs where each stub is
+ * packed into 8 bytes.
+ *
+ * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
+ * GCC treats the local vector variable as unsigned int and would expand
+ * all vectors above 0x7F to a 5 byte push. The original code did an
+ * adjustment of the vector number to be in the signed byte range to avoid
+ * this. While clever it's mindboggling counterintuitive and requires the
+ * odd conversion back to a real vector number in the C entry points. Using
+ * .byte achieves the same thing and the only fixup needed in the C entry
+ * point is to mask off the bits above bit 7 because the push is sign
+ * extending.
+ */
+	.align 8
+SYM_CODE_START(irq_entries_start)
+    vector=FIRST_EXTERNAL_VECTOR
+    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+	UNWIND_HINT_IRET_REGS
+	.byte	0x6a, vector
+	jmp	common_interrupt
+	.align	8
+    vector=vector+1
+    .endr
+SYM_CODE_END(irq_entries_start)
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	.align 8
+SYM_CODE_START(spurious_entries_start)
+    vector=FIRST_SYSTEM_VECTOR
+    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+	UNWIND_HINT_IRET_REGS
+	.byte	0x6a, vector
+	jmp	common_spurious
+	.align	8
+    vector=vector+1
+    .endr
+SYM_CODE_END(spurious_entries_start)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 /*
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -36,7 +36,7 @@ extern void native_init_IRQ(void);
 
 extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible void do_IRQ(struct pt_regs *regs);
+extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
 
 extern void init_ISA_irqs(void);
 
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -41,8 +41,9 @@ asmlinkage void smp_deferred_error_inter
 #endif
 
 void smp_apic_timer_interrupt(struct pt_regs *regs);
-void smp_spurious_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
+void smp_spurious_apic_interrupt(struct pt_regs *regs);
+void smp_spurious_interrupt(struct pt_regs *regs, unsigned long vector);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 #ifdef CONFIG_VMAP_STACK
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2152,15 +2152,29 @@ void __init register_lapic_address(unsig
  * Local APIC interrupts
  */
 
-/*
- * This interrupt should _never_ happen with our APIC/SMP architecture
+/**
+ * smp_spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @error_code:	The vector number is in the lower 8 bits
+ *
+ * This is invoked from ASM entry code to catch all interrupts which
+ * trigger on an entry which is routed to the common_spurious idtentry
+ * point.
+ *
+ * Also called from smp_spurious_apic_interrupt().
  */
-__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
+__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs,
+						  unsigned long vector)
 {
-	u8 vector = ~regs->orig_ax;
 	u32 v;
 
 	entering_irq();
+	/*
+	 * The push in the entry ASM code which stores the vector number on
+	 * the stack in the error code slot is sign expanding. Just use the
+	 * lower 8 bits.
+	 */
+	vector &= 0xFF;
 	trace_spurious_apic_entry(vector);
 
 	inc_irq_stat(irq_spurious_count);
@@ -2181,11 +2195,11 @@ void __init register_lapic_address(unsig
 	 */
 	v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
 	if (v & (1 << (vector & 0x1f))) {
-		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
+		pr_info("Spurious interrupt (vector 0x%02lx) on CPU#%d. Acked\n",
 			vector, smp_processor_id());
 		ack_APIC_irq();
 	} else {
-		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
+		pr_info("Spurious interrupt (vector 0x%02lx) on CPU#%d. Not pending!\n",
 			vector, smp_processor_id());
 	}
 out:
@@ -2193,6 +2207,11 @@ void __init register_lapic_address(unsig
 	exiting_irq();
 }
 
+__visible void smp_spurious_apic_interrupt(struct pt_regs *regs)
+{
+	smp_spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+}
+
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -142,7 +142,7 @@ static const __initconst struct idt_data
 #ifdef CONFIG_X86_UV
 	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
 #endif
-	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
+	INTG(SPURIOUS_APIC_VECTOR,	spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
 };
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -230,14 +230,18 @@ u64 arch_irq_stat(void)
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-__visible void __irq_entry do_IRQ(struct pt_regs *regs)
+__visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct irq_desc * desc;
-	/* high bit used in ret_from_ code  */
-	unsigned vector = ~regs->orig_ax;
+	struct irq_desc *desc;
 
 	entering_irq();
+	/*
+	 * The push in the entry ASM code which stores the vector number on
+	 * the stack in the error code slot is sign expanding. Just use the
+	 * lower 8 bits.
+	 */
+	vector &= 0xFF;
 
 	/* entering_irq() tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
@@ -252,7 +256,7 @@ u64 arch_irq_stat(void)
 		ack_APIC_irq();
 
 		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
+			pr_emerg_ratelimited("%s: %d.%lu No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
 		} else {

