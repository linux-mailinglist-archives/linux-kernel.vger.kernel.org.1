Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8F2ECD78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbhAGKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:07:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566EC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:06:32 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e340010e7ab4743168569.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3400:10e7:ab47:4316:8569])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 136591EC0505;
        Thu,  7 Jan 2021 11:06:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610013990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MhZATwKHsUOxANVoo/4D0dGaiOJjkTV06P6LFSgWe1I=;
        b=Ey1ffxJ9HnaHkZhI7YYreHtBD3zuN48G3fy2hCCE0SGHFI/5kFZV7w3+DNciZywjq56KSq
        hfb0cqF+DKe04jApWhx27TAplTvqJh6ySBmdthEVKMzO3ASdR6pcu+mX+zVVcAaQCCHfnS
        itES15OmWWmUfhzLJFt6vDmMYOo6DBY=
Date:   Thu, 7 Jan 2021 11:06:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        jpoimboe@redhat.com, sfr@canb.auug.org.au, tony.luck@intel.com
Subject: Re: [RFC][PATCH 6/6] x86/mce: Dont use noinstr for now
Message-ID: <20210107100626.GG14697@zn.tnic>
References: <20210106143619.479313782@infradead.org>
 <20210106144017.779081583@infradead.org>
 <8B866DA6-ED68-4681-8D83-A23E8F18E77C@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8B866DA6-ED68-4681-8D83-A23E8F18E77C@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:57:55PM +0100, Boris Petkov wrote:
> Another thing that we could do is carve out only the stuff which needs
> to be noinstr into a separate compilation unit and disable tracing
> only for that while keeping the rest traceable. Need to try it to see
> how ugly it'll get...

Something like the below, it barely builds.

I haven't found out whether I can even do

ccflags-remove

on a per-file basis, I guess I cannot so that's not there yet.

core_noinstr.c ended up containing all the code needed by the #MC
handler so that should be ok-ish, carve-out-wise.

Also, I've exported a bunch of functions which are in mce/core.c through
the internal.h header so that core_noinstr.c can call them. There are
no more objtool warnings but if it turns out that we have to move those
functions:

+/* core_noinstr.c */
+bool mce_check_crashing_cpu(void);
+void print_mce(struct mce *m);
+void mce_reset(void);
+bool whole_page(struct mce *m);
+u64 mce_rdmsrl(u32 msr);
+void mce_wrmsrl(u32 msr, u64 v);
+void mce_read_aux(struct mce *m, int i);
+void mce_gather_info(struct mce *m, struct pt_regs *regs);

to core_noinstr.c after all, then we can do your solution directly.

Ok, gnight. :-)

---
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 9f020c994154..2fa36118a05f 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y				=  core.o severity.o genpool.o
+# No instrumentation for #MC handler code
+KASAN_SANITIZE_core_instr.o	:= n
+UBSAN_SANITIZE_core_instr.o	:= n
+KCOV_INSTRUMENT_core_instr.o	:= n
+
+obj-y				=  core.o core_noinstr.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= intel.o
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e133ce1e562b..f5db9b98664d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -31,7 +31,6 @@
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/poll.h>
-#include <linux/nmi.h>
 #include <linux/cpu.h>
 #include <linux/ras.h>
 #include <linux/smp.h>
@@ -47,11 +46,10 @@
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
-#include <asm/traps.h>
 #include <asm/tlbflush.h>
+#include <asm/traps.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
-#include <asm/reboot.h>
 
 #include "internal.h"
 
@@ -61,17 +59,11 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
-#define SPINUNIT		100	/* 100ns */
-
 DEFINE_PER_CPU(unsigned, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-	bool			init;			/* initialise bank? */
-};
-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
 #define ATTR_LEN               16
 /* One object for each MCE bank, shared by all CPUs */
@@ -97,9 +89,7 @@ struct mca_config mca_cfg __read_mostly = {
 	.monarch_timeout = -1
 };
 
-static DEFINE_PER_CPU(struct mce, mces_seen);
 static unsigned long mce_need_notify;
-static int cpu_missing;
 
 /*
  * MCA banks polled by the period polling timer for corrected events.
@@ -121,7 +111,7 @@ mce_banks_t mce_banks_ce_disabled;
 static struct work_struct mce_work;
 static struct irq_work mce_irq_work;
 
-static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
+void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
@@ -266,7 +256,7 @@ static void __print_mce(struct mce *m)
 		m->microcode);
 }
 
-static void print_mce(struct mce *m)
+void print_mce(struct mce *m)
 {
 	__print_mce(m);
 
@@ -274,86 +264,6 @@ static void print_mce(struct mce *m)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
-#define PANIC_TIMEOUT 5 /* 5 seconds */
-
-static atomic_t mce_panicked;
-
-static int fake_panic;
-static atomic_t mce_fake_panicked;
-
-/* Panic in progress. Enable interrupts and wait for final IPI */
-static void wait_for_panic(void)
-{
-	long timeout = PANIC_TIMEOUT*USEC_PER_SEC;
-
-	preempt_disable();
-	local_irq_enable();
-	while (timeout-- > 0)
-		udelay(1);
-	if (panic_timeout == 0)
-		panic_timeout = mca_cfg.panic_timeout;
-	panic("Panicing machine check CPU died");
-}
-
-static void mce_panic(const char *msg, struct mce *final, char *exp)
-{
-	int apei_err = 0;
-	struct llist_node *pending;
-	struct mce_evt_llist *l;
-
-	if (!fake_panic) {
-		/*
-		 * Make sure only one CPU runs in machine check panic
-		 */
-		if (atomic_inc_return(&mce_panicked) > 1)
-			wait_for_panic();
-		barrier();
-
-		bust_spinlocks(1);
-		console_verbose();
-	} else {
-		/* Don't log too much for fake panic */
-		if (atomic_inc_return(&mce_fake_panicked) > 1)
-			return;
-	}
-	pending = mce_gen_pool_prepare_records();
-	/* First print corrected ones that are still unlogged */
-	llist_for_each_entry(l, pending, llnode) {
-		struct mce *m = &l->mce;
-		if (!(m->status & MCI_STATUS_UC)) {
-			print_mce(m);
-			if (!apei_err)
-				apei_err = apei_write_mce(m);
-		}
-	}
-	/* Now print uncorrected but with the final one last */
-	llist_for_each_entry(l, pending, llnode) {
-		struct mce *m = &l->mce;
-		if (!(m->status & MCI_STATUS_UC))
-			continue;
-		if (!final || mce_cmp(m, final)) {
-			print_mce(m);
-			if (!apei_err)
-				apei_err = apei_write_mce(m);
-		}
-	}
-	if (final) {
-		print_mce(final);
-		if (!apei_err)
-			apei_err = apei_write_mce(final);
-	}
-	if (cpu_missing)
-		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
-	if (exp)
-		pr_emerg(HW_ERR "Machine check: %s\n", exp);
-	if (!fake_panic) {
-		if (panic_timeout == 0)
-			panic_timeout = mca_cfg.panic_timeout;
-		panic(msg);
-	} else
-		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-}
-
 /* Support code for software error injection */
 
 static int msr_to_offset(u32 msr)
@@ -392,7 +302,7 @@ __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
 }
 
 /* MSR access wrappers used for error injection */
-static noinstr u64 mce_rdmsrl(u32 msr)
+u64 mce_rdmsrl(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -446,7 +356,7 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 	return true;
 }
 
-static noinstr void mce_wrmsrl(u32 msr, u64 v)
+void mce_wrmsrl(u32 msr, u64 v)
 {
 	u32 low, high;
 
@@ -479,7 +389,7 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
  * check into our "mce" struct so that we can use it later to assess
  * the severity of the problem as we read per-bank specific details.
  */
-static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
+void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
 	mce_setup(m);
 
@@ -586,7 +496,7 @@ bool mce_is_memory_error(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
-static bool whole_page(struct mce *m)
+bool whole_page(struct mce *m)
 {
 	if (!mca_cfg.ser || !(m->status & MCI_STATUS_MISCV))
 		return true;
@@ -682,7 +592,7 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static void mce_read_aux(struct mce *m, int i)
+void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(msr_ops.misc(i));
@@ -837,608 +747,6 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 }
 EXPORT_SYMBOL_GPL(machine_check_poll);
 
-/*
- * Do a quick check if any of the events requires a panic.
- * This decides if we keep the events around or clear them.
- */
-static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
-			  struct pt_regs *regs)
-{
-	char *tmp = *msg;
-	int i;
-
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		m->status = mce_rdmsrl(msr_ops.status(i));
-		if (!(m->status & MCI_STATUS_VAL))
-			continue;
-
-		__set_bit(i, validp);
-		if (quirk_no_way_out)
-			quirk_no_way_out(i, m, regs);
-
-		m->bank = i;
-		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			mce_read_aux(m, i);
-			*msg = tmp;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * Variable to establish order between CPUs while scanning.
- * Each CPU spins initially until executing is equal its number.
- */
-static atomic_t mce_executing;
-
-/*
- * Defines order of CPUs on entry. First CPU becomes Monarch.
- */
-static atomic_t mce_callin;
-
-/*
- * Check if a timeout waiting for other CPUs happened.
- */
-static int mce_timed_out(u64 *t, const char *msg)
-{
-	/*
-	 * The others already did panic for some reason.
-	 * Bail out like in a timeout.
-	 * rmb() to tell the compiler that system_state
-	 * might have been modified by someone else.
-	 */
-	rmb();
-	if (atomic_read(&mce_panicked))
-		wait_for_panic();
-	if (!mca_cfg.monarch_timeout)
-		goto out;
-	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1)
-			mce_panic(msg, NULL, NULL);
-		cpu_missing = 1;
-		return 1;
-	}
-	*t -= SPINUNIT;
-out:
-	touch_nmi_watchdog();
-	return 0;
-}
-
-/*
- * The Monarch's reign.  The Monarch is the CPU who entered
- * the machine check handler first. It waits for the others to
- * raise the exception too and then grades them. When any
- * error is fatal panic. Only then let the others continue.
- *
- * The other CPUs entering the MCE handler will be controlled by the
- * Monarch. They are called Subjects.
- *
- * This way we prevent any potential data corruption in a unrecoverable case
- * and also makes sure always all CPU's errors are examined.
- *
- * Also this detects the case of a machine check event coming from outer
- * space (not detected by any CPUs) In this case some external agent wants
- * us to shut down, so panic too.
- *
- * The other CPUs might still decide to panic if the handler happens
- * in a unrecoverable place, but in this case the system is in a semi-stable
- * state and won't corrupt anything by itself. It's ok to let the others
- * continue for a bit first.
- *
- * All the spin loops have timeouts; when a timeout happens a CPU
- * typically elects itself to be Monarch.
- */
-static void mce_reign(void)
-{
-	int cpu;
-	struct mce *m = NULL;
-	int global_worst = 0;
-	char *msg = NULL;
-
-	/*
-	 * This CPU is the Monarch and the other CPUs have run
-	 * through their handlers.
-	 * Grade the severity of the errors of all the CPUs.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct mce *mtmp = &per_cpu(mces_seen, cpu);
-
-		if (mtmp->severity > global_worst) {
-			global_worst = mtmp->severity;
-			m = &per_cpu(mces_seen, cpu);
-		}
-	}
-
-	/*
-	 * Cannot recover? Panic here then.
-	 * This dumps all the mces in the log buffer and stops the
-	 * other CPUs.
-	 */
-	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, NULL, mca_cfg.tolerant, &msg, true);
-		mce_panic("Fatal machine check", m, msg);
-	}
-
-	/*
-	 * For UC somewhere we let the CPU who detects it handle it.
-	 * Also must let continue the others, otherwise the handling
-	 * CPU could deadlock on a lock.
-	 */
-
-	/*
-	 * No machine check event found. Must be some external
-	 * source or one CPU is hung. Panic.
-	 */
-	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
-		mce_panic("Fatal machine check from unknown source", NULL, NULL);
-
-	/*
-	 * Now clear all the mces_seen so that they don't reappear on
-	 * the next mce.
-	 */
-	for_each_possible_cpu(cpu)
-		memset(&per_cpu(mces_seen, cpu), 0, sizeof(struct mce));
-}
-
-static atomic_t global_nwo;
-
-/*
- * Start of Monarch synchronization. This waits until all CPUs have
- * entered the exception handler and then determines if any of them
- * saw a fatal event that requires panic. Then it executes them
- * in the entry order.
- * TBD double check parallel CPU hotunplug
- */
-static int mce_start(int *no_way_out)
-{
-	int order;
-	int cpus = num_online_cpus();
-	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
-
-	if (!timeout)
-		return -1;
-
-	atomic_add(*no_way_out, &global_nwo);
-	/*
-	 * Rely on the implied barrier below, such that global_nwo
-	 * is updated before mce_callin.
-	 */
-	order = atomic_inc_return(&mce_callin);
-
-	/*
-	 * Wait for everyone.
-	 */
-	while (atomic_read(&mce_callin) != cpus) {
-		if (mce_timed_out(&timeout,
-				  "Timeout: Not all CPUs entered broadcast exception handler")) {
-			atomic_set(&global_nwo, 0);
-			return -1;
-		}
-		ndelay(SPINUNIT);
-	}
-
-	/*
-	 * mce_callin should be read before global_nwo
-	 */
-	smp_rmb();
-
-	if (order == 1) {
-		/*
-		 * Monarch: Starts executing now, the others wait.
-		 */
-		atomic_set(&mce_executing, 1);
-	} else {
-		/*
-		 * Subject: Now start the scanning loop one by one in
-		 * the original callin order.
-		 * This way when there are any shared banks it will be
-		 * only seen by one CPU before cleared, avoiding duplicates.
-		 */
-		while (atomic_read(&mce_executing) < order) {
-			if (mce_timed_out(&timeout,
-					  "Timeout: Subject CPUs unable to finish machine check processing")) {
-				atomic_set(&global_nwo, 0);
-				return -1;
-			}
-			ndelay(SPINUNIT);
-		}
-	}
-
-	/*
-	 * Cache the global no_way_out state.
-	 */
-	*no_way_out = atomic_read(&global_nwo);
-
-	return order;
-}
-
-/*
- * Synchronize between CPUs after main scanning loop.
- * This invokes the bulk of the Monarch processing.
- */
-static int mce_end(int order)
-{
-	int ret = -1;
-	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
-
-	if (!timeout)
-		goto reset;
-	if (order < 0)
-		goto reset;
-
-	/*
-	 * Allow others to run.
-	 */
-	atomic_inc(&mce_executing);
-
-	if (order == 1) {
-		/* CHECKME: Can this race with a parallel hotplug? */
-		int cpus = num_online_cpus();
-
-		/*
-		 * Monarch: Wait for everyone to go through their scanning
-		 * loops.
-		 */
-		while (atomic_read(&mce_executing) <= cpus) {
-			if (mce_timed_out(&timeout,
-					  "Timeout: Monarch CPU unable to finish machine check processing"))
-				goto reset;
-			ndelay(SPINUNIT);
-		}
-
-		mce_reign();
-		barrier();
-		ret = 0;
-	} else {
-		/*
-		 * Subject: Wait for Monarch to finish.
-		 */
-		while (atomic_read(&mce_executing) != 0) {
-			if (mce_timed_out(&timeout,
-					  "Timeout: Monarch CPU did not finish machine check processing"))
-				goto reset;
-			ndelay(SPINUNIT);
-		}
-
-		/*
-		 * Don't reset anything. That's done by the Monarch.
-		 */
-		return 0;
-	}
-
-	/*
-	 * Reset all global state.
-	 */
-reset:
-	atomic_set(&global_nwo, 0);
-	atomic_set(&mce_callin, 0);
-	barrier();
-
-	/*
-	 * Let others run again.
-	 */
-	atomic_set(&mce_executing, 0);
-	return ret;
-}
-
-static void mce_clear_state(unsigned long *toclear)
-{
-	int i;
-
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		if (test_bit(i, toclear))
-			mce_wrmsrl(msr_ops.status(i), 0);
-	}
-}
-
-/*
- * Cases where we avoid rendezvous handler timeout:
- * 1) If this CPU is offline.
- *
- * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
- *  skip those CPUs which remain looping in the 1st kernel - see
- *  crash_nmi_callback().
- *
- * Note: there still is a small window between kexec-ing and the new,
- * kdump kernel establishing a new #MC handler where a broadcasted MCE
- * might not get handled properly.
- */
-static noinstr bool mce_check_crashing_cpu(void)
-{
-	unsigned int cpu = smp_processor_id();
-
-	if (arch_cpu_is_offline(cpu) ||
-	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
-		u64 mcgstatus;
-
-		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
-
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
-			if (mcgstatus & MCG_STATUS_LMCES)
-				return false;
-		}
-
-		if (mcgstatus & MCG_STATUS_RIPV) {
-			__wrmsr(MSR_IA32_MCG_STATUS, 0, 0);
-			return true;
-		}
-	}
-	return false;
-}
-
-static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
-			    unsigned long *toclear, unsigned long *valid_banks,
-			    int no_way_out, int *worst)
-{
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	struct mca_config *cfg = &mca_cfg;
-	int severity, i;
-
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		__clear_bit(i, toclear);
-		if (!test_bit(i, valid_banks))
-			continue;
-
-		if (!mce_banks[i].ctl)
-			continue;
-
-		m->misc = 0;
-		m->addr = 0;
-		m->bank = i;
-
-		m->status = mce_rdmsrl(msr_ops.status(i));
-		if (!(m->status & MCI_STATUS_VAL))
-			continue;
-
-		/*
-		 * Corrected or non-signaled errors are handled by
-		 * machine_check_poll(). Leave them alone, unless this panics.
-		 */
-		if (!(m->status & (cfg->ser ? MCI_STATUS_S : MCI_STATUS_UC)) &&
-			!no_way_out)
-			continue;
-
-		/* Set taint even when machine check was not enabled. */
-		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
-
-		/*
-		 * When machine check was for corrected/deferred handler don't
-		 * touch, unless we're panicking.
-		 */
-		if ((severity == MCE_KEEP_SEVERITY ||
-		     severity == MCE_UCNA_SEVERITY) && !no_way_out)
-			continue;
-
-		__set_bit(i, toclear);
-
-		/* Machine check event was not enabled. Clear, but ignore. */
-		if (severity == MCE_NO_SEVERITY)
-			continue;
-
-		mce_read_aux(m, i);
-
-		/* assuming valid severity level != 0 */
-		m->severity = severity;
-
-		mce_log(m);
-
-		if (severity > *worst) {
-			*final = *m;
-			*worst = severity;
-		}
-	}
-
-	/* mce_clear_state will clear *final, save locally for use later */
-	*m = *final;
-}
-
-static void kill_me_now(struct callback_head *ch)
-{
-	force_sig(SIGBUS);
-}
-
-static void kill_me_maybe(struct callback_head *cb)
-{
-	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
-	int flags = MF_ACTION_REQUIRED;
-
-	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
-
-	if (!p->mce_ripv)
-		flags |= MF_MUST_KILL;
-
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
-	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
-		sync_core();
-		return;
-	}
-
-	if (p->mce_vaddr != (void __user *)-1l) {
-		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
-	} else {
-		pr_err("Memory error not recovered");
-		kill_me_now(cb);
-	}
-}
-
-static void queue_task_work(struct mce *m, int kill_current_task)
-{
-	current->mce_addr = m->addr;
-	current->mce_kflags = m->kflags;
-	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
-	current->mce_whole_page = whole_page(m);
-
-	if (kill_current_task)
-		current->mce_kill_me.func = kill_me_now;
-	else
-		current->mce_kill_me.func = kill_me_maybe;
-
-	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
-}
-
-/*
- * The actual machine check handler. This only handles real
- * exceptions when something got corrupted coming in through int 18.
- *
- * This is executed in NMI context not subject to normal locking rules. This
- * implies that most kernel services cannot be safely used. Don't even
- * think about putting a printk in there!
- *
- * On Intel systems this is entered on all CPUs in parallel through
- * MCE broadcast. However some CPUs might be broken beyond repair,
- * so be always careful when synchronizing with others.
- *
- * Tracing and kprobes are disabled: if we interrupted a kernel context
- * with IF=1, we need to minimize stack usage.  There are also recursion
- * issues: if the machine check was due to a failure of the memory
- * backing the user stack, tracing that reads the user stack will cause
- * potentially infinite recursion.
- */
-noinstr void do_machine_check(struct pt_regs *regs)
-{
-	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
-	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
-	struct mca_config *cfg = &mca_cfg;
-	struct mce m, *final;
-	char *msg = NULL;
-	int worst = 0;
-
-	/*
-	 * Establish sequential order between the CPUs entering the machine
-	 * check handler.
-	 */
-	int order = -1;
-
-	/*
-	 * If no_way_out gets set, there is no safe way to recover from this
-	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
-	 */
-	int no_way_out = 0;
-
-	/*
-	 * If kill_current_task is not set, there might be a way to recover from this
-	 * error.
-	 */
-	int kill_current_task = 0;
-
-	/*
-	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
-	 * on Intel.
-	 */
-	int lmce = 1;
-
-	this_cpu_inc(mce_exception_count);
-
-	mce_gather_info(&m, regs);
-	m.tsc = rdtsc();
-
-	final = this_cpu_ptr(&mces_seen);
-	*final = m;
-
-	memset(valid_banks, 0, sizeof(valid_banks));
-	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
-
-	barrier();
-
-	/*
-	 * When no restart IP might need to kill or panic.
-	 * Assume the worst for now, but if we find the
-	 * severity is MCE_AR_SEVERITY we have other options.
-	 */
-	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_current_task = (cfg->tolerant == 3) ? 0 : 1;
-	/*
-	 * Check if this MCE is signaled to only this logical processor,
-	 * on Intel, Zhaoxin only.
-	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL ||
-	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
-		lmce = m.mcgstatus & MCG_STATUS_LMCES;
-
-	/*
-	 * Local machine check may already know that we have to panic.
-	 * Broadcast machine check begins rendezvous in mce_start()
-	 * Go through all banks in exclusion of the other CPUs. This way we
-	 * don't report duplicated events on shared banks because the first one
-	 * to see it will clear it.
-	 */
-	if (lmce) {
-		if (no_way_out && cfg->tolerant < 3)
-			mce_panic("Fatal local machine check", &m, msg);
-	} else {
-		order = mce_start(&no_way_out);
-	}
-
-	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
-
-	if (!no_way_out)
-		mce_clear_state(toclear);
-
-	/*
-	 * Do most of the synchronization with other CPUs.
-	 * When there's any problem use only local no_way_out state.
-	 */
-	if (!lmce) {
-		if (mce_end(order) < 0) {
-			if (!no_way_out)
-				no_way_out = worst >= MCE_PANIC_SEVERITY;
-
-			if (no_way_out && cfg->tolerant < 3)
-				mce_panic("Fatal machine check on current CPU", &m, msg);
-		}
-	} else {
-		/*
-		 * If there was a fatal machine check we should have
-		 * already called mce_panic earlier in this function.
-		 * Since we re-read the banks, we might have found
-		 * something new. Check again to see if we found a
-		 * fatal error. We call "mce_severity()" again to
-		 * make sure we have the right "msg".
-		 */
-		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-			mce_severity(&m, regs, cfg->tolerant, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
-		}
-	}
-
-	if (worst != MCE_AR_SEVERITY && !kill_current_task)
-		goto out;
-
-	/* Fault was in user mode and we need to take some action */
-	if ((m.cs & 3) == 3) {
-		/* If this triggers there is no way to recover. Die hard. */
-		BUG_ON(!on_thread_stack() || !user_mode(regs));
-
-		queue_task_work(&m, kill_current_task);
-
-	} else {
-		/*
-		 * Handle an MCE which has happened in kernel space but from
-		 * which the kernel can recover: ex_has_fault_handler() has
-		 * already verified that the rIP at which the error happened is
-		 * a rIP from which the kernel can recover (by jumping to
-		 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
-		 * corresponding exception handler which would do that is the
-		 * proper one.
-		 */
-		if (m.kflags & MCE_IN_KERNEL_RECOV) {
-			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
-		}
-
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
-	}
-out:
-	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-}
-EXPORT_SYMBOL_GPL(do_machine_check);
-
 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)
 {
@@ -2706,15 +2014,6 @@ struct dentry *mce_get_debugfs_dir(void)
 	return dmce;
 }
 
-static void mce_reset(void)
-{
-	cpu_missing = 0;
-	atomic_set(&mce_fake_panicked, 0);
-	atomic_set(&mce_executing, 0);
-	atomic_set(&mce_callin, 0);
-	atomic_set(&global_nwo, 0);
-}
-
 static int fake_panic_get(void *data, u64 *val)
 {
 	*val = fake_panic;
diff --git a/arch/x86/kernel/cpu/mce/core_noinstr.c b/arch/x86/kernel/cpu/mce/core_noinstr.c
new file mode 100644
index 000000000000..ac03af804726
--- /dev/null
+++ b/arch/x86/kernel/cpu/mce/core_noinstr.c
@@ -0,0 +1,712 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/sched/signal.h>
+#include <linux/nmi.h>
+#include <linux/mm.h>
+
+#include <asm/set_memory.h>
+#include <asm/sync_core.h>
+#include <asm/extable.h>
+#include <asm/reboot.h>
+#include <asm/delay.h>
+#include <asm/traps.h>
+#include <asm/mce.h>
+
+#include "internal.h"
+
+/* 5 seconds */
+#define PANIC_TIMEOUT	5
+/* 100ns */
+#define SPINUNIT	100
+
+static atomic_t global_nwo;
+
+/*
+ * Variable to establish order between CPUs while scanning.
+ * Each CPU spins initially until executing is equal its number.
+ */
+static atomic_t mce_executing;
+
+/*
+ * Defines order of CPUs on entry. First CPU becomes Monarch.
+ */
+static atomic_t mce_callin;
+static atomic_t mce_panicked;
+static atomic_t mce_fake_panicked;
+static int cpu_missing;
+
+int fake_panic;
+
+static DEFINE_PER_CPU(struct mce, mces_seen);
+
+void mce_reset(void)
+{
+	cpu_missing = 0;
+	atomic_set(&mce_fake_panicked, 0);
+	atomic_set(&mce_executing, 0);
+	atomic_set(&mce_callin, 0);
+	atomic_set(&global_nwo, 0);
+}
+
+/* Panic in progress. Enable interrupts and wait for final IPI */
+static void wait_for_panic(void)
+{
+	long timeout = PANIC_TIMEOUT*USEC_PER_SEC;
+
+	preempt_disable();
+	local_irq_enable();
+	while (timeout-- > 0)
+		udelay(1);
+	if (panic_timeout == 0)
+		panic_timeout = mca_cfg.panic_timeout;
+	panic("Panicing machine check CPU died");
+}
+
+static void mce_panic(const char *msg, struct mce *final, char *exp)
+{
+	int apei_err = 0;
+	struct llist_node *pending;
+	struct mce_evt_llist *l;
+
+	if (!fake_panic) {
+		/*
+		 * Make sure only one CPU runs in machine check panic
+		 */
+		if (atomic_inc_return(&mce_panicked) > 1)
+			wait_for_panic();
+		barrier();
+
+		bust_spinlocks(1);
+		console_verbose();
+	} else {
+		/* Don't log too much for fake panic */
+		if (atomic_inc_return(&mce_fake_panicked) > 1)
+			return;
+	}
+	pending = mce_gen_pool_prepare_records();
+	/* First print corrected ones that are still unlogged */
+	llist_for_each_entry(l, pending, llnode) {
+		struct mce *m = &l->mce;
+		if (!(m->status & MCI_STATUS_UC)) {
+			print_mce(m);
+			if (!apei_err)
+				apei_err = apei_write_mce(m);
+		}
+	}
+	/* Now print uncorrected but with the final one last */
+	llist_for_each_entry(l, pending, llnode) {
+		struct mce *m = &l->mce;
+		if (!(m->status & MCI_STATUS_UC))
+			continue;
+		if (!final || mce_cmp(m, final)) {
+			print_mce(m);
+			if (!apei_err)
+				apei_err = apei_write_mce(m);
+		}
+	}
+	if (final) {
+		print_mce(final);
+		if (!apei_err)
+			apei_err = apei_write_mce(final);
+	}
+	if (cpu_missing)
+		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
+	if (exp)
+		pr_emerg(HW_ERR "Machine check: %s\n", exp);
+	if (!fake_panic) {
+		if (panic_timeout == 0)
+			panic_timeout = mca_cfg.panic_timeout;
+		panic(msg);
+	} else
+		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
+}
+
+static void kill_me_now(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void kill_me_maybe(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	int flags = MF_ACTION_REQUIRED;
+
+	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
+
+	if (!p->mce_ripv)
+		flags |= MF_MUST_KILL;
+
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
+	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		sync_core();
+		return;
+	}
+
+	if (p->mce_vaddr != (void __user *)-1l) {
+		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+	} else {
+		pr_err("Memory error not recovered");
+		kill_me_now(cb);
+	}
+}
+
+static void queue_task_work(struct mce *m, int kill_current_task)
+{
+	current->mce_addr = m->addr;
+	current->mce_kflags = m->kflags;
+	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
+	current->mce_whole_page = whole_page(m);
+
+	if (kill_current_task)
+		current->mce_kill_me.func = kill_me_now;
+	else
+		current->mce_kill_me.func = kill_me_maybe;
+
+	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
+}
+
+/*
+ * Do a quick check if any of the events requires a panic.
+ * This decides if we keep the events around or clear them.
+ */
+static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
+			  struct pt_regs *regs)
+{
+	char *tmp = *msg;
+	int i;
+
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
+		m->status = mce_rdmsrl(msr_ops.status(i));
+		if (!(m->status & MCI_STATUS_VAL))
+			continue;
+
+		__set_bit(i, validp);
+		if (quirk_no_way_out)
+			quirk_no_way_out(i, m, regs);
+
+		m->bank = i;
+		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+			mce_read_aux(m, i);
+			*msg = tmp;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Check if a timeout waiting for other CPUs happened.
+ */
+static int mce_timed_out(u64 *t, const char *msg)
+{
+	/*
+	 * The others already did panic for some reason.
+	 * Bail out like in a timeout.
+	 * rmb() to tell the compiler that system_state
+	 * might have been modified by someone else.
+	 */
+	rmb();
+	if (atomic_read(&mce_panicked))
+		wait_for_panic();
+	if (!mca_cfg.monarch_timeout)
+		goto out;
+	if ((s64)*t < SPINUNIT) {
+		if (mca_cfg.tolerant <= 1)
+			mce_panic(msg, NULL, NULL);
+		cpu_missing = 1;
+		return 1;
+	}
+	*t -= SPINUNIT;
+out:
+	touch_nmi_watchdog();
+	return 0;
+}
+
+/*
+ * The Monarch's reign.  The Monarch is the CPU who entered
+ * the machine check handler first. It waits for the others to
+ * raise the exception too and then grades them. When any
+ * error is fatal panic. Only then let the others continue.
+ *
+ * The other CPUs entering the MCE handler will be controlled by the
+ * Monarch. They are called Subjects.
+ *
+ * This way we prevent any potential data corruption in a unrecoverable case
+ * and also makes sure always all CPU's errors are examined.
+ *
+ * Also this detects the case of a machine check event coming from outer
+ * space (not detected by any CPUs) In this case some external agent wants
+ * us to shut down, so panic too.
+ *
+ * The other CPUs might still decide to panic if the handler happens
+ * in a unrecoverable place, but in this case the system is in a semi-stable
+ * state and won't corrupt anything by itself. It's ok to let the others
+ * continue for a bit first.
+ *
+ * All the spin loops have timeouts; when a timeout happens a CPU
+ * typically elects itself to be Monarch.
+ */
+static void mce_reign(void)
+{
+	int cpu;
+	struct mce *m = NULL;
+	int global_worst = 0;
+	char *msg = NULL;
+
+	/*
+	 * This CPU is the Monarch and the other CPUs have run
+	 * through their handlers.
+	 * Grade the severity of the errors of all the CPUs.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct mce *mtmp = &per_cpu(mces_seen, cpu);
+
+		if (mtmp->severity > global_worst) {
+			global_worst = mtmp->severity;
+			m = &per_cpu(mces_seen, cpu);
+		}
+	}
+
+	/*
+	 * Cannot recover? Panic here then.
+	 * This dumps all the mces in the log buffer and stops the
+	 * other CPUs.
+	 */
+	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+		/* call mce_severity() to get "msg" for panic */
+		mce_severity(m, NULL, mca_cfg.tolerant, &msg, true);
+		mce_panic("Fatal machine check", m, msg);
+	}
+
+	/*
+	 * For UC somewhere we let the CPU who detects it handle it.
+	 * Also must let continue the others, otherwise the handling
+	 * CPU could deadlock on a lock.
+	 */
+
+	/*
+	 * No machine check event found. Must be some external
+	 * source or one CPU is hung. Panic.
+	 */
+	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
+		mce_panic("Fatal machine check from unknown source", NULL, NULL);
+
+	/*
+	 * Now clear all the mces_seen so that they don't reappear on
+	 * the next mce.
+	 */
+	for_each_possible_cpu(cpu)
+		memset(&per_cpu(mces_seen, cpu), 0, sizeof(struct mce));
+}
+
+
+/*
+ * Start of Monarch synchronization. This waits until all CPUs have
+ * entered the exception handler and then determines if any of them
+ * saw a fatal event that requires panic. Then it executes them
+ * in the entry order.
+ * TBD double check parallel CPU hotunplug
+ */
+static int mce_start(int *no_way_out)
+{
+	int order;
+	int cpus = num_online_cpus();
+	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+
+	if (!timeout)
+		return -1;
+
+	atomic_add(*no_way_out, &global_nwo);
+	/*
+	 * Rely on the implied barrier below, such that global_nwo
+	 * is updated before mce_callin.
+	 */
+	order = atomic_inc_return(&mce_callin);
+
+	/*
+	 * Wait for everyone.
+	 */
+	while (atomic_read(&mce_callin) != cpus) {
+		if (mce_timed_out(&timeout,
+				  "Timeout: Not all CPUs entered broadcast exception handler")) {
+			atomic_set(&global_nwo, 0);
+			return -1;
+		}
+		ndelay(SPINUNIT);
+	}
+
+	/*
+	 * mce_callin should be read before global_nwo
+	 */
+	smp_rmb();
+
+	if (order == 1) {
+		/*
+		 * Monarch: Starts executing now, the others wait.
+		 */
+		atomic_set(&mce_executing, 1);
+	} else {
+		/*
+		 * Subject: Now start the scanning loop one by one in
+		 * the original callin order.
+		 * This way when there are any shared banks it will be
+		 * only seen by one CPU before cleared, avoiding duplicates.
+		 */
+		while (atomic_read(&mce_executing) < order) {
+			if (mce_timed_out(&timeout,
+					  "Timeout: Subject CPUs unable to finish machine check processing")) {
+				atomic_set(&global_nwo, 0);
+				return -1;
+			}
+			ndelay(SPINUNIT);
+		}
+	}
+
+	/*
+	 * Cache the global no_way_out state.
+	 */
+	*no_way_out = atomic_read(&global_nwo);
+
+	return order;
+}
+
+/*
+ * Synchronize between CPUs after main scanning loop.
+ * This invokes the bulk of the Monarch processing.
+ */
+static int mce_end(int order)
+{
+	int ret = -1;
+	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+
+	if (!timeout)
+		goto reset;
+	if (order < 0)
+		goto reset;
+
+	/*
+	 * Allow others to run.
+	 */
+	atomic_inc(&mce_executing);
+
+	if (order == 1) {
+		/* CHECKME: Can this race with a parallel hotplug? */
+		int cpus = num_online_cpus();
+
+		/*
+		 * Monarch: Wait for everyone to go through their scanning
+		 * loops.
+		 */
+		while (atomic_read(&mce_executing) <= cpus) {
+			if (mce_timed_out(&timeout,
+					  "Timeout: Monarch CPU unable to finish machine check processing"))
+				goto reset;
+			ndelay(SPINUNIT);
+		}
+
+		mce_reign();
+		barrier();
+		ret = 0;
+	} else {
+		/*
+		 * Subject: Wait for Monarch to finish.
+		 */
+		while (atomic_read(&mce_executing) != 0) {
+			if (mce_timed_out(&timeout,
+					  "Timeout: Monarch CPU did not finish machine check processing"))
+				goto reset;
+			ndelay(SPINUNIT);
+		}
+
+		/*
+		 * Don't reset anything. That's done by the Monarch.
+		 */
+		return 0;
+	}
+
+	/*
+	 * Reset all global state.
+	 */
+reset:
+	atomic_set(&global_nwo, 0);
+	atomic_set(&mce_callin, 0);
+	barrier();
+
+	/*
+	 * Let others run again.
+	 */
+	atomic_set(&mce_executing, 0);
+	return ret;
+}
+
+/*
+ * Cases where we avoid rendezvous handler timeout:
+ * 1) If this CPU is offline.
+ *
+ * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
+ *  skip those CPUs which remain looping in the 1st kernel - see
+ *  crash_nmi_callback().
+ *
+ * Note: there still is a small window between kexec-ing and the new,
+ * kdump kernel establishing a new #MC handler where a broadcasted MCE
+ * might not get handled properly.
+ */
+bool noinstr mce_check_crashing_cpu(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (arch_cpu_is_offline(cpu) ||
+	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
+		u64 mcgstatus;
+
+		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
+
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
+			if (mcgstatus & MCG_STATUS_LMCES)
+				return false;
+		}
+
+		if (mcgstatus & MCG_STATUS_RIPV) {
+			__wrmsr(MSR_IA32_MCG_STATUS, 0, 0);
+			return true;
+		}
+	}
+	return false;
+}
+
+
+static void mce_clear_state(unsigned long *toclear)
+{
+	int i;
+
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
+		if (test_bit(i, toclear))
+			mce_wrmsrl(msr_ops.status(i), 0);
+	}
+}
+
+static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
+			    unsigned long *toclear, unsigned long *valid_banks,
+			    int no_way_out, int *worst)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	struct mca_config *cfg = &mca_cfg;
+	int severity, i;
+
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
+		__clear_bit(i, toclear);
+		if (!test_bit(i, valid_banks))
+			continue;
+
+		if (!mce_banks[i].ctl)
+			continue;
+
+		m->misc = 0;
+		m->addr = 0;
+		m->bank = i;
+
+		m->status = mce_rdmsrl(msr_ops.status(i));
+		if (!(m->status & MCI_STATUS_VAL))
+			continue;
+
+		/*
+		 * Corrected or non-signaled errors are handled by
+		 * machine_check_poll(). Leave them alone, unless this panics.
+		 */
+		if (!(m->status & (cfg->ser ? MCI_STATUS_S : MCI_STATUS_UC)) &&
+			!no_way_out)
+			continue;
+
+		/* Set taint even when machine check was not enabled. */
+		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
+		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
+
+		/*
+		 * When machine check was for corrected/deferred handler don't
+		 * touch, unless we're panicking.
+		 */
+		if ((severity == MCE_KEEP_SEVERITY ||
+		     severity == MCE_UCNA_SEVERITY) && !no_way_out)
+			continue;
+
+		__set_bit(i, toclear);
+
+		/* Machine check event was not enabled. Clear, but ignore. */
+		if (severity == MCE_NO_SEVERITY)
+			continue;
+
+		mce_read_aux(m, i);
+
+		/* assuming valid severity level != 0 */
+		m->severity = severity;
+
+		mce_log(m);
+
+		if (severity > *worst) {
+			*final = *m;
+			*worst = severity;
+		}
+	}
+
+	/* mce_clear_state will clear *final, save locally for use later */
+	*m = *final;
+}
+
+/*
+ * The actual machine check handler. This only handles real
+ * exceptions when something got corrupted coming in through int 18.
+ *
+ * This is executed in NMI context not subject to normal locking rules. This
+ * implies that most kernel services cannot be safely used. Don't even
+ * think about putting a printk in there!
+ *
+ * On Intel systems this is entered on all CPUs in parallel through
+ * MCE broadcast. However some CPUs might be broken beyond repair,
+ * so be always careful when synchronizing with others.
+ *
+ * Tracing and kprobes are disabled: if we interrupted a kernel context
+ * with IF=1, we need to minimize stack usage.  There are also recursion
+ * issues: if the machine check was due to a failure of the memory
+ * backing the user stack, tracing that reads the user stack will cause
+ * potentially infinite recursion.
+ */
+void do_machine_check(struct pt_regs *regs)
+{
+	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
+	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
+	struct mca_config *cfg = &mca_cfg;
+	struct mce m, *final;
+	char *msg = NULL;
+	int worst = 0;
+
+	/*
+	 * Establish sequential order between the CPUs entering the machine
+	 * check handler.
+	 */
+	int order = -1;
+
+	/*
+	 * If no_way_out gets set, there is no safe way to recover from this
+	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
+	 */
+	int no_way_out = 0;
+
+	/*
+	 * If kill_current_task is not set, there might be a way to recover from this
+	 * error.
+	 */
+	int kill_current_task = 0;
+
+	/*
+	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
+	 * on Intel.
+	 */
+	int lmce = 1;
+
+	this_cpu_inc(mce_exception_count);
+
+	mce_gather_info(&m, regs);
+	m.tsc = rdtsc();
+
+	final = this_cpu_ptr(&mces_seen);
+	*final = m;
+
+	memset(valid_banks, 0, sizeof(valid_banks));
+	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
+
+	barrier();
+
+	/*
+	 * When no restart IP might need to kill or panic.
+	 * Assume the worst for now, but if we find the
+	 * severity is MCE_AR_SEVERITY we have other options.
+	 */
+	if (!(m.mcgstatus & MCG_STATUS_RIPV))
+		kill_current_task = (cfg->tolerant == 3) ? 0 : 1;
+	/*
+	 * Check if this MCE is signaled to only this logical processor,
+	 * on Intel, Zhaoxin only.
+	 */
+	if (m.cpuvendor == X86_VENDOR_INTEL ||
+	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
+		lmce = m.mcgstatus & MCG_STATUS_LMCES;
+
+	/*
+	 * Local machine check may already know that we have to panic.
+	 * Broadcast machine check begins rendezvous in mce_start()
+	 * Go through all banks in exclusion of the other CPUs. This way we
+	 * don't report duplicated events on shared banks because the first one
+	 * to see it will clear it.
+	 */
+	if (lmce) {
+		if (no_way_out && cfg->tolerant < 3)
+			mce_panic("Fatal local machine check", &m, msg);
+	} else {
+		order = mce_start(&no_way_out);
+	}
+
+	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
+
+	if (!no_way_out)
+		mce_clear_state(toclear);
+
+	/*
+	 * Do most of the synchronization with other CPUs.
+	 * When there's any problem use only local no_way_out state.
+	 */
+	if (!lmce) {
+		if (mce_end(order) < 0) {
+			if (!no_way_out)
+				no_way_out = worst >= MCE_PANIC_SEVERITY;
+
+			if (no_way_out && cfg->tolerant < 3)
+				mce_panic("Fatal machine check on current CPU", &m, msg);
+		}
+	} else {
+		/*
+		 * If there was a fatal machine check we should have
+		 * already called mce_panic earlier in this function.
+		 * Since we re-read the banks, we might have found
+		 * something new. Check again to see if we found a
+		 * fatal error. We call "mce_severity()" again to
+		 * make sure we have the right "msg".
+		 */
+		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+			mce_severity(&m, regs, cfg->tolerant, &msg, true);
+			mce_panic("Local fatal machine check!", &m, msg);
+		}
+	}
+
+	if (worst != MCE_AR_SEVERITY && !kill_current_task)
+		goto out;
+
+	/* Fault was in user mode and we need to take some action */
+	if ((m.cs & 3) == 3) {
+		/* If this triggers there is no way to recover. Die hard. */
+		BUG_ON(!on_thread_stack() || !user_mode(regs));
+
+		queue_task_work(&m, kill_current_task);
+
+	} else {
+		/*
+		 * Handle an MCE which has happened in kernel space but from
+		 * which the kernel can recover: ex_has_fault_handler() has
+		 * already verified that the rIP at which the error happened is
+		 * a rIP from which the kernel can recover (by jumping to
+		 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
+		 * corresponding exception handler which would do that is the
+		 * proper one.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
+				mce_panic("Failed kernel mode recovery", &m, msg);
+		}
+
+		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+			queue_task_work(&m, kill_current_task);
+	}
+out:
+	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+}
+EXPORT_SYMBOL_GPL(do_machine_check);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 88dcc79cfb07..d662f0246e46 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -11,6 +11,15 @@
 /* Pointer to the installed machine check handler for this CPU setup. */
 extern void (*machine_check_vector)(struct pt_regs *);
 
+struct mce_bank {
+	u64  ctl;			/* subevents to enable */
+	bool init;			/* initialise bank? */
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+extern int fake_panic;
+extern void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
+
 enum severity_level {
 	MCE_NO_SEVERITY,
 	MCE_DEFERRED_SEVERITY,
@@ -196,4 +205,14 @@ __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
 				      unsigned long error_code,
 				      unsigned long fault_addr);
 
+/* core_noinstr.c */
+bool mce_check_crashing_cpu(void);
+void print_mce(struct mce *m);
+void mce_reset(void);
+bool whole_page(struct mce *m);
+u64 mce_rdmsrl(u32 msr);
+void mce_wrmsrl(u32 msr, u64 v);
+void mce_read_aux(struct mce *m, int i);
+void mce_gather_info(struct mce *m, struct pt_regs *regs);
+
 #endif /* __X86_MCE_INTERNAL_H__ */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
