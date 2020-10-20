Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8A293D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407676AbgJTNra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:47:30 -0400
Received: from mail.efficios.com ([167.114.26.124]:43566 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407620AbgJTNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:47:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 751912D91D0;
        Tue, 20 Oct 2020 09:47:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0s1hfb8zK3PH; Tue, 20 Oct 2020 09:47:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A421F2D91CF;
        Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A421F2D91CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603201639;
        bh=wdlHdXScqDBTUYMXWUj2Bb++1fuTmyvvGLKL/AUpDt8=;
        h=From:To:Date:Message-Id;
        b=id7oikISqN1YevT0zaWn3UwFRprlsLOPVMH+AlLldDo/Sji+tXSxS+McVCx3avrTb
         d3NRLdgUv9BPRAe9pO+okn/uCQfIgFlKqUqN5okWTaBM7CwnUJYyaMpZ64vzTphkPz
         T1jeGsHyO3g30ET+iYqgZo8yfhPBGqMpXWE0lZdkhL7fs2NiQbuD68idfkfRTCURxg
         19VF0Q15DcDnReCiRhqo3xynRKFtkzkQ6pSymJT0HZ0RcjnFCjzFPQLTZJULJFBlRC
         P+Lq9kivDovP9BTUtlY1qJnBmII3GVvP/CD7a3Q+7onrEr4A8tMuNown9R/1VgJeh3
         jEkb+9ZD43g8A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iXbtnrNxZNGa; Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 18AF12D939B;
        Tue, 20 Oct 2020 09:47:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] sched: membarrier: cover kthread_use_mm (v4)
Date:   Tue, 20 Oct 2020 09:47:14 -0400
Message-Id: <20201020134715.13909-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
References: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
to allow the effect of membarrier(2) to apply to kthreads accessing
user-space memory as well.

Given that no prior kthread use this guarantee and that it only affects
kthreads, adding this guarantee does not affect user-space ABI.

Refine the check in membarrier_global_expedited to exclude runqueues
running the idle thread rather than all kthreads from the IPI cpumask.

Now that membarrier_global_expedited can IPI kthreads, the scheduler
also needs to update the runqueue's membarrier_state when entering lazy
TLB state.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v1:
- Add WARN_ON_ONCE(current->mm) in play_idle_precise (PeterZ),
- Use smp_mb__after_spinlock rather than smp_mb after task_lock.

Changes since v2:
- Update the rq's membarrier state on kthread use/unuse mm,
- The scheduler must use membarrier_switch_mm for lazy TLB case as well,
  now that global expedited membarrier IPIs kthreads.

Changes since v3:
- Revert back to not using membarrier_switch_mm for lazy TLB case. This
  is made OK by ensuring that the global expedited membarrier only skips
  kthreads which have a NULL mm, so it only skips kthreads which are in
  lazy TLB mode.
---
 kernel/kthread.c          | 21 +++++++++++++++++++++
 kernel/sched/idle.c       |  1 +
 kernel/sched/membarrier.c |  7 +++----
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..a396734d31f3 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1248,6 +1248,7 @@ void kthread_use_mm(struct mm_struct *mm)
 		tsk->active_mm = mm;
 	}
 	tsk->mm = mm;
+	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
@@ -1255,8 +1256,19 @@ void kthread_use_mm(struct mm_struct *mm)
 	finish_arch_post_lock_switch();
 #endif
 
+	/*
+	 * When a kthread starts operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after storing to tsk->mm, before accessing
+	 * user-space memory. A full memory barrier for membarrier
+	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
+	 * mmdrop(), or explicitly with smp_mb().
+	 */
 	if (active_mm != mm)
 		mmdrop(active_mm);
+	else
+		smp_mb();
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1276,9 +1288,18 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	force_uaccess_end(to_kthread(tsk)->oldfs);
 
 	task_lock(tsk);
+	/*
+	 * When a kthread stops operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after accessing user-space memory, before
+	 * clearing tsk->mm.
+	 */
+	smp_mb__after_spinlock();
 	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
+	membarrier_update_current_mm(NULL);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	local_irq_enable();
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f324dc36fc43..f0d81a5ea471 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -338,6 +338,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
 	WARN_ON_ONCE(!duration_ns);
+	WARN_ON_ONCE(current->mm);
 
 	rcu_sleep_check();
 	preempt_disable();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 8bc8b8a888b7..8b93b6844901 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -113,12 +113,11 @@ static int membarrier_global_expedited(void)
 			continue;
 
 		/*
-		 * Skip the CPU if it runs a kernel thread. The scheduler
-		 * leaves the prior task mm in place as an optimization when
-		 * scheduling a kthread.
+		 * Skip the CPU if it runs a kernel thread which is not using
+		 * a task mm.
 		 */
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p->flags & PF_KTHREAD)
+		if (!p->mm)
 			continue;
 
 		__cpumask_set_cpu(cpu, tmpmask);
-- 
2.17.1

