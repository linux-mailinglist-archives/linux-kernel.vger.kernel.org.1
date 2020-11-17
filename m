Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31912B5B97
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKQJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKQJPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:15:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9952C2417E;
        Tue, 17 Nov 2020 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605604550;
        bh=U+FYpbgrS49KuCOaHirSy6jXNIfRFAzW9rFOhILS5KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATn4XYy1NEKvOCvE0M0Asx1ReNHEc/aBqBdkRXRDuGScqCbsS+fWt51TiulICPfL/
         Hs8z/fVGlQUBqMSRmZry70txOGjOKH6wyJeO4fhd/11Jac4CRejULLhO+ZyXwOCA/F
         l8LSaNO/Eh/i6oM633/NSI4qxgvDOfLcc3iVkDcA=
Date:   Tue, 17 Nov 2020 09:15:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201117091545.GA31837@willie-the-truck>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:30:16AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 07:31:49PM +0000, Mel Gorman wrote:
> 
> > And this works.
> 
> Yay!
> 
> > sched_psi_wake_requeue can probably stay with the other three fields
> > given they are under the rq lock but sched_remote_wakeup needs to move
> > out.
> 
> I _think_ we can move the bit into the unserialized section below.
> 
> It's a bit cheecky, but it should work I think because the only time we
> actually use this bit, we're guaranteed the task isn't actually running,
> so current doesn't exist.
> 
> I suppose the question is wether this is worth saving 31 bits over...
> 
> How's this?
> 
> ---
> Subject: sched: Fix data-race in wakeup
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Nov 17 09:08:41 CET 2020
> 
> Mel reported that on some ARM64 platforms loadavg goes bananas and
> tracked it down to the following data race:
> 
>   CPU0					CPU1
> 
>   schedule()
>     prev->sched_contributes_to_load = X;
>     deactivate_task(prev);
> 
> 					try_to_wake_up()
> 					  if (p->on_rq &&) // false
> 					  if (smp_load_acquire(&p->on_cpu) && // true
> 					      ttwu_queue_wakelist())
> 					        p->sched_remote_wakeup = Y;
> 
>     smp_store_release(prev->on_cpu, 0);

(nit: I suggested this race over at [1] ;)

> where both p->sched_contributes_to_load and p->sched_remote_wakeup are
> in the same word, and thus the stores X and Y race (and can clobber
> one another's data).
> 
> Whereas prior to commit c6e7bd7afaeb ("sched/core: Optimize ttwu()
> spinning on p->on_cpu") the p->on_cpu handoff serialized access to
> p->sched_remote_wakeup (just as it still does with
> p->sched_contributes_to_load) that commit broke that by calling
> ttwu_queue_wakelist() with p->on_cpu != 0.
> 
> However, due to
> 
>   p->XXX			ttwu()
>   schedule()			  if (p->on_rq && ...) // false
>     smp_mb__after_spinlock()	  if (smp_load_acquire(&p->on_cpu) &&
>     deactivate_task()		      ttwu_queue_wakelist())
>       p->on_rq = 0;		        p->sched_remote_wakeup = X;
> 
> We can be sure any 'current' store is complete and 'current' is
> guaranteed asleep. Therefore we can move p->sched_remote_wakeup into
> the current flags word.
> 
> Note: while the observed failure was loadavg accounting gone wrong due
> to ttwu() cobbering p->sched_contributes_to_load, the reverse problem
> is also possible where schedule() clobbers p->sched_remote_wakeup,
> this could result in enqueue_entity() wrecking ->vruntime and causing
> scheduling artifacts.
> 
> Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -775,7 +775,6 @@ struct task_struct {
>  	unsigned			sched_reset_on_fork:1;
>  	unsigned			sched_contributes_to_load:1;
>  	unsigned			sched_migrated:1;
> -	unsigned			sched_remote_wakeup:1;
>  #ifdef CONFIG_PSI
>  	unsigned			sched_psi_wake_requeue:1;
>  #endif
> @@ -785,6 +784,18 @@ struct task_struct {
>  
>  	/* Unserialized, strictly 'current' */
>  
> +	/*
> +	 * p->in_iowait = 1;		ttwu()
> +	 * schedule()			  if (p->on_rq && ..) // false
> +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> +	 *   deactivate_task()		      ttwu_queue_wakelist())
> +	 *     p->on_rq = 0;			p->sched_remote_wakeup = X;
> +	 *
> +	 * Guarantees all stores of 'current' are visible before
> +	 * ->sched_remote_wakeup gets used.

I'm still not sure this is particularly clear -- don't we want to highlight
that the store of p->on_rq is unordered wrt the update to
p->sched_contributes_to_load() in deactivate_task()?

I dislike bitfields with a passion, but the fix looks good:

Acked-by: Will Deacon <will@kernel.org>

Now the million dollar question is why KCSAN hasn't run into this. Hrmph.

Will

[1] https://lore.kernel.org/r/20201116131102.GA29992@willie-the-truck
