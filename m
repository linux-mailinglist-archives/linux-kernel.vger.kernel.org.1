Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EBD2B7222
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgKQXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgKQXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:34 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98790C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:32 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id p12so266060qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aq0QeAerVR6nRC1Cc7NBH2AS0D2UV/+FjU8qxqTtF1Q=;
        b=aqNKyL8jfPLtbrjahMWmNZJZOitYSwcvTKn2/cy7fA0Ua0Wbv7qvHyUFjCrCZFnV9i
         aIfUu0oue0XEjVUz7+GTMVB4JDTPcxSnADbOZaQ3w6pgkNEQOT+47gOQDEJtw5zf6jAi
         W73iV/V4OEjkyXt28Q8ub0tQD6cDsm3Q3jKzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aq0QeAerVR6nRC1Cc7NBH2AS0D2UV/+FjU8qxqTtF1Q=;
        b=O7N1GYWpJuz0DPvXuzpJbfJafPWUfE95OV/2e6yTy3Lj4WXPUBa2Sr6cb8P2gDEtfz
         vT1hgP60gVnyMRhuaqr8EDdYiexe8hkN9oHTXr7FzmC0OYQnIUaXhzJXw4jWwDoMqM3P
         7eHLiSfOB4PBBNOl/tFRpPGRL6JDmNwe4PSDvr9FF07UrDly4wxvyrPIHEr5lcJdFjRg
         XhOgXldUJtCNLuYVSvBti2N2I0msMJ2wSwPalQk0Q6igjkuct8orYofyjRDlvavwjJnM
         bpaU+qC7Kp/JyNJD4Ekz7GvRU3yuldnmmmLI2CkPpYKPmqP/fS3+grc1TfrNyseTdWcG
         Rhbg==
X-Gm-Message-State: AOAM533jce1Qc45PqLXjw3MmtqCQruHDkD+RkzCpJ7T4IIAV0S7Y0cBw
        FdKeo2xT9ip3IsL+zpUv1AU76w==
X-Google-Smtp-Source: ABdhPJwJrXogT/h/+o8NFMyivtkWuPe6HjmpmWkvyP0cqIXRerpZla/qfSPm1AT5yTNcnSlfzlFvZg==
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr2112135qtu.171.1605655231773;
        Tue, 17 Nov 2020 15:20:31 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:31 -0800 (PST)
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
Subject: [PATCH -tip 09/32] sched/fair: Snapshot the min_vruntime of CPUs on force idle
Date:   Tue, 17 Nov 2020 18:19:39 -0500
Message-Id: <20201117232003.3580179-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During force-idle, we end up doing cross-cpu comparison of vruntimes
during pick_next_task. If we simply compare (vruntime-min_vruntime)
across CPUs, and if the CPUs only have 1 task each, we will always
end up comparing 0 with 0 and pick just one of the tasks all the time.
This starves the task that was not picked. To fix this, take a snapshot
of the min_vruntime when entering force idle and use it for comparison.
This min_vruntime snapshot will only be used for cross-CPU vruntime
comparison, and nothing else.

This resolves several performance issues that were seen in ChromeOS
audio usecase.

NOTE: Note, this patch will be improved in a later patch. It is just
      kept here as the basis for the later patch and to make rebasing
      easier. Further, it may make reverting the improvement easier in
      case the improvement causes any regression.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 33 ++++++++++++++++++++-------------
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  5 +++++
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 52d0e83072a4..4ee4902c2cf5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -115,19 +115,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
+		return cfs_prio_less(a, b);
 
 	return false;
 }
@@ -5144,6 +5133,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
+	bool fi_before = false;
 	bool need_sync;
 	int i, j, cpu;
 
@@ -5208,6 +5198,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle) {
 		need_sync = true;
+		fi_before = true;
 		rq->core->core_forceidle = false;
 	}
 	for_each_cpu(i, smt_mask) {
@@ -5219,6 +5210,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			update_rq_clock(rq_i);
 	}
 
+	/* Reset the snapshot if core is no longer in force-idle. */
+	if (!fi_before) {
+		for_each_cpu(i, smt_mask) {
+			struct rq *rq_i = cpu_rq(i);
+			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
+		}
+	}
+
 	/*
 	 * Try and select tasks for each sibling in decending sched_class
 	 * order.
@@ -5355,6 +5354,14 @@ next_class:;
 		resched_curr(rq_i);
 	}
 
+	/* Snapshot if core is in force-idle. */
+	if (!fi_before && rq->core->core_forceidle) {
+		for_each_cpu(i, smt_mask) {
+			struct rq *rq_i = cpu_rq(i);
+			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
+		}
+	}
+
 done:
 	set_next_task(rq, next);
 	return next;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 42965c4fd71f..de82f88ba98c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10726,6 +10726,46 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	bool samecpu = task_cpu(a) == task_cpu(b);
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	struct cfs_rq *cfs_rqa;
+	struct cfs_rq *cfs_rqb;
+	s64 delta;
+
+	if (samecpu) {
+		/* vruntime is per cfs_rq */
+		while (!is_same_group(sea, seb)) {
+			int sea_depth = sea->depth;
+			int seb_depth = seb->depth;
+			if (sea_depth >= seb_depth)
+				sea = parent_entity(sea);
+			if (sea_depth <= seb_depth)
+				seb = parent_entity(seb);
+		}
+
+		delta = (s64)(sea->vruntime - seb->vruntime);
+		goto out;
+	}
+
+	/* crosscpu: compare root level se's vruntime to decide priority */
+	while (sea->parent)
+		sea = sea->parent;
+	while (seb->parent)
+		seb = seb->parent;
+
+	cfs_rqa = sea->cfs_rq;
+	cfs_rqb = seb->cfs_rq;
+
+	/* normalize vruntime WRT their rq's base */
+	delta = (s64)(sea->vruntime - seb->vruntime) +
+		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+out:
+	return delta > 0;
+}
 #else
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be656ca8693d..d934cc51acf1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -517,6 +517,9 @@ struct cfs_rq {
 
 	u64			exec_clock;
 	u64			min_vruntime;
+#ifdef CONFIG_SCHED_CORE
+	u64			min_vruntime_fi;
+#endif
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
@@ -1130,6 +1133,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.29.2.299.gdc1121823c-goog

