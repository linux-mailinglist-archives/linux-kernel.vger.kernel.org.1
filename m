Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296522D60D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403891AbgLJQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:02:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392139AbgLJQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:01:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmK238tVmSIAAelMtwRuUoLDP5K+wDsMup1QF3f2fW4=;
        b=cp7KQ6LWSPCo7lf/ClHTlwrNheFg+3sVkro8g4oj47B+heHuHx7QwAnahMOetehPvtH4/X
        T/X6sX2GQNe3UIpSy9vVWAARr6TDkBpOujCz/3DPHVckN77+I7cnUPve9G/LwQvnX/+AQE
        N2nrSPrOmi+6OhUhAOJRvhQdT6hHSUc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03979AF1E;
        Thu, 10 Dec 2020 16:00:58 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 3/7] watchdog/softlockup: Report the overall time of softlockups
Date:   Thu, 10 Dec 2020 17:00:34 +0100
Message-Id: <20201210160038.31441-4-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softlockup detector currently shows the time spent since the last
report. As a result it is not clear whether a CPU is infinitely hogged
by a single task or if it is a repeated event.

The situation can be simulated with a simply busy loop:

	while (true)
	      cpu_relax();

The softlockup detector produces:

[  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]

But it should be, something like:

[  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
[  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
[  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
[  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]

For the better output, add an additional timestamp of the last report.
Only this timestamp is reset when the watchdog is intentionally
touched from slow code paths or when printing the report.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7776d53a015c..6259590d6474 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -154,7 +154,11 @@ static void lockup_detector_update_enable(void)
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
-#define SOFTLOCKUP_RESET	ULONG_MAX
+/*
+ * Delay the soflockup report when running a known slow code.
+ * It does _not_ affect the timestamp of the last successdul reschedule.
+ */
+#define SOFTLOCKUP_DELAY_REPORT	ULONG_MAX
 
 #ifdef CONFIG_SMP
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
@@ -169,7 +173,10 @@ unsigned int __read_mostly softlockup_panic =
 static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
 
+/* Timestamp taken after the last successful reschedule. */
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
+/* Timestamp of the last softlockup report. */
+static DEFINE_PER_CPU(unsigned long, watchdog_report_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
@@ -235,10 +242,16 @@ static void set_sample_period(void)
 	watchdog_update_hrtimer_threshold(sample_period);
 }
 
+static void update_report_ts(void)
+{
+	__this_cpu_write(watchdog_report_ts, get_timestamp());
+}
+
 /* Commands for resetting the watchdog */
 static void update_touch_ts(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	update_report_ts();
 }
 
 /**
@@ -252,10 +265,10 @@ static void update_touch_ts(void)
 notrace void touch_softlockup_watchdog_sched(void)
 {
 	/*
-	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
-	 * gets zeroed here, so use the raw_ operation.
+	 * Preemption can be enabled.  It doesn't matter which CPU's watchdog
+	 * report period gets restarted here, so use the raw_ operation.
 	 */
-	raw_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
+	raw_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
 }
 
 notrace void touch_softlockup_watchdog(void)
@@ -279,23 +292,23 @@ void touch_all_softlockup_watchdogs(void)
 	 * the softlockup check.
 	 */
 	for_each_cpu(cpu, &watchdog_allowed_mask)
-		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
+		per_cpu(watchdog_report_ts, cpu) = SOFTLOCKUP_DELAY_REPORT;
 	wq_watchdog_touch(-1);
 }
 
 void touch_softlockup_watchdog_sync(void)
 {
 	__this_cpu_write(softlockup_touch_sync, true);
-	__this_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
+	__this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
 }
 
-static int is_softlockup(unsigned long touch_ts)
+static int is_softlockup(unsigned long touch_ts, unsigned long period_ts)
 {
 	unsigned long now = get_timestamp();
 
 	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
 		/* Warn about unreasonable delays. */
-		if (time_after(now, touch_ts + get_softlockup_thresh()))
+		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
 	}
 	return 0;
@@ -341,6 +354,7 @@ static int softlockup_fn(void *data)
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
+	unsigned long period_ts = __this_cpu_read(watchdog_report_ts);
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
@@ -362,7 +376,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	if (touch_ts == SOFTLOCKUP_RESET) {
+	/* Reset the interval when touched externally by a known slow code. */
+	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
 			 * If the time stamp was touched atomically
@@ -374,7 +389,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		/* Clear the guest paused flag on watchdog reset */
 		kvm_check_and_clear_guest_paused();
-		update_touch_ts();
+		update_report_ts();
+
 		return HRTIMER_RESTART;
 	}
 
@@ -384,7 +400,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 * indicate it is getting cpu time.  If it hasn't then
 	 * this is a good indication some task is hogging the cpu
 	 */
-	duration = is_softlockup(touch_ts);
+	duration = is_softlockup(touch_ts, period_ts);
 	if (unlikely(duration)) {
 		/*
 		 * If a virtual machine is stopped by the host it can look to
@@ -410,7 +426,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		/* Start period for the next softlockup warning. */
-		update_touch_ts();
+		update_report_ts();
 
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
-- 
2.26.2

