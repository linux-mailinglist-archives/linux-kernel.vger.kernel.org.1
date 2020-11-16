Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5762B4BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgKPQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgKPQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:54:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD07C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RdSNhM8Hn1M8U/H/W7XgtiZjk4F566V45WZZcGzUBuo=; b=esKOJAxXuLn1o3Gh7n5RxwHvvG
        bVz98oZiDrmyArrcQS4CRf5vR7/7VjJHV2lfVYMZajOILGoPPdMN7uOUqOXC7H1MciBapaixa1NBv
        Zt4mKoUxBx7GTnCHgewUgiBUvz0r/aGJqXSX/A9SMHGD+XVe+czCO2dnh3SW5In9NZDyKq1uZ1hEf
        XYv+Zyu3f7U82YuaTb+OtoXfyd1dU/1VSGOsOtcj7l2hklXXl0bLtMKNWv9ROoLA00pmNmQJeYdi7
        BFkmwtAAiL9oAl3bzYJd7cxdufp491ktYY0QHkxAX33F3GgsvSrt/u86Mr730j/sY+vFdPStYMsat
        NPykfnsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehlg-00038a-JE; Mon, 16 Nov 2020 16:54:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 645F93012DC;
        Mon, 16 Nov 2020 17:54:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 489F620282DFC; Mon, 16 Nov 2020 17:54:15 +0100 (CET)
Date:   Mon, 16 Nov 2020 17:54:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116165415.GG3121392@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116155232.GS3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116155232.GS3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:52:32PM +0000, Mel Gorman wrote:
> On Mon, Nov 16, 2020 at 03:20:05PM +0100, Peter Zijlstra wrote:
> > > It used to be at least a WRITE_ONCE until 58877d347b58 ("sched: Better
> > > document ttwu()") which changed it. Not sure why that is and didn't
> > > think about it too deep as it didn't appear to be directly related to
> > > the problem and didn't have ordering consequences.
> > 
> > I'm confused; that commit didn't change deactivate_task(). Anyway,
> > ->on_rq should be strictly under rq->lock. That said, since there is a
> > READ_ONCE() consumer of ->on_rq it makes sense to have the stores as
> > WRITE_ONCE().
> > 
> 
> It didn't change deactivate_task but it did this
> 
> -       WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
> -       dequeue_task(rq, p, DEQUEUE_NOCLOCK);
> +       deactivate_task(rq, p, DEQUEUE_NOCLOCK);
> 
> which makes that write a
> 
> p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
> 
> As activate_task is also a plain store and I didn't spot a relevant
> ordering problem that would impact loadavg, I concluded it was not
> immediately relevant, just a curiousity.

That's move_queued_task() case, which is irrelevant for the issue at
hand.

> > > > __ttwu_queue_wakelist() we have:
> > > > 
> > > > 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> > > > 
> > > > which can be invoked on the try_to_wake_up() path if p->on_rq is first read
> > > > as zero and then p->on_cpu is read as 1. Perhaps these non-atomic bitfield
> > > > updates can race and cause the flags to be corrupted?
> > > > 
> > > 
> > > I think this is at least one possibility. I think at least that one
> > > should only be explicitly set on WF_MIGRATED and explicitly cleared in
> > > sched_ttwu_pending. While I haven't audited it fully, it might be enough
> > > to avoid a double write outside of the rq lock on the bitfield but I
> > > still need to think more about the ordering of sched_contributes_to_load
> > > and whether it's ordered by p->on_cpu or not.
> > 
> > The scenario you're worried about is something like:
> > 
> > 	CPU0							CPU1
> > 
> > 	schedule()
> > 		prev->sched_contributes_to_load = X;
> > 		deactivate_task(prev);
> > 
> > 								try_to_wake_up()
> > 									if (p->on_rq &&) // false
> > 									if (smp_load_acquire(&p->on_cpu) && // true
> > 									    ttwu_queue_wakelist())
> > 										p->sched_remote_wakeup = Y;
> > 
> > 		smp_store_release(prev->on_cpu, 0);
> > 
> 
> Yes, mostly because of what memory-barriers.txt warns about for bitfields
> if they are not protected by the same lock.

I'm not sure memory-barriers.txt is relevant; that's simply two racing
stores and 'obviously' buggered.

> > And then the stores of X and Y clobber one another.. Hummph, seems
> > reasonable. One quick thing to test would be something like this:
> > 
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 7abbdd7f3884..9844e541c94c 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -775,7 +775,9 @@ struct task_struct {
> >  	unsigned			sched_reset_on_fork:1;
> >  	unsigned			sched_contributes_to_load:1;
> >  	unsigned			sched_migrated:1;
> > +	unsigned			:0;
> >  	unsigned			sched_remote_wakeup:1;
> > +	unsigned			:0;
> >  #ifdef CONFIG_PSI
> >  	unsigned			sched_psi_wake_requeue:1;
> >  #endif
> 
> I'll test this after the smp_wmb() test completes. While a clobbering may
> be the issue, I also think the gap between the rq->nr_uninterruptible++
> and smp_store_release(prev->on_cpu, 0) is relevant and a better candidate.

I really don't understand what you wrote in that email...
