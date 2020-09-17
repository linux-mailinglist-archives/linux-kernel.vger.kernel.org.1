Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A81326D9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgIQKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIQKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:48:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D1C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:48:52 -0700 (PDT)
Message-Id: <20200917101624.416032757@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600339725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0Zj47Q0eEcB8xzIztqP6kQ504BZWNUsY26aT75T466E=;
        b=t4p/Um5izUcL3XLWiil0+a6PALEUpqfIcdPqu9IlbkOKN7MIuZzt0ryAnuzk6v//iOWpU0
        RNCj4aq1nY9RgsJEWZF9jM/QsLinDAy3foQwE9rL/9aMNyJrZRuhaSQtsh0qhe44T2sl+q
        3qjXeFM+6AgWflzg6UcHwjixoTeYB233BTeA5kbLjZVcly+4q/dOrI75p4c1hcHAcW8i/p
        A/1bwx7YBR4Z9xwRJivnOqw/s+9wY2bc8XJ8LP2N2hIpDh5Y+sV4vxA9DsGweK++qK5Y51
        asbOuvq9NjPTpoFC8DEnMkh7+q4W+s+MzsACu0i3w4S3vLlw8kdCIGdcWwhIHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600339725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0Zj47Q0eEcB8xzIztqP6kQ504BZWNUsY26aT75T466E=;
        b=93lQckA8MoDoB/XfCryk0FifLndYtwF3tEm2bsMUCZ2UxZtqGQrUSTISp+amlcpRo0CTeN
        azEjYmZL2r9vaYCA==
Date:   Thu, 17 Sep 2020 11:42:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [patch 05/10] sched/core: Split __set_cpus_allowed_ptr()
References: <20200917094202.301694311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the function so the actual work part can be reused and called from
places which hold rq::lock already.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   64 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1863,34 +1863,17 @@ void do_set_cpus_allowed(struct task_str
 		set_next_task(rq, p);
 }
 
-/*
- * Change a given task's CPU affinity. Migrate the thread to a
- * proper CPU and schedule it away if the CPU it's executing on
- * is removed from the allowed bitmask.
- *
- * NOTE: the caller must have a valid reference to the task, the
- * task must not exit() & deallocate itself prematurely. The
- * call is not atomic; no spinlocks may be held.
- */
-static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+static int set_cpus_allowed_ptr_locked(struct task_struct *p,
+				       const struct cpumask *new_mask,
+				       bool check,
+				       struct rq *rq, struct rq_flags *rf)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
-	struct rq_flags rf;
-	struct rq *rq;
 	int ret = 0;
 
-	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD) {
-		/*
-		 * Kernel threads are allowed on online && !active CPUs
-		 */
-		cpu_valid_mask = cpu_online_mask;
-	}
-
 	/*
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
@@ -1900,8 +1883,12 @@ static int __set_cpus_allowed_ptr(struct
 		goto out;
 	}
 
-	if (cpumask_equal(&p->cpus_mask, new_mask))
-		goto out;
+	if (p->flags & PF_KTHREAD) {
+		/*
+		 * Kernel threads are allowed on online && !active CPUs
+		 */
+		cpu_valid_mask = cpu_online_mask;
+	}
 
 	/*
 	 * Picking a ~random cpu helps in cases where we are changing affinity
@@ -1933,7 +1920,7 @@ static int __set_cpus_allowed_ptr(struct
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
+		task_rq_unlock(rq, p, rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 		return 0;
 	} else if (task_on_rq_queued(p)) {
@@ -1941,10 +1928,35 @@ static int __set_cpus_allowed_ptr(struct
 		 * OK, since we're going to drop the lock immediately
 		 * afterwards anyway.
 		 */
-		rq = move_queued_task(rq, &rf, p, dest_cpu);
+		rq = move_queued_task(rq, rf, p, dest_cpu);
 	}
 out:
-	task_rq_unlock(rq, p, &rf);
+	task_rq_unlock(rq, p, rf);
+	return ret;
+}
+
+/*
+ * Change a given task's CPU affinity. Migrate the thread to a
+ * proper CPU and schedule it away if the CPU it's executing on
+ * is removed from the allowed bitmask.
+ *
+ * NOTE: the caller must have a valid reference to the task, the
+ * task must not exit() & deallocate itself prematurely. The
+ * call is not atomic; no spinlocks may be held.
+ */
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask, bool check)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+	int ret = 0;
+
+	rq = task_rq_lock(p, &rf);
+
+	if (cpumask_equal(&p->cpus_mask, new_mask))
+		task_rq_unlock(rq, p, &rf);
+	else
+		ret = set_cpus_allowed_ptr_locked(p, new_mask, check, rq, &rf);
 
 	return ret;
 }

