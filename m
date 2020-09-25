Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8A278BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgIYPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgIYPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:02:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867DEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:02:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so1476135qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnDiMbysJVJC/JmmIBC/36rTB5PZI1EENuCjcwi4PKk=;
        b=HhAX07ZgGyp23nZZxF08MAv/UoWcR4fEKut5Xmptf4H4a3S20r1ak/lSe65wdyhmsq
         0VpnsFxTSV7LlV9ki4IRbH+7dizpea+8Cxb/lVySwUiL0Lb154D+cCsmKcDQa2Orec6A
         j8v/VO/hMaiKIMr7Bs22uTqscR98EGQJX0/dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnDiMbysJVJC/JmmIBC/36rTB5PZI1EENuCjcwi4PKk=;
        b=UgZs/I9DYDrKHpKzFRluS/krjwYcZuXmS38fF30ToRwa659RDPOCwfeZ30btFaE5vK
         z6kgSDfCYcJxvHZHUZNvvZVXwmNAxbPMlDIdpkkLdRniP3NFS8Mel0KNy7E23ejM6/pl
         GLNxh5NhbaxslWHdJMpqkh11vr7jiTwlKyhMiKQJCuZWpR+yoM5FNy7XhVmmi1lJLV0W
         xS5MxNY7sk3xJ7SZf/rletfdlRcUSk0F6P4CGHHaVi2Xbvf8TKWcydpuW6qP4U0r+9wv
         E0/d2EFYdidbTrO/w/cSmJ1YAFPqev/ZiOawTMHWGes59ipLHepL/rRMju4MW7tdQ0BN
         dEYQ==
X-Gm-Message-State: AOAM53215dsZnzTdewDp9DaiiGOWMbAcadU9Z9Wq4znKbPpr5/cmeCqs
        AscNgiseuW/uoNjmifsNK8PdTg==
X-Google-Smtp-Source: ABdhPJxPaGXLMfbdD6sYNcjX9heo6dFmVGouekrc28hawIuks1BTdawB7EkFImvx0HRGw8s53G7rDA==
X-Received: by 2002:a0c:ab4a:: with SMTP id i10mr4872557qvb.39.1601046130609;
        Fri, 25 Sep 2020 08:02:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s15sm1867398qkj.21.2020.09.25.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 08:02:09 -0700 (PDT)
Date:   Fri, 25 Sep 2020 11:02:09 -0400
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
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
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
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200925150209.GA3567448@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <20200828212927.GE29142@worktop.programming.kicks-ass.net>
 <20200923014622.GA1733275@google.com>
 <20200923015243.GA1739137@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923015243.GA1739137@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:52:43PM -0400, Joel Fernandes wrote:
> On Tue, Sep 22, 2020 at 09:46:22PM -0400, Joel Fernandes wrote:
> > On Fri, Aug 28, 2020 at 11:29:27PM +0200, Peter Zijlstra wrote:
> > > 
> > > 
> > > This is still a horrible patch..
> > 
> > Hi Peter,
> > I wrote a new patch similar to this one and it fares much better in my tests,
> > it is based on Aaron's idea but I do the sync only during force-idle, and not
> > during enqueue. Also I yanked the whole 'core wide min_vruntime' crap. There
> > is a regressing test which improves quite a bit with my patch (results below):
> > 
> > Aaron, Vineeth, Chris any other thoughts? This patch is based on Google's
> > 4.19 device kernel so will require some massaging to apply to mainline/v7
> > series. I will provide an updated patch later based on v7 series.
> > 
> > (Works only for SMT2, maybe we can generalize it more..)
> > --------8<-----------
> > 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] sched: Sync the min_vruntime of cores when the system enters
> >  force-idle
> > 
> > This patch provides a vruntime based way to compare two cfs task's priority, be
> > it on the same cpu or different threads of the same core.
> > 
> > It is based on Aaron Lu's patch with some important differences. Namely,
> > the vruntime is sync'ed only when the CPU goes into force-idle. Also I removed
> > the notion of core-wide min_vruntime.
> > 
> > Also I don't care how long a cpu in a core is force idled,  I do my sync
> > whenever the force idle starts essentially bringing both SMTs to a common time
> > base. After that point, selection can happen as usual.
> > 
> > When running an Android audio test, with patch the perf sched latency output:
> > 
> > -----------------------------------------------------------------------------------------------------------------
> > Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
> > -----------------------------------------------------------------------------------------------------------------
> > FinalizerDaemon:(2)   |     23.969 ms |      969 | avg:    0.504 ms | max:  162.020 ms | max at:   1294.327339 s
> > HeapTaskDaemon:(3)    |   2421.287 ms |     4733 | avg:    0.131 ms | max:   96.229 ms | max at:   1302.343366 s
> > adbd:(3)              |      6.101 ms |       79 | avg:    1.105 ms | max:   84.923 ms | max at:   1294.431284 s
> > 
> > Without this patch and with Aubrey's initial patch (in v5 series), the max delay looks much better:
> > 
> > -----------------------------------------------------------------------------------------------------------------
> > Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
> > -----------------------------------------------------------------------------------------------------------------
> > HeapTaskDaemon:(2)    |   2602.109 ms |     4025 | avg:    0.231 ms | max:   19.152 ms | max at:    522.903934 s
> > surfaceflinger:7478   |     18.994 ms |     1206 | avg:    0.189 ms | max:   17.375 ms | max at:    520.523061 s
> > ksoftirqd/3:30        |      0.093 ms |        5 | avg:    3.328 ms | max:   16.567 ms | max at:    522.903871 s
> 
> I messed up the change log, just to clarify - the first result is without
> patch (bad) and the second result is with patch (good).

Here's another approach that might be worth considering, I was discussing
with Vineeth. Freeze the min_vruntime of CPUs when the core enters into
force-idle. I think this is similar to Peter's suggestion.

It is doing quite well in my real-world audio tests. This applies on top of
our ChromeOS 4.19 kernel tree [1] (which has the v5 series).

Any thoughts or review are most welcome especially from Peter :)

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-4.19

---8<-----------------------

From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] Sync the min_vruntime of cores when the system enters force-idle

---
 kernel/sched/core.c  | 24 +++++++++++++++++-
 kernel/sched/fair.c  | 59 +++++++-------------------------------------
 kernel/sched/sched.h |  1 +
 3 files changed, 33 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 715391c418d8..4ab680319a6b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4073,6 +4073,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct cpumask *smt_mask;
 	int i, j, cpu, occ = 0;
 	bool need_sync = false;
+	bool fi_before = false;
 
 	cpu = cpu_of(rq);
 	if (cpu_is_offline(cpu))
@@ -4138,6 +4139,16 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			update_rq_clock(rq_i);
 	}
 
+	fi_before = need_sync;
+	if (!need_sync) {
+		for_each_cpu(i, smt_mask) {
+			struct rq *rq_i = cpu_rq(i);
+
+			/* Reset the snapshot if core is no longer in force-idle. */
+			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
+		}
+	}
+
 	/*
 	 * Try and select tasks for each sibling in decending sched_class
 	 * order.
@@ -4247,6 +4258,7 @@ next_class:;
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
+	need_sync = false;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -4255,8 +4267,10 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
-		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running) {
 			rq_i->core_forceidle = true;
+			need_sync = true;
+		}
 
 		rq_i->core_pick->core_occupation = occ;
 
@@ -4270,6 +4284,14 @@ next_class:;
 		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
 	}
 
+	if (!fi_before && need_sync) {
+		for_each_cpu(i, smt_mask) {
+			struct rq *rq_i = cpu_rq(i);
+
+			/* Snapshot if core is in force-idle. */
+			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
+		}
+	}
 done:
 	set_next_task(rq, next);
 	return next;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23d032ab62d8..3d7c822bb5fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -479,59 +479,17 @@ static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
 
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
 
-#ifdef CONFIG_SCHED_CORE
-static void coresched_adjust_vruntime(struct cfs_rq *cfs_rq, u64 delta)
-{
-	struct sched_entity *se, *next;
-
-	if (!cfs_rq)
-		return;
-
-	cfs_rq->min_vruntime -= delta;
-	rbtree_postorder_for_each_entry_safe(se, next,
-			&cfs_rq->tasks_timeline.rb_root, run_node) {
-		if (se->vruntime > delta)
-			se->vruntime -= delta;
-		if (se->my_q)
-			coresched_adjust_vruntime(se->my_q, delta);
-	}
-}
-
-static void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
-{
-	struct cfs_rq *cfs_rq_core;
-
-	if (!sched_core_enabled(rq_of(cfs_rq)))
-		return;
-
-	if (!is_root_cfs_rq(cfs_rq))
-		return;
-
-	cfs_rq_core = core_cfs_rq(cfs_rq);
-	if (cfs_rq_core != cfs_rq &&
-	    cfs_rq->min_vruntime < cfs_rq_core->min_vruntime) {
-		u64 delta = cfs_rq_core->min_vruntime - cfs_rq->min_vruntime;
-		coresched_adjust_vruntime(cfs_rq_core, delta);
-	}
-}
-#endif
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
 {
+	bool samecpu = task_cpu(a) == task_cpu(b);
 	struct sched_entity *sea = &a->se;
 	struct sched_entity *seb = &b->se;
-	bool samecpu = task_cpu(a) == task_cpu(b);
+	struct cfs_rq *cfs_rqa;
+	struct cfs_rq *cfs_rqb;
 	s64 delta;
 
 	if (samecpu) {
@@ -555,8 +513,13 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
 		sea = sea->parent;
 	while (seb->parent)
 		seb = seb->parent;
-	delta = (s64)(sea->vruntime - seb->vruntime);
 
+	cfs_rqa = sea->cfs_rq;
+	cfs_rqb = seb->cfs_rq;
+
+	/* normalize vruntime WRT their rq's base */
+	delta = (s64)(sea->vruntime - seb->vruntime) +
+		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 out:
 	return delta > 0;
 }
@@ -620,10 +583,6 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
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
index d09cfbd746e5..45c8ce5c2333 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -499,6 +499,7 @@ struct cfs_rq {
 
 	u64			exec_clock;
 	u64			min_vruntime;
+	u64			min_vruntime_fi;
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
-- 
2.28.0.709.gb0816b6eb0-goog
