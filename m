Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EE3011FA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAWBUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbhAWBRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:17:52 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677FBC061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:12 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h22so7112580qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0ElZ/BbWivtb3pu9iX4C+6MGiIHYdkJNzI6Y4NkoCU=;
        b=qHgGXVQB3+G9z+bgRdrTOlYskOnyL/6YvZsrcXtm/s2CTiAFT5ZVsrehF2MFbiM+jt
         tobcTbtKrGRbMGKJIhfVqbOAeEndHBc6eZ7+GCrWCqelkSbPyAp1Cobi7UBYcvjQcw3r
         jSPcwyAwcw3zKt8fuQlCxG61wt6cE+/2jhpR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0ElZ/BbWivtb3pu9iX4C+6MGiIHYdkJNzI6Y4NkoCU=;
        b=XLny2HjW4qKyXSUGL969M/X3u35pCtTxcT8fcYjpA+KjUcxJzc/NilKoZcQXz6uz0k
         JoPSpv2BLqBoRo5lKq0jrdpQqctimNSTRlecOJHoCLBGTWz7GDeWLXbP+9NwJwhFIK+u
         SJFFvq3+/zXNMPu71BSdW++h8ji8R5wcCLBtb0U+smK1ZYfN9u9t9Anzij3v0ci30IA5
         mT4v9ov1NW0HwVPiSKePqfDhx957ECWvtPEpw3tykTaeq7aXnTp7q32Msa6XcWV/9IIj
         /v0GzGIvHPQ18NibL/6KZUwgjdsImJjJJIDuclZea7SFdlFC141dABSsKu5f3fif+YMP
         UtUQ==
X-Gm-Message-State: AOAM531jOYJYyO2G8zQQy+V2so4Tvbpra0MpPK6jiXG8zEPaCEb/NmH0
        K9yTf/D058ZPVcH3VS0JU0xGfA==
X-Google-Smtp-Source: ABdhPJyVjy+YdDFG0/SXu0qxBHS5/6ge6z/dWq2HHpOzEaSznXsUYUHaluRttzDFqUs7rbZMBI01Bg==
X-Received: by 2002:a37:7104:: with SMTP id m4mr3849397qkc.5.1611364631368;
        Fri, 22 Jan 2021 17:17:11 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x15sm2516840qtr.72.2021.01.22.17.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:17:10 -0800 (PST)
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
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v10 2/5] sched: CGroup tagging interface for core scheduling
Date:   Fri, 22 Jan 2021 20:17:01 -0500
Message-Id: <20210123011704.1901835-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123011704.1901835-1-joel@joelfernandes.org>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
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

Co-developed-by: Josh Don <joshdon@google.com>
Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h            |  10 +
 include/uapi/linux/prctl.h       |   6 +
 kernel/fork.c                    |   1 +
 kernel/sched/Makefile            |   1 +
 kernel/sched/core.c              | 136 ++++++-
 kernel/sched/coretag.c           | 669 +++++++++++++++++++++++++++++++
 kernel/sched/debug.c             |   4 +
 kernel/sched/sched.h             |  58 ++-
 kernel/sys.c                     |   7 +
 tools/include/uapi/linux/prctl.h |   6 +
 10 files changed, 878 insertions(+), 20 deletions(-)
 create mode 100644 kernel/sched/coretag.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7efce9c9d9cf..7ca6f2f72cda 100644
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
 
@@ -2076,4 +2078,12 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+int sched_core_share_pid(unsigned long flags, pid_t pid);
+void sched_tsk_free(struct task_struct *tsk);
+#else
+#define sched_core_share_pid(flags, pid) do { } while (0)
+#define sched_tsk_free(tsk) do { } while (0)
+#endif
+
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c334e6a02e5f..f8e4e9626121 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -248,4 +248,10 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 7199d359690c..5468c93829c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	sched_tsk_free(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
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
index 20125431af87..a3844e2e7379 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -136,7 +136,33 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 	return false;
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+static bool sched_core_empty(struct rq *rq)
+{
+	return RB_EMPTY_ROOT(&rq->core_tree);
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
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
 	struct task_struct *node_task;
@@ -163,14 +189,15 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	rb_insert_color(&p->core_node, &rq->core_tree);
 }
 
-static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
@@ -234,8 +261,24 @@ static int __sched_core_stopper(void *data)
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
@@ -245,7 +288,11 @@ static int sched_core_count;
 
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
@@ -253,8 +300,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -274,12 +319,6 @@ void sched_core_put(void)
 		__sched_core_disable();
 	mutex_unlock(&sched_core_mutex);
 }
-
-#else /* !CONFIG_SCHED_CORE */
-
-static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
-static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
-
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -3882,6 +3921,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	int __maybe_unused ret;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -3957,6 +3997,13 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
+
+	ret = sched_core_fork(p, clone_flags);
+	if (ret)
+		return ret;
 #endif
 	return 0;
 }
@@ -7738,6 +7785,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -8742,6 +8792,9 @@ void sched_offline_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
+void cpu_core_get_group_cookie(struct task_group *tg,
+			       unsigned long *group_cookie_ptr);
+
 static void sched_change_group(struct task_struct *tsk, int type)
 {
 	struct task_group *tg;
@@ -8754,6 +8807,11 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
+
+#ifdef CONFIG_SCHED_CORE
+	sched_core_change_group(tsk, tg);
+#endif
+
 	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -8806,11 +8864,6 @@ void sched_move_task(struct task_struct *tsk)
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
@@ -8846,6 +8899,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_SCHED_CORE
+	struct task_group *tg = css_tg(css);
+
+	if (tg->core_tagged) {
+		sched_core_put();
+		tg->core_tagged = 0;
+	}
+#endif
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -9447,6 +9512,22 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "core_tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#ifdef CONFIG_SCHED_DEBUG
+	/* Read the group cookie. */
+	{
+		.name = "core_group_cookie",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_group_cookie_read_u64,
+	},
+#endif
+#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -9620,6 +9701,22 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "core_tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#ifdef CONFIG_SCHED_DEBUG
+	/* Read the group cookie. */
+	{
+		.name = "core_group_cookie",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_group_cookie_read_u64,
+	},
+#endif
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
@@ -9648,6 +9745,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
new file mode 100644
index 000000000000..207fbaac5897
--- /dev/null
+++ b/kernel/sched/coretag.c
@@ -0,0 +1,669 @@
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
+#include <linux/prctl.h>
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
+/* All active sched_core_cookies */
+static struct rb_root sched_core_cookies = RB_ROOT;
+static DEFINE_RAW_SPINLOCK(sched_core_cookies_lock);
+
+static void sched_core_cookie_init_from_task(struct sched_core_cookie *cookie,
+					     struct task_struct *p)
+{
+	cookie->task_cookie = p->core_task_cookie;
+	cookie->group_cookie = p->core_group_cookie;
+}
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
+ */
+static void __sched_core_update_cookie(struct task_struct *p)
+{
+	struct rb_node *parent, **node;
+	struct sched_core_cookie *node_core_cookie, *match;
+	static const struct sched_core_cookie zero_cookie;
+	struct sched_core_cookie requested_cookie;
+	bool is_zero_cookie;
+	struct sched_core_cookie *const curr_cookie =
+		(struct sched_core_cookie *)p->core_cookie;
+
+	/*
+	 * Ensures that we do not cause races/corruption by modifying/reading
+	 * task cookie fields. Also ensures task cannot get migrated.
+	 */
+	lockdep_assert_held(rq_lockp(task_rq(p)));
+
+	sched_core_cookie_init_from_task(&requested_cookie, p);
+
+	is_zero_cookie = !sched_core_cookie_cmp(&requested_cookie, &zero_cookie);
+
+	/*
+	 * Already have a cookie matching the requested settings? Nothing to
+	 * do.
+	 */
+	if ((curr_cookie && !sched_core_cookie_cmp(curr_cookie, &requested_cookie)) ||
+	    (!curr_cookie && is_zero_cookie))
+		return;
+
+	raw_spin_lock(&sched_core_cookies_lock);
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
+		cmp = sched_core_cookie_cmp(&requested_cookie, node_core_cookie);
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
+		*match = requested_cookie;
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
+	p->core_cookie = (unsigned long)match;
+
+	raw_spin_unlock(&sched_core_cookies_lock);
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
+ */
+static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
+				     enum sched_core_cookie_type cookie_type)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!p)
+		return;
+
+	rq = task_rq_lock(p, &rf);
+
+	switch (cookie_type) {
+	case sched_core_task_cookie_type:
+		p->core_task_cookie = cookie;
+		break;
+	case sched_core_group_cookie_type:
+		p->core_group_cookie = cookie;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	/* Set p->core_cookie, which is the overall cookie */
+	__sched_core_update_cookie(p);
+
+	if (sched_core_enqueued(p)) {
+		sched_core_dequeue(rq, p);
+		if (!p->core_cookie) {
+			task_rq_unlock(rq, p, &rf);
+			return;
+		}
+	}
+
+	if (sched_core_enabled(rq) &&
+	    p->core_cookie && task_on_rq_queued(p))
+		sched_core_enqueue(task_rq(p), p);
+
+	/*
+	 * If task is currently running or waking, it may not be compatible
+	 * anymore after the cookie change, so enter the scheduler on its CPU
+	 * to schedule it away.
+	 */
+	if (task_running(rq, p) || p->state == TASK_WAKING)
+		resched_curr(rq);
+
+	task_rq_unlock(rq, p, &rf);
+}
+
+#ifdef CONFIG_CGROUP_SCHED
+static unsigned long cpu_core_get_group_cookie(struct task_group *tg);
+
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
+{
+	lockdep_assert_held(rq_lockp(task_rq(p)));
+
+	/*
+	 * It is ok if this races with an update to new_tg->core_tagged. Any
+	 * update that occurs after we read the group_cookie here will have to
+	 * perform a cookie update on this task _after_ the update below, due
+	 * to the dependence on task_rq lock.
+	 */
+	p->core_group_cookie = cpu_core_get_group_cookie(new_tg);
+
+	__sched_core_update_cookie(p);
+}
+#endif
+
+/* Per-task interface: Used by fork(2) and prctl(2). */
+static void sched_core_put_cookie_work(struct work_struct *ws);
+
+/* Caller has to call sched_core_get() if non-zero value is returned. */
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
+	return (unsigned long)ck;
+}
+
+static void sched_core_get_task_cookie(unsigned long cookie)
+{
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
+
+	refcount_inc(&ptr->refcnt);
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
+static inline void sched_core_update_task_cookie(struct task_struct *t,
+						 unsigned long c)
+{
+	sched_core_update_cookie(t, c, sched_core_task_cookie_type);
+}
+
+int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
+{
+	static DEFINE_MUTEX(sched_core_tasks_mutex);
+	unsigned long cookie;
+	int ret = -ENOMEM;
+
+	mutex_lock(&sched_core_tasks_mutex);
+
+	if (!t2) {
+		if (t1->core_task_cookie) {
+			sched_core_put_task_cookie(t1->core_task_cookie);
+			sched_core_update_task_cookie(t1, 0);
+			sched_core_put();
+		}
+	} else if (t1 == t2) {
+		/* Assign a unique per-task cookie solely for t1. */
+		cookie = sched_core_alloc_task_cookie();
+		if (!cookie)
+			goto out_unlock;
+		sched_core_get();
+
+		if (t1->core_task_cookie) {
+			sched_core_put_task_cookie(t1->core_task_cookie);
+			sched_core_put();
+		}
+		sched_core_update_task_cookie(t1, cookie);
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
+		sched_core_get(); /* For the alloc. */
+
+		/* Add another reference for the other task. */
+		sched_core_get_task_cookie(cookie);
+		sched_core_get(); /* For the other task. */
+
+		sched_core_update_task_cookie(t1, cookie);
+		sched_core_update_task_cookie(t2, cookie);
+	} else if (t1->core_task_cookie && !t2->core_task_cookie) {
+		/* CASE 2. */
+		sched_core_put_task_cookie(t1->core_task_cookie);
+		sched_core_update_task_cookie(t1, 0);
+		sched_core_put();
+	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
+		/* CASE 3. */
+		sched_core_get_task_cookie(t2->core_task_cookie);
+		sched_core_get();
+		sched_core_update_task_cookie(t1, t2->core_task_cookie);
+
+	} else {
+		/* CASE 4. */
+		sched_core_get_task_cookie(t2->core_task_cookie);
+		sched_core_get();
+
+		sched_core_put_task_cookie(t1->core_task_cookie);
+		sched_core_update_task_cookie(t1, t2->core_task_cookie);
+		sched_core_put();
+	}
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&sched_core_tasks_mutex);
+	return ret;
+}
+
+/* Called from prctl interface: PR_SCHED_CORE_SHARE */
+int sched_core_share_pid(unsigned long flags, pid_t pid)
+{
+	struct task_struct *to;
+	struct task_struct *from;
+	struct task_struct *task;
+	int err;
+
+	rcu_read_lock();
+	task = find_task_by_vpid(pid);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	get_task_struct(task);
+
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		rcu_read_unlock();
+		err = -EPERM;
+		goto out;
+	}
+	rcu_read_unlock();
+
+	if (flags == PR_SCHED_CORE_CLEAR) {
+		to = task;
+		from = NULL;
+	} else if (flags == PR_SCHED_CORE_SHARE_TO) {
+		to = task;
+		from = current;
+	} else if (flags == PR_SCHED_CORE_SHARE_FROM) {
+		to = current;
+		from = task;
+	} else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = sched_core_share_tasks(to, from);
+out:
+	put_task_struct(task);
+	return err;
+}
+
+/* CGroup core-scheduling interface support. */
+#ifdef CONFIG_CGROUP_SCHED
+/*
+ * Helper to get the group cookie in a hierarchy. Any ancestor can have a
+ * cookie.
+ *
+ * Can race with an update to tg->core_tagged if sched_core_group_mutex is
+ * not held.
+ */
+static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
+{
+	for (; tg; tg = tg->parent) {
+		if (READ_ONCE(tg->core_tagged))
+			return (unsigned long)tg;
+	}
+
+	return 0;
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
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	return !!css_tg(css)->core_tagged;
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
+int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			   u64 val)
+{
+	static DEFINE_MUTEX(sched_core_group_mutex);
+	struct task_group *tg = css_tg(css);
+	struct cgroup_subsys_state *css_tmp;
+	struct task_struct *p;
+	unsigned long cookie;
+	int ret = 0;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	mutex_lock(&sched_core_group_mutex);
+
+	if (!tg->core_tagged && val) {
+		/* Tag is being set. Check ancestors and descendants. */
+		if (cpu_core_get_group_cookie(tg) ||
+		    cpu_core_check_descendants(tg, true /* tag */)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+	} else if (tg->core_tagged && !val) {
+		/* Tag is being reset. Check descendants. */
+		if (cpu_core_check_descendants(tg, true /* tag */)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+	} else {
+		goto out_unlock;
+	}
+
+	if (!!val)
+		sched_core_get();
+
+	tg->core_tagged = val;
+	cookie = cpu_core_get_group_cookie(tg);
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(css_tmp, css) {
+		struct css_task_iter it;
+
+		css_task_iter_start(css_tmp, 0, &it);
+		/*
+		 * Note: css_task_iter_next will skip dying tasks.
+		 * There could still be dying tasks left in the core queue
+		 * when we set cgroup tag to 0 when the loop is done below.
+		 */
+		while ((p = css_task_iter_next(&it)))
+			sched_core_update_cookie(p, cookie, sched_core_group_cookie_type);
+
+		css_task_iter_end(&it);
+	}
+	rcu_read_unlock();
+
+	if (!val)
+		sched_core_put();
+
+out_unlock:
+	mutex_unlock(&sched_core_group_mutex);
+	return ret;
+}
+#endif
+
+/* Called from sched_fork() */
+int sched_core_fork(struct task_struct *p, unsigned long clone_flags)
+{
+	/*
+	 * These are ref counted; avoid an uncounted reference.
+	 * If p should have a cookie, it will be set below.
+	 */
+	p->core_task_cookie = 0;
+	p->core_cookie = 0;
+
+	/*
+	 * First, update the new task's per-task cookie.
+	 * If parent is tagged via per-task cookie, tag the child (either with
+	 * the parent's cookie, or a new one).
+	 */
+	if (READ_ONCE(current->core_task_cookie)) {
+		int ret;
+
+		if (clone_flags & CLONE_THREAD) {
+			/* For CLONE_THREAD, share parent's per-task tag. */
+			ret = sched_core_share_tasks(p, p);
+		} else {
+			/* Otherwise, assign a new per-task tag. */
+			ret = sched_core_share_tasks(p, current);
+		}
+
+		if (ret)
+			return ret;
+
+		/* sched_core_share_tasks() should always update p's core_cookie. */
+		WARN_ON_ONCE(!p->core_cookie);
+
+		return 0;
+	}
+
+	/*
+	 * NOTE: This might race with a concurrent cgroup cookie update. That's
+	 * ok; sched_core_change_group() will handle this post-fork, once the
+	 * task is visible.
+	 */
+	if (p->core_group_cookie) {
+		struct sched_core_cookie *parent_cookie;
+		struct sched_core_cookie child_requested_cookie;
+		bool needs_update = false;
+		struct rq_flags rf;
+		struct rq *rq;
+		unsigned long flags;
+
+		/* No locking needed; child is not yet visible */
+		sched_core_cookie_init_from_task(&child_requested_cookie, p);
+
+		/*
+		 * Optimization: try to grab the parent's cookie and increment
+		 * the refcount directly, rather than traverse the RB tree.
+		 *
+		 * Note: sched_core_cookies_lock is less contended than
+		 * rq_lock(current), and is sufficient to protect
+		 * current->core_cookie.
+		 */
+		raw_spin_lock_irqsave(&sched_core_cookies_lock, flags);
+		parent_cookie = (struct sched_core_cookie *)current->core_cookie;
+		if (likely(parent_cookie &&
+			   !sched_core_cookie_cmp(&child_requested_cookie, parent_cookie) &&
+			   refcount_inc_not_zero(&parent_cookie->refcnt))) {
+			p->core_cookie = (unsigned long)parent_cookie;
+		} else {
+			needs_update = true; /* raced */
+		}
+		raw_spin_unlock_irqrestore(&sched_core_cookies_lock, flags);
+
+		if (needs_update) {
+			rq = task_rq_lock(p, &rf);
+			__sched_core_update_cookie(p);
+			task_rq_unlock(rq, p, &rf);
+			WARN_ON_ONCE(!p->core_cookie);
+		}
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
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 60a922d3f46f..8c452b8010ad 100644
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d6efb1ffc08c..133560db1030 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -377,6 +377,10 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_SCHED_CORE
+	int			core_tagged;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
@@ -425,6 +429,11 @@ struct task_group {
 
 };
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
@@ -1124,6 +1133,11 @@ static inline bool is_migration_disabled(struct task_struct *p)
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
+enum sched_core_cookie_type {
+	sched_core_task_cookie_type,
+	sched_core_group_cookie_type,
+};
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
@@ -1194,12 +1208,54 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 	return false;
 }
 
-extern void queue_core_balance(struct rq *rq);
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg);
+int sched_core_fork(struct task_struct *p, unsigned long clone_flags);
+
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
+int sched_core_share_pid(unsigned long flags, pid_t pid);
+int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
+
+#ifdef CONFIG_CGROUP_SCHED
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft);
+
+#ifdef CONFIG_SCHED_DEBUG
+u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft);
+#endif
+
+int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			   u64 val);
+#endif
+
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#define _TIF_UNSAFE_RET (0)
+#endif
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 #else /* !CONFIG_SCHED_CORE */
 
+static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
+{
+	return -ENOTSUPP;
+}
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return false;
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..da52a0da24ef 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2530,6 +2530,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+#ifdef CONFIG_SCHED_CORE
+	case PR_SCHED_CORE_SHARE:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = sched_core_share_pid(arg2, arg3);
+		break;
+#endif
 	default:
 		error = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 7f0827705c9a..cd37bbf3cd90 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -247,4 +247,10 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.30.0.280.ga3ce27912f-goog

