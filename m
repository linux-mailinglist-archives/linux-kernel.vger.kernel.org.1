Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7CE26D98E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIQKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIQKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EFC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:50 -0700 (PDT)
Message-Id: <20200917101624.205718256@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2PPbf4gqHZ2eAjh7am4Uj1RC1t/6Vw90qRmFfbhEJLU=;
        b=BldLTvZKgPdsSHd50KkD5cKp7FFKMf05aQf14okzFPeO2vjXgoVNBccD7bnDXiauJWPdbH
        Q8tgAM28l1GYJOl7NTr965lKzusNIpdPCILWJJusZIZ0Duc6J9J1At2T/b7pUwHrCCtFtu
        if0o4aiTq0L30IL9+9rHQaHaqadIxXAmJOU2W5322/As1HAbGTHdq/ScddGfAJpbUKfk39
        XtYmMISPssXIuo6k0JAv/5uMjXsFBvhMvYcKWpbT9bLkY15RuKwxqbQ+jRoCdQn/8iBkxI
        oCw/6mqhR4/BQmwxcPp/XSKQH8doFT/mAkFaK79rSk9F4EVlBBx0joCJRuXF+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2PPbf4gqHZ2eAjh7am4Uj1RC1t/6Vw90qRmFfbhEJLU=;
        b=qOeWD/AG+LEdUycYOhdGBren1wLN3re3rRcVJ9vgbXEQjUrwWLb4yd+IKinaZ4Axkijyc+
        iEFoOmzBJqY5BVBw==
Date:   Thu, 17 Sep 2020 11:42:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 03/10] sched/core: Wait for tasks being pushed away on hotplug
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT kernels need to ensure that all tasks which are not per CPU kthreads
have left the outgoing CPU to guarantee that no tasks are force migrated
within a migrate disabled section.

There is also some desire to (ab)use fine grained CPU hotplug control to
clear a CPU from active state to force migrate tasks which are not per CPU
kthreads away for power control purposes.

Add a mechanism which waits until all tasks which should leave the CPU
after the CPU active flag is cleared have moved to a different online CPU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c  |   44 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |    4 ++++
 2 files changed, 45 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6892,11 +6892,24 @@ static bool balance_push(struct rq *rq)
 	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
 	/*
-	 * Both the cpu-hotplug and stop task are in this case and are
+	 * Both the cpu-hotplug and stop task are in this class and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task))
+	if (is_per_cpu_kthread(push_task)) {
+		/*
+		 * If this is the idle task on the outgoing CPU try to wake
+		 * up the hotplug control thread which might wait for the
+		 * last task to vanish. The rcuwait_active() check is
+		 * accurate here because the waiter is pinned on this CPU
+		 * and can't obviously be running in parallel.
+		 */
+		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
+			raw_spin_unlock(&rq->lock);
+			rcuwait_wake_up(&rq->hotplug_wait);
+			raw_spin_lock(&rq->lock);
+		}
 		return false;
+	}
 
 	get_task_struct(push_task);
 	/*
@@ -6929,13 +6942,31 @@ static void balance_push_set(int cpu, bo
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-#else
+/*
+ * Invoked from a CPUs hotplug control thread after the CPU has been marked
+ * inactive. All tasks which are not per CPU kernel threads are either
+ * pushed off this CPU now via balance_push() or placed on a different CPU
+ * during wakeup. Wait until the CPU is quiescent.
+ */
+static void balance_hotplug_wait(void)
+{
+	struct rq *rq = this_rq();
+
+	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+			   TASK_UNINTERRUPTIBLE);
+}
+
+#else /* !CONFIG_HOTPLUG_CPU */
+
+static inline void balance_push_set(int cpu, bool on) { }
 
 static inline bool balance_push(struct rq *rq)
 {
 	return false;
 }
 
+static inline void balance_hotplug_wait(void) { }
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -7090,6 +7121,10 @@ int sched_cpu_deactivate(unsigned int cp
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
+
+	/* Wait for all non per CPU kernel threads to vanish. */
+	balance_hotplug_wait();
+
 	return 0;
 }
 
@@ -7330,6 +7365,9 @@ void __init sched_init(void)
 
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+		rcuwait_init(&rq->hotplug_wait);
+#endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1004,6 +1004,10 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	struct rcuwait		hotplug_wait;
+#endif
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING

