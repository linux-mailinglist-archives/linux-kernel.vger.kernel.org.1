Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4921C58B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgEEORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729514AbgEEORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNL-0002XQ-5K; Tue, 05 May 2020 16:16:47 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 86AE51001F5;
        Tue,  5 May 2020 16:16:46 +0200 (CEST)
Message-Id: <20200505135830.189161434@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:54:02 +0200
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
Subject: [patch V4 part 5 21/31] x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC
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

From: Thomas Gleixner <tglx@linutronix.de>

Convert KVM specific system vectors to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>

---
 arch/x86/entry/entry_64.S         |    7 -------
 arch/x86/include/asm/entry_arch.h |    7 -------
 arch/x86/include/asm/hw_irq.h     |    4 ----
 arch/x86/include/asm/idtentry.h   |    6 ++++++
 arch/x86/include/asm/irq.h        |    3 ---
 arch/x86/kernel/idt.c             |    6 +++---
 arch/x86/kernel/irq.c             |   15 ++++++---------
 7 files changed, 15 insertions(+), 33 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -957,13 +957,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-
-#ifdef CONFIG_HAVE_KVM
-apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
-apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_posted_intr_wakeup_ipi
-apicinterrupt3 POSTED_INTR_NESTED_VECTOR	kvm_posted_intr_nested_ipi	smp_kvm_posted_intr_nested_ipi
-#endif
-
 #ifdef CONFIG_SMP
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -13,10 +13,3 @@
 #ifdef CONFIG_SMP
 BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 #endif
-
-#ifdef CONFIG_HAVE_KVM
-BUILD_INTERRUPT(kvm_posted_intr_ipi, POSTED_INTR_VECTOR)
-BUILD_INTERRUPT(kvm_posted_intr_wakeup_ipi, POSTED_INTR_WAKEUP_VECTOR)
-BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
-#endif
-
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -29,10 +29,6 @@
 #include <asm/sections.h>
 
 /* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void kvm_posted_intr_ipi(void);
-extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
-extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-
 extern asmlinkage void reschedule_interrupt(void);
 
 #ifdef	CONFIG_X86_LOCAL_APIC
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -602,6 +602,12 @@ DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,
 # endif
 #endif
 
+#ifdef CONFIG_HAVE_KVM
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
+DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -26,9 +26,6 @@ extern void fixup_irqs(void);
 
 #ifdef CONFIG_HAVE_KVM
 extern void kvm_set_posted_intr_wakeup_handler(void (*handler)(void));
-extern __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs);
-extern __visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs);
-extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 #endif
 
 extern void (*x86_platform_ipi_callback)(void);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -132,9 +132,9 @@ static const __initconst struct idt_data
 	INTG(LOCAL_TIMER_VECTOR,		asm_sysvec_apic_timer_interrupt),
 	INTG(X86_PLATFORM_IPI_VECTOR,		asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
-	INTG(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
-	INTG(POSTED_INTR_WAKEUP_VECTOR,		kvm_posted_intr_wakeup_ipi),
-	INTG(POSTED_INTR_NESTED_VECTOR,		kvm_posted_intr_nested_ipi),
+	INTG(POSTED_INTR_VECTOR,		asm_sysvec_kvm_posted_intr_ipi),
+	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
+	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),
 # endif
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -293,40 +293,37 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
 /*
  * Handler for POSTED_INTERRUPT_VECTOR.
  */
-__visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(kvm_posted_intr_ipis);
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 
 /*
  * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
  */
-__visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(kvm_posted_intr_wakeup_ipis);
 	kvm_posted_intr_wakeup_handler();
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 
 /*
  * Handler for POSTED_INTERRUPT_NESTED_VECTOR.
  */
-__visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_nested_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	entering_ack_irq();
+	ack_APIC_irq();
 	inc_irq_stat(kvm_posted_intr_nested_ipis);
-	exiting_irq();
 	set_irq_regs(old_regs);
 }
 #endif

