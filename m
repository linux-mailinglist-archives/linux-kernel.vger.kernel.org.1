Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370DA1C3086
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 02:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEDAjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbgEDAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 20:39:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF3C061A0F
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 17:39:15 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so7578749qvz.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 17:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZU2Jq3uSJpx5BEWiOvjjNcojy+e0VaV2eMdS/R2jofE=;
        b=c+gq2CsapviuzhbYBwhkWprA+wnrt9iSRNkzDjfsdr8klJwCw3lo12OdY8UGP61V/F
         JiDHdnEVsJ0gQ6cdTTMXkOUmiqr4kBOguFPxzqy9B1nDZWxLZ7koDCCAOMdc21tNq2Wm
         RSZDF167f03u58e+jXnybeFxUJXategn8dNOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZU2Jq3uSJpx5BEWiOvjjNcojy+e0VaV2eMdS/R2jofE=;
        b=d/MlysFewrEjHr5ajb1WRHmIReRoKXmUFNf+qVrL1IlB63/ecwA4svUoYSjUZvfFlJ
         mXSrl6gMdL77qLr/XZhScf0mKyqQXtZYgcd2POIPfcu6tBD9nQx6oYpNRsldjvA99VSi
         AwxlUy1zmY59810SYjqRWxrM8fkactAoZTrhKzO3iBsrmFLgCBDWXLYf122pzrc3ak6I
         E0JjDDegi1BRzfI9cK9yRug3YUYZ2+yvjs9YpQoN6VWke34NOmYwO4WYrYDjCMsENT1u
         VVDFnTBzEOljH5Db9WoR8iGstRUOqTtxY8c6geTR4VKkRWrozfSChpp7L4AQ0SwKXuBh
         DStg==
X-Gm-Message-State: AGi0PuaR/kswi4ZE9f4EE7B1k0iAAc7kLQ+aH4LG6L7z4/gKp9cM3tqr
        ErB3GXtGc/xJA9KSR5BCRvEZxg==
X-Google-Smtp-Source: APiQypLdBBSYo8HhlYJeaV+F4IR7VDwMmFvV05Z+duvtwaqhe2u+oVt/G2F8/UroUd8NM8jj3B8V5Q==
X-Received: by 2002:a0c:8222:: with SMTP id h31mr14223004qva.106.1588552754590;
        Sun, 03 May 2020 17:39:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t67sm8801032qka.17.2020.05.03.17.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 17:39:13 -0700 (PDT)
Date:   Sun, 3 May 2020 20:39:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
Message-ID: <20200504003913.GE212435@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-4-urezki@gmail.com>
 <20200501190555.GB7560@paulmck-ThinkPad-P72>
 <20200503235213.GC197097@google.com>
 <20200504002656.GE2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002656.GE2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 05:26:56PM -0700, Paul E. McKenney wrote:
> On Sun, May 03, 2020 at 07:52:13PM -0400, Joel Fernandes wrote:
> > On Fri, May 01, 2020 at 12:05:55PM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > 
> > > > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > > > with majority of commenting styles.
> > > > 
> > > > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Hmmm...
> > > 
> > > Exactly why is three additional characters per line preferable?  Or in
> > > the case of block comments, either one or two additional lines, depending
> > > on /* */ style?
> > 
> > I prefer to keep the code consistent and then bulk convert it later. Its a
> > bit ugly to read when its mixed up with "//" and "/* */" right now. We can
> > convert it to // all at once later but until then it'll be good to keep it
> > consistent in this file IMO. When I checked the kfree_rcu() code, it had more
> > "/* */" than not, so this small change is less churn for now.
> 
> Please just drop this patch along with the other "//"-to-"/* */"
> regressions.

Right now in your rcu/dev branch (without applying this series),in
kfree_rcu_drain_unlock() and the functions before and after it, it is
inconsistent.

Also in kfree_call_rcu(), it is:

	// Queue the object but don't yet schedule the batch.
	if (debug_rcu_head_queue(head)) {
		// Probable double kfree_rcu(), just leak.
		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
			  __func__, head);
		goto unlock_return;
	}

	/*
	 * Under high memory pressure GFP_NOWAIT can fail,
	 * in that case the emergency path is maintained.
	 */

> If you want to convert more comments to "//" within the confines of the
> kfree_rcu() code, I am probably OK with that.  But again, a big-bang
> change of this sort often causes problems due to lots of potential
> rebase/merge conflicts.

Ok. Since this series touched kfree-related RCU code, converting all of the
kfree-related RCU code to "//" is Ok with me. Just wanted to keep it
consistent :)

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > > 
> > > I am (slowly) moving RCU to "//" for those reasons.  ;-)
> > > 
> > > 							Thanx, Paul
> > > 
> > > > ---
> > > >  kernel/rcu/tree.c | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index cd61649e1b00..1487af8e11e8 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3043,15 +3043,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> > > >  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > > >  					  unsigned long flags)
> > > >  {
> > > > -	// Attempt to start a new batch.
> > > > +	/* Attempt to start a new batch. */
> > > >  	krcp->monitor_todo = false;
> > > >  	if (queue_kfree_rcu_work(krcp)) {
> > > > -		// Success! Our job is done here.
> > > > +		/* Success! Our job is done here. */
> > > >  		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > >  		return;
> > > >  	}
> > > >  
> > > > -	// Previous RCU batch still in progress, try again later.
> > > > +	/* Previous RCU batch still in progress, try again later. */
> > > >  	krcp->monitor_todo = true;
> > > >  	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > > @@ -3151,14 +3151,14 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	unsigned long flags;
> > > >  	struct kfree_rcu_cpu *krcp;
> > > >  
> > > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > > +	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
> > > >  	krcp = this_cpu_ptr(&krc);
> > > >  	if (krcp->initialized)
> > > >  		raw_spin_lock(&krcp->lock);
> > > >  
> > > > -	// Queue the object but don't yet schedule the batch.
> > > > +	/* Queue the object but don't yet schedule the batch. */
> > > >  	if (debug_rcu_head_queue(head)) {
> > > > -		// Probable double kfree_rcu(), just leak.
> > > > +		/* Probable double kfree_rcu(), just leak. */
> > > >  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > >  			  __func__, head);
> > > >  		goto unlock_return;
> > > > @@ -3176,7 +3176,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  
> > > >  	WRITE_ONCE(krcp->count, krcp->count + 1);
> > > >  
> > > > -	// Set timer to drain after KFREE_DRAIN_JIFFIES.
> > > > +	/* Set timer to drain after KFREE_DRAIN_JIFFIES. */
> > > >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > > >  	    !krcp->monitor_todo) {
> > > >  		krcp->monitor_todo = true;
> > > > @@ -3722,7 +3722,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > >  
> > > >  	rcutree_affinity_setting(cpu, cpu);
> > > >  
> > > > -	// nohz_full CPUs need the tick for stop-machine to work quickly
> > > > +	/* nohz_full CPUs need the tick for stop-machine to work quickly */
> > > >  	tick_dep_set(TICK_DEP_BIT_RCU);
> > > >  	return 0;
> > > >  }
> > > > -- 
> > > > 2.20.1
> > > > 
