Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B784B298D11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775442AbgJZMsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:48:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775434AbgJZMsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8z7lC8inBjW/CfTmD5xG9915EkN6oe2dFKK/Pu9tyBA=; b=wCthTUegaCH95QRlc7RuVUiMg4
        IBBCkAw9tE5PV+A9VYDbddF1kdTkawR9Ms+1ZfSLv3uEGQVTEM80821ED6e+mhMoD8J4L8QT7HVhA
        tcKn6bwKad65gOGNvaJiYDTPy5dn1rMgbVpIxBjuZQPI2nYF14+HLANMauQjh6F2bdgfxlrrMu1oY
        mQucxqhfEMrKcTFmyabCOaQ1KH8Lty5vMRoVb1+NnAdSxLR7V4HE5efjC4H58Y6Vri6bO6+TQhWc1
        KOTAK5aXxkCXw3Pr3JT21Dk7iNFQ+ST9w1GAvkkVck4AHGdfTTKN+HSPfJUe7lOIUNu0vnb8no7YV
        dDXDtnWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX1uJ-0000n3-GP; Mon, 26 Oct 2020 12:47:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85526305815;
        Mon, 26 Oct 2020 13:47:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 605922141F784; Mon, 26 Oct 2020 13:47:24 +0100 (CET)
Date:   Mon, 26 Oct 2020 13:47:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 08/26] sched/fair: Snapshot the min_vruntime of
 CPUs on force idle
Message-ID: <20201026124724.GT2611@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020014336.2076526-9-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 09:43:18PM -0400, Joel Fernandes (Google) wrote:

> @@ -4723,6 +4714,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  			update_rq_clock(rq_i);
>  	}
>  
> +	/* Reset the snapshot if core is no longer in force-idle. */
> +	if (!fi_before) {
> +		for_each_cpu(i, smt_mask) {
> +			struct rq *rq_i = cpu_rq(i);
> +			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
> +		}
> +	}

So this is the thing that drags vruntime_fi along when (both?) siblings
are active, right? But should we not do that after pick? Consider 2
tasks a weight 1 and a weight 10 task, one for each sibling. By syncing
the vruntime before picking, the cfs_prio_less() loop will not be able
to distinguish between these two, since they'll both have effectively
the same lag.

If however, you syn after pick, then the weight 1 task will have accreud
far more runtime than the weight 10 task, and consequently the weight 10
task will have preference when a decision will have to be made.

(also, if this were the right place, the whole thing should've been part
of the for_each_cpu() loop right before this)

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 56bea0decda1..9cae08c3fca1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10686,6 +10686,46 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
>  	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
>  		resched_curr(rq);
>  }
> +
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	bool samecpu = task_cpu(a) == task_cpu(b);
> +	struct sched_entity *sea = &a->se;
> +	struct sched_entity *seb = &b->se;
> +	struct cfs_rq *cfs_rqa;
> +	struct cfs_rq *cfs_rqb;
> +	s64 delta;
> +
> +	if (samecpu) {
> +		/* vruntime is per cfs_rq */
> +		while (!is_same_group(sea, seb)) {
> +			int sea_depth = sea->depth;
> +			int seb_depth = seb->depth;
> +			if (sea_depth >= seb_depth)
> +				sea = parent_entity(sea);
> +			if (sea_depth <= seb_depth)
> +				seb = parent_entity(seb);
> +		}
> +
> +		delta = (s64)(sea->vruntime - seb->vruntime);
> +		goto out;
> +	}
> +
> +	/* crosscpu: compare root level se's vruntime to decide priority */
> +	while (sea->parent)
> +		sea = sea->parent;
> +	while (seb->parent)
> +		seb = seb->parent;

This seems unfortunate, I think we can do better.

> +
> +	cfs_rqa = sea->cfs_rq;
> +	cfs_rqb = seb->cfs_rq;
> +
> +	/* normalize vruntime WRT their rq's base */
> +	delta = (s64)(sea->vruntime - seb->vruntime) +
> +		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
> +out:
> +	return delta > 0;
> +}


How's something like this?

 - after each pick, such that the pick itself sees the divergence (see
   above); either:

    - pull the vruntime_fi forward, when !fi
    - freeze the vruntime_fi, when newly fi    (A)

 - either way, update vruntime_fi for each cfs_rq in the active
   hierachy.

 - when comparing, and fi, update the vruntime_fi hierachy until we
   encounter a mark from (A), per doing it during the pick, but before
   runtime, this guaranteees it hasn't moved since (A).

XXX, still buggered on SMT>2, imagine having {ta, tb, fi, i} on an SMT4,
then when comparing any two tasks that do not involve the fi, we should
(probably) have pulled them fwd -- but we can't actually pull them,
because then the fi thing would break, mooo.


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -115,19 +115,8 @@ static inline bool prio_less(struct task
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
@@ -4642,12 +4631,15 @@ pick_task(struct rq *rq, const struct sc
 	return cookie_pick;
 }
 
+extern void task_vruntime_update(struct rq *rq, struct task_struct *p);
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
+	bool fi_before = false;
 	bool need_sync;
 	int i, j, cpu;
 
@@ -4707,6 +4699,7 @@ pick_next_task(struct rq *rq, struct tas
 	need_sync = !!rq->core->core_cookie;
 	if (rq->core->core_forceidle) {
 		need_sync = true;
+		fi_before = true;
 		rq->core->core_forceidle = false;
 	}
 
@@ -4757,6 +4750,11 @@ pick_next_task(struct rq *rq, struct tas
 				continue;
 
 			rq_i->core_pick = p;
+			if (rq_i->idle == p && rq_i->nr_running) {
+				rq->core->core_forceidle = true;
+				if (!fi_before)
+					rq->core->core_forceidle_seq++;
+			}
 
 			/*
 			 * If this new candidate is of higher priority than the
@@ -4775,6 +4773,7 @@ pick_next_task(struct rq *rq, struct tas
 				max = p;
 
 				if (old_max) {
+					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -4823,10 +4822,8 @@ pick_next_task(struct rq *rq, struct tas
 		if (!rq_i->core_pick)
 			continue;
 
-		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
-		    !rq_i->core->core_forceidle) {
-			rq_i->core->core_forceidle = true;
-		}
+		if (!(fi_before && rq->core->core_forceidle))
+			task_vruntime_update(rq_i, rq_i->core_pick);
 
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10686,6 +10686,67 @@ static inline void task_tick_core(struct
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
+
+static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
+{
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
+void task_vruntime_update(struct rq *rq, struct task_struct *p)
+{
+	struct sched_entity *se = &p->se;
+
+	if (p->sched_class != &fair_sched_class)
+		return;
+
+	se_fi_update(se, rq->core->core_forceidle_seq, rq->core->core_forceidle);
+}
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct rq *rq = task_rq(a);
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	struct cfs_rq *cfs_rqa;
+	struct cfs_rq *cfs_rqb;
+	s64 delta;
+
+	SCHED_WARN_ON(task_rq(b)->core != rq->core);
+
+	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
+		int sea_depth = sea->depth;
+		int seb_depth = seb->depth;
+
+		if (sea_depth >= seb_depth)
+			sea = parent_entity(sea);
+		if (sea_depth <= seb_depth)
+			seb = parent_entity(seb);
+	}
+
+	if (rq->core->core_forceidle) {
+		se_fi_update(sea, rq->core->core_forceidle_seq, true);
+		se_fi_update(seb, rq->core->core_forceidle_seq, true);
+	}
+
+	cfs_rqa = sea->cfs_rq;
+	cfs_rqb = seb->cfs_rq;
+
+	/* normalize vruntime WRT their rq's base */
+	delta = (s64)(sea->vruntime - seb->vruntime) +
+		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
+
+	return delta > 0;
+}
 #else
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -522,6 +522,11 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+#ifdef CONFIG_SCHED_CORE
+	unsigned int		forceidle_seq;
+	u64			min_vruntime_fi;
+#endif
+
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifndef CONFIG_64BIT
@@ -1061,7 +1066,8 @@ struct rq {
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
-	unsigned char		core_forceidle;
+	unsigned int		core_forceidle;
+	unsigned int		core_forceidle_seq;
 #endif
 };
 
@@ -1106,6 +1112,8 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
