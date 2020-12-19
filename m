Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35912DECB9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 03:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgLSCV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 21:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLSCV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 21:21:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53823C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 18:21:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z12so2313847pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 18:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9OlKLUPxbpdOAtdhQ3EN4IQYNMbfJ+OhuNX6mqjhDbM=;
        b=nMqSzEugt3TYFKTTCvDMFFqJQfEAMQS6JPO9HJG+FkfLgTFhbs6msTXSFa5PV9mN6V
         k6rlQRx9dbjl2z/17rAXu1GV1I04GcK3Pi1CMbwuA9JRWgTWpqnHSab2nZ3qvgJ88rBz
         cPoGDeFpQUsA5iWZPKmUL5hNVqzvI2pArpqPa6RH/V2s+lmcsW6+HuAK0TjRNXBbKdpo
         HnKDVJY/gw/xTF+j+la2PE8T4XT+XEuyxpP7XaxINcswNtp+vgcyYVY+xuQY05ga6iY8
         SjNtS5TPp08g57H2Y943QJ9xjHlhr/FLsZY4CGz1Gj8X8a3AOqxlrs/YJeGWyn3g8LMl
         bxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9OlKLUPxbpdOAtdhQ3EN4IQYNMbfJ+OhuNX6mqjhDbM=;
        b=Xqw3lySmjC0y6/gqvrAygOsrgldkq8tYCoKXLhOjXoyKXSX9nVYpgRKHMfcu3iTXyq
         +X48t1CuPgSyFv7yNfYJ1F1T5CDTb5tWYo16Cy8qEzLk1lvuy7zgQ2nvRv6IAFeQKLA+
         c7GkFDRF8mP29bymNA2NyfH17bw0TscLZ0Hcz7/fbKMfXoJlgQXwI1f2NRZR4MyGpr1l
         yQIkjyB2EjTzn5TimslNxPjX2/Q1nw9hk6j/znLxWQum9SHUXsHAac+vBiyOk8KHt8rM
         HA53waozWrOkeN2NSnl8tbRndxOalm3g4SdbrBWkShTs1Q97WB5uO7n75vDaZg0mad35
         FLCw==
X-Gm-Message-State: AOAM533zcUlNf3yD8CeYddoD+GXgCc9EXaU+ZKcNIkU3MS/FbSAoYvnk
        fU0h5hCxsZoF4/Vqr7Nl7yE=
X-Google-Smtp-Source: ABdhPJwQJ05j0HIYoldfSELqaooFZybPsxMU+efj5NEIzrKOE1NvcgfUGsi9OjtFXXOij9Wel4euwg==
X-Received: by 2002:a17:90a:658c:: with SMTP id k12mr6996091pjj.31.1608344471343;
        Fri, 18 Dec 2020 18:21:11 -0800 (PST)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n195sm10268505pfd.169.2020.12.18.18.21.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 18:21:10 -0800 (PST)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, zhang.lyra@gmail.com, Ke.Wang@unisoc.com,
        xuewyan@foxmail.com, Xuewen.Yan@unisoc.com
Subject: [PATCH v4] sched/fair: Avoid stale CPU util_est value for schedutil in task dequeue
Date:   Sat, 19 Dec 2020 10:20:49 +0800
Message-Id: <1608344449-3149-1-git-send-email-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

CPU (root cfs_rq) estimated utilization (util_est) is currently used in
dequeue_task_fair() to drive frequency selection before it is updated.

with:

CPU_util        : rq->cfs.avg.util_avg
CPU_util_est    : rq->cfs.avg.util_est
CPU_utilization : max(CPU_util, CPU_util_est)
task_util       : p->se.avg.util_avg
task_util_est   : p->se.avg.util_est

dequeue_task_fair():

    /* (1) CPU_util and task_util update + inform schedutil about
           CPU_utilization changes */
    for_each_sched_entity() /* 2 loops */
        (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
         -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]
         -> sugov_get_util() -> cpu_util_cfs()

    /* (2) CPU_util_est and task_util_est update */
    util_est_dequeue()

cpu_util_cfs() uses CPU_utilization which could lead to a false (too
high) utilization value for schedutil in task ramp-down or ramp-up
scenarios during task dequeue.

To mitigate the issue split the util_est update (2) into:

 (A) CPU_util_est update in util_est_dequeue()
 (B) task_util_est update in util_est_update()

Place (A) before (1) and keep (B) where (2) is. The latter is necessary
since (B) relies on task_util update in (1).

Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
Change since v3:
-add reviewer
-add more comment details

Changes since v2:
-modify the comment
-move util_est_dequeue above within_margin()
-modify the tab and space

Changes since v1:
-change the util_est_dequeue/update to inline type
-use unsigned int enqueued rather than util_est in util_est_dequeue
-remove "cpu" var

---
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba..f3a1b7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3932,6 +3932,22 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
+static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
+				    struct task_struct *p)
+{
+	unsigned int enqueued;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/* Update root cfs_rq's estimated utilization */
+	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+
+	trace_sched_util_est_cfs_tp(cfs_rq);
+}
+
 /*
  * Check if a (signed) value is within a specified (unsigned) margin,
  * based on the observation that:
@@ -3945,23 +3961,16 @@ static inline bool within_margin(int value, int margin)
 	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
 }
 
-static void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
+static inline void util_est_update(struct cfs_rq *cfs_rq,
+				   struct task_struct *p,
+				   bool task_sleep)
 {
 	long last_ewma_diff;
 	struct util_est ue;
-	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/* Update root cfs_rq's estimated utilization */
-	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
-	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
-
-	trace_sched_util_est_cfs_tp(cfs_rq);
-
 	/*
 	 * Skip update of task's estimated utilization when the task has not
 	 * yet completed an activation, e.g. being migrated.
@@ -4001,8 +4010,7 @@ static inline bool within_margin(int value, int margin)
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	cpu = cpu_of(rq_of(cfs_rq));
-	if (task_util(p) > capacity_orig_of(cpu))
+	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
@@ -4085,8 +4093,11 @@ static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 
 static inline void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
-		 bool task_sleep) {}
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+
+static inline void
+util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
+		bool task_sleep) {}
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
 #endif /* CONFIG_SMP */
@@ -5589,6 +5600,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 
+	util_est_dequeue(&rq->cfs, p);
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
@@ -5639,7 +5652,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
-	util_est_dequeue(&rq->cfs, p, task_sleep);
+	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
 
-- 
1.9.1

