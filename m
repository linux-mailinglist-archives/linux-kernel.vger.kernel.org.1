Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C82285BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgJGJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:34:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgJGJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:34:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD5A1B19C;
        Wed,  7 Oct 2020 09:34:38 +0000 (UTC)
Date:   Wed, 7 Oct 2020 10:34:36 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 3/5] sched: Detect call to schedule from critical entry
 code
Message-ID: <20201007093436.GG3165@suse.de>
References: <20201005104919.5250-1-frederic@kernel.org>
 <20201005104919.5250-4-frederic@kernel.org>
 <20201005112353.GI2628@hirez.programming.kicks-ass.net>
 <20201005122648.GA1743@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201005122648.GA1743@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 02:26:48PM +0200, Frederic Weisbecker wrote:
> On Mon, Oct 05, 2020 at 01:23:53PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 05, 2020 at 12:49:17PM +0200, Frederic Weisbecker wrote:
> > > Detect calls to schedule() between user_enter() and user_exit(). Those
> > > are symptoms of early entry code that either forgot to protect a call
> > > to schedule() inside exception_enter()/exception_exit() or, in the case
> > > of HAVE_CONTEXT_TRACKING_OFFSTACK, enabled interrupts or preemption in
> > > a wrong spot.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Phil Auld <pauld@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  kernel/sched/core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 2d95dc3f4644..d31a79e073e3 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4295,6 +4295,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> > >  		preempt_count_set(PREEMPT_DISABLED);
> > >  	}
> > >  	rcu_sleep_check();
> > > +	WARN_ON_ONCE(ct_state() == CONTEXT_USER);
> > 
> > 	SCHED_WARN_ON() ?
> 
> Bah! That's exactly what I was looking for.
> 
> > No point in unconditionally polluting that path. Although, per MeL, we
> > should probably invest in CONFIG_SCHED_DEBUG_I_MEANS_IT :/
> 
> Because CONFIG_SCHED_DEBUG is often used by default on distros?
> 

SCHED_DEBUG is generally useful (e.g. figuring out weird topology problems
on new hardware). The overhead isn't too bad when schedstats are
disabled so it would be nice to avoid adding too much overhead via
SCHED_DEBUG.

Other debugging options -- not so much. A lot of them are useful for
development but there are people who request them be enabled anyway
thinking that they improve security somehow when in reality they might,
at best, detect a hardware issue that happens to hit a specific structure.

-- 
Mel Gorman
SUSE Labs
