Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9062A1ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgJaVlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJaVlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:41:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502FFC0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:41:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a65so6074443qkg.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FcJEHiC/aqNUQz438vQCMkPtjfJ7RnY44co/c5S+XzU=;
        b=KlaJXy0WvRkKJNJBtdXdHy91YPjEdds4e7gqhm12IOtyjYnrfaYPtbgghAGLy8HxY0
         RbDePB5Od75QWfSComX87In/VrjavOpy81F03Ygui2EDjCiKdJhs05KrYtaoon7mPshQ
         VcG0OLbBN7cGZ8hZEWnoxYxPpdqm2I6o4squc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FcJEHiC/aqNUQz438vQCMkPtjfJ7RnY44co/c5S+XzU=;
        b=eKgJB8dsUk7tDOJoGzKUptDT8ueHHg4J6mIe48lLK8Xo0bdh/6kOMW3EHiKEK6rzEi
         f2jk77ZXAa2DtIGF/xFBVUZz6paWyjkcaghvbs+//+uhmLamM58IeaM8yYKwdVlalib5
         hC8rj86bw8KdIHn5HNQU8NS1ghNNVz2+aFIj79jLM2xcCSrPzLAr/jXh/GT70N7YwLMw
         dCmLuhaqmu9XfqeOoxYPgIrPF7txUO936fhDXkKAMTJoTZsH2d2AGQD9W1T2J51IA2Q/
         cXuH3L77EHl/A8+HRigiJOGZHKevYLCmFjQnWF5XlG2Q0TTfI+U1d0yA+1pKAC2ws1BI
         VJeA==
X-Gm-Message-State: AOAM530Q01QrJvayBbUMtp2I+FAhfWyHgAot7lT026HLl4KhpMSBEkYk
        dpmB+IwPXYNrIMQT2Iw6yepkwA==
X-Google-Smtp-Source: ABdhPJxVKAlO0dveVOasRBEvF8Kv+9n2LcDWRBu+n5dDsTxbqUVfdDdAJ/apUXELoaW5DMQCz3/hrg==
X-Received: by 2002:a37:6311:: with SMTP id x17mr8424529qkb.323.1604180472527;
        Sat, 31 Oct 2020 14:41:12 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id e6sm5019678qtb.32.2020.10.31.14.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 14:41:11 -0700 (PDT)
Date:   Sat, 31 Oct 2020 17:41:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 08/26] sched/fair: Snapshot the min_vruntime of
 CPUs on force idle
Message-ID: <20201031214111.GA2798587@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org>
 <20201026124724.GT2611@hirez.programming.kicks-ass.net>
 <20201029182429.GA1844482@google.com>
 <20201029185933.GG2611@hirez.programming.kicks-ass.net>
 <CAEXW_YRtrhhL4Gc8W8_-2CR1CCw6_hhtnwSdQ-dMLYCJ+fP+RA@mail.gmail.com>
 <CAEXW_YTnJWANAZNeR9b=5xUeHu1CAPq9vgYaH8WSHgApJZ21Rw@mail.gmail.com>
 <20201030084112.GX2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030084112.GX2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 09:41:12AM +0100, Peter Zijlstra wrote:
> On Thu, Oct 29, 2020 at 10:42:29PM -0400, Joel Fernandes wrote:
> 
> > Forgot to ask, do you also need to do the task_vruntime_update() for
> > the unconstrained pick?
> 
> Humm.. interesting case.
> 
> Yes, however... since in that case the picks aren't synchronized it's a
> wee bit dodgy. I'll throw it on the pile together with SMT4.

Ok. I threw it into the patch below anyway to not take any chances. I got the
version of your patch to a point where the perf is looking good (there's
still some room for improvement, but I am much much happier with the tests).

The changes are:
- Fix but in !(fib && !fi) thingie.
- Pass prio_less with with force-idle information ... prio_less() is called
  from various paths. We need to be careful what we pass it. Its possible we
  select idle on something, but we are not done with selection yet - we
  continue doing prio_less(). So just pass it fi_before.
- During enqueue, prio_less is used then, we may need to sync even then.
- Make cfs_prio_less sync even when !fi.
- Sync the min_vruntime for unconstrained picks and during prio_less() even
  when the core is not in FI. Clarify why you feel for its dodgy for sync'ing
  when unconstrained?

> Also, I'm still hoping you can make this form work:
> 
>   https://lkml.kernel.org/r/20201026093131.GF2628@hirez.programming.kicks-ass.net
> 
> (note that the put_prev_task() needs an additional rq argument)
> 
> That's both simpler code and faster.

Sure, I'll give that a go soon.

(This is based on our older 4.19 kernel, so the task_tick_fair() bit needed
changes to make it work - which aren't needed in v8).

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 711f8a78a947..c15fd5bbc707 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -97,7 +97,7 @@ static inline int __task_prio(struct task_struct *p)
  */
 
 /* real prio, less is less */
-static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 {
 
 	int pa = __task_prio(a), pb = __task_prio(b);
@@ -112,7 +112,7 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
 	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
-		return cfs_prio_less(a, b);
+		return cfs_prio_less(a, b, in_fi);
 
 	return false;
 }
@@ -126,7 +126,7 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 		return false;
 
 	/* flip prio, so high prio is leftmost */
-	if (prio_less(b, a))
+	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
 		return true;
 
 	return false;
@@ -4025,7 +4025,7 @@ void sched_core_irq_exit(void)
  * - Else returns idle_task.
  */
 static struct task_struct *
-pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
 {
 	struct task_struct *class_pick, *cookie_pick;
 	unsigned long cookie = rq->core->core_cookie;
@@ -4040,7 +4040,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		 * higher priority than max.
 		 */
 		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max))
+		    prio_less(class_pick, max, in_fi))
 			return idle_sched_class.pick_task(rq);
 
 		return class_pick;
@@ -4059,13 +4059,15 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
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
@@ -4141,15 +4143,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			update_rq_clock(rq_i);
 	}
 
-	if (!fi_before) {
-		for_each_cpu(i, smt_mask) {
-			struct rq *rq_i = cpu_rq(i);
-
-			/* Reset the snapshot if core is no longer in force-idle. */
-			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
-		}
-	}
-
 	/*
 	 * Try and select tasks for each sibling in decending sched_class
 	 * order.
@@ -4174,7 +4167,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 * highest priority task already selected for this
 			 * core.
 			 */
-			p = pick_task(rq_i, class, max);
+			p = pick_task(rq_i, class, max, fi_before);
 			if (!p) {
 				/*
 				 * If there weren't no cookies; we don't need
@@ -4199,6 +4192,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+
+				WARN_ON_ONCE(fi_before);
+				task_vruntime_update(rq_i, p, false);
+
 				goto done;
 			}
 
@@ -4206,6 +4203,11 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				occ++;
 
 			rq_i->core_pick = p;
+			if (rq_i->idle == p && rq_i->nr_running) {
+				rq->core->core_forceidle = true;
+				if (!fi_before)
+					rq->core->core_forceidle_seq++;
+			}
 
 			/*
 			 * If this new candidate is of higher priority than the
@@ -4224,6 +4226,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				max = p;
 
 				if (old_max) {
+					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -4268,29 +4271,22 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
-		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running) {
-			rq_i->core_forceidle = true;
-			need_sync = true;
-		}
+		if (!(!fi_before && rq->core->core_forceidle)) {
+			task_vruntime_update(rq_i, rq_i->core_pick, true);
 
-		rq_i->core_pick->core_occupation = occ;
+			rq_i->core_pick->core_occupation = occ;
 
-		if (i == cpu)
-			continue;
+			if (i == cpu)
+				continue;
 
-		if (rq_i->curr != rq_i->core_pick)
-			resched_curr(rq_i);
+			if (rq_i->curr != rq_i->core_pick) {
+				resched_curr(rq_i);
+			}
+		}
 
 		/* Did we break L1TF mitigation requirements? */
-		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
-	}
-
-	if (!fi_before && need_sync) {
-		for_each_cpu(i, smt_mask) {
-			struct rq *rq_i = cpu_rq(i);
-
-			/* Snapshot if core is in force-idle. */
-			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
+		if (unlikely(!cookie_match(next, rq_i->core_pick))) {
+			WARN_ON_ONCE(1);
 		}
 	}
 done:
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e36608477aa..6d8e16bc3d79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -483,36 +483,30 @@ static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle);
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 {
-	bool samecpu = task_cpu(a) == task_cpu(b);
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
+	SCHED_WARN_ON(task_rq(b)->core != rq->core);
 
-			if (sea_depth >= seb_depth)
-				sea = parent_entity(sea);
-			if (sea_depth <= seb_depth)
-				seb = parent_entity(seb);
-		}
+	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
+		int sea_depth = sea->depth;
+		int seb_depth = seb->depth;
 
-		delta = (s64)(sea->vruntime - seb->vruntime);
-		goto out;
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
@@ -520,7 +514,7 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
 	/* normalize vruntime WRT their rq's base */
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
-out:
+
 	return delta > 0;
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
@@ -10929,8 +10923,6 @@ static void core_sched_deactivate_fair(struct rq *rq)
  */
 static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
 {
-	int cpu = cpu_of(rq), sibling_cpu;
-
 	/*
 	 * If runqueue has only one task which used up its slice and if the
 	 * sibling is forced idle, then trigger schedule to give forced idle
@@ -10944,23 +10936,9 @@ static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
 	 * forced idle cpu has atleast MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks
 	 * and use that to check if we need to give up the cpu.
 	 */
-	if (rq->cfs.nr_running > 1 ||
-	    !__entity_slice_used(se, MIN_NR_TASKS_DURING_FORCEIDLE))
-		return;
-
-	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
-		struct rq *sibling_rq;
-		if (sibling_cpu == cpu)
-			continue;
-		if (cpu_is_offline(sibling_cpu))
-			continue;
-
-		sibling_rq = cpu_rq(sibling_cpu);
-		if (sibling_rq->core_forceidle) {
-			resched_curr(rq);
-			break;
-		}
-	}
+	if (rq->core->core_forceidle && rq->cfs.nr_running == 1 &&
+	    __entity_slice_used(se, MIN_NR_TASKS_DURING_FORCEIDLE))
+		resched_curr(rq);
 }
 #endif
 
@@ -11102,6 +11080,41 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 }
+static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
+{
+	bool root = true;
+	long old, new;
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		if (forceidle) {
+			if (cfs_rq->forceidle_seq == fi_seq)
+				break;
+			cfs_rq->forceidle_seq = fi_seq;
+		}
+
+		if (root) {
+			old = cfs_rq->min_vruntime_fi;
+			new = cfs_rq->min_vruntime;
+			root = false;
+			trace_printk("cfs_rq(min_vruntime_fi) %Lu->%Lu\n",
+				     old, new);
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
 #else
 static void propagate_entity_cfs_rq(struct sched_entity *se) { }
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 45c8ce5c2333..74ad557d551e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -497,9 +497,13 @@ struct cfs_rq {
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;
 
+#ifdef CONFIG_SCHED_CORE
+	unsigned int		forceidle_seq;
+	u64			min_vruntime_fi;
+#endif
+
 	u64			exec_clock;
 	u64			min_vruntime;
-	u64			min_vruntime_fi;
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
@@ -974,7 +978,6 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-	bool			core_forceidle;
 	unsigned char		core_pause_pending;
 	unsigned int		core_this_irq_nest;
 
@@ -982,6 +985,8 @@ struct rq {
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned int		core_forceidle;
+	unsigned int		core_forceidle_seq;
 	unsigned int		core_irq_nest;
 #endif
 };
@@ -1061,6 +1066,8 @@ extern void queue_core_balance(struct rq *rq);
 void sched_core_add(struct rq *rq, struct task_struct *p);
 void sched_core_remove(struct rq *rq, struct task_struct *p);
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -2549,7 +2556,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 #define perf_domain_span(pd) NULL
 #endif
 
-bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 #ifdef CONFIG_SMP
 extern struct static_key_false sched_energy_present;
