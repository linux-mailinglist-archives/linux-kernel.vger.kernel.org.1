Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C888527D1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbgI2Oy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgI2Oy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:54:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DEF20757;
        Tue, 29 Sep 2020 14:54:25 +0000 (UTC)
Date:   Tue, 29 Sep 2020 10:54:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929105416.757c47f0@gandalf.local.home>
In-Reply-To: <20200929144105.GU29330@paulmck-ThinkPad-P72>
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
        <20200929103620.06762622@gandalf.local.home>
        <20200929144105.GU29330@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 07:41:06 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Sep 29, 2020 at 10:36:20AM -0400, Steven Rostedt wrote:
> > On Tue, 29 Sep 2020 13:33:40 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > Kim reported that perf-ftrace made his box unhappy. It turns out that
> > > commit:
> > > 
> > >   ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> > > 
> > > removed one too many notrace. Probably due to there not being a helpful
> > > comment.
> > > 
> > > Reinstate the notrace and add a comment to avoid loosing it again.
> > > 
> > > Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> > > Reported-by: Kim Phillips <kim.phillips@amd.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/rcu/tree.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ee5e595501e8..33020d84ec6b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1098,8 +1098,11 @@ noinstr bool __rcu_is_watching(void)
> > >   * CPU can safely enter RCU read-side critical sections.  In other words,
> > >   * if the current CPU is not in its idle loop or is in an interrupt or
> > >   * NMI handler, return true.
> > > + *
> > > + * Must be notrace because __ftrace_ops_list_func() / ftrace_ops_assist_func()
> > > + * will call this (for every function) outside of recursion protection.
> > >   */
> > > -bool rcu_is_watching(void)
> > > +notrace bool rcu_is_watching(void)
> > >  {
> > >  	bool ret;
> > >    
> > 
> > I think the patch I suggested is more suitable.  
> 
> OK, I will let you guys fight it out.  ;-)
> 

Well, I think we should actually apply both, but the comment needs to be
updated, as it will no longer be outside recursion. And the comment is
wrong now as well, as its only outside recursion protection for the
assist_func(). 

But it does prevent it from being always called for perf.

 * Make notrace because it can be called by the internal functions of
 * ftrace, and making this notrace removes unnecessary recursion calls.


-- Steve
