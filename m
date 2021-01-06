Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F182EB6F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbhAFAmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbhAFAmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:42:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EDFC22DD3;
        Wed,  6 Jan 2021 00:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609893700;
        bh=FJLYXCWTou8SgL5w7Dj8yWgssa3cuHFxz1RKGI/mBGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oB7ws1T5WkI8VVmpz5xBemkocm8n2m5ETF/7T/uRCHiKPTYnRAFFvroreQs1/LzNS
         //ob8MPuzDDtwbdvnlvwyoUaHbYkk7y+n9t9ETLdek2ONigKcLjuabiVDLYNnx9FOB
         hyIbLkQQpvDcLBWVVaqy4AsdlJmIjIurF6sHRpxNDDNd8OQK2nxSKRv4cn7ze2Xy2s
         0oBYWHnfDsA6dBQVVoNr1k+3sK94tXL0W1Dx5obraPyT718BQj8x8TjvWRzz8WDEYK
         nLSmdwUHX3TRkFm6s1Dd0nJLWbIIWF4wJIaqDQd2RgVKIBqecgQj5O+Jb5pu71CRLN
         O/d/rXg+cbyRg==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH RFC clocksource 2/5] clocksource: Retry clock read if long delays detected
Date:   Tue,  5 Jan 2021 16:41:31 -0800
Message-Id: <20210106004134.11467-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004013.GA11179@paulmck-ThinkPad-P72>
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
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
 kernel/time/clocksource.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a0d9d36..4663b86 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -124,6 +124,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
+#define WATCHDOG_MAX_SKEW (NSEC_PER_SEC >> 6)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -203,7 +204,6 @@ static void clocksource_watchdog_inject_delay(void)
 		injectfail = inject_delay_run;
 	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {
 		printk("%s(): Injecting delay.\n", __func__);
-		injectfail = 0;
 		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC; i++)
 			udelay(1000);
 		printk("%s(): Done injecting delay.\n", __func__);
@@ -214,9 +214,10 @@ static void clocksource_watchdog_inject_delay(void)
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
@@ -225,6 +226,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	reset_pending = atomic_read(&watchdog_reset_pending);
 
 	list_for_each_entry(cs, &watchdog_list, wd_list) {
+		nretries = 0;
 
 		/* Clocksource already marked unstable? */
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
@@ -233,11 +235,23 @@ static void clocksource_watchdog(struct timer_list *unused)
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

