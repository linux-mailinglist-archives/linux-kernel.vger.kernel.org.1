Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26A26ACB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIOS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbgIOSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:55:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA4C061351
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:55:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f185so4368170ybf.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=o8t0RttqibGBQNXCaKlW9OweaEKnFiMzn7sl3do7r44=;
        b=cZSBFfRbaO21NrucPWMSkyE+lwYXMhKM7LtlyNkPzGstWLOjV3KbsQMUZizwmPMkCV
         hFmtIt4ouBrCVVLbQ1z2JSG1xnkBf4GP+LyMxUPR1TBja3ZqusuP1GhrHwEw+yohyNDA
         lFSUHoe0t0jobe6ADdqO8+7RRRs3Pz6mYA16Dv46IXD+m7LSF2SQ8dnqL2TS93yQgL/X
         EMK7d/D3AwGRzpFvkTaJa0KXkJiLux9H7jFLmmX7UBsCOtlR7vN8hbMXxXy+Tl+C41iD
         9H9sVpt6mYezalFK2fr30fs3+vu11PuQd4MQpLJfJguZ4XhSQnkDOxiiW6kKpDwNadSP
         tJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=o8t0RttqibGBQNXCaKlW9OweaEKnFiMzn7sl3do7r44=;
        b=WuVAR+ws5SA4AbfJZubBi6WL88f3507uKLtobYfjl1CxDiqq9BjObXvJsMZj/7FnNE
         LjwV4EByhFwld8esp7IIZ4eNYYLQToCUkIeYtdpXjr7QkS+bdeC33A5mehFYOLuO6LK+
         qtwboGZmgy5wEsHoxuBDC2T1O1+ZZYbgS+/PDlaViJmV3G+eGOmW4vVcf7FkjWIIY4Ma
         hwEIji21AOP61gLfKFUB4UFgFyB0KrWUAJsceRb3Zlm05uJzLj0FzaU/jtfcztUtz3xO
         /nKJHQQuMcpcgYgnXX2LFsXVJJ2zdc4W+ESo0Vxd8vEuOY3aOUIrpt7+oB/4LVRumgB1
         iPAQ==
X-Gm-Message-State: AOAM533EB0B6kFKooyz+uXRAJrrId5mea3Zb0rOZ6qn6SnNian9TPZQC
        f0sBmvfa0jZAYqkfCMTC+9tfnbe1
X-Google-Smtp-Source: ABdhPJwEct1HOaI5IL0muTD9fbLtcWqQwmCoMVWR31LBxAw6wy5xSYkJVqHa3oy08a1RSECvGVF0f65z
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe09:7598])
 (user=posk job=sendgmr) by 2002:a25:ca17:: with SMTP id a23mr15485213ybg.176.1600196146230;
 Tue, 15 Sep 2020 11:55:46 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:55:40 -0700
Message-Id: <20200915185541.1565837-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH 1/2 v7] rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
From:   Peter Oskolkov <posk@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Google-internal RSEQ
work done by Paul Turner and Andrew Hunter.

When working with per-CPU RSEQ-based memory allocations,
it is sometimes important to make sure that a global
memory location is no longer accessed from RSEQ critical
sections. For example, there can be two per-CPU lists,
one is "active" and accessed per-CPU, while another one
is inactive and worked on asynchronously "off CPU" (e.g.
garbage collection is performed). Then at some point
the two lists are swapped, and a fast RCU-like mechanism
is required to make sure that the previously active
list is no longer accessed.

This patch introduces such a mechanism: in short,
membarrier() syscall issues an IPI to a CPU, restarting
a potentially active RSEQ critical section on the CPU.

v1->v2:
  - removed the ability to IPI all CPUs in a single sycall;
  - use task->mm rather than task->group_leader to identify
    tasks belonging to the same process.
v2->v3:
  - re-added the ability to IPI all CPUs in a single syscall;
  - integrated with membarrier_private_expedited() to
    make sure only CPUs running tasks with the same mm as
    the current task are interrupted;
  - also added MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ;
  - flags in membarrier_private_expedited are never actually
    bit flags but always distinct values (i.e. never two flags
    are combined), so I modified bit testing to full equation
    comparison for simplicity (otherwise the code needs to
    work when several bits are set, for example).
v3->v4:
  - added the third parameter to membarrier syscall: @cpu_id:
    if @flags == MEMBARRIER_CMD_FLAG_CPU, then @cpu_id indicates
    the cpu on which RSEQ CS should be restarted.
v4->v5:
  - added @cpu_id parameter to sys_membarrier in syscalls.h.
v5->v6:
  - made membarrier_private_expedited more efficient in a
    single-cpu case;
  - a couple of minor refactorings.
v6->v7:
  - made @flags an unsigned int in sys_membarrier;
  - a couple of minor refactorings.

The second patch in the patchset adds a selftest
of this feature.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/sched/mm.h        |   3 +
 include/linux/syscalls.h        |   2 +-
 include/uapi/linux/membarrier.h |  26 ++++++
 kernel/sched/membarrier.c       | 136 +++++++++++++++++++++++++-------
 4 files changed, 136 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..15bfb06f2884 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -348,10 +348,13 @@ enum {
 	MEMBARRIER_STATE_GLOBAL_EXPEDITED			= (1U << 3),
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY	= (1U << 4),
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE		= (1U << 5),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY		= (1U << 6),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ			= (1U << 7),
 };
 
 enum {
 	MEMBARRIER_FLAG_SYNC_CORE	= (1U << 0),
+	MEMBARRIER_FLAG_RSEQ		= (1U << 1),
 };
 
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 75ac7f8ae93c..466c993e52bf 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -974,7 +974,7 @@ asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
 asmlinkage long sys_userfaultfd(int flags);
-asmlinkage long sys_membarrier(int cmd, int flags);
+asmlinkage long sys_membarrier(int cmd, int flags, int cpu_id);
 asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
 asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
 				    int fd_out, loff_t __user *off_out,
diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 5891d7614c8c..737605897f36 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -114,6 +114,26 @@
  *                          If this command is not implemented by an
  *                          architecture, -EINVAL is returned.
  *                          Returns 0 on success.
+ * @MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+ *                          Ensure the caller thread, upon return from
+ *                          system call, that all its running thread
+ *                          siblings have any currently running rseq
+ *                          critical sections restarted if @flags
+ *                          parameter is 0; if @flags parameter is
+ *                          MEMBARRIER_CMD_FLAG_CPU,
+ *                          then this operation is performed only
+ *                          on CPU indicated by @cpu_id. If this command is
+ *                          not implemented by an architecture, -EINVAL
+ *                          is returned. A process needs to register its
+ *                          intent to use the private expedited rseq
+ *                          command prior to using it, otherwise
+ *                          this command returns -EPERM.
+ * @MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+ *                          Register the process intent to use
+ *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
+ *                          If this command is not implemented by an
+ *                          architecture, -EINVAL is returned.
+ *                          Returns 0 on success.
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
@@ -131,9 +151,15 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED		= (1 << 4),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE		= (1 << 5),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
 };
 
+enum membarrier_cmd_flag {
+	MEMBARRIER_CMD_FLAG_CPU		= (1 << 0),
+};
+
 #endif /* _UAPI_LINUX_MEMBARRIER_H */
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..04729fb96fba 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -18,6 +18,14 @@
 #define MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK	0
 #endif
 
+#ifdef CONFIG_RSEQ
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK		\
+	(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			\
+	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
+#else
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK	0
+#endif
+
 #define MEMBARRIER_CMD_BITMASK						\
 	(MEMBARRIER_CMD_GLOBAL | MEMBARRIER_CMD_GLOBAL_EXPEDITED	\
 	| MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED			\
@@ -30,6 +38,11 @@ static void ipi_mb(void *info)
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
+static void ipi_rseq(void *info)
+{
+	rseq_preempt(current);
+}
+
 static void ipi_sync_rq_state(void *info)
 {
 	struct mm_struct *mm = (struct mm_struct *) info;
@@ -129,19 +142,27 @@ static int membarrier_global_expedited(void)
 	return 0;
 }
 
-static int membarrier_private_expedited(int flags)
+static int membarrier_private_expedited(int flags, int cpu_id)
 {
-	int cpu;
 	cpumask_var_t tmpmask;
 	struct mm_struct *mm = current->mm;
+	smp_call_func_t ipi_func = ipi_mb;
 
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
+	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
+	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
+		if (!IS_ENABLED(CONFIG_RSEQ))
+			return -EINVAL;
+		if (!(atomic_read(&mm->membarrier_state) &
+		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
+			return -EPERM;
+		ipi_func = ipi_rseq;
 	} else {
+		BUG_ON(flags != 0);
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
 			return -EPERM;
@@ -156,35 +177,59 @@ static int membarrier_private_expedited(int flags)
 	 */
 	smp_mb();	/* system call entry is not a mb. */
 
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+	if (cpu_id < 0 && !zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpus_read_lock();
-	rcu_read_lock();
-	for_each_online_cpu(cpu) {
+
+	if (cpu_id >= 0) {
 		struct task_struct *p;
 
-		/*
-		 * Skipping the current CPU is OK even through we can be
-		 * migrated at any point. The current CPU, at the point
-		 * where we read raw_smp_processor_id(), is ensured to
-		 * be in program order with respect to the caller
-		 * thread. Therefore, we can skip this CPU from the
-		 * iteration.
-		 */
-		if (cpu == raw_smp_processor_id())
-			continue;
-		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p && p->mm == mm)
-			__cpumask_set_cpu(cpu, tmpmask);
+		if (cpu_id >= nr_cpu_ids || !cpu_online(cpu_id))
+			goto out;
+		if (cpu_id == raw_smp_processor_id())
+			goto out;
+		rcu_read_lock();
+		p = rcu_dereference(cpu_rq(cpu_id)->curr);
+		if (!p || p->mm != mm) {
+			rcu_read_unlock();
+			goto out;
+		}
+		rcu_read_unlock();
+	} else {
+		int cpu;
+
+		rcu_read_lock();
+		for_each_online_cpu(cpu) {
+			struct task_struct *p;
+
+			/*
+			 * Skipping the current CPU is OK even through we can be
+			 * migrated at any point. The current CPU, at the point
+			 * where we read raw_smp_processor_id(), is ensured to
+			 * be in program order with respect to the caller
+			 * thread. Therefore, we can skip this CPU from the
+			 * iteration.
+			 */
+			if (cpu == raw_smp_processor_id())
+				continue;
+			p = rcu_dereference(cpu_rq(cpu)->curr);
+			if (p && p->mm == mm)
+				__cpumask_set_cpu(cpu, tmpmask);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
 	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	if (cpu_id >= 0)
+		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
+	else
+		smp_call_function_many(tmpmask, ipi_func, NULL, 1);
 	preempt_enable();
 
-	free_cpumask_var(tmpmask);
+out:
+	if (cpu_id < 0)
+		free_cpumask_var(tmpmask);
 	cpus_read_unlock();
 
 	/*
@@ -283,11 +328,18 @@ static int membarrier_register_private_expedited(int flags)
 	    set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED,
 	    ret;
 
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
+	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
 		ready_state =
 			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
+	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
+		if (!IS_ENABLED(CONFIG_RSEQ))
+			return -EINVAL;
+		ready_state =
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY;
+	} else {
+		BUG_ON(flags != 0);
 	}
 
 	/*
@@ -299,6 +351,8 @@ static int membarrier_register_private_expedited(int flags)
 		return 0;
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
 		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
+	if (flags & MEMBARRIER_FLAG_RSEQ)
+		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ;
 	atomic_or(set_state, &mm->membarrier_state);
 	ret = sync_runqueues_membarrier_state(mm);
 	if (ret)
@@ -310,8 +364,15 @@ static int membarrier_register_private_expedited(int flags)
 
 /**
  * sys_membarrier - issue memory barriers on a set of threads
- * @cmd:   Takes command values defined in enum membarrier_cmd.
- * @flags: Currently needs to be 0. For future extensions.
+ * @cmd:    Takes command values defined in enum membarrier_cmd.
+ * @flags:  Currently needs to be 0 for all commands other than
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ: in the latter
+ *          case it can be MEMBARRIER_CMD_FLAG_CPU, indicating that @cpu_id
+ *          contains the CPU on which to interrupt (= restart)
+ *          the RSEQ critical section.
+ * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
+ *          RSEQ CS should be interrupted (@cmd must be
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
  * command specified does not exist, not available on the running
@@ -337,10 +398,21 @@ static int membarrier_register_private_expedited(int flags)
  *        smp_mb()           X           O            O
  *        sys_membarrier()   O           O            O
  */
-SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
+SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
 {
-	if (unlikely(flags))
-		return -EINVAL;
+	switch (cmd) {
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+		if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
+			return -EINVAL;
+		break;
+	default:
+		if (unlikely(flags))
+			return -EINVAL;
+	}
+
+	if (!(flags & MEMBARRIER_CMD_FLAG_CPU))
+		cpu_id = -1;
+
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
 	{
@@ -362,13 +434,17 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 	case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
 		return membarrier_register_global_expedited();
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
-		return membarrier_private_expedited(0);
+		return membarrier_private_expedited(0, cpu_id);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
 		return membarrier_register_private_expedited(0);
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
-		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, cpu_id);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
+	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
 	default:
 		return -EINVAL;
 	}
-- 
2.28.0.618.gf4bc123cb7-goog

