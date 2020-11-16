Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5962B40D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgKPKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbgKPKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:32 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0362465E;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521909;
        bh=qlMzfQ3HAY/DMShVXfsrywi/ZvHE7KbTKL3qR/8mICE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGHkIZEHn2+mxFrJ99MYFwQhSZ/pZF8Izhvlp2qxk+MhFuCp2UotVtA2LFZnfJViL
         6Za1dG9fks0JiedTr3mommTvngV97BCG5NEkefGdC/kpTsALsiD8eTbvgpqaipce2u
         fKz6ZzWgMQvSnJLeWwRPCh8cIUOOXi+0rZO7fVLU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEq-MC; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/27] shed: fix kernel-doc markup
Date:   Mon, 16 Nov 2020 11:18:20 +0100
Message-Id: <7cf5d2691e70ab82c332a335d21f6f04c0f742ab.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc requires that a kernel-doc markup to be immediatly
below the function prototype, as otherwise it will rename it.
So, move sys_sched_yield() markup to the right place.

Also fix the cpu_util() markup: Kernel-doc markups
should use this format:
        identifier - description

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02076e6d3792..9d41378ae8f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6560,65 +6560,65 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 27536f37ba1a..cb7cd7d8a28f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6310,41 +6310,41 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
-- 
2.28.0

