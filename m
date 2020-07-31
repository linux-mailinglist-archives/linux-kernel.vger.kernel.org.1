Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6CE233CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 03:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgGaBep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 21:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgGaBep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:34:45 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390842076B;
        Fri, 31 Jul 2020 01:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596159284;
        bh=Ln8RgoD9LBDCVjUQZUfivLSz29Krd2/xbBE+CCZmDHw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EKf2aA8wtUVYth+jA4ZL5IJdYbx7I2mgKPCYEU1YiNzRKpZq+yhgZ2t9n4fVePNCS
         wl5ULXxkkJHyZiqh8gUZbRLU6oZZo88XoIq2i3dqN7+XKG3ytzPHSCErFE9QlvHA1j
         SOqirVawGbEa17bxyleID8Fqc1nHDAQNuvVy8N3E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A4243521361; Thu, 30 Jul 2020 18:34:44 -0700 (PDT)
Date:   Thu, 30 Jul 2020 18:34:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting
 quiescent states
Message-ID: <20200731013443.GG9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730030221.705255-2-joel@joelfernandes.org>
 <CAEXW_YSbad9Cium_9f1eA1RfZ2Me9JcX2S-KMe-jRQo8W6AaBg@mail.gmail.com>
 <20200730163520.GA9247@paulmck-ThinkPad-P72>
 <20200731012152.GC2336096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731012152.GC2336096@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:21:52PM -0400, Joel Fernandes wrote:
> On Thu, Jul 30, 2020 at 09:35:20AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 29, 2020 at 11:25:19PM -0400, Joel Fernandes wrote:
> > > On Wed, Jul 29, 2020 at 11:02 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > At least since v4.19, the FQS loop no longer reports quiescent states
> > > 
> > > I meant here, "FQS loop no longer reports quiescent states for offline CPUs."
> > > 
> > > Sorry,
> > 
> > You did have me going there for a bit.  ;-)
> > 
> > No period (".") at the end though, unless you fix up the following
> > to start a new sentence.
> 
> Ok.
> 
> > > > unless it is a dire situation where an offlined CPU failed to report
> > > > a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
> > > > to keep the comment current.
> > 
> > How about the following for this last sentence?
> > 
> > "This commit therefore fixes the comment in rcu_gp_init() to match
> > the current code."
> 
> As per:
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> 
> It says:
> Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
> of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
> if you are giving orders to the codebase to change its behaviour.
> 
> May be I should make it "Fix the comment in rcu_gp_init() to match the
> current code"?

What submitting-patches.rst is objecting to is starting the commit
log with "This patch...".  I am suggesting something quite different,
namely providing a clear indication of the transition from problem
statement to solution.

> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 1e51962b565b..929568ff5989 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
> > > >
> > > >         /*
> > > >          * Apply per-leaf buffered online and offline operations to the
> > > > -        * rcu_node tree.  Note that this new grace period need not wait
> > > > -        * for subsequent online CPUs, and that quiescent-state forcing
> > > > +        * rcu_node tree.  Note that this new grace period need not wait for
> > > > +        * subsequent online CPUs, and that RCU hooks in CPU offlining path
> > > >          * will handle subsequent offline CPUs.
> > 
> > How about something like this?
> > 
> > 	...  Note that this new grace period ned not wait for subsequent
> > 	online CPUs, and that RCU hooks in the CPU offlining path, when
> > 	combined with checks in this function, will handle CPUs that
> > 	are currently going offline and that go offline later.
> 
> Sounds good to me. I think s/and that go/or that go/ though.

Good point!  Another approach would be s/and that/and those that/
but yours works.

> I will make these changes and send v3, let me know though if you object.

Sounds good!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 						Thanx, Paul
> > 
> > > >          */
> > > >         rcu_state.gp_state = RCU_GP_ONOFF;
> > > > --
> > > > 2.28.0.rc0.142.g3c755180ce-goog
> > > >
