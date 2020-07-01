Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC4210154
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGABLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 21:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGABKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:49 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9030820780;
        Wed,  1 Jul 2020 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565848;
        bh=N+mVRYojS/sgF3AShn1/nfVqZdHfXdbQ40Gc/VFNccg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBaweMGX+MlYORgKOWNtedK0Onh/3xY654VISkwQWX2lCCTWiwjzzpjVROyvq7SYY
         UB7XCxdbABHhZUdXxNTFubDysvFWDTZe/VTvm7SqeplJcBHxLDXS4z44y+2wPMU3Tt
         0tX4+HbIp4PfWNPBwj32o+UI5F8MQDKHca/wmzEw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 08/10] timer: Spare timer softirq until next expiry
Date:   Wed,  1 Jul 2020 03:10:28 +0200
Message-Id: <20200701011030.14324-9-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core timer infrastructure doesn't depend anymore on
periodic base->clk increments, even when the CPU is not in NO_HZ mode,
we can delay the timer softirqs until we have actual timers to expire.

Some spurious softirqs can still remain since base->next_expiry doesn't
keep track of canceled timers but we are still way ahead of the
unconditional periodic softirqs (~15 times less of them with 1000 Hz
and ~5 times less with 100 Hz).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 49 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 6c021be0e76f..95f51b646447 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1449,10 +1449,10 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
-static int __collect_expired_timers(struct timer_base *base,
-				    struct hlist_head *heads)
+static int collect_expired_timers(struct timer_base *base,
+				  struct hlist_head *heads)
 {
-	unsigned long clk = base->clk;
+	unsigned long clk = base->clk = base->next_expiry;
 	struct hlist_head *vec;
 	int i, levels = 0;
 	unsigned int idx;
@@ -1675,40 +1675,6 @@ void timer_clear_idle(void)
 	 */
 	base->is_idle = false;
 }
-
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
-{
-	unsigned long now = READ_ONCE(jiffies);
-
-	/*
-	 * NOHZ optimization. After a long idle sleep we need to forward the
-	 * base to current jiffies. Avoid a loop by searching the bitfield for
-	 * the next expiring timer.
-	 */
-	if ((long)(now - base->clk) > 2) {
-		/*
-		 * If the next timer is ahead of time forward to current
-		 * jiffies, otherwise forward to the next expiry time:
-		 */
-		if (time_after(base->next_expiry, now)) {
-			/*
-			 * The call site will increment base->clk and then
-			 * terminate the expiry loop immediately.
-			 */
-			base->clk = now;
-			return 0;
-		}
-		base->clk = base->next_expiry;
-	}
-	return __collect_expired_timers(base, heads);
-}
-#else
-static inline int collect_expired_timers(struct timer_base *base,
-					 struct hlist_head *heads)
-{
-	return __collect_expired_timers(base, heads);
-}
 #endif
 
 /*
@@ -1741,7 +1707,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (!time_after_eq(jiffies, base->clk))
+	if (time_before(jiffies, base->next_expiry))
 		return;
 
 	timer_base_lock_expiry(base);
@@ -1754,7 +1720,8 @@ static inline void __run_timers(struct timer_base *base)
 	 */
 	base->must_forward_clk = false;
 
-	while (time_after_eq(jiffies, base->clk)) {
+	while (time_after_eq(jiffies, base->clk) &&
+	       time_after_eq(jiffies, base->next_expiry)) {
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
@@ -1789,12 +1756,12 @@ void run_local_timers(void)
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->clk)) {
+	if (time_before(jiffies, base->next_expiry)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
 			return;
 		/* CPU is awake, so check the deferrable base. */
 		base++;
-		if (time_before(jiffies, base->clk))
+		if (time_before(jiffies, base->next_expiry))
 			return;
 	}
 	raise_softirq(TIMER_SOFTIRQ);
-- 
2.26.2

