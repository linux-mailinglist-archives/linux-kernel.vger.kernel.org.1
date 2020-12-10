Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A92D60D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbgLJQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:02:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392110AbgLJQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:01:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ui4kA5u/qkus7PCUEH2ncAwdBScgqUumbWzFYNgaNj4=;
        b=R3J6yv8+Iuq6Ev0KqS4WaNBXcqs/lOrhQv7Af7VAbVyt0HFqiBEga+lIRdCGM8eTbZDbMv
        ZEar8n+u4b8f7K7qV8Lu+VKe+ppk1RpwnEQypOFvZAZ2NtPzHdg28FEMg29JbZd/jM5A+A
        7vVBzdyn8dPo+XpvEQXymqRRbQ1dBQU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 624BFAF0F;
        Thu, 10 Dec 2020 16:00:57 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 1/7] watchdog: Rename __touch_watchdog() to a better descriptive name
Date:   Thu, 10 Dec 2020 17:00:32 +0100
Message-Id: <20201210160038.31441-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many touch_*watchdog() functions. They are called in situations
where the watchdog could report false positives or create unnecessary
noise. For example, when CPU is entering idle mode, a virtual machine
is stopped, or a lot of messages are printed in the atomic context.

These functions set SOFTLOCKUP_RESET instead of a real timestamp. It allows
to call them even in a context where jiffies might be outdated. For example,
in an atomic context.

The real timestamp is set by __touch_watchdog() that is called from
the watchdog timer callback.

Rename this callback to update_touch_ts(). It better describes the effect
and clearly distinguish is from the other touch_*watchdog() functions.

Another motivation is that two timestamps are going to be used. One will
be used for the total softlockup time. The other will be used to measure
time since the last report. The new function name will help to distinguish
which timestamp is being updated.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 71109065bd8e..c58244064de8 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -236,7 +236,7 @@ static void set_sample_period(void)
 }
 
 /* Commands for resetting the watchdog */
-static void __touch_watchdog(void)
+static void update_touch_ts(void)
 {
 	__this_cpu_write(watchdog_touch_ts, get_timestamp());
 }
@@ -331,7 +331,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
  */
 static int softlockup_fn(void *data)
 {
-	__touch_watchdog();
+	update_touch_ts();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
@@ -374,7 +374,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		/* Clear the guest paused flag on watchdog reset */
 		kvm_check_and_clear_guest_paused();
-		__touch_watchdog();
+		update_touch_ts();
 		return HRTIMER_RESTART;
 	}
 
@@ -460,7 +460,7 @@ static void watchdog_enable(unsigned int cpu)
 		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	/* Initialize timestamp */
-	__touch_watchdog();
+	update_touch_ts();
 	/* Enable the perf event */
 	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
 		watchdog_nmi_enable(cpu);
-- 
2.26.2

