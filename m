Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67A230077D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbhAVPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbhAVPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:36:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 508E6206A4;
        Fri, 22 Jan 2021 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611329741;
        bh=WG6IzHZ750YD/dhJrEgxww5BN2aFxSjz9Zbw7htUOyI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Of07N0rmMyfV08auVII1TMwOfHK75L2r454+L2BIYa8eS2IXbouPIV9wR56sJ58Ce
         jAJ/2pPLp/07yC9fexIxb0ljRTurMjR4t0pc5eJId8LiM07pu+xCdZTcvTYNp/knOE
         BCYRGeCXWN/6SpcklFXd+eEibx/wikQ1tDCVFZJX9xb3QIPyLQY/+u9L7ch48SESrm
         ALC+sGvCzfayufJ6xB+iLPkx69bwjNh/YEBDurtMtcdlcfizNTtG7X075hkA8XpnG2
         mTRcQYxzjHwBuaTpMpYECOSLnhju1/Vn/wkYJoP8k8PZ6cDSy54mLwZSzzg4in0n2i
         HuM6f+iSJofJA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05D053522649; Fri, 22 Jan 2021 07:35:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 07:35:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org,
        valentin.schneider@arm.com
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20210122153540.GF2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
 <20200527163543.GA706478@hirez.programming.kicks-ass.net>
 <20200527171236.GC706495@hirez.programming.kicks-ass.net>
 <YAmyVW1r0xQOwneB@hirez.programming.kicks-ass.net>
 <20210122002012.GB2743@paulmck-ThinkPad-P72>
 <YAqNacbJ5b7L/Sd2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAqNacbJ5b7L/Sd2@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:31:37AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 21, 2021 at 04:20:12PM -0800, Paul E. McKenney wrote:
> 
> > > ---
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 368749008ae8..2c8d4c3e341e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -445,7 +445,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > >  	/*
> > >  	 * Usually called from the tick; but also used from smp_function_call()
> > >  	 * for expedited grace periods. This latter can result in running from
> > > -	 * the idle task, instead of an actual IPI.
> > > +	 * a (usually the idle) task, instead of an actual IPI.
> > 
> > The story is growing enough hair that we should tell it only once.
> > So here just where it is called from:
> > 
> > 	/*
> > 	 * Usually called from the tick; but also used from smp_function_call()
> > 	 * for expedited grace periods.
> > 	 */
> > 
> > >  	lockdep_assert_irqs_disabled();
> > >  
> > > @@ -461,9 +461,14 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > >  		return false;
> > >  
> > >  	/*
> > > -	 * If we're not in an interrupt, we must be in the idle task!
> > > +	 * If we're not in an interrupt, we must be in task context.
> > > +	 *
> > > +	 * This will typically be the idle task through:
> > > +	 *   flush_smp_call_function_from_idle(),
> > > +	 *
> > > +	 * but can also be in CPU HotPlug through smpcfd_dying().
> > >  	 */
> > 
> > Good, but how about like this?
> > 
> > 	/*
> > 	 * If we are not in an interrupt handler, we must be in
> > 	 * smp_call_function() handler.
> > 	 *
> > 	 * Normally, smp_call_function() handlers are invoked from
> > 	 * the idle task via flush_smp_call_function_from_idle().
> > 	 * However, they can also be invoked from CPU hotplug
> > 	 * operations via smpcfd_dying().
> > 	 */
> > 
> > > -	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> > > +	WARN_ON_ONCE(!nesting && !in_task(current));
> > 
> > This is used in time-critical contexts, so why not RCU_LOCKDEP_WARN()?
> > That should also allow checking more closely.  Would something like the
> > following work?
> > 
> > 	RCU_LOCKDEP_WARN(!nesting && !is_idle_task(current) && (!in_task(current) || !lockdep_cpus_write_held()));
> > 
> > Where lockdep_cpus_write_held is defined in kernel/cpu.c:
> 
> Works for me, except s/in_task(current)/in_task()/ compiles a lot
> better.

These compilers sure constrain my creativity!  ;-)

Might be a good thing, though...

							Thanx, Paul
