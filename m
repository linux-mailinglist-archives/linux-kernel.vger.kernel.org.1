Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4528C577
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgJLXy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgJLXy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:54:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BCA2083E;
        Mon, 12 Oct 2020 23:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546867;
        bh=6V2sA36T8oOrhBQlvUgWtRGRL94SwtZzkxLJ97+1Mqg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l/Iiz4wRYy1xRUkMTJYY+mtTkdtXnf3iCMZQ7ccTrVN3/48LwYyBidVuVTkKnL8DU
         06NNFuLY0dWhN48GinFQQi8TLN+c0zfiFmB8P6Ivojsh/s5tfBNgPTO6tFo5Pc4Yhi
         2FEOg24oei6hHk4rJW4uQiLa2rBwInyxJjVOwUKI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1F2935229C4; Mon, 12 Oct 2020 16:54:26 -0700 (PDT)
Date:   Mon, 12 Oct 2020 16:54:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
Message-ID: <20201012235426.GJ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201012141451.GA3425471@gmail.com>
 <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
 <20201012214405.GI3249@paulmck-ThinkPad-P72>
 <CAHk-=wgYr6DHdK1p5RTa4yemf=6t86UtRnY4VhKjcvovBxO_hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYr6DHdK1p5RTa4yemf=6t86UtRnY4VhKjcvovBxO_hw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:59:41PM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 2:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > So that RCU can tell, even in CONFIG_PREEMPT_NONE=y kernels, whether it
> > is safe to invoke the memory allocator.
> 
> So in what situation is RCU called from random contexts that it can't even tell?

In CONFIG_PREEMPT_NONE=y kernels, RCU has no way to tell whether or
not its caller holds a raw spinlock, which some callers do.  And if its
caller holds a raw spinlock, then RCU cannot invoke the memory allocator
because the allocator acquires non-raw spinlocks, which in turn results
in lockdep splats.  Making CONFIG_PREEMPT_COUNT unconditional allows
RCU to make this determination.

Please note that RCU always provides a fallback for memory-allocation
failure, but such failure needs to be rare, at least in non-OOM
situations.

The alternatives to this approach are:

1.	Lockless memory allocation, which was provided by an earlier
	patch series.  Again, the relevant maintainers are not happy
	with this approach.

2.	Defer memory allocation to a clean environment.  However,
	even softirq handlers are not clean enough, so this approach
	incurs a full scheduling delay.  And this delay is incurred
	unconditionally in kernels built with CONFIG_PREEMPT_COUNT=n,
	even if the system has memory coming out of its ears, and even
	if RCU's caller happens to be a clean environment.

3.	A long and sad litany of subtly broken approaches.

> > But either way, please let me know how you would like us to proceed.
> 
> Well, AT A MINIMUM, the pull request should damn well have made it
> 1000% clear that this removes a case that has existed for decades, and
> that potentially makes a difference for small kernels in particular.

Got it, thank you.

> In fact, my personal config option - still to this day - is
> CONFIG_PREEMPT_VOLUNTARY and on the kernel I'm running,
> CONFIG_PREEMPT_COUNT isn't actually set.
> 
> Because honestly, the code generation of some core code looks better
> that way (in places where I've historically looked at things), and the
> latency arguments against it simply aren't relevant when you have 8
> cores or more.
> 
> So i don't think that "make preempt count unconditional" is some small
> meaningless detail.

Understood and agreed.  And to take your point one step further, not
just CONFIG_PREEMPT_VOLUNTARY but also CONFIG_PREEMPT_NONE is also in
extremely heavy use, including by my employer.

And understood on kernel text size.  Raw performance is a different story:
Even microbenchmarks didn't show statistically significant performance
change from CONFIG_PREEMPT_COUNT=n, and system-level benchmarks showed no
difference whatsoever.

So would it help if CONFIG_PREEMPT_COUNT=n became unconditional only for
CONFIG_SMP=y kernels?  RCU does have other options for CONFIG_SMP=n.  Or
do your small-kernel concerns extend beyond single-CPU microcontrollers?

> What is so magical about RCU allocating memory? I assume it's some
> debug case? Why does that debug case then have a
> 
>     select PREEMPT_COUNT
> 
> like is done for PROVE_LOCKING?

Sadly, no, it is not just a debug case.

This memory allocation enables a cache-locality optimization to
callback processing that reduces cache misses.  This optimization
is currently implemented only for kvfree_rcu(), where it reduces
callback-invocation-time cache misses by a factor of eight on typical
x86 systems, which produces decent system-level benefits.  So it would
be good to also apply this optimization to call_rcu().

> > I based my
> > optimism in part on your not having complained about either the patch
> > series or the pull request, both of which I CCed you on:
> 
> I had already raised my concerns when that patch series was posted by
> Thomas originally. I did not feel like I needed to re-raise them just
> because the series got reposted by somebody else.

OK, I did not know, but I do know it now!

							Thanx, Paul
