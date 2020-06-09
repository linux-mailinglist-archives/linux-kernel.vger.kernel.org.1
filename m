Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D645C1F4448
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbgFISCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 14:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbgFISC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:02:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472BC206D5;
        Tue,  9 Jun 2020 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725747;
        bh=3RKSAtWMH1lyWLRWFOOdp8K9w7gNBF2vUUFMIouVOIs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ebn5d4w7NWA678saEwBWdYf0fk2O/G8nw61u81Wr35USF5iJ1RzfbT2kT5BfGaCu1
         VsYwITJ8GHL4sV/uN6tpAg7swZjW4cmYOwyTTxMr8bT2A6588oxxL4vL1rlvoOexTu
         94cOggrOei9OneTWFq4upvxNCPRETbnYcIudMURc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2D1A835229D0; Tue,  9 Jun 2020 11:02:27 -0700 (PDT)
Date:   Tue, 9 Jun 2020 11:02:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200609180227.GR4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200604114121.GA26398@lenoir>
 <20200604163655.GC29598@paulmck-ThinkPad-P72>
 <20200608125715.GA30920@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125715.GA30920@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 02:57:17PM +0200, Frederic Weisbecker wrote:
> On Thu, Jun 04, 2020 at 09:36:55AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 04, 2020 at 01:41:22PM +0200, Frederic Weisbecker wrote:
> > > On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> > > > On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > Thank you for looking this over, Joel!
> > > > 
> > > > Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> > > > right thing", even when things are changing?  If it is feasible, that
> > > > would prevent any number of "interesting" copy-pasta and "just now became
> > > > common code" bugs down the road.
> > > 
> > > This won't be pretty:
> > > 
> > >     locked = rcu_nocb_lock();
> > >     rcu_nocb_unlock(locked);
> > 
> > I was thinking in terms of a bit in the rcu_data structure into
> > which rcu_nocb_lock() and friends stored the status, and from which
> > rcu_nocb_unlock() and friends retrieved that same status.  Sort of like
> > how preemptible RCU uses the ->rcu_read_lock_nesting field in task_struct.
> > 
> > As noted, this does require reworking the hotplug code to avoid the
> > current holding of two such locks concurrently, which I am happy to do
> > if that helps.
> > 
> > Or am I missing a subtle (or not-so-subtle) twist here?
> 
> So, during a CPU round, the nocb-gp kthread locks the corresponding rdp-nocb
> and then ignores if it is not offloaded. Surely there is a smarter ways to do
> that though. Well that's something we'll need to optimize at some point anyway.
> 
> Also we must then make sure that the nocb timers won't ever fire while we
> switch to offloaded state or they may fiddle with internals without locking
> nocb.

Understood, the synchronization requirements during the switchover will
be tricky.  But that will be the case no matter how we set it up.
If possible, it would be good if that trickiness could be concentrated
rather than spread far and wide.

> > > And anyway we still want to unconditionally lock on many places,
> > > regardless of the offloaded state. I don't know how we could have
> > > a magic helper do the unconditional lock on some places and the
> > > conditional on others.
> > 
> > I was assuming (perhaps incorrectly) that an intermediate phase between
> > not-offloaded and offloaded would take care of all of those cases.
> 
> Perhaps partly but I fear that won't be enough.

One approach is to rely on RCU read-side critical sections surrounding
the lock acquisition and to stay in the intermediate phase until a grace
period completes, preferably call_rcu() instead of synchronize_rcu().

This of course means refusing to do a transition if the CPU is still
in the intermediate state from a prior transition.

> > > Also the point of turning the lock helpers into primitives is to make
> > > it clearer as to where we really need unconditional locking and where
> > > we allow it to be conditional. A gift to reviewers :-)
> > 
> > Unless and until someone does a copy-pasta, thus unconditionally
> > doing the wrong thing.  ;-)
> 
> Yeah but the cost is more complicated code and synchronization to
> maintain the use of those all-in-one locking APIs everywhere. And
> current state is already not that simple :-)
> 
> Perhaps we should rename rcu_nocb_lock() into rcu_nocb_lock_cond() to
> prevent from accidents?

We do need something to avoid accidents.  ;-)

> Also I've been thinking that rcu_nocb_lock() should meet any of these
> requirements:
> 
> * hotplug is locked
> * rcu barrier is locked
> * rnp is locked
> 
> Because checking the offloaded state (when nocb isn't locked yet) of
> an rdp without any of the above locks held is racy. And that should
> be easy to check and prevent from copy-pasta accidents.
> 
> What do you think?

An RCU read-side critical section might be simpler.

							Thanx, Paul
