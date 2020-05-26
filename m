Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8904F1C58F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgEEOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729849AbgEEOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD32C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLp-0001Ts-Nx; Tue, 05 May 2020 16:15:13 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 23C63FFC8D;
        Tue,  5 May 2020 16:15:13 +0200 (CEST)
Message-Id: <20200505134905.056243863@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:12 +0200
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
Subject: [patch V4 part 3 18/29] x86/entry: Convert Device not available
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

Convert #NM to IDTENTRY:
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
 arch/x86/kernel/traps.c         |    8 ++------
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 6 insertions(+), 20 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1311,13 +1311,6 @@ SYM_CODE_START(simd_coprocessor_error)
 	jmp	common_exception
 SYM_CODE_END(simd_coprocessor_error)
 
-SYM_CODE_START(device_not_available)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_device_not_available
-	jmp	common_exception
-SYM_CODE_END(device_not_available)
-
 #ifdef CONFIG_PARAVIRT
 SYM_CODE_START(native_iret)
 	iret
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,7 +1074,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
 idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
 idtentry	X86_TRAP_NP		segment_not_present	do_segment_not_present		has_error_code=1
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -81,5 +81,6 @@ DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divid
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
 DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
 DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
+DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,7 +14,6 @@
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
 asmlinkage void int3(void);
-asmlinkage void device_not_available(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
@@ -37,7 +36,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
-asmlinkage void xen_device_not_available(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_coprocessor_segment_overrun(void);
 asmlinkage void xen_invalid_TSS(void);
@@ -57,7 +55,6 @@ asmlinkage void xen_simd_coprocessor_err
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
-dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -74,7 +74,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_NMI,		nmi),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
-	INTG(X86_TRAP_NM,		device_not_available),
+	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
 	INTG(X86_TRAP_OLD_MF,		coprocessor_segment_overrun),
 	INTG(X86_TRAP_TS,		invalid_TSS),
 	INTG(X86_TRAP_NP,		segment_not_present),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -874,13 +874,10 @@ do_spurious_interrupt_bug(struct pt_regs
 	 */
 }
 
-dotraplinkage void
-do_device_not_available(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
@@ -905,10 +902,9 @@ do_device_not_available(struct pt_regs *
 		 * to kill the task than getting stuck in a never-ending
 		 * loop of #NM faults.
 		 */
-		die("unexpected #NM exception", regs, error_code);
+		die("unexpected #NM exception", regs, 0);
 	}
 }
-NOKPROBE_SYMBOL(do_device_not_available);
 
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -626,7 +626,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_divide_error,			false ),
 	TRAP_ENTRY(exc_bounds,				false ),
 	TRAP_ENTRY(exc_invalid_op,			false ),
-	{ device_not_available,        xen_device_not_available,        false },
+	TRAP_ENTRY(exc_device_not_available,		false ),
 	{ coprocessor_segment_overrun, xen_coprocessor_segment_overrun, false },
 	{ invalid_TSS,                 xen_invalid_TSS,                 false },
 	{ segment_not_present,         xen_segment_not_present,         false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -36,7 +36,7 @@ xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
-xen_pv_trap device_not_available
+xen_pv_trap asm_exc_device_not_available
 xen_pv_trap double_fault
 xen_pv_trap coprocessor_segment_overrun
 xen_pv_trap invalid_TSS

