Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94462F2518
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbhALAro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbhALAqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:46:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0141E225AB;
        Tue, 12 Jan 2021 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610412325;
        bh=86/Ys3Y6pJzJbA9cEo2GdAoWkZsI+8QLDHkBP242akE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsLzCT9Yb8yXYwJjt/XQSR6zxY89zNNyH2Gq2WryHtuYDd7Wu1Vq6a4OfNv3OODYa
         e9wRKirnWkLoqIEL8Oe6H4xT7FfLTcHU4P/DGkXRFx3L5oCSVwT+csHgtuI0PcPpJx
         Du5yS2EY95XfhWAStr/0iZcTO+INFSfaFHOCHjK/8U0nOWsTc2DUpBQmBYwQ30RZht
         KoTh6q2JY3zUl9vsvz1T3viQoQQpgOEOdNosxDuE3PXlDTYfJlUIOOpnOm7CsQEQjI
         Lvdjk533K672RQKkReFeQPmGGZYtghekAfrGNcfS/0pTF+DQ8MH2MlDaHrqrhgrkNN
         i2s640dPO58Eg==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 clocksource 2/5] clocksource: Retry clock read if long delays detected
Date:   Mon, 11 Jan 2021 16:45:17 -0800
Message-Id: <20210112004520.24027-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210112004258.GA23158@paulmck-ThinkPad-P72>
References: <20210112004258.GA23158@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When the clocksource watchdog marks a clock as unstable, this might
be due to that clock being unstable or it might be due to delays that
happen to occur between the reads of the two clocks.  Yes, interrupts are
disabled across those two reads, but there are no shortage of things that
can delay interrupts-disabled regions of code ranging from SMI handlers
to vCPU preemption.  It would be good to have some indication as to why
the clock was marked unstable.

This commit therefore re-reads the watchdog clock on either side of
the read from the clock under test.  If the watchdog clock shows an
excessive time delta between its pair of reads, the reads are retried.
The maximum number of retries is specified by a new kernel boot
parameter clocksource.max_read_retries, which defaults to three, that
is, up to four reads, one initial and up to three retries.  If retries
were required, a message is printed on the console.  If the number of
retries is exceeded, the clock under test will be marked unstable.
However, the probability of this happening due to various sorts of
delays is quite small.  In addition, the reason (clock-read delays)
for the unstable marking will be apparent.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Per-clocksource retries per Neeraj Upadhyay feedback. ]
[ paulmck: Don't reset injectfail per Neeraj Upadhyay feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 545889c..4663b86 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -124,6 +124,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
+#define WATCHDOG_MAX_SKEW (NSEC_PER_SEC >> 6)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -213,9 +214,10 @@ static void clocksource_watchdog_inject_delay(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
-	u64 csnow, wdnow, cslast, wdlast, delta;
-	int64_t wd_nsec, cs_nsec;
+	u64 csnow, wdnow, wdagain, cslast, wdlast, delta;
+	int64_t wd_nsec, wdagain_nsec, wderr_nsec = 0, cs_nsec;
 	int next_cpu, reset_pending;
+	int nretries;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -224,6 +226,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	reset_pending = atomic_read(&watchdog_reset_pending);
 
 	list_for_each_entry(cs, &watchdog_list, wd_list) {
+		nretries = 0;
 
 		/* Clocksource already marked unstable? */
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
@@ -232,11 +235,23 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
+retry:
 		local_irq_disable();
-		csnow = cs->read(cs);
-		clocksource_watchdog_inject_delay();
 		wdnow = watchdog->read(watchdog);
+		clocksource_watchdog_inject_delay();
+		csnow = cs->read(cs);
+		wdagain = watchdog->read(watchdog);
 		local_irq_enable();
+		delta = clocksource_delta(wdagain, wdnow, watchdog->mask);
+		wdagain_nsec = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
+		if (wdagain_nsec < 0 || wdagain_nsec > WATCHDOG_MAX_SKEW) {
+			wderr_nsec = wdagain_nsec;
+			if (nretries++ < max_read_retries)
+				goto retry;
+		}
+		if (nretries)
+			pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d\n",
+				smp_processor_id(), watchdog->name, wderr_nsec, nretries);
 
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
-- 
2.9.5

