Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76FF2C8021
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgK3IhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgK3IhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:37:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1105C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qIb50yKovGBQs/bZksPtu11iL0Mi53YMxJTDOWsbJrE=; b=O4uwm0LyvyUdgIg6esnbT74Nyo
        LW1NQ2U4hH4IIESS89CUTR+2daJxi+BtK0ZMuqOJjDlnjguFnWOGrW6NE3hkyB4RZuixrP5VK3IR8
        erWZPGzP99gCAzzvjnHQW8G///pwhKhnKjvp50APZ4B5OaC/QuAc2v7KTVeAbpwxDAlF39smfTKw6
        cVj57ozm72qQcaoJnJx0Epq/FFJJimg6/yGvddHT2UW4QhbVJZNkjIP2LIvA+ycYpXzQRoSgulKUD
        kt3Io25AeWJMIbGAkgKeiZumRu7YfDDfYY/yixuzFpb2EfHKLlI4em4kQlJGQZVGEhs2IE0OdEmTs
        ptPgQw/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjefX-0004Pw-OT; Mon, 30 Nov 2020 08:36:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E714C3003E1;
        Mon, 30 Nov 2020 09:36:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDC53203EEFB6; Mon, 30 Nov 2020 09:36:22 +0100 (CET)
Date:   Mon, 30 Nov 2020 09:36:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201130083622.GH3092@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:56:51AM +0100, Peter Zijlstra wrote:
> The idea was to flip all of arch_cpu_idle() to not enable interrupts.
> 
> This is suboptimal for things like x86 where arch_cpu_idle() is
> basically STI;HLT, but x86 isn't likely to actually use this code path
> anyway, given all the various cpuidle drivers it has.
> 
> Many of the other archs are now doing things like arm's:
> wfi();raw_local_irq_enable().
> 
> Doing that tree-wide interrupt-state flip was something I didn't want to
> do at this late a stage, the chanse of messing that up is just too high.

It looks something like the below, but this needs to soak a bit because
who knows, I might've missed some obscure case ...

And then, after I've also flipped cpuidle, I need to go noinstr annotate
all the actual idle code :-/ (which is going to be a pain due to chasing
function pointers).

---
 arch/alpha/kernel/process.c      |  1 -
 arch/arc/kernel/process.c        |  3 +++
 arch/arm/kernel/process.c        |  1 -
 arch/arm/mach-gemini/board-dt.c  |  3 ++-
 arch/arm64/kernel/process.c      |  1 -
 arch/c6x/kernel/process.c        |  1 +
 arch/csky/kernel/process.c       |  1 -
 arch/h8300/kernel/process.c      |  1 +
 arch/hexagon/kernel/process.c    |  1 -
 arch/ia64/kernel/process.c       |  1 +
 arch/microblaze/kernel/process.c |  1 -
 arch/mips/kernel/idle.c          |  7 +------
 arch/nios2/kernel/process.c      |  1 -
 arch/openrisc/kernel/process.c   |  1 +
 arch/parisc/kernel/process.c     |  2 --
 arch/powerpc/kernel/idle.c       |  5 ++---
 arch/riscv/kernel/process.c      |  1 -
 arch/s390/kernel/idle.c          |  1 -
 arch/sh/kernel/idle.c            |  1 +
 arch/sparc/kernel/leon_pmc.c     |  4 ++++
 arch/sparc/kernel/process_32.c   |  1 -
 arch/sparc/kernel/process_64.c   |  3 ++-
 arch/um/kernel/process.c         |  1 -
 arch/x86/kernel/process.c        | 14 ++++----------
 arch/xtensa/kernel/process.c     |  1 +
 kernel/sched/idle.c              | 10 +++-------
 26 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 4c7b0414a3ff..d686e8faec6e 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -57,7 +57,6 @@ EXPORT_SYMBOL(pm_power_off);
 void arch_cpu_idle(void)
 {
 	wtint(0);
-	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_dead(void)
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 37f724ad5e39..1d0832b28d09 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -114,6 +114,8 @@ void arch_cpu_idle(void)
 		"sleep %0	\n"
 		:
 		:"I"(arg)); /* can't be "r" has to be embedded const */
+
+	raw_local_irq_disable();
 }
 
 #else	/* ARC700 */
@@ -122,6 +124,7 @@ void arch_cpu_idle(void)
 {
 	/* sleep, but enable both set E1/E2 (levels of interrutps) before committing */
 	__asm__ __volatile__("sleep 0x3	\n");
+	raw_local_irq_disable();
 }
 
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 9f199b1e8383..f9c97caa52d1 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -71,7 +71,6 @@ void arch_cpu_idle(void)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
-	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_prepare(void)
diff --git a/arch/arm/mach-gemini/board-dt.c b/arch/arm/mach-gemini/board-dt.c
index de0afcc8d94a..fbafe7475c02 100644
--- a/arch/arm/mach-gemini/board-dt.c
+++ b/arch/arm/mach-gemini/board-dt.c
@@ -42,8 +42,9 @@ static void gemini_idle(void)
 	 */
 
 	/* FIXME: Enabling interrupts here is racy! */
-	local_irq_enable();
+	raw_local_irq_enable();
 	cpu_do_idle();
+	raw_local_irq_disable();
 }
 
 static void __init gemini_init_machine(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7697a4b48b7c..07f551879dc5 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -126,7 +126,6 @@ void arch_cpu_idle(void)
 	 * tricks
 	 */
 	cpu_do_idle();
-	raw_local_irq_enable();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index 9f4fd6a40a10..9e638155ca76 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -45,6 +45,7 @@ void arch_cpu_idle(void)
 		      "   mvc .s2 %0,CSR\n"
 		      "|| idle\n"
 		      : "=b"(tmp));
+	raw_local_irq_disable();
 }
 
 static void halt_loop(void)
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 69af6bc87e64..bae792dca7a3 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -102,6 +102,5 @@ void arch_cpu_idle(void)
 #ifdef CONFIG_CPU_PM_STOP
 	asm volatile("stop\n");
 #endif
-	raw_local_irq_enable();
 }
 #endif
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index bc1364db58fe..59e301c3d805 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -59,6 +59,7 @@ void arch_cpu_idle(void)
 {
 	raw_local_irq_enable();
 	__asm__("sleep");
+	raw_local_irq_disable();
 }
 
 void machine_restart(char *__unused)
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 67767c5ed98c..be1fa449b96f 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -44,7 +44,6 @@ void arch_cpu_idle(void)
 {
 	__vmwait();
 	/*  interrupts wake us up, but irqs are still disabled */
-	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index c9ff8796b509..a2851080c491 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -240,6 +240,7 @@ void arch_cpu_idle(void)
 		(*mark_idle)(1);
 
 	raw_safe_halt();
+	raw_local_irq_disable();
 
 	if (mark_idle)
 		(*mark_idle)(0);
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index f99860771ff4..83a8110a758c 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -149,5 +149,4 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 
 void arch_cpu_idle(void)
 {
-       raw_local_irq_enable();
 }
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 18e69ebf5691..1b1e157bc27e 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -33,20 +33,19 @@ static void __cpuidle r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | R30XX_CONF_HALT);
-	raw_local_irq_enable();
 }
 
 static void __cpuidle r39xx_wait(void)
 {
 	if (!need_resched())
 		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
-	raw_local_irq_enable();
 }
 
 void __cpuidle r4k_wait(void)
 {
 	raw_local_irq_enable();
 	__r4k_wait();
+	raw_local_irq_disable();
 }
 
 /*
@@ -64,7 +63,6 @@ void __cpuidle r4k_wait_irqoff(void)
 		"	.set	arch=r4000	\n"
 		"	wait			\n"
 		"	.set	pop		\n");
-	raw_local_irq_enable();
 }
 
 /*
@@ -84,7 +82,6 @@ static void __cpuidle rm7k_wait_irqoff(void)
 		"	wait						\n"
 		"	mtc0	$1, $12		# stalls until W stage	\n"
 		"	.set	pop					\n");
-	raw_local_irq_enable();
 }
 
 /*
@@ -256,8 +253,6 @@ void arch_cpu_idle(void)
 {
 	if (cpu_wait)
 		cpu_wait();
-	else
-		raw_local_irq_enable();
 }
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 50b4eb19a6cc..40236d17b601 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -33,7 +33,6 @@ EXPORT_SYMBOL(pm_power_off);
 
 void arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c98728cce24..eba87ed6603d 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -82,6 +82,7 @@ void arch_cpu_idle(void)
 	raw_local_irq_enable();
 	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
+	raw_local_irq_disable();
 }
 
 void (*pm_power_off) (void) = machine_power_off;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index a92a23d6acd9..cb7858fcf81c 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -169,8 +169,6 @@ void __cpuidle arch_cpu_idle_dead(void)
 
 void __cpuidle arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
-
 	/* nop on real hardware, qemu will idle sleep. */
 	asm volatile("or %%r10,%%r10,%%r10\n":::);
 }
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 1f835539fda4..4195311da67e 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -51,10 +51,9 @@ void arch_cpu_idle(void)
 		 * Some power_save functions return with
 		 * interrupts enabled, some don't.
 		 */
-		if (irqs_disabled())
-			raw_local_irq_enable();
+		if (!irqs_disabled())
+			raw_local_irq_disable();
 	} else {
-		raw_local_irq_enable();
 		/*
 		 * Go into low thread priority and possibly
 		 * low power mode.
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index dd5f985b1f40..886eef55645e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -36,7 +36,6 @@ extern asmlinkage void ret_from_kernel_thread(void);
 void arch_cpu_idle(void)
 {
 	wait_for_interrupt();
-	raw_local_irq_enable();
 }
 
 void show_regs(struct pt_regs *regs)
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 2b85096964f8..5bd8c1044d09 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -123,7 +123,6 @@ void arch_cpu_idle_enter(void)
 void arch_cpu_idle(void)
 {
 	enabled_wait();
-	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_exit(void)
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index f59814983bd5..3418c40f0099 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -25,6 +25,7 @@ void default_idle(void)
 	raw_local_irq_enable();
 	/* Isn't this racy ? */
 	cpu_sleep();
+	raw_local_irq_disable();
 	clear_bl_bit();
 }
 
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index 396f46bca52e..6c00cbad7fb5 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -57,6 +57,8 @@ static void pmc_leon_idle_fixup(void)
 		"lda	[%0] %1, %%g0\n"
 		:
 		: "r"(address), "i"(ASI_LEON_BYPASS));
+
+	raw_local_irq_disable();
 }
 
 /*
@@ -70,6 +72,8 @@ static void pmc_leon_idle(void)
 
 	/* For systems without power-down, this will be no-op */
 	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
+
+	raw_local_irq_disable();
 }
 
 /* Install LEON Power Down function */
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index a02363735915..53c02385e352 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -74,7 +74,6 @@ void arch_cpu_idle(void)
 {
 	if (sparc_idle)
 		(*sparc_idle)();
-	raw_local_irq_enable();
 }
 
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 6f8c7822fc06..e5137da95268 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -62,7 +62,6 @@ void arch_cpu_idle(void)
 {
 	if (tlb_type != hypervisor) {
 		touch_nmi_watchdog();
-		raw_local_irq_enable();
 	} else {
 		unsigned long pstate;
 
@@ -93,6 +92,8 @@ void arch_cpu_idle(void)
 			"wrpr %0, %%g0, %%pstate"
 			: "=&r" (pstate)
 			: "i" (PSTATE_IE));
+
+		raw_local_irq_disable();
 	}
 }
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 9505a7e87396..c3674ac848f0 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -217,7 +217,6 @@ void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
-	raw_local_irq_enable();
 }
 
 int __cant_sleep(void) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..f0973aa101ea 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -686,6 +686,7 @@ void arch_cpu_idle(void)
 void __cpuidle default_idle(void)
 {
 	raw_safe_halt();
+	raw_local_irq_disable();
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -755,13 +756,7 @@ static void amd_e400_idle(void)
 
 	default_idle();
 
-	/*
-	 * The switch back from broadcast mode needs to be called with
-	 * interrupts disabled.
-	 */
-	raw_local_irq_disable();
 	tick_broadcast_exit();
-	raw_local_irq_enable();
 }
 
 /*
@@ -800,12 +795,11 @@ static __cpuidle void mwait_idle(void)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
+		if (!need_resched()) {
 			__sti_mwait(0, 0);
-		else
-			raw_local_irq_enable();
+			raw_local_irq_disable();
+		}
 	} else {
-		raw_local_irq_enable();
 	}
 	__current_clr_polling();
 }
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 397a7de56377..1cea1d92ff12 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -120,6 +120,7 @@ void coprocessor_flush_all(struct thread_info *ti)
 void arch_cpu_idle(void)
 {
 	platform_idle();
+	raw_local_irq_disable();
 }
 
 /*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c6932b8f4467..71a30820bfd2 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -96,8 +96,8 @@ void __cpuidle default_idle_call(void)
 		stop_critical_timings();
 
 		/*
-		 * arch_cpu_idle() is supposed to enable IRQs, however
-		 * we can't do that because of RCU and tracing.
+		 * arch_cpu_idle() is allowed to (temporary) enable IRQs. It
+		 * will return with IRQs disabled.
 		 *
 		 * Trace IRQs enable here, then switch off RCU, and have
 		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
@@ -112,12 +112,8 @@ void __cpuidle default_idle_call(void)
 		arch_cpu_idle();
 
 		/*
-		 * OK, so IRQs are enabled here, but RCU needs them disabled to
-		 * turn itself back on.. funny thing is that disabling IRQs
-		 * will cause tracing, which needs RCU. Jump through hoops to
-		 * make it 'work'.
+		 * Carefully unto the above.
 		 */
-		raw_local_irq_disable();
 		lockdep_hardirqs_off(_THIS_IP_);
 		rcu_idle_exit();
 		lockdep_hardirqs_on(_THIS_IP_);
