Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44E2B49F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgKPPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:52:38 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:55389 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730557AbgKPPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:52:38 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 1ED321F7B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:52:36 +0000 (GMT)
Received: (qmail 2698 invoked from network); 16 Nov 2020 15:52:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 15:52:35 -0000
Date:   Mon, 16 Nov 2020 15:52:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116155232.GS3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:20:05PM +0100, Peter Zijlstra wrote:
> > It used to be at least a WRITE_ONCE until 58877d347b58 ("sched: Better
> > document ttwu()") which changed it. Not sure why that is and didn't
> > think about it too deep as it didn't appear to be directly related to
> > the problem and didn't have ordering consequences.
> 
> I'm confused; that commit didn't change deactivate_task(). Anyway,
> ->on_rq should be strictly under rq->lock. That said, since there is a
> READ_ONCE() consumer of ->on_rq it makes sense to have the stores as
> WRITE_ONCE().
> 

It didn't change deactivate_task but it did this

-       WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
-       dequeue_task(rq, p, DEQUEUE_NOCLOCK);
+       deactivate_task(rq, p, DEQUEUE_NOCLOCK);

which makes that write a

p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;

As activate_task is also a plain store and I didn't spot a relevant
ordering problem that would impact loadavg, I concluded it was not
immediately relevant, just a curiousity.

> > > __ttwu_queue_wakelist() we have:
> > > 
> > > 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> > > 
> > > which can be invoked on the try_to_wake_up() path if p->on_rq is first read
> > > as zero and then p->on_cpu is read as 1. Perhaps these non-atomic bitfield
> > > updates can race and cause the flags to be corrupted?
> > > 
> > 
> > I think this is at least one possibility. I think at least that one
> > should only be explicitly set on WF_MIGRATED and explicitly cleared in
> > sched_ttwu_pending. While I haven't audited it fully, it might be enough
> > to avoid a double write outside of the rq lock on the bitfield but I
> > still need to think more about the ordering of sched_contributes_to_load
> > and whether it's ordered by p->on_cpu or not.
> 
> The scenario you're worried about is something like:
> 
> 	CPU0							CPU1
> 
> 	schedule()
> 		prev->sched_contributes_to_load = X;
> 		deactivate_task(prev);
> 
> 								try_to_wake_up()
> 									if (p->on_rq &&) // false
> 									if (smp_load_acquire(&p->on_cpu) && // true
> 									    ttwu_queue_wakelist())
> 										p->sched_remote_wakeup = Y;
> 
> 		smp_store_release(prev->on_cpu, 0);
> 

Yes, mostly because of what memory-barriers.txt warns about for bitfields
if they are not protected by the same lock.

> And then the stores of X and Y clobber one another.. Hummph, seems
> reasonable. One quick thing to test would be something like this:
> 
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7abbdd7f3884..9844e541c94c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -775,7 +775,9 @@ struct task_struct {
>  	unsigned			sched_reset_on_fork:1;
>  	unsigned			sched_contributes_to_load:1;
>  	unsigned			sched_migrated:1;
> +	unsigned			:0;
>  	unsigned			sched_remote_wakeup:1;
> +	unsigned			:0;
>  #ifdef CONFIG_PSI
>  	unsigned			sched_psi_wake_requeue:1;
>  #endif

I'll test this after the smp_wmb() test completes. While a clobbering may
be the issue, I also think the gap between the rq->nr_uninterruptible++
and smp_store_release(prev->on_cpu, 0) is relevant and a better candidate.

-- 
Mel Gorman
SUSE Labs
