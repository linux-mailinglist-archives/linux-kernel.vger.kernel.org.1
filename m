Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCC2B723D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKQXVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgKQXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:10 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0723C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:09 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g15so223039qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvoQs9F37MKnIScDh2B192hOLaT2k1KS7DzXm1IYW4Q=;
        b=njrzenaaSflAtBongBeHsSjHVi8ma3tSo89Q1EoZF7+ksCWKWXI99+vES3SQLwqM7K
         wDFKiwrFF2LTDsapRkSzQCWBK8HT7ogqMRUUQerqGa2lQ03tccSEaQlGcGokIMbOZ1/7
         FYjB6EzwAkZvFL+HfyjAWvYGGRd1mT3TnRpJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvoQs9F37MKnIScDh2B192hOLaT2k1KS7DzXm1IYW4Q=;
        b=UUaVx6eBbRAGm6/53UCotYlkCoQ31Q6+5645ndc1S8SPp9lkgGZSOrH2nhNbkNXGRC
         DveBZqF7MlSvPy8l4j36EGKd0vVJHFeoNi6jb3a3L9SpzNpClU74esEcS4yGAnjedwQZ
         3NypKFUfO61ucF9IrVeLVK+RU7Cb+Z6tjgewq3FJ0rjbKukQYzIm+v0hRbVDh241Dtt7
         2uMD0hf3aR3jeAXDg2FjRD/xRMQJuU7RIqqeSjBOZFtdQ9O8zwHuSO5qIT6D7kzvnkHi
         8mEABQx5fMOKt9rgQYPiLYcMJB4yurtUeUxOEJOURiJ+yWlqVabBwqVPoQcb79Tns6Ql
         uOgQ==
X-Gm-Message-State: AOAM530O0OUtstd+ZM+FqOFrKnL0GHfdJBg4ZBUYW9raoKWZwLq/r+Sb
        XyaEgyeOu6NskLIEej3daZL0XQ==
X-Google-Smtp-Source: ABdhPJwIM7hcLAUW5KmtkHclLrmRc8PcpROT21fRwtFGAP7Gbq1g3+v2fj+/MUFQV/9lQRNNbAV7zg==
X-Received: by 2002:a05:622a:14c:: with SMTP id v12mr2185660qtw.11.1605655268432;
        Tue, 17 Nov 2020 15:21:08 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:21:07 -0800 (PST)
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
Subject: [PATCH -tip 29/32] sched: Move core-scheduler interfacing code to a new file
Date:   Tue, 17 Nov 2020 18:19:59 -0500
Message-Id: <20201117232003.3580179-30-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core.c is already huge. The core-tagging interface code is largely
independent of it. Move it to its own file to make both files easier to
maintain.

Also make the following changes:
- Fix SWA bugs found by Chris Hyser.
- Fix refcount underrun caused by not zero'ing new task's cookie.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/Makefile  |   1 +
 kernel/sched/core.c    | 809 +---------------------------------------
 kernel/sched/coretag.c | 819 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  51 ++-
 4 files changed, 872 insertions(+), 808 deletions(-)
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
index f1d9762b571a..5ef04bdc849f 100644
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
@@ -3834,6 +3818,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->capture_control = NULL;
 #endif
 	init_numa_balancing(clone_flags, p);
+#ifdef CONFIG_SCHED_CORE
+	p->core_task_cookie = 0;
+#endif
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
@@ -9118,11 +9105,6 @@ void sched_move_task(struct task_struct *tsk)
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
@@ -9735,787 +9717,6 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
-#ifdef CONFIG_SCHED_CORE
-/*
- * Wrapper representing a complete cookie. The address of the cookie is used as
- * a unique identifier. Each cookie has a unique permutation of the internal
- * cookie fields.
- */
-struct sched_core_cookie {
-	unsigned long task_cookie;
-	unsigned long group_cookie;
-	unsigned long color;
-
-	struct rb_node node;
-	refcount_t refcnt;
-};
-
-/*
- * A simple wrapper around refcount. An allocated sched_core_task_cookie's
- * address is used to compute the cookie of the task.
- */
-struct sched_core_task_cookie {
-	refcount_t refcnt;
-};
-
-/* All active sched_core_cookies */
-static struct rb_root sched_core_cookies = RB_ROOT;
-static DEFINE_RAW_SPINLOCK(sched_core_cookies_lock);
-
-/*
- * Returns the following:
- * a < b  => -1
- * a == b => 0
- * a > b  => 1
- */
-static int sched_core_cookie_cmp(const struct sched_core_cookie *a,
-				 const struct sched_core_cookie *b)
-{
-#define COOKIE_CMP_RETURN(field) do {		\
-	if (a->field < b->field)		\
-		return -1;			\
-	else if (a->field > b->field)		\
-		return 1;			\
-} while (0)					\
-
-	COOKIE_CMP_RETURN(task_cookie);
-	COOKIE_CMP_RETURN(group_cookie);
-	COOKIE_CMP_RETURN(color);
-
-	/* all cookie fields match */
-	return 0;
-
-#undef COOKIE_CMP_RETURN
-}
-
-static inline void __sched_core_erase_cookie(struct sched_core_cookie *cookie)
-{
-	lockdep_assert_held(&sched_core_cookies_lock);
-
-	/* Already removed */
-	if (RB_EMPTY_NODE(&cookie->node))
-		return;
-
-	rb_erase(&cookie->node, &sched_core_cookies);
-	RB_CLEAR_NODE(&cookie->node);
-}
-
-/* Called when a task no longer points to the cookie in question */
-static void sched_core_put_cookie(struct sched_core_cookie *cookie)
-{
-	unsigned long flags;
-
-	if (!cookie)
-		return;
-
-	if (refcount_dec_and_test(&cookie->refcnt)) {
-		raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
-		__sched_core_erase_cookie(cookie);
-		raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
-		kfree(cookie);
-	}
-}
-
-/*
- * A task's core cookie is a compound structure composed of various cookie
- * fields (task_cookie, group_cookie, color). The overall core_cookie is
- * a pointer to a struct containing those values. This function either finds
- * an existing core_cookie or creates a new one, and then updates the task's
- * core_cookie to point to it. Additionally, it handles the necessary reference
- * counting.
- *
- * REQUIRES: task_rq(p) lock or called from cpu_stopper.
- * Doing so ensures that we do not cause races/corruption by modifying/reading
- * task cookie fields.
- */
-static void __sched_core_update_cookie(struct task_struct *p)
-{
-	struct rb_node *parent, **node;
-	struct sched_core_cookie *node_core_cookie, *match;
-	static const struct sched_core_cookie zero_cookie;
-	struct sched_core_cookie temp = {
-		.task_cookie	= p->core_task_cookie,
-		.group_cookie	= p->core_group_cookie,
-		.color		= p->core_color
-	};
-	const bool is_zero_cookie =
-		(sched_core_cookie_cmp(&temp, &zero_cookie) == 0);
-	struct sched_core_cookie *const curr_cookie =
-		(struct sched_core_cookie *)p->core_cookie;
-	unsigned long flags;
-
-	/*
-	 * Already have a cookie matching the requested settings? Nothing to
-	 * do.
-	 */
-	if ((curr_cookie && sched_core_cookie_cmp(curr_cookie, &temp) == 0) ||
-	    (!curr_cookie && is_zero_cookie))
-		return;
-
-	raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
-
-	if (is_zero_cookie) {
-		match = NULL;
-		goto finish;
-	}
-
-retry:
-	match = NULL;
-
-	node = &sched_core_cookies.rb_node;
-	parent = *node;
-	while (*node) {
-		int cmp;
-
-		node_core_cookie =
-			container_of(*node, struct sched_core_cookie, node);
-		parent = *node;
-
-		cmp = sched_core_cookie_cmp(&temp, node_core_cookie);
-		if (cmp < 0) {
-			node = &parent->rb_left;
-		} else if (cmp > 0) {
-			node = &parent->rb_right;
-		} else {
-			match = node_core_cookie;
-			break;
-		}
-	}
-
-	if (!match) {
-		/* No existing cookie; create and insert one */
-		match = kmalloc(sizeof(struct sched_core_cookie), GFP_ATOMIC);
-
-		/* Fall back to zero cookie */
-		if (WARN_ON_ONCE(!match))
-			goto finish;
-
-		match->task_cookie = temp.task_cookie;
-		match->group_cookie = temp.group_cookie;
-		match->color = temp.color;
-		refcount_set(&match->refcnt, 1);
-
-		rb_link_node(&match->node, parent, node);
-		rb_insert_color(&match->node, &sched_core_cookies);
-	} else {
-		/*
-		 * Cookie exists, increment refcnt. If refcnt is currently 0,
-		 * we're racing with a put() (refcnt decremented but cookie not
-		 * yet removed from the tree). In this case, we can simply
-		 * perform the removal ourselves and retry.
-		 * sched_core_put_cookie() will still function correctly.
-		 */
-		if (unlikely(!refcount_inc_not_zero(&match->refcnt))) {
-			__sched_core_erase_cookie(match);
-			goto retry;
-		}
-	}
-
-finish:
-	/*
-	 * Set the core_cookie under the cookies lock. This guarantees that
-	 * p->core_cookie cannot be freed while the cookies lock is held in
-	 * sched_core_fork().
-	 */
-	p->core_cookie = (unsigned long)match;
-
-	raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
-
-	sched_core_put_cookie(curr_cookie);
-}
-
-/*
- * sched_core_update_cookie - Common helper to update a task's core cookie. This
- * updates the selected cookie field and then updates the overall cookie.
- * @p: The task whose cookie should be updated.
- * @cookie: The new cookie.
- * @cookie_type: The cookie field to which the cookie corresponds.
- *
- * REQUIRES: either task_rq(p)->lock held or called from a stop-machine handler.
- * Doing so ensures that we do not cause races/corruption by modifying/reading
- * task cookie fields.
- */
-static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
-				     enum sched_core_cookie_type cookie_type)
-{
-	if (!p)
-		return;
-
-	switch (cookie_type) {
-	case sched_core_no_update:
-		break;
-	case sched_core_task_cookie_type:
-		p->core_task_cookie = cookie;
-		break;
-	case sched_core_group_cookie_type:
-		p->core_group_cookie = cookie;
-		break;
-	case sched_core_color_type:
-		p->core_color = cookie;
-		break;
-	default:
-		WARN_ON_ONCE(1);
-	}
-
-	/* Set p->core_cookie, which is the overall cookie */
-	__sched_core_update_cookie(p);
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
-void cpu_core_get_group_cookie_and_color(struct task_group *tg,
-					 unsigned long *group_cookie_ptr,
-					 unsigned long *color_ptr);
-
-void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
-{
-	unsigned long new_group_cookie, new_color;
-
-	cpu_core_get_group_cookie_and_color(new_tg, &new_group_cookie,
-					    &new_color);
-
-	if (p->core_group_cookie == new_group_cookie &&
-	    p->core_color == new_color)
-		return;
-
-	p->core_group_cookie = new_group_cookie;
-	p->core_color = new_color;
-
-	__sched_core_update_cookie(p);
-}
-
-/* Per-task interface */
-static unsigned long sched_core_alloc_task_cookie(void)
-{
-	struct sched_core_task_cookie *ptr =
-		kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);
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
-	struct sched_core_task_cookie *ptr =
-		(struct sched_core_task_cookie *)cookie;
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
-	struct sched_core_task_cookie *ptr =
-		(struct sched_core_task_cookie *)cookie;
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
-		sched_core_update_cookie(tag->tasks[i], tag->cookies[i],
-					 sched_core_task_cookie_type);
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
-			ret = -EINVAL;
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
- * Helper to get the group cookie and color in a hierarchy.
- * Any ancestor can have a tag/color. Atmost one color and one
- * tag is allowed.
- * Sets *group_cookie_ptr and *color_ptr to the hierarchical group cookie
- * and color.
- */
-void cpu_core_get_group_cookie_and_color(struct task_group *tg,
-					 unsigned long *group_cookie_ptr,
-					 unsigned long *color_ptr)
-{
-	unsigned long group_cookie = 0UL;
-	unsigned long color = 0UL;
-
-	if (!tg)
-		goto out;
-
-	for (; tg; tg = tg->parent) {
-		if (tg->core_tag_color) {
-			WARN_ON_ONCE(color);
-			color = tg->core_tag_color;
-		}
-
-		if (tg->core_tagged) {
-			group_cookie = (unsigned long)tg;
-			break;
-		}
-	}
-
-out:
-	*group_cookie_ptr = group_cookie;
-	*color_ptr = color;
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
-	unsigned long group_cookie, color;
-
-	cpu_core_get_group_cookie_and_color(css_tg(css), &group_cookie, &color);
-
-	/*
-	 * Combine group_cookie and color into a single 64 bit value, for
-	 * display purposes only.
-	 */
-	return (group_cookie << 32) | (color & 0xffffffff);
-}
-#endif
-
-struct write_core_tag {
-	struct cgroup_subsys_state *css;
-	unsigned long cookie;
-	enum sched_core_cookie_type cookie_type;
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
-			sched_core_update_cookie(p, tag->cookie,
-						 tag->cookie_type);
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
-	unsigned long group_cookie, color;
-
-	if (val > 1)
-		return -ERANGE;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -EINVAL;
-
-	if (!tg->core_tagged && val) {
-		/* Tag is being set. Check ancestors and descendants. */
-		cpu_core_get_group_cookie_and_color(tg, &group_cookie, &color);
-		if (group_cookie ||
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
-	wtag.cookie = (unsigned long)tg;
-	wtag.cookie_type = sched_core_group_cookie_type;
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
-	unsigned long group_cookie, color;
-
-	if (val > ULONG_MAX)
-		return -ERANGE;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -EINVAL;
-
-	cpu_core_get_group_cookie_and_color(tg, &group_cookie, &color);
-	/* Can't set color if nothing in the ancestors were tagged. */
-	if (!group_cookie)
-		return -EINVAL;
-
-	/*
-	 * Something in the ancestors already colors us. Can't change the color
-	 * at this level.
-	 */
-	if (!tg->core_tag_color && color)
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
-	wtag.css = css;
-	wtag.cookie = val;
-	wtag.cookie_type = sched_core_color_type;
-	tg->core_tag_color = val;
-
-	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
-
-	return 0;
-}
-
-static int sched_update_core_tag_stopper(void *data)
-{
-	struct task_struct *p = (struct task_struct *)data;
-
-	/* Recalculate core cookie */
-	sched_core_update_cookie(p, 0, sched_core_no_update);
-
-	return 0;
-}
-
-/* Called from sched_fork() */
-int sched_core_fork(struct task_struct *p, unsigned long clone_flags)
-{
-	struct sched_core_cookie *parent_cookie =
-		(struct sched_core_cookie *)current->core_cookie;
-
-	/*
-	 * core_cookie is ref counted; avoid an uncounted reference.
-	 * If p should have a cookie, it will be set below.
-	 */
-	p->core_cookie = 0UL;
-
-	/*
-	 * If parent is tagged via per-task cookie, tag the child (either with
-	 * the parent's cookie, or a new one).
-	 *
-	 * We can return directly in this case, because sched_core_share_tasks()
-	 * will set the core_cookie (so there is no need to try to inherit from
-	 * the parent). The cookie will have the proper sub-fields (ie. group
-	 * cookie, etc.), because these come from p's task_struct, which is
-	 * dup'd from the parent.
-	 */
-	if (current->core_task_cookie) {
-		int ret;
-
-		/* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
-		if (!(clone_flags & CLONE_THREAD)) {
-			ret = sched_core_share_tasks(p, p);
-		} else {
-			/* Otherwise share the parent's per-task tag. */
-			ret = sched_core_share_tasks(p, current);
-		}
-
-		if (ret)
-			return ret;
-
-		/*
-		 * We expect sched_core_share_tasks() to always update p's
-		 * core_cookie.
-		 */
-		WARN_ON_ONCE(!p->core_cookie);
-
-		return 0;
-	}
-
-	/*
-	 * If parent is tagged, inherit the cookie and ensure that the reference
-	 * count is updated.
-	 *
-	 * Technically, we could instead zero-out the task's group_cookie and
-	 * allow sched_core_change_group() to handle this post-fork, but
-	 * inheriting here has a performance advantage, since we don't
-	 * need to traverse the core_cookies RB tree and can instead grab the
-	 * parent's cookie directly.
-	 */
-	if (parent_cookie) {
-		bool need_stopper = false;
-		unsigned long flags;
-
-		/*
-		 * cookies lock prevents task->core_cookie from changing or
-		 * being freed
-		 */
-		raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
-
-		if (likely(refcount_inc_not_zero(&parent_cookie->refcnt))) {
-			p->core_cookie = (unsigned long)parent_cookie;
-		} else {
-			/*
-			 * Raced with put(). We'll use stop_machine to get
-			 * a core_cookie
-			 */
-			need_stopper = true;
-		}
-
-		raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
-
-		if (need_stopper)
-			stop_machine(sched_update_core_tag_stopper,
-				     (void *)p, NULL);
-	}
-
-	return 0;
-}
-
-void sched_tsk_free(struct task_struct *tsk)
-{
-	sched_core_put_cookie((struct sched_core_cookie *)tsk->core_cookie);
-
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
index 000000000000..800c0f8bacfc
--- /dev/null
+++ b/kernel/sched/coretag.c
@@ -0,0 +1,819 @@
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
+ * Wrapper representing a complete cookie. The address of the cookie is used as
+ * a unique identifier. Each cookie has a unique permutation of the internal
+ * cookie fields.
+ */
+struct sched_core_cookie {
+	unsigned long task_cookie;
+	unsigned long group_cookie;
+	unsigned long color;
+
+	struct rb_node node;
+	refcount_t refcnt;
+};
+
+/*
+ * A simple wrapper around refcount. An allocated sched_core_task_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_task_cookie {
+	refcount_t refcnt;
+	struct work_struct work; /* to free in WQ context. */;
+};
+
+static DEFINE_MUTEX(sched_core_tasks_mutex);
+
+/* All active sched_core_cookies */
+static struct rb_root sched_core_cookies = RB_ROOT;
+static DEFINE_RAW_SPINLOCK(sched_core_cookies_lock);
+
+/*
+ * Returns the following:
+ * a < b  => -1
+ * a == b => 0
+ * a > b  => 1
+ */
+static int sched_core_cookie_cmp(const struct sched_core_cookie *a,
+				 const struct sched_core_cookie *b)
+{
+#define COOKIE_CMP_RETURN(field) do {		\
+	if (a->field < b->field)		\
+		return -1;			\
+	else if (a->field > b->field)		\
+		return 1;			\
+} while (0)					\
+
+	COOKIE_CMP_RETURN(task_cookie);
+	COOKIE_CMP_RETURN(group_cookie);
+	COOKIE_CMP_RETURN(color);
+
+	/* all cookie fields match */
+	return 0;
+
+#undef COOKIE_CMP_RETURN
+}
+
+static inline void __sched_core_erase_cookie(struct sched_core_cookie *cookie)
+{
+	lockdep_assert_held(&sched_core_cookies_lock);
+
+	/* Already removed */
+	if (RB_EMPTY_NODE(&cookie->node))
+		return;
+
+	rb_erase(&cookie->node, &sched_core_cookies);
+	RB_CLEAR_NODE(&cookie->node);
+}
+
+/* Called when a task no longer points to the cookie in question */
+static void sched_core_put_cookie(struct sched_core_cookie *cookie)
+{
+	unsigned long flags;
+
+	if (!cookie)
+		return;
+
+	if (refcount_dec_and_test(&cookie->refcnt)) {
+		raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
+		__sched_core_erase_cookie(cookie);
+		raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
+		kfree(cookie);
+	}
+}
+
+/*
+ * A task's core cookie is a compound structure composed of various cookie
+ * fields (task_cookie, group_cookie, color). The overall core_cookie is
+ * a pointer to a struct containing those values. This function either finds
+ * an existing core_cookie or creates a new one, and then updates the task's
+ * core_cookie to point to it. Additionally, it handles the necessary reference
+ * counting.
+ *
+ * REQUIRES: task_rq(p) lock or called from cpu_stopper.
+ * Doing so ensures that we do not cause races/corruption by modifying/reading
+ * task cookie fields.
+ */
+static void __sched_core_update_cookie(struct task_struct *p)
+{
+	struct rb_node *parent, **node;
+	struct sched_core_cookie *node_core_cookie, *match;
+	static const struct sched_core_cookie zero_cookie;
+	struct sched_core_cookie temp = {
+		.task_cookie	= p->core_task_cookie,
+		.group_cookie	= p->core_group_cookie,
+		.color		= p->core_color
+	};
+	const bool is_zero_cookie =
+		(sched_core_cookie_cmp(&temp, &zero_cookie) == 0);
+	struct sched_core_cookie *const curr_cookie =
+		(struct sched_core_cookie *)p->core_cookie;
+	unsigned long flags;
+
+	/*
+	 * Already have a cookie matching the requested settings? Nothing to
+	 * do.
+	 */
+	if ((curr_cookie && sched_core_cookie_cmp(curr_cookie, &temp) == 0) ||
+	    (!curr_cookie && is_zero_cookie))
+		return;
+
+	raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
+
+	if (is_zero_cookie) {
+		match = NULL;
+		goto finish;
+	}
+
+retry:
+	match = NULL;
+
+	node = &sched_core_cookies.rb_node;
+	parent = *node;
+	while (*node) {
+		int cmp;
+
+		node_core_cookie =
+			container_of(*node, struct sched_core_cookie, node);
+		parent = *node;
+
+		cmp = sched_core_cookie_cmp(&temp, node_core_cookie);
+		if (cmp < 0) {
+			node = &parent->rb_left;
+		} else if (cmp > 0) {
+			node = &parent->rb_right;
+		} else {
+			match = node_core_cookie;
+			break;
+		}
+	}
+
+	if (!match) {
+		/* No existing cookie; create and insert one */
+		match = kmalloc(sizeof(struct sched_core_cookie), GFP_ATOMIC);
+
+		/* Fall back to zero cookie */
+		if (WARN_ON_ONCE(!match))
+			goto finish;
+
+		match->task_cookie = temp.task_cookie;
+		match->group_cookie = temp.group_cookie;
+		match->color = temp.color;
+		refcount_set(&match->refcnt, 1);
+
+		rb_link_node(&match->node, parent, node);
+		rb_insert_color(&match->node, &sched_core_cookies);
+	} else {
+		/*
+		 * Cookie exists, increment refcnt. If refcnt is currently 0,
+		 * we're racing with a put() (refcnt decremented but cookie not
+		 * yet removed from the tree). In this case, we can simply
+		 * perform the removal ourselves and retry.
+		 * sched_core_put_cookie() will still function correctly.
+		 */
+		if (unlikely(!refcount_inc_not_zero(&match->refcnt))) {
+			__sched_core_erase_cookie(match);
+			goto retry;
+		}
+	}
+
+finish:
+	/*
+	 * Set the core_cookie under the cookies lock. This guarantees that
+	 * p->core_cookie cannot be freed while the cookies lock is held in
+	 * sched_core_fork().
+	 */
+	p->core_cookie = (unsigned long)match;
+
+	raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
+
+	sched_core_put_cookie(curr_cookie);
+}
+
+/*
+ * sched_core_update_cookie - Common helper to update a task's core cookie. This
+ * updates the selected cookie field and then updates the overall cookie.
+ * @p: The task whose cookie should be updated.
+ * @cookie: The new cookie.
+ * @cookie_type: The cookie field to which the cookie corresponds.
+ *
+ * REQUIRES: either task_rq(p)->lock held or called from a stop-machine handler.
+ * Doing so ensures that we do not cause races/corruption by modifying/reading
+ * task cookie fields.
+ */
+static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
+				     enum sched_core_cookie_type cookie_type)
+{
+	if (!p)
+		return;
+
+	switch (cookie_type) {
+	case sched_core_no_update:
+		break;
+	case sched_core_task_cookie_type:
+		p->core_task_cookie = cookie;
+		break;
+	case sched_core_group_cookie_type:
+		p->core_group_cookie = cookie;
+		break;
+	case sched_core_color_type:
+		p->core_color = cookie;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	/* Set p->core_cookie, which is the overall cookie */
+	__sched_core_update_cookie(p);
+
+	if (sched_core_enqueued(p)) {
+		sched_core_dequeue(task_rq(p), p);
+		if (!p->core_cookie)
+			return;
+	}
+
+	if (sched_core_enabled(task_rq(p)) &&
+	    p->core_cookie && task_on_rq_queued(p))
+		sched_core_enqueue(task_rq(p), p);
+}
+
+#ifdef CONFIG_CGROUP_SCHED
+void cpu_core_get_group_cookie_and_color(struct task_group *tg,
+					 unsigned long *group_cookie_ptr,
+					 unsigned long *color_ptr);
+
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
+{
+	unsigned long new_group_cookie, new_color;
+
+	cpu_core_get_group_cookie_and_color(new_tg, &new_group_cookie,
+					    &new_color);
+
+	if (p->core_group_cookie == new_group_cookie &&
+	    p->core_color == new_color)
+		return;
+
+	p->core_group_cookie = new_group_cookie;
+	p->core_color = new_color;
+
+	__sched_core_update_cookie(p);
+}
+#endif
+
+/* Per-task interface: Used by fork(2) and prctl(2). */
+static void sched_core_put_cookie_work(struct work_struct *ws);
+
+static unsigned long sched_core_alloc_task_cookie(void)
+{
+	struct sched_core_task_cookie *ck =
+		kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);
+
+	if (!ck)
+		return 0;
+	refcount_set(&ck->refcnt, 1);
+	INIT_WORK(&ck->work, sched_core_put_cookie_work);
+
+	/*
+	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
+	 * is done after the stopper runs.
+	 */
+	sched_core_get();
+	return (unsigned long)ck;
+}
+
+static bool sched_core_get_task_cookie(unsigned long cookie)
+{
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
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
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
+
+	if (refcount_dec_and_test(&ptr->refcnt))
+		kfree(ptr);
+}
+
+static void sched_core_put_cookie_work(struct work_struct *ws)
+{
+	struct sched_core_task_cookie *ck =
+		container_of(ws, struct sched_core_task_cookie, work);
+
+	sched_core_put_task_cookie((unsigned long)ck);
+	sched_core_put();
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
+		sched_core_update_cookie(tag->tasks[i], tag->cookies[i],
+					 sched_core_task_cookie_type);
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
+	if (!t2) {
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
+	} else if (!t1->core_task_cookie && !t2->core_task_cookie) {
+		/*
+		 * 		t1		joining		t2
+		 * CASE 1:
+		 * before	0				0
+		 * after	new cookie			new cookie
+		 *
+		 * CASE 2:
+		 * before	X (non-zero)			0
+		 * after	0				0
+		 *
+		 * CASE 3:
+		 * before	0				X (non-zero)
+		 * after	X				X
+		 *
+		 * CASE 4:
+		 * before	Y (non-zero)			X (non-zero)
+		 * after	X				X
+		 */
+
+		/* CASE 1. */
+		cookie = sched_core_alloc_task_cookie();
+		if (!cookie)
+			goto out_unlock;
+
+		/* Add another reference for the other task. */
+		if (!sched_core_get_task_cookie(cookie)) {
+			ret = -EINVAL;
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
+			goto out;
+		}
+		rcu_read_unlock();
+	}
+
+	err = sched_core_share_tasks(current, task);
+out:
+	if (task)
+		put_task_struct(task);
+	return err;
+}
+
+/* CGroup core-scheduling interface support. */
+#ifdef CONFIG_CGROUP_SCHED
+/*
+ * Helper to get the group cookie and color in a hierarchy.
+ * Any ancestor can have a tag/color. Atmost one color and one
+ * tag is allowed.
+ * Sets *group_cookie_ptr and *color_ptr to the hierarchical group cookie
+ * and color.
+ */
+void cpu_core_get_group_cookie_and_color(struct task_group *tg,
+					 unsigned long *group_cookie_ptr,
+					 unsigned long *color_ptr)
+{
+	unsigned long group_cookie = 0UL;
+	unsigned long color = 0UL;
+
+	if (!tg)
+		goto out;
+
+	for (; tg; tg = tg->parent) {
+		if (tg->core_tag_color) {
+			WARN_ON_ONCE(color);
+			color = tg->core_tag_color;
+		}
+
+		if (tg->core_tagged) {
+			group_cookie = (unsigned long)tg;
+			break;
+		}
+	}
+
+out:
+	*group_cookie_ptr = group_cookie;
+	*color_ptr = color;
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
+	unsigned long group_cookie, color;
+
+	cpu_core_get_group_cookie_and_color(css_tg(css), &group_cookie, &color);
+
+	/*
+	 * Combine group_cookie and color into a single 64 bit value, for
+	 * display purposes only.
+	 */
+	return (group_cookie << 32) | (color & 0xffffffff);
+}
+#endif
+
+struct write_core_tag {
+	struct cgroup_subsys_state *css;
+	unsigned long cookie;
+	enum sched_core_cookie_type cookie_type;
+};
+
+static int __sched_write_tag(void *data)
+{
+	struct write_core_tag *tag = (struct write_core_tag *)data;
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
+			sched_core_update_cookie(p, tag->cookie,
+						 tag->cookie_type);
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
+	unsigned long group_cookie, color;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	if (!tg->core_tagged && val) {
+		/* Tag is being set. Check ancestors and descendants. */
+		cpu_core_get_group_cookie_and_color(tg, &group_cookie, &color);
+		if (group_cookie ||
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
+	wtag.cookie = (unsigned long)tg;
+	wtag.cookie_type = sched_core_group_cookie_type;
+
+	tg->core_tagged = val;
+
+	stop_machine(__sched_write_tag, (void *)&wtag, NULL);
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
+	unsigned long group_cookie, color;
+
+	if (val > ULONG_MAX)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	cpu_core_get_group_cookie_and_color(tg, &group_cookie, &color);
+	/* Can't set color if nothing in the ancestors were tagged. */
+	if (!group_cookie)
+		return -EINVAL;
+
+	/*
+	 * Something in the ancestors already colors us. Can't change the color
+	 * at this level.
+	 */
+	if (!tg->core_tag_color && color)
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
+	wtag.css = css;
+	wtag.cookie = val;
+	wtag.cookie_type = sched_core_color_type;
+	tg->core_tag_color = val;
+
+	stop_machine(__sched_write_tag, (void *)&wtag, NULL);
+
+	return 0;
+}
+#endif
+
+/*
+ * Tagging support when fork(2) is called:
+ * If it is a CLONE_THREAD fork, share parent's tag. Otherwise assign a unique per-task tag.
+ */
+static int sched_update_core_tag_stopper(void *data)
+{
+	struct task_struct *p = (struct task_struct *)data;
+
+	/* Recalculate core cookie */
+	sched_core_update_cookie(p, 0, sched_core_no_update);
+
+	return 0;
+}
+
+/* Called from sched_fork() */
+int sched_core_fork(struct task_struct *p, unsigned long clone_flags)
+{
+	struct sched_core_cookie *parent_cookie =
+		(struct sched_core_cookie *)current->core_cookie;
+
+	/*
+	 * core_cookie is ref counted; avoid an uncounted reference.
+	 * If p should have a cookie, it will be set below.
+	 */
+	p->core_cookie = 0UL;
+
+	/*
+	 * If parent is tagged via per-task cookie, tag the child (either with
+	 * the parent's cookie, or a new one).
+	 *
+	 * We can return directly in this case, because sched_core_share_tasks()
+	 * will set the core_cookie (so there is no need to try to inherit from
+	 * the parent). The cookie will have the proper sub-fields (ie. group
+	 * cookie, etc.), because these come from p's task_struct, which is
+	 * dup'd from the parent.
+	 */
+	if (current->core_task_cookie) {
+		int ret;
+
+		/* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
+		if (!(clone_flags & CLONE_THREAD)) {
+			ret = sched_core_share_tasks(p, p);
+		} else {
+			/* Otherwise share the parent's per-task tag. */
+			ret = sched_core_share_tasks(p, current);
+		}
+
+		if (ret)
+			return ret;
+
+		/*
+		 * We expect sched_core_share_tasks() to always update p's
+		 * core_cookie.
+		 */
+		WARN_ON_ONCE(!p->core_cookie);
+
+		return 0;
+	}
+
+	/*
+	 * If parent is tagged, inherit the cookie and ensure that the reference
+	 * count is updated.
+	 *
+	 * Technically, we could instead zero-out the task's group_cookie and
+	 * allow sched_core_change_group() to handle this post-fork, but
+	 * inheriting here has a performance advantage, since we don't
+	 * need to traverse the core_cookies RB tree and can instead grab the
+	 * parent's cookie directly.
+	 */
+	if (parent_cookie) {
+		bool need_stopper = false;
+		unsigned long flags;
+
+		/*
+		 * cookies lock prevents task->core_cookie from changing or
+		 * being freed
+		 */
+		raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
+
+		if (likely(refcount_inc_not_zero(&parent_cookie->refcnt))) {
+			p->core_cookie = (unsigned long)parent_cookie;
+		} else {
+			/*
+			 * Raced with put(). We'll use stop_machine to get
+			 * a core_cookie
+			 */
+			need_stopper = true;
+		}
+
+		raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
+
+		if (need_stopper)
+			stop_machine(sched_update_core_tag_stopper,
+				     (void *)p, NULL);
+	}
+
+	return 0;
+}
+
+void sched_tsk_free(struct task_struct *tsk)
+{
+	struct sched_core_task_cookie *ck;
+
+	sched_core_put_cookie((struct sched_core_cookie *)tsk->core_cookie);
+
+	if (!tsk->core_task_cookie)
+		return;
+
+	ck = (struct sched_core_task_cookie *)tsk->core_task_cookie;
+	queue_work(system_wq, &ck->work);
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ca22918b69a..a99c24740e4b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -430,6 +430,11 @@ struct task_group {
 
 };
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
@@ -1185,12 +1190,53 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 void sched_core_change_group(struct task_struct *p, struct task_group *new_tg);
 int sched_core_fork(struct task_struct *p, unsigned long clone_flags);
 
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
+int sched_core_share_pid(pid_t pid);
+int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
+
+#ifdef CONFIG_CGROUP_SCHED
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
+#endif
+
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#endif
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 #else /* !CONFIG_SCHED_CORE */
 
+static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return false;
@@ -2871,7 +2917,4 @@ void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
 #ifdef CONFIG_SCHED_CORE
-#ifndef TIF_UNSAFE_RET
-#define TIF_UNSAFE_RET (0)
-#endif
 #endif
-- 
2.29.2.299.gdc1121823c-goog

