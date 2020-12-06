Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C971E2D074C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgLFVVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:21:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:21:53 -0500
Message-Id: <20201206212002.725238293@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607289671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=t7MBVP6KYWOxRUlHPQxrH6lEk6drMxmUxnHf4Vx3LVk=;
        b=XAlBQC0V1fBZunLbRhZep83vezX2wLK1JI6QBQw16gXGcjWggJArgi84lndV13eVhKOFI8
        qGjaVbn3diHvEtI5f72j0QlQBhFudYGOFn7CCQh2y0GxbitJxem6SChQSvbnzs5433SOsD
        1tz0QmCntaIHftA42Z2hRjOlXRhs9lwzd5Tn+KQ0GFtz0MqpjkTbKwxxhwXLJCDzy2hasA
        weXb4Y6guOXewhABpyAiC/NVDdF5b/hJc8wZ0aOLO8z7YIH05lU+ErdCqx7C9D8KW9BuG0
        839UQhB1Etsn+V9zBEUWoPovT/oAx4YwMxqrUIFD2v3obYxp84V5Xu+wovlf5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607289671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=t7MBVP6KYWOxRUlHPQxrH6lEk6drMxmUxnHf4Vx3LVk=;
        b=yx6wCVg70vE8115O7OS37G3s1QJDNR0LGAkh/3q/EUUuiIZZS+Tx0ZGVwKnhCeZqwU/TCP
        F/faT1lkZj4W3pAg==
Date:   Sun, 06 Dec 2020 22:12:55 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [patch 2/3] tick/sched: Remove bogus boot "safety" check
References: <20201206211253.919834182@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can_stop_idle_tick() checks whether the do_timer() duty has been taken over
by a CPU on boot. That's silly because the boot CPU always takes over with
the initial clockevent device.

But even if no CPU would have installed a clockevent and taken over the
duty then the question whether the tick on the current CPU can be stopped
or not is moot. In that case the current CPU would have no clockevent
either, so there would be nothing to keep ticking.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c |    7 -------
 1 file changed, 7 deletions(-)
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -941,13 +941,6 @@ static bool can_stop_idle_tick(int cpu,
 		 */
 		if (tick_do_timer_cpu == cpu)
 			return false;
-		/*
-		 * Boot safety: make sure the timekeeping duty has been
-		 * assigned before entering dyntick-idle mode,
-		 * tick_do_timer_cpu is TICK_DO_TIMER_BOOT
-		 */
-		if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_BOOT))
-			return false;
 
 		/* Should not happen for nohz-full */
 		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))

