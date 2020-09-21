Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7309273356
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgIUT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:56:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44466 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgIUT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:56:53 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CEDD12D7;
        Mon, 21 Sep 2020 21:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600718211;
        bh=HaoTxYQD5e4vVzG+0N4ohrxKZQDQAmGxRMJB8zMf2Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPtQx2KGrvekqZfHIAJiKQKpl/oVW+2sVsWCRxDBJyE8pFJE1AXRe+LxO3ME+wj3Y
         RHl5ca8SFozzLHBxwxas3NcRHu6xpHFQ0yPgLflfNGuZpMalYQHnXEJAsxMU2DneTX
         AjN2WkZaVpgfzq+l73+iaQwFkWG9pEZdbv42GzdM=
Date:   Mon, 21 Sep 2020 22:56:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Fix compilation warning with
 !CONFIG_TASKS_RCU and CONFIG_TINY_RCU
Message-ID: <20200921195618.GB18343@pendragon.ideasonboard.com>
References: <20200823030405.22174-1-laurent.pinchart@ideasonboard.com>
 <20200825150222.GP2855@paulmck-ThinkPad-P72>
 <20200825152249.GF6767@pendragon.ideasonboard.com>
 <20200825161629.GS2855@paulmck-ThinkPad-P72>
 <20200917222641.GA589@pendragon.ideasonboard.com>
 <20200917232416.GR29330@paulmck-ThinkPad-P72>
 <20200921193718.GI29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921193718.GI29330@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:37:18PM -0700, Paul E. McKenney wrote:
> On Thu, Sep 17, 2020 at 04:24:16PM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 18, 2020 at 01:26:41AM +0300, Laurent Pinchart wrote:
> > > Hi Paul,
> > > 
> > > On Tue, Aug 25, 2020 at 09:16:29AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Aug 25, 2020 at 06:22:49PM +0300, Laurent Pinchart wrote:
> > > > > On Tue, Aug 25, 2020 at 08:02:22AM -0700, Paul E. McKenney wrote:
> > > > > > On Sun, Aug 23, 2020 at 06:04:05AM +0300, Laurent Pinchart wrote:
> > > > > > > Commit 8344496e8b49 ("rcu-tasks: Conditionally compile
> > > > > > > show_rcu_tasks_gp_kthreads()") introduced conditional compilation of
> > > > > > > several functions, but forgot one occurrence of
> > > > > > > show_rcu_tasks_classic_gp_kthread() that causes the compiler to warn of
> > > > > > > an unused static function. Fix it.
> > > > > > > 
> > > > > > > Fixes: 8344496e8b49 ("rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()")
> > > > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > > ---
> > > > > > >  kernel/rcu/tasks.h | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > > > index 835e2df8590a..bddf3968c1eb 100644
> > > > > > > --- a/kernel/rcu/tasks.h
> > > > > > > +++ b/kernel/rcu/tasks.h
> > > > > > > @@ -590,7 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
> > > > > > >  }
> > > > > > >  
> > > > > > >  #else /* #ifdef CONFIG_TASKS_RCU */
> > > > > > > +#ifndef CONFIG_TINY_RCU
> > > > > > >  static void show_rcu_tasks_classic_gp_kthread(void) { }
> > > > > > > +#endif /* #ifndef CONFIG_TINY_RCU */
> > > > > > >  void exit_tasks_rcu_start(void) { }
> > > > > > >  void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> > > > > > >  #endif /* #else #ifdef CONFIG_TASKS_RCU */
> > > > > > 
> > > > > > Good catch!!!
> > > > > > 
> > > > > > But does the following addition of "static inline" work for you?
> > > > > 
> > > > > They do. I initially added a static inline, and realized #ifdef was used
> > > > > extensively when trying to find the proper Fixes: tag, so I went for
> > > > > that. I don't mind either way, as long as this gets fixed :-)
> > > > 
> > > > This is admittedly an odd .h file, given that it is included but once.
> > > > 
> > > > I have applied the following patch with your Reported-by, cc-ing -stable
> > > > for v5.8 and later.
> > > 
> > > I don't see the fix in Linus' master branch. Given that 8344496e8b49 was
> > > introduced in v5.9-rc1, shouldn't this be treated as a regression and
> > > merged before Linus releases v5.9 ?
> > 
> > The current plan is that it goes in during the upcoming merge window,
> > a few weeks from now.  However, it sounds like you need it sooner.
> > I will try doing a pull request and see what happens.
> 
> And sent, CCing you.

Thank you :-)

> > > > > > ------------------------------------------------------------------------
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > > index 835e2df..3dc3ffc 100644
> > > > > > --- a/kernel/rcu/tasks.h
> > > > > > +++ b/kernel/rcu/tasks.h
> > > > > > @@ -590,9 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
> > > > > >  }
> > > > > >  
> > > > > >  #else /* #ifdef CONFIG_TASKS_RCU */
> > > > > > -static void show_rcu_tasks_classic_gp_kthread(void) { }
> > > > > > -void exit_tasks_rcu_start(void) { }
> > > > > > -void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> > > > > > +static inline void show_rcu_tasks_classic_gp_kthread(void) { }
> > > > > > +static inline void exit_tasks_rcu_start(void) { }
> > > > > > +static inline void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> > > > > >  #endif /* #else #ifdef CONFIG_TASKS_RCU */
> > > > > >  
> > > > > >  #ifdef CONFIG_TASKS_RUDE_RCU

-- 
Regards,

Laurent Pinchart
