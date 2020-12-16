Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEFD2DBA38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLPEwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLPEwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:52:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED8C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:51:24 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id q4so6533156plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9MKGxDf4fEGjQy48PhswymjorV1NFgBgLKEDW88drDo=;
        b=BTgSrQMEClryEL6huJcb12mkV0uFSukmm3aqrsgdtWXfO7Bi9VmxNHq+tYbTLbjppt
         ZvJCtLKyuPCgBYdAcSH8RQk5mhuPk6/Df8H4+HkLfG9D2dZ/Fdt5motc9HXIAOLosEdp
         kv92i4iq8xg8Uo+MZkWOra9MdLGUWkSUsctJnD8qOVcqm+gvejL9A9QqbsEHfR+l03mJ
         ACHp9AppNeFZrNewAU80ZDKSsHQULTs6B8dClxzYNdZCYepk4Vt/A+oW6pTO/TcTIj4H
         P6aS/B1PnQ3CKlJTvYcXf1SqQ+9lBZT2lyAknB7HFpbdi36gKjwEqyB0kuteZADD3+1L
         n7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9MKGxDf4fEGjQy48PhswymjorV1NFgBgLKEDW88drDo=;
        b=Hjb34+o+jFzJHIK+pncxbQBZ7XMa65wqlfn5hL3ff2fsO418gO3Oq7KnYJt8+O6HW2
         N+2xNOm8JRgHaewqtrKXKhWUXphFjmR2wSPx5szOEAsUwMD+77wQouEN9vNB2pWM97Sd
         tKOSaZllBejpC8Xf8YcWctfoWHKGxyX8fjJ5mLt3Bypqto1OnAWLasD7Y4YXWe8KuAIO
         BWMJd8MFbk3Zgatz8HtszcXF6Y3eHzHnBnCVa9+Dx1h3kN61zXNaobpeJu8pPm0nfV3M
         v38KcAdtXXb2u9+mM/THdbFd+YSbRbfmGM0O/zkbunO8Z83GEzhHFrTIkY3UO1ut2BHG
         rO8g==
X-Gm-Message-State: AOAM533KmGqVuGHIbV6k63wzPKnu3hwYkdL1F/KOm9RAZlMy7DVgI6D5
        10QybLceKXn53xHbWbWXfgzDDkCY86EzwVDu
X-Google-Smtp-Source: ABdhPJxF7yzfhit/tlaMSY3Li6nfb3lLkBZvqrJ+qpcNVnUOyWecqQ324qBNRuLTI1JBbAkTZv4SYg==
X-Received: by 2002:a17:902:d705:b029:db:fbbf:6145 with SMTP id w5-20020a170902d705b02900dbfbbf6145mr2331531ply.7.1608094284266;
        Tue, 15 Dec 2020 20:51:24 -0800 (PST)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n1sm713123pfu.28.2020.12.15.20.50.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 20:51:23 -0800 (PST)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Xuewen.Yan@unisoc.com, Ke.Wang@unisoc.com, xuewyan@foxmail.com,
        zhang.lyra@gmail.com, patrick.bellasi@arm.com
Subject: [PATCH v2] fair/util_est: fix schedutil may use an old util_est.enqueued value at dequeue
Date:   Wed, 16 Dec 2020 12:50:23 +0800
Message-Id: <1608094223-22564-1-git-send-email-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

when a task dequeued, it would update it's util and cfs_rq's util,
the following calling relationship exists here:

update_load_avg() -> cfs_rq_util_change() -> cpufreq_update_util()->
sugov_update_[shared\|single] -> sugov_get_util() -> cpu_util_cfs();

util = max {rq->cfs.avg.util_avg,rq->cfs.avg.util_est.enqueued };

For those tasks alternate long and short runs scenarios, the
rq->cfs.avg.util_est.enqueued may be bigger than rq->cfs.avg.util_avg.
but because the _task_util_est(p) didn't be subtracted, this would
cause schedutil use an old util_est.enqueued value.

This could have an effect in task ramp-down and ramp-up scenarios.
when the task dequeued, we hope the freq could be reduced as soon
as possible. If the schedutil's value is the old util_est.enqueued, this
may cause the cpu couldn't reduce it's freq.

separate the util_est_dequeue() into util_est_dequeue() and
util_est_update(), and dequeue the _task_util_est(p) before update util.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

---
Changes since v1:
-change the util_est_dequeue/update to inline type
-use unsigned int enqueued rather than util_est in util_est_dequeue
-remove "cpu" var

---
 kernel/sched/fair.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba..864d6b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3945,22 +3945,31 @@ static inline bool within_margin(int value, int margin)
 	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
 }
 
-static void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
+static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
+				struct task_struct *p)
 {
-	long last_ewma_diff;
-	struct util_est ue;
-	int cpu;
+	unsigned int enqueued;
 
 	if (!sched_feat(UTIL_EST))
 		return;
 
 	/* Update root cfs_rq's estimated utilization */
-	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
-	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
+	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
+}
+
+static inline void util_est_update(struct cfs_rq *cfs_rq,
+				struct task_struct *p,
+				bool task_sleep)
+{
+	long last_ewma_diff;
+	struct util_est ue;
+
+	if (!sched_feat(UTIL_EST))
+		return;
 
 	/*
 	 * Skip update of task's estimated utilization when the task has not
@@ -4001,8 +4010,7 @@ static inline bool within_margin(int value, int margin)
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	cpu = cpu_of(rq_of(cfs_rq));
-	if (task_util(p) > capacity_orig_of(cpu))
+	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
@@ -4085,7 +4093,10 @@ static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
 util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 
 static inline void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+
+static inline void
+util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
 		 bool task_sleep) {}
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 
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

