Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249572BA993
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgKTLua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbgKTLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:50:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831CC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jdqMfB963wKJGrAzXVqyPE4gEoI0rMwIUGP1EJsxuKA=; b=pztY0M3tWL3DlvEjcIYOj4lSWL
        3gA4vtnTuFFDJbU7ZLBWodvNOVkjp6HL7pKAUVK/lJwKoVrhY030IrX3GHOUrY5TFgnOrCM3/Rjp3
        NGB4sK3ryiW0uQpkiVWfXC23WDFPhg87He22FoxT53s0+EvQ18E7JiwJ8rU213+NQiQeCfwtvErc4
        yqQaYHynFKLgO1X9cBEtGqYfw/7Qnm1TYiKVox+/TLyYavNDI/yH15vqwYhov2b++mlFRLNJ49MqK
        qKgWh6UPlK/7Df4XTbM0zk5b69mvu6t31e2mUCJSy3VB2/CA0fUrNgVelQWai+Kr+gjDCnjhcDPkI
        sKecFXSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg4vl-0003x8-Ul; Fri, 20 Nov 2020 11:50:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0ADE63011C6;
        Fri, 20 Nov 2020 12:50:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E71252B06A141; Fri, 20 Nov 2020 12:50:19 +0100 (CET)
Message-ID: <20201120114925.594122626@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Nov 2020 12:41:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org
Cc:     x86@kernel.org, mark.rutland@arm.com, will@kernel.org,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
References: <20201120114145.197714127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call arch_cpu_idle() with RCU disabled, but then use
local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.

Switch all arch_cpu_idle() implementations to use
raw_local_irq_{en,dis}able() and carefully manage the
lockdep,rcu,tracing state like we do in entry.

(XXX: we really should change arch_cpu_idle() to not return with
interrupts enabled)

Reported-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/kernel/process.c      |    2 +-
 arch/arm/kernel/process.c        |    2 +-
 arch/arm64/kernel/process.c      |    2 +-
 arch/csky/kernel/process.c       |    2 +-
 arch/h8300/kernel/process.c      |    2 +-
 arch/hexagon/kernel/process.c    |    2 +-
 arch/ia64/kernel/process.c       |    2 +-
 arch/microblaze/kernel/process.c |    2 +-
 arch/mips/kernel/idle.c          |   12 ++++++------
 arch/nios2/kernel/process.c      |    2 +-
 arch/openrisc/kernel/process.c   |    2 +-
 arch/parisc/kernel/process.c     |    2 +-
 arch/powerpc/kernel/idle.c       |    4 ++--
 arch/riscv/kernel/process.c      |    2 +-
 arch/s390/kernel/idle.c          |    2 +-
 arch/sh/kernel/idle.c            |    2 +-
 arch/sparc/kernel/leon_pmc.c     |    4 ++--
 arch/sparc/kernel/process_32.c   |    2 +-
 arch/sparc/kernel/process_64.c   |    4 ++--
 arch/um/kernel/process.c         |    2 +-
 arch/x86/include/asm/mwait.h     |    2 --
 arch/x86/kernel/process.c        |   12 +++++++-----
 kernel/sched/idle.c              |   28 +++++++++++++++++++++++++++-
 23 files changed, 62 insertions(+), 36 deletions(-)

--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(pm_power_off);
 void arch_cpu_idle(void)
 {
 	wtint(0);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_dead(void)
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -71,7 +71,7 @@ void arch_cpu_idle(void)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_prepare(void)
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -126,7 +126,7 @@ void arch_cpu_idle(void)
 	 * tricks
 	 */
 	cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -102,6 +102,6 @@ void arch_cpu_idle(void)
 #ifdef CONFIG_CPU_PM_STOP
 	asm volatile("stop\n");
 #endif
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 #endif
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -57,7 +57,7 @@ asmlinkage void ret_from_kernel_thread(v
  */
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	__asm__("sleep");
 }
 
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -44,7 +44,7 @@ void arch_cpu_idle(void)
 {
 	__vmwait();
 	/*  interrupts wake us up, but irqs are still disabled */
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -239,7 +239,7 @@ void arch_cpu_idle(void)
 	if (mark_idle)
 		(*mark_idle)(1);
 
-	safe_halt();
+	raw_safe_halt();
 
 	if (mark_idle)
 		(*mark_idle)(0);
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -149,5 +149,5 @@ int dump_fpu(struct pt_regs *regs, elf_f
 
 void arch_cpu_idle(void)
 {
-       local_irq_enable();
+       raw_local_irq_enable();
 }
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -33,19 +33,19 @@ static void __cpuidle r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | R30XX_CONF_HALT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 static void __cpuidle r39xx_wait(void)
 {
 	if (!need_resched())
 		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void __cpuidle r4k_wait(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	__r4k_wait();
 }
 
@@ -64,7 +64,7 @@ void __cpuidle r4k_wait_irqoff(void)
 		"	.set	arch=r4000	\n"
 		"	wait			\n"
 		"	.set	pop		\n");
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -84,7 +84,7 @@ static void __cpuidle rm7k_wait_irqoff(v
 		"	wait						\n"
 		"	mtc0	$1, $12		# stalls until W stage	\n"
 		"	.set	pop					\n");
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -257,7 +257,7 @@ void arch_cpu_idle(void)
 	if (cpu_wait)
 		cpu_wait();
 	else
-		local_irq_enable();
+		raw_local_irq_enable();
 }
 
 #ifdef CONFIG_CPU_IDLE
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(pm_power_off);
 
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -79,7 +79,7 @@ void machine_power_off(void)
  */
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
 }
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -169,7 +169,7 @@ void __cpuidle arch_cpu_idle_dead(void)
 
 void __cpuidle arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	/* nop on real hardware, qemu will idle sleep. */
 	asm volatile("or %%r10,%%r10,%%r10\n":::);
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -52,9 +52,9 @@ void arch_cpu_idle(void)
 		 * interrupts enabled, some don't.
 		 */
 		if (irqs_disabled())
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		local_irq_enable();
+		raw_local_irq_enable();
 		/*
 		 * Go into low thread priority and possibly
 		 * low power mode.
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -36,7 +36,7 @@ extern asmlinkage void ret_from_kernel_t
 void arch_cpu_idle(void)
 {
 	wait_for_interrupt();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void show_regs(struct pt_regs *regs)
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -123,7 +123,7 @@ void arch_cpu_idle_enter(void)
 void arch_cpu_idle(void)
 {
 	enabled_wait();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_exit(void)
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -22,7 +22,7 @@ static void (*sh_idle)(void);
 void default_idle(void)
 {
 	set_bl_bit();
-	local_irq_enable();
+	raw_local_irq_enable();
 	/* Isn't this racy ? */
 	cpu_sleep();
 	clear_bl_bit();
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -50,7 +50,7 @@ static void pmc_leon_idle_fixup(void)
 	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
 
 	/* Interrupts need to be enabled to not hang the CPU */
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	__asm__ __volatile__ (
 		"wr	%%g0, %%asr19\n"
@@ -66,7 +66,7 @@ static void pmc_leon_idle_fixup(void)
 static void pmc_leon_idle(void)
 {
 	/* Interrupts need to be enabled to not hang the CPU */
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	/* For systems without power-down, this will be no-op */
 	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -74,7 +74,7 @@ void arch_cpu_idle(void)
 {
 	if (sparc_idle)
 		(*sparc_idle)();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -62,11 +62,11 @@ void arch_cpu_idle(void)
 {
 	if (tlb_type != hypervisor) {
 		touch_nmi_watchdog();
-		local_irq_enable();
+		raw_local_irq_enable();
 	} else {
 		unsigned long pstate;
 
-		local_irq_enable();
+		raw_local_irq_enable();
 
                 /* The sun4v sleeping code requires that we have PSTATE.IE cleared over
                  * the cpu sleep hypervisor call.
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -217,7 +217,7 @@ void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 int __cant_sleep(void) {
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -88,8 +88,6 @@ static inline void __mwaitx(unsigned lon
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	trace_hardirqs_on();
-
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -685,7 +685,7 @@ void arch_cpu_idle(void)
  */
 void __cpuidle default_idle(void)
 {
-	safe_halt();
+	raw_safe_halt();
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -736,6 +736,8 @@ void stop_this_cpu(void *dummy)
 /*
  * AMD Erratum 400 aware idle routine. We handle it the same way as C3 power
  * states (local apic timer and TSC stop).
+ *
+ * XXX this function is completely buggered vs RCU and tracing.
  */
 static void amd_e400_idle(void)
 {
@@ -757,9 +759,9 @@ static void amd_e400_idle(void)
 	 * The switch back from broadcast mode needs to be called with
 	 * interrupts disabled.
 	 */
-	local_irq_disable();
+	raw_local_irq_disable();
 	tick_broadcast_exit();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -801,9 +803,9 @@ static __cpuidle void mwait_idle(void)
 		if (!need_resched())
 			__sti_mwait(0, 0);
 		else
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		local_irq_enable();
+		raw_local_irq_enable();
 	}
 	__current_clr_polling();
 }
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -78,7 +78,7 @@ void __weak arch_cpu_idle_dead(void) { }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /**
@@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
 
 		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
+
+		/*
+		 * arch_cpu_idle() is supposed to enable IRQs, however
+		 * we can't do that because of RCU and tracing.
+		 *
+		 * Trace IRQs enable here, then switch off RCU, and have
+		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
+		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
+		 * last -- this is very similar to the entry code.
+		 */
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(_THIS_IP_);
 		rcu_idle_enter();
+		lockdep_hardirqs_on(_THIS_IP_);
+
 		arch_cpu_idle();
+
+		/*
+		 * OK, so IRQs are enabled here, but RCU needs them disabled to
+		 * turn itself back on.. funny thing is that disabling IRQs
+		 * will cause tracing, which needs RCU. Jump through hoops to
+		 * make it 'work'.
+		 */
+		raw_local_irq_disable();
+		lockdep_hardirqs_off(_THIS_IP_);
 		rcu_idle_exit();
+		lockdep_hardirqs_on(_THIS_IP_);
+		raw_local_irq_enable();
+
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}


