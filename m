Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559B81B9A65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgD0Ihw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 04:37:52 -0400
Received: from foss.arm.com ([217.140.110.172]:59966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgD0Ihw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:37:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D6B11D4;
        Mon, 27 Apr 2020 01:37:51 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECBFF3F68F;
        Mon, 27 Apr 2020 01:37:47 -0700 (PDT)
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
Subject: [PATCH v2 5/6] sched/deadline: Make DL capacity-aware
Date:   Mon, 27 Apr 2020 10:37:08 +0200
Message-Id: <20200427083709.30262-6-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427083709.30262-1-dietmar.eggemann@arm.com>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Abeni <luca.abeni@santannapisa.it>

The current SCHED_DEADLINE (DL) scheduler uses a global EDF scheduling
algorithm w/o considering CPU capacity or task utilization.
This works well on homogeneous systems where DL tasks are guaranteed
to have a bounded tardiness but presents issues on heterogeneous
systems.

A DL task can migrate to a CPU which does not have enough CPU capacity
to correctly serve the task (e.g. a task w/ 70ms runtime and 100ms
period on a CPU w/ 512 capacity).

Add the DL fitness function dl_task_fits_capacity() for DL admission
control on heterogeneous systems. A task fits onto a CPU if:

    CPU original capacity / 1024 >= task runtime / task deadline

Use this function on heterogeneous systems to try to find a CPU which
meets this criterion during task wakeup, push and offline migration.

On homogeneous systems the original behavior of the DL admission
control should be retained.

Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpudeadline.c | 14 +++++++++++++-
 kernel/sched/deadline.c    | 18 ++++++++++++++----
 kernel/sched/sched.h       | 15 +++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 5cc4012572ec..8630f2a40a3f 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -121,7 +121,19 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 	if (later_mask &&
 	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
-		return 1;
+		int cpu;
+
+		if (!static_branch_unlikely(&sched_asym_cpucapacity))
+			return 1;
+
+		/* Ensure the capacity of the CPUs fits the task. */
+		for_each_cpu(cpu, later_mask) {
+			if (!dl_task_fits_capacity(p, cpu))
+				cpumask_clear_cpu(cpu, later_mask);
+		}
+
+		if (!cpumask_empty(later_mask))
+			return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 08ab28e1cefc..575b7d88d839 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1634,6 +1634,7 @@ static int
 select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	struct task_struct *curr;
+	bool select_rq;
 	struct rq *rq;
 
 	if (sd_flag != SD_BALANCE_WAKE)
@@ -1653,10 +1654,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	if (unlikely(dl_task(curr)) &&
-	    (curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
-	    (p->nr_cpus_allowed > 1)) {
+	select_rq = unlikely(dl_task(curr)) &&
+		    (curr->nr_cpus_allowed < 2 ||
+		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		    p->nr_cpus_allowed > 1;
+
+	/*
+	 * Take the capacity of the CPU into account to
+	 * ensure it fits the requirement of the task.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity))
+		select_rq |= !dl_task_fits_capacity(p, cpu);
+
+	if (select_rq) {
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 511edacc2282..ec0efd99497b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -317,6 +317,21 @@ static inline bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap,
 	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
 }
 
+/*
+ * Verify the fitness of task @p to run on @cpu taking into account the
+ * CPU original capacity and the runtime/deadline ratio of the task.
+ *
+ * The function will return true if the CPU original capacity of the
+ * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
+ * task and false otherwise.
+ */
+static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	unsigned long cap = arch_scale_cpu_capacity(cpu);
+
+	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
+}
+
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
-- 
2.17.1

