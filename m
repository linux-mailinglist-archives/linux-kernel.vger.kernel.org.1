Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517A12F2519
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbhALArp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731212AbhALAqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:46:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF8F0224F9;
        Tue, 12 Jan 2021 00:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610412324;
        bh=K3O6gKFJKcbyDHcwjQn0wZdQng8xLoi5pGlJ16Urynk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0Lg8MU3t0s6t8QSknEjfpxklSwISs5tXoPuPofQTBK1TzdanmZMlnbw9jXu7rk40
         6UEU/OruMvKTH0o5HPnG399RyFw0ZcB0LNLOBVjWgnmdKAtMMcg1ZEY7BnXlIOADpE
         sIqscs9mX8dzy3O+beAetC0p2LZL+6nBGIIE99pLTPPvLG52MYWOwY0I1uoqrlGy0C
         2MmzbNfObzfKPptIQ5ebeY3ju0qmqD/6sDqIlgLN4bZbkbJYRp/k38pcWHaCLogRTr
         eAEaNi8PkcZOpGl6CLeqUyKmub7N4WIJikNqyxOFOOJ6iEZ8yMF0eepboBb+WEG6Qy
         fBk4bdZziDk0Q==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 clocksource 1/5] clocksource: Provide module parameters to inject delays in watchdog
Date:   Mon, 11 Jan 2021 16:45:16 -0800
Message-Id: <20210112004520.24027-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210112004258.GA23158@paulmck-ThinkPad-P72>
References: <20210112004258.GA23158@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When the clocksource watchdog marks a clock as unstable, this might be due
to that clock being unstable or it might be due to delays that happen to
occur between the reads of the two clocks.  Yes, interrupts are disabled
across those two reads, but there are no shortage of things that can
delay interrupts-disabled regions of code ranging from SMI handlers to
vCPU preemption.  It would be good to have some indication as to why
the clock was marked unstable.

The first step is a way of injecting such delays, and this
commit therefore provides a clocksource.inject_delay_freq and
clocksource.inject_delay_run kernel boot parameters that specify that
sufficient delay be injected to cause the clocksource_watchdog()
function to mark a clock unstable.  This delay is injected every
Nth set of M calls to clocksource_watchdog(), where N is the value
specified for the inject_delay_freq boot parameter and M is the value
specified for the inject_delay_run boot parameter.  Values of zero or
less for either parameter disable delay injection, and the default for
clocksource.inject_delay_freq is zero, that is, disabled.  The default for
clocksource.inject_delay_run is the value one, that is single-call runs.

This facility is intended for diagnostic use only, and should be avoided
on production systems.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
[ paulmck: Apply Rik van Riel feedback. ]
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 22 ++++++++++++++++++++
 kernel/time/clocksource.c                       | 27 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e3cdb2..4c59813 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -577,6 +577,28 @@
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.inject_delay_freq= [KNL]
+			Number of runs of calls to clocksource_watchdog()
+			before delays are injected between reads from the
+			two clocksources.  Values less than or equal to
+			zero disable this delay injection.  These delays
+			can cause clocks to be marked unstable, so use
+			of this parameter should therefore be avoided on
+			production systems.  Defaults to zero (disabled).
+
+	clocksource.inject_delay_run= [KNL]
+			Run lengths of clocksource_watchdog() delay
+			injections.  Specifying the value 8 will result
+			in eight consecutive delays followed by eight
+			times the value specified for inject_delay_freq
+			of consecutive non-delays.
+
+	clocksource.max_read_retries= [KNL]
+			Number of clocksource_watchdog() retries due to
+			external delays before the clock will be marked
+			unstable.  Defaults to three retries, that is,
+			four attempts to read the clock under test.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cce484a..545889c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
@@ -184,6 +185,31 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
+static int inject_delay_freq;
+module_param(inject_delay_freq, int, 0644);
+static int inject_delay_run = 1;
+module_param(inject_delay_run, int, 0644);
+static int max_read_retries = 3;
+module_param(max_read_retries, int, 0644);
+
+static void clocksource_watchdog_inject_delay(void)
+{
+	int i;
+	static int injectfail = -1;
+
+	if (inject_delay_freq <= 0 || inject_delay_run <= 0)
+		return;
+	if (injectfail < 0 || injectfail > INT_MAX / 2)
+		injectfail = inject_delay_run;
+	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {
+		printk("%s(): Injecting delay.\n", __func__);
+		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC; i++)
+			udelay(1000);
+		printk("%s(): Done injecting delay.\n", __func__);
+	}
+	WARN_ON_ONCE(injectfail < 0);
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
@@ -208,6 +234,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		local_irq_disable();
 		csnow = cs->read(cs);
+		clocksource_watchdog_inject_delay();
 		wdnow = watchdog->read(watchdog);
 		local_irq_enable();
 
-- 
2.9.5

