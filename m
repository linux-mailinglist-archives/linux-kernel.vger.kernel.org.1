Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA202F8D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbhAPLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbhAPLol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E79C061798
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jW965wIj4Nk6fWhpyu0BxC4zsQGVgLdYs668mqxSOw0=; b=ftfJfNV4U0bLyfP/1zYUS5Z8+V
        RX3pqUe/5rflZvnqHpnMRcTBEBNFX6lp6UZxMjA3KjOBCT8hDcyingTI0qbAck8jXPc27cwkSBDm0
        cBPEOHF7Hf6pc6eYeBlOxBhjm3JyeDTKSBkij1X1roXUTjpo7nqrkQEPrmAjR6DCRDVPQThNkya/C
        9lAAHjUcCuQfJNa+hgJcmkHDPtevjw77g8Di156bG7xn/GmuQ3x2Nb8rU3dSHsB31Zph62aNxAzwZ
        jNUWCsy0t/9YF72wSl6fyzQlvfi4GiBD3ZZapiOxlf8isX3j0/5FpHWCbiQ3piH4C1zR/Xu/kGYbv
        Rq5m1fUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0jyT-00ADOA-Mb; Sat, 16 Jan 2021 11:42:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0051E306E07;
        Sat, 16 Jan 2021 12:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 336A920285FAE; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113920.103635633@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 7/8] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
References: <20210116113033.608340773@infradead.org>
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
 kernel/sched/core.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

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
+	if (cpu_rq(cpu)->balance_callback == &balance_push_callback)
+		return cpu_active(cpu);
+
+	/* But are allowed during online. */
+	return cpu_online(cpu);
 }
 
 /*
@@ -7276,8 +7291,14 @@ static void balance_push(struct rq *rq)
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
@@ -7309,7 +7330,7 @@ static void balance_push(struct rq *rq)
 	/*
 	 * At this point need_resched() is true and we'll take the loop in
 	 * schedule(). The next pick is obviously going to be the stop task
-	 * which is_per_cpu_kthread() and will push this task away.
+	 * which kthread_is_per_cpu() and will push this task away.
 	 */
 	raw_spin_lock(&rq->lock);
 }


