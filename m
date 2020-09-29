Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39D27D3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgI2Q4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgI2Q4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:56:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2761C208B8;
        Tue, 29 Sep 2020 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601398601;
        bh=gEzCaMn5tSZSPBLZ7kMG+DMBiSLkCwAHal0wNfaaiB0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TBmJvy45vJvyRyPgCkPCWs1xJFG2fmDy1IpJjrXrfEOWf2iRs+24UyZMYjPr5fOdc
         N9Fu3Hqs8cyn01kugPzQcpCnDM0CPhO8UwAA5kN6WPG8d9ib2uHoIwTBqcMTbneMCT
         83IOHG+btiTpnBSCgvZesvVGGMhSRSRkzEubiaIo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7A0213522C1A; Tue, 29 Sep 2020 09:56:40 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:56:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929165640.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
 <20200929103620.06762622@gandalf.local.home>
 <20200929144105.GU29330@paulmck-ThinkPad-P72>
 <20200929105416.757c47f0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929105416.757c47f0@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:54:16AM -0400, Steven Rostedt wrote:
> On Tue, 29 Sep 2020 07:41:06 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Tue, Sep 29, 2020 at 10:36:20AM -0400, Steven Rostedt wrote:
> > > On Tue, 29 Sep 2020 13:33:40 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > Kim reported that perf-ftrace made his box unhappy. It turns out that
> > > > commit:
> > > > 
> > > >   ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> > > > 
> > > > removed one too many notrace. Probably due to there not being a helpful
> > > > comment.
> > > > 
> > > > Reinstate the notrace and add a comment to avoid loosing it again.
> > > > 
> > > > Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> > > > Reported-by: Kim Phillips <kim.phillips@amd.com>
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index ee5e595501e8..33020d84ec6b 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1098,8 +1098,11 @@ noinstr bool __rcu_is_watching(void)
> > > >   * CPU can safely enter RCU read-side critical sections.  In other words,
> > > >   * if the current CPU is not in its idle loop or is in an interrupt or
> > > >   * NMI handler, return true.
> > > > + *
> > > > + * Must be notrace because __ftrace_ops_list_func() / ftrace_ops_assist_func()
> > > > + * will call this (for every function) outside of recursion protection.
> > > >   */
> > > > -bool rcu_is_watching(void)
> > > > +notrace bool rcu_is_watching(void)
> > > >  {
> > > >  	bool ret;
> > > >    
> > > 
> > > I think the patch I suggested is more suitable.  
> > 
> > OK, I will let you guys fight it out.  ;-)
> > 
> 
> Well, I think we should actually apply both, but the comment needs to be
> updated, as it will no longer be outside recursion. And the comment is
> wrong now as well, as its only outside recursion protection for the
> assist_func(). 
> 
> But it does prevent it from being always called for perf.
> 
>  * Make notrace because it can be called by the internal functions of
>  * ftrace, and making this notrace removes unnecessary recursion calls.

Fair enough.  ;-)

If I don't hear otherwise by late today (Tuesday), Pacific Time, I will
update the comment and pull it into -rcu.  If you guys have some other
route to mainline in mind, you have my Reviewed-by.  Either way, just
let me know.

							Thanx, Paul
