Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528A6294C94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442350AbgJUM2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:28:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440204AbgJUM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:28:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D94ADAC82;
        Wed, 21 Oct 2020 12:28:13 +0000 (UTC)
Date:   Wed, 21 Oct 2020 13:28:11 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021122811.GD32041@suse.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <alpine.DEB.2.22.394.2010211336410.8475@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2010211336410.8475@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> > I suspect that the benefit of this patch is due to avoiding the overhead
> > of wake_affine_weight() check because the following check exists in
> > select_idle_sibling
> 
> I'm running 160 threads on 160 cores (80 physical cores).  All of the
> threads are thus best off to just stay where they are.  If one thread
> moves to the socket of prev, then they will be displacing other threads
> that also expect to return to where they were previously located.
> 
> You can see this in the traces shown here:
> 
> https://pages.lip6.fr/Julia.Lawall/uas.pdf
> 

This is an important point -- almost all CPUs are commonly active and the
search for an idle CPU is going to be difficult given that it is inherently
race-prone. In this case, you're right, it may indeed be better off to just
leave the task where it is if the prev CPU is idle. Not only does it avoid
the wake_affine_weight cost, it avoids a useless search of idle siblings.

However, there is alsoo the important case where a machine is only
partially or lightly utilised. In that case, a cross-node migration
may be beneficial as the wakee may need to access data in the wakers
cache or memory local to the waker (no guarantee, the waker/wakee could
be completely independent but the scheduler cannot tell). In the low
utilisation case, select_idle_sibling is also likely to be less expensive.

Leaving a task on a remote node because the prev CPU was idle is an
important semantic change in the behaviour of the scheduler when there is
spare idle capacity in either domain. It's non-obvious from the changelog
and the patch itself that this change of behaviour happens.

> Prior to 5.8, my machine was using intel_pstate and had few background
> tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> the kernel decided that intel_cpufreq would be more appropriate, which
> introduced kworkers every 0.004 seconds on all cores.  In the graphs for
> early versions, sometimes the whole benchmark runs with the threads just
> staying on their cores, or a few migrations.  Starting with 5.8, after 5
> seconds where there are a number of synchronizations, all of the threads
> move around between all of the cores.  Typically, one bad placement leads
> to 10-15 threads moving around, until one ends up on the idle core where
> the original thread was intended to be.
> 

And this is an issue but I don't think the fix is avoiding cross-node
migrations entirely if the prev CPU happened to be idle because cache
lines will have to be bounced and/or remote data be accessed.  At minimum,
the low utilisation case should be considered and the changelog justify
why avoiding cross-node wakeups is still appropriate when the waker CPU
has plenty of idle CPUs.

> >
> >         /*
> >          * If the previous CPU is cache affine and idle, don't be stupid:
> >          */
> >         if (prev != target && cpus_share_cache(prev, target) &&
> >             (available_idle_cpu(prev) || sched_idle_cpu(prev)))
> >                 return prev;
> 
> This isn't triggered in the problematic case, because the problematic case
> is where the prev core and the waker core are on different sockets.
> 

I simply wanted to highlight the fact it checks whether caches are shared
or not as that is also taken into account in select_idle_sibling for
example.

> To my understanding, when the runnable load was used and prev was idle,
> wake_affine_weight would fail, and then wake_affine would return prev.
> With the load average, in the case where there is a thread on the waker
> core and there has recently been a daemon on the prev core, the comparison
> between the cores is a bit random.  The patch thus tries to restore the
> previous behavior.
> 

I think wake_affine_weight() is a bit random anyway simply because it picks
a CPU that select_idle_sibling ignores in a lot of cases and in others
simply stacks the wakee on top of the waker. Every so often I think that
it should simply be ripped out because the scheduler avoids stacking on
the wakeup paths unless there is no other choice in which case the task
might as well remain on prev anyway. Maybe it made more sense when there
was an effort to detect when task stacking is appropriate but right now,
wake_affine_weight() is basically a random migration generator -- leave
it to the load balancer to figure out placement decisions based on load.

-- 
Mel Gorman
SUSE Labs
