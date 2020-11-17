Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B32B6751
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgKQOYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgKQOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:22 -0500
Message-Id: <20201117132006.766643526@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=36AbueCPRviT4pJmIguZZEcFRiUIP+ZE3fekX7M9B1s=;
        b=JQViGrtfMCrpuuz39trLdPQDptUJ4On3D8tV0uvq9xElvQZdMIsJ2HtuRQWOoZ5Ch1MtY/
        RaYMI1SMigQ9k4+hjdp8of2FVaz18WSSAmB+c1Er2INrn4bssDL5hZ1t5NRMeipBGgNWnO
        TNlCj+GNrjd3GRrMqUiTafkss/AybcTl0s31OZTDQp7FHGhAaTWYVed1RBJ3V5aL+3Xei1
        ThgT57DRPbfSXzzC0Dx8H2EsR1o2CtSeYlZtD0HlF29W0gCTOR9IPCLI1gSOUzmwOTtzxn
        FzdrIrgp+vb/02FNCnWE/AhVL89GzkGOyh1jV4JdUdcSMRA6R/V/7WOnf4T1Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=36AbueCPRviT4pJmIguZZEcFRiUIP+ZE3fekX7M9B1s=;
        b=bK6hgoV9t+X637a4dlPtQEXrTaoAR2Sl2H9tGAVuDb9u+ULlgvKhfe0AAs8UGzKJnZC83R
        NIZygVTNTS5GuwDA==
Date:   Tue, 17 Nov 2020 14:19:49 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 7/7] tick: Get rid of tick_period
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable tick_period is initialized to NSEC_PER_TICK / HZ during boot
and never updated again.

If NSEC_PER_TICK is not an integer multiple of HZ this computation is less
accurate than TICK_NSEC which has proper rounding in place.

Aside of the inaccuracy there is no reason for having this variable at
all. It's just a pointless indirection and all usage sites can just use the
TICK_NSEC constant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-broadcast.c |    2 +-
 kernel/time/tick-common.c    |    8 +++-----
 kernel/time/tick-internal.h  |    1 -
 kernel/time/tick-sched.c     |   22 +++++++++++-----------
 4 files changed, 15 insertions(+), 18 deletions(-)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -331,7 +331,7 @@ static void tick_handle_periodic_broadca
 	bc_local = tick_do_periodic_broadcast();
 
 	if (clockevent_state_oneshot(dev)) {
-		ktime_t next = ktime_add(dev->next_event, tick_period);
+		ktime_t next = ktime_add_ns(dev->next_event, TICK_NSEC);
 
 		clockevents_program_event(dev, next, true);
 	}
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -32,7 +32,6 @@ DEFINE_PER_CPU(struct tick_device, tick_
  * no requirement to write hold the jiffies seqcount for it.
  */
 ktime_t tick_next_period;
-ktime_t tick_period;
 
 /*
  * tick_do_timer_cpu is a timer core internal variable which holds the CPU NR
@@ -90,7 +89,7 @@ static void tick_periodic(int cpu)
 		write_seqcount_begin(&jiffies_seq);
 
 		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
+		tick_next_period = ktime_add_ns(tick_next_period, TICK_NSEC);
 
 		do_timer(1);
 		write_seqcount_end(&jiffies_seq);
@@ -129,7 +128,7 @@ void tick_handle_periodic(struct clock_e
 		 * Setup the next period for devices, which do not have
 		 * periodic mode:
 		 */
-		next = ktime_add(next, tick_period);
+		next = ktime_add_ns(next, TICK_NSEC);
 
 		if (!clockevents_program_event(dev, next, false))
 			return;
@@ -175,7 +174,7 @@ void tick_setup_periodic(struct clock_ev
 		for (;;) {
 			if (!clockevents_program_event(dev, next, false))
 				return;
-			next = ktime_add(next, tick_period);
+			next = ktime_add_ns(next, TICK_NSEC);
 		}
 	}
 }
@@ -222,7 +221,6 @@ static void tick_setup_device(struct tic
 			tick_do_timer_cpu = cpu;
 
 			tick_next_period = ktime_get();
-			tick_period = NSEC_PER_SEC / HZ;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -15,7 +15,6 @@
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
-extern ktime_t tick_period;
 extern int tick_do_timer_cpu __read_mostly;
 
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -95,17 +95,17 @@ static void tick_do_update_jiffies64(kti
 	write_seqcount_begin(&jiffies_seq);
 
 	delta = ktime_sub(now, tick_next_period);
-	if (unlikely(delta >= tick_period)) {
+	if (unlikely(delta >= TICK_NSEC)) {
 		/* Slow path for long idle sleep times */
-		s64 incr = ktime_to_ns(tick_period);
+		s64 incr = TICK_NSEC;
 
 		ticks += ktime_divns(delta, incr);
 
 		last_jiffies_update = ktime_add_ns(last_jiffies_update,
 						   incr * ticks);
 	} else {
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   TICK_NSEC);
 	}
 
 	/* Advance jiffies to complete the jiffies_seq protected job */
@@ -116,7 +116,7 @@ static void tick_do_update_jiffies64(kti
 	 * pairs with the READ_ONCE() in the lockless quick check above.
 	 */
 	WRITE_ONCE(tick_next_period,
-		   ktime_add(last_jiffies_update, tick_period));
+		   ktime_add_ns(last_jiffies_update, TICK_NSEC));
 
 	/*
 	 * Release the sequence count. calc_global_load() below is not
@@ -691,7 +691,7 @@ static void tick_nohz_restart(struct tic
 	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
 	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
 		hrtimer_start_expires(&ts->sched_timer,
@@ -1260,7 +1260,7 @@ static void tick_nohz_handler(struct clo
 	if (unlikely(ts->tick_stopped))
 		return;
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
@@ -1297,7 +1297,7 @@ static void tick_nohz_switch_to_nohz(voi
 	next = tick_init_jiffy_update();
 
 	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, tick_period);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
 }
@@ -1363,7 +1363,7 @@ static enum hrtimer_restart tick_sched_t
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
 
-	hrtimer_forward(timer, now, tick_period);
+	hrtimer_forward(timer, now, TICK_NSEC);
 
 	return HRTIMER_RESTART;
 }
@@ -1397,13 +1397,13 @@ void tick_setup_sched_timer(void)
 
 	/* Offset the tick to avert jiffies_lock contention. */
 	if (sched_skew_tick) {
-		u64 offset = ktime_to_ns(tick_period) >> 1;
+		u64 offset = TICK_NSEC >> 1;
 		do_div(offset, num_possible_cpus());
 		offset *= smp_processor_id();
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }

