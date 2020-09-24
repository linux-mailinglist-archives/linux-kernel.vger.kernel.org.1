Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8D2777BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgIXRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:25:30 -0400
Received: from mail.efficios.com ([167.114.26.124]:53580 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgIXRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:25:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 268722D64DF;
        Thu, 24 Sep 2020 13:25:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id x7T-MVb3KWCP; Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 91F302D6819;
        Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 91F302D6819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600968317;
        bh=zLxn7FGoPJYghx49QThG3MR35b326LMYvjG0XfsBwp8=;
        h=From:To:Date:Message-Id;
        b=YKxH2senveOrLhPR8u+TuNB+9UE0ZjUmEAbMeOEwmdwLAWJTzcaOeAxMwPe47LCWi
         DN5bkSvAwZuyniIoXgz4lHwuAxMcfc/rjpnP+U3bg9/SlN8RgaC3pYW85jjKiLDtMl
         FGfch6M/1Mvtrg38wDuu1G31sNmOYjqZAF3j8wr0y9P5KNL4me/dSy1luZemsptOVC
         L3dbuv3cttm42HBPtOvU7pSoAP3gsVkwQicI3XYla5LFXwKGBizyae3VeMDviUHm/g
         WstrEADUNpq0dXBnQIHu0NN/zwh5ikOEgDsI6QxiXACMGw0eKlGXTUAghlewiJ1Xlj
         +lttr8BIZeySg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PgRD4eLp1GvJ; Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 672BD2D66D0;
        Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
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
Subject: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v3)
Date:   Thu, 24 Sep 2020 13:25:07 -0400
Message-Id: <20200924172508.8724-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
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
---
 kernel/kthread.c          | 21 +++++++++++++++++++++
 kernel/sched/core.c       |  3 ++-
 kernel/sched/idle.c       |  1 +
 kernel/sched/membarrier.c |  8 ++------
 kernel/sched/sched.h      |  5 +++--
 5 files changed, 29 insertions(+), 9 deletions(-)

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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..bab6f4f2809f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3736,6 +3736,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 */
 	arch_start_context_switch(prev);
 
+	membarrier_switch_mm(rq, prev->mm, next->mm);
+
 	/*
 	 * kernel -> kernel   lazy + transfer active
 	 *   user -> kernel   lazy + mmgrab() active
@@ -3752,7 +3754,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		else
 			prev->active_mm = NULL;
 	} else {                                        // to user
-		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
 		 * rq->curr / membarrier_switch_mm() and returning to userspace.
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
index 8bc8b8a888b7..e5246580201b 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -112,13 +112,9 @@ static int membarrier_global_expedited(void)
 		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
 			continue;
 
-		/*
-		 * Skip the CPU if it runs a kernel thread. The scheduler
-		 * leaves the prior task mm in place as an optimization when
-		 * scheduling a kthread.
-		 */
+		/* Skip the CPU if it runs the idle thread. */
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p->flags & PF_KTHREAD)
+		if (is_idle_task(p))
 			continue;
 
 		__cpumask_set_cpu(cpu, tmpmask);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..d884959d4280 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2592,12 +2592,13 @@ static inline void membarrier_switch_mm(struct rq *rq,
 					struct mm_struct *prev_mm,
 					struct mm_struct *next_mm)
 {
-	int membarrier_state;
+	int membarrier_state = 0;
 
 	if (prev_mm == next_mm)
 		return;
 
-	membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (next_mm)
+		membarrier_state = atomic_read(&next_mm->membarrier_state);
 	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
 		return;
 
-- 
2.17.1

