Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E12B7243
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgKQXVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgKQXUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:54 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 199so22751236qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Val4g4szeO8BWpYu1K6Y9caooemc5+OLmyPVnA2BwYE=;
        b=ZiWzOmHIt1KR6cu3fzkml/u3djKwFwHoSz5erjJkbH16MIccYseThmbVfygyh+GpB1
         Jdblr63unG2N4sRhKL8xFvOs4c7VEk1f0Irtkg4Wm9hX3b8hA6zOkhZxIxLyAv8Jh9g6
         0cY4Q/nxtXE0DhGobvUGhrDxLsSPfFk2OpErg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Val4g4szeO8BWpYu1K6Y9caooemc5+OLmyPVnA2BwYE=;
        b=TNgY4JCExhEPvKET1WbI1Q4ONEH5KjVeTop+5kOo4nPKsXbVrtXUqa8f1XyOp5cW0/
         iTM4bxOYQbhXG8A9oXSK9z/AqURM2lXOilHV5lIxKFm3NKXJyo32MGUknzNF7gxlMoCB
         0boMxvVXx9i1HXSsDS4eB3FnEe+GaVLvwrXit1q4zHfAnPjMUL0OGhlskL15nDZZ6CNm
         IC2WND51Wp1RmhN+KT9YLkD3M6nf0NvScg5MhZkKp/mXSF9rDlkiy5lCJPMc3qBBAVg5
         7t2EH4cV6XgWfbBj3Qt8zqW/A05iPYjoMvodiLoIkvVT9m8VhRRisgNoXfry/Hp8rQ3J
         CaXA==
X-Gm-Message-State: AOAM531l05dqgnTrCcHc6fe44XpEi75D4VKrr39CdnxhSa6OALolL60r
        J6f1ajKjBPC782WY1WPJyqoD+Q==
X-Google-Smtp-Source: ABdhPJxEvDLR2e5VT2eoFnxzysjmuVxR39f/xXr5fxXXy6HZyNROfFwbQ0RhGYVj3m58xZm6DObvUg==
X-Received: by 2002:a37:e20d:: with SMTP id g13mr2091023qki.325.1605655253524;
        Tue, 17 Nov 2020 15:20:53 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:52 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 21/32] sched: CGroup tagging interface for core scheduling
Date:   Tue, 17 Nov 2020 18:19:51 -0500
Message-Id: <20201117232003.3580179-22-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Marks all tasks in a cgroup as matching for core-scheduling.

A task will need to be moved into the core scheduler queue when the cgroup
it belongs to is tagged to run with core scheduling.  Similarly the task
will need to be moved out of the core scheduler queue when the cgroup
is untagged.

Also after we forked a task, its core scheduler queue's presence will
need to be updated according to its new cgroup's status.

Use stop machine mechanism to update all tasks in a cgroup to prevent a
new task from sneaking into the cgroup, and missed out from the update
while we iterates through all the tasks in the cgroup.  A more complicated
scheme could probably avoid the stop machine.  Such scheme will also
need to resovle inconsistency between a task's cgroup core scheduling
tag and residency in core scheduler queue.

We are opting for the simple stop machine mechanism for now that avoids
such complications.

Core scheduler has extra overhead.  Enable it only for core with
more than one SMT hardware threads.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 183 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |   4 +
 2 files changed, 181 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f807a84cc30..b99a7493d590 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -157,6 +157,37 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 	return false;
 }
 
+static bool sched_core_empty(struct rq *rq)
+{
+	return RB_EMPTY_ROOT(&rq->core_tree);
+}
+
+static bool sched_core_enqueued(struct task_struct *task)
+{
+	return !RB_EMPTY_NODE(&task->core_node);
+}
+
+static struct task_struct *sched_core_first(struct rq *rq)
+{
+	struct task_struct *task;
+
+	task = container_of(rb_first(&rq->core_tree), struct task_struct, core_node);
+	return task;
+}
+
+static void sched_core_flush(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *task;
+
+	while (!sched_core_empty(rq)) {
+		task = sched_core_first(rq);
+		rb_erase(&task->core_node, &rq->core_tree);
+		RB_CLEAR_NODE(&task->core_node);
+	}
+	rq->core->core_task_seq++;
+}
+
 static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
@@ -188,10 +219,11 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
@@ -255,8 +287,24 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
-		cpu_rq(cpu)->core_enabled = enabled;
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		WARN_ON_ONCE(enabled == rq->core_enabled);
+
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
+			/*
+			 * All active and migrating tasks will have already
+			 * been removed from core queue when we clear the
+			 * cgroup tags. However, dying tasks could still be
+			 * left in core queue. Flush them here.
+			 */
+			if (!enabled)
+				sched_core_flush(cpu);
+
+			rq->core_enabled = enabled;
+		}
+	}
 
 	return 0;
 }
@@ -266,7 +314,11 @@ static int sched_core_count;
 
 static void __sched_core_enable(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
+
+	/* verify there are no cookie tasks (yet) */
+	for_each_online_cpu(cpu)
+		BUG_ON(!sched_core_empty(cpu_rq(cpu)));
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
@@ -274,8 +326,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -300,6 +350,7 @@ void sched_core_put(void)
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static bool sched_core_enqueued(struct task_struct *task) { return false; }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -3978,6 +4029,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
 #endif
 	return 0;
 }
@@ -7979,6 +8033,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -8995,6 +9052,15 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
+
+#ifdef CONFIG_SCHED_CORE
+	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
+		tsk->core_cookie = 0UL;
+
+	if (tg->tagged /* && !tsk->core_cookie ? */)
+		tsk->core_cookie = (unsigned long)tg;
+#endif
+
 	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -9087,6 +9153,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_SCHED_CORE
+	struct task_group *tg = css_tg(css);
+
+	if (tg->tagged) {
+		sched_core_put();
+		tg->tagged = 0;
+	}
+#endif
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -9652,6 +9730,82 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_SCHED_CORE
+static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return !!tg->tagged;
+}
+
+struct write_core_tag {
+	struct cgroup_subsys_state *css;
+	int val;
+};
+
+static int __sched_write_tag(void *data)
+{
+	struct write_core_tag *tag = (struct write_core_tag *) data;
+	struct cgroup_subsys_state *css = tag->css;
+	int val = tag->val;
+	struct task_group *tg = css_tg(tag->css);
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	tg->tagged = !!val;
+
+	css_task_iter_start(css, 0, &it);
+	/*
+	 * Note: css_task_iter_next will skip dying tasks.
+	 * There could still be dying tasks left in the core queue
+	 * when we set cgroup tag to 0 when the loop is done below.
+	 */
+	while ((p = css_task_iter_next(&it))) {
+		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
+
+		if (sched_core_enqueued(p)) {
+			sched_core_dequeue(task_rq(p), p);
+			if (!p->core_cookie)
+				continue;
+		}
+
+		if (sched_core_enabled(task_rq(p)) &&
+		    p->core_cookie && task_on_rq_queued(p))
+			sched_core_enqueue(task_rq(p), p);
+
+	}
+	css_task_iter_end(&it);
+
+	return 0;
+}
+
+static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct write_core_tag wtag;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	if (tg->tagged == !!val)
+		return 0;
+
+	if (!!val)
+		sched_core_get();
+
+	wtag.css = css;
+	wtag.val = val;
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
+	if (!val)
+		sched_core_put();
+
+	return 0;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -9688,6 +9842,14 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -9861,6 +10023,14 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
@@ -9889,6 +10059,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be6691337bbb..3ba08973ed58 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -377,6 +377,10 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_SCHED_CORE
+	int			tagged;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
-- 
2.29.2.299.gdc1121823c-goog

