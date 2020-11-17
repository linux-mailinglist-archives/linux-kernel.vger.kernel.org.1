Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4112B7235
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgKQXVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgKQXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:02 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD45C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:01 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id r12so76658qvq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GFXuuExKORe1IECnfv7WB6nkE5QZoKjYKK4+7vHzH8=;
        b=WJz8Jtmi8soQOKhI0TefYgK8i74kzfqdSSYlJsDOwzmYdTp7gxLFgs7D0fazk421F/
         Ve/5y67sarOjOu2qipLVv3GU6B7aFlKJ4XH5TFweHrkEcFL8FrycRIJjEAndq7+1pRa4
         VeLtxi9c3RpLNyfD0ypfBWO0o/2aF/38FkH7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GFXuuExKORe1IECnfv7WB6nkE5QZoKjYKK4+7vHzH8=;
        b=co7gLBLZmVV1d15dF9PXN3nXqAtgYfcPOpaG09WtBWBFAmkMvAv6wljCdXUZBU1VlM
         Oa5gr3kK1SlhmtRB6fW92qj0FP78CHjCG4AyRbLa6Kb9gEouwPyw+wXpyET3QSvuWZei
         eg4G+YMzF7QSqb6ZOkW0lTsDRNwImm0PG5CzhFD+5E/succPkZ53ZauvDjTFXXbCJa7T
         MTecdz9+9OMaNHofMvA2UlyFxfVtM4E1a5FfM87z04Y3n8x/jvvUPnA6ujibzMq6kJRg
         STDbXnkrK+JfbPeSa7lY/qL2Xov/E90gjR5oKAPrahjiw1MbIKtbHrmVXD43CijZdy2N
         YiAw==
X-Gm-Message-State: AOAM530LGSYv2+h2JR4yDj470gIhipP1ow9NFbtaTBwKy0CJuyY6sgTp
        +F4o1YLMuKozJwkD5nLsBGExRw==
X-Google-Smtp-Source: ABdhPJx0czwIBbv3ySmmIiYGBjlLquRARcFbUVTQwFS62gd900eLeppISCM90dbwMfwFEXsxB652aw==
X-Received: by 2002:a0c:db8c:: with SMTP id m12mr1827338qvk.11.1605655260801;
        Tue, 17 Nov 2020 15:21:00 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:21:00 -0800 (PST)
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
Subject: [PATCH -tip 25/32] sched: Refactor core cookie into struct
Date:   Tue, 17 Nov 2020 18:19:55 -0500
Message-Id: <20201117232003.3580179-26-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Don <joshdon@google.com>

The overall core cookie is currently a single unsigned long value. This
poses issues as we seek to add additional sub-fields to the cookie. This
patch refactors the core_cookie to be a pointer to a struct containing
an arbitrary set of cookie fields.

We maintain a sorted RB tree of existing core cookies so that multiple
tasks may share the same core_cookie.

This will be especially useful in the next patch, where the concept of
cookie color is introduced.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 481 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  11 +-
 2 files changed, 429 insertions(+), 63 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cc36c384364e..bd75b3d62a97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3958,6 +3958,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	int __maybe_unused ret;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -4037,20 +4038,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SCHED_CORE
 	RB_CLEAR_NODE(&p->core_node);
 
-	/*
-	 * If parent is tagged via per-task cookie, tag the child (either with
-	 * the parent's cookie, or a new one). The final cookie is calculated
-	 * by concatenating the per-task cookie with that of the CGroup's.
-	 */
-	if (current->core_task_cookie) {
-
-		/* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
-		if (!(clone_flags & CLONE_THREAD)) {
-			return sched_core_share_tasks(p, p);
-               }
-		/* Otherwise share the parent's per-task tag. */
-		return sched_core_share_tasks(p, current);
-	}
+	ret = sched_core_fork(p, clone_flags);
+	if (ret)
+		return ret;
 #endif
 	return 0;
 }
@@ -9059,6 +9049,9 @@ void sched_offline_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
+void cpu_core_get_group_cookie(struct task_group *tg,
+			       unsigned long *group_cookie_ptr);
+
 static void sched_change_group(struct task_struct *tsk, int type)
 {
 	struct task_group *tg;
@@ -9073,11 +9066,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = autogroup_task_group(tsk, tg);
 
 #ifdef CONFIG_SCHED_CORE
-	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
-		tsk->core_cookie = 0UL;
-
-	if (tg->tagged /* && !tsk->core_cookie ? */)
-		tsk->core_cookie = (unsigned long)tg;
+	sched_core_change_group(tsk, tg);
 #endif
 
 	tsk->sched_task_group = tg;
@@ -9177,9 +9166,9 @@ static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
 #ifdef CONFIG_SCHED_CORE
 	struct task_group *tg = css_tg(css);
 
-	if (tg->tagged) {
+	if (tg->core_tagged) {
 		sched_core_put();
-		tg->tagged = 0;
+		tg->core_tagged = 0;
 	}
 #endif
 }
@@ -9751,38 +9740,225 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 
 #ifdef CONFIG_SCHED_CORE
 /*
- * A simple wrapper around refcount. An allocated sched_core_cookie's
- * address is used to compute the cookie of the task.
+ * Wrapper representing a complete cookie. The address of the cookie is used as
+ * a unique identifier. Each cookie has a unique permutation of the internal
+ * cookie fields.
  */
 struct sched_core_cookie {
+	unsigned long task_cookie;
+	unsigned long group_cookie;
+
+	struct rb_node node;
 	refcount_t refcnt;
 };
 
 /*
- * sched_core_tag_requeue - Common helper for all interfaces to set a cookie.
- * @p: The task to assign a cookie to.
- * @cookie: The cookie to assign.
- * @group: is it a group interface or a per-task interface.
+ * A simple wrapper around refcount. An allocated sched_core_task_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_task_cookie {
+	refcount_t refcnt;
+};
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
+ * fields (task_cookie, group_cookie). The overall core_cookie is
+ * a pointer to a struct containing those values. This function either finds
+ * an existing core_cookie or creates a new one, and then updates the task's
+ * core_cookie to point to it. Additionally, it handles the necessary reference
+ * counting.
  *
- * This function is typically called from a stop-machine handler.
+ * REQUIRES: task_rq(p) lock or called from cpu_stopper.
+ * Doing so ensures that we do not cause races/corruption by modifying/reading
+ * task cookie fields.
  */
-void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
+static void __sched_core_update_cookie(struct task_struct *p)
+{
+	struct rb_node *parent, **node;
+	struct sched_core_cookie *node_core_cookie, *match;
+	static const struct sched_core_cookie zero_cookie;
+	struct sched_core_cookie temp = {
+		.task_cookie	= p->core_task_cookie,
+		.group_cookie	= p->core_group_cookie,
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
 {
 	if (!p)
 		return;
 
-	if (group)
-		p->core_group_cookie = cookie;
-	else
+	switch (cookie_type) {
+	case sched_core_no_update:
+		break;
+	case sched_core_task_cookie_type:
 		p->core_task_cookie = cookie;
+		break;
+	case sched_core_group_cookie_type:
+		p->core_group_cookie = cookie;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
 
-	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
-	p->core_cookie = (p->core_task_cookie <<
-				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
+	/* Set p->core_cookie, which is the overall cookie */
+	__sched_core_update_cookie(p);
 
 	if (sched_core_enqueued(p)) {
 		sched_core_dequeue(task_rq(p), p);
-		if (!p->core_task_cookie)
+		if (!p->core_cookie)
 			return;
 	}
 
@@ -9791,11 +9967,28 @@ void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool gr
 		sched_core_enqueue(task_rq(p), p);
 }
 
+void cpu_core_get_group_cookie(struct task_group *tg,
+			       unsigned long *group_cookie_ptr);
+
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
+{
+	unsigned long new_group_cookie;
+
+	cpu_core_get_group_cookie(new_tg, &new_group_cookie);
+
+	if (p->core_group_cookie == new_group_cookie)
+		return;
+
+	p->core_group_cookie = new_group_cookie;
+
+	__sched_core_update_cookie(p);
+}
+
 /* Per-task interface */
 static unsigned long sched_core_alloc_task_cookie(void)
 {
-	struct sched_core_cookie *ptr =
-		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
+	struct sched_core_task_cookie *ptr =
+		kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);
 
 	if (!ptr)
 		return 0;
@@ -9811,7 +10004,8 @@ static unsigned long sched_core_alloc_task_cookie(void)
 
 static bool sched_core_get_task_cookie(unsigned long cookie)
 {
-	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
 
 	/*
 	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
@@ -9823,7 +10017,8 @@ static bool sched_core_get_task_cookie(unsigned long cookie)
 
 static void sched_core_put_task_cookie(unsigned long cookie)
 {
-	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
 
 	if (refcount_dec_and_test(&ptr->refcnt))
 		kfree(ptr);
@@ -9845,7 +10040,8 @@ static int sched_core_task_join_stopper(void *data)
 	int i;
 
 	for (i = 0; i < 2; i++)
-		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
+		sched_core_update_cookie(tag->tasks[i], tag->cookies[i],
+					 sched_core_task_cookie_type);
 
 	return 0;
 }
@@ -10002,41 +10198,89 @@ int sched_core_share_pid(pid_t pid)
 }
 
 /* CGroup interface */
+
+/*
+ * Helper to get the group cookie and color in a hierarchy.
+ * Any ancestor can have a tag/color. Atmost one color and one
+ * tag is allowed.
+ * Sets *group_cookie_ptr to the hierarchical group cookie.
+ */
+void cpu_core_get_group_cookie(struct task_group *tg,
+			       unsigned long *group_cookie_ptr)
+{
+	unsigned long group_cookie = 0UL;
+
+	if (!tg)
+		goto out;
+
+	for (; tg; tg = tg->parent) {
+
+		if (tg->core_tagged) {
+			group_cookie = (unsigned long)tg;
+			break;
+		}
+	}
+
+out:
+	*group_cookie_ptr = group_cookie;
+}
+
+/* Determine if any group in @tg's children are tagged. */
+static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag)
+{
+	struct task_group *child;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		if ((child->core_tagged && check_tag)) {
+			rcu_read_unlock();
+			return true;
+		}
+
+		rcu_read_unlock();
+		return cpu_core_check_descendants(child, check_tag);
+	}
+
+	rcu_read_unlock();
+	return false;
+}
+
 static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 {
 	struct task_group *tg = css_tg(css);
 
-	return !!tg->tagged;
+	return !!tg->core_tagged;
 }
 
 struct write_core_tag {
 	struct cgroup_subsys_state *css;
-	int val;
+	unsigned long cookie;
+	enum sched_core_cookie_type cookie_type;
 };
 
 static int __sched_write_tag(void *data)
 {
 	struct write_core_tag *tag = (struct write_core_tag *) data;
-	struct cgroup_subsys_state *css = tag->css;
-	int val = tag->val;
-	struct task_group *tg = css_tg(tag->css);
-	struct css_task_iter it;
 	struct task_struct *p;
+	struct cgroup_subsys_state *css;
 
-	tg->tagged = !!val;
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, tag->css) {
+		struct css_task_iter it;
 
-	css_task_iter_start(css, 0, &it);
-	/*
-	 * Note: css_task_iter_next will skip dying tasks.
-	 * There could still be dying tasks left in the core queue
-	 * when we set cgroup tag to 0 when the loop is done below.
-	 */
-	while ((p = css_task_iter_next(&it))) {
-		unsigned long cookie = !!val ? (unsigned long)tg : 0UL;
+		css_task_iter_start(css, 0, &it);
+		/*
+		 * Note: css_task_iter_next will skip dying tasks.
+		 * There could still be dying tasks left in the core queue
+		 * when we set cgroup tag to 0 when the loop is done below.
+		 */
+		while ((p = css_task_iter_next(&it)))
+			sched_core_update_cookie(p, tag->cookie,
+						 tag->cookie_type);
 
-		sched_core_tag_requeue(p, cookie, true /* group */);
+		css_task_iter_end(&it);
 	}
-	css_task_iter_end(&it);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -10045,6 +10289,7 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 {
 	struct task_group *tg = css_tg(css);
 	struct write_core_tag wtag;
+	unsigned long group_cookie;
 
 	if (val > 1)
 		return -ERANGE;
@@ -10052,14 +10297,29 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 	if (!static_branch_likely(&sched_smt_present))
 		return -EINVAL;
 
-	if (tg->tagged == !!val)
+	if (!tg->core_tagged && val) {
+		/* Tag is being set. Check ancestors and descendants. */
+		cpu_core_get_group_cookie(tg, &group_cookie);
+		if (group_cookie ||
+		    cpu_core_check_descendants(tg, true /* tag */))
+			return -EBUSY;
+	} else if (tg->core_tagged && !val) {
+		/* Tag is being reset. Check descendants. */
+		if (cpu_core_check_descendants(tg, true /* tag */))
+			return -EBUSY;
+	} else {
 		return 0;
+	}
 
 	if (!!val)
 		sched_core_get();
 
 	wtag.css = css;
-	wtag.val = val;
+	wtag.cookie = (unsigned long)tg;
+	wtag.cookie_type = sched_core_group_cookie_type;
+
+	tg->core_tagged = val;
+
 	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
 	if (!val)
 		sched_core_put();
@@ -10067,8 +10327,105 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 	return 0;
 }
 
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
 void sched_tsk_free(struct task_struct *tsk)
 {
+	sched_core_put_cookie((struct sched_core_cookie *)tsk->core_cookie);
+
 	if (!tsk->core_task_cookie)
 		return;
 	sched_core_put_task_cookie(tsk->core_task_cookie);
@@ -10114,7 +10471,7 @@ static struct cftype cpu_legacy_files[] = {
 #endif
 #ifdef CONFIG_SCHED_CORE
 	{
-		.name = "tag",
+		.name = "core_tag",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_core_tag_read_u64,
 		.write_u64 = cpu_core_tag_write_u64,
@@ -10295,7 +10652,7 @@ static struct cftype cpu_files[] = {
 #endif
 #ifdef CONFIG_SCHED_CORE
 	{
-		.name = "tag",
+		.name = "core_tag",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_core_tag_read_u64,
 		.write_u64 = cpu_core_tag_write_u64,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ba08973ed58..042a9d6a3be9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -378,7 +378,7 @@ struct task_group {
 	struct cgroup_subsys_state css;
 
 #ifdef CONFIG_SCHED_CORE
-	int			tagged;
+	int			core_tagged;
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1130,6 +1130,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #ifdef CONFIG_SCHED_CORE
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+enum sched_core_cookie_type {
+	sched_core_no_update = 0,
+	sched_core_task_cookie_type,
+	sched_core_group_cookie_type,
+};
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
@@ -1174,6 +1180,9 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	return idle_core || rq->core->core_cookie == p->core_cookie;
 }
 
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg);
+int sched_core_fork(struct task_struct *p, unsigned long clone_flags);
+
 extern void queue_core_balance(struct rq *rq);
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
-- 
2.29.2.299.gdc1121823c-goog

