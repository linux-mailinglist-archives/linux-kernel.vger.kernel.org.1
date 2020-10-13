Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1028C744
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgJMCrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgJMCrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:47:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D716421D7F;
        Tue, 13 Oct 2020 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602556902;
        bh=LQiPOpY968vM15ws6eatLn5hkMoc6C69BAyptP8yb3s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WJfKJAakgAD7qjFI7I8d62+38dQW/gR39Oyw6pqDzFE53FhoKsmUCSBRe90Jac+65
         ueYxxyOXZybO0c9hRkwD2mzsyekqicomiCZkaJ3QCTTGddOyuRxFwPeVwEWxY1i6N6
         pYLvroZxwpBga1g3+1vSai6CI9au7JSEOt5Da1C8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 980AA35229C4; Mon, 12 Oct 2020 19:41:42 -0700 (PDT)
Date:   Mon, 12 Oct 2020 19:41:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
Message-ID: <20201013024142.GK3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201012141451.GA3425471@gmail.com>
 <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
 <20201012214405.GI3249@paulmck-ThinkPad-P72>
 <CAHk-=wgYr6DHdK1p5RTa4yemf=6t86UtRnY4VhKjcvovBxO_hw@mail.gmail.com>
 <20201012235426.GJ3249@paulmck-ThinkPad-P72>
 <CAHk-=whQDWhcH6jTJuS_OFpdnuh9mMHt7x7hJ5OocLVfgfKEqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whQDWhcH6jTJuS_OFpdnuh9mMHt7x7hJ5OocLVfgfKEqA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:14:42PM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 4:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > In CONFIG_PREEMPT_NONE=y kernels, RCU has no way to tell whether or
> > not its caller holds a raw spinlock, which some callers do.
> 
> Only kfree_rcu()? (And apparently eventually call_rcu())?

Yes.  The other RCU APIs either only use raw spinlocks themselves on
the one hand or must be called from schedulable contexts on the other.

> And since we have lockdep, and it warns about it, and raw spinlocks
> are really really rare, do we really need to then disable this simple
> optimization for everybody else?
> 
> We have been very successful with "don't do that then" rules.
> 
> Eg, you cannot do normal memory allocations inside a spinlock (or you
> have to mark them with GFP_ATOMIC, and not all allocations can be
> marked as such), and this has been the case basically forever. And we
> have debug code and tools that will check that.
> 
> Why is it impossible to just say "you can't do kfree_rcu() while
> holding a raw spinlock"?
> 
> Particularly for something like kfree_rcu() and particularly if it's
> just about raw spinlocks, it would seem to be very natural to just say
> "just delay freeing it until after you've released the raw spinlock".
> 
> Because I sure hope that you don't find raw spinlock users in random
> places. It should be stuff like core scheduling, RCU itself, etc.

True enough, but core stuff does use RCU, some of it while holding
raw spinlocks.

And you are right that "just don't do that, defer it instead" is often
very effective.  In fact, I defer wakeups within RCU in order to avoid
deadlocks with the scheduler.  It is simple in concept, and it does
work, but it is also a disproportionate source of bugs.  Most of which
rcutorture finds in the safety and comfort of my own system, thankfully,
but some do escape.  Maybe I am overreacting, but I have been burned
often enough that I feel the need to avoid this.

Plus I did oversimplify.  CONFIG_PREEMPT_COUNT also allows the call_rcu()
portion to avoid deadlocks with the current non-lockless memory allocator.

So if the answer from you on global CONFIG_PREEMPT_COUNT=y and from
the MM guys on lockless allocation is irrevocably "@#$@#$ NO!" or the
current-day bowdlerized equivalent, I will take the scheduling delays
in the shorts and defer allocation.

> > Making CONFIG_PREEMPT_COUNT unconditional allows
> > RCU to make this determination.
> 
> I understand _that_ part, but the thing I find objectionable is how a
> small piece of code seems to want to change the rules we have had in
> the kernel since basically day #1.
> 
> (Ok, so the preempt count itself is much more recent than "day #1",
> but the basic non-counting spinlocks do go back to very early in the
> SMP stages).

Understood, a count-free CONFIG_PREEMPT_NONE has been in place in the
Linux kernel for an extremely long time.  And I also understand that
adding CONFIG_PREEMPT_COUNT=y everywhere is a pervasive change that is
not to be taken lightly.

							Thanx, Paul
