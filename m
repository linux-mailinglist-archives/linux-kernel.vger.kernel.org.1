Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE03D1C58F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgEEOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729848AbgEEOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E071BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:30 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLo-0001Sp-E8; Tue, 05 May 2020 16:15:12 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id DE5BEFFC8D;
        Tue,  5 May 2020 16:15:11 +0200 (CEST)
Message-Id: <20200505134904.955511913@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:11 +0200
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
Subject: [patch V4 part 3 17/29] x86/entry: Convert Invalid Opcode exception
 to IDTENTRY
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

Convert #UD to IDTENTRY:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Fixup the FOOF bug call in fault.c
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fixup the FOOF bug call into invalid op
---
 arch/x86/entry/entry_32.S       |    7 -------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    8 +++++---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |   16 +++++++++++++++-
 arch/x86/mm/fault.c             |    2 +-
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 9 files changed, 25 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1325,13 +1325,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(invalid_op)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_invalid_op
-	jmp	common_exception
-SYM_CODE_END(invalid_op)
-
 SYM_CODE_START(coprocessor_segment_overrun)
 	ASM_CLAC
 	pushl	$0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1074,7 +1074,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
-idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
 idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
 idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -80,5 +80,6 @@ static __always_inline void __##func(str
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
 DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
+DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -14,7 +14,6 @@
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
 asmlinkage void int3(void);
-asmlinkage void invalid_op(void);
 asmlinkage void device_not_available(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
@@ -38,7 +37,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
-asmlinkage void xen_invalid_op(void);
 asmlinkage void xen_device_not_available(void);
 asmlinkage void xen_double_fault(void);
 asmlinkage void xen_coprocessor_segment_overrun(void);
@@ -59,7 +57,6 @@ asmlinkage void xen_simd_coprocessor_err
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
-dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
@@ -86,6 +83,11 @@ struct bad_iret_stack *fixup_bad_iret(st
 void __init trap_init(void);
 #endif
 
+#ifdef CONFIG_X86_F00F_BUG
+/* For handling the FOOF bug */
+void handle_invalid_op(struct pt_regs *regs);
+#endif
+
 static inline int get_si_code(unsigned long condition)
 {
 	if (condition & DR_STEP)
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -73,7 +73,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
 	INTG(X86_TRAP_NMI,		nmi),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
-	INTG(X86_TRAP_UD,		invalid_op),
+	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		device_not_available),
 	INTG(X86_TRAP_OLD_MF,		coprocessor_segment_overrun),
 	INTG(X86_TRAP_TS,		invalid_TSS),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -221,6 +221,21 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
+#ifdef CONFIG_X86_F00F_BUG
+void handle_invalid_op(struct pt_regs *regs)
+#else
+static inline void handle_invalid_op(struct pt_regs *regs)
+#endif
+{
+	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
+		      ILL_ILLOPN, error_get_trap_addr(regs));
+}
+
+DEFINE_IDTENTRY(exc_invalid_op)
+{
+	handle_invalid_op(regs);
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -228,7 +243,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
 DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -567,7 +567,7 @@ static int is_f00f_bug(struct pt_regs *r
 		nr = (address - idt_descr.address) >> 3;
 
 		if (nr == 6) {
-			do_invalid_op(regs, 0);
+			handle_invalid_op(regs);
 			return 1;
 		}
 	}
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -625,7 +625,7 @@ static struct trap_array_entry trap_arra
 	{ page_fault,                  xen_page_fault,                  false },
 	TRAP_ENTRY(exc_divide_error,			false ),
 	TRAP_ENTRY(exc_bounds,				false ),
-	{ invalid_op,                  xen_invalid_op,                  false },
+	TRAP_ENTRY(exc_invalid_op,			false ),
 	{ device_not_available,        xen_device_not_available,        false },
 	{ coprocessor_segment_overrun, xen_coprocessor_segment_overrun, false },
 	{ invalid_TSS,                 xen_invalid_TSS,                 false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -35,7 +35,7 @@ xen_pv_trap int3
 xen_pv_trap xennmi
 xen_pv_trap asm_exc_overflow
 xen_pv_trap asm_exc_bounds
-xen_pv_trap invalid_op
+xen_pv_trap asm_exc_invalid_op
 xen_pv_trap device_not_available
 xen_pv_trap double_fault
 xen_pv_trap coprocessor_segment_overrun

