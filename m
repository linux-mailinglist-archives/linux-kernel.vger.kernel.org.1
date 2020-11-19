Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8A2B8A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKSDx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKSDx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:53:26 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCFC0613D4;
        Wed, 18 Nov 2020 19:53:25 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id i13so1014988oou.11;
        Wed, 18 Nov 2020 19:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G49A8pUTKl70GNsNFV/E59Bu/I/7VE4/sBdZY3Noomg=;
        b=r7vPMzh+Kj5zBfDxjISg7UqlITE+Q+QR5qPo8n1/mMWZZwPu6bihWnDPuB+MsRMoPz
         tVZHtpBVkqFel76pNl16DgJKNYL3Saf6frypmYNsbNfWwOtLG9/vCVFITq80SjVGzCQz
         R7KGRqUuPBCDWB9S0g5nZpL0aH1i75JWlAQ5MUlgCKgEueMRwXeKW/7AYHhqlBhGSFyM
         vcfqBGWykg6LhajCVzL3LqIWFQIAHtcnpLQzEy9JcC50SydB6vJ7ZWSIzNAh4FaYlEz+
         IeUrBwVgqL/R8m/LlMx6GWoTYcdFC5g6KWFAF+IE9ufznPW7yh+xdEhaeI0uwyA98rnf
         v0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G49A8pUTKl70GNsNFV/E59Bu/I/7VE4/sBdZY3Noomg=;
        b=FgI0uyiMVP2fRmpdf0oFx+vk5oJPUJ2Lq8kVItbPsbpT+ISB5MOU98Ux2BJNgfOs0o
         6xzqwzrh6ob3YravgrEx2YjIL6lkQ9RCy0cWD7xGERR2Y4/UEMz+0wVlM7jSfxOn29rW
         3AUTffQb/UQ/RPzHHc765vI1vsj44w4iPL1gz9LsQbI2LSefjp1HPT4swymZTJEwNT94
         9XpNQgE2CmCeWf/pJ/7MNwWnzC+cuBwENVXTl/o8C8TO2rJ0fmQgPSOWBucii8t4A4JF
         zNJ0qYLkircHjcq5tkvB1AjAP8k2aSkWRYt1YIhe/jgL7iNlLF2F81YIqyT8ILVe8GYk
         pqsw==
X-Gm-Message-State: AOAM5307zqBsPce5Y/ONzqUbz3jJoEKfdAg3n2ys6U6n83NcugxoT+bC
        DIRTwNHoS19Cq0LpPkwGniU=
X-Google-Smtp-Source: ABdhPJyd+JJbB049Gl3asvrmSeu+cnCu1DYmtBVopfHPnhBZlk0nQVc20dqEPtaoV7cRBNe5jDll9A==
X-Received: by 2002:a4a:8582:: with SMTP id t2mr8748471ooh.89.1605758005288;
        Wed, 18 Nov 2020 19:53:25 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id k20sm8320926ots.53.2020.11.18.19.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:53:24 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 4/4] sched, rt: support schedstat for RT sched class
Date:   Thu, 19 Nov 2020 11:52:30 +0800
Message-Id: <20201119035230.45330-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201119035230.45330-1-laoar.shao@gmail.com>
References: <20201119035230.45330-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstat facility, but currently schedstat is only
supported for fair sched class. This patch enable it for RT sched class
as well.

The schedstat statistics are define in struct sched_entity, which is a
member of struct task_struct, so we can resue it for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
		fair				RT
enqueue		update_stats_enqueue_fair	update_stats_enqueue_rt
dequeue		update_stats_dequeue_fair	update_stats_dequeue_rt
put_prev_task	update_stats_wait_start		update_stats_wait_start
set_next_task	update_stats_wait_end		update_stats_wait_end
show		/proc/[pid]/sched		/proc/[pid]/sched

The sched:sched_stats_* tracepoints can be used to trace RT tasks as
well.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/rt.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 63 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b9ec886702a1..a318236b7166 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1246,6 +1246,46 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	dec_rt_group(rt_se, rt_rq);
 }
 
+static inline void
+update_stats_enqueue_rt(struct rq *rq, struct sched_entity *se,
+			struct sched_rt_entity *rt_se, int flags)
+{
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_se != rt_rq->curr)
+		update_stats_wait_start(rq, se);
+
+	if (flags & ENQUEUE_WAKEUP)
+		update_stats_enqueue_sleeper(rq, se);
+}
+
+static inline void
+update_stats_dequeue_rt(struct rq *rq, struct sched_entity *se,
+			struct sched_rt_entity *rt_se, int flags)
+{
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (!schedstat_enabled())
+		return;
+
+	if (rt_se != rt_rq->curr)
+		update_stats_wait_end(rq, se);
+
+	if ((flags & DEQUEUE_SLEEP) && rt_entity_is_task(rt_se)) {
+		struct task_struct *tsk = rt_task_of(rt_se);
+
+		if (tsk->state & TASK_INTERRUPTIBLE)
+			__schedstat_set(se->statistics.sleep_start,
+					rq_clock(rq));
+		if (tsk->state & TASK_UNINTERRUPTIBLE)
+			__schedstat_set(se->statistics.block_start,
+					rq_clock(rq));
+	}
+}
+
 /*
  * Change rt_se->run_list location unless SAVE && !MOVE
  *
@@ -1275,6 +1315,7 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 	struct rt_prio_array *array = &rt_rq->active;
 	struct rt_rq *group_rq = group_rt_rq(rt_se);
 	struct list_head *queue = array->queue + rt_se_prio(rt_se);
+	struct task_struct *task = rt_task_of(rt_se);
 
 	/*
 	 * Don't enqueue the group if its throttled, or when empty.
@@ -1288,6 +1329,8 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 		return;
 	}
 
+	update_stats_enqueue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, flags);
+
 	if (move_entity(flags)) {
 		WARN_ON_ONCE(rt_se->on_list);
 		if (flags & ENQUEUE_HEAD)
@@ -1307,7 +1350,9 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 	struct rt_prio_array *array = &rt_rq->active;
+	struct task_struct *task = rt_task_of(rt_se);
 
+	update_stats_dequeue_rt(rq_of_rt_rq(rt_rq), &task->se, rt_se, flags);
 	if (move_entity(flags)) {
 		WARN_ON_ONCE(!rt_se->on_list);
 		__delist_rt_entity(rt_se, array);
@@ -1374,6 +1419,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
+	check_schedstat_required();
 	enqueue_rt_entity(rt_se, flags);
 
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
@@ -1574,6 +1620,12 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
+	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_end(rq, &p->se);
+
 	update_stats_curr_start(rq, &p->se);
 
 	/* The running task is never eligible for pushing */
@@ -1591,6 +1643,8 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
+
+	rt_rq->curr = rt_se;
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
@@ -1638,6 +1692,11 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
+	struct rt_rq *rt_rq = &rq->rt;
+
+	if (on_rt_rq(&p->rt))
+		update_stats_wait_start(rq, &p->se);
+
 	update_curr_rt(rq);
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
@@ -1648,6 +1707,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	rt_rq->curr = NULL;
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28986736ced9..7787afbd5723 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,6 +649,8 @@ struct rt_rq {
 	struct rq		*rq;
 	struct task_group	*tg;
 #endif
+
+	struct sched_rt_entity  *curr;
 };
 
 static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
-- 
2.18.4

