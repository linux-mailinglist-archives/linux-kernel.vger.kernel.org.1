Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612F21C5899
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgEEOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730069AbgEEOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB7AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:18 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMa-00021V-Rv; Tue, 05 May 2020 16:16:01 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 54D5AFFC8D;
        Tue,  5 May 2020 16:16:00 +0200 (CEST)
Message-Id: <20200505135314.609932306@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:39 +0200
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
Subject: [patch V4 part 4 13/24] x86/entry: Convert NMI to IDTENTRY_NMI
References: <20200505134926.578885807@linutronix.de>
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

Convert #NMI to IDTENTRY_NMI:
  - Implement the C entry point with DEFINE_IDTENTRY_NMI
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    8 ++++----
 arch/x86/entry/entry_64.S       |   15 +++++++--------
 arch/x86/include/asm/idtentry.h |    4 ++++
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    4 ++--
 arch/x86/kernel/nmi.c           |    4 +---
 arch/x86/xen/enlighten_pv.c     |    7 ++++++-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 25 insertions(+), 22 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1547,7 +1547,7 @@ SYM_CODE_END(double_fault)
  * switched stacks.  We handle both conditions by simply checking whether we
  * interrupted kernel code running on the SYSENTER stack.
  */
-SYM_CODE_START(nmi)
+SYM_CODE_START(asm_exc_nmi)
 	ASM_CLAC
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1576,7 +1576,7 @@ SYM_CODE_START(nmi)
 	jb	.Lnmi_from_sysenter_stack
 
 	/* Not on SYSENTER stack. */
-	call	do_nmi
+	call	exc_nmi
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1586,7 +1586,7 @@ SYM_CODE_START(nmi)
 	 */
 	movl	%esp, %ebx
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
-	call	do_nmi
+	call	exc_nmi
 	movl	%ebx, %esp
 
 .Lnmi_return:
@@ -1640,7 +1640,7 @@ SYM_CODE_START(nmi)
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
 	jmp	.Lirq_return
 #endif
-SYM_CODE_END(nmi)
+SYM_CODE_END(asm_exc_nmi)
 
 .pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1080,7 +1080,6 @@ idtentry_df	X86_TRAP_DF		double_fault		d
 
 #ifdef CONFIG_XEN_PV
 idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-idtentry	X86_TRAP_NMI		xennmi			do_nmi				has_error_code=0
 idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
 #endif
 
@@ -1416,7 +1415,7 @@ SYM_CODE_END(error_return)
  *	%r14: Used to save/restore the CR3 of the interrupted context
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
-SYM_CODE_START(nmi)
+SYM_CODE_START(asm_exc_nmi)
 	UNWIND_HINT_IRET_REGS
 
 	/*
@@ -1501,7 +1500,7 @@ SYM_CODE_START(nmi)
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	do_nmi
+	call	exc_nmi
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1558,7 +1557,7 @@ SYM_CODE_START(nmi)
 	 * end_repeat_nmi, then we are a nested NMI.  We must not
 	 * modify the "iret" frame because it's being written by
 	 * the outer NMI.  That's okay; the outer NMI handler is
-	 * about to about to call do_nmi anyway, so we can just
+	 * about to about to call exc_nmi() anyway, so we can just
 	 * resume the outer NMI.
 	 */
 
@@ -1677,7 +1676,7 @@ SYM_CODE_START(nmi)
 	 * RSP is pointing to "outermost RIP".  gsbase is unknown, but, if
 	 * we're repeating an NMI, gsbase has the same value that it had on
 	 * the first iteration.  paranoid_entry will load the kernel
-	 * gsbase if needed before we call do_nmi.  "NMI executing"
+	 * gsbase if needed before we call exc_nmi().  "NMI executing"
 	 * is zero.
 	 */
 	movq	$1, 10*8(%rsp)		/* Set "NMI executing". */
@@ -1711,10 +1710,10 @@ SYM_CODE_START(nmi)
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
-	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
+	/* paranoidentry exc_nmi(), 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	do_nmi
+	call	exc_nmi
 
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
@@ -1751,7 +1750,7 @@ SYM_CODE_START(nmi)
 	 * about espfix64 on the way back to kernel mode.
 	 */
 	iretq
-SYM_CODE_END(nmi)
+SYM_CODE_END(asm_exc_nmi)
 
 #ifndef CONFIG_IA32_EMULATION
 /*
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -260,4 +260,8 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_BP,	exc_in
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
 #endif
 
+/* NMI */
+DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
+DECLARE_IDTENTRY_XEN(X86_TRAP_NMI,	nmi);
+
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -12,7 +12,6 @@
 #define dotraplinkage __visible
 
 asmlinkage void debug(void);
-asmlinkage void nmi(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
@@ -20,14 +19,12 @@ asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
 #endif
 
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
-dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -71,7 +71,7 @@ static const __initconst struct idt_data
  */
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
-	INTG(X86_TRAP_NMI,		nmi),
+	INTG(X86_TRAP_NMI,		asm_exc_nmi),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
@@ -183,7 +183,7 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
  */
 static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_DB,	debug,			IST_INDEX_DB),
-	ISTG(X86_TRAP_NMI,	nmi,			IST_INDEX_NMI),
+	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
 	ISTG(X86_TRAP_DF,	double_fault,		IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
 	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -507,8 +507,7 @@ static bool notrace is_debug_stack(unsig
 NOKPROBE_SYMBOL(is_debug_stack);
 #endif
 
-dotraplinkage notrace void
-do_nmi(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_NMI(exc_nmi)
 {
 	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
 		return;
@@ -558,7 +557,6 @@ do_nmi(struct pt_regs *regs, long error_
 	if (user_mode(regs))
 		mds_user_clear_cpu_buffers();
 }
-NOKPROBE_SYMBOL(do_nmi);
 
 void stop_nmi(void)
 {
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -610,13 +610,18 @@ struct trap_array_entry {
 	.xen		= xen_asm_##func,		\
 	.ist_okay	= ist_ok }
 
+#define TRAP_ENTRY_REDIR(func, xenfunc, ist_ok) {	\
+	.orig		= asm_##func,			\
+	.xen		= xen_asm_##xenfunc,		\
+	.ist_okay	= ist_ok }
+
 static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
 	{ double_fault,                xen_double_fault,                true },
 #ifdef CONFIG_X86_MCE
 	TRAP_ENTRY(exc_machine_check,			true  ),
 #endif
-	{ nmi,                         xen_xennmi,                      true },
+	TRAP_ENTRY_REDIR(exc_nmi, exc_xennmi,		true  ),
 	TRAP_ENTRY(exc_int3,				false ),
 	TRAP_ENTRY(exc_overflow,			false ),
 #ifdef CONFIG_IA32_EMULATION
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -32,7 +32,7 @@ xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
 xen_pv_trap asm_exc_int3
-xen_pv_trap xennmi
+xen_pv_trap asm_exc_xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op

