Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50591DEE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgEVRjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 13:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbgEVRjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:39:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127B120723;
        Fri, 22 May 2020 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590169194;
        bh=pCggLUgtLHk37QLP1KiU/AqxsIhlvs8CogkTmNBsVVE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H3EM+BYnJl8KhSvLVpvUEMEmvdqhZT8pAPiYSZBgIV+NabmD6XguadVfGdAtJRiUC
         dRdTrWFBOYI1kO9Lvr4+PQ+OMBX5fUsoucJ7QyY96anD1D2VNjjhHK7/ZcZen8uvqZ
         G4wlCzgdd+ABfW4dLwFEDOkPiCXWojviYRk83DDk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E67EE3522E41; Fri, 22 May 2020 10:39:53 -0700 (PDT)
Date:   Fri, 22 May 2020 10:39:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200522173953.GI2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520184345.GU2869@paulmck-ThinkPad-P72>
 <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522151255.rtqnuk2cl3dpruou@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 05:12:55PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 11:43:45 [-0700], Paul E. McKenney wrote:
> > 
> > Yes, that CPU's rcu_segcblist structure does need mutual exclusion in
> > this case.  This is because rcu_segcblist_pend_cbs() looks not just
> > at the ->tails[] pointer, but also at the pointer referenced by the
> > ->tails[] pointer.  This last pointer is in an rcu_head structure, and
> > not just any rcu_head structure, but one that is ready to be invoked.
> > So this callback could vanish into the freelist (or worse) at any time.
> > But callback invocation runs on the CPU that enqueued the callbacks
> > (as long as that CPU remains online, anyway), so disabling interrupts
> > suffices in mainline.
> > 
> > Now, we could have srcu_might_be_idle() instead acquire the sdp->lock
> > to protect the structure.
> 
> Joel suggested that.

Good!

> > What would be really nice is a primitive that acquires such a per-CPU
> > lock and remains executing on that CPU, whether by the graces of
> > preempt_disable(), local_irq_save(), migrate_disable(), or what have you.
> 
> It depends on what is required. migrate_disable() would limit you to
> executing one CPU but would allow preemption. You would need a lock to
> ensure exclusive access to the data structure. preempt_disable() /
> local_irq_save() guarantee more than that.
> 
> Looking at the two call-sites there is no damage there is a CPU
> migration after obtaining the per-CPU pointer. There could be a
> CPU-migration before and after the pointer has been obtained so the code
> before and after this function can not make any assumptions.
> 
> Would something like this work: ?

It looks good to me, but I have not yet tested it.  (Happy to let you
take the first crack at rcutorture in any case, scenarios SRCU-P and
SRCU-N.)

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -764,14 +764,15 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>  	unsigned long t;
>  	unsigned long tlast;
>  
> +	check_init_srcu_struct(ssp);
>  	/* If the local srcu_data structure has callbacks, not idle.  */
> -	local_irq_save(flags);
> -	sdp = this_cpu_ptr(ssp->sda);
> +	sdp = raw_cpu_ptr(ssp->sda);
> +	spin_lock_irqsave_rcu_node(sdp, flags);
>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> -		local_irq_restore(flags);
> +		spin_unlock_irqrestore_rcu_node(sdp, flags);
>  		return false; /* Callbacks already present, so not idle. */
>  	}
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore_rcu_node(sdp, flags);
>  
>  	/*
>  	 * No local callbacks, so probabalistically probe global state.
> @@ -851,9 +852,8 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>  	}
>  	rhp->func = func;
>  	idx = srcu_read_lock(ssp);
> -	local_irq_save(flags);
> -	sdp = this_cpu_ptr(ssp->sda);
> -	spin_lock_rcu_node(sdp);
> +	sdp = raw_cpu_ptr(ssp->sda);
> +	spin_lock_irqsave_rcu_node(sdp, flags);
>  	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>  	rcu_segcblist_advance(&sdp->srcu_cblist,
>  			      rcu_seq_current(&ssp->srcu_gp_seq));
> 
> 
> That check_init_srcu_struct() is needed, because otherwise:
> 
> | BUG: spinlock bad magic on CPU#2, swapper/0/1
> |  lock: 0xffff88803ed28ac0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> | CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc6+ #81
> | Call Trace:
> |  dump_stack+0x71/0xa0
> |  do_raw_spin_lock+0x6c/0xb0
> |  _raw_spin_lock_irqsave+0x33/0x40
> |  synchronize_srcu+0x24/0xc9
> |  wakeup_source_remove+0x4d/0x70
> |  wakeup_source_unregister.part.0+0x9/0x40
> |  device_wakeup_enable+0x99/0xc0
> 
> I'm not sure if there should be an explicit init of `wakeup_srcu' or if
> an srcu function (like call_srcu()) is supposed to do it.

It is fine.  Beforehand, that check_init_srcu_struct() would have been
invoked very shortly thereafter from __call_srcu(), and there is no
instead harm invoking it a few microseconds earlier.  ;-)

 							Thanx, Paul
