Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2E28C43F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgJLVoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbgJLVoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:44:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D2D20797;
        Mon, 12 Oct 2020 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602539046;
        bh=Avy5/yMPziqq52bPoFT2o2ztrkVvoYmmK2PZgwcTYPY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1Izch2gcW/kqmktKyzZ558qfo9Ypsirss9tk0yFbNvcjCX3zVBrnITT/e/ldPma+G
         3Ir9sE9OOPRhfpltWjMrGo2iZ04Fw12s+cLAsnhQ9lBXBCVLrDso+Sbh3rGrGygqgp
         RtSoAkgrcZ5pK2yJ6IKTlnd4CCbbrIMHL+nL8X3o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CD4CA35227C6; Mon, 12 Oct 2020 14:44:05 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:44:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
Message-ID: <20201012214405.GI3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201012141451.GA3425471@gmail.com>
 <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 01:25:09PM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 7:14 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest core/rcu git tree from:
> >
> > RCU changes for v5.10:
> >
> >  - Debugging for smp_call_function()
> >  - RT raw/non-raw lock ordering fixes
> >  - Strict grace periods for KASAN
> >  - New smp_call_function() torture test
> >  - Torture-test updates
> >  - Documentation updates
> >  - Miscellaneous fixes
> 
> I am *very* unhappy with this pull request.
> 
> It doesn't even mention the big removal of CONFIR_PREEMPT, that I felt
> was still under discussion.
> 
> I don't absolutely hate that code, and I'm willing to be convinced
> about how little it matter for people who don't want to have the
> counting overhead, but I refuse to pull it as some secret hidden thing
> that isn't even mentioned in the pull request.
> 
> Honestly, I did not get any strong arguments for why making the
> preempt count unconditional was such an important thing.
> 
> Yes, Thomas pointed me at a couple of uses that were garbage, but even
> the people involved in those seemed to agree they were legacy garbage.
> 
> So why was this preempt-count thing then pushed through like this?

So that RCU can tell, even in CONFIG_PREEMPT_NONE=y kernels, whether it
is safe to invoke the memory allocator.  RCU needs to figure this out
for -rt kernels and for the CONFIG_PROVE_RAW_LOCK_NESTING Kconfig option
that was recently added to lockdep.  And with this option, lockdep has
been triggering for kvfree_rcu() for awhile now.

We have tried a number of alternative fixes, but they have had subtle
problems.  Or, in the case of the alternative that uses a lockless
interface to the memory allocator, the not-so-subtle problem of strong
resistance from the maintainers.

In contrast, your earlier comments seemed to indicate that with a valid
use case, you would be OK with unconditional PREEMPT_COUNT, though
perhaps that was a case of excessive optimism on my part.  I based my
optimism in part on your not having complained about either the patch
series or the pull request, both of which I CCed you on:

https://lore.kernel.org/lkml/20200928233041.GA23230@paulmck-ThinkPad-P72
	Patch series.

https://lore.kernel.org/lkml/20201001210750.GA25287@paulmck-ThinkPad-P72
	Pull request.

Of course, if you hate this approach, we can go back to browbeating the
memory-allocator maintainers.  On the other hand, the approach used in
this pull request does work quite well and I do know that there are
people who were quite tired of the kvfree_rcu() lockdep complaints
starting quite some time ago.

But either way, please let me know how you would like us to proceed.

							Thanx, Paul
