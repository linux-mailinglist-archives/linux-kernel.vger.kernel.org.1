Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE2283918
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgJEPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgJEPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:10:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDBC0613AD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lBR13pn+A+wuQ7f3n6B6sZ7w6IYzLnDV0iovL3FM7hw=; b=nEbkr3NOF3jahI7L3QCrzUI08y
        p433O9d7kWkKE4C0505UvKnSiZi3yrQ9eNa7T+p3wR26qjDz2BiCO4Dia4cnHhZOFdIyOvZMJegtR
        WNW24/QRgWpdmgzOHWDlhz93netrARukHYbQYJTarCoQ1RoyR4pGWkf97p2eafqmypmODQNWbR9xH
        FQG8rm+fvg2GIKrSvCdMAfd1nsrPiuj83n67s8JQcAxr+3IHGI/LbWRN/ztRyZDHhzJ1BT8MyiMg9
        n91vaaOVZOSkYnEjK4E6jLbfH+YBxhD5KT4J+mXQDZtTGgGp05y8dS+OoqhcXnsXY57FI1Q6kZG9n
        czWbJa8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7V-0000LO-KA; Mon, 05 Oct 2020 15:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F72C307691;
        Mon,  5 Oct 2020 17:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E653529A897BC; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005150922.057639274@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 11/17] sched/core: Make migrate disable and CPU hotplug cooperative
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On CPU unplug tasks which are in a migrate disabled region cannot be pushed
to a different CPU until they returned to migrateable state.

Account the number of tasks on a runqueue which are in a migrate disabled
section and make the hotplug wait mechanism respect that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   36 ++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |    4 ++++
 2 files changed, 34 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1725,10 +1725,17 @@ static void migrate_disable_switch(struc
 
 void migrate_disable(void)
 {
-	if (current->migration_disabled++)
+	struct task_struct *p = current;
+
+	if (p->migration_disabled) {
+		p->migration_disabled++;
 		return;
+	}
 
-	barrier();
+	preempt_disable();
+	this_rq()->nr_pinned++;
+	p->migration_disabled = 1;
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -1755,6 +1762,7 @@ void migrate_enable(void)
 	 */
 	barrier();
 	p->migration_disabled = 0;
+	this_rq()->nr_pinned--;
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
@@ -1764,6 +1772,11 @@ static inline bool is_migration_disabled
 	return p->migration_disabled;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return rq->nr_pinned;
+}
+
 #endif
 
 /*
@@ -2634,6 +2647,11 @@ static inline bool is_migration_disabled
 	return false;
 }
 
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return false;
+}
+
 #endif
 
 static void
@@ -7006,15 +7024,20 @@ static bool balance_push(struct rq *rq)
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
 	 */
-	if (is_per_cpu_kthread(push_task)) {
+	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
 		 * last task to vanish. The rcuwait_active() check is
 		 * accurate here because the waiter is pinned on this CPU
 		 * and can't obviously be running in parallel.
+		 *
+		 * On RT kernels this also has to check whether there are
+		 * pinned and scheduled out tasks on the runqueue. They
+		 * need to leave the migrate disabled section first.
 		 */
-		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
+		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
+		    rcuwait_active(&rq->hotplug_wait)) {
 			raw_spin_unlock(&rq->lock);
 			rcuwait_wake_up(&rq->hotplug_wait);
 			raw_spin_lock(&rq->lock);
@@ -7063,7 +7086,8 @@ static void balance_hotplug_wait(void)
 {
 	struct rq *rq = this_rq();
 
-	rcuwait_wait_event(&rq->hotplug_wait, rq->nr_running == 1,
+	rcuwait_wait_event(&rq->hotplug_wait,
+			   rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
 			   TASK_UNINTERRUPTIBLE);
 }
 
@@ -7310,7 +7334,7 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1);
+	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1053,6 +1053,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
+	unsigned int		nr_pinned;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED


