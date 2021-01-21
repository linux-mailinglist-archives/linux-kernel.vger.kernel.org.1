Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3552FE7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbhAUKju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbhAUKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:37:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47984C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4Qv6/+9MO0R9mzPsqaEWzOXWe6PLt0ArerpifrEE8iQ=; b=dJbQoAT1Y3IFQq81FP7woCr3Nz
        RvSqdvlMWDJhaK0sD8Zwdw1R2bJTZDAluZk479KcG4EKEnrF8OOPnwKx32UOPvecHb0vcZglE9zmm
        NWokG3824p4TxPSgNemfCwdoklqSCdkWxluGT5ofVweTrZZBQf0wvhlFAtI6FSxhCilWFdig7KxbQ
        RX1Ur4iVyZeW6Ji6zyoTGwrwubxpk3xl6tzCo0SL+yN1PD/oxP4PulE8bRVje4S0C67wcniM7ynoe
        Elh4NrTnwqpwxOJuKmMuY1qHH7gevuhVVGbj43P4QqEL5DkY9bkaPWj8NmuCOGAcIpkZyH9TjtGoG
        qvtJyqQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2XKK-0007Nk-LW; Thu, 21 Jan 2021 10:36:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A031307005;
        Thu, 21 Jan 2021 11:36:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7919620C86816; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121103507.102416009@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 8/9] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
References: <20210121101702.402798862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 1cf12e08bc4d ("sched/hotplug: Consolidate task
migration on CPU unplug") we'd leave any task on the dying CPU and
break affinity and force them off at the very end.

This scheme had to change in order to enable migrate_disable(). One
cannot wait for migrate_disable() to complete while stuck in
stop_machine(). Furthermore, since we need at the very least: idle,
hotplug and stop threads at any point before stop_machine, we can't
break affinity and/or push those away.

Under the assumption that all per-cpu kthreads are sanely handled by
CPU hotplug, the new code no long breaks affinity or migrates any of
them (which then includes the critical ones above).

However, there's an important difference between per-cpu kthreads and
kthreads that happen to have a single CPU affinity which is lost. The
latter class very much relies on the forced affinity breaking and
migration semantics previously provided.

Use the new kthread_is_per_cpu() infrastructure to tighten
is_per_cpu_kthread() and fix the hot-unplug problems stemming from the
change.

Fixes: 1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1796,13 +1796,28 @@ static inline bool rq_has_pinned_tasks(s
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
+	/* When not in the task's cpumask, no point in looking further. */
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
+	/* migrate_disabled() must be allowed to finish. */
+	if (is_migration_disabled(p))
 		return cpu_online(cpu);
 
-	return cpu_active(cpu);
+	/* Non kernel threads are not allowed during either online or offline. */
+	if (!(p->flags & PF_KTHREAD))
+		return cpu_active(cpu);
+
+	/* KTHREAD_IS_PER_CPU is always allowed. */
+	if (kthread_is_per_cpu(p))
+		return cpu_online(cpu);
+
+	/* Regular kernel threads don't get to stay during offline. */
+	if (cpu_rq(cpu)->balance_push)
+		return false;
+
+	/* But are allowed during online. */
+	return cpu_online(cpu);
 }
 
 /*
@@ -3122,6 +3122,13 @@ bool cpus_share_cache(int this_cpu, int
 static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 {
 	/*
+	 * Do not complicate things with the async wake_list while the CPU is
+	 * in hotplug state.
+	 */
+	if (!cpu_active(cpu))
+		return false;
+
+	/*
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
@@ -7283,8 +7298,14 @@ static void balance_push(struct rq *rq)
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
+	 *
+	 * XXX: the idle task does not match kthread_is_per_cpu() due to
+	 * histerical raisins.
 	 */
-	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
+	if (rq->idle == push_task ||
+	    ((push_task->flags & PF_KTHREAD) && kthread_is_per_cpu(push_task)) ||
+	    is_migration_disabled(push_task)) {
+
 		/*
 		 * If this is the idle task on the outgoing CPU try to wake
 		 * up the hotplug control thread which might wait for the
@@ -7316,7 +7337,7 @@ static void balance_push(struct rq *rq)
 	/*
 	 * At this point need_resched() is true and we'll take the loop in
 	 * schedule(). The next pick is obviously going to be the stop task
-	 * which is_per_cpu_kthread() and will push this task away.
+	 * which kthread_is_per_cpu() and will push this task away.
 	 */
 	raw_spin_lock(&rq->lock);
 }
@@ -7504,6 +7525,9 @@ int sched_cpu_deactivate(unsigned int cp
 	 * preempt-disabled and RCU users of this state to go away such that
 	 * all new such users will observe it.
 	 *
+	 * Specifically, we rely on ttwu to no longer target this CPU, see
+	 * ttwu_queue_cond() and is_cpu_allowed().
+	 *
 	 * Do sync before park smpboot threads to take care the rcu boost case.
 	 */
 	synchronize_rcu();


