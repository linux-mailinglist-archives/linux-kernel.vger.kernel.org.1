Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43B2DC5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgLPSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:11:31 -0500
Received: from foss.arm.com ([217.140.110.172]:39200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgLPSLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:11:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB6E31B;
        Wed, 16 Dec 2020 10:10:45 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7699D3F66B;
        Wed, 16 Dec 2020 10:10:44 -0800 (PST)
Date:   Wed, 16 Dec 2020 18:10:42 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU stall leading to deadlock warning
Message-ID: <20201216181042.wif34g5l5unbcm2q@e107158-lin.cambridge.arm.com>
References: <20201216172939.ts72yy3ekalavlpm@e107158-lin.cambridge.arm.com>
 <20201216175442.GK2657@paulmck-ThinkPad-P72>
 <20201216180047.GA10686@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201216180047.GA10686@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/20 10:00, Paul E. McKenney wrote:
> On Wed, Dec 16, 2020 at 09:54:42AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 16, 2020 at 05:29:39PM +0000, Qais Yousef wrote:
> > > Hi Paul
> > > 
> > > We hit the below splat a couple of days ago in our testing. Sadly I can't
> > > reproduce it. And it was on android-mainline branch..
> > > 
> > > It's the deadlock message that bothers me. I can't see how we could have ended
> > > there. We detect a stall and when trying to dump the stack LOCKDEP spits the
> > > warning.
> > > 
> > > Maybe should take this report with a pinch of salt since it wasn't on mainline.
> > > I just thought it might be something worth sharing in case you can actually
> > > spot something obvious that I can't see. If I got more info or a reproducer
> > > I will share them.
> > > 
> > > The failure was triggered twice on that day running 2 different tests.
> > 
> > This looks like the same problem that Mark Rutland's recent patch series
> > was fixing.  Do you have this series applied?
> > 
> > lore.kernel.org/lkml/20201126123602.23454-1-mark.rutland@arm.com

Oh yeah I remember this one. Yes it could be relevant. I don't see the series
in the tree. If it wasn't merged (which AFAICS it isn't), it won't appear
there.

> I would not expect the patch below to help given what your RCU CPU stall
> warning looks like, but just in case...

Thanks. If I manage to find a reproducer I will give it a go. Still no luck in
triggering it in my test env :(

Thanks

--
Qais Yousef

> 
> (Full disclosure: Peter fixed a bug of mine, filenames notwithstanding.)
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit f355d19f94bf4361d641fb3dbb9ece0fbac766f8
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Sat Aug 29 10:22:24 2020 -0700
> 
>     sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
>     
>     The try_invoke_on_locked_down_task() function currently requires
>     that interrupts be enabled, but it is called with interrupts
>     disabled from rcu_print_task_stall(), resulting in an "IRQs not
>     enabled as expected" diagnostic.  This commit therefore updates
>     try_invoke_on_locked_down_task() to use raw_spin_lock_irqsave() instead
>     of raw_spin_lock_irq(), thus allowing use from either context.
>     
>     Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
>     Link: https://lore.kernel.org/lkml/20200928075729.GC2611@hirez.programming.kicks-ass.net/
>     Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
>     Signed-off-by: Peter Zijlstra <peterz@infradead.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b2d6898..4abf041 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2989,7 +2989,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  
>  /**
>   * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
> - * @p: Process for which the function is to be invoked.
> + * @p: Process for which the function is to be invoked, can be @current.
>   * @func: Function to invoke.
>   * @arg: Argument to function.
>   *
> @@ -3007,12 +3007,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   */
>  bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
>  {
> -	bool ret = false;
>  	struct rq_flags rf;
> +	bool ret = false;
>  	struct rq *rq;
>  
> -	lockdep_assert_irqs_enabled();
> -	raw_spin_lock_irq(&p->pi_lock);
> +	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	if (p->on_rq) {
>  		rq = __task_rq_lock(p, &rf);
>  		if (task_rq(p) == rq)
> @@ -3029,7 +3028,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
>  				ret = func(p, arg);
>  		}
>  	}
> -	raw_spin_unlock_irq(&p->pi_lock);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  	return ret;
>  }
>  
