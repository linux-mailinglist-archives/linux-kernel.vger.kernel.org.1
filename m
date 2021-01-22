Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C72FF957
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbhAVAU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbhAVAUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 208FC23A33;
        Fri, 22 Jan 2021 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611274813;
        bh=jGhsT/jSo19FT6n/PtkCpp/CjkK4SqYPsKIWbUU+L8o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lQLQuD31sVHhDQRTnz8EGfsQlTWdIm1Ozpf1+QuEJQR3Yv7zgdQwpWyfo4VOtjb9g
         qZZCNYQUXodE+jHtg+Gm+D859Ne6jzudqMnOGVVOAaWlKqQaXtIUkHqh/bLTzJsrIK
         Y/7OGL76udA5SsrvJImS1yVFVTHDK9v88C5ouiACg2RSBWC7dho5BwTFQfbH0tZdyh
         P5Z020P/q2Ugw3FM7H5ByaC1NfEK+Q86t/RdjdT03hrCewDA5ABU9EHlBLEQTofp2S
         jIx0yjik+PofAE0qqHHiMFxPQ41UeyV1psliSGU8mivwEEY//sh18rz4Z1jIHD44EY
         TwMk082WKd/qg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C824335226D8; Thu, 21 Jan 2021 16:20:12 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:20:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org,
        valentin.schneider@arm.com
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20210122002012.GB2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
 <20200527163543.GA706478@hirez.programming.kicks-ass.net>
 <20200527171236.GC706495@hirez.programming.kicks-ass.net>
 <YAmyVW1r0xQOwneB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAmyVW1r0xQOwneB@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:56:53PM +0100, Peter Zijlstra wrote:
> On Wed, May 27, 2020 at 07:12:36PM +0200, Peter Zijlstra wrote:
> > Subject: rcu: Allow for smp_call_function() running callbacks from idle
> > 
> > Current RCU hard relies on smp_call_function() callbacks running from
> > interrupt context. A pending optimization is going to break that, it
> > will allow idle CPUs to run the callbacks from the idle loop. This
> > avoids raising the IPI on the requesting CPU and avoids handling an
> > exception on the receiving CPU.
> > 
> > Change rcu_is_cpu_rrupt_from_idle() to also accept task context,
> > provided it is the idle task.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/rcu/tree.c   | 25 +++++++++++++++++++------
> >  kernel/sched/idle.c |  4 ++++
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d8e9dbbefcfa..c716eadc7617 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -418,16 +418,23 @@ void rcu_momentary_dyntick_idle(void)
> >  EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
> >  
> >  /**
> > - * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
> > + * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
> >   *
> >   * If the current CPU is idle and running at a first-level (not nested)
> > - * interrupt from idle, return true.  The caller must have at least
> > - * disabled preemption.
> > + * interrupt, or directly, from idle, return true.
> > + *
> > + * The caller must have at least disabled IRQs.
> >   */
> >  static int rcu_is_cpu_rrupt_from_idle(void)
> >  {
> > -	/* Called only from within the scheduling-clock interrupt */
> > -	lockdep_assert_in_irq();
> > +	long nesting;
> > +
> > +	/*
> > +	 * Usually called from the tick; but also used from smp_function_call()
> > +	 * for expedited grace periods. This latter can result in running from
> > +	 * the idle task, instead of an actual IPI.
> > +	 */
> > +	lockdep_assert_irqs_disabled();
> >  
> >  	/* Check for counter underflows */
> >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> > @@ -436,9 +443,15 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> >  
> >  	/* Are we at first interrupt nesting level? */
> > -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> > +	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> > +	if (nesting > 1)
> >  		return false;
> >  
> > +	/*
> > +	 * If we're not in an interrupt, we must be in the idle task!
> > +	 */
> > +	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> > +
> >  	/* Does CPU appear to be idle from an RCU standpoint? */
> >  	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> >  }
> 
> Let me revive this thread after yesterdays IRC conversation.
> 
> As said; it might be _extremely_ unlikely, but somewhat possible for us
> to send the IPI concurrent with hot-unplug, not yet observing
> rcutree_offline_cpu() or thereabout.
> 
> Then have the IPI 'delayed' enough to not happen until smpcfd_dying()
> and getting ran there.
> 
> This would then run the function from the stopper thread instead of the
> idle thread and trigger the warning, even though we're not holding
> rcu_read_lock() (which, IIRC, was the only constraint).
> 
> So would something like the below be acceptable?
> 
> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 368749008ae8..2c8d4c3e341e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -445,7 +445,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	/*
>  	 * Usually called from the tick; but also used from smp_function_call()
>  	 * for expedited grace periods. This latter can result in running from
> -	 * the idle task, instead of an actual IPI.
> +	 * a (usually the idle) task, instead of an actual IPI.

The story is growing enough hair that we should tell it only once.
So here just where it is called from:

	/*
	 * Usually called from the tick; but also used from smp_function_call()
	 * for expedited grace periods.
	 */

>  	lockdep_assert_irqs_disabled();
>  
> @@ -461,9 +461,14 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  		return false;
>  
>  	/*
> -	 * If we're not in an interrupt, we must be in the idle task!
> +	 * If we're not in an interrupt, we must be in task context.
> +	 *
> +	 * This will typically be the idle task through:
> +	 *   flush_smp_call_function_from_idle(),
> +	 *
> +	 * but can also be in CPU HotPlug through smpcfd_dying().
>  	 */

Good, but how about like this?

	/*
	 * If we are not in an interrupt handler, we must be in
	 * smp_call_function() handler.
	 *
	 * Normally, smp_call_function() handlers are invoked from
	 * the idle task via flush_smp_call_function_from_idle().
	 * However, they can also be invoked from CPU hotplug
	 * operations via smpcfd_dying().
	 */

> -	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> +	WARN_ON_ONCE(!nesting && !in_task(current));

This is used in time-critical contexts, so why not RCU_LOCKDEP_WARN()?
That should also allow checking more closely.  Would something like the
following work?

	RCU_LOCKDEP_WARN(!nesting && !is_idle_task(current) && (!in_task(current) || !lockdep_cpus_write_held()));

Where lockdep_cpus_write_held is defined in kernel/cpu.c:

void lockdep_cpus_write_held(void)
{
#ifdef CONFIG_PROVE_LOCKING
	if (system_state < SYSTEM_RUNNING)
		return false;
	return lockdep_is_held_type(&cpu_hotplug_lock, 0);
#else
	return false;
#endif
}

Seem reasonable?

							Thanx, Paul

>  	/* Does CPU appear to be idle from an RCU standpoint? */
>  	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
