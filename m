Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F882CEC90
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgLDK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:56:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgLDK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:56:02 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607079320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sbibtqXkXNRCHKrQ+gLnAAGmMtFsu+qZqRnLb4/ON80=;
        b=PqfC65gSUjj3x1T6zER8W3YtRcTVqgV2a7QsYP9XOlqARZ3QmIM3/0uhIFD8f2U8XVVRQ8
        wCJ6MXgcIjS1Mtry6WTtC8485We0rLJObR6uqLkjCsPbfkTqmVnXN0Iv9vouPGwUFj7N6t
        ePMSyPzmonGMD/eVLpb9UE7pt4khaHYsIc1I8kZpTACfDFiU96Pl/KTf84o3mdeDJnbjKA
        MwfiwjRwymEmgsq79nMPX8Zbi02FbwKIoCOQ7ym95KparbQSWjEF4lY6o6onIg54bxxsAC
        l1hfZubKbjPSxg6QGbTmslxEsp+aNxovo5JLUo9XNhaOHIgfzXiV8ZizgE8X9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607079320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sbibtqXkXNRCHKrQ+gLnAAGmMtFsu+qZqRnLb4/ON80=;
        b=a5rL7z+wNkFTx7V5GyjRyUR92VxA7NmJolGc395ogBeLrVNtGm1OJnMRZx1qYSeDRwi2wK
        FFmMWZ/tpsyG8XAg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: tick/sched: Make jiffies update quick check more robust
Date:   Fri, 04 Dec 2020 11:55:19 +0100
Message-ID: <87czzpc02w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quick check in tick_do_update_jiffies64() whether jiffies need to be
updated is not really correct under all circumstances and on all
architectures, especially not on 32bit systems.

The quick check does:

    if (now < READ_ONCE(tick_next_period))
    	return;

and the counterpart in the update is:

    WRITE_ONCE(tick_next_period, next_update_time);

This has two problems:

  1) On weakly ordered architectures there is no guarantee that the stores
     before the WRITE_ONCE() are visible which means that other CPUs can
     operate on a stale jiffies value.

  2) On 32bit the store of tick_next_period which is an u64 is split into
     two 32bit stores. If the first 32bit store advances tick_next_period
     far out and the second 32bit store is delayed (virt, NMI ...) then
     jiffies will become stale until the second 32bit store happens.

Address this by seperating the handling for 32bit and 64bit.

On 64bit problem #1 is addressed by replacing READ_ONCE() / WRITE_ONCE()
with smp_load_acquire() / smp_store_release().

On 32bit problem #2 is addressed by protecting the quick check with the
jiffies sequence counter. The load and stores can be plain because the
sequence count mechanics provides the required barriers already.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Applies on tip timers/core
---
 kernel/time/tick-sched.c |   74 +++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 27 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -57,36 +57,42 @@ static ktime_t last_jiffies_update;
 static void tick_do_update_jiffies64(ktime_t now)
 {
 	unsigned long ticks = 1;
-	ktime_t delta;
+	ktime_t delta, nextp;
 
 	/*
-	 * Do a quick check without holding jiffies_lock. The READ_ONCE()
+	 * 64bit can do a quick check without holding jiffies lock and
+	 * without looking at the sequence count. The smp_load_acquire()
 	 * pairs with the update done later in this function.
 	 *
-	 * This is also an intentional data race which is even safe on
-	 * 32bit in theory. If there is a concurrent update then the check
-	 * might give a random answer. It does not matter because if it
-	 * returns then the concurrent update is already taking care, if it
-	 * falls through then it will pointlessly contend on jiffies_lock.
-	 *
-	 * Though there is one nasty case on 32bit due to store tearing of
-	 * the 64bit value. If the first 32bit store makes the quick check
-	 * return on all other CPUs and the writing CPU context gets
-	 * delayed to complete the second store (scheduled out on virt)
-	 * then jiffies can become stale for up to ~2^32 nanoseconds
-	 * without noticing. After that point all CPUs will wait for
-	 * jiffies lock.
-	 *
-	 * OTOH, this is not any different than the situation with NOHZ=off
-	 * where one CPU is responsible for updating jiffies and
-	 * timekeeping. If that CPU goes out for lunch then all other CPUs
-	 * will operate on stale jiffies until it decides to come back.
+	 * 32bit cannot do that because the store of tick_next_period
+	 * consists of two 32bit stores and the first store could move it
+	 * to a random point in the future.
 	 */
-	if (ktime_before(now, READ_ONCE(tick_next_period)))
-		return;
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
+			return;
+	} else {
+		unsigned int seq;
+
+		/*
+		 * Avoid contention on jiffies_lock and protect the quick
+		 * check with the sequence count.
+		 */
+		do {
+			seq = read_seqcount_begin(&jiffies_seq);
+			nextp = tick_next_period;
+		} while (read_seqcount_retry(&jiffies_seq, seq));
+
+		if (ktime_before(now, nextp))
+			return;
+	}
 
-	/* Reevaluate with jiffies_lock held */
+	/* Quick check failed, i.e. update is required. */
 	raw_spin_lock(&jiffies_lock);
+	/*
+	 * Reevaluate with the lock held. Another CPU might have done the
+	 * update already.
+	 */
 	if (ktime_before(now, tick_next_period)) {
 		raw_spin_unlock(&jiffies_lock);
 		return;
@@ -112,11 +118,25 @@ static void tick_do_update_jiffies64(kti
 	jiffies_64 += ticks;
 
 	/*
-	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
-	 * pairs with the READ_ONCE() in the lockless quick check above.
+	 * Keep the tick_next_period variable up to date.
 	 */
-	WRITE_ONCE(tick_next_period,
-		   ktime_add_ns(last_jiffies_update, TICK_NSEC));
+	nextp = ktime_add_ns(last_jiffies_update, TICK_NSEC);
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/*
+		 * Pairs with smp_load_acquire() in the lockless quick
+		 * check above and ensures that the update to jiffies_64 is
+		 * not reordered vs. the store to tick_next_period, neither
+		 * by the compiler nor by the CPU.
+		 */
+		smp_store_release(&tick_next_period, nextp);
+	} else {
+		/*
+		 * A plain store is good enough on 32bit as the quick check
+		 * above is protected by the sequence count.
+		 */
+		tick_next_period = nextp;
+	}
 
 	/*
 	 * Release the sequence count. calc_global_load() below is not
