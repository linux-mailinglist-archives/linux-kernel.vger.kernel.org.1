Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CFE29F465
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgJ2TAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJ2TAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:00:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8917BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=57r/lWUgbbUmqtddMXVNRPEblcX1wLgNtlDW8gxKu0A=; b=YQpbdmK784ziEuyE4Xr8pxF7Xl
        bO0/X5AKtflqFmd8QqpgyiyX06PuSsXgoNYgQ0v1v0Tp6L6dBINmDhxj3+dSEeVPbQhVRBnUu8TUo
        0jI0ngRSr4Fa8F9W/7gkXreqZifEpNJmdY54Ixu/Ogvuf9m8olR4s/LUbLMkETP4vfEo0VkgqqG0P
        +O2MGpFcaQ05ztfQ2Y9PDTjfK4FvGvWe19PF8yCXoyXB1Y6tPFS7ivj8ohtuJ+LgRSDUE6Uv9gesY
        sY8cQ3fhZzwhq6dOnltlTwTiW3V0E8SuSSJpunFqMzUe/a/ekXH6HhobrL7FdD+QfS3DnMOFEkJK5
        SI/D5DWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYD97-000114-DB; Thu, 29 Oct 2020 18:59:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 160E3300446;
        Thu, 29 Oct 2020 19:59:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5B91203BF7FF; Thu, 29 Oct 2020 19:59:33 +0100 (CET)
Date:   Thu, 29 Oct 2020 19:59:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20201029185933.GG2611@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org>
 <20201026124724.GT2611@hirez.programming.kicks-ass.net>
 <20201029182429.GA1844482@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029182429.GA1844482@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:24:29PM -0400, Joel Fernandes wrote:

> > @@ -4823,10 +4822,8 @@ pick_next_task(struct rq *rq, struct tas
> >  		if (!rq_i->core_pick)
> >  			continue;
> >  
> > -		if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
> > -		    !rq_i->core->core_forceidle) {
> > -			rq_i->core->core_forceidle = true;
> > -		}
> > +		if (!(fi_before && rq->core->core_forceidle))
> > +			task_vruntime_update(rq_i, rq_i->core_pick);
> 
> Shouldn't this be:
> 
> 	if (!fi_before && rq->core->core_forceidle)
> 			task_vruntime_update(rq_i, rq_i->core_pick);
> 
> ?

*groan*, I should've written a comment there :/

When we're not fi, we need to update.
when we're fi and we were not fi, we must update
When we're fi and we were already fi, we must not update

Which gives:

	fib	fi	X

	0	0	1
	0	1	0
	1	0	1
	1	1	1

which is: !(!fib && fi) or something.

> > +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> > +{
> > +	struct rq *rq = task_rq(a);
> > +	struct sched_entity *sea = &a->se;
> > +	struct sched_entity *seb = &b->se;
> > +	struct cfs_rq *cfs_rqa;
> > +	struct cfs_rq *cfs_rqb;
> > +	s64 delta;
> > +
> > +	SCHED_WARN_ON(task_rq(b)->core != rq->core);
> > +
> > +	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
> > +		int sea_depth = sea->depth;
> > +		int seb_depth = seb->depth;
> > +
> > +		if (sea_depth >= seb_depth)
> > +			sea = parent_entity(sea);
> > +		if (sea_depth <= seb_depth)
> > +			seb = parent_entity(seb);
> > +	}
> > +
> > +	if (rq->core->core_forceidle) {
> > +		se_fi_update(sea, rq->core->core_forceidle_seq, true);
> > +		se_fi_update(seb, rq->core->core_forceidle_seq, true);
> > +	}
> 
> As we chatted on IRC you mentioned the reason for the sync here is:
> 
>  say we have 2 cgroups (a,b) under root, and we go force-idle in a, then we
>  update a and root. Then we pick and end up in b, but b hasn't been updated
>  yet.
> 
> One thing I was wondering about that was, if the pick of 'b' happens much
> later than 'a', then the snapshot might be happening too late right?

No, since this is the first pick in b since fi, it cannot have advanced.
So by updating to fi_seq before picking, we guarantee it is unchanged
since we went fi.
