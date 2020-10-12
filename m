Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5C28BF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbgJLRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389562AbgJLRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:47:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DEEC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:47:15 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602524834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9kqA0z6P3LL57ygs5Kwunolmj3Yn14l9IKbNYF8lZRw=;
        b=aS61cG0boXZnHvRYNKolYOnWDhCy0dwnds4VVI7U3wXl35R8b2EdoL/4eSAL/S109SxwOW
        EXeBqbgI6zgKL7xiZ2NRQAvUHlUuLidEpdc0juQRXFXjcYFRqtUSBy3fPrR9rop3JDfj32
        hqBwePIvvaxP99mwBcGNSdTcfapcZMFjwtx9EHiYXJdeU8fdxmswfjQnOa+6OXwziWfC2f
        E4ggc2w4o8HoXRc2vln+m7CjT3yZZDudtVL4CJyTsRdvvm2X0B8UbsZSHL5atbErw97rns
        q1lv1t0Jr3Ne3rLCdxye6qi3v9XoJRPsZ7YuNkoJh4tEZLXCfj88aeimPL7RQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602524834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9kqA0z6P3LL57ygs5Kwunolmj3Yn14l9IKbNYF8lZRw=;
        b=DLSerXFXp//QBkp9mkPIzjfvpHKyypOMk6q4DWek77b59RHTEKrBI0LJd2o4Q7G/gwOMMF
        6uTRTDATlskpm9Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for 5.10-rc1
Message-ID: <160252482265.32373.8059671755708873284.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-10-12

up to:  d53d9bc0cf78: x86/debug: Change thread.debugreg6 to thread.virtual_dr6


More consolidation and correctness fixes for the debug exception:

   - Ensure BTF synchronization under all circumstances

   - Distangle kernel and user mode #DB further

   - Get ordering vs. the debug notifier correct to make KGDB work more
     reliably.

   - Cleanup historical gunk and make the code simpler to understand.

Thanks,

	tglx

------------------>
Peter Zijlstra (11):
      x86/debug: Sync BTF earlier
      x86/debug: Move kprobe_debug_handler() into exc_debug_kernel()
      x86/debug: Remove handle_debug(.user) argument
      x86/debug: Simplify #DB signal code
      x86/debug: Move historical SYSENTER junk into exc_debug_kernel()
      x86/debug: Move cond_local_irq_enable() block into exc_debug_user()
      x86/debug: Remove the historical junk
      x86/debug: Remove aout_dump_debugregs()
      x86/debug: Simplify hw_breakpoint_handler()
      x86/debug: Support negative polarity DR6 bits
      x86/debug: Change thread.debugreg6 to thread.virtual_dr6


 arch/x86/include/asm/debugreg.h  |   2 -
 arch/x86/include/asm/kprobes.h   |   4 ++
 arch/x86/include/asm/processor.h |   2 +-
 arch/x86/kernel/hw_breakpoint.c  |  58 ++--------------
 arch/x86/kernel/kgdb.c           |   5 +-
 arch/x86/kernel/ptrace.c         |   6 +-
 arch/x86/kernel/traps.c          | 146 +++++++++++++++++++++------------------
 7 files changed, 94 insertions(+), 129 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index e89558a3fe4a..cfdf307ddc01 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -90,8 +90,6 @@ static __always_inline bool hw_breakpoint_active(void)
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }
 
-extern void aout_dump_debugregs(struct user *dump);
-
 extern void hw_breakpoint_restore(void);
 
 static __always_inline unsigned long local_db_save(void)
diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 143bc9abe99c..991a7ad540c7 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -106,5 +106,9 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_int3_handler(struct pt_regs *regs);
 extern int kprobe_debug_handler(struct pt_regs *regs);
 
+#else
+
+static inline int kprobe_debug_handler(struct pt_regs *regs) { return 0; }
+
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_X86_KPROBES_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d87994c..d8a82e650810 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -517,7 +517,7 @@ struct thread_struct {
 	/* Save middle states of ptrace breakpoints */
 	struct perf_event	*ptrace_bps[HBP_NUM];
 	/* Debug status used for traps, single steps, etc... */
-	unsigned long           debugreg6;
+	unsigned long           virtual_dr6;
 	/* Keep track of the exact dr7 value set by the user */
 	unsigned long           ptrace_dr7;
 	/* Fault info: */
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b98ff620ba77..03aa33b58165 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -441,42 +441,6 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	return 0;
 }
 
-/*
- * Dump the debug register contents to the user.
- * We can't dump our per cpu values because it
- * may contain cpu wide breakpoint, something that
- * doesn't belong to the current task.
- *
- * TODO: include non-ptrace user breakpoints (perf)
- */
-void aout_dump_debugregs(struct user *dump)
-{
-	int i;
-	int dr7 = 0;
-	struct perf_event *bp;
-	struct arch_hw_breakpoint *info;
-	struct thread_struct *thread = &current->thread;
-
-	for (i = 0; i < HBP_NUM; i++) {
-		bp = thread->ptrace_bps[i];
-
-		if (bp && !bp->attr.disabled) {
-			dump->u_debugreg[i] = bp->attr.bp_addr;
-			info = counter_arch_bp(bp);
-			dr7 |= encode_dr7(i, info->len, info->type);
-		} else {
-			dump->u_debugreg[i] = 0;
-		}
-	}
-
-	dump->u_debugreg[4] = 0;
-	dump->u_debugreg[5] = 0;
-	dump->u_debugreg[6] = current->thread.debugreg6;
-
-	dump->u_debugreg[7] = dr7;
-}
-EXPORT_SYMBOL_GPL(aout_dump_debugregs);
-
 /*
  * Release the user breakpoints used by ptrace
  */
@@ -490,7 +454,7 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
 		t->ptrace_bps[i] = NULL;
 	}
 
-	t->debugreg6 = 0;
+	t->virtual_dr6 = 0;
 	t->ptrace_dr7 = 0;
 }
 
@@ -500,7 +464,7 @@ void hw_breakpoint_restore(void)
 	set_debugreg(__this_cpu_read(cpu_debugreg[1]), 1);
 	set_debugreg(__this_cpu_read(cpu_debugreg[2]), 2);
 	set_debugreg(__this_cpu_read(cpu_debugreg[3]), 3);
-	set_debugreg(current->thread.debugreg6, 6);
+	set_debugreg(DR6_RESERVED, 6);
 	set_debugreg(__this_cpu_read(cpu_dr7), 7);
 }
 EXPORT_SYMBOL_GPL(hw_breakpoint_restore);
@@ -523,10 +487,10 @@ EXPORT_SYMBOL_GPL(hw_breakpoint_restore);
  */
 static int hw_breakpoint_handler(struct die_args *args)
 {
-	int i, cpu, rc = NOTIFY_STOP;
+	int i, rc = NOTIFY_STOP;
 	struct perf_event *bp;
-	unsigned long dr6;
 	unsigned long *dr6_p;
+	unsigned long dr6;
 
 	/* The DR6 value is pointed by args->err */
 	dr6_p = (unsigned long *)ERR_PTR(args->err);
@@ -540,14 +504,6 @@ static int hw_breakpoint_handler(struct die_args *args)
 	if ((dr6 & DR_TRAP_BITS) == 0)
 		return NOTIFY_DONE;
 
-	/*
-	 * Assert that local interrupts are disabled
-	 * Reset the DRn bits in the virtualized register value.
-	 * The ptrace trigger routine will add in whatever is needed.
-	 */
-	current->thread.debugreg6 &= ~DR_TRAP_BITS;
-	cpu = get_cpu();
-
 	/* Handle all the breakpoints that were triggered */
 	for (i = 0; i < HBP_NUM; ++i) {
 		if (likely(!(dr6 & (DR_TRAP0 << i))))
@@ -561,7 +517,7 @@ static int hw_breakpoint_handler(struct die_args *args)
 		 */
 		rcu_read_lock();
 
-		bp = per_cpu(bp_per_reg[i], cpu);
+		bp = this_cpu_read(bp_per_reg[i]);
 		/*
 		 * Reset the 'i'th TRAP bit in dr6 to denote completion of
 		 * exception handling
@@ -592,12 +548,10 @@ static int hw_breakpoint_handler(struct die_args *args)
 	 * breakpoints (to generate signals) and b) when the system has
 	 * taken exception due to multiple causes
 	 */
-	if ((current->thread.debugreg6 & DR_TRAP_BITS) ||
+	if ((current->thread.virtual_dr6 & DR_TRAP_BITS) ||
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
-	put_cpu();
-
 	return rc;
 }
 
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index c2f02f308ecf..ff7878df96b4 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -629,9 +629,10 @@ static void kgdb_hw_overflow_handler(struct perf_event *event,
 	struct task_struct *tsk = current;
 	int i;
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 4; i++) {
 		if (breakinfo[i].enabled)
-			tsk->thread.debugreg6 |= (DR_TRAP0 << i);
+			tsk->thread.virtual_dr6 |= (DR_TRAP0 << i);
+	}
 }
 
 void kgdb_arch_late(void)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e7537c5440bb..bedca011459c 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -465,7 +465,7 @@ static void ptrace_triggered(struct perf_event *bp,
 			break;
 	}
 
-	thread->debugreg6 |= (DR_TRAP0 << i);
+	thread->virtual_dr6 |= (DR_TRAP0 << i);
 }
 
 /*
@@ -601,7 +601,7 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 		if (bp)
 			val = bp->hw.info.address;
 	} else if (n == 6) {
-		val = thread->debugreg6;
+		val = thread->virtual_dr6 ^ DR6_RESERVED; /* Flip back to arch polarity */
 	} else if (n == 7) {
 		val = thread->ptrace_dr7;
 	}
@@ -657,7 +657,7 @@ static int ptrace_set_debugreg(struct task_struct *tsk, int n,
 	if (n < HBP_NUM) {
 		rc = ptrace_set_breakpoint_addr(tsk, n, val);
 	} else if (n == 6) {
-		thread->debugreg6 = val;
+		thread->virtual_dr6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
 		rc = 0;
 	} else if (n == 7) {
 		rc = ptrace_write_dr7(tsk, val);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 81a2fb711091..df9c6554f83e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -745,9 +745,21 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	 * Keep it simple: clear DR6 immediately.
 	 */
 	get_debugreg(dr6, 6);
-	set_debugreg(0, 6);
-	/* Filter out all the reserved bits which are preset to 1 */
-	dr6 &= ~DR6_RESERVED;
+	set_debugreg(DR6_RESERVED, 6);
+	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
+
+	/*
+	 * Clear the virtual DR6 value, ptrace routines will set bits here for
+	 * things we want signals for.
+	 */
+	current->thread.virtual_dr6 = 0;
+
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
 
 	return dr6;
 }
@@ -776,74 +788,20 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
-{
-	struct task_struct *tsk = current;
-	bool user_icebp;
-	int si_code;
-
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
-	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (!user && !dr6)
-		return;
 
+static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
+{
 	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
+	 * Notifiers will clear bits in @dr6 to indicate the event has been
+	 * consumed - hw_breakpoint_handler(), single_stop_cont().
+	 *
+	 * Notifiers will set bits in @virtual_dr6 to indicate the desire
+	 * for signals - ptrace_triggered(), kgdb_hw_overflow_handler().
 	 */
-	user_icebp = user && !dr6;
-
-	/* Store the virtualized DR6 value */
-	tsk->thread.debugreg6 = dr6;
-
-#ifdef CONFIG_KPROBES
-	if (kprobe_debug_handler(regs)) {
-		return;
-	}
-#endif
-
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
-		       SIGTRAP) == NOTIFY_STOP) {
-		return;
-	}
-
-	/* It's safe to allow irq's after DR6 has been saved */
-	cond_local_irq_enable(regs);
-
-	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
-				 X86_TRAP_DB);
-		goto out;
-	}
-
-	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		tsk->thread.debugreg6 &= ~DR_STEP;
-		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
-		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
-	si_code = get_si_code(tsk->thread.debugreg6);
-	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
-		send_sigtrap(regs, 0, si_code);
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
+		return true;
 
-out:
-	cond_local_irq_disable(regs);
+	return false;
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -877,8 +835,32 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
-	handle_debug(regs, dr6, false);
+	if (kprobe_debug_handler(regs))
+		goto out;
+
+	/*
+	 * The kernel doesn't use INT1
+	 */
+	if (!dr6)
+		goto out;
 
+	if (notify_debug(regs, &dr6))
+		goto out;
+
+	/*
+	 * The kernel doesn't use TF single-step outside of:
+	 *
+	 *  - Kprobes, consumed through kprobe_debug_handler()
+	 *  - KGDB, consumed through notify_debug()
+	 *
+	 * So if we get here with DR_STEP set, something is wonky.
+	 *
+	 * A known way to trigger this is through QEMU's GDB stub,
+	 * which leaks #DB into the guest and causes IST recursion.
+	 */
+	if (WARN_ON_ONCE(dr6 & DR_STEP))
+		regs->flags &= ~X86_EFLAGS_TF;
+out:
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
 
@@ -888,6 +870,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
+	bool icebp;
+
 	/*
 	 * If something gets miswired and we end up here for a kernel mode
 	 * #DB, we will malfunction.
@@ -906,8 +890,32 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6, true);
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	icebp = !dr6;
 
+	if (notify_debug(regs, &dr6))
+		goto out;
+
+	/* It's safe to allow irq's after DR6 has been saved */
+	local_irq_enable();
+
+	if (v8086_mode(regs)) {
+		handle_vm86_trap((struct kernel_vm86_regs *)regs, 0, X86_TRAP_DB);
+		goto out_irq;
+	}
+
+	/* Add the virtual_dr6 bits for signals. */
+	dr6 |= current->thread.virtual_dr6;
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(dr6));
+
+out_irq:
+	local_irq_disable();
+out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }

