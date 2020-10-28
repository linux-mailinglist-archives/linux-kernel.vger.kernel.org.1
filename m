Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F75529D91D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbgJ1Wod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389159AbgJ1WmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38EB247D4;
        Wed, 28 Oct 2020 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603916154;
        bh=yeuEHlayFmSooOIM4atMOm1X/2p7fFSFU1uBRzszkkg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hBUc6JcB0RsnYdPRgf4DTu6DEOetHuj7XfmsvGJ5Y5OUK7ACi488NbzzbGwCJKfEh
         rACnq/LMvlJDZzYy5pw4lyC10IPU2EJN6dS3KsOoIWgMZ6LhyXtMSCMbkR4jEsVQ2i
         i1oP/+mOgS6AIuGCAbj+Lrv/ubdHHHWYtXiR8dvw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 469A835225B2; Wed, 28 Oct 2020 13:15:54 -0700 (PDT)
Date:   Wed, 28 Oct 2020 13:15:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201028201554.GE3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
 <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 09:02:43PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 03:54:28PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 28, 2020 at 12:07:13PM +0100, Peter Zijlstra wrote:
> > > AFAICT we only need/use irq_work_queue_on() on remote CPUs, since we
> > > can directly access local state.  So avoid the IRQ_WORK dependency and
> > > use the unconditionally available irq_work_queue_remote().
> > > 
> > > This survives a number of TREE01 runs.
> > 
> > OK, Paul mentioned on IRC that while it is extremely unlikely, this code
> > does not indeed guarantee it will not try to IPI self.
> > 
> > I'll try again.
> 
> This is the best I could come up with.. :/
> 
> ---
> Subject: rcu/tree: Use irq_work_queue_remote()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Oct 28 11:53:40 CET 2020
> 
> All sites that consume rcu_iw_gp_seq seem to have rcu_node lock held,
> so setting it probably should too. Also the effect of self-IPI here
> would be setting rcu_iw_gp_seq to the value we just set it to
> (pointless) and clearing rcu_iw_pending, which we just set, so don't
> set it.
> 
> Passes TREE01.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1308,14 +1308,16 @@ static int rcu_implicit_dynticks_qs(stru
>  			resched_cpu(rdp->cpu);
>  			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
>  		}
> -#ifdef CONFIG_IRQ_WORK
> +		raw_spin_lock_rcu_node(rnp);

The caller of rcu_implicit_dynticks_qs() already holds this lock.
Please see the force_qs_rnp() function and its second call site,
to which rcu_implicit_dynticks_qs() is passed as an argument.

But other than that, this does look plausible.  And getting rid of
that #ifdef is worth something.  ;-)

							Thanx, Paul

>  		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
>  		    (rnp->ffmask & rdp->grpmask)) {
> -			rdp->rcu_iw_pending = true;
>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> -			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> +			if (likely(rdp->cpu != smp_processor_id())) {
> +				rdp->rcu_iw_pending = true;
> +				irq_work_queue_remote(rdp->cpu, &rdp->rcu_iw);
> +			}
>  		}
> -#endif
> +		raw_spin_unlock_rcu_node(rnp);
>  	}
>  
>  	return 0;
