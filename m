Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFE2D30D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgLHRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgLHRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:20:08 -0500
Date:   Tue, 8 Dec 2020 09:19:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607447967;
        bh=KEimt0jcwW+P/vbPqY4292QrZle3hU8qS7paJWgJKuk=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HYP+Xfm6SXDsQtMMoXliQqf+SlXz+ccfFjoFXl8ZNSAv0UCXMRtmG6fBS/klyOvqN
         Sl+4n1AFwToONSjyGahm/Pb5FVv2CI2iVEMZU76uDedqIwOvJ/jC2uGu8D6hjgMEQK
         aCnPCnY8sL77eHu6Odlduku/2eSUROfRO5FLqo64WCLBT1/bztr51/HDzpM+5fMMsF
         CdqZyXAAv4HqBYep4Zt3WNH7w01hiVSd+6Na0v8Nr9FKyaZNtxtzoKG5dKlvwAx23j
         0jlTJ94HQvANhNpL/YrwARp7FrOn79Bt/0gsajgZ6K5WdsrJQN0/3qR+Oh8UJQmNkL
         GZ3jYL+l41VRQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201208171927.GS2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201208145810.GA4875@paulmck-ThinkPad-P72>
 <20201208155457.GA3916@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208155457.GA3916@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 04:54:57PM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 08, 2020 at 06:58:10AM -0800, Paul E. McKenney wrote:
> > Hello, Frederic,
> > 
> > Boqun just asked if RCU callbacks ran in BH-disabled context to avoid
> > concurrent execution of the same callback.  Of course, this raises the
> > question of whether a self-posting callback can have two instances of
> > itself running concurrently while a CPU is in the process of transitioning
> > between softirq and rcuo invocation of callbacks.
> > 
> > I believe that the answer is "no" because BH-disabled context is
> > an implicit RCU read-side critical section.  Therefore, the initial
> > invocation of the RCU callback must complete in order for a new grace
> > period to complete, and a new grace period must complete before the
> > second invocation of that same callback to start.
> > 
> > Does that make sense, or am I missing something?
> 
> Sounds like a good explanation. But then why are we actually calling
> the entire rcu_do_batch() under BH-disabled context? Was it to quieten
> lockdep against rcu_callback_map ?

Inertia and lack of complaints about it.  ;-)

Plus when called from softirq, neither local_bh_disable() nor
rcu_read_lock() is necessary, and so represents pointless overhead.

> Wouldn't rcu_read_lock() around callbacks invocation be enough? Or is
> there another reason for the BH-disabled context that I'm missing?

There are likely to be callback functions that use spin_lock() instead
of spin_lock_bh() because they know that they are invoked in BH-disabled
context.

But what does this change help?

							Thanx, Paul

> Untested below:
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bd04b09b84b3..207eff8a4e1a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2468,6 +2468,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  
>  		debug_rcu_head_unqueue(rhp);
>  
> +		rcu_read_lock();
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_callback(rcu_state.name, rhp);
>  
> @@ -2476,6 +2477,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		f(rhp);
>  
>  		rcu_lock_release(&rcu_callback_map);
> +		rcu_read_unlock();
>  
>  		/*
>  		 * Stop only if limit reached and CPU has something to do.
> @@ -2494,11 +2496,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		}
>  		if (offloaded) {
>  			WARN_ON_ONCE(in_serving_softirq());
> -			local_bh_enable();
>  			lockdep_assert_irqs_enabled();
>  			cond_resched_tasks_rcu_qs();
>  			lockdep_assert_irqs_enabled();
> -			local_bh_disable();
>  		}
>  	}
>  
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index fd8a52e9a887..2a3d3c59d650 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2095,9 +2095,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  	local_irq_save(flags);
>  	rcu_momentary_dyntick_idle();
>  	local_irq_restore(flags);
> -	local_bh_disable();
>  	rcu_do_batch(rdp);
> -	local_bh_enable();
>  	lockdep_assert_irqs_enabled();
>  	rcu_nocb_lock_irqsave(rdp, flags);
>  	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> 
