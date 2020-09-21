Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6174D2732F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIUThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:37:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9333A2193E;
        Mon, 21 Sep 2020 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600717038;
        bh=q6xAbhp5lYhc9fHGIo85JYl03Y3OpqUWULIOogMAYOE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KLPGrJStFS7lM17yDAvVX9b308Q2YR6uyH3NWRAroUuFuboX9cqHo4NGOlmdk1oWn
         Us04uv96KGrNj1tTp4OQsgyUEoTCHc/mzpJ5W4u89VZaDN9ZT0UghGAy4EWOX3Q57b
         1xBB2s2sUqsTErZi0QeC7AKnCzv+LaIXaTxjGLos=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 664F8352303A; Mon, 21 Sep 2020 12:37:18 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:37:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Fix compilation warning with
 !CONFIG_TASKS_RCU and CONFIG_TINY_RCU
Message-ID: <20200921193718.GI29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200823030405.22174-1-laurent.pinchart@ideasonboard.com>
 <20200825150222.GP2855@paulmck-ThinkPad-P72>
 <20200825152249.GF6767@pendragon.ideasonboard.com>
 <20200825161629.GS2855@paulmck-ThinkPad-P72>
 <20200917222641.GA589@pendragon.ideasonboard.com>
 <20200917232416.GR29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917232416.GR29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:24:16PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 18, 2020 at 01:26:41AM +0300, Laurent Pinchart wrote:
> > Hi Paul,
> > 
> > On Tue, Aug 25, 2020 at 09:16:29AM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 25, 2020 at 06:22:49PM +0300, Laurent Pinchart wrote:
> > > > On Tue, Aug 25, 2020 at 08:02:22AM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Aug 23, 2020 at 06:04:05AM +0300, Laurent Pinchart wrote:
> > > > > > Commit 8344496e8b49 ("rcu-tasks: Conditionally compile
> > > > > > show_rcu_tasks_gp_kthreads()") introduced conditional compilation of
> > > > > > several functions, but forgot one occurrence of
> > > > > > show_rcu_tasks_classic_gp_kthread() that causes the compiler to warn of
> > > > > > an unused static function. Fix it.
> > > > > > 
> > > > > > Fixes: 8344496e8b49 ("rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()")
> > > > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > ---
> > > > > >  kernel/rcu/tasks.h | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > > index 835e2df8590a..bddf3968c1eb 100644
> > > > > > --- a/kernel/rcu/tasks.h
> > > > > > +++ b/kernel/rcu/tasks.h
> > > > > > @@ -590,7 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
> > > > > >  }
> > > > > >  
> > > > > >  #else /* #ifdef CONFIG_TASKS_RCU */
> > > > > > +#ifndef CONFIG_TINY_RCU
> > > > > >  static void show_rcu_tasks_classic_gp_kthread(void) { }
> > > > > > +#endif /* #ifndef CONFIG_TINY_RCU */
> > > > > >  void exit_tasks_rcu_start(void) { }
> > > > > >  void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> > > > > >  #endif /* #else #ifdef CONFIG_TASKS_RCU */
> > > > > 
> > > > > Good catch!!!
> > > > > 
> > > > > But does the following addition of "static inline" work for you?
> > > > 
> > > > They do. I initially added a static inline, and realized #ifdef was used
> > > > extensively when trying to find the proper Fixes: tag, so I went for
> > > > that. I don't mind either way, as long as this gets fixed :-)
> > > 
> > > This is admittedly an odd .h file, given that it is included but once.
> > > 
> > > I have applied the following patch with your Reported-by, cc-ing -stable
> > > for v5.8 and later.
> > 
> > I don't see the fix in Linus' master branch. Given that 8344496e8b49 was
> > introduced in v5.9-rc1, shouldn't this be treated as a regression and
> > merged before Linus releases v5.9 ?
> 
> The current plan is that it goes in during the upcoming merge window,
> a few weeks from now.  However, it sounds like you need it sooner.
> I will try doing a pull request and see what happens.

And sent, CCing you.

							Thanx, Paul

> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > index 835e2df..3dc3ffc 100644
> > > > > --- a/kernel/rcu/tasks.h
> > > > > +++ b/kernel/rcu/tasks.h
> > > > > @@ -590,9 +590,9 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
> > > > >  }
> > > > >  
> > > > >  #else /* #ifdef CONFIG_TASKS_RCU */
> > > > > -static void show_rcu_tasks_classic_gp_kthread(void) { }
> > > > > -void exit_tasks_rcu_start(void) { }
> > > > > -void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> > > > > +static inline void show_rcu_tasks_classic_gp_kthread(void) { }
> > > > > +static inline void exit_tasks_rcu_start(void) { }
> > > > > +static inline void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
> > > > >  #endif /* #else #ifdef CONFIG_TASKS_RCU */
> > > > >  
> > > > >  #ifdef CONFIG_TASKS_RUDE_RCU
> > 
> > -- 
> > Regards,
> > 
> > Laurent Pinchart
