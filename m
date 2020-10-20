Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B42932DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgJTBoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390205AbgJTBoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C98C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:37 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p15so607584ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDJtUziN9hXOYg4zFHFJKo0bkwSTQiXwKmD5T0Pc/LQ=;
        b=ayhwrU/beXWlJqGhuwcg66dGmMlj7SRo+F0RKk3nFjDNSmMKWtM3P7UQ4SLOvOFGH2
         ppXGWMUBDAnmw63yCWGah3FMlZ4vo7BiK0/NxOvAfjU+iSm+iFpSVXX+RM/3CzJIIFzH
         x2XyyuVr5PoNr0pTAxw5fu7KY/CjdOe36PpBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDJtUziN9hXOYg4zFHFJKo0bkwSTQiXwKmD5T0Pc/LQ=;
        b=GM9PCmuqsJxZn33kPm7ubtpDQOqoXJ9FtQLXUphutDeQECFoNYjBkDsxJCzuNZ9cI1
         7GYoNE664CVA6lLUkOHTbUA1LVGf61n08v1/gXCjkc8frrQEk/JqgQ+CYuZnyoarR9Jq
         ZzyFjfiUleFBe9LTwYKU42f45AsQIRllvbwTgA33/2nGNH6FQSbft6rpa4FSHVBLygWw
         f3TXq4XnTBxk0/6KX0V9q3A6DUX0pYi8I29seKjVwydHnVGJgZr/2CGVfnb5kei8gRtr
         gCXLOBOdlUGotHzeHC303e8Rg4xXQlLh4x3PzyA7wF9Vx5mh/7cnSHOD1q2us3HupGi+
         BnRQ==
X-Gm-Message-State: AOAM530ibikV1Y7C4DsogsFZJpXg9lplxpMgUkW4chw1HNNO6rW7mhO7
        OWto0q4UKvDaH2W6owlWYGeEvg==
X-Google-Smtp-Source: ABdhPJx3pz4X3ehrCehdmN64kT4XetSaSt0avXh9idACIje3yXGLYAtAG47u7algDWjht1OnqPpxUw==
X-Received: by 2002:a6b:f416:: with SMTP id i22mr472209iog.161.1603158276604;
        Mon, 19 Oct 2020 18:44:36 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:36 -0700 (PDT)
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
Subject: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task cookie on fork
Date:   Mon, 19 Oct 2020 21:43:27 -0400
Message-Id: <20201020014336.2076526-18-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent interference and clearly support both per-task and CGroup
APIs, split the cookie into 2 and allow it to be set from either per-task, or
CGroup API. The final cookie is the combined value of both and is computed when
the stop-machine executes during a change of cookie.

Also, for the per-task cookie, it will get weird if we use pointers of any
emphemeral objects. For this reason, introduce a refcounted object who's sole
purpose is to assign unique cookie value by way of the object's pointer.

While at it, refactor the CGroup code a bit. Future patches will introduce more
APIs and support.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h |   2 +
 kernel/sched/core.c   | 241 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/debug.c  |   4 +
 3 files changed, 236 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fe6f225bfbf9..c6034c00846a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -688,6 +688,8 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned long			core_task_cookie;
+	unsigned long			core_group_cookie;
 	unsigned int			core_occupation;
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bab4ea2f5cd8..30a9e4cb5ce1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -346,11 +346,14 @@ void sched_core_put(void)
 	mutex_unlock(&sched_core_mutex);
 }
 
+static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
 static bool sched_core_enqueued(struct task_struct *task) { return false; }
+static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -3583,6 +3586,20 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 #ifdef CONFIG_SCHED_CORE
 	RB_CLEAR_NODE(&p->core_node);
+
+	/*
+	 * Tag child via per-task cookie only if parent is tagged via per-task
+	 * cookie. This is independent of, but can be additive to the CGroup tagging.
+	 */
+	if (current->core_task_cookie) {
+
+		/* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
+		if (!(clone_flags & CLONE_THREAD)) {
+			return sched_core_share_tasks(p, p);
+               }
+		/* Otherwise share the parent's per-task tag. */
+		return sched_core_share_tasks(p, current);
+	}
 #endif
 	return 0;
 }
@@ -9177,6 +9194,217 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 #ifdef CONFIG_SCHED_CORE
+/*
+ * A simple wrapper around refcount. An allocated sched_core_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_cookie {
+	refcount_t refcnt;
+};
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
+		if (!p->core_task_cookie)
+			return;
+	}
+
+	if (sched_core_enabled(task_rq(p)) &&
+			p->core_cookie && task_on_rq_queued(p))
+		sched_core_enqueue(task_rq(p), p);
+}
+
+/* Per-task interface */
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
+static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
+{
+	struct sched_core_task_write_tag wr = {}; /* for stop machine. */
+	bool sched_core_put_after_stopper = false;
+	unsigned long cookie;
+	int ret = -ENOMEM;
+
+	mutex_lock(&sched_core_mutex);
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
+	mutex_unlock(&sched_core_mutex);
+	return ret;
+}
+
+/* CGroup interface */
 static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 {
 	struct task_group *tg = css_tg(css);
@@ -9207,18 +9435,9 @@ static int __sched_write_tag(void *data)
 	 * when we set cgroup tag to 0 when the loop is done below.
 	 */
 	while ((p = css_task_iter_next(&it))) {
-		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
-
-		if (sched_core_enqueued(p)) {
-			sched_core_dequeue(task_rq(p), p);
-			if (!p->core_cookie)
-				continue;
-		}
-
-		if (sched_core_enabled(task_rq(p)) &&
-		    p->core_cookie && task_on_rq_queued(p))
-			sched_core_enqueue(task_rq(p), p);
+		unsigned long cookie = !!val ? (unsigned long)tg : 0UL;
 
+		sched_core_tag_requeue(p, cookie, true /* group */);
 	}
 	css_task_iter_end(&it);
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c8fee8d9dfd4..88bf45267672 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1024,6 +1024,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		__PS("clock-delta", t1-t0);
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	__PS("core_cookie", p->core_cookie);
+#endif
+
 	sched_show_numa(p, m);
 }
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

