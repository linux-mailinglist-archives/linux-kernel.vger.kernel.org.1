Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4E2D61FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403902AbgLJQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:03:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:50222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391139AbgLJQCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:02:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm1VpRI0pRdWegL/4GNOSlgDQroovlVKC7NnZ6GivtY=;
        b=fO+c/EN+MaW+rIe9e+8nfgH9DST+GbIkS7UN5qHjPj0MpoRtX9fqkY9oNNfoxb6Ns/gPNw
        IELzhwrj0hpORl/Oln7eZEVaE74vigGb57QIOiooL22stEghpmFvQxGCcK6rBU3RfgSTNN
        x2ulBNelQNinnVo058ENzkhT/kOtIDA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0F65AF22;
        Thu, 10 Dec 2020 16:00:58 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 6/7] watchdog: Cleanup handling of false positives
Date:   Thu, 10 Dec 2020 17:00:37 +0100
Message-Id: <20201210160038.31441-7-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d6ad3e286d2c075 ("softlockup: Add sched_clock_tick() to avoid
kernel warning on kgdb resume") introduced touch_softlockup_watchdog_sync().

It solved a problem when the watchdog was touched in an atomic context,
the timer callback was proceed right after releasing interrupts,
and the local clock has not been updated yet. In this case,
sched_clock_tick() was called in watchdog_timer_fn() before
updating the timer.

So far so good.

Later the commit 5d1c0f4a80a6df73 ("watchdog: add check for suspended vm
in softlockup detector") added two kvm_check_and_clear_guest_paused()
calls. They touch the watchdog when the guest has been sleeping.

The code makes my head spin around.

Scenario 1:

    + guest did sleep:
	+ PVCLOCK_GUEST_STOPPED is set

    + 1st watchdog_timer_fn() invocation:
	+ the watchdog is not touched yet
	+ is_softlockup() returns too big delay
	+ kvm_check_and_clear_guest_paused():
	   + clear PVCLOCK_GUEST_STOPPED
	   + call touch_softlockup_watchdog_sync()
		+ set SOFTLOCKUP_DELAY_REPORT
		+ set softlockup_touch_sync
	+ return from the timer callback

      + 2nd watchdog_timer_fn() invocation:

	+ call sched_clock_tick() even though it is not needed.
	  The timer callback was invoked again only because the clock
	  has already been updated in the meantime.

	+ call kvm_check_and_clear_guest_paused() that does nothing
	  because PVCLOCK_GUEST_STOPPED has been cleared already.

	+ call update_report_ts() and return. This is fine. Except
	  that sched_clock_tick() might allow to set it already
	  during the 1st invocation.

Scenario 2:

	+ guest did sleep

	+ 1st watchdog_timer_fn() invocation
	    + same as in 1st scenario

	+ guest did sleep again:
	    + set PVCLOCK_GUEST_STOPPED again

	+ 2nd watchdog_timer_fn() invocation
	    + SOFTLOCKUP_DELAY_REPORT is set from 1st invocation
	    + call sched_clock_tick()
	    + call kvm_check_and_clear_guest_paused()
		+ clear PVCLOCK_GUEST_STOPPED
		+ call touch_softlockup_watchdog_sync()
		    + set SOFTLOCKUP_DELAY_REPORT
		    + set softlockup_touch_sync
	    + call update_report_ts() (set real timestamp immediately)
	    + return from the timer callback

	+ 3rd watchdog_timer_fn() invocation
	    + timestamp is set from 2nd invocation
	    + softlockup_touch_sync is set but not checked because
	      the real timestamp is already set

Make the code more straightforward:

1. Always call kvm_check_and_clear_guest_paused() at the very
   beginning to handle PVCLOCK_GUEST_STOPPED. It touches the watchdog
   when the quest did sleep.

2. Handle the situation when the watchdog has been touched
   (SOFTLOCKUP_DELAY_REPORT is set).

   Call sched_clock_tick() when touch_*sync() variant was used. It makes
   sure that the timestamp will be up to date even when it has been
   touched in atomic context or quest did sleep.

As a result, kvm_check_and_clear_guest_paused() is called on a single
location. And the right timestamp is always set when returning from
the timer callback.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6dc1f79e36aa..c050323fcd33 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -375,7 +375,14 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
 
-	/* Reset the interval when touched externally by a known slow code. */
+	/*
+	 * If a virtual machine is stopped by the host it can look to
+	 * the watchdog like a soft lockup. Check to see if the host
+	 * stopped the vm before we process the timestamps.
+	 */
+	kvm_check_and_clear_guest_paused();
+
+	/* Reset the interval when touched by known problematic code. */
 	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
 			/*
@@ -386,10 +393,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			sched_clock_tick();
 		}
 
-		/* Clear the guest paused flag on watchdog reset */
-		kvm_check_and_clear_guest_paused();
 		update_report_ts();
-
 		return HRTIMER_RESTART;
 	}
 
@@ -401,14 +405,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 */
 	duration = is_softlockup(touch_ts, period_ts);
 	if (unlikely(duration)) {
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like a soft lockup, check to see if the host
-		 * stopped the vm before we issue the warning
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return HRTIMER_RESTART;
-
 		/*
 		 * Prevent multiple soft-lockup reports if one cpu is already
 		 * engaged in dumping all cpu back traces.
-- 
2.26.2

