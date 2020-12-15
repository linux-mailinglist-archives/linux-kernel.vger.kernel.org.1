Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BE2DAB06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgLOKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:44:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLOKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:44:55 -0500
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608029053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pgoOW6vetLZTlQDRtLWHF2JninZ1NXno1JI9btjlhfs=;
        b=tkq3Tq4zZK3q13EpVQws4yMDmMn3HQPQtb4kgDSGNtV0e39g782Qo5aDikc3UL9K0O25l+
        sHnVxmtMIxIA/M/liLIYQv/uQMO/jgBmCyhoh35O/SAqjYXqBYepZTOjgYmzBDrS7orb6n
        VIb0P4Wi8Jbqi4Dr7BLNa6VGEW6v4jQgO/Eb2eScHFkFvtg+/Qh49+kftUs1zW5CZJrX/j
        7u7MSVPnblVWskmlWAQRbRIRVy0cBBouw65Dtou1UDmQeKUr8JDoU0w/BIEWPaCv2PDZSA
        DPQX/nB4ULY5E/GRY3FdyWWxgnZzi7vlF7e3L0MfgSjyuXnrJA3hqRygWcLd6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608029053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pgoOW6vetLZTlQDRtLWHF2JninZ1NXno1JI9btjlhfs=;
        b=kuReXaRjrbu/VfJzFaa5+LMMiqYlANRlDUZiPB9AkbAwPObtzP2X6C1KxIvRCZzbipgE8R
        fvKzkscPrQGGfhCw==
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
Date:   Tue, 15 Dec 2020 11:44:00 +0100
Message-Id: <20201215104400.9435-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_SOFTIRQ is raised to trigger periodic load balancing. When CPU is not
active, CPU should not participate in load balancing.

The scheduler uses nohz.idle_cpus_mask to keep track of the CPUs which can
do idle load balancing. When bringing a CPU up the CPU is added to the mask
when it reaches the active state, but on teardown the CPU stays in the mask
until it goes offline and invokes sched_cpu_dying().

When SCHED_SOFTIRQ is raised on a !active CPU, there might be a pending
softirq when stopping the tick which triggers a warning in NOHZ code. The
SCHED_SOFTIRQ can also be raised by the scheduler tick which has the same
issue.

Therefore remove the CPU from nohz.idle_cpus_mask when it is marked
inactive and also prevent the scheduler_tick() from raising SCHED_SOFTIRQ
after this point.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/sched/core.c | 7 ++++++-
 kernel/sched/fair.c | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 21b548b69455..69284dc121d3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7492,6 +7492,12 @@ int sched_cpu_deactivate(unsigned int cpu)
 	struct rq_flags rf;
 	int ret;
 
+	/*
+	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
+	 * load balancing when not active
+	 */
+	nohz_balance_exit_idle(rq);
+
 	set_cpu_active(cpu, false);
 	/*
 	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU
@@ -7598,7 +7604,6 @@ int sched_cpu_dying(unsigned int cpu)
 
 	calc_load_migrate(rq);
 	update_max_interval();
-	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..fd422b8eb859 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10700,8 +10700,11 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
  */
 void trigger_load_balance(struct rq *rq)
 {
-	/* Don't need to rebalance while attached to NULL domain */
-	if (unlikely(on_null_domain(rq)))
+	/*
+	 * Don't need to rebalance while attached to NULL domain or
+	 * runqueue CPU is not active
+	 */
+	if (unlikely(on_null_domain(rq) || !cpu_active(cpu_of(rq))))
 		return;
 
 	if (time_after_eq(jiffies, rq->next_balance))
-- 
2.20.1

