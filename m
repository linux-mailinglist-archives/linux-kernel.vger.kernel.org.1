Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA12F8D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbhAPLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbhAPLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2EC061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=f8Vh7AFAxggxFJw8yVBsAmoWyW5qOJyrzUkSYRd7lUw=; b=TrOwlh+9ZWPNlGLmAXHmq1r3w2
        aPONeraxM+U1JN19coUQ64ga0QqU8grEEK3I1JdRTZwqUh/b8Zqq9ISRL55/siivQVUt+MZV5N1pI
        hZXpqaWYKtKTIjgH/jNnIdmdBtyYzIl5asg8S1Wb6DOuFNtymWxmEK+Js672IXmWbYxU06ee7F8BB
        2VjvMFSLb+5h0Ibxy6r2qfG55Cx8zl4e+hFT1kKsY9xF1gZGONvJGy5Ss/BTjqsFWTb2ftCK+SZZ2
        GCE8YTNiBV05iSDK9a7SCz7lQ52cB9wT0xbb/mCRPtTz0Nio2IT8OD6ZhrTuOW5Fu1fOOtnzDtTaB
        OcvVEb/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0jyx-00ADQv-R7; Sat, 16 Jan 2021 11:43:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 037853070D5;
        Sat, 16 Jan 2021 12:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 37A6620285FB3; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113920.187137770@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 8/8] sched: Relax the set_cpus_allowed_ptr() semantics
References: <20210116113033.608340773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have KTHREAD_IS_PER_CPU to denote the critical per-cpu
tasks to retain during CPU offline, we can relax the warning in
set_cpus_allowed_ptr(). Any spurious kthread that wants to get on at
the last minute will get pushed off before it can run.

While during CPU online there is no harm, and actual benefit, to
allowing kthreads back on early, it simplifies hotplug code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2342,7 +2342,9 @@ static int __set_cpus_allowed_ptr(struct
 
 	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs.
+		 * Kernel threads are allowed on online && !active CPUs,
+		 * however, during cpu-hot-unplug, even these might get pushed
+		 * away if not KTHREAD_IS_PER_CPU.
 		 *
 		 * Specifically, migration_disabled() tasks must not fail the
 		 * cpumask_any_and_distribute() pick below, esp. so on
@@ -2386,16 +2388,6 @@ static int __set_cpus_allowed_ptr(struct
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	if (p->flags & PF_KTHREAD) {
-		/*
-		 * For kernel threads that do indeed end up on online &&
-		 * !active we want to ensure they are strict per-CPU threads.
-		 */
-		WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
-			!cpumask_intersects(new_mask, cpu_active_mask) &&
-			p->nr_cpus_allowed != 1);
-	}
-
 	return affine_move_task(rq, p, &rf, dest_cpu, flags);
 
 out:
@@ -7519,6 +7511,12 @@ int sched_cpu_deactivate(unsigned int cp
 	 */
 	synchronize_rcu();
 
+	/*
+	 * From this point forward, this CPU will refuse to run any task that
+	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
+	 * push those tasks away until this gets cleared, see
+	 * sched_cpu_dying().
+	 */
 	balance_push_set(cpu, true);
 
 	rq_lock_irqsave(rq, &rf);


