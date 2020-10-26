Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460F9298F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781673AbgJZOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781656AbgJZOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:37:33 -0400
Received: from localhost (bny93-h09-176-172-152-46.dsl.sta.abo.bbox.fr [176.172.152.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0012168B;
        Mon, 26 Oct 2020 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603723051;
        bh=qliYb5Jm4kq0Yk2JVt5lkmPGHuxX8X18w3Jd/VKdIR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXmTpqbCz5DteFwZJHXNkeAWK4XvEQ3A14Q0Sy/y3SadoN1V6vViwcRX4EwZIDhQZ
         71H3lCdaEqpAuEpfKi4fOuB8AmxoQsX9Botj3wOgwq4iwmdeAyWLksozu/48/Naark
         45RBhzMWk4atDqEOlMG5UuD+yfFq4VWGsg0VFeqg=
Date:   Mon, 26 Oct 2020 15:37:28 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 3/5] sched: Detect call to schedule from critical entry
 code
Message-ID: <20201026143728.GA120760@lothringen>
References: <20201005104919.5250-1-frederic@kernel.org>
 <20201005104919.5250-4-frederic@kernel.org>
 <20201005112353.GI2628@hirez.programming.kicks-ass.net>
 <20201005122648.GA1743@lothringen>
 <20201007093436.GG3165@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007093436.GG3165@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:34:36AM +0100, Mel Gorman wrote:
> On Mon, Oct 05, 2020 at 02:26:48PM +0200, Frederic Weisbecker wrote:
> > On Mon, Oct 05, 2020 at 01:23:53PM +0200, Peter Zijlstra wrote:
> > > On Mon, Oct 05, 2020 at 12:49:17PM +0200, Frederic Weisbecker wrote:
> > > > Detect calls to schedule() between user_enter() and user_exit(). Those
> > > > are symptoms of early entry code that either forgot to protect a call
> > > > to schedule() inside exception_enter()/exception_exit() or, in the case
> > > > of HAVE_CONTEXT_TRACKING_OFFSTACK, enabled interrupts or preemption in
> > > > a wrong spot.
> > > > 
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Phil Auld <pauld@redhat.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > ---
> > > >  kernel/sched/core.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 2d95dc3f4644..d31a79e073e3 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -4295,6 +4295,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> > > >  		preempt_count_set(PREEMPT_DISABLED);
> > > >  	}
> > > >  	rcu_sleep_check();
> > > > +	WARN_ON_ONCE(ct_state() == CONTEXT_USER);
> > > 
> > > 	SCHED_WARN_ON() ?
> > 
> > Bah! That's exactly what I was looking for.
> > 
> > > No point in unconditionally polluting that path. Although, per MeL, we
> > > should probably invest in CONFIG_SCHED_DEBUG_I_MEANS_IT :/
> > 
> > Because CONFIG_SCHED_DEBUG is often used by default on distros?
> > 
> 
> SCHED_DEBUG is generally useful (e.g. figuring out weird topology problems
> on new hardware). The overhead isn't too bad when schedstats are
> disabled so it would be nice to avoid adding too much overhead via
> SCHED_DEBUG.
> 
> Other debugging options -- not so much. A lot of them are useful for
> development but there are people who request them be enabled anyway
> thinking that they improve security somehow when in reality they might,
> at best, detect a hardware issue that happens to hit a specific structure.


So we are good with SCHED_WARN_ON(), right?

I'll reissue with that.

Thanks.
