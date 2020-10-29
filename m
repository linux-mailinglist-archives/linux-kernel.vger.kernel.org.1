Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761ED29F267
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJ2Q7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgJ2Q7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:59:17 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:59:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cv1so1621086qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vo9k3ckWD9hL1xrwQVMH+VsTn9K1T1wJ8yjkMnzmTEU=;
        b=p5K++XJOfQaJGL+20EQ9n887+T7EeWHua1mb5Gs7jWqzmlQIXe1ZvMlbIF1sKL6sMv
         Suc2JTNcWnc77n5gaUGTZW8lU98jjpDUAWIQsyZ7q3xbyIwnJa9f3qJmhwz1RGzdz+14
         4tGrQsDIoXAQ+6rPGeG7VeAydNyt/RhYthA7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vo9k3ckWD9hL1xrwQVMH+VsTn9K1T1wJ8yjkMnzmTEU=;
        b=QQ8Gqg1co4DTc49IyuZnWDqOLTOXeL5M36N8s6WPiCbfkZu2xCtpucLWCQJbl7rtSU
         MSqS2T5OJ/vKGYcBqbH1xfBEUTRBGlXBwksZ0ZVsxoOfI3fQre15bEW7ObJ1rU7xKBk/
         NLOttoCYPTR3co6xE1Gj52uVS7LdkdR3KoresEKtuKo0+Yx+toeHO0c0MunIR/yRGNWa
         rGhkfblgEZKBpJT4b5zAKUOTkPddmqXhJtikMmWTXuIXaxsCc9ywNxh3+IZCodWtflr2
         ZwkPMoo22fk4yzhuV2jg2i5WDolEavPG3/qtvioDQC1HlDvY8SQDxGKGIR+zbgJqgjde
         PkKQ==
X-Gm-Message-State: AOAM533v0og9Qh9Jn2BIll7mxODHVu+pP2dQ6gef+JbvnYj3GjGgF+Rb
        1iGG0Rhon0KIyEWcuSgJwHHbdg==
X-Google-Smtp-Source: ABdhPJy7EagYagnYkZFgj9GpTjrPFx+RljHyAAWG4kLEUmurjJKdt/1/0BIGQ2x30i/gHFMzKkKzag==
X-Received: by 2002:ad4:4142:: with SMTP id z2mr5478133qvp.20.1603990755868;
        Thu, 29 Oct 2020 09:59:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b8sm1330754qkn.133.2020.10.29.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:59:14 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:59:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201029165914.GA1589842@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org>
 <20201026124724.GT2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026124724.GT2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:47:24PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 09:43:18PM -0400, Joel Fernandes (Google) wrote:
> 
> > @@ -4723,6 +4714,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  			update_rq_clock(rq_i);
> >  	}
> >  
> > +	/* Reset the snapshot if core is no longer in force-idle. */
> > +	if (!fi_before) {
> > +		for_each_cpu(i, smt_mask) {
> > +			struct rq *rq_i = cpu_rq(i);
> > +			rq_i->cfs.min_vruntime_fi = rq_i->cfs.min_vruntime;
> > +		}
> > +	}
> 
> So this is the thing that drags vruntime_fi along when (both?) siblings
> are active, right? But should we not do that after pick? Consider 2
> tasks a weight 1 and a weight 10 task, one for each sibling. By syncing
> the vruntime before picking, the cfs_prio_less() loop will not be able
> to distinguish between these two, since they'll both have effectively
> the same lag.
> 
> If however, you syn after pick, then the weight 1 task will have accreud
> far more runtime than the weight 10 task, and consequently the weight 10
> task will have preference when a decision will have to be made.
> 
> (also, if this were the right place, the whole thing should've been part
> of the for_each_cpu() loop right before this)
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 56bea0decda1..9cae08c3fca1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10686,6 +10686,46 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
> >  	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
> >  		resched_curr(rq);
> >  }
> > +
> > +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> > +{
> > +	bool samecpu = task_cpu(a) == task_cpu(b);
> > +	struct sched_entity *sea = &a->se;
> > +	struct sched_entity *seb = &b->se;
> > +	struct cfs_rq *cfs_rqa;
> > +	struct cfs_rq *cfs_rqb;
> > +	s64 delta;
> > +
> > +	if (samecpu) {
> > +		/* vruntime is per cfs_rq */
> > +		while (!is_same_group(sea, seb)) {
> > +			int sea_depth = sea->depth;
> > +			int seb_depth = seb->depth;
> > +			if (sea_depth >= seb_depth)
> > +				sea = parent_entity(sea);
> > +			if (sea_depth <= seb_depth)
> > +				seb = parent_entity(seb);
> > +		}
> > +
> > +		delta = (s64)(sea->vruntime - seb->vruntime);
> > +		goto out;
> > +	}
> > +
> > +	/* crosscpu: compare root level se's vruntime to decide priority */
> > +	while (sea->parent)
> > +		sea = sea->parent;
> > +	while (seb->parent)
> > +		seb = seb->parent;
> 
> This seems unfortunate, I think we can do better.
> 
> > +
> > +	cfs_rqa = sea->cfs_rq;
> > +	cfs_rqb = seb->cfs_rq;
> > +
> > +	/* normalize vruntime WRT their rq's base */
> > +	delta = (s64)(sea->vruntime - seb->vruntime) +
> > +		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
> > +out:
> > +	return delta > 0;
> > +}
> 
> 
> How's something like this?
> 
>  - after each pick, such that the pick itself sees the divergence (see
>    above); either:
> 
>     - pull the vruntime_fi forward, when !fi
>     - freeze the vruntime_fi, when newly fi    (A)
> 
>  - either way, update vruntime_fi for each cfs_rq in the active
>    hierachy.
> 
>  - when comparing, and fi, update the vruntime_fi hierachy until we
>    encounter a mark from (A), per doing it during the pick, but before
>    runtime, this guaranteees it hasn't moved since (A).
> 
> XXX, still buggered on SMT>2, imagine having {ta, tb, fi, i} on an SMT4,
> then when comparing any two tasks that do not involve the fi, we should
> (probably) have pulled them fwd -- but we can't actually pull them,
> because then the fi thing would break, mooo.

Hi Peter, Vineeth,

I tried Peter's diff (had to backport it to 4.19 as that's what our devices are
on). Let me know if I screwed the backport:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/6469fd5b6bcd0eb1e054307aa4b54bc9e937346d%5E%21/

With Peter's changes, I see really bad wakeup latencies when running a simple
synthetic test (1 task busy on a CPU with the sibling doing a 70% run-sleep
cycle with 1 second period. The 'perf sched latency' worst case is of the
order of 100s of ms, which I don't see with my patch.

I do feel Peter's patch is better though and I'll try to debug it.

thanks,

 - Joel


> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -115,19 +115,8 @@ static inline bool prio_less(struct task
>  	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
>  		return !dl_time_before(a->dl.deadline, b->dl.deadline);
>  
> -	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
> -		u64 vruntime = b->se.vruntime;
> -
> -		/*
> -		 * Normalize the vruntime if tasks are in different cpus.
> -		 */
> -		if (task_cpu(a) != task_cpu(b)) {
> -			vruntime -= task_cfs_rq(b)->min_vruntime;
> -			vruntime += task_cfs_rq(a)->min_vruntime;
> -		}
> -
> -		return !((s64)(a->se.vruntime - vruntime) <= 0);
> -	}
> +	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
> +		return cfs_prio_less(a, b);
>  
>  	return false;
>  }
> @@ -4642,12 +4631,15 @@ pick_task(struct rq *rq, const struct sc
>  	return cookie_pick;
>  }
>  
> +extern void task_vruntime_update(struct rq *rq, struct task_struct *p);
> +
>  static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  	struct task_struct *next, *max = NULL;
>  	const struct sched_class *class;
>  	const struct cpumask *smt_mask;
> +	bool fi_before = false;
>  	bool need_sync;
>  	int i, j, cpu;
>  
> @@ -4707,6 +4699,7 @@ pick_next_task(struct rq *rq, struct tas
>  	need_sync = !!rq->core->core_cookie;
>  	if (rq->core->core_forceidle) {
>  		need_sync = true;
> +		fi_before = true;
>  		rq->core->core_forceidle = false;
>  	}
>  
> @@ -4757,6 +4750,11 @@ pick_next_task(struct rq *rq, struct tas
>  				continue;
>  
>  			rq_i->core_pick = p;
> +			if (rq_i->idle == p && rq_i->nr_running) {
> +				rq->core->core_forceidle = true;
> +				if (!fi_before)
> +					rq->core->core_forceidle_seq++;
> +			}
>  
>  			/*
>  			 * If this new candidate is of higher priority than the
> @@ -4775,6 +4773,7 @@ pick_next_task(struct rq *rq, struct tas
>  				max = p;
>  
>  				if (old_max) {
> +					rq->core->core_forceidle = false;
>  					for_each_cpu(j, smt_mask) {
>  						if (j == i)
>  							continue;
> @@ -4823,10 +4822,8 @@ pick_next_task(struct rq *rq, struct tas
>  		if (!rq_i->core_pick)
>  			continue;
>  
> -		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
> -		    !rq_i->core->core_forceidle) {
> -			rq_i->core->core_forceidle = true;
> -		}
> +		if (!(fi_before && rq->core->core_forceidle))
> +			task_vruntime_update(rq_i, rq_i->core_pick);
>  
>  		if (i == cpu) {
>  			rq_i->core_pick = NULL;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10686,6 +10686,67 @@ static inline void task_tick_core(struct
>  	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
>  		resched_curr(rq);
>  }
> +
> +static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
> +{
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +		if (forceidle) {
> +			if (cfs_rq->forceidle_seq == fi_seq)
> +				break;
> +			cfs_rq->forceidle_seq = fi_seq;
> +		}
> +
> +		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
> +	}
> +}
> +
> +void task_vruntime_update(struct rq *rq, struct task_struct *p)
> +{
> +	struct sched_entity *se = &p->se;
> +
> +	if (p->sched_class != &fair_sched_class)
> +		return;
> +
> +	se_fi_update(se, rq->core->core_forceidle_seq, rq->core->core_forceidle);
> +}
> +
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	struct rq *rq = task_rq(a);
> +	struct sched_entity *sea = &a->se;
> +	struct sched_entity *seb = &b->se;
> +	struct cfs_rq *cfs_rqa;
> +	struct cfs_rq *cfs_rqb;
> +	s64 delta;
> +
> +	SCHED_WARN_ON(task_rq(b)->core != rq->core);
> +
> +	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
> +		int sea_depth = sea->depth;
> +		int seb_depth = seb->depth;
> +
> +		if (sea_depth >= seb_depth)
> +			sea = parent_entity(sea);
> +		if (sea_depth <= seb_depth)
> +			seb = parent_entity(seb);
> +	}
> +
> +	if (rq->core->core_forceidle) {
> +		se_fi_update(sea, rq->core->core_forceidle_seq, true);
> +		se_fi_update(seb, rq->core->core_forceidle_seq, true);
> +	}
> +
> +	cfs_rqa = sea->cfs_rq;
> +	cfs_rqb = seb->cfs_rq;
> +
> +	/* normalize vruntime WRT their rq's base */
> +	delta = (s64)(sea->vruntime - seb->vruntime) +
> +		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
> +
> +	return delta > 0;
> +}
>  #else
>  static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
>  #endif
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -522,6 +522,11 @@ struct cfs_rq {
>  	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
>  	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
>  
> +#ifdef CONFIG_SCHED_CORE
> +	unsigned int		forceidle_seq;
> +	u64			min_vruntime_fi;
> +#endif
> +
>  	u64			exec_clock;
>  	u64			min_vruntime;
>  #ifndef CONFIG_64BIT
> @@ -1061,7 +1066,8 @@ struct rq {
>  	unsigned int		core_task_seq;
>  	unsigned int		core_pick_seq;
>  	unsigned long		core_cookie;
> -	unsigned char		core_forceidle;
> +	unsigned int		core_forceidle;
> +	unsigned int		core_forceidle_seq;
>  #endif
>  };
>  
> @@ -1106,6 +1112,8 @@ static inline raw_spinlock_t *rq_lockp(s
>  	return &rq->__lock;
>  }
>  
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
> +
>  #else /* !CONFIG_SCHED_CORE */
>  
>  static inline bool sched_core_enabled(struct rq *rq)
