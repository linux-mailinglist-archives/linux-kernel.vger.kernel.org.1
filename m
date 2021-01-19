Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90A2FB42F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbhASIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:37:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731279AbhASIgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:36:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C5031B;
        Tue, 19 Jan 2021 00:35:55 -0800 (PST)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67B5D3F66E;
        Tue, 19 Jan 2021 00:35:53 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] sched/deadline: Reduce rq lock contention in dl_add_task_root_domain()
Date:   Tue, 19 Jan 2021 09:35:42 +0100
Message-Id: <20210119083542.19856-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dl_add_task_root_domain() is called during sched domain rebuild:

  rebuild_sched_domains_locked()
    partition_and_rebuild_sched_domains()
      rebuild_root_domains()
         for all top_cpuset descendants:
           update_tasks_root_domain()
             for all tasks of cpuset:
               dl_add_task_root_domain()

Change it so that only the task pi lock is taken to check if the task
has a SCHED_DEADLINE (DL) policy. In case that p is a DL task take the
rq lock as well to be able to safely de-reference root domain's DL
bandwidth structure.

Most of the tasks will have another policy (namely SCHED_NORMAL) and
can now bail without taking the rq lock.

One thing to note here: Even in case that there aren't any DL user
tasks, a slow frequency switching system with cpufreq gov schedutil has
a DL task (sugov) per frequency domain running which participates in DL
bandwidth management.

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

The use case in which this makes a noticeable difference is Android's
'CPU pause' power management feature.

It uses CPU hotplug control to clear a CPU from active state to force
all threads which are not per-cpu kthreads away from this CPU.

Making DL bandwidth management faster during sched domain rebuild helps
to reduce the time to pause/un-pause a CPU.

 kernel/sched/deadline.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5421782fe897..c7b1a63a053b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2409,9 +2409,13 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq *rq;
 	struct dl_bw *dl_b;
 
-	rq = task_rq_lock(p, &rf);
-	if (!dl_task(p))
-		goto unlock;
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
+	if (!dl_task(p)) {
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
+		return;
+	}
+
+	rq = __task_rq_lock(p, &rf);
 
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
@@ -2420,7 +2424,6 @@ void dl_add_task_root_domain(struct task_struct *p)
 
 	raw_spin_unlock(&dl_b->lock);
 
-unlock:
 	task_rq_unlock(rq, p, &rf);
 }
 
-- 
2.25.1

