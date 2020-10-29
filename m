Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C837229F40E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJ2SYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJ2SYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:24:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:24:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b18so2775990qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/QTc8D0vhtQsPvELK2npFA1du/dc5nEGtBgs0aqvuqE=;
        b=c5YlyWrjnUQSlTRidr+K7g8Hc5O30Ukn7exoIt1p1jiI4Gy8olmUOVb6nbSVMi54/8
         fGW2HJ0nJjd5T9YiIL77BD5UW88x7iR6a/SpQa1DokKwvKvFREwRUxh8j7JmDcNsflte
         VidcwWrNDDudXDLl6hw7yIho1GQEWeNSUxz+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/QTc8D0vhtQsPvELK2npFA1du/dc5nEGtBgs0aqvuqE=;
        b=D4L+F+jsOMkq0WbzJi+nOGtETeBvBu5k9AGucp2AaFMVoYnukkI42bczrUAYaV9Y8h
         S1FJ9P5BlSaRv4NLaGqSDD5RjfAbrdQ/zu1oNfzF10z6QeEKjPrntsyVPoHVLBzWdGYI
         hEb8k58FsAd51F4juysoi1uqmTTJu+wfnkjAV/uYGvtDNmkweNCoCJY7Qj1aAhgGVJNL
         AL8y1UWe8Mh9wvRlEE04KE1/W9wI5hG//buYUCp5zUmRMJhVYjJrgLUmwQ18fgECz8IR
         ab8pkNIcR2HWAY9XJ2oi7+k/r+jAieVfJFdUDpgtk9AnI37SJ+I5VtnPAoPQdAXjoFeU
         ka1A==
X-Gm-Message-State: AOAM531F+6vXLB16p9Su5uqkR7/3IRTL7hb9JZWKIB0kw9xzj0ilrTz/
        kOIHcKAs1VYJ5aJHyzHeLY9i+A==
X-Google-Smtp-Source: ABdhPJxsz/jpvcYWVHOkg8/XdxFUU8vC2SBM0IQY4X6IFry8fXpmLjd4ixlKZWE7YBpIt3B8pT5SAA==
X-Received: by 2002:a37:4692:: with SMTP id t140mr3837727qka.275.1603995870747;
        Thu, 29 Oct 2020 11:24:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id o5sm1532788qtt.3.2020.10.29.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:24:29 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:24:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
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
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 08/26] sched/fair: Snapshot the min_vruntime of
 CPUs on force idle
Message-ID: <20201029182429.GA1844482@google.com>
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
[..] 
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
> 
v> 
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

Shouldn't this be:

	if (!fi_before && rq->core->core_forceidle)
			task_vruntime_update(rq_i, rq_i->core_pick);

?

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

As we chatted on IRC you mentioned the reason for the sync here is:

 say we have 2 cgroups (a,b) under root, and we go force-idle in a, then we
 update a and root. Then we pick and end up in b, but b hasn't been updated
 yet.

One thing I was wondering about that was, if the pick of 'b' happens much
later than 'a', then the snapshot might be happening too late right?

Maybe the snapshot should happen on all cfs_rqs on all siblings in
pick_next_task() itself? That way everything gets updated at the instant the
force-idle started. Thought that may be a bit more slow.

thanks,

 - Joel

