Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3542DE066
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbgLRJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733133AbgLRJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:28:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776FC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 01:28:13 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so969236pgj.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AyR7D2VD8ei5zy4f2zSlytBUtG4hQYrp7RXsr2FqVB0=;
        b=L9NdZ3vxToQ7UjSgW3+QpzA12QkwO3nKGtI7d3YTEX85IjnwP1KY3CKe/prgwPf8r/
         iQLe0Ihx8TWJ1dsR4PSXM+k7xr2AjHHbpKdcdF92YBIai+FefHowLb1DnHwnNXaltU6Z
         whUyP8Oj07b+y5to0dt8nhiFbrRh/tNmjHDTNAuePIJsD6L/Co2fpdZ/DaA8WW0F66nX
         RbRCjgw4KmTrD4Uflz/Rf6WKHb8wrhumPaPTPpp5O6XAAMve8wyH7w5OyejVcKDjkSXJ
         CFk3uzKwaX1ri0sUU0oK4U5KclliGXdahe3R/TqBEB+ky0zY06ZlfwgJJjyHWFtGbFYb
         jMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AyR7D2VD8ei5zy4f2zSlytBUtG4hQYrp7RXsr2FqVB0=;
        b=nIP/aBcpzelYSE0sNwsYMjhfQ5ryPKjSpMIfafE0ELXXzZpHpsIg/XyGbLvuEOgyeV
         9nWZKXDoLZ53DtJxHw380ITorJuxl9M2o3Am0/RERzjU5FCVNIbwXIWyXuDMa9c9fWPm
         NqdLISza/QvQx+t0VbH3SYQ9LXOAj8+Oyb0qTXDE2V53+qLzyKpIYEiD8QoKKwLRkyLx
         TAlLWJSwiajRrJQACr585lWh1pGHeNTblXXI3FNCv/RFA+9me8heww7qH68ZyZ1V5jeY
         QML8JNyg1O1BGIAK0ikUihHhVW1wHPaGKlhTYUfrv9bb9WeLt6cutN6j5b+1IHbknDY2
         tb5w==
X-Gm-Message-State: AOAM533YvVGCZfZRdJ/GjfZ5FcSz5Nf1qExuZh9p+gsJrHRNIN66Y2Ny
        2ov+fymMtPAnvDsv660cxfo=
X-Google-Smtp-Source: ABdhPJxrEEPL5b5mu3aaiHLpsnFO7S3me7VUnMCZgo1lBURSOWUoHLeBo/qybW3UkXi3d+J5d24EuA==
X-Received: by 2002:a63:1a58:: with SMTP id a24mr3359843pgm.118.1608283692644;
        Fri, 18 Dec 2020 01:28:12 -0800 (PST)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z23sm7950766pfn.202.2020.12.18.01.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 01:28:11 -0800 (PST)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, zhang.lyra@gmail.com, Ke.Wang@unisoc.com,
        xuewyan@foxmail.com, Xuewen.Yan@unisoc.com
Subject: [PATCH v3] sched/fair: Avoid stale CPU util_est value for schedutil in task dequeue
Date:   Fri, 18 Dec 2020 17:27:52 +0800
Message-Id: <1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com>
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

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
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

