Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0339274EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgIWBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIWBqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:46:25 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41BEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:46:24 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p15so10566717qvk.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HlDsOT3hTKno1puBj4odcuCaauNmkccjaaZ+sF+Y6Zc=;
        b=LZ6moumyHcUDgvbF1GEGRi3WAyPrfpBo++VkPZkhQdhg108Ff45a1RBZ9jfbDoKmPJ
         C7KNUa9025cmzQaf11OPKAh2pKcCBI1StphYoIUbR6S6b5N7B+4JszmrtF0Bn1pzFitC
         yGRqbW+3L+cRwn6YgGR3uH3YzDynPGBc9qf1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HlDsOT3hTKno1puBj4odcuCaauNmkccjaaZ+sF+Y6Zc=;
        b=g5pUeJap0aqAcm/DCMPR2l9oSaAlY8mKCWcR2cV7dPTcNaF2O4xC8LUQwJEveFwwoj
         r7TdY49AuKEjj+ULBhcU8GCPVeO1Mz/05IqggNwgZ+YRfFFitZE8mHqxugKAKDitlaRm
         5MjFFMcgHqAIONFBvVbsyp7Rx/rYaKF851HIyacxCqbVjFbFmKneiB+A9cANUeQIsbVo
         vgcaoveF0ss3NQM2ibndudn+ltUJ0JsXawDQJHcdUCgL03yOHywU1c5M/wxqKg0TZq2I
         ZaBBUbdkmv8aZnFJzMZAOFNxXllhrazsovIZdW5pW5Qf1N5vOMZXUKD+Lb6+8wj5pDfk
         gRcA==
X-Gm-Message-State: AOAM531v9H/AEZSnFsEYaCOBVRz/EIeZRhz3klB/ZTbefmn4nnMufgDV
        RH1tORyxuc3OwHJ7369aA8qzrg==
X-Google-Smtp-Source: ABdhPJyaR07/xJ7VSb6xmLB3sezvNoDZn0oiN/EGrQ2Ge53p73ufw90Lj2+wv+KeV3V6zMI3AYvVSg==
X-Received: by 2002:a05:6214:8c9:: with SMTP id da9mr9167513qvb.57.1600825583978;
        Tue, 22 Sep 2020 18:46:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k52sm14402157qtc.56.2020.09.22.18.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:46:23 -0700 (PDT)
Date:   Tue, 22 Sep 2020 21:46:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200923014622.GA1733275@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <20200828212927.GE29142@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828212927.GE29142@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:29:27PM +0200, Peter Zijlstra wrote:
> 
> 
> This is still a horrible patch..

Hi Peter,
I wrote a new patch similar to this one and it fares much better in my tests,
it is based on Aaron's idea but I do the sync only during force-idle, and not
during enqueue. Also I yanked the whole 'core wide min_vruntime' crap. There
is a regressing test which improves quite a bit with my patch (results below):

Aaron, Vineeth, Chris any other thoughts? This patch is based on Google's
4.19 device kernel so will require some massaging to apply to mainline/v7
series. I will provide an updated patch later based on v7 series.

(Works only for SMT2, maybe we can generalize it more..)
--------8<-----------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] sched: Sync the min_vruntime of cores when the system enters
 force-idle

This patch provides a vruntime based way to compare two cfs task's priority, be
it on the same cpu or different threads of the same core.

It is based on Aaron Lu's patch with some important differences. Namely,
the vruntime is sync'ed only when the CPU goes into force-idle. Also I removed
the notion of core-wide min_vruntime.

Also I don't care how long a cpu in a core is force idled,  I do my sync
whenever the force idle starts essentially bringing both SMTs to a common time
base. After that point, selection can happen as usual.

When running an Android audio test, with patch the perf sched latency output:

-----------------------------------------------------------------------------------------------------------------
Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
-----------------------------------------------------------------------------------------------------------------
FinalizerDaemon:(2)   |     23.969 ms |      969 | avg:    0.504 ms | max:  162.020 ms | max at:   1294.327339 s
HeapTaskDaemon:(3)    |   2421.287 ms |     4733 | avg:    0.131 ms | max:   96.229 ms | max at:   1302.343366 s
adbd:(3)              |      6.101 ms |       79 | avg:    1.105 ms | max:   84.923 ms | max at:   1294.431284 s

Without this patch and with Aubrey's initial patch (in v5 series), the max delay looks much better:

-----------------------------------------------------------------------------------------------------------------
Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
-----------------------------------------------------------------------------------------------------------------
HeapTaskDaemon:(2)    |   2602.109 ms |     4025 | avg:    0.231 ms | max:   19.152 ms | max at:    522.903934 s
surfaceflinger:7478   |     18.994 ms |     1206 | avg:    0.189 ms | max:   17.375 ms | max at:    520.523061 s
ksoftirqd/3:30        |      0.093 ms |        5 | avg:    3.328 ms | max:   16.567 ms | max at:    522.903871 s

The comparison bits are the same as with Aaron's patch. When the two tasks
are on the same CPU, we just need to find a common cfs_rq both sched_entities
are on and then do the comparison.

When the two tasks are on different threads of the same core, the root
level sched_entities to which the two tasks belong will be used to do
the comparison.

An ugly illustration for the cross CPU case:

       cpu0         cpu1
     /   |  \     /   |  \
    se1 se2 se3  se4 se5 se6
        /  \            /   \
      se21 se22       se61  se62

Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
task B's se is se61. To compare priority of task A and B, we compare
priority of se2 and se6. Whose vruntime is smaller, who wins.

To make this work, the root level se should have a common cfs_rq min
vuntime, which I call it the core cfs_rq min vruntime.

When we adjust the min_vruntime of rq->core, we need to propgate
that down the tree so as to not cause starvation of existing tasks
based on previous vruntime.

Inspired-by: Aaron Lu <ziqian.lzq@antfin.com>
Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
Change-Id: Ida0083a2382a37f768030112ddf43bdf024a84b3
---
 kernel/sched/core.c  | 17 +++++++++++++-
 kernel/sched/fair.c  | 54 +++++++++++++++++++++++---------------------
 kernel/sched/sched.h |  2 ++
 3 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aeaf72acf063..d6f25fdd78ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4068,6 +4068,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
+	struct cfs_rq *cfs_rq[2];
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
@@ -4247,6 +4248,7 @@ next_class:;
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
+	need_sync = false;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -4255,8 +4257,10 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
-		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running) {
 			rq_i->core_forceidle = true;
+			need_sync = true;
+		}
 
 		rq_i->core_pick->core_occupation = occ;
 
@@ -4270,6 +4274,17 @@ next_class:;
 		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
 	}
 
+	/* Something got force idled, sync the vruntimes. Works only for SMT2. */
+	if (need_sync) {
+		j = 0;
+		for_each_cpu(i, smt_mask) {
+			struct rq *rq_i = cpu_rq(i);
+			cfs_rq[j++] = &rq_i->cfs;
+		}
+		
+		if (j == 2)
+			update_core_cfs_rq_min_vruntime(cfs_rq[0], cfs_rq[1]);
+	}
 done:
 	set_next_task(rq, next);
 	return next;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ca3f6173c52..5bd220751d7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -479,13 +479,6 @@ static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
 
 static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 {
-	if (!sched_core_enabled(rq_of(cfs_rq)))
-		return cfs_rq->min_vruntime;
-
-#ifdef CONFIG_SCHED_CORE
-	if (is_root_cfs_rq(cfs_rq))
-		return core_cfs_rq(cfs_rq)->min_vruntime;
-#endif
 	return cfs_rq->min_vruntime;
 }
 
@@ -497,40 +490,47 @@ static void coresched_adjust_vruntime(struct cfs_rq *cfs_rq, u64 delta)
 	if (!cfs_rq)
 		return;
 
-	cfs_rq->min_vruntime -= delta;
+	/*
+	 * vruntime only goes forward. This can cause sleepers to be boosted
+	 * but that's Ok for now.
+	 */
+	cfs_rq->min_vruntime += delta;
 	rbtree_postorder_for_each_entry_safe(se, next,
 			&cfs_rq->tasks_timeline.rb_root, run_node) {
 		if (se->vruntime > delta)
-			se->vruntime -= delta;
+			se->vruntime += delta;
 		if (se->my_q)
 			coresched_adjust_vruntime(se->my_q, delta);
 	}
 }
 
-static void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rqa,
+				    struct cfs_rq *cfs_rqb)
 {
-	struct cfs_rq *cfs_rq_core;
-
-	if (!sched_core_enabled(rq_of(cfs_rq)))
-		return;
+	u64 delta;
 
-	if (!is_root_cfs_rq(cfs_rq))
+	if (!is_root_cfs_rq(cfs_rqa) || !is_root_cfs_rq(cfs_rqb))
 		return;
 
-	cfs_rq_core = core_cfs_rq(cfs_rq);
-	if (cfs_rq_core != cfs_rq &&
-	    cfs_rq->min_vruntime < cfs_rq_core->min_vruntime) {
-		u64 delta = cfs_rq_core->min_vruntime - cfs_rq->min_vruntime;
-		coresched_adjust_vruntime(cfs_rq_core, delta);
+	if (cfs_rqa->min_vruntime < cfs_rqb->min_vruntime) {
+		delta = cfs_rqb->min_vruntime - cfs_rqa->min_vruntime;
+		/* Bring a upto speed with b. */
+		coresched_adjust_vruntime(cfs_rqa, delta);
+	} else if (cfs_rqb->min_vruntime < cfs_rqa->min_vruntime) {
+		u64 delta = cfs_rqa->min_vruntime - cfs_rqb->min_vruntime;
+		/* Bring b upto speed with a. */
+		coresched_adjust_vruntime(cfs_rqb, delta);
 	}
 }
 #endif
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
 {
+	struct cfs_rq *cfs_rqa = &cpu_rq(task_cpu(a))->cfs;
+	struct cfs_rq *cfs_rqb = &cpu_rq(task_cpu(b))->cfs;
+	bool samecpu = task_cpu(a) == task_cpu(b);
 	struct sched_entity *sea = &a->se;
 	struct sched_entity *seb = &b->se;
-	bool samecpu = task_cpu(a) == task_cpu(b);
 	struct task_struct *p;
 	s64 delta;
 
@@ -555,7 +555,13 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
 		sea = sea->parent;
 	while (seb->parent)
 		seb = seb->parent;
-	delta = (s64)(sea->vruntime - seb->vruntime);
+
+	WARN_ON_ONCE(sea->vruntime < cfs_rqa->min_vruntime);
+	WARN_ON_ONCE(seb->vruntime < cfs_rqb->min_vruntime);
+
+	/* normalize vruntime WRT their rq's base */
+	delta = (s64)(sea->vruntime - seb->vruntime) +
+		(s64)(cfs_rqb->min_vruntime - cfs_rqa->min_vruntime);
 
 out:
 	p = delta > 0 ? b : a;
@@ -624,10 +630,6 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	/* ensure we never gain time by being placed backwards. */
 	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
 
-#ifdef CONFIG_SCHED_CORE
-	update_core_cfs_rq_min_vruntime(cfs_rq);
-#endif
-
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d09cfbd746e5..8559d0ee157f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2549,6 +2549,8 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 #endif
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rqa,
+				    struct cfs_rq *cfs_rqb);
 
 #ifdef CONFIG_SMP
 extern struct static_key_false sched_energy_present;
-- 
2.28.0.681.g6f77f65b4e-goog

