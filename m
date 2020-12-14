Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF82DA41E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgLNX0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgLNX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:26:23 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11BC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:25:43 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id l7so8673860qvt.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c+h+8QkTwi2OyLUwlA8Lb3HWj9VAv6P8qRdG3beLPxg=;
        b=ZgxANA8FjTDB/xAqjYQ16A6qzgqFdyhGktKlaGDeTRO/921zKWkVeVZDmA1xBo0kBk
         TOrO+8o1jbCwDIAlpaMWY9twAuFkJITxcZxzzt7NSiURO35XEX58FaY1L8a8eKr9HiBJ
         y3OJkg8T3JTH4eGg15Tw57U01co0UcqIOo+UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+h+8QkTwi2OyLUwlA8Lb3HWj9VAv6P8qRdG3beLPxg=;
        b=tnUvJnohDxECe6kAhbbzr5ZeaD0QSdLfDkN1dhZtb73Y7LIJ0LZ5rSg/rgl0/0flah
         EwERopx/t9cOcWzJat4x91EHl4g1WI6SHHsqyW7dhThGGPKwcQg3Fg2tF/rOcaMUfzFm
         l0yCqYRvPIZpftBDAEA/DvoR4DSzcn9PbaNahgdSBH5WMF0Xqo5B5Hvy/j/Ji+w06nWZ
         rSoI0Y3sbhhY+CJ5VxuJ5f0XgTSMxCqb7yePX1qLFytv3+4+YugC5DbOLuAuEgLBmXCC
         80sVWRG6+VcMz8mljyPXeJ4+c95u7yy/eC7nXdEt4Fu/ISkpZ+qwJaG+yhZSXhCbr0BE
         gJyw==
X-Gm-Message-State: AOAM530516ObiuPEYJtqMRB51aibl0zI1tMFGd+6mK+UANv5sGX1a/tH
        lsEBkoUTGnf1SjzfZ8Xq9Or82w==
X-Google-Smtp-Source: ABdhPJwN7b7NH+YpmlrNixmRp/J0DWcVj5RDpofmyzFHPyEwgN4Peml3Q8e9woy0C8Gq5wvizJePTg==
X-Received: by 2002:a05:6214:b2f:: with SMTP id w15mr12495752qvj.8.1607988342324;
        Mon, 14 Dec 2020 15:25:42 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x6sm2404098qtm.4.2020.12.14.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:25:41 -0800 (PST)
Date:   Mon, 14 Dec 2020 18:25:41 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
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
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
Message-ID: <20201214232541.GF201514@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com>
 <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <X9e9dcLMrMJThZs+@google.com>
 <16a390e4-b44d-b0eb-1df6-6e56d78d009f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a390e4-b44d-b0eb-1df6-6e56d78d009f@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:44:09PM -0500, chris hyser wrote:
> On 12/14/20 2:31 PM, Joel Fernandes wrote:
> > > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > > index cffdfab..50c31f3 100644
> > > --- a/kernel/sched/debug.c
> > > +++ b/kernel/sched/debug.c
> > > @@ -1030,6 +1030,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
> > >   #ifdef CONFIG_SCHED_CORE
> > >   	__PS("core_cookie", p->core_cookie);
> > > +	__PS("core_task_cookie", p->core_task_cookie);
> > >   #endif
> > 
> > Hmm, so the final cookie of the task is always p->core_cookie. This is what
> > the scheduler uses. All other fields are ingredients to derive the final
> > cookie value.
> > 
> > I will drop this hunk from your overall diff, but let me know if you
> > disagree!
> 
> 
> No problem. That was there primarily for debugging.

Ok. I squashed Josh's changes into this patch and several of my fixups. So
there'll be 3 patches:
1. CGroup + prctl  (single patch as it is hell to split it)
2. Documentation
3. ksefltests

Below is the diff of #1. I still have to squash in the stop_machine removal
and some more review changes. But other than that, please take a look and let
me know anything that's odd.  I will test further as well.

Also next series will only be interface as I want to see if I can get lucky
enough to have Peter look at it before he leaves for PTO next week.
For the other features, I will post different series as I prepare them. One
series for interface, and another for kernel protection / migration changes.

---8<-----------------------

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a60868165590..73baca11d743 100644
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
 
@@ -2081,11 +2083,15 @@ void sched_core_unsafe_enter(void);
 void sched_core_unsafe_exit(void);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(void);
+int sched_core_share_pid(unsigned long flags, pid_t pid);
+void sched_tsk_free(struct task_struct *tsk);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
+#define sched_core_share_pid(flags, pid) do { } while (0)
+#define sched_tsk_free(tsk) do { } while (0)
 #endif
 
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c334e6a02e5f..3752006842e1 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -248,4 +248,10 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+#define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+#define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
+#define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
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
index 7f807a84cc30..80daca9c5930 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -157,7 +157,33 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
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
@@ -184,14 +210,15 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
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
@@ -255,8 +282,24 @@ static int __sched_core_stopper(void *data)
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
@@ -266,7 +309,11 @@ static int sched_core_count;
 
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
@@ -274,8 +321,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -295,12 +340,6 @@ void sched_core_put(void)
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
@@ -3779,6 +3818,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->capture_control = NULL;
 #endif
 	init_numa_balancing(clone_flags, p);
+#ifdef CONFIG_SCHED_CORE
+	p->core_task_cookie = 0;
+#endif
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
@@ -3903,6 +3945,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	int __maybe_unused ret;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -3978,6 +4021,13 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
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
@@ -7979,6 +8029,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -8983,6 +9036,9 @@ void sched_offline_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
+void cpu_core_get_group_cookie(struct task_group *tg,
+			       unsigned long *group_cookie_ptr);
+
 static void sched_change_group(struct task_struct *tsk, int type)
 {
 	struct task_group *tg;
@@ -8995,6 +9051,11 @@ static void sched_change_group(struct task_struct *tsk, int type)
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
@@ -9047,11 +9108,6 @@ void sched_move_task(struct task_struct *tsk)
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
@@ -9087,6 +9143,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -9688,6 +9756,22 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -9861,6 +9945,22 @@ static struct cftype cpu_files[] = {
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
@@ -9889,6 +9989,7 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
new file mode 100644
index 000000000000..4eeb956382ee
--- /dev/null
+++ b/kernel/sched/coretag.c
@@ -0,0 +1,734 @@
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
+		sched_core_get();
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
+		sched_core_get(); /* For the alloc. */
+
+		/* Add another reference for the other task. */
+		sched_core_get_task_cookie(cookie);
+		sched_core_get(); /* For the other task. */
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
+		sched_core_get_task_cookie(t2->core_task_cookie);
+		sched_core_get();
+
+		wr.tasks[0] = t1;
+		wr.cookies[0] = t2->core_task_cookie;
+
+	} else {
+		/* CASE 4. */
+		sched_core_get_task_cookie(t2->core_task_cookie);
+		sched_core_get();
+
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
+	if (task)
+		put_task_struct(task);
+	return err;
+}
+
+/* CGroup core-scheduling interface support. */
+#ifdef CONFIG_CGROUP_SCHED
+/*
+ * Helper to get the group cookie in a hierarchy. Any ancestor can have a
+ * cookie.
+ *
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
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return !!tg->core_tagged;
+}
+
+#ifdef CONFIG_SCHED_DEBUG
+u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	unsigned long group_cookie;
+
+	cpu_core_get_group_cookie(css_tg(css), &group_cookie);
+
+	return group_cookie;
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
+	unsigned long group_cookie;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
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
index b03f261b95b3..94e07c271528 100644
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
 
@@ -1127,6 +1136,12 @@ static inline bool is_migration_disabled(struct task_struct *p)
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
+enum sched_core_cookie_type {
+	sched_core_no_update = 0,
+	sched_core_task_cookie_type,
+	sched_core_group_cookie_type,
+};
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
@@ -1197,12 +1212,53 @@ static inline bool sched_group_cookie_match(struct rq *rq,
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
@@ -2899,7 +2955,4 @@ void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
 #ifdef CONFIG_SCHED_CORE
-#ifndef TIF_UNSAFE_RET
-#define TIF_UNSAFE_RET (0)
-#endif
 #endif
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
index 7f0827705c9a..8fbf9d164ec4 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -247,4 +247,10 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+#define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+#define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
+#define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.29.2.684.gfbc64c5ab5-goog

