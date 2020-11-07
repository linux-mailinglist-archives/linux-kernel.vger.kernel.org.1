Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF92AA1E3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKGAsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKGAsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:48:16 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C928206D5;
        Sat,  7 Nov 2020 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604710095;
        bh=d7xWJLSjJ7RLOIXvdq/UTR+dudKnOid7xsqEvkWOWLQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HDoG9YKUhLpeKHRqqOhjSWipW6DZHmu/BqF1lo89S+3ZCK0Lz9WotB9pMTRd1eTvo
         gQyn6U1fYzHYOIy8R0MD5sljb+yskaaGzia2qCAWjn9UqASOQI4A6708ecTU5+r4fZ
         OFReChrjIlHEjyD9UYe9jAlfMymz85GUNsXyXjek=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1905B35225DD; Fri,  6 Nov 2020 16:48:15 -0800 (PST)
Date:   Fri, 6 Nov 2020 16:48:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 2/7] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201107004815.GD3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-3-joel@joelfernandes.org>
 <20201104170133.GI3249@paulmck-ThinkPad-P72>
 <20201107000157.GB1397669@google.com>
 <20201107001847.GD1397669@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107001847.GD1397669@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 07:18:47PM -0500, Joel Fernandes wrote:
> On Fri, Nov 06, 2020 at 07:01:57PM -0500, Joel Fernandes wrote:
> > On Wed, Nov 04, 2020 at 09:01:33AM -0800, Paul E. McKenney wrote:
> > 
> > > A casual reader might be forgiven for being confused by the combination
> > > of "Return" in the above comment and the "void" function type below.
> > > So shouldn't this comment be something like "Add the specified number
> > > of callbacks to the specified segment..."?
> > 
> > You are right, sorry and will fix it.
> > 
> > > > @@ -330,11 +342,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
> > > >  
> > > >  	if (!rcu_segcblist_pend_cbs(rsclp))
> > > >  		return; /* Nothing to do. */
> > > > +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> > > > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> > > > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
> > > 
> > > This should be a "for" loop.  Yes, the number and names of the segments
> > > hasn't changed for a good long time, but nothing like code as above to
> > > inspire Murphy to more mischief.  :-/
> > > 
> > > Actually, why not put the summation in the existing "for" loop below?
> > > That would save a line of code in addition to providing less inspiration
> > > for Mr. Murphy.
> > 
> > I can do that. Actually Frederic suggested the same thing but I was reluctant
> > as I felt it did not give much LOC benefit. Will revisit it.
> 
> It reduces 1 line of code :) I changed it to the below, will update the patch:

Thank you!  And yes, I am much more concerned about the constraints on
Mr. Murphy than on the lines of code.  ;-)

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 9b43d686b1f3..bff9b2253e50 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -101,7 +101,7 @@ static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long
>  	WRITE_ONCE(rsclp->seglen[seg], v);
>  }
>  
> -/* Return number of callbacks in a segment of the segmented callback list. */
> +/* Increase the numeric length of a segment by a specified amount. */
>  static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
>  {
>  	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
> @@ -406,13 +406,12 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_pend_cbs(rsclp))
>  		return; /* Nothing to do. */
> -	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> -		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> -		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
> +	rclp->len = 0;
>  	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
>  	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
>  	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
> +		rclp->len += rcu_segcblist_get_seglen(rsclp, i);
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
>  		rcu_segcblist_set_seglen(rsclp, i, 0);
>  	}
