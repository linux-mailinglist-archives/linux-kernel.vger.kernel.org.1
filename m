Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB22F521F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbhAMScg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:32:36 -0500
Received: from foss.arm.com ([217.140.110.172]:40390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbhAMScf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:32:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2A81FB;
        Wed, 13 Jan 2021 10:31:49 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EECBB3F66E;
        Wed, 13 Jan 2021 10:31:47 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, jiangshanlai@gmail.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: [PATCH] sched/core: Print out straggler tasks in sched_cpu_dying()
Date:   Wed, 13 Jan 2021 18:31:41 +0000
Message-Id: <20210113183141.11974-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit

  1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")

tasks are expected to move themselves out of a out-going CPU. For most
tasks this will be done automagically via BALANCE_PUSH, but percpu kthreads
will have to cooperate and move themselves away one way or another.

Currently, some percpu kthreads (workqueues being a notable exemple) do not
cooperate nicely and can end up on an out-going CPU at the time
sched_cpu_dying() is invoked.

Print the dying rq's tasks to shed some light on the stragglers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
As Peter pointed out, this should really be caught much earlier than
sched_cpu_dying().

If we go down the route of preventing kthreads from being affined to
!active CPUs in __set_cpus_allowed_ptr() (genuine percpu kthreads sidestep
it via kthread_bind_mask()), then I *think* we could catch this in wakeups,
i.e. select_task_rq(). I've been playing around there, but it's not as
straightforward as I'd have hoped.
---
 kernel/sched/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a08a39d7cdb..d784dd1ae436 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7564,6 +7564,25 @@ static void calc_load_migrate(struct rq *rq)
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
+static void dump_rq_tasks(struct rq *rq, const char *loglvl)
+{
+	struct task_struct *g, *p;
+	int cpu = cpu_of(rq);
+
+	lockdep_assert_held(&rq->lock);
+
+	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
+	for_each_process_thread(g, p) {
+		if (task_cpu(p) != cpu)
+			continue;
+
+		if (!task_on_rq_queued(p))
+			continue;
+
+		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
+	}
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7573,7 +7592,10 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
+	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
+		WARN(true, "Dying CPU not properly vacated!");
+		dump_rq_tasks(rq, KERN_WARNING);
+	}
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
-- 
2.27.0

