Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03F2FFE41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAVIfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbhAVIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:32:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21823C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l1or63vZWLAmnmjTaOxJSexcVLE8UAT7YoDDiA/iMos=; b=m0nbZBt1lHv3C2bHS9svSKWxMQ
        C3QPGZHuZp/BwawtR4sGVGxdbIsqSqOoqxA/MlrxbEJpUWR7WjglXt+Qb1Oe1gxkGHJId9q+eYlC3
        vF8boDyYRxPfAYyG6Djclt9pmbVP5pNStBxfDchFDfpBNpsl23MhD4SWsw20kWE2rqsgoUO2jXiIg
        dPHWf3lqqesATffitN3A+qfBuoteVfgWQtxjS7iWAJ1L6TLaQzQMO/q7EO7sknePSDR+Wg9cLSP5a
        xyNaNlNnSBH12A2oE4DwLHpZnUWbSO7Tl8Gci+C2N19Fy9gHQbcDnJGDA99rNGmyiM1tkaOnu8L49
        Ql7T5/FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2rr0-000Vxh-F8; Fri, 22 Jan 2021 08:31:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33D383012DF;
        Fri, 22 Jan 2021 09:31:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B65F2D54EF7A; Fri, 22 Jan 2021 09:31:37 +0100 (CET)
Date:   Fri, 22 Jan 2021 09:31:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org,
        valentin.schneider@arm.com
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <YAqNacbJ5b7L/Sd2@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
 <20200527163543.GA706478@hirez.programming.kicks-ass.net>
 <20200527171236.GC706495@hirez.programming.kicks-ass.net>
 <YAmyVW1r0xQOwneB@hirez.programming.kicks-ass.net>
 <20210122002012.GB2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122002012.GB2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:20:12PM -0800, Paul E. McKenney wrote:

> > ---
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 368749008ae8..2c8d4c3e341e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -445,7 +445,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >  	/*
> >  	 * Usually called from the tick; but also used from smp_function_call()
> >  	 * for expedited grace periods. This latter can result in running from
> > -	 * the idle task, instead of an actual IPI.
> > +	 * a (usually the idle) task, instead of an actual IPI.
> 
> The story is growing enough hair that we should tell it only once.
> So here just where it is called from:
> 
> 	/*
> 	 * Usually called from the tick; but also used from smp_function_call()
> 	 * for expedited grace periods.
> 	 */
> 
> >  	lockdep_assert_irqs_disabled();
> >  
> > @@ -461,9 +461,14 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >  		return false;
> >  
> >  	/*
> > -	 * If we're not in an interrupt, we must be in the idle task!
> > +	 * If we're not in an interrupt, we must be in task context.
> > +	 *
> > +	 * This will typically be the idle task through:
> > +	 *   flush_smp_call_function_from_idle(),
> > +	 *
> > +	 * but can also be in CPU HotPlug through smpcfd_dying().
> >  	 */
> 
> Good, but how about like this?
> 
> 	/*
> 	 * If we are not in an interrupt handler, we must be in
> 	 * smp_call_function() handler.
> 	 *
> 	 * Normally, smp_call_function() handlers are invoked from
> 	 * the idle task via flush_smp_call_function_from_idle().
> 	 * However, they can also be invoked from CPU hotplug
> 	 * operations via smpcfd_dying().
> 	 */
> 
> > -	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> > +	WARN_ON_ONCE(!nesting && !in_task(current));
> 
> This is used in time-critical contexts, so why not RCU_LOCKDEP_WARN()?
> That should also allow checking more closely.  Would something like the
> following work?
> 
> 	RCU_LOCKDEP_WARN(!nesting && !is_idle_task(current) && (!in_task(current) || !lockdep_cpus_write_held()));
> 
> Where lockdep_cpus_write_held is defined in kernel/cpu.c:

Works for me, except s/in_task(current)/in_task()/ compiles a lot
better.
