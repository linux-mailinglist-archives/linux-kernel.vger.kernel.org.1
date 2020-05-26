Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4D1DBD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETSnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgETSnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:43:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1BB2072C;
        Wed, 20 May 2020 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590000226;
        bh=owmd5u00J5EiVH2Bk/mE1PizXwMz7BYeJOqOkWe+ZV4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=StBvvx4lBl3cno5a4mqWpDoOstM5l0ZCDMY6G5r34semnxevm7xhNqhzoFtrEPcMu
         ydvPzGsJnRI0oNwJlKNR49Lz90gDD2ruiCbx5Z6s9q2k+ARwsupEKIUcxB9HTDpQlh
         vTNLSIQVTrnsvOHUxetEg7a+bqKt7BB38Ws79mng=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CA0273522A2B; Wed, 20 May 2020 11:43:45 -0700 (PDT)
Date:   Wed, 20 May 2020 11:43:45 -0700
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
Message-ID: <20200520184345.GU2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520120608.mwros5jurmidxxfv@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:06:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 12:24:07 [+0200], Peter Zijlstra wrote:
> > On Tue, May 19, 2020 at 10:19:07PM +0200, Sebastian Andrzej Siewior wrote:
> > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 0c71505f0e19c..8d2b5f75145d7 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/module.h>
> > >  #include <linux/srcu.h>
> > > +#include <linux/locallock.h>
> > >  
> > >  #include "rcu.h"
> > >  #include "rcu_segcblist.h"
> > > @@ -735,6 +736,7 @@ static void srcu_flip(struct srcu_struct *ssp)
> > >  	smp_mb(); /* D */  /* Pairs with C. */
> > >  }
> > >  
> > > +static DEFINE_LOCAL_LOCK(sda_lock);
> > >  /*
> > >   * If SRCU is likely idle, return true, otherwise return false.
> > >   *
> > > @@ -765,13 +767,13 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> > >  	unsigned long tlast;
> > >  
> > >  	/* If the local srcu_data structure has callbacks, not idle.  */
> > > -	local_irq_save(flags);
> > > +	local_lock_irqsave(sda_lock, flags);
> > >  	sdp = this_cpu_ptr(ssp->sda);
> > >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> > > -		local_irq_restore(flags);
> > > +		local_unlock_irqrestore(sda_lock, flags);
> > >  		return false; /* Callbacks already present, so not idle. */
> > >  	}
> > > -	local_irq_restore(flags);
> > > +	local_unlock_irqrestore(sda_lock, flags);
> > 
> > Would it perhaps make sense to stick the local_lock in struct srcu_data ?
> 
> In that case we would need something for pointer stability before the
> lock is acquired.
> I remember Paul looked at that patch a few years ago and he said that
> that disabling interrupts here is important and matches the other part
> instance where the interrupts are disabled. Looking at it now, it seems
> that there is just pointer stability but I can't tell if
> rcu_segcblist_pend_cbs() needs more than just this.

Yes, that CPU's rcu_segcblist structure does need mutual exclusion in
this case.  This is because rcu_segcblist_pend_cbs() looks not just
at the ->tails[] pointer, but also at the pointer referenced by the
->tails[] pointer.  This last pointer is in an rcu_head structure, and
not just any rcu_head structure, but one that is ready to be invoked.
So this callback could vanish into the freelist (or worse) at any time.
But callback invocation runs on the CPU that enqueued the callbacks
(as long as that CPU remains online, anyway), so disabling interrupts
suffices in mainline.

Now, we could have srcu_might_be_idle() instead acquire the sdp->lock
to protect the structure.

What would be really nice is a primitive that acquires such a per-CPU
lock and remains executing on that CPU, whether by the graces of
preempt_disable(), local_irq_save(), migrate_disable(), or what have you.

							Thanx, Paul
