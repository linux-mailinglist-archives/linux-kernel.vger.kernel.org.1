Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8902CA23E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbgLAMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388695AbgLAMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:53 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD132224A;
        Tue,  1 Dec 2020 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824556;
        bh=457tAyYykeptYGTvekzzpW1yT8MfaCE/G8tRtLknlfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0Xo/Yqfnq5ORINmusXKvp98rqaKYk42Q08x6aF+WLvOYAcH8NGp12XrH7py5sGYk
         7Ka+UcKdSoqcZwM6t2W8gxueK2Lv64qVuX2Iyi7ecoiy7zCPUgxP1PbAvNEa4qGdir
         aLg7brWMSfqcAjWukUeTrCu4UZxY/+1lz0ogctBE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdM-7q; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/16] sched: fix kernel-doc markup
Date:   Tue,  1 Dec 2020 13:09:06 +0100
Message-Id: <50cd6f460aeb872ebe518a8e9cfffda2df8bdb0a.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc requires that a kernel-doc markup to be immediately
below the function prototype, as otherwise it will rename it.
So, move sys_sched_yield() markup to the right place.

Also fix the cpu_util() markup: Kernel-doc markups
should use this format:
        identifier - description

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7f5277adbee..3545359072a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6606,89 +6606,89 @@ long sched_getaffinity(pid_t pid, struct cpumask *mask)
  *
  * Return: size of CPU mask copied to user_mask_ptr on success. An
  * error code otherwise.
  */
 SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 		unsigned long __user *, user_mask_ptr)
 {
 	int ret;
 	cpumask_var_t mask;
 
 	if ((len * BITS_PER_BYTE) < nr_cpu_ids)
 		return -EINVAL;
 	if (len & (sizeof(unsigned long)-1))
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return -ENOMEM;
 
 	ret = sched_getaffinity(pid, mask);
 	if (ret == 0) {
 		unsigned int retlen = min(len, cpumask_size());
 
 		if (copy_to_user(user_mask_ptr, mask, retlen))
 			ret = -EFAULT;
 		else
 			ret = retlen;
 	}
 	free_cpumask_var(mask);
 
 	return ret;
 }
 
-/**
- * sys_sched_yield - yield the current processor to other threads.
- *
- * This function yields the current CPU to other tasks. If there are no
- * other threads running on this CPU then this function will return.
- *
- * Return: 0.
- */
 static void do_sched_yield(void)
 {
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = this_rq_lock_irq(&rf);
 
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
 
 	preempt_disable();
 	rq_unlock_irq(rq, &rf);
 	sched_preempt_enable_no_resched();
 
 	schedule();
 }
 
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * This function yields the current CPU to other tasks. If there are no
+ * other threads running on this CPU then this function will return.
+ *
+ * Return: 0.
+ */
 SYSCALL_DEFINE0(sched_yield)
 {
 	do_sched_yield();
 	return 0;
 }
 
 #ifndef CONFIG_PREEMPTION
 int __sched _cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
 		return 1;
 	}
 	rcu_all_qs();
 	return 0;
 }
 EXPORT_SYMBOL(_cond_resched);
 #endif
 
 /*
  * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
  * call schedule, and on return reacquire the lock.
  *
  * This works OK both with and without CONFIG_PREEMPTION. We do strange low-level
  * operations here to prevent schedule() from being called twice (once via
  * spin_unlock(), once by hand).
  */
 int __cond_resched_lock(spinlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7e21ac479a2..f5dcedacc104 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6301,65 +6301,65 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		 * cpuset defines a symmetric island (i.e. one unique
 		 * capacity_orig value through the cpuset), the key will be set
 		 * but the CPUs within that cpuset will not have a domain with
 		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
 		 * capacity path.
 		 */
 		if (sd) {
 			i = select_idle_capacity(p, sd, target);
 			return ((unsigned)i < nr_cpumask_bits) ? i : target;
 		}
 	}
 
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
 
 	i = select_idle_core(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
 	i = select_idle_smt(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
 	return target;
 }
 
 /**
- * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
+ * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
  * @cpu: the CPU to get the utilization of
  *
  * The unit of the return value must be the one of capacity so we can compare
  * the utilization with the capacity of the CPU that is available for CFS task
  * (ie cpu_capacity).
  *
  * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on a CPU. It represents
  * the amount of utilization of a CPU in the range [0..capacity_orig] where
  * capacity_orig is the cpu_capacity available at the highest frequency
  * (arch_scale_freq_capacity()).
  * The utilization of a CPU converges towards a sum equal to or less than the
  * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
  * the running time on this CPU scaled by capacity_curr.
  *
  * The estimated utilization of a CPU is defined to be the maximum between its
  * cfs_rq.avg.util_avg and the sum of the estimated utilization of the tasks
  * currently RUNNABLE on that CPU.
  * This allows to properly represent the expected utilization of a CPU which
  * has just got a big task running since a long sleep period. At the same time
  * however it preserves the benefits of the "blocked utilization" in
  * describing the potential for other tasks waking up on the same CPU.
  *
  * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
  * higher than capacity_orig because of unfortunate rounding in
  * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
  * the average stabilizes with the new running time. We need to check that the
  * utilization stays within the range of [0..capacity_orig] and cap it if
  * necessary. Without utilization capping, a group could be seen as overloaded
  * (CPU0 utilization at 121% + CPU1 utilization at 80%) whereas CPU1 has 20% of
  * available capacity. We allow utilization to overshoot capacity_curr (but not
  * capacity_orig) as it useful for predicting the capacity required after task
-- 
2.28.0

