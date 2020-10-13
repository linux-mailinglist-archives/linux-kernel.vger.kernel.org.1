Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1128CFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgJMOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:01:35 -0400
Received: from foss.arm.com ([217.140.110.172]:60414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgJMOBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:01:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 249D6106F;
        Tue, 13 Oct 2020 07:01:33 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F6AC3F66B;
        Tue, 13 Oct 2020 07:01:30 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH 2/2] sched: Comment affine_move_task()
Date:   Tue, 13 Oct 2020 15:01:16 +0100
Message-Id: <20201013140116.26651-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005145717.346020688@infradead.org>
References: <20201005145717.346020688@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 81 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f4e38819de1..8cf74ba49d61 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2032,7 +2032,75 @@ struct set_affinity_pending {
 };
 
 /*
- * This function is wildly self concurrent, consider at least 3 times.
+ * This function is wildly self concurrent; here be dragons.
+ *
+ *
+ * When given a valid mask, __set_cpus_allowed_ptr() must block until the
+ * designated task is enqueued on an allowed CPU. If that task is currently
+ * running, we have to kick it out using the CPU stopper.
+ *
+ * Migrate-Disable comes along and tramples all over our nice sandcastle.
+ * Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *
+ * P1 *cannot* return from this set_cpus_allowed_ptr() call until P0 executes
+ * its outermost migrate_enable() (i.e. it exits its Migrate-Disable region).
+ * This means we need the following scheme:
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *                                <blocks>
+ *     <resumes>
+ *     migrate_enable();
+ *       __set_cpus_allowed_ptr();
+ *       <wakes local stopper>
+ *                         `--> <woken on migration completion>
+ *
+ * Now the fun stuff: there may be several P1-like tasks, i.e. multiple
+ * concurrent set_cpus_allowed_ptr(P0, [*]) calls. CPU affinity changes of any
+ * task p are serialized by p->pi_lock, which we can leverage: the one that
+ * should come into effect at the end of the Migrate-Disable region is the last
+ * one. This means we only need to track a single cpumask (i.e. p->cpus_mask),
+ * but we still need to properly signal those waiting tasks at the appropriate
+ * moment.
+ *
+ * This is implemented using struct set_affinity_pending. The first
+ * __set_cpus_allowed_ptr() caller within a given Migrate-Disable region will
+ * setup an instance of that struct and install it on the targeted task_struct.
+ * Any and all further callers will reuse that instance. Those then wait for
+ * a completion signaled at the tail of the CPU stopper callback (1), triggered
+ * on the end of the Migrate-Disable region (i.e. outermost migrate_enable()).
+ *
+ *
+ * (1) In the cases covered above. There is one more where the completion is
+ * signaled within affine_move_task() itself: when a subsequent affinity request
+ * cancels the need for an active migration. Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0            P1                             P2
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                        set_cpus_allowed_ptr(P0, [1]);
+ *                          <blocks>
+ *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
+ *                                                         <signal completion>
+ *                          <awakes>
+ *
+ * Note that the above is safe vs a concurrent migrate_enable(), as any
+ * pending affinity completion is preceded an uninstallion of
+ * p->migration_pending done with p->pi_lock held.
  */
 static int affine_move_task(struct rq *rq, struct rq_flags *rf,
 			    struct task_struct *p, int dest_cpu, unsigned int flags)
@@ -2075,6 +2143,7 @@ static int affine_move_task(struct rq *rq, struct rq_flags *rf,
 	if (!(flags & SCA_MIGRATE_ENABLE)) {
 		/* serialized by p->pi_lock */
 		if (!p->migration_pending) {
+			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
 			p->migration_pending = &my_pending;
@@ -2113,7 +2182,11 @@ static int affine_move_task(struct rq *rq, struct rq_flags *rf,
 	}
 
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
-
+		/*
+		 * Lessen races (and headaches) by delegating
+		 * is_migration_disabled(p) checks to the stopper, which will
+		 * run on the same CPU as said p.
+		 */
 		task_rq_unlock(rq, p, rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 
@@ -2138,6 +2211,10 @@ static int affine_move_task(struct rq *rq, struct rq_flags *rf,
 	if (refcount_dec_and_test(&pending->refs))
 		wake_up_var(&pending->refs);
 
+	/*
+	 * Block the original owner of &pending until all subsequent callers
+	 * have seen the completion and decremented the refcount
+	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
 	return 0;
-- 
2.27.0

