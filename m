Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0752E2835C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgJEM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEM0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:26:51 -0400
Received: from localhost (unknown [94.238.213.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B91A2078D;
        Mon,  5 Oct 2020 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601900810;
        bh=cPWhv4qf92jldfjMFg9lqz8+5AvD07QXH8qqecG62qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sb/nXA9UVqkPCudYLEjw8X/s6LuxvCYZ7dfAeuMZT0vPNdM+ylP6Cu7iYb87yE8m+
         wWDy434mrD7A3YfMOVSocbOzt8jKzfEGUHiJpQaAjBlApxQufGxk2t+jvG6Yxwqmx5
         vZOZBuv8JG15MBMw5vhNE2XAoYPoQMoskSTj96tQ=
Date:   Mon, 5 Oct 2020 14:26:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 3/5] sched: Detect call to schedule from critical entry
 code
Message-ID: <20201005122648.GA1743@lothringen>
References: <20201005104919.5250-1-frederic@kernel.org>
 <20201005104919.5250-4-frederic@kernel.org>
 <20201005112353.GI2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005112353.GI2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 01:23:53PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 05, 2020 at 12:49:17PM +0200, Frederic Weisbecker wrote:
> > Detect calls to schedule() between user_enter() and user_exit(). Those
> > are symptoms of early entry code that either forgot to protect a call
> > to schedule() inside exception_enter()/exception_exit() or, in the case
> > of HAVE_CONTEXT_TRACKING_OFFSTACK, enabled interrupts or preemption in
> > a wrong spot.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Phil Auld <pauld@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/sched/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2d95dc3f4644..d31a79e073e3 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4295,6 +4295,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >  		preempt_count_set(PREEMPT_DISABLED);
> >  	}
> >  	rcu_sleep_check();
> > +	WARN_ON_ONCE(ct_state() == CONTEXT_USER);
> 
> 	SCHED_WARN_ON() ?

Bah! That's exactly what I was looking for.

> No point in unconditionally polluting that path. Although, per MeL, we
> should probably invest in CONFIG_SCHED_DEBUG_I_MEANS_IT :/

Because CONFIG_SCHED_DEBUG is often used by default on distros?

Thanks.
