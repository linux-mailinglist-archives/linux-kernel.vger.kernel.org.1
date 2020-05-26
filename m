Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F161D133E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 14:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbgEMMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 08:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgEMMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:52:25 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D787A206CC;
        Wed, 13 May 2020 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589374344;
        bh=ZbMkBfAzfkfcZdSiGoSeDeyC8mg7b0wfm9fi4XUsJTo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1fJdqOUhwUiPz2ME341FBZekwiSiUvdDMo8eK334wcEegLLZqF1UDoB5+FMdriPUB
         UH7tapmZe4sXvIauNPJelItrmoUmNF9YxsiqoGzMvLppARnAdtZgd94sT6LFxf4yBP
         TZQsfQMprL5MkexJHlI7je9nOvLEueZhC1cBcOfU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 62926352343E; Wed, 13 May 2020 05:52:24 -0700 (PDT)
Date:   Wed, 13 May 2020 05:52:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200513125224.GP2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200507170903.GR2869@paulmck-ThinkPad-P72>
 <20200507183102.GB155220@cmpxchg.org>
 <20200507190905.GX2869@paulmck-ThinkPad-P72>
 <6d93affb-6505-1bf3-58a0-c67c34a18a9e@yandex-team.ru>
 <20200508144638.GF2869@paulmck-ThinkPad-P72>
 <8671cc58-11e0-b9f0-74b1-264fea58b23c@yandex-team.ru>
 <20200509160900.GM2869@paulmck-ThinkPad-P72>
 <20200513013238.GM2005@dread.disaster.area>
 <20200513031826.GN2869@paulmck-ThinkPad-P72>
 <1705751d-0be0-1f7f-116b-e5aea44e8efb@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705751d-0be0-1f7f-116b-e5aea44e8efb@yandex-team.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:35:25AM +0300, Konstantin Khlebnikov wrote:
> On 13/05/2020 06.18, Paul E. McKenney wrote:
> > On Wed, May 13, 2020 at 11:32:38AM +1000, Dave Chinner wrote:
> > > On Sat, May 09, 2020 at 09:09:00AM -0700, Paul E. McKenney wrote:
> > > > On Sat, May 09, 2020 at 11:54:40AM +0300, Konstantin Khlebnikov wrote:
> > > > > On 08/05/2020 17.46, Paul E. McKenney wrote:
> > > > > > Easy for me to provide "start fast and inefficient mode" and "stop fast
> > > > > > and inefficient mode" APIs for MM to call!
> > > > > > 
> > > > > > How about rcu_mempressure_start() and rcu_mempressure_end()?  I would
> > > > > > expect them not to nest (as in if you need them to nest, please let
> > > > > > me know).  I would not expect these to be invoked all that often (as in
> > > > > > if you do need them to be fast and scalable, please let me know). >
> > > > > > RCU would then be in fast/inefficient mode if either MM told it to be
> > > > > > or if RCU had detected callback overload on at least one CPU.
> > > > > > 
> > > > > > Seem reasonable?
> > > > > 
> > > > > Not exactly nested calls, but kswapd threads are per numa node.
> > > > > So, at some level nodes under pressure must be counted.
> > > > 
> > > > Easy enough, especially given that RCU already "counts" CPUs having
> > > > excessive numbers of callbacks.  But assuming that the transitions to/from
> > > > OOM are rare, I would start by just counting them with a global counter.
> > > > If the counter is non-zero, RCU is in fast and inefficient mode.
> > > > 
> > > > > Also forcing rcu calls only for cpus in one numa node might be useful.
> > > > 
> > > > Interesting.  RCU currently evaluates a given CPU by comparing the
> > > > number of callbacks against a fixed cutoff that can be set at boot using
> > > > rcutree.qhimark, which defaults to 10,000.  When this cutoff is exceeded,
> > > > RCU becomes more aggressive about invoking callbacks on that CPU, for
> > > > example, by sacrificing some degree of real-time response.  I believe
> > > > that this heuristic would also serve the OOM use case well.
> > > 
> > > So one of the things that I'm not sure people have connected here is
> > > that memory reclaim done by shrinkers is one of the things that
> > > drives huge numbers of call_rcu() callbacks to free memory via rcu.
> > > If we are reclaiming dentries and inodes, then we can be pushing
> > > thousands to hundreds of thousands of objects into kfree_rcu()
> > > and/or direct call_rcu() calls to free these objects in a single
> > > reclaim pass.
> > 
> > Good point!
> 
> Indeed
> 
> > 
> > > Hence the trigger for RCU going into "excessive callback" mode
> > > might, in fact, be kswapd running a pass over the shrinkers. i.e.
> > > memory reclaim itself can be responsible for pushing RCU into this "OOM
> > > pressure" situation.
> > > 
> > > So perhaps we've missed a trick here by not having the memory
> > > reclaim routines trigger RCU callbacks at the end of a priority
> > > scan. The shrinkers have queued the objects for freeing, but they
> > > haven't actually been freed yet and so things like slab pages
> > > haven't actually been returned to the free pool even though the
> > > shrinkers have said "freed this many objects"...
> > > 
> > > i.e. perhaps the right solution here is a "rcu_run_callbacks()"
> > > function that memory reclaim calls before backing off and/or winding
> > > up reclaim priority.
> > 
> > It would not be hard to make something that put RCU into fast/inefficient
> > mode for a couple of grace periods.  I will also look into the possibility
> > of speeding up callback invocation.
> > 
> > It might also make sense to put RCU grace periods into fast mode while
> > running the shrinkers that are freeing dentries and inodes.  However,
> > kbuild test robot reports ugly regressions when putting RCU into
> > fast/inefficient mode to quickly and too often.  As in 78.5% degradation
> > on one of the benchmarks.
> 
> I think fast/inefficient mode here just an optimization for freeing
> memory faster. It doesn't solve the problem itself.
> 
> At first we have to close the loop in reclaimer and actually wait or run
> rcu callbacks which might free memory before increasing priority and
> invoking OOM killer.

That is easy, just invoke rcu_barrier(), which will block until all
prior call_rcu()/kfree_rcu() callbacks have been invoked.

> > > > > I wonder if direct-reclaim should at some stage simply wait for RCU QS.
> > > > > I.e. call rcu_barrier() or similar somewhere before invoking OOM.
> > > > 
> > > > The rcu_oom_count() function in the patch starting this thread returns the
> > > > total number of outstanding callbacks queued on all CPUs.  So one approach
> > > > would be to invoke this function, and if the return value was truly
> > > > huge (taking size of memory and who knows that all else into account),
> > > > do the rcu_barrier() to wait for RCU to clear its current backlog.
> > > 
> > > The shrinker scan control structure has a node mask in it to
> > > indicate what node (and hence CPUs) it should be reclaiming from.
> > > This information comes from the main reclaim scan routine, so it
> > > would be trivial to feed straight into the RCU code to have it
> > > act on just the CPUs/node that we are reclaiming memory from...
> > 
> > For the callbacks, RCU can operate on CPUs, in theory anyway.  The
> > grace period itself, however, is inherently global.
> > 
> > > > On the NUMA point, it would be dead easy for me to supply a function
> > > > that returned the number of callbacks on a given CPU, which would allow
> > > > you to similarly evaluate a NUMA node, a cgroup, or whatever.
> > > 
> > > I'd think it runs the other way around - we optimisitically call the
> > > RCU layer to do cleanup, and the RCU layer decides if there's enough
> > > queued callbacks on the cpus/node to run callbacks immediately. It
> > > would even be provided with the scan priority to indicate the level
> > > of desperation memory reclaim is under....
> > 
> > Easy for RCU to count the number of callbacks.  That said, it has no
> > idea which callbacks are which.  Perhaps kfree_rcu() could gather that
> > information from the slab allocator, though.
> 
> It's simple to mark slab shrinkers that frees object through RCU and
> count freed objects in reclaimer:
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -536,6 +536,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>         else
>                 new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> 
> +       if (shrinker->flags & SHRINKER_KFREE_RCU)
> +               shrinkctl->nr_kfree_rcu += freed;
> +
>         trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
>         return freed;
>  }
> 
> And when accumulated enough do some synchronization.
> 
> Probably it's better to sum freed objects at per-cpu variable,
> and accumulate size rather than count.

RCU currently has no notion of size outside of possibly kfree_rcu(),
so that would be new information to RCU.

							Thanx, Paul

> > > > > All GFP_NOFAIL users should allow direct-reclaim, thus this loop
> > > > > in page_alloc shouldn't block RCU and doesn't need special care.
> > > > 
> > > > I must defer to you guys on this.  The main caution is the duration of
> > > > direct reclaim.  After all, if it is too long, the kfree_rcu() instance
> > > > would have been better of just invoking synchronize_rcu().
> > > 
> > > Individual callers of kfree_rcu() have no idea of the load on RCU,
> > > nor how long direct reclaim is taking. Calling synchronize_rcu()
> > > incorrectly has pretty major downsides to it, so nobody should be
> > > trying to expedite kfree_rcu() unless there is a good reason to do
> > > so (e.g. at unmount to ensure everything allocated by a filesystem
> > > has actually been freed). Hence I'd much prefer the decision to
> > > expedite callbacks is made by the RCU subsystem based on it's known
> > > callback load and some indication of how close memory reclaim is to
> > > declaring OOM...
> > 
> > Sorry, I was unclear.  There is a new single-argument kfree_rcu() under
> > way that does not require an rcu_head in the structure being freed.
> > However, in this case, kfree_rcu() might either allocate the memory
> > that is needed to track the memory to be freed on the one hand or just
> > invoke synchronize_rcu() on the other.  So this decision would be taken
> > inside kfree_rcu(), and not be visible to either core RCU or the caller
> > of kfree_rcu().
> > 
> > This decision is made based on whether or not the allocator provides
> > kfree_rcu() the memory needed.  The tradeoff is what GFP flags are
> > supplied.  So the question kfree_rcu() has to answer is "Would it be
> > better to give myself to reclaim as an additional task, or would it
> > instead be better to just invoke synchronize_rcu() and then immediately
> > free()?"
> > 
> > I am probably still unclear, but hopefully at least one step in the
> > right direction.
> > 
> > 							Thanx, Paul
> > 
