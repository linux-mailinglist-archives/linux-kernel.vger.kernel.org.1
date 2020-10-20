Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A430F2932D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgJTBpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390344AbgJTBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:58 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F37C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:58 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so530782iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khwI5T0sR74rg77SQY3S5Zd4N1VQgIKXKai9LHpcVIA=;
        b=P0okIhsqAFamV1fQjWG+r7mueWxUtS0pLxMqoICM4poS2N8SZtWyETH5Rp0i+P2oG9
         2ix7yxj/m4m3xtn6QQ0NNVl28h3ACWSRNIzVYspAWtmEQ+p56s8c+DWJETUERl7IVu7o
         7wtSXaHd0GjzbT+G07cAKUDsNec4a4cRlcVmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khwI5T0sR74rg77SQY3S5Zd4N1VQgIKXKai9LHpcVIA=;
        b=GAxTQgKfyn0EJG6BCPzfBZIrG5FY+2ACzuZux2PPGOpIMuOZQEDP8BUPIYIVFxZM0y
         D1lnLSTVcpDTQN5P2iKa4SlIBiyYKhOtAYMAU5oW5N/FSelpwGISnb5tHe69CLxpYXjR
         ibT/I8brYvAW9ZJErXucXgIbDZKDvvFnuxGV/d7h1wORrKMylearLYOxmEil6pb6AJH6
         JUow7Wo5RZ8nrw/ZGpO75kr41Hmt5JY8fYBcxl3slKNG+HOI4DW0UccZbaTgvUPvEBAw
         3qPrknASuQ05Jup3RR2+L80vAGgTFvyv9zeKFq+eqHg9V08g5HLBwos9OH9q8Ssxp2Kt
         koVg==
X-Gm-Message-State: AOAM530wAZIFj/3FOrs2T6LqH9bZmUpd0qRav/f6SqVJLxbB0ltSM6In
        KCMObHRrnXyCxno2J6cJ94VP2w==
X-Google-Smtp-Source: ABdhPJwXueoT01K6qS9PwooZNs4fU4d1TZZyKYV3MuLxBlkSBfRhI0BQlNEiCmfycgoA8ZQsvVRD4g==
X-Received: by 2002:a02:3b54:: with SMTP id i20mr441964jaf.94.1603158297259;
        Mon, 19 Oct 2020 18:44:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:56 -0700 (PDT)
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 24/26] sched: Move core-scheduler interfacing code to a new file
Date:   Mon, 19 Oct 2020 21:43:34 -0400
Message-Id: <20201020014336.2076526-25-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core.c is already huge. The core-tagging interface code is largely
independent of it. Move it to its own file to make both files easier to
maintain.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/Makefile  |   1 +
 kernel/sched/core.c    | 481 +----------------------------------------
 kernel/sched/coretag.c | 468 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  56 ++++-
 4 files changed, 523 insertions(+), 483 deletions(-)
 create mode 100644 kernel/sched/coretag.c

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 5fc9c9b70862..c526c20adf9d 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
+obj-$(CONFIG_SCHED_CORE) += coretag.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b3afbba5abe1..211e0784675f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -162,11 +162,6 @@ static bool sched_core_empty(struct rq *rq)
 	return RB_EMPTY_ROOT(&rq->core_tree);
 }
 
-static bool sched_core_enqueued(struct task_struct *task)
-{
-	return !RB_EMPTY_NODE(&task->core_node);
-}
-
 static struct task_struct *sched_core_first(struct rq *rq)
 {
 	struct task_struct *task;
@@ -188,7 +183,7 @@ static void sched_core_flush(int cpu)
 	rq->core->core_task_seq++;
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
 	struct task_struct *node_task;
@@ -215,7 +210,7 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	rb_insert_color(&p->core_node, &rq->core_tree);
 }
 
-static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
@@ -310,7 +305,6 @@ static int __sched_core_stopper(void *data)
 }
 
 static DEFINE_MUTEX(sched_core_mutex);
-static DEFINE_MUTEX(sched_core_tasks_mutex);
 static int sched_core_count;
 
 static void __sched_core_enable(void)
@@ -346,16 +340,6 @@ void sched_core_put(void)
 		__sched_core_disable();
 	mutex_unlock(&sched_core_mutex);
 }
-
-static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
-
-#else /* !CONFIG_SCHED_CORE */
-
-static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
-static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
-static bool sched_core_enqueued(struct task_struct *task) { return false; }
-static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
-
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -8505,9 +8489,6 @@ void sched_offline_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-#define SCHED_CORE_GROUP_COOKIE_MASK ((1UL << (sizeof(unsigned long) * 4)) - 1)
-static unsigned long cpu_core_get_group_cookie(struct task_group *tg);
-
 static void sched_change_group(struct task_struct *tsk, int type)
 {
 	struct task_group *tg;
@@ -8583,11 +8564,6 @@ void sched_move_task(struct task_struct *tsk)
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
@@ -9200,459 +9176,6 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
-#ifdef CONFIG_SCHED_CORE
-/*
- * A simple wrapper around refcount. An allocated sched_core_cookie's
- * address is used to compute the cookie of the task.
- */
-struct sched_core_cookie {
-	refcount_t refcnt;
-};
-
-/*
- * sched_core_tag_requeue - Common helper for all interfaces to set a cookie.
- * @p: The task to assign a cookie to.
- * @cookie: The cookie to assign.
- * @group: is it a group interface or a per-task interface.
- *
- * This function is typically called from a stop-machine handler.
- */
-void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
-{
-	if (!p)
-		return;
-
-	if (group)
-		p->core_group_cookie = cookie;
-	else
-		p->core_task_cookie = cookie;
-
-	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
-	p->core_cookie = (p->core_task_cookie <<
-				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
-
-	if (sched_core_enqueued(p)) {
-		sched_core_dequeue(task_rq(p), p);
-		if (!p->core_cookie)
-			return;
-	}
-
-	if (sched_core_enabled(task_rq(p)) &&
-			p->core_cookie && task_on_rq_queued(p))
-		sched_core_enqueue(task_rq(p), p);
-}
-
-/* Per-task interface */
-static unsigned long sched_core_alloc_task_cookie(void)
-{
-	struct sched_core_cookie *ptr =
-		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
-
-	if (!ptr)
-		return 0;
-	refcount_set(&ptr->refcnt, 1);
-
-	/*
-	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
-	 * is done after the stopper runs.
-	 */
-	sched_core_get();
-	return (unsigned long)ptr;
-}
-
-static bool sched_core_get_task_cookie(unsigned long cookie)
-{
-	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
-
-	/*
-	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
-	 * is done after the stopper runs.
-	 */
-	sched_core_get();
-	return refcount_inc_not_zero(&ptr->refcnt);
-}
-
-static void sched_core_put_task_cookie(unsigned long cookie)
-{
-	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
-
-	if (refcount_dec_and_test(&ptr->refcnt))
-		kfree(ptr);
-}
-
-struct sched_core_task_write_tag {
-	struct task_struct *tasks[2];
-	unsigned long cookies[2];
-};
-
-/*
- * Ensure that the task has been requeued. The stopper ensures that the task cannot
- * be migrated to a different CPU while its core scheduler queue state is being updated.
- * It also makes sure to requeue a task if it was running actively on another CPU.
- */
-static int sched_core_task_join_stopper(void *data)
-{
-	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
-	int i;
-
-	for (i = 0; i < 2; i++)
-		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
-
-	return 0;
-}
-
-static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
-{
-	struct sched_core_task_write_tag wr = {}; /* for stop machine. */
-	bool sched_core_put_after_stopper = false;
-	unsigned long cookie;
-	int ret = -ENOMEM;
-
-	mutex_lock(&sched_core_tasks_mutex);
-
-	/*
-	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
-	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
-	 *       by this function *after* the stopper removes the tasks from the
-	 *       core queue, and not before. This is just to play it safe.
-	 */
-	if (t2 == NULL) {
-		if (t1->core_task_cookie) {
-			sched_core_put_task_cookie(t1->core_task_cookie);
-			sched_core_put_after_stopper = true;
-			wr.tasks[0] = t1; /* Keep wr.cookies[0] reset for t1. */
-		}
-	} else if (t1 == t2) {
-		/* Assign a unique per-task cookie solely for t1. */
-
-		cookie = sched_core_alloc_task_cookie();
-		if (!cookie)
-			goto out_unlock;
-
-		if (t1->core_task_cookie) {
-			sched_core_put_task_cookie(t1->core_task_cookie);
-			sched_core_put_after_stopper = true;
-		}
-		wr.tasks[0] = t1;
-		wr.cookies[0] = cookie;
-	} else
-	/*
-	 * 		t1		joining		t2
-	 * CASE 1:
-	 * before	0				0
-	 * after	new cookie			new cookie
-	 *
-	 * CASE 2:
-	 * before	X (non-zero)			0
-	 * after	0				0
-	 *
-	 * CASE 3:
-	 * before	0				X (non-zero)
-	 * after	X				X
-	 *
-	 * CASE 4:
-	 * before	Y (non-zero)			X (non-zero)
-	 * after	X				X
-	 */
-	if (!t1->core_task_cookie && !t2->core_task_cookie) {
-		/* CASE 1. */
-		cookie = sched_core_alloc_task_cookie();
-		if (!cookie)
-			goto out_unlock;
-
-		/* Add another reference for the other task. */
-		if (!sched_core_get_task_cookie(cookie)) {
-			return -EINVAL;
-			goto out_unlock;
-		}
-
-		wr.tasks[0] = t1;
-		wr.tasks[1] = t2;
-		wr.cookies[0] = wr.cookies[1] = cookie;
-
-	} else if (t1->core_task_cookie && !t2->core_task_cookie) {
-		/* CASE 2. */
-		sched_core_put_task_cookie(t1->core_task_cookie);
-		sched_core_put_after_stopper = true;
-
-		wr.tasks[0] = t1; /* Reset cookie for t1. */
-
-	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
-		/* CASE 3. */
-		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
-
-		wr.tasks[0] = t1;
-		wr.cookies[0] = t2->core_task_cookie;
-
-	} else {
-		/* CASE 4. */
-		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
-		sched_core_put_task_cookie(t1->core_task_cookie);
-		sched_core_put_after_stopper = true;
-
-		wr.tasks[0] = t1;
-		wr.cookies[0] = t2->core_task_cookie;
-	}
-
-	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
-
-	if (sched_core_put_after_stopper)
-		sched_core_put();
-
-	ret = 0;
-out_unlock:
-	mutex_unlock(&sched_core_tasks_mutex);
-	return ret;
-}
-
-/* Called from prctl interface: PR_SCHED_CORE_SHARE */
-int sched_core_share_pid(pid_t pid)
-{
-	struct task_struct *task;
-	int err;
-
-	if (pid == 0) { /* Recent current task's cookie. */
-		/* Resetting a cookie requires privileges. */
-		if (current->core_task_cookie)
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-		task = NULL;
-	} else {
-		rcu_read_lock();
-		task = pid ? find_task_by_vpid(pid) : current;
-		if (!task) {
-			rcu_read_unlock();
-			return -ESRCH;
-		}
-
-		get_task_struct(task);
-
-		/*
-		 * Check if this process has the right to modify the specified
-		 * process. Use the regular "ptrace_may_access()" checks.
-		 */
-		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
-			rcu_read_unlock();
-			err = -EPERM;
-			goto out_put;
-		}
-		rcu_read_unlock();
-	}
-
-	err = sched_core_share_tasks(current, task);
-out_put:
-	if (task)
-		put_task_struct(task);
-	return err;
-}
-
-/* CGroup interface */
-
-/*
- * Helper to get the cookie in a hierarchy.
- * The cookie is a combination of a tag and color. Any ancestor
- * can have a tag/color. tag is the first-level cookie setting
- * with color being the second. Atmost one color and one tag is
- * allowed.
- */
-static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
-{
-	unsigned long color = 0;
-
-	if (!tg)
-		return 0;
-
-	for (; tg; tg = tg->parent) {
-		if (tg->core_tag_color) {
-			WARN_ON_ONCE(color);
-			color = tg->core_tag_color;
-		}
-
-		if (tg->core_tagged) {
-			unsigned long cookie = ((unsigned long)tg << 8) | color;
-			cookie &= SCHED_CORE_GROUP_COOKIE_MASK;
-			return cookie;
-		}
-	}
-
-	return 0;
-}
-
-/* Determine if any group in @tg's children are tagged or colored. */
-static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag,
-					bool check_color)
-{
-	struct task_group *child;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(child, &tg->children, siblings) {
-		if ((child->core_tagged && check_tag) ||
-		    (child->core_tag_color && check_color)) {
-			rcu_read_unlock();
-			return true;
-		}
-
-		rcu_read_unlock();
-		return cpu_core_check_descendants(child, check_tag, check_color);
-	}
-
-	rcu_read_unlock();
-	return false;
-}
-
-static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
-{
-	struct task_group *tg = css_tg(css);
-
-	return !!tg->core_tagged;
-}
-
-static u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
-{
-	struct task_group *tg = css_tg(css);
-
-	return tg->core_tag_color;
-}
-
-#ifdef CONFIG_SCHED_DEBUG
-static u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
-{
-	return cpu_core_get_group_cookie(css_tg(css));
-}
-#endif
-
-struct write_core_tag {
-	struct cgroup_subsys_state *css;
-	unsigned long cookie;
-};
-
-static int __sched_write_tag(void *data)
-{
-	struct write_core_tag *tag = (struct write_core_tag *) data;
-	struct task_struct *p;
-	struct cgroup_subsys_state *css;
-
-	rcu_read_lock();
-	css_for_each_descendant_pre(css, tag->css) {
-		struct css_task_iter it;
-
-		css_task_iter_start(css, 0, &it);
-		/*
-		 * Note: css_task_iter_next will skip dying tasks.
-		 * There could still be dying tasks left in the core queue
-		 * when we set cgroup tag to 0 when the loop is done below.
-		 */
-		while ((p = css_task_iter_next(&it)))
-			sched_core_tag_requeue(p, tag->cookie, true /* group */);
-
-		css_task_iter_end(&it);
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
-static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
-{
-	struct task_group *tg = css_tg(css);
-	struct write_core_tag wtag;
-
-	if (val > 1)
-		return -ERANGE;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -EINVAL;
-
-	if (!tg->core_tagged && val) {
-		/* Tag is being set. Check ancestors and descendants. */
-		if (cpu_core_get_group_cookie(tg) ||
-		    cpu_core_check_descendants(tg, true /* tag */, true /* color */))
-			return -EBUSY;
-	} else if (tg->core_tagged && !val) {
-		/* Tag is being reset. Check descendants. */
-		if (cpu_core_check_descendants(tg, true /* tag */, true /* color */))
-			return -EBUSY;
-	} else {
-		return 0;
-	}
-
-	if (!!val)
-		sched_core_get();
-
-	wtag.css = css;
-	wtag.cookie = (unsigned long)tg << 8; /* Reserve lower 8 bits for color. */
-
-	/* Truncate the upper 32-bits - those are used by the per-task cookie. */
-	wtag.cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
-
-	tg->core_tagged = val;
-
-	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
-	if (!val)
-		sched_core_put();
-
-	return 0;
-}
-
-static int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
-					struct cftype *cft, u64 val)
-{
-	struct task_group *tg = css_tg(css);
-	struct write_core_tag wtag;
-	u64 cookie;
-
-	if (val > 255)
-		return -ERANGE;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -EINVAL;
-
-	cookie = cpu_core_get_group_cookie(tg);
-	/* Can't set color if nothing in the ancestors were tagged. */
-	if (!cookie)
-		return -EINVAL;
-
-	/*
-	 * Something in the ancestors already colors us. Can't change the color
-	 * at this level.
-	 */
-	if (!tg->core_tag_color && (cookie & 255))
-		return -EINVAL;
-
-	/*
-	 * Check if any descendants are colored. If so, we can't recolor them.
-	 * Don't need to check if descendants are tagged, since we don't allow
-	 * tagging when already tagged.
-	 */
-	if (cpu_core_check_descendants(tg, false /* tag */, true /* color */))
-		return -EINVAL;
-
-	cookie &= ~255;
-	cookie |= val;
-	wtag.css = css;
-	wtag.cookie = cookie;
-	tg->core_tag_color = val;
-
-	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
-
-	return 0;
-}
-
-void sched_tsk_free(struct task_struct *tsk)
-{
-	if (!tsk->core_task_cookie)
-		return;
-	sched_core_put_task_cookie(tsk->core_task_cookie);
-	sched_core_put();
-}
-#endif
-
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
new file mode 100644
index 000000000000..3333c9b0afc5
--- /dev/null
+++ b/kernel/sched/coretag.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kernel/sched/core-tag.c
+ *
+ * Core-scheduling tagging interface support.
+ *
+ * Copyright(C) 2020, Joel Fernandes.
+ * Initial interfacing code  by Peter Ziljstra.
+ */
+
+#include "sched.h"
+
+/*
+ * A simple wrapper around refcount. An allocated sched_core_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_cookie {
+	refcount_t refcnt;
+};
+
+static DEFINE_MUTEX(sched_core_tasks_mutex);
+
+/*
+ * sched_core_tag_requeue - Common helper for all interfaces to set a cookie.
+ * @p: The task to assign a cookie to.
+ * @cookie: The cookie to assign.
+ * @group: is it a group interface or a per-task interface.
+ *
+ * This function is typically called from a stop-machine handler.
+ */
+void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
+{
+	if (!p)
+		return;
+
+	if (group)
+		p->core_group_cookie = cookie;
+	else
+		p->core_task_cookie = cookie;
+
+	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
+	p->core_cookie = (p->core_task_cookie <<
+				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
+
+	if (sched_core_enqueued(p)) {
+		sched_core_dequeue(task_rq(p), p);
+		if (!p->core_cookie)
+			return;
+	}
+
+	if (sched_core_enabled(task_rq(p)) &&
+			p->core_cookie && task_on_rq_queued(p))
+		sched_core_enqueue(task_rq(p), p);
+}
+
+/* Per-task interface: Used by fork(2) and prctl(2). */
+static unsigned long sched_core_alloc_task_cookie(void)
+{
+	struct sched_core_cookie *ptr =
+		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
+
+	if (!ptr)
+		return 0;
+	refcount_set(&ptr->refcnt, 1);
+
+	/*
+	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
+	 * is done after the stopper runs.
+	 */
+	sched_core_get();
+	return (unsigned long)ptr;
+}
+
+static bool sched_core_get_task_cookie(unsigned long cookie)
+{
+	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
+
+	/*
+	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
+	 * is done after the stopper runs.
+	 */
+	sched_core_get();
+	return refcount_inc_not_zero(&ptr->refcnt);
+}
+
+static void sched_core_put_task_cookie(unsigned long cookie)
+{
+	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
+
+	if (refcount_dec_and_test(&ptr->refcnt))
+		kfree(ptr);
+}
+
+struct sched_core_task_write_tag {
+	struct task_struct *tasks[2];
+	unsigned long cookies[2];
+};
+
+/*
+ * Ensure that the task has been requeued. The stopper ensures that the task cannot
+ * be migrated to a different CPU while its core scheduler queue state is being updated.
+ * It also makes sure to requeue a task if it was running actively on another CPU.
+ */
+static int sched_core_task_join_stopper(void *data)
+{
+	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
+	int i;
+
+	for (i = 0; i < 2; i++)
+		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
+
+	return 0;
+}
+
+int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
+{
+	struct sched_core_task_write_tag wr = {}; /* for stop machine. */
+	bool sched_core_put_after_stopper = false;
+	unsigned long cookie;
+	int ret = -ENOMEM;
+
+	mutex_lock(&sched_core_tasks_mutex);
+
+	/*
+	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
+	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
+	 *       by this function *after* the stopper removes the tasks from the
+	 *       core queue, and not before. This is just to play it safe.
+	 */
+	if (t2 == NULL) {
+		if (t1->core_task_cookie) {
+			sched_core_put_task_cookie(t1->core_task_cookie);
+			sched_core_put_after_stopper = true;
+			wr.tasks[0] = t1; /* Keep wr.cookies[0] reset for t1. */
+		}
+	} else if (t1 == t2) {
+		/* Assign a unique per-task cookie solely for t1. */
+
+		cookie = sched_core_alloc_task_cookie();
+		if (!cookie)
+			goto out_unlock;
+
+		if (t1->core_task_cookie) {
+			sched_core_put_task_cookie(t1->core_task_cookie);
+			sched_core_put_after_stopper = true;
+		}
+		wr.tasks[0] = t1;
+		wr.cookies[0] = cookie;
+	} else
+	/*
+	 * 		t1		joining		t2
+	 * CASE 1:
+	 * before	0				0
+	 * after	new cookie			new cookie
+	 *
+	 * CASE 2:
+	 * before	X (non-zero)			0
+	 * after	0				0
+	 *
+	 * CASE 3:
+	 * before	0				X (non-zero)
+	 * after	X				X
+	 *
+	 * CASE 4:
+	 * before	Y (non-zero)			X (non-zero)
+	 * after	X				X
+	 */
+	if (!t1->core_task_cookie && !t2->core_task_cookie) {
+		/* CASE 1. */
+		cookie = sched_core_alloc_task_cookie();
+		if (!cookie)
+			goto out_unlock;
+
+		/* Add another reference for the other task. */
+		if (!sched_core_get_task_cookie(cookie)) {
+			return -EINVAL;
+			goto out_unlock;
+		}
+
+		wr.tasks[0] = t1;
+		wr.tasks[1] = t2;
+		wr.cookies[0] = wr.cookies[1] = cookie;
+
+	} else if (t1->core_task_cookie && !t2->core_task_cookie) {
+		/* CASE 2. */
+		sched_core_put_task_cookie(t1->core_task_cookie);
+		sched_core_put_after_stopper = true;
+
+		wr.tasks[0] = t1; /* Reset cookie for t1. */
+
+	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
+		/* CASE 3. */
+		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		wr.tasks[0] = t1;
+		wr.cookies[0] = t2->core_task_cookie;
+
+	} else {
+		/* CASE 4. */
+		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		sched_core_put_task_cookie(t1->core_task_cookie);
+		sched_core_put_after_stopper = true;
+
+		wr.tasks[0] = t1;
+		wr.cookies[0] = t2->core_task_cookie;
+	}
+
+	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
+
+	if (sched_core_put_after_stopper)
+		sched_core_put();
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&sched_core_tasks_mutex);
+	return ret;
+}
+
+/* Called from prctl interface: PR_SCHED_CORE_SHARE */
+int sched_core_share_pid(pid_t pid)
+{
+	struct task_struct *task;
+	int err;
+
+	if (pid == 0) { /* Recent current task's cookie. */
+		/* Resetting a cookie requires privileges. */
+		if (current->core_task_cookie)
+			if (!capable(CAP_SYS_ADMIN))
+				return -EPERM;
+		task = NULL;
+	} else {
+		rcu_read_lock();
+		task = pid ? find_task_by_vpid(pid) : current;
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+
+		get_task_struct(task);
+
+		/*
+		 * Check if this process has the right to modify the specified
+		 * process. Use the regular "ptrace_may_access()" checks.
+		 */
+		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+			rcu_read_unlock();
+			err = -EPERM;
+			goto out_put;
+		}
+		rcu_read_unlock();
+	}
+
+	err = sched_core_share_tasks(current, task);
+out_put:
+	if (task)
+		put_task_struct(task);
+	return err;
+}
+
+/* CGroup core-scheduling interface support. */
+
+/*
+ * Helper to get the cookie in a hierarchy.
+ * The cookie is a combination of a tag and color. Any ancestor
+ * can have a tag/color. tag is the first-level cookie setting
+ * with color being the second. Atmost one color and one tag is
+ * allowed.
+ */
+unsigned long cpu_core_get_group_cookie(struct task_group *tg)
+{
+	unsigned long color = 0;
+
+	if (!tg)
+		return 0;
+
+	for (; tg; tg = tg->parent) {
+		if (tg->core_tag_color) {
+			WARN_ON_ONCE(color);
+			color = tg->core_tag_color;
+		}
+
+		if (tg->core_tagged) {
+			unsigned long cookie = ((unsigned long)tg << 8) | color;
+			cookie &= SCHED_CORE_GROUP_COOKIE_MASK;
+			return cookie;
+		}
+	}
+
+	return 0;
+}
+
+/* Determine if any group in @tg's children are tagged or colored. */
+static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag,
+				       bool check_color)
+{
+	struct task_group *child;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		if ((child->core_tagged && check_tag) ||
+		    (child->core_tag_color && check_color)) {
+			rcu_read_unlock();
+			return true;
+		}
+
+		rcu_read_unlock();
+		return cpu_core_check_descendants(child, check_tag, check_color);
+	}
+
+	rcu_read_unlock();
+	return false;
+}
+
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return !!tg->core_tagged;
+}
+
+u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css,
+				struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return tg->core_tag_color;
+}
+
+#ifdef CONFIG_SCHED_DEBUG
+u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	return cpu_core_get_group_cookie(css_tg(css));
+}
+#endif
+
+struct write_core_tag {
+	struct cgroup_subsys_state *css;
+	unsigned long cookie;
+};
+
+static int __sched_write_tag(void *data)
+{
+	struct write_core_tag *tag = (struct write_core_tag *) data;
+	struct task_struct *p;
+	struct cgroup_subsys_state *css;
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, tag->css) {
+		struct css_task_iter it;
+
+		css_task_iter_start(css, 0, &it);
+		/*
+		 * Note: css_task_iter_next will skip dying tasks.
+		 * There could still be dying tasks left in the core queue
+		 * when we set cgroup tag to 0 when the loop is done below.
+		 */
+		while ((p = css_task_iter_next(&it)))
+			sched_core_tag_requeue(p, tag->cookie, true /* group */);
+
+		css_task_iter_end(&it);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			   u64 val)
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
+	if (!tg->core_tagged && val) {
+		/* Tag is being set. Check ancestors and descendants. */
+		if (cpu_core_get_group_cookie(tg) ||
+		    cpu_core_check_descendants(tg, true /* tag */, true /* color */))
+			return -EBUSY;
+	} else if (tg->core_tagged && !val) {
+		/* Tag is being reset. Check descendants. */
+		if (cpu_core_check_descendants(tg, true /* tag */, true /* color */))
+			return -EBUSY;
+	} else {
+		return 0;
+	}
+
+	if (!!val)
+		sched_core_get();
+
+	wtag.css = css;
+	wtag.cookie = (unsigned long)tg << 8; /* Reserve lower 8 bits for color. */
+
+	/* Truncate the upper 32-bits - those are used by the per-task cookie. */
+	wtag.cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
+
+	tg->core_tagged = val;
+
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
+	if (!val)
+		sched_core_put();
+
+	return 0;
+}
+
+int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct write_core_tag wtag;
+	u64 cookie;
+
+	if (val > 255)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	cookie = cpu_core_get_group_cookie(tg);
+	/* Can't set color if nothing in the ancestors were tagged. */
+	if (!cookie)
+		return -EINVAL;
+
+	/*
+	 * Something in the ancestors already colors us. Can't change the color
+	 * at this level.
+	 */
+	if (!tg->core_tag_color && (cookie & 255))
+		return -EINVAL;
+
+	/*
+	 * Check if any descendants are colored. If so, we can't recolor them.
+	 * Don't need to check if descendants are tagged, since we don't allow
+	 * tagging when already tagged.
+	 */
+	if (cpu_core_check_descendants(tg, false /* tag */, true /* color */))
+		return -EINVAL;
+
+	cookie &= ~255;
+	cookie |= val;
+	wtag.css = css;
+	wtag.cookie = cookie;
+	tg->core_tag_color = val;
+
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
+
+	return 0;
+}
+
+void sched_tsk_free(struct task_struct *tsk)
+{
+	if (!tsk->core_task_cookie)
+		return;
+	sched_core_put_task_cookie(tsk->core_task_cookie);
+	sched_core_put();
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aebeb91c4a0f..290a3b8be3d3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -437,6 +437,11 @@ struct task_group {
 
 };
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
@@ -1104,6 +1109,8 @@ static inline int cpu_of(struct rq *rq)
 #ifdef CONFIG_SCHED_CORE
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+#define SCHED_CORE_GROUP_COOKIE_MASK ((1UL << (sizeof(unsigned long) * 4)) - 1)
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
@@ -1148,10 +1155,54 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	return idle_core || rq->core->core_cookie == p->core_cookie;
 }
 
-extern void queue_core_balance(struct rq *rq);
+static inline bool sched_core_enqueued(struct task_struct *task)
+{
+	return !RB_EMPTY_NODE(&task->core_node);
+}
+
+void queue_core_balance(struct rq *rq);
+
+void sched_core_enqueue(struct rq *rq, struct task_struct *p);
+void sched_core_dequeue(struct rq *rq, struct task_struct *p);
+void sched_core_get(void);
+void sched_core_put(void);
+
+void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie,
+			    bool group);
+
+int sched_core_share_pid(pid_t pid);
+int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
+
+unsigned long cpu_core_get_group_cookie(struct task_group *tg);
+
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft);
+
+u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css,
+				struct cftype *cft);
+
+#ifdef CONFIG_SCHED_DEBUG
+u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft);
+#endif
+
+int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			   u64 val);
+
+int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft, u64 val);
+
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#endif
 
 #else /* !CONFIG_SCHED_CORE */
 
+static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return false;
@@ -2779,7 +2830,4 @@ void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
 #ifdef CONFIG_SCHED_CORE
-#ifndef TIF_UNSAFE_RET
-#define TIF_UNSAFE_RET (0)
-#endif
 #endif
-- 
2.29.0.rc1.297.gfa9743e501-goog

