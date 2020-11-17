Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC232B7245
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgKQXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgKQXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D86C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:43 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id x13so98107qvk.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHwCPb6C7f/1AEFvEjifktUOCyNsLZKi2lWeLxumHTE=;
        b=ftP9mCWUt43LZdDBROhLjBsVJg1sH6Agm0l19rcbu0SPzrtU/x51yQShZE2Q0/Xgz5
         n2lhlGyqXAszu5n2D5AIHf1Of2ciKCOShIu72cjDQPo8Lt2/TLv7y1L5Od4gzxmih+kt
         S4jThKClB8pSaoeFYgGCERpeXsS0plFWZILTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHwCPb6C7f/1AEFvEjifktUOCyNsLZKi2lWeLxumHTE=;
        b=GhMbWAsr87JnE2xHZwouCCLzKflIJ3ZwLRGy6rx/pSytFtkQ30ro/Rko1qRgTkoPO4
         v+fkrHuouPc7AyLztHrfRuOw6TyymzWFiCbIYDMYCS8tjGy/cyh+Hz7RCUwlp6I6BO7B
         IChPXr+irKpoCMPsFXExkrmT5m6Xfz3WO1L49KcHO0WN9xDjdlLLtkv8LqMjXWBRaine
         hyZGLBqYzeHt9IpfTizu8EaUNpqCsN/MjiQpHa6At4VhB9jlM+OJWZP2A5nOOZ77Dsob
         Cc0LM/NJNVrQh9WZVhXA77L79Hrf1su36Bk2zVdE1AzgTX7BJ0/25/p56AtpufcTB4sV
         a+/g==
X-Gm-Message-State: AOAM531SplgqZ4WWpK7MuKePC/pTllJ0/ZHtMefO78JONxrjjSPSh6/Q
        Zc772nwbdqzAq4Jwccv1VwkQ4A==
X-Google-Smtp-Source: ABdhPJzjqVo2uEPjJn0vuRwtjKG0r9qBeoIA/NoqsNl5lb3zay6YouoiFuroiXaoUaMTBkfYS9BxqA==
X-Received: by 2002:a0c:d414:: with SMTP id t20mr2282945qvh.34.1605655242616;
        Tue, 17 Nov 2020 15:20:42 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:42 -0800 (PST)
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
Subject: [PATCH -tip 15/32] sched: Improve snapshotting of min_vruntime for CGroups
Date:   Tue, 17 Nov 2020 18:19:45 -0500
Message-Id: <20201117232003.3580179-16-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch improved cross-cpu vruntime comparison opertations in
pick_next_task(). Improve it further for tasks in CGroups.

In particular, for cross-CPU comparisons, we were previously going to
the root-level se(s) for both the task being compared. That was strange.
This patch instead finds the se(s) for both tasks that have the same
parent (which may be different from root).

A note about the min_vruntime snapshot and force idling:
Abbreviations: fi: force-idled now? ; fib: force-idled before?
During selection:
When we're not fi, we need to update snapshot.
when we're fi and we were not fi, we must update snapshot.
When we're fi and we were already fi, we must not update snapshot.

Which gives:
        fib     fi      update?
        0       0       1
        0       1       1
        1       0       1
        1       1       0
So the min_vruntime snapshot needs to be updated when: !(fib && fi).

Also, the cfs_prio_less() function needs to be aware of whether the core
is in force idle or not, since it will be use this information to know
whether to advance a cfs_rq's min_vruntime_fi in the hierarchy. So pass
this information along via pick_task() -> prio_less().

Reviewed-by: Vineeth Pillai <viremana@linux.microsoft.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 61 +++++++++++++++++----------------
 kernel/sched/fair.c  | 80 ++++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h |  7 +++-
 3 files changed, 97 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3b373b592680..20125431af87 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -101,7 +101,7 @@ static inline int __task_prio(struct task_struct *p)
  */
 
 /* real prio, less is less */
-static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 {
 
 	int pa = __task_prio(a), pb = __task_prio(b);
@@ -116,7 +116,7 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
-		return cfs_prio_less(a, b);
+		return cfs_prio_less(a, b, in_fi);
 
 	return false;
 }
@@ -130,7 +130,7 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 		return false;
 
 	/* flip prio, so high prio is leftmost */
-	if (prio_less(b, a))
+	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
 		return true;
 
 	return false;
@@ -5101,7 +5101,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
  * - Else returns idle_task.
  */
 static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
 {
 	struct task_struct *class_pick, *cookie_pick;
 	unsigned long cookie = rq->core->core_cookie;
@@ -5116,7 +5116,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		 * higher priority than max.
 		 */
 		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max))
+		    prio_less(class_pick, max, in_fi))
 			return idle_sched_class.pick_task(rq);
 
 		return class_pick;
@@ -5135,13 +5135,15 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 	 * the core (so far) and it must be selected, otherwise we must go with
 	 * the cookie pick in order to satisfy the constraint.
 	 */
-	if (prio_less(cookie_pick, class_pick) &&
-	    (!max || prio_less(max, class_pick)))
+	if (prio_less(cookie_pick, class_pick, in_fi) &&
+	    (!max || prio_less(max, class_pick, in_fi)))
 		return class_pick;
 
 	return cookie_pick;
 }
 
+extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -5230,9 +5232,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
+			/*
+			 * For robustness, update the min_vruntime_fi for
+			 * unconstrained picks as well.
+			 */
+			WARN_ON_ONCE(fi_before);
+			task_vruntime_update(rq, next, false);
 			goto done;
 		}
-		need_sync = true;
 	}
 
 	for_each_cpu(i, smt_mask) {
@@ -5244,14 +5251,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			update_rq_clock(rq_i);
 	}
 
-	/* Reset the snapshot if core is no longer in force-idle. */
-	if (!fi_before) {
-		for_each_cpu(i, smt_mask) {
-			struct rq *rq_i = cpu_rq(i);
-			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
-		}
-	}
-
 	/*
 	 * Try and select tasks for each sibling in decending sched_class
 	 * order.
@@ -5271,7 +5270,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 * highest priority task already selected for this
 			 * core.
 			 */
-			p = pick_task(rq_i, class, max);
+			p = pick_task(rq_i, class, max, fi_before);
 			if (!p)
 				continue;
 
@@ -5279,6 +5278,11 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				occ++;
 
 			rq_i->core_pick = p;
+			if (rq_i->idle == p && rq_i->nr_running) {
+				rq->core->core_forceidle = true;
+				if (!fi_before)
+					rq->core->core_forceidle_seq++;
+			}
 
 			/*
 			 * If this new candidate is of higher priority than the
@@ -5297,6 +5301,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				max = p;
 
 				if (old_max) {
+					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -5338,10 +5343,16 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
-		    !rq_i->core->core_forceidle) {
-			rq_i->core->core_forceidle = true;
-		}
+		/*
+		 * Update for new !FI->FI transitions, or if continuing to be in !FI:
+		 * fi_before     fi      update?
+		 *  0            0       1
+		 *  0            1       1
+		 *  1            0       1
+		 *  1            1       0
+		 */
+		if (!(fi_before && rq->core->core_forceidle))
+			task_vruntime_update(rq_i, rq_i->core_pick, rq->core->core_forceidle);
 
 		rq_i->core_pick->core_occupation = occ;
 
@@ -5361,14 +5372,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		resched_curr(rq_i);
 	}
 
-	/* Snapshot if core is in force-idle. */
-	if (!fi_before && rq->core->core_forceidle) {
-		for_each_cpu(i, smt_mask) {
-			struct rq *rq_i = cpu_rq(i);
-			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
-		}
-	}
-
 done:
 	set_next_task(rq, next);
 	return next;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ceb3906c9a8a..a89c7c917cc6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10781,43 +10781,81 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 		resched_curr(rq);
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+/*
+ * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
+ */
+static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
 {
-	bool samecpu = task_cpu(a) == task_cpu(b);
+	bool root = true;
+	long old, new;
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		if (forceidle) {
+			if (cfs_rq->forceidle_seq == fi_seq)
+				break;
+			cfs_rq->forceidle_seq = fi_seq;
+		}
+
+		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
+	}
+}
+
+void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
+{
+	struct sched_entity *se = &p->se;
+
+	if (p->sched_class != &fair_sched_class)
+		return;
+
+	se_fi_update(se, rq->core->core_forceidle_seq, in_fi);
+}
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
+{
+	struct rq *rq = task_rq(a);
 	struct sched_entity *sea = &a->se;
 	struct sched_entity *seb = &b->se;
 	struct cfs_rq *cfs_rqa;
 	struct cfs_rq *cfs_rqb;
 	s64 delta;
 
-	if (samecpu) {
-		/* vruntime is per cfs_rq */
-		while (!is_same_group(sea, seb)) {
-			int sea_depth = sea->depth;
-			int seb_depth = seb->depth;
-			if (sea_depth >= seb_depth)
-				sea = parent_entity(sea);
-			if (sea_depth <= seb_depth)
-				seb = parent_entity(seb);
-		}
+	SCHED_WARN_ON(task_rq(b)->core != rq->core);
 
-		delta = (s64)(sea->vruntime - seb->vruntime);
-		goto out;
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	/*
+	 * Find an se in the hierarchy for tasks a and b, such that the se's
+	 * are immediate siblings.
+	 */
+	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
+		int sea_depth = sea->depth;
+		int seb_depth = seb->depth;
+
+		if (sea_depth >= seb_depth)
+			sea = parent_entity(sea);
+		if (sea_depth <= seb_depth)
+			seb = parent_entity(seb);
 	}
 
-	/* crosscpu: compare root level se's vruntime to decide priority */
-	while (sea->parent)
-		sea = sea->parent;
-	while (seb->parent)
-		seb = seb->parent;
+	se_fi_update(sea, rq->core->core_forceidle_seq, in_fi);
+	se_fi_update(seb, rq->core->core_forceidle_seq, in_fi);
 
 	cfs_rqa = sea->cfs_rq;
 	cfs_rqb = seb->cfs_rq;
+#else
+	cfs_rqa = &task_rq(a)->cfs;
+	cfs_rqb = &task_rq(b)->cfs;
+#endif
 
-	/* normalize vruntime WRT their rq's base */
+	/*
+	 * Find delta after normalizing se's vruntime with its cfs_rq's
+	 * min_vruntime_fi, which would have been updated in prior calls
+	 * to se_fi_update().
+	 */
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
-out:
+
 	return delta > 0;
 }
 #else
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de553d39aa40..5c258ab64052 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -518,8 +518,10 @@ struct cfs_rq {
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
+	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;
 #endif
+
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
@@ -1078,6 +1080,7 @@ struct rq {
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
 	unsigned char		core_forceidle;
+	unsigned int		core_forceidle_seq;
 #endif
 };
 
@@ -1133,7 +1136,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 /*
  * Helper to check if the CPU's core cookie matches with the task's cookie
@@ -1166,6 +1169,8 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 
 extern void queue_core_balance(struct rq *rq);
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.29.2.299.gdc1121823c-goog

