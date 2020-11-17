Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234D22B5BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgKQJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKQJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:29:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/mGspyDrUE9cLixCRZMRH+ZDRs8K51mv90gNUMNpFR4=; b=jy4Z5odYqv8DhSI+/PSRBa85wX
        rvInEFPfcMMTaM1e1C08rsjC41c/UEC9HduBUpE6gaWftm/z/TA+n/FHhrhHodeU/cWudoJ/QvVVG
        nkq0+apjqw1kxT1pdIVkUbubXbspMRvQEqq3x5oOTfAYXd0ciPNxfktwTL0JB1xBMxITWMBYrcBLG
        1FC6LnVk+pW5hgXWyiEnnO9ZVqNJfcAa1KTUizN6W0xIFikLZyW4YJu+S0uSgcLEe5KUYwNz9QKOH
        yjo3p0X1W9cNj58tTt1WnOvd1d8uwyOPIjR68IbIgyM9Cxh2ncu3h1spaIz0WArnevv8WmC213+hB
        8/4BvdOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kexIx-0005X4-6i; Tue, 17 Nov 2020 09:29:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26D2D3019CE;
        Tue, 17 Nov 2020 10:29:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12D382012638E; Tue, 17 Nov 2020 10:29:36 +0100 (CET)
Date:   Tue, 17 Nov 2020 10:29:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117091545.GA31837@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117091545.GA31837@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:15:46AM +0000, Will Deacon wrote:
> On Tue, Nov 17, 2020 at 09:30:16AM +0100, Peter Zijlstra wrote:

> > Subject: sched: Fix data-race in wakeup
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Tue Nov 17 09:08:41 CET 2020
> > 
> > Mel reported that on some ARM64 platforms loadavg goes bananas and
> > tracked it down to the following data race:
> > 
> >   CPU0					CPU1
> > 
> >   schedule()
> >     prev->sched_contributes_to_load = X;
> >     deactivate_task(prev);
> > 
> > 					try_to_wake_up()
> > 					  if (p->on_rq &&) // false
> > 					  if (smp_load_acquire(&p->on_cpu) && // true
> > 					      ttwu_queue_wakelist())
> > 					        p->sched_remote_wakeup = Y;
> > 
> >     smp_store_release(prev->on_cpu, 0);
> 
> (nit: I suggested this race over at [1] ;)

Ah, I'll ammend and get you a Debugged-by line or something ;-)

> > where both p->sched_contributes_to_load and p->sched_remote_wakeup are
> > in the same word, and thus the stores X and Y race (and can clobber
> > one another's data).
> > 
> > Whereas prior to commit c6e7bd7afaeb ("sched/core: Optimize ttwu()
> > spinning on p->on_cpu") the p->on_cpu handoff serialized access to
> > p->sched_remote_wakeup (just as it still does with
> > p->sched_contributes_to_load) that commit broke that by calling
> > ttwu_queue_wakelist() with p->on_cpu != 0.
> > 
> > However, due to
> > 
> >   p->XXX			ttwu()
> >   schedule()			  if (p->on_rq && ...) // false
> >     smp_mb__after_spinlock()	  if (smp_load_acquire(&p->on_cpu) &&
> >     deactivate_task()		      ttwu_queue_wakelist())
> >       p->on_rq = 0;		        p->sched_remote_wakeup = X;
> > 
> > We can be sure any 'current' store is complete and 'current' is
> > guaranteed asleep. Therefore we can move p->sched_remote_wakeup into
> > the current flags word.
> > 
> > Note: while the observed failure was loadavg accounting gone wrong due
> > to ttwu() cobbering p->sched_contributes_to_load, the reverse problem
> > is also possible where schedule() clobbers p->sched_remote_wakeup,
> > this could result in enqueue_entity() wrecking ->vruntime and causing
> > scheduling artifacts.
> > 
> > Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
> > Reported-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/sched.h |   13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -775,7 +775,6 @@ struct task_struct {
> >  	unsigned			sched_reset_on_fork:1;
> >  	unsigned			sched_contributes_to_load:1;
> >  	unsigned			sched_migrated:1;
> > -	unsigned			sched_remote_wakeup:1;
> >  #ifdef CONFIG_PSI
> >  	unsigned			sched_psi_wake_requeue:1;
> >  #endif
> > @@ -785,6 +784,18 @@ struct task_struct {
> >  
> >  	/* Unserialized, strictly 'current' */
> >  
> > +	/*
> > +	 * p->in_iowait = 1;		ttwu()
> > +	 * schedule()			  if (p->on_rq && ..) // false
> > +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> > +	 *   deactivate_task()		      ttwu_queue_wakelist())
> > +	 *     p->on_rq = 0;			p->sched_remote_wakeup = X;
> > +	 *
> > +	 * Guarantees all stores of 'current' are visible before
> > +	 * ->sched_remote_wakeup gets used.
> 
> I'm still not sure this is particularly clear -- don't we want to highlight
> that the store of p->on_rq is unordered wrt the update to
> p->sched_contributes_to_load() in deactivate_task()?

I can explicitly call that out I suppose.

> I dislike bitfields with a passion, but the fix looks good:

I don't particularly hate them, they're just a flag field with names on
(in this case).

> Acked-by: Will Deacon <will@kernel.org>

Thanks!

> Now the million dollar question is why KCSAN hasn't run into this. Hrmph.

kernel/sched/Makefile:KCSAN_SANITIZE := n

might have something to do with that, I suppose.
