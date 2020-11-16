Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3757E2B459C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKPOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgKPOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:14:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF042C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:14:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605536096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msP9dXnS4Ud3LM3uQFCzWHyOMT8T5fNfMvvV7GaX8lw=;
        b=CXWVguS12KemdDwlu/5DbxkwIQLQNppEWj8Cc1gM+gr52vCRRf5sTL7TWGLeuRGd2EpYvd
        oIaGKaQv1+s5dnHJWtnhvPqAj/tCrNLC9B0iPE/MgchgsKWb0mVkoPudEpjXPhLihwCPEg
        igZ3JcqdFsVAAK4KZBHaBdc+Sr64HxnjJOfQzY8EBSogtzBPj0YHCEqhM58WuFRwhmwtCz
        rpqg+PAFGTjv3kSpxCrZ//ZB/QN7Wnnn2cwuG1ivKwTaefAqdWz8I2YjbmNNrMVcOHHHlF
        QPM0O9h5d7vjzfROWJQ/C5hubFAQrHc+dStVy0qrDtByJmVeoAfr8z+MjrJ3Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605536096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msP9dXnS4Ud3LM3uQFCzWHyOMT8T5fNfMvvV7GaX8lw=;
        b=6a+q4dPCCre7DKo5P14wJzTwJeoAXflAV0bs2x4VjTmX3NGMd48IY78Mf5lsos8jmz8WQQ
        qNyZSiS1ZdGQp0DA==
To:     Yunfeng Ye <yeyunfeng@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tick/nohz: Reduce the critical region for jiffies_seq
In-Reply-To: <b08bc867-91db-3fcc-8927-ac94db2327cd@huawei.com>
References: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com> <87h7pq8kyc.fsf@nanos.tec.linutronix.de> <66c172ec-72a1-022a-d387-6c836a698912@huawei.com> <87o8jxzgj7.fsf@nanos.tec.linutronix.de> <b08bc867-91db-3fcc-8927-ac94db2327cd@huawei.com>
Date:   Mon, 16 Nov 2020 15:14:56 +0100
Message-ID: <87eektz8v3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 21:24, Yunfeng Ye wrote:
> On 2020/11/16 19:29, Thomas Gleixner wrote:
>> There are quite some other inefficiencies in that code and the seqcount
>> held time can be reduced way further. Let me stare at it.
>> 
> I think the write seqcount only protecting the last_jiffies_update/jiffies_64/
> tick_next_period is enough. The modification which has not been tested,
> look like this:

Yes, but it can be further simplified. I was doing that before I got
distracted. Uncompiled and untested.

A split up patch series is here: https://tglx.de/~tglx/patches-jiffies.tar

Thanks,

        tglx
---
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -193,7 +193,6 @@ extern int try_to_del_timer_sync(struct
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
 extern void init_timers(void);
-extern void run_local_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1693,29 +1693,6 @@ void timer_clear_idle(void)
 }
 #endif
 
-/*
- * Called from the timer interrupt handler to charge one tick to the current
- * process.  user_tick is 1 if the tick is user time, 0 for system.
- */
-void update_process_times(int user_tick)
-{
-	struct task_struct *p = current;
-
-	PRANDOM_ADD_NOISE(jiffies, user_tick, p, 0);
-
-	/* Note: this timer irq context must be accounted for as well. */
-	account_process_tick(p, user_tick);
-	run_local_timers();
-	rcu_sched_clock_irq(user_tick);
-#ifdef CONFIG_IRQ_WORK
-	if (in_irq())
-		irq_work_tick();
-#endif
-	scheduler_tick();
-	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
-		run_posix_cpu_timers();
-}
-
 /**
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
@@ -1765,7 +1742,7 @@ static __latent_entropy void run_timer_s
 /*
  * Called by the local, per-CPU timer interrupt on SMP.
  */
-void run_local_timers(void)
+static void run_local_timers(void)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
@@ -1783,6 +1760,29 @@ void run_local_timers(void)
 }
 
 /*
+ * Called from the timer interrupt handler to charge one tick to the current
+ * process.  user_tick is 1 if the tick is user time, 0 for system.
+ */
+void update_process_times(int user_tick)
+{
+	struct task_struct *p = current;
+
+	PRANDOM_ADD_NOISE(jiffies, user_tick, p, 0);
+
+	/* Note: this timer irq context must be accounted for as well. */
+	account_process_tick(p, user_tick);
+	run_local_timers();
+	rcu_sched_clock_irq(user_tick);
+#ifdef CONFIG_IRQ_WORK
+	if (in_irq())
+		irq_work_tick();
+#endif
+	scheduler_tick();
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
+		run_posix_cpu_timers();
+}
+
+/*
  * Since schedule_timeout()'s timer is defined on the stack, it must store
  * the target task on the stack as well.
  */
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -877,6 +877,21 @@ static void tick_broadcast_init_next_eve
 	}
 }
 
+static inline ktime_t tick_get_next_period(void)
+{
+	ktime_t next;
+
+	/*
+	 * Protect against concurrent updates (store /load tearing on
+	 * 32bit). It does not matter if the time is already in the
+	 * past. The broadcast device which is about to be programmed will
+	 * fire in any case.
+	 */
+	raw_spin_lock(&jiffies_lock);
+	next = tick_next_period;
+	raw_spin_unlock(&jiffies_lock);
+}
+
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
  */
@@ -905,10 +920,11 @@ static void tick_broadcast_setup_oneshot
 			   tick_broadcast_oneshot_mask, tmpmask);
 
 		if (was_periodic && !cpumask_empty(tmpmask)) {
+			u64 ktime_t = tick_get_next_period();
+
 			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
-			tick_broadcast_init_next_event(tmpmask,
-						       tick_next_period);
-			tick_broadcast_set_event(bc, cpu, tick_next_period);
+			tick_broadcast_init_next_event(tmpmask, nextevt);
+			tick_broadcast_set_event(bc, cpu, nextevt);
 		} else
 			bc->next_event = KTIME_MAX;
 	} else {
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -27,7 +27,9 @@
  */
 DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
 /*
- * Tick next event: keeps track of the tick time
+ * Tick next event: keeps track of the tick time. It's updated by the
+ * CPU which handles the tick and protected by jiffies_lock. There is
+ * no requirement to write hold the jiffies seqcount for it.
  */
 ktime_t tick_next_period;
 ktime_t tick_period;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -44,7 +44,9 @@ struct tick_sched *tick_get_tick_sched(i
 
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
- * The time, when the last jiffy update happened. Protected by jiffies_lock.
+ * The time, when the last jiffy update happened. Write access must hold
+ * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
+ * consistent view of jiffies and last_jiffies_update.
  */
 static ktime_t last_jiffies_update;
 
@@ -53,50 +55,59 @@ static ktime_t last_jiffies_update;
  */
 static void tick_do_update_jiffies64(ktime_t now)
 {
-	unsigned long ticks = 0;
+	unsigned long ticks = 1;
 	ktime_t delta;
 
 	/*
-	 * Do a quick check without holding jiffies_lock:
-	 * The READ_ONCE() pairs with two updates done later in this function.
+	 * Do a quick check without holding jiffies_lock. The READ_ONCE()
+	 * pairs with the update done later in this function.
 	 */
-	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
-	if (delta < tick_period)
+	if (ktime_before(now, READ_ONCE(tick_next_period)))
 		return;
 
 	/* Reevaluate with jiffies_lock held */
 	raw_spin_lock(&jiffies_lock);
+	if (ktime_before(now, tick_next_period)) {
+		raw_spin_unlock(&jiffies_lock);
+		return;
+	}
+
 	write_seqcount_begin(&jiffies_seq);
 
-	delta = ktime_sub(now, last_jiffies_update);
-	if (delta >= tick_period) {
+	delta = ktime_sub(now, tick_next_period);
+	if (unlikely(delta >= tick_period)) {
+		/* Slow path for long idle sleep times */
+		s64 incr = ktime_to_ns(tick_period);
 
-		delta = ktime_sub(delta, tick_period);
-		/* Pairs with the lockless read in this function. */
-		WRITE_ONCE(last_jiffies_update,
-			   ktime_add(last_jiffies_update, tick_period));
-
-		/* Slow path for long timeouts */
-		if (unlikely(delta >= tick_period)) {
-			s64 incr = ktime_to_ns(tick_period);
-
-			ticks = ktime_divns(delta, incr);
-
-			/* Pairs with the lockless read in this function. */
-			WRITE_ONCE(last_jiffies_update,
-				   ktime_add_ns(last_jiffies_update,
-						incr * ticks));
-		}
-		do_timer(++ticks);
+		ticks += ktime_divns(delta, incr);
 
-		/* Keep the tick_next_period variable up to date */
-		tick_next_period = ktime_add(last_jiffies_update, tick_period);
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   incr * ticks);
 	} else {
-		write_seqcount_end(&jiffies_seq);
-		raw_spin_unlock(&jiffies_lock);
-		return;
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						tick_period);
 	}
+
+	/*
+	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
+	 * pairs with the READ_ONCE() in the lockless quick check above. Do
+	 * this here to make the lockless quick check above more efficient.
+	 */
+	WRITE_ONCE(tick_next_period,
+		   ktime_add(last_jiffies_update, tick_period));
+
+	/* Advance jiffies to complete the jiffies_seq protected job */
+	jiffies_64 += ticks;
+
+	/*
+	 * Release the sequence count. calc_global_load() below is not
+	 * protected by it, but jiffies_lock needs to be held to prevent
+	 * concurrent invocations.
+	 */
 	write_seqcount_end(&jiffies_seq);
+
+	calc_global_load();
+
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }

