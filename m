Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C49D2D074D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgLFVV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:21:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60266 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgLFVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:21:55 -0500
Message-Id: <20201206212002.876987748@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607289672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Jmy3TOSqlkN1xwh6VfqwyN/qEI/DOMeobgTI+gZzk5Y=;
        b=DXM+qkw0FvrgyX0F/RQY6SUA2pz0EBrIr3rMcoEw8E/z6KjR8UDEHN5wXjHBozbq3uSnrN
        ciPbK3JBJUlTXt6OwS4Zsk1J8u9ZsDqlcVo23dHBIcNxh4Uv7Gt99TUHKjS19/aTrkrqeV
        +xqVaq5xcEavCCuvl8WuuC+S8Zme8hSaSuNvpf9YpaCIchnU/S9pboSPR26dovQeWpH4uv
        k1xSEcw8MP18q83kY3E7MTeBNDboXRyQUxp7WCEdiqOXVnH7IXcCTfcLgwE9VHaHTHRPc6
        9o+2nk43imLPaE4wsuWEw15aXU1lZQl0PTIOKXzeSSWoWKypCvD7RqMKmRwaaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607289672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Jmy3TOSqlkN1xwh6VfqwyN/qEI/DOMeobgTI+gZzk5Y=;
        b=14v4Ge0Zz2tXyuXSMEGZ8OjlrmPC/xaeveRLqBBOPbOmPtj1H8j2XO77MdcWvk388S9Prp
        ApWTfYJnES77o9Dg==
Date:   Sun, 06 Dec 2020 22:12:56 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
References: <20201206211253.919834182@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_do_timer_cpu is intentionally racy as it would require a global lock
to protect which is a non-starter.

The variable is used to prevent thundering herd problems of many CPUs
trying to update jiffies and timekeeping on the tick. It assigns the duty
of doing so to one CPU. On NOHZ=n systems this stays on the boot CPU
forever and is never updated except when the boot CPU is unplugged. On NOHZ
enabled systems this is quite different because a CPU can give up the
assignment to go for a long idle sleep. The duty is then picked up by
another online CPU on the next tick or interrupt from idle. This handover
is carefully designed so that even competing writes or temporary
assumptions cannot cause havoc.

The mechanism is unfortunately barely documented and not annotated which
triggers KCSAN reports all over the place.

Annotate the racy reads with data_race() and document the various places
which are affected.

Reported-by: syzbot+23a256029191772c2f02@syzkaller.appspotmail.com
Reported-by: syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com
Reported-by: syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-common.c |   45 ++++++++++++++++++++++-
 kernel/time/tick-sched.c  |   89 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 114 insertions(+), 20 deletions(-)

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -45,6 +45,27 @@ ktime_t tick_period;
  *    TICK_DO_TIMER_NONE, i.e. a non existing CPU. So the next cpu which looks
  *    at it will take over and keep the time keeping alive.  The handover
  *    procedure also covers cpu hotplug.
+ *
+ * The variable is neither atomic nor accessed with locks. The handover and
+ * checks are intentionaly racy but safe. The basic rules for the update are:
+ *
+ * All reads and writes happen with interrupts disabled. The execution
+ * context is either task or hard interrupt.
+ *
+ * If tick_do_timer_cpu contains a CPU number then the only possible
+ * transition is that the holding CPU writes it to TICK_DO_TIMER_NONE. This
+ * only happens on NOHZ systems. If NOHZ is off then the duty stays with
+ * the CPU which picked it up, the boot CPU. The only exception is CPU hot
+ * unplug where the outgoing CPU transfers it, but that's safe because all
+ * other CPUs are stuck in stomp_machine().
+ *
+ * If tick_do_timer_cpu contains TICK_DO_TIMER_NONE then any CPU observing
+ * this can overwrite it with it's own CPU number and take on the tick
+ * duty. As this is lockless several CPUs can observe TICK_DO_TIMER_NONE
+ * concurrently and write their own CPU number to it, but at the end only
+ * one will win. Even if one of the writers assumes temporarily that it
+ * owns the duty there is no harm because the tick update is serialized
+ * with jiffies_lock. Other side effects are shorter sleeps for one round.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
 #ifdef CONFIG_NO_HZ_FULL
@@ -83,6 +104,13 @@ int tick_is_oneshot_available(void)
  */
 static void tick_periodic(int cpu)
 {
+	/*
+	 * Raceless access in periodic tick mode. The variable can only
+	 * change when the CPU holding tick_do_timer_cpu goes offline which
+	 * requires that all other CPUs are inside stomp_machine() with
+	 * interrupts disabled and cannot do this read here which is always
+	 * executed from the timer interrupt.
+	 */
 	if (tick_do_timer_cpu == cpu) {
 		raw_spin_lock(&jiffies_lock);
 		write_seqcount_begin(&jiffies_seq);
@@ -185,6 +213,11 @@ static void giveup_do_timer(void *info)
 
 	WARN_ON(tick_do_timer_cpu != smp_processor_id());
 
+	/*
+	 * Exception to the rule that the holding CPU only can
+	 * write TICK_DO_TIMER_NONE. The new CPU is waiting for
+	 * this function call to complete and asked for this.
+	 */
 	tick_do_timer_cpu = cpu;
 }
 
@@ -214,9 +247,14 @@ static void tick_setup_device(struct tic
 	if (!td->evtdev) {
 		/*
 		 * If no cpu took the do_timer update, assign it to
-		 * this cpu:
+		 * this cpu.
+		 *
+		 * Intentional data race. The boot CPU takes it over which
+		 * is obviously not racy. CPUs coming up later cannot
+		 * observe TICK_DO_TIMER_BOOT even if there is a concurrent
+		 * hand over.
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+		if (data_race(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
 			tick_do_timer_cpu = cpu;
 
 			tick_next_period = ktime_get();
@@ -409,6 +447,9 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot
  *
  * Called with interrupts disabled. No locking required. If
  * tick_do_timer_cpu is owned by this cpu, nothing can change it.
+ *
+ * Not a data race because all other CPUs are hanging out in
+ * stomp_machine() and cannot change that assignment.
  */
 void tick_handover_do_timer(void)
 {
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -125,25 +125,40 @@ static void tick_sched_do_timer(struct t
 
 #ifdef CONFIG_NO_HZ_COMMON
 	/*
-	 * Check if the do_timer duty was dropped. We don't care about
-	 * concurrency: This happens only when the CPU in charge went
-	 * into a long sleep. If two CPUs happen to assign themselves to
-	 * this duty, then the jiffies update is still serialized by
-	 * jiffies_lock.
-	 *
-	 * If nohz_full is enabled, this should not happen because the
-	 * tick_do_timer_cpu never relinquishes.
+	 * Check if the do_timer duty was dropped. This is an intentional
+	 * data race and we don't care about concurrency: This happens only
+	 * when the CPU in charge went into a long sleep. If two CPUs
+	 * happen to assign themselves to this duty it does not matter
+	 * which one ends up holding it. Both will try to update jiffies
+	 * but the jiffies update is still serialized by jiffies_lock.
 	 */
-	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
+	if (unlikely(data_race(tick_do_timer_cpu) == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
+		/*
+		 *
+		 * If nohz_full is enabled, this should not happen because
+		 * the tick_do_timer_cpu never relinquishes. Warn and try
+		 * to keep it alive.
+		 */
 		WARN_ON(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu = cpu;
 	}
 #endif
 
-	/* Check, if the jiffies need an update */
-	if (tick_do_timer_cpu == cpu)
+	/*
+	 * Check if jiffies need an update. Intentional data race on NOHZ:
+	 *
+	 * - There is some other CPU holding it
+	 * - This CPU took over above but raced with another CPU. So both
+	 *   invoke tick_do_update_jiffies64() and contend on jiffies lock
+	 *   eventually.
+	 * - The other CPU which holds it is about to give it up which does
+	 *   not cause harm because the current or some other CPU will
+	 *   observe that state either on the next interrupt or when trying
+	 *   to go back to idle and act upon it.
+	 */
+	if (data_race(tick_do_timer_cpu) == cpu)
 		tick_do_update_jiffies64(now);
 
 	if (ts->inidle)
@@ -433,6 +448,9 @@ static int tick_nohz_cpu_down(unsigned i
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
 	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
+	 *
+	 * There is no data race here. If nohz_full is enabled, this can
+	 * not change because the tick_do_timer_cpu never relinquishes.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
 		return -EBUSY;
@@ -687,6 +705,7 @@ static ktime_t tick_nohz_next_event(stru
 	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
+	int duty;
 
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
@@ -751,8 +770,15 @@ static ktime_t tick_nohz_next_event(stru
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
-	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
+	/*
+	 * Intentional data race: If the current CPU holds the do_timer()
+	 * duty then nothing can change it. It's always the holder which
+	 * gives it up.  If it's not held by any CPU then this CPU might be
+	 * the one which held it last. If that is true and another CPU
+	 * takes over in parallel then the only "damage" is a short sleep.
+	 */
+	duty = data_race(tick_do_timer_cpu);
+	if (cpu != duty && (duty != TICK_DO_TIMER_NONE || !ts->do_timer_last))
 		delta = KTIME_MAX;
 
 	/* Calculate the next expiry time */
@@ -773,6 +799,7 @@ static void tick_nohz_stop_tick(struct t
 	u64 basemono = ts->timer_expires_base;
 	u64 expires = ts->timer_expires;
 	ktime_t tick = expires;
+	int duty;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
@@ -784,11 +811,19 @@ static void tick_nohz_stop_tick(struct t
 	 * don't drop this here the jiffies might be stale and
 	 * do_timer() never invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
+	 *
+	 * Another intentional data race: If the current CPU holds the
+	 * do_timer() duty, then no other CPU can change it. If no CPU
+	 * holds it and on read another CPU is taking it on concurrently
+	 * then the only damage is that ts->do_timer_last might not be
+	 * cleared right now which just prevents the CPU from going into
+	 * sleep forever mode for another round.
 	 */
-	if (cpu == tick_do_timer_cpu) {
+	duty = data_race(tick_do_timer_cpu);
+	if (cpu == duty) {
 		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
 		ts->do_timer_last = 1;
-	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
+	} else if (duty != TICK_DO_TIMER_NONE) {
 		ts->do_timer_last = 0;
 	}
 
@@ -906,7 +941,15 @@ static bool can_stop_idle_tick(int cpu,
 	 * invoked.
 	 */
 	if (unlikely(!cpu_online(cpu))) {
-		if (cpu == tick_do_timer_cpu)
+		/*
+		 * If the current CPU holds it then the access is not racy
+		 * as no other CPU can change it. If it does not hold it
+		 * then it's irrelevant whether there is a concurrent
+		 * update which either sets it to TICK_DO_TIMER_NONE or
+		 * takes over from TICK_DO_TIMER_NONE, but no other CPU can
+		 * write the current CPU number into it.
+		 */
+		if (cpu == data_race(tick_do_timer_cpu))
 			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
 		/*
 		 * Make sure the CPU doesn't get fooled by obsolete tick
@@ -935,15 +978,25 @@ static bool can_stop_idle_tick(int cpu,
 	}
 
 	if (tick_nohz_full_enabled()) {
+		int duty;
+
+		/*
+		 * Data race only possible during boot while a nohz_full
+		 * CPU holds the do_timer() duty. So this read might race
+		 * with an upcoming housekeeping CPU taking over. If the
+		 * current CPU holds it then this cannot race.
+		 */
+		duty = data_race(tick_do_timer_cpu);
+
 		/*
 		 * Keep the tick alive to guarantee timekeeping progression
 		 * if there are full dynticks CPUs around
 		 */
-		if (tick_do_timer_cpu == cpu)
+		if (duty == cpu)
 			return false;
 
 		/* Should not happen for nohz-full */
-		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
+		if (WARN_ON_ONCE(duty == TICK_DO_TIMER_NONE))
 			return false;
 	}
 

