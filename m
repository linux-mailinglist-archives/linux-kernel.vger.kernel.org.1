Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F01C5890
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgEEOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729912AbgEEOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187CEC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:41 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLz-0001dJ-It; Tue, 05 May 2020 16:15:23 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 15D241001F5;
        Tue,  5 May 2020 16:15:23 +0200 (CEST)
Message-Id: <20200505134905.838823510@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:20 +0200
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
Subject: [patch V4 part 3 26/29] x86/entry: Convert Coprocessor error
 exception to IDTENTRY
References: <20200505134354.774943181@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Convert #MF to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes
  - Remove the RCU warning as the new entry macro ensures correctness

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/entry/entry_32.S       |    7 -------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    5 ++---
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 6 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1290,13 +1290,6 @@ SYM_FUNC_END(name)
 /* The include is where all of the SMP etc. interrupts come from */
 #include <asm/entry_arch.h>
 
-SYM_CODE_START(coprocessor_error)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_coprocessor_error
-	jmp	common_exception
-SYM_CODE_END(coprocessor_error)
-
 SYM_CODE_START(simd_coprocessor_error)
 	ASM_CLAC
 	pushl	$0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,7 +1074,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
 idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
 idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
 
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -130,6 +130,7 @@ DECLARE_IDTENTRY(X86_TRAP_UD,		exc_inval
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
+DECLARE_IDTENTRY(X86_TRAP_MF,		exc_coprocessor_error);
 
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -19,7 +19,6 @@ asmlinkage void double_fault(void);
 #endif
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
-asmlinkage void coprocessor_error(void);
 asmlinkage void alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void machine_check(void);
@@ -32,7 +31,6 @@ asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_page_fault(void);
-asmlinkage void xen_coprocessor_error(void);
 asmlinkage void xen_alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void xen_machine_check(void);
@@ -47,7 +45,6 @@ dotraplinkage void do_int3(struct pt_reg
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
-dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -81,7 +81,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
 	INTG(X86_TRAP_GP,		asm_exc_general_protection),
 	INTG(X86_TRAP_SPURIOUS,		asm_exc_spurious_interrupt_bug),
-	INTG(X86_TRAP_MF,		coprocessor_error),
+	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
 	INTG(X86_TRAP_AC,		alignment_check),
 	INTG(X86_TRAP_XF,		simd_coprocessor_error),
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -846,10 +846,9 @@ static void math_error(struct pt_regs *r
 	cond_local_irq_disable(regs);
 }
 
-dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_coprocessor_error)
 {
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	math_error(regs, error_code, X86_TRAP_MF);
+	math_error(regs, 0, X86_TRAP_MF);
 }
 
 dotraplinkage void
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -633,7 +633,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_stack_segment,			false ),
 	TRAP_ENTRY(exc_general_protection,		false ),
 	TRAP_ENTRY(exc_spurious_interrupt_bug,		false ),
-	{ coprocessor_error,           xen_coprocessor_error,           false },
+	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	{ alignment_check,             xen_alignment_check,             false },
 	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
 };
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -45,7 +45,7 @@ xen_pv_trap asm_exc_stack_segment
 xen_pv_trap asm_exc_general_protection
 xen_pv_trap page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
-xen_pv_trap coprocessor_error
+xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap alignment_check
 #ifdef CONFIG_X86_MCE
 xen_pv_trap machine_check

