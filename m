Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA52019BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391524AbgFSRsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 13:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgFSRsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:48:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FB620786;
        Fri, 19 Jun 2020 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592588883;
        bh=N4RWgoN16EE1BZsFdbQEMpRXO0It9G1CC6hfBn+wOUI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PX+5u82USt671V6ybsFCsBoqsdOzVrG6mQ34A/fY/I6+EfFuA3ASyLSSNDOkKXGAq
         O3AfUE7Wh4OQ4g+PuFOv7JMYeb/vhrL7h6i8sJJwrUYa2hz65xY1ZWthF1AQ+kVpc5
         4e+cy9YHjAJsb6UN9Mgp3bMXqchKOB1yGY2+0UAQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DD9683522B50; Fri, 19 Jun 2020 10:48:02 -0700 (PDT)
Date:   Fri, 19 Jun 2020 10:48:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        npiggin@gmail.com
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200619174802.GA10403@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
 <20200616170410.GL2554@hirez.programming.kicks-ass.net>
 <20200616171721.GM2554@hirez.programming.kicks-ass.net>
 <20200619134423.GB577403@hirez.programming.kicks-ass.net>
 <20200619172047.GK2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619172047.GK2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:20:47AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 19, 2020 at 03:44:23PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 16, 2020 at 07:17:21PM +0200, Peter Zijlstra wrote:

[ . . . ]

> > If not, I'm, once again, defeated by this...
> 
> Here is hoping that this patch cures things!
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/sched/core.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 8298b2c240ce..5534eb1ab79a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2378,6 +2378,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
> >  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
> >  {
> >  	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
> > +		if (WARN_ON(cpu == smp_processor_id()))
> > +			return false;
> > +
> >  		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> >  		__ttwu_queue_wakelist(p, cpu, wake_flags);
> >  		return true;
> > @@ -2550,7 +2553,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  
> >  	/* We're going to change ->state: */
> >  	success = 1;
> > -	cpu = task_cpu(p);
> >  
> >  	/*
> >  	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
> > @@ -2615,7 +2617,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	 * let the waker make forward progress. This is safe because IRQs are
> >  	 * disabled and the IPI will deliver after on_cpu is cleared.
> >  	 */
> > -	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
> > +	if (smp_load_acquire(&p->on_cpu) &&

Given the x86 memory model, this only protects against the compiler
reordering accesses in ttwu_queue_wakelist() against the fetch of
p->on_cpu, correct?

Don't get me wrong, I do see some potential compiler misorderings,
including with cpu_rq(cpu)->nr_running.  Just curious.

						Thanx, Paul

> > +	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_RQ))
> >  		goto unlock;
> >  
> >  	/*
> > @@ -2635,6 +2638,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  		psi_ttwu_dequeue(p);
> >  		set_task_cpu(p, cpu);
> >  	}
> > +#else
> > +	cpu = task_cpu(p);
> >  #endif /* CONFIG_SMP */
> >  
> >  	ttwu_queue(p, cpu, wake_flags);
> > 
