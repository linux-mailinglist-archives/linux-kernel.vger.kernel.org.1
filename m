Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90C273CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIVIDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:03:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:45154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIVIDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:03:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600761787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FvWG7tC3kKNI3D6q7QNexOS+dy5AJm0QHRE89VaQpY=;
        b=rFPGEtfOB48pYzUWyAcKcwutF4tjK6MGFMST8WT/FaYU0Sy1hfpZz8F0ueMohfL1P8BnRe
        JTIFVi04+w/D3IEcEjQkflh09iEKuP5Zj5Fp3qxPLf6Qj16BIzDXDY3/PRczaE/8MzdrBZ
        1WTQZhMYbotweBatf5ALz2mgXgvY4AI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28398AF98;
        Tue, 22 Sep 2020 08:03:44 +0000 (UTC)
Date:   Tue, 22 Sep 2020 10:03:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200922080306.GV12990@dhcp22.suse.cz>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200922033553.GU29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922033553.GU29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 20:35:53, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 06:03:18PM +0200, Michal Hocko wrote:
> > On Mon 21-09-20 08:45:58, Paul E. McKenney wrote:
> > > On Mon, Sep 21, 2020 at 09:47:16AM +0200, Michal Hocko wrote:
> > > > On Fri 18-09-20 21:48:15, Uladzislau Rezki (Sony) wrote:
> > > > [...]
> > > > > Proposal
> > > > > ========
> > > > > Introduce a lock-free function that obtain a page from the per-cpu-lists
> > > > > on current CPU. It returns NULL rather than acquiring any non-raw spinlock.
> > > > 
> > > > I was not happy about this solution when we have discussed this
> > > > last time and I have to say I am still not happy. This is exposing
> > > > an internal allocator optimization and allows a hard to estimate
> > > > consumption of pcp free pages. IIUC this run on pcp cache can be
> > > > controled directly from userspace (close(open) loop IIRC) which makes it
> > > > even bigger no-no.
> > > 
> > > Yes, I do well remember that you are unhappy with this approach.
> > > Unfortunately, thus far, there is no solution that makes all developers
> > > happy.  You might be glad to hear that we are also looking into other
> > > solutions, each of which makes some other developers unhappy.  So we
> > > are at least not picking on you alone.  :-/
> > 
> > No worries I do not feel like a whipping boy here. But do expect me to
> > argue against the approach. I would also appreciate it if there was some
> > more information on other attempts, why they have failed. E.g. why
> > pre-allocation is not an option that works well enough in most
> > reasonable workloads. I would also appreciate some more thoughts why we
> > need to optimize for heavy abusers of RCU (like close(open) extremes).
> 
> Not optimizing for them, but rather defending against them.  Uladzislau
> gave the example of low-memory phones.  And we have quite the array
> of defenses against other userspace bugs including MMUs, the "limit"
> command, and so on.
> 
> There have been quite a few successful attempts, starting from the
> introduction of blimit and RCU-bh more than 15 years ago, continuing
> through making call_rcu() jump-start grace periods, IPIing reluctant
> CPUs, tuning RCU callback offloading, and many others.  But these prior
> approaches have only taken us so far.

Thank you this is useful. It gives me some idea about the problem but I
still cannot picture how serious the problem really is. Is this a DoS
like scenario where an unprivileged task is able to monopolize the
system/CPU to do all the RCU heavy lifting? Are other RCU users deprived
from doing their portion? How much expediting helps? Does it really
solve the problem or it merely shifts it around as you will have hard
time to keep up with more and more tasks to hit the same path and the
pre-allocated memory is a very finite resource.

> Other approaches under consideration include making CONFIG_PREEMPT_COUNT
> unconditional and thus allowing call_rcu() and kvfree_rcu() to determine
> whether direct calls to the allocator are safe (some guy named Linus
> doesn't like this one),

I assume that the primary argument is the overhead, right? Do you happen
to have any reference?

> preallocation (Uladzislau covered this, and
> the amount that would need to be preallocated is excessive), deferring
> allocation to RCU_SOFTIRQ (this would also need CONFIG_PREEMPT_COUNT),
> and deferring to some clean context (which is the best we can do within
> the confines of RCU, but which can have issues with delay).

I have already replied to that so let's not split the discussion into
several fronts.

> So it is not the need to address this general problem that is new.
> Far from it!  What is new is the need for changes outside of RCU.
> 
> > > > I strongly agree with Thomas http://lkml.kernel.org/r/87tux4kefm.fsf@nanos.tec.linutronix.de
> > > > that this optimization is not aiming at reasonable workloads. Really, go
> > > > with pre-allocated buffer and fallback to whatever slow path you have
> > > > already. Exposing more internals of the allocator is not going to do any
> > > > good for long term maintainability.
> > > 
> > > I suggest that you carefully re-read the thread following that email.
> > 
> > I clearly remember Thomas not being particularly happy that you optimize
> > for a corner case. I do not remember there being a consensus that this
> > is the right approach. There was some consensus that this is better than
> > a gfp flag. Still quite bad though if you ask me.
> 
> Again, this "optimization" is for robustness more than raw speed.
> 
> > > Given a choice between making users unhappy and making developers
> > > unhappy, I will side with the users each and every time.
> > 
> > Well, let me rephrase. It is not only about me (as a developer) being
> > unhappy but also all the side effects this would have for users when
> > performance of their favorite workload declines for no apparent reason
> > just because pcp caches are depleted by an unrelated process.
> 
> But in the close(open()) case, wouldn't the allocations on the open()
> side refill those caches?

Yes pcp lists will eventually get replenished. This is not a correctness
problem I am pointing out. It is the fact that any user of this new
interface can monopolize the _global_ pool which would affect all other
users of the pool.
-- 
Michal Hocko
SUSE Labs
