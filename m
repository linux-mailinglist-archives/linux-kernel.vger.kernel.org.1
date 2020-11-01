Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB202A1E63
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKAN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:56:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE82C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 05:56:32 -0800 (PST)
Date:   Sun, 01 Nov 2020 13:56:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604238991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eN8lPK+z1OoJK+FYuEYQUw5chk7YDL3Okne0luc7NVg=;
        b=omt79yy6xG+Ufk8Wla3CSW325LcbbM9lHpJoK6B9j0AKnC6HH4EL4tzpdq8zHaUcXPNlfP
        283qH77QmO9D1yd3zpip5yyZuu7cBDs7ibfiV2NtkMuMD/faL2VNwFCg0pXnl9FBmk0MlG
        PoJQJjRx1eQ3lyz5Sm41ZcnsqAmw8OoaSodrI65m3NI3srpIdTtFP/u0x/vc6EH0YxPKea
        W+1iCnbDb/V0U1wBvL7y8RbEZvY9X+Kbk3EPLKDmsDVhjIn8Gct0Tgrg2/LJW7XADgIeiK
        IfB76FNAvw+cFmztB8xj0/0k35FEuKGt+IvUBzU1lMLcfHWMOQhm84FPS7zD7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604238991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eN8lPK+z1OoJK+FYuEYQUw5chk7YDL3Okne0luc7NVg=;
        b=PGIza34YVBhYWKFRi13y+SiwzVVXmYPwrGBowuOiXFrvIllHIhCnF8LfDexZ5wCpOI/ykY
        LI98s4Srhbbk/YAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.10-rc2
References: <160423896136.5667.9743580255833470691.tglx@nanos>
Message-ID: <160423896377.5667.2321676473760468647.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-11-01

up to:  cb47755725da: time: Prevent undefined behaviour in timespec64_to_ns()


A few fixes for timers/timekeeping:

  - Prevent undefined behaviour in the timespec64_to_ns() conversion which
    is used for converting user supplied time input to nanoseconds. It
    lacked overflow protection.

  - Mark sched_clock_read_begin/retry() to prevent recursion in the tracer

  - Remove unused debug functions in the hrtimer and timerlist code


Thanks,

	tglx

------------------>
Quanyang Wang (1):
      time/sched_clock: Mark sched_clock_read_begin/retry() as notrace

YueHaibing (2):
      hrtimer: Remove unused inline function debug_hrtimer_free()
      timers: Remove unused inline funtion debug_timer_free()

Zeng Tao (1):
      time: Prevent undefined behaviour in timespec64_to_ns()


 include/linux/time64.h    | 4 ++++
 kernel/time/hrtimer.c     | 5 -----
 kernel/time/itimer.c      | 4 ----
 kernel/time/sched_clock.c | 4 ++--
 kernel/time/timer.c       | 5 -----
 5 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index c9dcb3e5781f..5117cb5b5656 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -124,6 +124,10 @@ static inline bool timespec64_valid_settod(const struct timespec64 *ts)
  */
 static inline s64 timespec64_to_ns(const struct timespec64 *ts)
 {
+	/* Prevent multiplication overflow */
+	if ((unsigned long long)ts->tv_sec >= KTIME_SEC_MAX)
+		return KTIME_MAX;
+
 	return ((s64) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3624b9b5835d..387b4bef7dd1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -425,11 +425,6 @@ static inline void debug_hrtimer_deactivate(struct hrtimer *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
 
-static inline void debug_hrtimer_free(struct hrtimer *timer)
-{
-	debug_object_free(timer, &hrtimer_debug_descr);
-}
-
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode);
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index ca4e6d57d68b..00629e658ca1 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -172,10 +172,6 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 	u64 oval, nval, ointerval, ninterval;
 	struct cpu_itimer *it = &tsk->signal->it[clock_id];
 
-	/*
-	 * Use the to_ktime conversion because that clamps the maximum
-	 * value to KTIME_MAX and avoid multiplication overflows.
-	 */
 	nval = timespec64_to_ns(&value->it_value);
 	ninterval = timespec64_to_ns(&value->it_interval);
 
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0642013dace4..b1b9b12899f5 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -68,13 +68,13 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 	return (cyc * mult) >> shift;
 }
 
-struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
+notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
 	*seq = raw_read_seqcount_latch(&cd.seq);
 	return cd.read_data + (*seq & 1);
 }
 
-int sched_clock_read_retry(unsigned int seq)
+notrace int sched_clock_read_retry(unsigned int seq)
 {
 	return read_seqcount_latch_retry(&cd.seq, seq);
 }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index de37e33a868d..c3ad64fb9d8b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -732,11 +732,6 @@ static inline void debug_timer_deactivate(struct timer_list *timer)
 	debug_object_deactivate(timer, &timer_debug_descr);
 }
 
-static inline void debug_timer_free(struct timer_list *timer)
-{
-	debug_object_free(timer, &timer_debug_descr);
-}
-
 static inline void debug_timer_assert_init(struct timer_list *timer)
 {
 	debug_object_assert_init(timer, &timer_debug_descr);

