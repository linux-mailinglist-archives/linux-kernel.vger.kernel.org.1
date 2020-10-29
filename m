Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C429F0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJ2QGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgJ2QGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:06:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF91C2076D;
        Thu, 29 Oct 2020 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603987594;
        bh=G3NhcyrxuUbde1V+HPUpiLH1/czAYGGB1IdZo3AQtk4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y54h0hVXTxq07bQlXLVpWGGmxy8p6pWIsIU7d2fFyceCI7TvmlKb+qezokurTXzFW
         juLMTP/S8oVCGaidmAADmMj3vmYjBGNOs+mmBNAE8ERVEAus9IMQ9BUCp6RbBL/GYN
         AW7o5M0Kkq/aowRchGvs9hXbUxhWQM4LWxItBy1U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 85EE03522778; Thu, 29 Oct 2020 09:06:33 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:06:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201029160633.GM3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
 <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
 <20201028201554.GE3249@paulmck-ThinkPad-P72>
 <20201029091534.GH2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029091534.GH2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:15:34AM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 01:15:54PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 28, 2020 at 09:02:43PM +0100, Peter Zijlstra wrote:
> > > -#ifdef CONFIG_IRQ_WORK
> > > +		raw_spin_lock_rcu_node(rnp);
> > 
> > The caller of rcu_implicit_dynticks_qs() already holds this lock.
> > Please see the force_qs_rnp() function and its second call site,
> > to which rcu_implicit_dynticks_qs() is passed as an argument.
> 
> Like this then.

This does look plausible!  But I am sure that rcutorture will also
have an opinion.  ;-)

							Thanx, Paul

> ---
> Subject: rcu/tree: Use irq_work_queue_remote()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Oct 28 11:53:40 CET 2020
> 
> The effect of an self-IPI here would be setting rcu_iw_gp_seq to the
> value we just set it to (pointless) and clearing rcu_iw_pending, which
> we just set, so don't set it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1204,6 +1204,8 @@ static int rcu_implicit_dynticks_qs(stru
>  	bool *ruqp;
>  	struct rcu_node *rnp = rdp->mynode;
>  
> +	raw_lockdep_assert_held_rcu_node(rnp);
> +
>  	/*
>  	 * If the CPU passed through or entered a dynticks idle phase with
>  	 * no active irq/NMI handlers, then we can safely pretend that the CPU
> @@ -1308,14 +1310,14 @@ static int rcu_implicit_dynticks_qs(stru
>  			resched_cpu(rdp->cpu);
>  			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
>  		}
> -#ifdef CONFIG_IRQ_WORK
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
>  	}
>  
>  	return 0;
