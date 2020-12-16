Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A22DC687
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgLPSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:31:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgLPSbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:31:55 -0500
Date:   Wed, 16 Dec 2020 10:00:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608141647;
        bh=GNYL9cs0MRjSecx4KsDqQi2WqJmD7na1dTeQYG2Ly5w=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OcwmiC3+gsROGPbOrVd5EJHMkhuwJv+Qkj7glQJrwIUct/dPB+YQ11vf/peSkhmuC
         iBSZjzCs1gocdw9u2hYrkJlMxDK+vrykOmDSt7gKOqQwaDqeKRzlsavc7jPYKXIt4V
         98m27IPfNeUy4iQ6Vg2ilM9K9V4GJ12XZMLv9epQKCxWNZpKr8VyE0PgKSrO0yO3bQ
         9hGcBBIZThltffqllmInphyUjutXl6wg94TjQgtxlJ+QFflgei4Ed3ZJaN4t4zFGyJ
         X+3oYOxo1NsqoRnpeqsN4N2sYY3buaxL4BsXL+QtiRwd0suDifYmbRSwGTKvqgIgiC
         7HpZ5FA/qU/Aw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU stall leading to deadlock warning
Message-ID: <20201216180047.GA10686@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201216172939.ts72yy3ekalavlpm@e107158-lin.cambridge.arm.com>
 <20201216175442.GK2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216175442.GK2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:54:42AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 16, 2020 at 05:29:39PM +0000, Qais Yousef wrote:
> > Hi Paul
> > 
> > We hit the below splat a couple of days ago in our testing. Sadly I can't
> > reproduce it. And it was on android-mainline branch..
> > 
> > It's the deadlock message that bothers me. I can't see how we could have ended
> > there. We detect a stall and when trying to dump the stack LOCKDEP spits the
> > warning.
> > 
> > Maybe should take this report with a pinch of salt since it wasn't on mainline.
> > I just thought it might be something worth sharing in case you can actually
> > spot something obvious that I can't see. If I got more info or a reproducer
> > I will share them.
> > 
> > The failure was triggered twice on that day running 2 different tests.
> 
> This looks like the same problem that Mark Rutland's recent patch series
> was fixing.  Do you have this series applied?
> 
> lore.kernel.org/lkml/20201126123602.23454-1-mark.rutland@arm.com

I would not expect the patch below to help given what your RCU CPU stall
warning looks like, but just in case...

(Full disclosure: Peter fixed a bug of mine, filenames notwithstanding.)

							Thanx, Paul

------------------------------------------------------------------------

commit f355d19f94bf4361d641fb3dbb9ece0fbac766f8
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Aug 29 10:22:24 2020 -0700

    sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
    
    The try_invoke_on_locked_down_task() function currently requires
    that interrupts be enabled, but it is called with interrupts
    disabled from rcu_print_task_stall(), resulting in an "IRQs not
    enabled as expected" diagnostic.  This commit therefore updates
    try_invoke_on_locked_down_task() to use raw_spin_lock_irqsave() instead
    of raw_spin_lock_irq(), thus allowing use from either context.
    
    Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
    Link: https://lore.kernel.org/lkml/20200928075729.GC2611@hirez.programming.kicks-ass.net/
    Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b2d6898..4abf041 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2989,7 +2989,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 /**
  * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
- * @p: Process for which the function is to be invoked.
+ * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
@@ -3007,12 +3007,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3029,7 +3028,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
