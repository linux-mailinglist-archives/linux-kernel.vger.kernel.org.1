Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9449B2932CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbgJTBoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390180AbgJTBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:11 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03DDC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z2so277320ilh.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhJI2h6Ly2xZ1BBmr+QEaXcjTkWkuZA3OmHjUCg7CNs=;
        b=K0wPev/MbCgVFTREeoZLBmpy7G0M1VXBT7JAM2C1BlcYc6ZEsE9Yq34COy828d4VSE
         +pQTO5KMLpArCmu0jvVeR6EnGkrKvLKWCRK0my+hJV3ov1wovIcaZWTDzr4MTs4/3Hlm
         p/y2iakkp4orSMdtdb3okAL7hLgn6LMUuXkgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhJI2h6Ly2xZ1BBmr+QEaXcjTkWkuZA3OmHjUCg7CNs=;
        b=LkWfWwU70T0P3HHxpq+OxBnpY9ZkEH2aHqqNXyJaQMeFGG5MnsdoeVRqPHe9YNrryr
         n4aN3ONq135UC/tX8uKKpZcZqeS7BCgnh6RxnKdXpS/up/JFhvqrl6SmAu5zQ2i0z+1z
         fXuK23n0HJqgJZ105BVouxEmeC3DE16wK0xQQHZHjyylwjoUvVioqPWATC07ZVbVfiSs
         dNL+9C0qELelRrRdWtcm7dxa8ksLHVrXu6bxPvX78lDX+5RvqI/EjYNjR2btlXeczQIM
         77/qL2wVCOeq9mVWNRYFBCnUkJTf/SHYpckAFspidQbwnWUG7+VJyJA1ap+feFlVIBOm
         veOw==
X-Gm-Message-State: AOAM530Y9Rl0Rl96jylH6Ap58E16CSf6BAjYSbcaQx8UL2WmZq8xnJBz
        ZQSTcVuKWNsGXVgXd4LPpi6nkA==
X-Google-Smtp-Source: ABdhPJx3HxM6exX/zxLNWApgNoqzXmweeq1rkBTjXBHjNjAMs2JyutMicexzEu6XgmVIsEaQWTew9g==
X-Received: by 2002:a92:243:: with SMTP id 64mr237944ilc.298.1603158250048;
        Mon, 19 Oct 2020 18:44:10 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:09 -0700 (PDT)
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
Subject: [PATCH v8 -tip 08/26] sched/fair: Snapshot the min_vruntime of CPUs on force idle
Date:   Mon, 19 Oct 2020 21:43:18 -0400
Message-Id: <20201020014336.2076526-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
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

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 33 ++++++++++++++++++++-------------
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  5 +++++
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 469428979182..a5404ec9e89a 100644
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
@@ -4648,6 +4637,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
+	bool fi_before = false;
 	bool need_sync;
 	int i, j, cpu;
 
@@ -4712,6 +4702,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle) {
 		need_sync = true;
+		fi_before = true;
 		rq->core->core_forceidle = false;
 	}
 	for_each_cpu(i, smt_mask) {
@@ -4723,6 +4714,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -4859,6 +4858,14 @@ next_class:;
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
index 56bea0decda1..9cae08c3fca1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10686,6 +10686,46 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
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
index 884d23d5e55d..dfdb0ebb07a8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -524,6 +524,9 @@ struct cfs_rq {
 
 	u64			exec_clock;
 	u64			min_vruntime;
+#ifdef CONFIG_SCHED_CORE
+	u64			min_vruntime_fi;
+#endif
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
@@ -1106,6 +1109,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.29.0.rc1.297.gfa9743e501-goog

