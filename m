Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0981F2EB6F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbhAFAmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbhAFAmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:42:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B070023101;
        Wed,  6 Jan 2021 00:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609893700;
        bh=HiIShzhYvwjPgropxRaTqsT8GUtbHT2q0K5yTdNeXz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhhE7pA2t+aYtQ7vnns16bOmCaJOICd8fdLyXEdjMt9o8XThus1SujbxMmX1F3OtS
         1Z+ww4/7ekCySmXDUWLPRh7xz63RakhSE+0Qve6QN+13I/AkOFPrQowr05ggTvK7HW
         NK01APb5+PVQHBcuEvfgq2J/taMNi4zmMkP9oipDxgW1sIwnpA981XcYbCaxVk88jD
         n74a9NmLFuTfgdDCqtgnaZ560ZWBL3YdR/mqstD+Ffy0OxmwoHBshKHyDJEzCYwMa2
         R7hroeA78OGE9A6BKeAjYsrlMsYmVfBAnK4hQ6BzQ5jAmsl2/NwXW66irbBVzdLaJD
         LeuNvbiSf2/AQ==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH RFC clocksource 5/5] clocksource: Do pairwise clock-desynchronization checking
Date:   Tue,  5 Jan 2021 16:41:34 -0800
Message-Id: <20210106004134.11467-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004013.GA11179@paulmck-ThinkPad-P72>
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although smp_call_function() has the advantage of simplicity, using
it to check for cross-CPU clock desynchronization means that any CPU
being slow reduces the sensitivity of the checking across all CPUs.
And it is not uncommon for smp_call_function() latencies to be in the
hundreds of microseconds.

This commit therefore switches to smp_call_function_single(), so that
delays from a given CPU affect only those measurements involving that
particular CPU.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 67cf41c..31560c6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -214,7 +214,7 @@ static void clocksource_watchdog_inject_delay(void)
 }
 
 static struct clocksource *clocksource_verify_work_cs;
-static DEFINE_PER_CPU(u64, csnow_mid);
+static u64 csnow_mid;
 static cpumask_t cpus_ahead;
 static cpumask_t cpus_behind;
 
@@ -228,7 +228,7 @@ static void clocksource_verify_one_cpu(void *csin)
 		sign = ((smp_processor_id() >> inject_delay_shift_percpu) & 0x1) * 2 - 1;
 		delta = sign * NSEC_PER_SEC;
 	}
-	__this_cpu_write(csnow_mid, cs->read(cs) + delta);
+	csnow_mid = cs->read(cs) + delta;
 }
 
 static void clocksource_verify_percpu_wq(struct work_struct *unused)
@@ -236,9 +236,12 @@ static void clocksource_verify_percpu_wq(struct work_struct *unused)
 	int cpu;
 	struct clocksource *cs;
 	int64_t cs_nsec;
+	int64_t cs_nsec_max;
+	int64_t cs_nsec_min;
 	u64 csnow_begin;
 	u64 csnow_end;
-	u64 delta;
+	s64 delta;
+	bool firsttime = 1;
 
 	cs = smp_load_acquire(&clocksource_verify_work_cs); // pairs with release
 	if (WARN_ON_ONCE(!cs))
@@ -247,19 +250,28 @@ static void clocksource_verify_percpu_wq(struct work_struct *unused)
 		cs->name, smp_processor_id());
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
-	csnow_begin = cs->read(cs);
-	smp_call_function(clocksource_verify_one_cpu, cs, 1);
-	csnow_end = cs->read(cs);
+	preempt_disable();
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
-		delta = (per_cpu(csnow_mid, cpu) - csnow_begin) & cs->mask;
-		if ((s64)delta < 0)
+		csnow_begin = cs->read(cs);
+		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
+		csnow_end = cs->read(cs);
+		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
+		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_behind);
-		delta = (csnow_end - per_cpu(csnow_mid, cpu)) & cs->mask;
-		if ((s64)delta < 0)
+		delta = (csnow_end - csnow_mid) & cs->mask;
+		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
+		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
+		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		if (firsttime || cs_nsec > cs_nsec_max)
+			cs_nsec_max = cs_nsec;
+		if (firsttime || cs_nsec < cs_nsec_min)
+			cs_nsec_min = cs_nsec;
+		firsttime = 0;
 	}
+	preempt_enable();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_ahead),
@@ -268,12 +280,9 @@ static void clocksource_verify_percpu_wq(struct work_struct *unused)
 		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_behind),
 			smp_processor_id(), cs->name);
-	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind)) {
-		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
-		pr_warn("        CPU %d duration %lldns for clocksource %s.\n",
-			smp_processor_id(), cs_nsec, cs->name);
-	}
+	if (!firsttime && (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind)))
+		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
+			smp_processor_id(), cs_nsec_min, cs_nsec_max, cs->name);
 	smp_store_release(&clocksource_verify_work_cs, NULL); // pairs with acquire.
 }
 
-- 
2.9.5

