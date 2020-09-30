Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB127F2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgI3Tw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Tw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:52:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1152620709;
        Wed, 30 Sep 2020 19:52:24 +0000 (UTC)
Date:   Wed, 30 Sep 2020 15:52:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20200930155222.6754ce6c@gandalf.local.home>
In-Reply-To: <20200930192242.GM2611@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
        <20200930181323.GF2628@hirez.programming.kicks-ass.net>
        <20200930151026.4a87ab79@gandalf.local.home>
        <20200930192242.GM2611@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 21:22:42 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 30, 2020 at 03:10:26PM -0400, Steven Rostedt wrote:
> > On Wed, 30 Sep 2020 20:13:23 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > >  diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h  
> > > > index 6a584b3e5c74..3e5bc1dd71c6 100644
> > > > --- a/include/linux/lockdep.h
> > > > +++ b/include/linux/lockdep.h
> > > > @@ -550,7 +550,8 @@ do {									\
> > > >  
> > > >  #define lockdep_assert_irqs_disabled()					\
> > > >  do {									\
> > > > -	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
> > > > +	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled) &&	\
> > > > +           likely(!(current->lockdep_recursion & LOCKDEP_RECURSION_MASK)));\
> > > >  } while (0)    
> > > 
> > > Blergh, IIRC there's header hell that way. The sane fix is killing off
> > > that trace_*_rcuidle() disease.  
> > 
> > Really?
> > 
> > I could run this through all my other tests to see if that is the case.
> > That is, to see if it stumbles across header hell.  
> 
> I went through a lot of pain to make that per-cpu to avoid using
> current. But that might've been driven by
> lockdep_assert_preemption_disabled(), which is used in seqlock.h which
> in turn is included all over the place.
> 
> That said, there's at least two things we can do:
> 
>  - make lockdep_recursion per-cpu too, IIRC we only ever set that when
>    we have IRQs disabled anyway.
> 
> OR
> 
>  - inspired by the above, as can save/clear - restore hardirqs_enabled
>    when we frob lockdep_recursion.
> 
> Admittedly, the second is somewhat gross :-)

I think making lockdep_recursion percpu sounds like the best approach.

-- Steve
