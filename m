Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC42C8BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgK3RvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgK3RvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:51:23 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780CA2087C;
        Mon, 30 Nov 2020 17:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606758642;
        bh=yNpLsNn6g9LiRfAIwGsv+VR6roA82S8+ZJTlH+OND1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAM77jw1WH9uer6XXVSehUnvQfCEaeCv3lZReAZsRQmaMnXJsUeGcI5ltF7eCybsw
         Cf5l5ZmZvabT7Mi7LYHvU6Sla+8HowXdudSOH4v7Iq4h6RkCmCcfYOlHFVWBBPTMoA
         uqI9Zmyg6bFe2hlzDewCtNy5djdPS86jY3rH1Z9s=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
Date:   Mon, 30 Nov 2020 09:50:35 -0800
Message-Id: <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606758530.git.luto@kernel.org>
References: <cover.1606758530.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
other CPUs, but there are two issues.

 - membarrier() does not sync_core() or rseq_preempt() the calling
   CPU.  Aside from the logic being mind-bending, this also means
   that it may not be safe to modify user code through an alias,
   call membarrier(), and then jump to a different executable alias
   of the same code.

 - membarrier() does not explicitly sync_core() remote CPUs either;
   instead, it relies on the assumption that an IPI will result in a
   core sync.  On x86, I think this may be true in practice, but
   it's not architecturally reliable.  In particular, the SDM and
   APM do not appear to guarantee that interrupt delivery is
   serializing.  On a preemptible kernel, IPI return can schedule,
   thereby switching to another task in the same mm that was
   sleeping in a syscall.  The new task could then SYSRET back to
   usermode without ever executing IRET.

This patch simplifies the code to treat the calling CPU just like
all other CPUs, and explicitly sync_core() on all target CPUs.  This
eliminates the need for the smp_mb() at the end of the function
except in the special case of a targeted remote membarrier().  This
patch updates that code and the comments accordingly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/sched/membarrier.c | 94 +++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 7d98ef5d3bcd..40266aa7ec39 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -38,6 +38,11 @@ static void ipi_mb(void *info)
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
+static void ipi_sync_core(void *info)
+{
+	sync_core_before_usermode();
+}
+
 static void ipi_rseq(void *info)
 {
 	/*
@@ -162,6 +167,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
+		ipi_func = ipi_sync_core;
 	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
 		if (!IS_ENABLED(CONFIG_RSEQ))
 			return -EINVAL;
@@ -180,10 +186,46 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		return 0;
 
 	/*
-	 * Matches memory barriers around rq->curr modification in
-	 * scheduler.
+	 * Consider the following scenario:
+	 *
+	 * Initially, x != y, *x == 0, *y == 0
+	 *
+	 * Our thread, on CPU 0:
+	 * ===========
+	 * WRITE_ONCE(*x, 1);
+	 * membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0);
+	 * a = READ_ONCE(*y);
+	 *
+	 * Another thread:
+	 * ============
+	 * WRITE_ONCE(*y, 1);
+	 * barrier(); -- should synchronize with membarrier()
+	 * b = READ_ONCE(*x);
+	 *
+	 * Now suppose the other thread schedules out before writing 1
+	 * to *y.  Then it schedules back in on CPU 1 concurrently
+	 * with the membarrier() call.  If our thread did not have any
+	 * barrier here in the membarrier() syscall and if system call
+	 * entries were not barriers, then CPU 0 could do this:
+	 *
+	 *  WRITE_ONCE(*x, 1);
+	 *  [no barrier here]
+	 *  observe cpu_rq(1)->curr->mm != current->mm
+	 *
+	 * and we would not send an IPI to CPU 1.  But, again because there is
+	 * no barrier, the write to *x might not be visible to CPU 1
+	 * until after CPU 1 returns to usermode and reads *x == 0.  And, since
+	 * nothing forces CPU1's write to *y to become globally visible
+	 * at any point, CPU0 can see *y == 0.
+	 *
+	 * This sequence of events gives a == b == 0, which is a violation
+	 * of the semantics of membarrier().  If effect, the WRITE_ONCE(*x, 1)
+	 * got reordered with the membarrier(), and that shouldn't happen.
+	 *
+	 * This barrier synchronizes with the barrier after the
+	 * rq->curr modification in the scheduler.
 	 */
-	smp_mb();	/* system call entry is not a mb. */
+	smp_mb();
 
 	if (cpu_id < 0 && !zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
@@ -195,8 +237,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 
 		if (cpu_id >= nr_cpu_ids || !cpu_online(cpu_id))
 			goto out;
-		if (cpu_id == raw_smp_processor_id())
-			goto out;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu_id)->curr);
 		if (!p || p->mm != mm) {
@@ -211,16 +251,6 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		for_each_online_cpu(cpu) {
 			struct task_struct *p;
 
-			/*
-			 * Skipping the current CPU is OK even through we can be
-			 * migrated at any point. The current CPU, at the point
-			 * where we read raw_smp_processor_id(), is ensured to
-			 * be in program order with respect to the caller
-			 * thread. Therefore, we can skip this CPU from the
-			 * iteration.
-			 */
-			if (cpu == raw_smp_processor_id())
-				continue;
 			p = rcu_dereference(cpu_rq(cpu)->curr);
 			if (p && p->mm == mm)
 				__cpumask_set_cpu(cpu, tmpmask);
@@ -228,25 +258,33 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		rcu_read_unlock();
 	}
 
-	preempt_disable();
-	if (cpu_id >= 0)
-		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
-	else
-		smp_call_function_many(tmpmask, ipi_func, NULL, 1);
-	preempt_enable();
+	if (cpu_id >= 0) {
+		int cpu = get_cpu();
+
+		if (cpu_id == cpu) {
+			ipi_func(NULL);
+		} else {
+			smp_call_function_single(cpu_id, ipi_func, NULL, 1);
+			/*
+			 * This is analogous to the smp_mb() at the beginning
+			 * of the function -- exit from a system call is not a
+			 * barrier.  We only need this if we're targeting a
+			 * specific remote CPU, though -- otherwise ipi_func()
+			 * would serves the same purpose.
+			 */
+			smp_mb();
+		}
+
+		put_cpu();
+	} else {
+		on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
+	}
 
 out:
 	if (cpu_id < 0)
 		free_cpumask_var(tmpmask);
 	cpus_read_unlock();
 
-	/*
-	 * Memory barrier on the caller thread _after_ we finished
-	 * waiting for the last IPI. Matches memory barriers around
-	 * rq->curr modification in scheduler.
-	 */
-	smp_mb();	/* exit from system call is not a mb */
-
 	return 0;
 }
 
-- 
2.28.0

