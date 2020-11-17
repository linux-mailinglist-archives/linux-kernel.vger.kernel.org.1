Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488572B674D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKQOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgKQOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:17 -0500
Message-Id: <20201117132006.337366695@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4bqow+VVZql0fTlpP82IVusdgCkjEvcm+9t7m4BZcuA=;
        b=klMd8XWvI5DXxDBhSTXiNFZJGXlxvaVtNMYer2g/Z9BZcKht68iZzGEivgOl/9hCqGmupd
        nULc24gTWjXwH4KECDoRMnsJUUplF5L82lkDNQqmbM/vI93sNWS2J0kto+hnhNHVac8SLL
        x0smpjW+O/aUA5G2Graq+G15qKhOJrbpBRnCpmQye8Td2PU8nuRpR7X4ZUf9wLFZihNq04
        uoE4JmLf4mYZnylRCJolaXQv3i4GQnlpGZNciOVDexPkKQubLTk9CHiUjrFR4cR30t+uv+
        3CKNvupSf6PBqPQfLZ5fW84co5KiHNt07N9cM8kEIJT5TSS3f+k4Yxq5uZp3NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4bqow+VVZql0fTlpP82IVusdgCkjEvcm+9t7m4BZcuA=;
        b=2b8xwa+G0Jfm6gN8umno7rsETVrTJmFoYxkKfx1/+c31lLxYF6rNi+F2oFpEo9jywv5+Ru
        EC0vAdqTnFWGp2Dg==
Date:   Tue, 17 Nov 2020 14:19:45 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 3/7] tick/sched: Use tick_next_period for lockless quick check
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in doing calculations.

   tick_next_period = last_jiffies_update + tick_period

Just check whether now is before tick_next_period to figure out whether
jiffies need an update.

Add a comment why the intentional data race in the quick check is safe or
not so safe in a 32bit corner case and why we don't worry about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c |   46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -59,11 +59,29 @@ static void tick_do_update_jiffies64(kti
 	ktime_t delta;
 
 	/*
-	 * Do a quick check without holding jiffies_lock:
-	 * The READ_ONCE() pairs with two updates done later in this function.
+	 * Do a quick check without holding jiffies_lock. The READ_ONCE()
+	 * pairs with the update done later in this function.
+	 *
+	 * This is also an intentional data race which is even safe on
+	 * 32bit in theory. If there is a concurrent update then the check
+	 * might give a random answer. It does not matter because if it
+	 * returns then the concurrent update is already taking care, if it
+	 * falls through then it will pointlessly contend on jiffies_lock.
+	 *
+	 * Though there is one nasty case on 32bit due to store tearing of
+	 * the 64bit value. If the first 32bit store makes the quick check
+	 * return on all other CPUs and the writing CPU context gets
+	 * delayed to complete the second store (scheduled out on virt)
+	 * then jiffies can become stale for up to ~2^32 nanoseconds
+	 * without noticing. After that point all CPUs will wait for
+	 * jiffies lock.
+	 *
+	 * OTOH, this is not any different than the situation with NOHZ=off
+	 * where one CPU is responsible for updating jiffies and
+	 * timekeeping. If that CPU goes out for lunch then all other CPUs
+	 * will operate on stale jiffies until it decides to come back.
 	 */
-	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
-	if (delta < tick_period)
+	if (ktime_before(now, READ_ONCE(tick_next_period)))
 		return;
 
 	/* Reevaluate with jiffies_lock held */
@@ -74,9 +92,8 @@ static void tick_do_update_jiffies64(kti
 	if (delta >= tick_period) {
 
 		delta = ktime_sub(delta, tick_period);
-		/* Pairs with the lockless read in this function. */
-		WRITE_ONCE(last_jiffies_update,
-			   ktime_add(last_jiffies_update, tick_period));
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						tick_period);
 
 		/* Slow path for long timeouts */
 		if (unlikely(delta >= tick_period)) {
@@ -84,15 +101,18 @@ static void tick_do_update_jiffies64(kti
 
 			ticks = ktime_divns(delta, incr);
 
-			/* Pairs with the lockless read in this function. */
-			WRITE_ONCE(last_jiffies_update,
-				   ktime_add_ns(last_jiffies_update,
-						incr * ticks));
+			last_jiffies_update = ktime_add_ns(last_jiffies_update,
+							   incr * ticks);
 		}
 		do_timer(++ticks);
 
-		/* Keep the tick_next_period variable up to date */
-		tick_next_period = ktime_add(last_jiffies_update, tick_period);
+		/*
+		 * Keep the tick_next_period variable up to date.
+		 * WRITE_ONCE() pairs with the READ_ONCE() in the lockless
+		 * quick check above.
+		 */
+		WRITE_ONCE(tick_next_period,
+			   ktime_add(last_jiffies_update, tick_period));
 	} else {
 		write_seqcount_end(&jiffies_seq);
 		raw_spin_unlock(&jiffies_lock);

