Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966131D01FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 00:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgELWXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731281AbgELWXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379AC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIA-0004ef-Df; Wed, 13 May 2020 00:22:27 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C4E071006A1;
        Wed, 13 May 2020 00:22:25 +0200 (CEST)
Message-Id: <20200512213809.997307469@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:05 +0200
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
Subject: [patch V5 06/38] x86/entry: Provide helpers for execute on irqstack
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

Device interrupt handlers and system vector handlers are executed on the
interrupt stack. The stack switch happens in the low level assembly entry
code. This conflicts with the efforts to consolidate the exit code in C to
ensure correctness vs. RCU and tracing.

As there is no way to move #DB away from IST due to the MOV SS issue, the
requirements vs. #DB and NMI for switching to the interrupt stack do not
exist anymore. The only requirement is that interrupts are disabled.

That allows to move the stack switching to C code which simplifies the
entry/exit handling further because it allows to switch stacks after
handling the entry and on exit before handling RCU, return to usermode and
kernel preemption in the same way as for regular exceptions.

The initial attempt of having the stack switching in inline ASM caused too
much headache vs. objtool and the unwinder. After analysing the use cases
it was agreed on that having the stack switch in ASM for the price of an
indirect call is acceptable as the main users are indirect call heavy
anyway and the few system vectors which are empty shells (scheduler IPI and
KVM posted interrupt vectors) can run from the regular stack.

Provide helper functions to check whether the interrupt stack is already
active and whether stack switching is required.

64 bit only for now. 32 bit has a variant of that already. Once this is
cleaned up the two implementations might be consolidated as a cleanup on
top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200507161020.783541450@infradead.org
---
V5: Moved the actual switch to ASM code
---
 arch/x86/entry/entry_64.S        |   39 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/irq_stack.h |   40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1106,6 +1106,45 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 SYM_CODE_END(.Lbad_gs)
 	.previous
 
+/*
+ * rdi: New stack pointer points to the top word of the stack
+ * rsi: Function pointer
+ * rdx: Function argument (can be NULL if none)
+ */
+SYM_FUNC_START(asm_call_on_stack)
+	/*
+	 * Save the frame pointer unconditionally. This allows the ORC
+	 * unwinder to handle the stack switch.
+	 */
+	pushq		%rbp
+	mov		%rsp, %rbp
+
+	/*
+	 * The unwinder relies on the word at the top of the new stack
+	 * page linking back to the previous RSP.
+	 */
+	mov		%rsp, (%rdi)
+	mov		%rdi, %rsp
+	/* Move the argument to the right place */
+	mov		%rdx, %rdi
+
+1:
+	.pushsection .discard.instr_begin
+	.long 1b - .
+	.popsection
+
+	CALL_NOSPEC	rsi
+
+2:
+	.pushsection .discard.instr_end
+	.long 2b - .
+	.popsection
+
+	/* Restore the previous stack pointer from RBP. */
+	leaveq
+	ret
+SYM_FUNC_END(asm_call_on_stack)
+
 /* Call softirq on interrupt stack. Interrupts are off. */
 .pushsection .text, "ax"
 SYM_FUNC_START(do_softirq_own_stack)
--- /dev/null
+++ b/arch/x86/include/asm/irq_stack.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IRQ_STACK_H
+#define _ASM_X86_IRQ_STACK_H
+
+#include <linux/ptrace.h>
+
+#include <asm/processor.h>
+
+#ifdef CONFIG_X86_64
+static __always_inline bool irqstack_active(void)
+{
+	return __this_cpu_read(irq_count) != -1;
+}
+
+void asm_call_on_stack(void *sp, void *func, void *arg);
+
+static __always_inline void run_on_irqstack(void *func, void *arg)
+{
+	void *tos = __this_cpu_read(hardirq_stack_ptr);
+
+	lockdep_assert_irqs_disabled();
+
+	__this_cpu_add(irq_count, 1);
+	asm_call_on_stack(tos - 8, func, arg);
+	__this_cpu_sub(irq_count, 1);
+}
+
+#else /* CONFIG_X86_64 */
+static inline bool irqstack_active(void) { return false; }
+static inline void run_on_irqstack(void *func, void *arg) { }
+#endif /* !CONFIG_X86_64 */
+
+static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
+	return !user_mode(regs) && !irqstack_active();
+}
+
+#endif

