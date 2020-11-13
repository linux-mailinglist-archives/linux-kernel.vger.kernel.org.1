Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69F2B19FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKMLYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:24:43 -0500
Received: from foss.arm.com ([217.140.110.172]:36446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgKMLY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:24:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5479E1042;
        Fri, 13 Nov 2020 03:24:26 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED82C3F6CF;
        Fri, 13 Nov 2020 03:24:23 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@redhat.com>, bigeasy@linutronix.de,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, mgorman@suse.de, mingo@kernel.org,
        ouwen210@hotmail.com, peterz@infradead.org, qais.yousef@arm.com,
        rostedt@goodmis.org, swood@redhat.com, tglx@linutronix.de,
        tj@kernel.org, vincent.donnefort@arm.com,
        vincent.guittot@linaro.org
Subject: [PATCH] sched/core: Add missing completion for affine_move_task() waiters
Date:   Fri, 13 Nov 2020 11:24:14 +0000
Message-Id: <20201113112414.2569-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian reported that some fuzzer issuing sched_setaffinity() ends up stuck on
a wait_for_completion(). The problematic pattern seems to be:

  affine_move_task()
      // task_running() case
      stop_one_cpu();
      wait_for_completion(&pending->done);

Combined with, on the stopper side:

  migration_cpu_stop()
    // Task moved between unlocks and scheduling the stopper
    task_rq(p) != rq &&
    // task_running() case
    dest_cpu >= 0

    => no complete_all()

This can happen with both PREEMPT and !PREEMPT, although !PREEMPT should
be more likely to see this given the targeted task has a much bigger window
to block and be woken up elsewhere before the stopper runs.

Make migration_cpu_stop() always look at pending affinity requests; signal
their completion if the stopper hits a rq mismatch but the task is
still within its allowed mask. When Migrate-Disable isn't involved, this
matches the previous set_cpus_allowed_ptr() vs migration_cpu_stop()
behaviour.

Link: https://lore.kernel.org/lkml/8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com
Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02076e6d3792..fad0a8e62aca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1923,7 +1923,7 @@ static int migration_cpu_stop(void *data)
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0) {
+	} else if (dest_cpu < 0 || pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -1933,6 +1933,17 @@ static int migration_cpu_stop(void *data)
 		 * more likely.
 		 */
 
+		/*
+		 * The task moved before the stopper got to run. We're holding
+		 * ->pi_lock, so the allowed mask is stable - if it got
+		 * somewhere allowed, we're done.
+		 */
+		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			p->migration_pending = NULL;
+			complete = true;
+			goto out;
+		}
+
 		/*
 		 * When this was migrate_enable() but we no longer have an
 		 * @pending, a concurrent SCA 'fixed' things and we should be
-- 
2.27.0

