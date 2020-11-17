Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F5E2B5CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKQKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgKQKg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:36:28 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00F4223C7;
        Tue, 17 Nov 2020 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605609387;
        bh=gZaiJIRNLJTPM7wL507aXVpZaly9y7V7PkaeLC69J6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoVhIyYm4EnEMnk5qXn6L0Rw/qRCDYcrO4inuFB8vpHDuDtD32HzE4xLprJiX38ZX
         eTgEbktWBRW8UHk0lKtUX3meCoQXqACQSpPlt7k1lnMZDZAjHcTqYliy6uaZKhvdBX
         EWcRfzv5zikih5dCRAmowXJYbK6A+sRr/dY3G8RE=
Date:   Tue, 17 Nov 2020 10:36:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201117103622.GA32035@willie-the-truck>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117091545.GA31837@willie-the-truck>
 <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
 <20201117094621.GE3121429@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117094621.GE3121429@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:46:21AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 10:29:36AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 09:15:46AM +0000, Will Deacon wrote:
> > > On Tue, Nov 17, 2020 at 09:30:16AM +0100, Peter Zijlstra wrote:
> > > >  	/* Unserialized, strictly 'current' */
> > > >  
> > > > +	/*
> > > > +	 * p->in_iowait = 1;		ttwu()
> > > > +	 * schedule()			  if (p->on_rq && ..) // false
> > > > +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> > > > +	 *   deactivate_task()		      ttwu_queue_wakelist())
> > > > +	 *     p->on_rq = 0;			p->sched_remote_wakeup = X;
> > > > +	 *
> > > > +	 * Guarantees all stores of 'current' are visible before
> > > > +	 * ->sched_remote_wakeup gets used.
> > > 
> > > I'm still not sure this is particularly clear -- don't we want to highlight
> > > that the store of p->on_rq is unordered wrt the update to
> > > p->sched_contributes_to_load() in deactivate_task()?
> 
> How's this then? It still doesn't explicitly call out the specific race,
> but does mention the more fundamental issue that wakelist queueing
> doesn't respect the regular rules anymore.
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
> @@ -785,6 +784,21 @@ struct task_struct {
>  
>  	/* Unserialized, strictly 'current' */
>  
> +	/*
> +	 * This field must not be in the scheduler word above due to wakelist
> +	 * queueing no longer being serialized by p->on_cpu. However:
> +	 *
> +	 * p->XXX = X;			ttwu()
> +	 * schedule()			  if (p->on_rq && ..) // false
> +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> +	 *   deactivate_task()		      ttwu_queue_wakelist())
> +	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
> +	 *
> +	 * guarantees all stores of 'current' are visible before
> +	 * ->sched_remote_wakeup gets used, so it can be in this word.
> +	 */
> +	unsigned			sched_remote_wakeup:1;

Much better, thanks!

Will
