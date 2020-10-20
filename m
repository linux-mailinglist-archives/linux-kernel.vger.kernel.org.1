Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30B02932CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgJTBoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390162AbgJTBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9FAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z5so595630iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5To+W6ZnE1Kcdc4TQzeE5ZYxd+S9DX6+GXeio3/h5qI=;
        b=JAnlRT3JfVgL+OK4ShwXnWSvl2D6mrcr3zvIjeCCxcxkZtQ0DGLBhX62/TL0iALIKd
         8VvG6B3pL/HrtTNy4s19w4biGTHH3wnkdC8I/ei+MGpu494qBQzbn76hRGfcVyyUlx9f
         JsiPmzXKuRHJuK6GwGb4s0DP13MYy79HN9/zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5To+W6ZnE1Kcdc4TQzeE5ZYxd+S9DX6+GXeio3/h5qI=;
        b=CXnXjzj4sW5A1Wl3Dko7si34PgtC97yXFQMtQQ5kGnDNPI/SIBFEUxAK3WMvvEtiXN
         7tfaox8iwvGj5NzaevXEIsOjHWznne7qmg366+I4Zj5QQk5Dd/MJrjQaj2wThf/LxqaX
         B4WVZIc8KWU6NARUqq93OSWpMxnR8FGHGXKK4gz/V+a4hZmRC6BeWzFvJdhG1ADU0hXn
         eBOqXroLVurZdnnQhCT3Jo5nt/nA2XncBro14hjYL0ynDwLTlZbI07+YkaNI/Ag3jfJ4
         Q3h798/TRz26RmU5RtYCd0KDHgqMGbbGcLS35eJ8TMyvMvmfrAtjpefdukh+sjDvz2ck
         yHrQ==
X-Gm-Message-State: AOAM532aV6zhXq54nNdkY2uR0poFwHGX6NGdV6RE+uCcBy7+uZUztzHY
        0NecPXbzYTJx/wh9rcnLkaMVsg==
X-Google-Smtp-Source: ABdhPJyc5hAseCrDG+ugtuV0PVZj1e46aWtgzh4ggkflnbuTxjLioU14f7yinr53oQBTQOBeSm90eQ==
X-Received: by 2002:a05:6638:d0d:: with SMTP id q13mr456208jaj.115.1603158243779;
        Mon, 19 Oct 2020 18:44:03 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:03 -0700 (PDT)
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
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 06/26] sched: Add core wide task selection and scheduling.
Date:   Mon, 19 Oct 2020 21:43:16 -0400
Message-Id: <20201020014336.2076526-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Instead of only selecting a local task, select a task for all SMT
siblings for every reschedule on the core (irrespective which logical
CPU does the reschedule).

During a CPU hotplug event, schedule would be called with the hotplugged
CPU not in the cpumask. So use for_each_cpu(_wrap)_or to include the
current cpu in the task pick loop.

There are multiple loops in pick_next_task that iterate over CPUs in
smt_mask. During a hotplug event, sibling could be removed from the
smt_mask while pick_next_task is running. So we cannot trust the mask
across the different loops. This can confuse the logic. Add a retry logic
if smt_mask changes between the loops.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/core.c  | 301 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   6 +-
 2 files changed, 305 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a032f481c6e6..12030b77bd6d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4533,7 +4533,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -4574,6 +4574,294 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 
 #ifdef CONFIG_SCHED_CORE
+static inline bool is_task_rq_idle(struct task_struct *t)
+{
+	return (task_rq(t)->idle == t);
+}
+
+static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
+{
+	return is_task_rq_idle(a) || (a->core_cookie == cookie);
+}
+
+static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
+{
+	if (is_task_rq_idle(a) || is_task_rq_idle(b))
+		return true;
+
+	return a->core_cookie == b->core_cookie;
+}
+
+// XXX fairness/fwd progress conditions
+/*
+ * Returns
+ * - NULL if there is no runnable task for this class.
+ * - the highest priority task for this runqueue if it matches
+ *   rq->core->core_cookie or its priority is greater than max.
+ * - Else returns idle_task.
+ */
+static struct task_struct *
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+{
+	struct task_struct *class_pick, *cookie_pick;
+	unsigned long cookie = rq->core->core_cookie;
+
+	class_pick = class->pick_task(rq);
+	if (!class_pick)
+		return NULL;
+
+	if (!cookie) {
+		/*
+		 * If class_pick is tagged, return it only if it has
+		 * higher priority than max.
+		 */
+		if (max && class_pick->core_cookie &&
+		    prio_less(class_pick, max))
+			return idle_sched_class.pick_task(rq);
+
+		return class_pick;
+	}
+
+	/*
+	 * If class_pick is idle or matches cookie, return early.
+	 */
+	if (cookie_equals(class_pick, cookie))
+		return class_pick;
+
+	cookie_pick = sched_core_find(rq, cookie);
+
+	/*
+	 * If class > max && class > cookie, it is the highest priority task on
+	 * the core (so far) and it must be selected, otherwise we must go with
+	 * the cookie pick in order to satisfy the constraint.
+	 */
+	if (prio_less(cookie_pick, class_pick) &&
+	    (!max || prio_less(max, class_pick)))
+		return class_pick;
+
+	return cookie_pick;
+}
+
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *next, *max = NULL;
+	const struct sched_class *class;
+	const struct cpumask *smt_mask;
+	bool need_sync;
+	int i, j, cpu;
+
+	if (!sched_core_enabled(rq))
+		return __pick_next_task(rq, prev, rf);
+
+	cpu = cpu_of(rq);
+
+	/* Stopper task is switching into idle, no need core-wide selection. */
+	if (cpu_is_offline(cpu)) {
+		/*
+		 * Reset core_pick so that we don't enter the fastpath when
+		 * coming online. core_pick would already be migrated to
+		 * another cpu during offline.
+		 */
+		rq->core_pick = NULL;
+		return __pick_next_task(rq, prev, rf);
+	}
+
+	/*
+	 * If there were no {en,de}queues since we picked (IOW, the task
+	 * pointers are all still valid), and we haven't scheduled the last
+	 * pick yet, do so now.
+	 *
+	 * rq->core_pick can be NULL if no selection was made for a CPU because
+	 * it was either offline or went offline during a sibling's core-wide
+	 * selection. In this case, do a core-wide selection.
+	 */
+	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core->core_pick_seq != rq->core_sched_seq &&
+	    rq->core_pick) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
+
+		next = rq->core_pick;
+		if (next != prev) {
+			put_prev_task(rq, prev);
+			set_next_task(rq, next);
+		}
+
+		rq->core_pick = NULL;
+		return next;
+	}
+
+	put_prev_task_balance(rq, prev, rf);
+
+	smt_mask = cpu_smt_mask(cpu);
+
+	/*
+	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
+	 *
+	 * @task_seq guards the task state ({en,de}queues)
+	 * @pick_seq is the @task_seq we did a selection on
+	 * @sched_seq is the @pick_seq we scheduled
+	 *
+	 * However, preemptions can cause multiple picks on the same task set.
+	 * 'Fix' this by also increasing @task_seq for every pick.
+	 */
+	rq->core->core_task_seq++;
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		rq_i->core_pick = NULL;
+
+		if (rq_i->core_forceidle) {
+			need_sync = true;
+			rq_i->core_forceidle = false;
+		}
+
+		if (i != cpu)
+			update_rq_clock(rq_i);
+	}
+
+	/*
+	 * Try and select tasks for each sibling in decending sched_class
+	 * order.
+	 */
+	for_each_class(class) {
+again:
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			struct rq *rq_i = cpu_rq(i);
+			struct task_struct *p;
+
+			if (rq_i->core_pick)
+				continue;
+
+			/*
+			 * If this sibling doesn't yet have a suitable task to
+			 * run; ask for the most elegible task, given the
+			 * highest priority task already selected for this
+			 * core.
+			 */
+			p = pick_task(rq_i, class, max);
+			if (!p) {
+				/*
+				 * If there weren't no cookies; we don't need to
+				 * bother with the other siblings.
+				 * If the rest of the core is not running a tagged
+				 * task, i.e.  need_sync == 0, and the current CPU
+				 * which called into the schedule() loop does not
+				 * have any tasks for this class, skip selecting for
+				 * other siblings since there's no point. We don't skip
+				 * for RT/DL because that could make CFS force-idle RT.
+				 */
+				if (i == cpu && !need_sync && class == &fair_sched_class)
+					goto next_class;
+
+				continue;
+			}
+
+			/*
+			 * Optimize the 'normal' case where there aren't any
+			 * cookies and we don't need to sync up.
+			 */
+			if (i == cpu && !need_sync && !p->core_cookie) {
+				next = p;
+				goto done;
+			}
+
+			rq_i->core_pick = p;
+
+			/*
+			 * If this new candidate is of higher priority than the
+			 * previous; and they're incompatible; we need to wipe
+			 * the slate and start over. pick_task makes sure that
+			 * p's priority is more than max if it doesn't match
+			 * max's cookie.
+			 *
+			 * NOTE: this is a linear max-filter and is thus bounded
+			 * in execution time.
+			 */
+			if (!max || !cookie_match(max, p)) {
+				struct task_struct *old_max = max;
+
+				rq->core->core_cookie = p->core_cookie;
+				max = p;
+
+				if (old_max) {
+					for_each_cpu(j, smt_mask) {
+						if (j == i)
+							continue;
+
+						cpu_rq(j)->core_pick = NULL;
+					}
+					goto again;
+				} else {
+					/*
+					 * Once we select a task for a cpu, we
+					 * should not be doing an unconstrained
+					 * pick because it might starve a task
+					 * on a forced idle cpu.
+					 */
+					need_sync = true;
+				}
+
+			}
+		}
+next_class:;
+	}
+
+	rq->core->core_pick_seq = rq->core->core_task_seq;
+	next = rq->core_pick;
+	rq->core_sched_seq = rq->core->core_pick_seq;
+
+	/* Something should have been selected for current CPU */
+	WARN_ON_ONCE(!next);
+
+	/*
+	 * Reschedule siblings
+	 *
+	 * NOTE: L1TF -- at this point we're no longer running the old task and
+	 * sending an IPI (below) ensures the sibling will no longer be running
+	 * their task. This ensures there is no inter-sibling overlap between
+	 * non-matching user state.
+	 */
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		/*
+		 * An online sibling might have gone offline before a task
+		 * could be picked for it, or it might be offline but later
+		 * happen to come online, but its too late and nothing was
+		 * picked for it.  That's Ok - it will pick tasks for itself,
+		 * so ignore it.
+		 */
+		if (!rq_i->core_pick)
+			continue;
+
+		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running)
+			rq_i->core_forceidle = true;
+
+		if (i == cpu) {
+			rq_i->core_pick = NULL;
+			continue;
+		}
+
+		/* Did we break L1TF mitigation requirements? */
+		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+
+		if (rq_i->curr == rq_i->core_pick) {
+			rq_i->core_pick = NULL;
+			continue;
+		}
+
+		resched_curr(rq_i);
+	}
+
+done:
+	set_next_task(rq, next);
+	return next;
+}
 
 static inline void sched_core_cpu_starting(unsigned int cpu)
 {
@@ -4608,6 +4896,12 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
 
 static inline void sched_core_cpu_starting(unsigned int cpu) {}
 
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return __pick_next_task(rq, prev, rf);
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -7446,7 +7740,12 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
+		rq->core_pick = NULL;
 		rq->core_enabled = 0;
+		rq->core_tree = RB_ROOT;
+		rq->core_forceidle = false;
+
+		rq->core_cookie = 0UL;
 #endif
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4964453591c3..2b6e0bf61720 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1052,11 +1052,16 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
+	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	unsigned char		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
+	unsigned int		core_pick_seq;
+	unsigned long		core_cookie;
 #endif
 };
 
@@ -1936,7 +1941,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

