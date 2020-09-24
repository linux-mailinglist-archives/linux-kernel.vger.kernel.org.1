Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2484C2777B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgIXRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:25:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:53556 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgIXRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:25:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C9DF12D64DD;
        Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hdzMxv5viQO6; Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7047C2D655D;
        Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7047C2D655D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600968317;
        bh=zdrxtBYfYBOFgWEPLTIsxULhzZQ9l77xgbOeF/2I5e8=;
        h=From:To:Date:Message-Id;
        b=AdJL2VDySGg8lfq74aDS7xukc2w/T8RLzsb/myaY2ePtJWYtBZVWtKNSu34bz2wnR
         XEZ0Q064f6sHnEmOTqIlQpjxypEmErCZPSpvKtUYojaoLXOppWSmMnkhkLQiR0oMP+
         C7ZdGifRTddNMfujk3Gv+L8w4uw0d5FFS2GwIwfrH4F7nq9e3bG+7y3TtFNUZW/YpA
         9v2sN2oxPte7ippkutQ0L/suRt5TVGojvAiubvObsrH6/Ie/JriFrU0sia5zYsyKj3
         slrJc3J2AdnjhTkA7lETFAZZogreXk6K96coaylbzFvkDQi1QCrYpIQ5SB5loe0pKT
         fUaUo4g9b8o9A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A7n2xgkRa9mB; Thu, 24 Sep 2020 13:25:17 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 2ACDB2D690A;
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
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org
Subject: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v3)
Date:   Thu, 24 Sep 2020 13:25:06 -0400
Message-Id: <20200924172508.8724-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exit_mm should issue memory barriers after user-space memory accesses,
before clearing current->mm, to order user-space memory accesses
performed prior to exit_mm before clearing tsk->mm, which has the
effect of skipping the membarrier private expedited IPIs.

exit_mm should also update the runqueue's membarrier_state so
membarrier global expedited IPIs are not sent when they are not
needed.

The membarrier system call can be issued concurrently with do_exit
if we have thread groups created with CLONE_VM but not CLONE_THREAD.

Here is the scenario I have in mind:

Two thread groups are created, A and B. Thread group B is created by
issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
Let's assume we have a single thread within each thread group (Thread A
and Thread B).

The AFAIU we can have:

Userspace variables:

int x = 0, y = 0;

CPU 0                   CPU 1
Thread A                Thread B
(in thread group A)     (in thread group B)

x = 1
barrier()
y = 1
exit()
exit_mm()
current->mm = NULL;
                        r1 = load y
                        membarrier()
                          skips CPU 0 (no IPI) because its current mm is NULL
                        r2 = load x
                        BUG_ON(r1 == 1 && r2 == 0)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mm@kvack.org
---
Changes since v1:
- Use smp_mb__after_spinlock rather than smp_mb.
- Document race scenario in commit message.

Changes since v2:
- Introduce membarrier_update_current_mm,
- Use membarrier_update_current_mm to update rq's membarrier_state from
  exit_mm.
---
 include/linux/sched/mm.h  |  5 +++++
 kernel/exit.c             | 12 ++++++++++++
 kernel/sched/membarrier.c | 12 ++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..5dd7f56baaba 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -370,6 +370,8 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 
 extern void membarrier_exec_mmap(struct mm_struct *mm);
 
+extern void membarrier_update_current_mm(struct mm_struct *next_mm);
+
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
@@ -384,6 +386,9 @@ static inline void membarrier_exec_mmap(struct mm_struct *mm)
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 }
+static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
+{
+}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..0767a2dbf245 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -475,7 +475,19 @@ static void exit_mm(void)
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
+	/*
+	 * When a thread stops operating on an address space, the loop
+	 * in membarrier_private_expedited() may not observe that
+	 * tsk->mm, and the loop in membarrier_global_expedited() may
+	 * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
+	 * rq->membarrier_state, so those would not issue an IPI.
+	 * Membarrier requires a memory barrier after accessing
+	 * user-space memory, before clearing tsk->mm or the
+	 * rq->membarrier_state.
+	 */
+	smp_mb__after_spinlock();
 	current->mm = NULL;
+	membarrier_update_current_mm(NULL);
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
 	task_unlock(current);
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..8bc8b8a888b7 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -63,6 +63,18 @@ void membarrier_exec_mmap(struct mm_struct *mm)
 	this_cpu_write(runqueues.membarrier_state, 0);
 }
 
+void membarrier_update_current_mm(struct mm_struct *next_mm)
+{
+	struct rq *rq = this_rq();
+	int membarrier_state = 0;
+
+	if (next_mm)
+		membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
+		return;
+	WRITE_ONCE(rq->membarrier_state, membarrier_state);
+}
+
 static int membarrier_global_expedited(void)
 {
 	int cpu;
-- 
2.17.1

