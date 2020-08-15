Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7060B2452F7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgHOV47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgHOVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5EC061375
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so8455213qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5feyrK3GEwLx1OK+GBXddL/wr0TU4O/j9frRn9tS7+s=;
        b=KM1YiBg3B5GsPNRsms1fOPlZyLk2EggDM10z8gmgJD74wi22HOak0s+FM2sCpTmzzj
         nDQwIlXTopvsGX6U5eY+jTZJbvoBWw7eU/F4H+pirkhsy3WT3qlp7a550zmWOoh8CsEW
         DrXltkue7Y5dNzZjanXONvfefV0YXroIO/wR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5feyrK3GEwLx1OK+GBXddL/wr0TU4O/j9frRn9tS7+s=;
        b=PCNH0v7Fyjb/VEAzlD8XsTfrMWbac39fXpCyvFkd87MfqIT1ncDWUCBAP/AVXpGHtX
         fA+0aFNCV0O/z5tt4yiixeSJW0C72oERPgDzNS4EKwtDbV5eP+cAu25kLKZZYc/ZuKU/
         kHKqaNbIbrtXkbG4Ecj9UF3Hnm8EELIZaqgEwIovjxh9h2C7ccF4/4A7ym36QKD66Rjh
         9tCCg6OeaEbK5ooiwHGD/TbM6141of/LlCyirX56/fP/dFhFK2QjIlpuRmXSfALYI/Vj
         CP7YSVdK3ZECJqTebs1uKfNp/dgBYfxd9L1IaH7cA5rak0zDs4heUN+roBEcrEyWZ5ut
         cr3Q==
X-Gm-Message-State: AOAM531OpNIuaxDwqtlFZRvxKjeX3c45OMnC+YFUNjFRtQGBKYZH6fcT
        25jHyOnY4cnR07qHypmHbnm2PSOTo6CoDQ==
X-Google-Smtp-Source: ABdhPJy7mlADPB9/wh5CWPR5Dso1oSG2ic7EKAsUG9GGreXqCJ2ZqHfJnJBBa7qhRJwtUTeampCnZg==
X-Received: by 2002:ac8:78d:: with SMTP id l13mr5015260qth.188.1597461566872;
        Fri, 14 Aug 2020 20:19:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 04/12] kernel/entry: Add support for core-wide protection of kernel-mode
Date:   Fri, 14 Aug 2020 23:19:00 -0400
Message-Id: <20200815031908.1015049-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core-scheduling prevents hyperthreads in usermode from attacking each
other, but it does not do anything about one of the hyperthreads
entering the kernel for any reason. This leaves the door open for MDS
and L1TF attacks with concurrent execution sequences between
hyperthreads.

This patch therefore adds support for protecting all syscall and IRQ
kernel mode entries. Care is taken to track the outermost usermode exit
and entry using per-cpu counters. In cases where one of the hyperthreads
enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
when not needed - example: idle and non-cookie HTs do not need to be
forced into kernel mode.

More information about attacks:
For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
data to either host or guest attackers. For L1TF, it is possible to leak
to guest attackers. There is no possible mitigation involving flushing
of buffers to avoid this since the execution of attacker and victims
happen concurrently on 2 or more HTs.

Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h |  12 +++
 kernel/entry/common.c |  88 +++++++++++-------
 kernel/sched/core.c   | 205 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |   3 +
 4 files changed, 277 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 295e3258c9bf..910274141ab2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2054,4 +2054,16 @@ int sched_trace_rq_cpu(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+void sched_core_unsafe_enter(void);
+void sched_core_unsafe_exit(void);
+void sched_core_unsafe_exit_wait(unsigned long ti_check);
+void sched_core_wait_till_safe(unsigned long ti_check);
+#else
+#define sched_core_unsafe_enter(ignore) do { } while (0)
+#define sched_core_unsafe_exit(ignore) do { } while (0)
+#define sched_core_wait_till_safe(ignore) do { } while (0)
+#define sched_core_unsafe_exit_wait(ignore) do { } while (0)
+#endif
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 495f5c051b03..3027ec474567 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -28,6 +28,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
+	sched_core_unsafe_enter();
 	instrumentation_end();
 }
 
@@ -111,59 +112,84 @@ static __always_inline void exit_to_user_mode(void)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal(struct pt_regs *regs) { }
 
-static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
+static inline bool exit_to_user_mode_work_pending(unsigned long ti_work)
 {
-	/*
-	 * Before returning to user space ensure that all pending work
-	 * items have been completed.
-	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+	return (ti_work & EXIT_TO_USER_MODE_WORK);
+}
 
-		local_irq_enable_exit_to_user(ti_work);
+static inline void exit_to_user_mode_work(struct pt_regs *regs,
+					  unsigned long ti_work)
+{
 
-		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+	local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_UPROBE)
-			uprobe_notify_resume(regs);
+	if (ti_work & _TIF_NEED_RESCHED)
+		schedule();
 
-		if (ti_work & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
+	if (ti_work & _TIF_UPROBE)
+		uprobe_notify_resume(regs);
 
-		if (ti_work & _TIF_SIGPENDING)
-			arch_do_signal(regs);
+	if (ti_work & _TIF_PATCH_PENDING)
+		klp_update_patch_state(current);
 
-		if (ti_work & _TIF_NOTIFY_RESUME) {
-			clear_thread_flag(TIF_NOTIFY_RESUME);
-			tracehook_notify_resume(regs);
-			rseq_handle_notify_resume(NULL, regs);
-		}
+	if (ti_work & _TIF_SIGPENDING)
+		arch_do_signal(regs);
+
+	if (ti_work & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
+	}
+
+	/* Architecture specific TIF work */
+	arch_exit_to_user_mode_work(regs, ti_work);
+
+	local_irq_disable_exit_to_user();
+}
 
-		/* Architecture specific TIF work */
-		arch_exit_to_user_mode_work(regs, ti_work);
+static unsigned long exit_to_user_mode_loop(struct pt_regs *regs)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	/*
+	 * Before returning to user space ensure that all pending work
+	 * items have been completed.
+	 */
+	while (1) {
+		/* Both interrupts and preemption could be enabled here. */
+		if (exit_to_user_mode_work_pending(ti_work))
+			exit_to_user_mode_work(regs, ti_work);
+
+		/* Interrupts may be reenabled with preemption disabled. */
+		sched_core_unsafe_exit_wait(EXIT_TO_USER_MODE_WORK);
 
 		/*
-		 * Disable interrupts and reevaluate the work flags as they
-		 * might have changed while interrupts and preemption was
-		 * enabled above.
+		 * Reevaluate the work flags as they might have changed
+		 * while interrupts and preemption were enabled.
 		 */
-		local_irq_disable_exit_to_user();
 		ti_work = READ_ONCE(current_thread_info()->flags);
+
+		/*
+		 * We may be switching out to another task in kernel mode. That
+		 * process is responsible for exiting the "unsafe" kernel mode
+		 * when it returns to user or guest.
+		 */
+		if (exit_to_user_mode_work_pending(ti_work))
+			sched_core_unsafe_enter();
+		else
+			break;
 	}
 
-	/* Return the latest work state for arch_exit_to_user_mode() */
 	return ti_work;
 }
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work;
 
 	lockdep_assert_irqs_disabled();
 
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
+	ti_work = exit_to_user_mode_loop(regs);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab6357223b32..ff13254ed317 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4352,6 +4352,210 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
+/*
+ * Handler to attempt to enter kernel. It does nothing because the exit to
+ * usermode or guest mode will do the actual work (of waiting if needed).
+ */
+static void sched_core_irq_work(struct irq_work *work)
+{
+	return;
+}
+
+/*
+ * sched_core_wait_till_safe - Pause the caller's hyperthread until the core
+ * exits the core-wide unsafe state. Obviously the CPU calling this function
+ * should not be responsible for the core being in the core-wide unsafe state
+ * otherwise it will deadlock.
+ *
+ * @ti_check: We spin here with IRQ enabled and preempt disabled. Break out of
+ *            the loop if TIF flags are set and notify caller about it.
+ *
+ * IRQs should be disabled.
+ */
+void sched_core_wait_till_safe(unsigned long ti_check)
+{
+	bool restart = false;
+	struct rq *rq;
+	int cpu;
+
+	/* Only untrusted tasks need to do any waiting. */
+	if (!test_tsk_thread_flag(current, TIF_UNSAFE_RET) || WARN_ON_ONCE(!current->core_cookie))
+		goto ret;
+
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+
+	if (!sched_core_enabled(rq))
+		goto ret;
+
+	/* Down grade to allow interrupts. */
+	preempt_disable();
+	local_irq_enable();
+
+	/*
+	 * Wait till the core of this HT is not in an unsafe state.
+	 *
+	 * Pair with smp_store_release() in sched_core_unsafe_exit().
+	 */
+	while (smp_load_acquire(&rq->core->core_unsafe_nest) > 0) {
+		cpu_relax();
+		if (READ_ONCE(current_thread_info()->flags) & ti_check) {
+			restart = true;
+			break;
+		}
+	}
+
+	/* Upgrade it back to the expectations of entry code. */
+	local_irq_disable();
+	preempt_enable();
+
+ret:
+	if (!restart)
+		clear_tsk_thread_flag(current, TIF_UNSAFE_RET);
+
+	return;
+}
+
+/*
+ * Enter the core-wide IRQ state. Sibling will be paused if it is running
+ * 'untrusted' code, until sched_core_unsafe_exit() is called. Every attempt to
+ * avoid sending useless IPIs is made. Must be called only from hard IRQ
+ * context.
+ */
+void sched_core_unsafe_enter(void)
+{
+	const struct cpumask *smt_mask;
+	unsigned long flags;
+	struct rq *rq;
+	int i, cpu;
+
+	/* Ensure that on return to user/guest, we check whether to wait. */
+	if (current->core_cookie)
+		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+	if (!sched_core_enabled(rq))
+		goto ret;
+
+	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
+	rq->core_this_unsafe_nest++;
+
+	/* Should not nest: enter() should only pair with exit(). */
+	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
+		goto ret;
+
+	raw_spin_lock(rq_lockp(rq));
+	smt_mask = cpu_smt_mask(cpu);
+
+	/* Contribute this CPU's unsafe_enter() to core-wide unsafe_enter() count. */
+	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
+
+	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
+		goto unlock;
+
+	if (irq_work_pending(&rq->core_irq_work)) {
+		/*
+		 * Do nothing more since we are in an IPI sent from another
+		 * sibling to enforce safety. That sibling would have sent IPIs
+		 * to all of the HTs.
+		 */
+		goto unlock;
+	}
+
+	/*
+	 * If we are not the first ones on the core to enter core-wide unsafe
+	 * state, do nothing.
+	 */
+	if (rq->core->core_unsafe_nest > 1)
+		goto unlock;
+
+	/* Do nothing more if the core is not tagged. */
+	if (!rq->core->core_cookie)
+		goto unlock;
+
+	for_each_cpu(i, smt_mask) {
+		struct rq *srq = cpu_rq(i);
+
+		if (i == cpu || cpu_is_offline(i))
+			continue;
+
+		if (!srq->curr->mm || is_idle_task(srq->curr))
+			continue;
+
+		/* Skip if HT is not running a tagged task. */
+		if (!srq->curr->core_cookie && !srq->core_pick)
+			continue;
+
+		/*
+		 * Force sibling into the kernel by IPI. If work was already
+		 * pending, no new IPIs are sent. This is Ok since the receiver
+		 * would already be in the kernel, or on its way to it.
+		 */
+		irq_work_queue_on(&srq->core_irq_work, i);
+	}
+unlock:
+	raw_spin_unlock(rq_lockp(rq));
+ret:
+	local_irq_restore(flags);
+}
+
+/*
+ * Process any work need for either exiting the core-wide unsafe state, or for
+ * waiting on this hyperthread if the core is still in this state.
+ *
+ * @idle: Are we called from the idle loop?
+ */
+void sched_core_unsafe_exit(void)
+{
+	unsigned long flags;
+	unsigned int nest;
+	struct rq *rq;
+	int cpu;
+
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+
+	/* Do nothing if core-sched disabled. */
+	if (!sched_core_enabled(rq))
+		goto ret;
+
+	/*
+	 * Can happen when a process is forked and the first return to user
+	 * mode is a syscall exit. Either way, there's nothing to do.
+	 */
+	if (rq->core_this_unsafe_nest == 0)
+		goto ret;
+
+	rq->core_this_unsafe_nest--;
+
+	/* enter() should be paired with exit() only. */
+	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 0))
+		goto ret;
+
+	raw_spin_lock(rq_lockp(rq));
+	/*
+	 * Core-wide nesting counter can never be 0 because we are
+	 * still in it on this CPU.
+	 */
+	nest = rq->core->core_unsafe_nest;
+	WARN_ON_ONCE(!nest);
+
+	/* Pair with smp_load_acquire() in sched_core_wait_till_safe(). */
+	smp_store_release(&rq->core->core_unsafe_nest, nest - 1);
+	raw_spin_unlock(rq_lockp(rq));
+ret:
+	local_irq_restore(flags);
+}
+
+void sched_core_unsafe_exit_wait(unsigned long ti_check)
+{
+	sched_core_unsafe_exit();
+	sched_core_wait_till_safe(ti_check);
+}
+
 // XXX fairness/fwd progress conditions
 /*
  * Returns
@@ -7295,6 +7499,7 @@ int sched_cpu_starting(unsigned int cpu)
 		rq = cpu_rq(i);
 		if (rq->core && rq->core == rq)
 			core_rq = rq;
+		init_irq_work(&rq->core_irq_work, sched_core_irq_work);
 	}
 
 	if (!core_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1901d11a6f41..2922e171a1f0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1040,11 +1040,14 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 	unsigned char		core_forceidle;
+	struct irq_work		core_irq_work; /* To force HT into kernel */
+	unsigned int		core_this_unsafe_nest;
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned int		core_unsafe_nest;
 #endif
 };
 
-- 
2.28.0.220.ged08abb693-goog

