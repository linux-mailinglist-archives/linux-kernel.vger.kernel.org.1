Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3721C5938
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgEEOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729237AbgEEOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D012C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKO-0000cz-7G; Tue, 05 May 2020 16:13:44 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A5813FFC8D;
        Tue,  5 May 2020 16:13:43 +0200 (CEST)
Message-Id: <20200505134100.484532537@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:26 +0200
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch V4 part 1 24/36] lockdep: Prepare for noinstr sections
References: <20200505131602.633487962@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

Force inlining and prevent instrumentation of all sorts by marking the
functions which are invoked from low level entry code with 'noinstr'.

Split the irqflags tracking into two parts. One which does the heavy
lifting while RCU is watching and the final one which can be invoked after
RCU is turned off.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqflags.h        |    2 +
 include/linux/sched.h           |    1 
 kernel/locking/lockdep.c        |   70 ++++++++++++++++++++++++++++++----------
 kernel/trace/trace_preemptirq.c |    2 +
 lib/debug_locks.c               |    2 -
 5 files changed, 59 insertions(+), 18 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -19,11 +19,13 @@
 #ifdef CONFIG_PROVE_LOCKING
   extern void lockdep_softirqs_on(unsigned long ip);
   extern void lockdep_softirqs_off(unsigned long ip);
+  extern void lockdep_hardirqs_on_prepare(unsigned long ip);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
 #else
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
+  static inline void lockdep_hardirqs_on_prepare(unsigned long ip) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -983,6 +983,7 @@ struct task_struct {
 	unsigned int			hardirq_disable_event;
 	int				hardirqs_enabled;
 	int				hardirq_context;
+	u64				hardirq_chain_key;
 	unsigned long			softirq_disable_ip;
 	unsigned long			softirq_enable_ip;
 	unsigned int			softirq_disable_event;
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3639,9 +3639,6 @@ static void __trace_hardirqs_on_caller(u
 {
 	struct task_struct *curr = current;
 
-	/* we'll do an OFF -> ON transition: */
-	curr->hardirqs_enabled = 1;
-
 	/*
 	 * We are going to turn hardirqs on, so set the
 	 * usage bit for all held locks:
@@ -3653,16 +3650,13 @@ static void __trace_hardirqs_on_caller(u
 	 * bit for all held locks. (disabled hardirqs prevented
 	 * this bit from being set before)
 	 */
-	if (curr->softirqs_enabled)
+	if (curr->softirqs_enabled) {
 		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
 			return;
-
-	curr->hardirq_enable_ip = ip;
-	curr->hardirq_enable_event = ++curr->irq_events;
-	debug_atomic_inc(hardirqs_on_events);
+	}
 }
 
-void lockdep_hardirqs_on(unsigned long ip)
+void lockdep_hardirqs_on_prepare(unsigned long ip)
 {
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
@@ -3698,20 +3692,62 @@ void lockdep_hardirqs_on(unsigned long i
 	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
 		return;
 
+	current->hardirq_chain_key = current->curr_chain_key;
+
 	current->lockdep_recursion++;
 	__trace_hardirqs_on_caller(ip);
 	lockdep_recursion_finish();
 }
-NOKPROBE_SYMBOL(lockdep_hardirqs_on);
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
+
+void noinstr lockdep_hardirqs_on(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks || curr->lockdep_recursion))
+		return;
+
+	if (curr->hardirqs_enabled) {
+		/*
+		 * Neither irq nor preemption are disabled here
+		 * so this is racy by nature but losing one hit
+		 * in a stat is not a big deal.
+		 */
+		__debug_atomic_inc(redundant_hardirqs_on);
+		return;
+	}
+
+	/*
+	 * We're enabling irqs and according to our state above irqs weren't
+	 * already enabled, yet we find the hardware thinks they are in fact
+	 * enabled.. someone messed up their IRQ state tracing.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return;
+
+	/*
+	 * Ensure the lock stack remained unchanged between
+	 * lockdep_hardirqs_on_prepare() and lockdep_hardirqs_on().
+	 */
+	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
+			    current->curr_chain_key);
+
+	/* we'll do an OFF -> ON transition: */
+	curr->hardirqs_enabled = 1;
+	curr->hardirq_enable_ip = ip;
+	curr->hardirq_enable_event = ++curr->irq_events;
+	debug_atomic_inc(hardirqs_on_events);
+}
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
 
 /*
  * Hardirqs were disabled:
  */
-void lockdep_hardirqs_off(unsigned long ip)
+void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks || curr->lockdep_recursion))
 		return;
 
 	/*
@@ -3732,7 +3768,7 @@ void lockdep_hardirqs_off(unsigned long
 	} else
 		debug_atomic_inc(redundant_hardirqs_off);
 }
-NOKPROBE_SYMBOL(lockdep_hardirqs_off);
+EXPORT_SYMBOL_GPL(lockdep_hardirqs_off);
 
 /*
  * Softirqs will be enabled:
@@ -4408,8 +4444,8 @@ static void print_unlock_imbalance_bug(s
 	dump_stack();
 }
 
-static int match_held_lock(const struct held_lock *hlock,
-					const struct lockdep_map *lock)
+static noinstr int match_held_lock(const struct held_lock *hlock,
+				   const struct lockdep_map *lock)
 {
 	if (hlock->instance == lock)
 		return 1;
@@ -4696,7 +4732,7 @@ static int
 	return 0;
 }
 
-static nokprobe_inline
+static __always_inline
 int __lock_is_held(const struct lockdep_map *lock, int read)
 {
 	struct task_struct *curr = current;
@@ -4956,7 +4992,7 @@ void lock_release(struct lockdep_map *lo
 }
 EXPORT_SYMBOL_GPL(lock_release);
 
-int lock_is_held_type(const struct lockdep_map *lock, int read)
+noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 {
 	unsigned long flags;
 	int ret = 0;
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -46,6 +46,7 @@ void trace_hardirqs_on(void)
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
@@ -93,6 +94,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
 /*
  * Generic 'turn off all lock debugging' function:
  */
-int debug_locks_off(void)
+noinstr int debug_locks_off(void)
 {
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {

