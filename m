Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600821A1E49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgDHJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 05:50:33 -0400
Received: from foss.arm.com ([217.140.110.172]:36308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHJuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:50:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6CEC1063;
        Wed,  8 Apr 2020 02:50:31 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E888B3F73D;
        Wed,  8 Apr 2020 02:50:28 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched/deadline: Improve admission control for asymmetric CPU capacities
Date:   Wed,  8 Apr 2020 11:50:10 +0200
Message-Id: <20200408095012.3819-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408095012.3819-1-dietmar.eggemann@arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Abeni <luca.abeni@santannapisa.it>

The current SCHED_DEADLINE (DL) admission control ensures that

    sum of reserved CPU bandwidth < x * M

where

    x = /proc/sys/kernel/sched_rt_{runtime,period}_us
    M = # CPUs in root domain.

DL admission control works well for homogeneous systems where the
capacity of all CPUs are equal (1024). I.e. bounded tardiness for DL
and non-starvation of non-DL tasks is guaranteed.

But on heterogeneous systems where capacity of CPUs are different it
could fail by over-allocating CPU time on smaller capacity CPUs.

On an Arm big.LITTLE/DynamIQ system DL tasks can easily starve other
tasks making it unusable.

Fix this by explicitly considering the CPU capacity in the DL admission
test by replacing M with the root domain CPU capacity sum.

Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 23 +++++++++++------------
 kernel/sched/sched.h    |  7 +++++--
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..53b34a95e29e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2551,11 +2551,11 @@ void sched_dl_do_global(void)
 int sched_dl_overflow(struct task_struct *p, int policy,
 		      const struct sched_attr *attr)
 {
-	struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 	u64 period = attr->sched_period ?: attr->sched_deadline;
 	u64 runtime = attr->sched_runtime;
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
-	int cpus, err = -1;
+	int cpus, err = -1, cpu = task_cpu(p);
+	struct dl_bw *dl_b = dl_bw_of(cpu);
 
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return 0;
@@ -2570,15 +2570,15 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	 * allocated bandwidth of the container.
 	 */
 	raw_spin_lock(&dl_b->lock);
-	cpus = dl_bw_cpus(task_cpu(p));
+	cpus = dl_bw_cpus(cpu);
 	if (dl_policy(policy) && !task_has_dl_policy(p) &&
-	    !__dl_overflow(dl_b, cpus, 0, new_bw)) {
+	    !__dl_overflow(dl_b, cpu, 0, new_bw)) {
 		if (hrtimer_active(&p->dl.inactive_timer))
 			__dl_sub(dl_b, p->dl.dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 		err = 0;
 	} else if (dl_policy(policy) && task_has_dl_policy(p) &&
-		   !__dl_overflow(dl_b, cpus, p->dl.dl_bw, new_bw)) {
+		   !__dl_overflow(dl_b, cpu, p->dl.dl_bw, new_bw)) {
 		/*
 		 * XXX this is slightly incorrect: when the task
 		 * utilization decreases, we should delay the total
@@ -2715,18 +2715,17 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed)
 {
 	unsigned int dest_cpu;
+	unsigned long flags;
 	struct dl_bw *dl_b;
 	bool overflow;
-	int cpus, ret;
-	unsigned long flags;
+	int ret;
 
 	dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(dest_cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cpus = dl_bw_cpus(dest_cpu);
-	overflow = __dl_overflow(dl_b, cpus, 0, p->dl.dl_bw);
+	overflow = __dl_overflow(dl_b, dest_cpu, 0, p->dl.dl_bw);
 	if (overflow) {
 		ret = -EBUSY;
 	} else {
@@ -2736,6 +2735,8 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
 		 * We will free resources in the source root_domain
 		 * later on (see set_cpus_allowed_dl()).
 		 */
+		int cpus = dl_bw_cpus(dest_cpu);
+
 		__dl_add(dl_b, p->dl.dl_bw, cpus);
 		ret = 0;
 	}
@@ -2771,13 +2772,11 @@ bool dl_cpu_busy(unsigned int cpu)
 	unsigned long flags;
 	struct dl_bw *dl_b;
 	bool overflow;
-	int cpus;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cpus = dl_bw_cpus(cpu);
-	overflow = __dl_overflow(dl_b, cpus, 0, 0);
+	overflow = __dl_overflow(dl_b, cpu, 0, 0);
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 	rcu_read_unlock_sched();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91bd0cb0c529..6cbdf7a342a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -304,11 +304,14 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 	__dl_update(dl_b, -((s32)tsk_bw / cpus));
 }
 
+static inline unsigned long rd_capacity(int cpu);
+
 static inline
-bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
+bool __dl_overflow(struct dl_bw *dl_b, int cpu, u64 old_bw, u64 new_bw)
 {
 	return dl_b->bw != -1 &&
-	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
+	       cap_scale(dl_b->bw, rd_capacity(cpu)) <
+	       dl_b->total_bw - old_bw + new_bw;
 }
 
 extern void init_dl_bw(struct dl_bw *dl_b);
-- 
2.17.1

