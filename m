Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE621DBDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 21:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETTRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:17:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6086AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:17:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbUCq-0000s0-7Q; Wed, 20 May 2020 21:16:44 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A3FFB100C99; Wed, 20 May 2020 21:16:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
In-Reply-To: <CALCETrX4Zy2iuc39XTifYd_mvezCEUtW2ax3=ec1TF=yZxAHDg@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de> <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com> <87imgr7nwp.fsf@nanos.tec.linutronix.de> <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com> <87y2pm4ruh.fsf@nanos.tec.linutronix.de> <CALCETrUvH5DQvL6Lo6EkM04pr7wWj+7eZbTg3H_eLNXcZsH0FA@mail.gmail.com> <CALCETrX4Zy2iuc39XTifYd_mvezCEUtW2ax3=ec1TF=yZxAHDg@mail.gmail.com>
Date:   Wed, 20 May 2020 21:16:43 +0200
Message-ID: <871rnewh5w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> Andrew Cooper pointed out that there is too much magic in Xen for this
> to work.  So never mind.

:)

But you made me stare more at that stuff and I came up with a way
simpler solution. See below.

Thanks,

        tglx

8<--------------

 arch/x86/entry/common.c         |   75 ++++++++++++++++++++++++++++++++++++++--
 arch/x86/entry/entry_32.S       |   17 ++++-----
 arch/x86/entry/entry_64.S       |   22 +++--------
 arch/x86/include/asm/idtentry.h |   13 ++++++
 arch/x86/xen/setup.c            |    4 +-
 arch/x86/xen/smp_pv.c           |    3 +
 arch/x86/xen/xen-asm_32.S       |   12 +++---
 arch/x86/xen/xen-asm_64.S       |    2 -
 arch/x86/xen/xen-ops.h          |    1 
 drivers/xen/Makefile            |    2 -
 drivers/xen/preempt.c           |   42 ----------------------
 11 files changed, 115 insertions(+), 78 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -27,6 +27,9 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
+#include <xen/xen-ops.h>
+#include <xen/events.h>
+
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/vdso.h>
@@ -35,6 +38,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/syscall.h>
+#include <asm/irq_stack.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -539,7 +543,8 @@ void noinstr idtentry_enter(struct pt_re
 	}
 }
 
-static __always_inline void __idtentry_exit(struct pt_regs *regs)
+static __always_inline void __idtentry_exit(struct pt_regs *regs,
+					    bool may_sched)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -548,7 +553,7 @@ static __always_inline void __idtentry_e
 		prepare_exit_to_usermode(regs);
 	} else if (regs->flags & X86_EFLAGS_IF) {
 		/* Check kernel preemption, if enabled */
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+		if (IS_ENABLED(CONFIG_PREEMPTION) || may_resched) {
 			/*
 			 * This needs to be done very carefully.
 			 * idtentry_enter() invoked rcu_irq_enter(). This
@@ -612,5 +617,69 @@ static __always_inline void __idtentry_e
  */
 void noinstr idtentry_exit(struct pt_regs *regs)
 {
-	__idtentry_exit(regs);
+	__idtentry_exit(regs, false);
+}
+
+#ifdef CONFIG_XEN_PV
+
+#ifndef CONFIG_PREEMPTION
+/*
+ * Some hypercalls issued by the toolstack can take many 10s of
+ * seconds. Allow tasks running hypercalls via the privcmd driver to
+ * be voluntarily preempted even if full kernel preemption is
+ * disabled.
+ *
+ * Such preemptible hypercalls are bracketed by
+ * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
+ * calls.
+ */
+DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
+EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
+
+/*
+ * In case of scheduling the flag must be cleared and restored after
+ * returning from schedule as the task might move to a different CPU.
+ */
+static __always_inline bool get_and_clear_inhcall(void)
+{
+	boot inhcall = __this_cpu_read(xen_in_preemptible_hcall);
+
+	__this_cpu_write(xen_in_preemptible_hcall, false);
+}
+
+static __always_inline void restore_inhcall(bool inhcall)
+{
+	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
+}
+#else
+static __always_inline bool get_and_clear_inhcall(void) { return false; }
+static __always_inline void restore_inhcall(bool inhcall) { }
+#endif
+
+static void __xen_pv_evtchn_do_upcall(void)
+{
+	irq_enter_rcu();
+	inc_irq_stat(irq_hv_callback_count);
+
+	xen_hvm_evtchn_do_upcall();
+
+	irq_exit_rcu();
+}
+
+__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	bool inhcall;
+
+	idtentry_enter(regs);
+	old_regs = set_irq_regs(regs);
+
+	run_on_irqstack(__xen_pv_evtchn_do_upcall, NULL, regs);
+
+	set_irq_regs(old_regs);
+
+	inhcall = get_and_clear_inhcall();
+	__idtentry_exit(regs, inhcall);
+	restore_inhcall(inhcall);
 }
+#endif /* CONFIG_XEN_PV */
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1298,7 +1298,10 @@ SYM_CODE_END(native_iret)
 #endif
 
 #ifdef CONFIG_XEN_PV
-SYM_FUNC_START(xen_hypervisor_callback)
+/*
+ * See comment in entry_64.S for further explanation
+ */
+SYM_FUNC_START(exc_xen_hypervisor_callback)
 	/*
 	 * Check to see if we got the event in the critical
 	 * region in xen_iret_direct, after we've reenabled
@@ -1315,14 +1318,11 @@ SYM_FUNC_START(xen_hypervisor_callback)
 	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
+
 	mov	%esp, %eax
-	call	xen_evtchn_do_upcall
-#ifndef CONFIG_PREEMPTION
-	call	xen_maybe_preempt_hcall
-#endif
-	jmp	ret_from_intr
-SYM_FUNC_END(xen_hypervisor_callback)
+	call	xen_pv_evtchn_do_upcall
+	jmp	handle_exception_return
+SYM_FUNC_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
@@ -1464,6 +1464,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exce
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC edi
 
+handle_exception_return:
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb	PT_CS(%esp), %al
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1067,10 +1067,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-#ifdef CONFIG_XEN_PV
-idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
@@ -1158,9 +1154,10 @@ SYM_FUNC_END(asm_call_on_stack)
  * So, on entry to the handler we detect whether we interrupted an
  * existing activation in its critical region -- if so, we pop the current
  * activation and restart the handler using the previous one.
+ *
+ * C calling convention: exc_xen_hypervisor_callback(struct *pt_regs)
  */
-/* do_hypervisor_callback(struct *pt_regs) */
-SYM_CODE_START_LOCAL(xen_do_hypervisor_callback)
+SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
 
 /*
  * Since we don't modify %rdi, evtchn_do_upall(struct *pt_regs) will
@@ -1170,15 +1167,10 @@ SYM_CODE_START_LOCAL(xen_do_hypervisor_c
 	movq	%rdi, %rsp			/* we don't return, adjust the stack frame */
 	UNWIND_HINT_REGS
 
-	ENTER_IRQ_STACK old_rsp=%r10
-	call	xen_evtchn_do_upcall
-	LEAVE_IRQ_STACK
-
-#ifndef CONFIG_PREEMPTION
-	call	xen_maybe_preempt_hcall
-#endif
-	jmp	error_exit
-SYM_CODE_END(xen_do_hypervisor_callback)
+	call	xen_pv_evtchn_do_upcall
+
+	jmp	error_return
+SYM_CODE_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -332,6 +332,13 @@ static __always_inline void __##func(str
  * This avoids duplicate defines and ensures that everything is consistent.
  */
 
+/*
+ * Dummy trap number so the low level ASM macro vector number checks do not
+ * match which results in emitting plain IDTENTRY stubs without bells and
+ * whistels.
+ */
+#define X86_TRAP_OTHER		0xFFFF
+
 /* Simple exception entry points. No hardware error code */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
@@ -371,4 +378,10 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug)
 /* #DF */
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
 
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
+#endif
+
+#undef X86_TRAP_OTHER
+
 #endif
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -20,6 +20,7 @@
 #include <asm/setup.h>
 #include <asm/acpi.h>
 #include <asm/numa.h>
+#include <asm/idtentry.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -993,7 +994,8 @@ static void __init xen_pvmmu_arch_setup(
 	HYPERVISOR_vm_assist(VMASST_CMD_enable,
 			     VMASST_TYPE_pae_extended_cr3);
 
-	if (register_callback(CALLBACKTYPE_event, xen_hypervisor_callback) ||
+	if (register_callback(CALLBACKTYPE_event,
+			      xen_asm_exc_xen_hypervisor_callback) ||
 	    register_callback(CALLBACKTYPE_failsafe, xen_failsafe_callback))
 		BUG();
 
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -27,6 +27,7 @@
 #include <asm/paravirt.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
+#include <asm/idtentry.h>
 #include <asm/cpu.h>
 
 #include <xen/interface/xen.h>
@@ -347,7 +348,7 @@ cpu_initialize_context(unsigned int cpu,
 	ctxt->gs_base_kernel = per_cpu_offset(cpu);
 #endif
 	ctxt->event_callback_eip    =
-		(unsigned long)xen_hypervisor_callback;
+		(unsigned long)xen_asm_exc_xen_hypervisor_callback;
 	ctxt->failsafe_callback_eip =
 		(unsigned long)xen_failsafe_callback;
 	per_cpu(xen_cr3, cpu) = __pa(swapper_pg_dir);
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -93,7 +93,7 @@ SYM_CODE_START(xen_iret)
 
 	/*
 	 * If there's something pending, mask events again so we can
-	 * jump back into xen_hypervisor_callback. Otherwise do not
+	 * jump back into exc_xen_hypervisor_callback. Otherwise do not
 	 * touch XEN_vcpu_info_mask.
 	 */
 	jne 1f
@@ -113,7 +113,7 @@ SYM_CODE_START(xen_iret)
 	 * Events are masked, so jumping out of the critical region is
 	 * OK.
 	 */
-	je xen_hypervisor_callback
+	je asm_exc_xen_hypervisor_callback
 
 1:	iret
 xen_iret_end_crit:
@@ -127,7 +127,7 @@ SYM_CODE_END(xen_iret)
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
 /*
- * This is called by xen_hypervisor_callback in entry_32.S when it sees
+ * This is called by exc_xen_hypervisor_callback in entry_32.S when it sees
  * that the EIP at the time of interrupt was between
  * xen_iret_start_crit and xen_iret_end_crit.
  *
@@ -144,7 +144,7 @@ SYM_CODE_END(xen_iret)
  *	 eflags		}
  *	 cs		}  nested exception info
  *	 eip		}
- *	 return address	: (into xen_hypervisor_callback)
+ *	 return address	: (into asm_exc_xen_hypervisor_callback)
  *
  * In order to deliver the nested exception properly, we need to discard the
  * nested exception frame such that when we handle the exception, we do it
@@ -152,7 +152,8 @@ SYM_CODE_END(xen_iret)
  *
  * The only caveat is that if the outer eax hasn't been restored yet (i.e.
  * it's still on stack), we need to restore its value here.
- */
+*/
+.pushsection .noinstr.text, "ax"
 SYM_CODE_START(xen_iret_crit_fixup)
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
@@ -181,3 +182,4 @@ SYM_CODE_START(xen_iret_crit_fixup)
 2:
 	ret
 SYM_CODE_END(xen_iret_crit_fixup)
+.popsection
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -54,7 +54,7 @@ xen_pv_trap asm_exc_simd_coprocessor_err
 #ifdef CONFIG_IA32_EMULATION
 xen_pv_trap entry_INT80_compat
 #endif
-xen_pv_trap hypervisor_callback
+xen_pv_trap asm_exc_xen_hypervisor_callback
 
 	__INIT
 SYM_CODE_START(xen_early_idt_handler_array)
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -8,7 +8,6 @@
 #include <xen/xen-ops.h>
 
 /* These are code, but not functions.  Defined in entry.S */
-extern const char xen_hypervisor_callback[];
 extern const char xen_failsafe_callback[];
 
 void xen_sysenter_target(void);
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
-obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
+obj-y	+= grant-table.o features.o balloon.o manage.o time.o
 obj-y	+= mem-reservation.o
 obj-y	+= events/
 obj-y	+= xenbus/
--- a/drivers/xen/preempt.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Preemptible hypercalls
- *
- * Copyright (C) 2014 Citrix Systems R&D ltd.
- */
-
-#include <linux/sched.h>
-#include <xen/xen-ops.h>
-
-#ifndef CONFIG_PREEMPTION
-
-/*
- * Some hypercalls issued by the toolstack can take many 10s of
- * seconds. Allow tasks running hypercalls via the privcmd driver to
- * be voluntarily preempted even if full kernel preemption is
- * disabled.
- *
- * Such preemptible hypercalls are bracketed by
- * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
- * calls.
- */
-
-DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
-EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
-
-asmlinkage __visible void xen_maybe_preempt_hcall(void)
-{
-	if (unlikely(__this_cpu_read(xen_in_preemptible_hcall)
-		     && need_resched())) {
-		/*
-		 * Clear flag as we may be rescheduled on a different
-		 * cpu.
-		 */
-		__this_cpu_write(xen_in_preemptible_hcall, false);
-		local_irq_enable();
-		cond_resched();
-		local_irq_disable();
-		__this_cpu_write(xen_in_preemptible_hcall, true);
-	}
-}
-#endif /* CONFIG_PREEMPTION */
