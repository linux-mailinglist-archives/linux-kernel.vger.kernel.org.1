Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC228E93F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgJNXk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbgJNXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:40:56 -0400
Received: from localhost (unknown [176.167.119.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCD6208D5;
        Wed, 14 Oct 2020 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602718855;
        bh=hGMXOP6gyJ3ATfZP4dASK21yvBlRFVKikz9hv7cwjL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkrTS3UVL3nP/Tk6tFF/qu3NynCLslI5YSvIIrlfnJsQHRkO+y/DwDtSOmADGGD3S
         1F/MwHaQoriU7VtZtNWDfjQZNceFyPCiEtsG9nQqdMZIQMABrp/U3Qn0TZhFFRrVA4
         BaA7b1I3Ti6VgGgy2a+k+hnen4vAUNshO/qtGHb0=
Date:   Thu, 15 Oct 2020 01:40:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201014234053.GA86158@lothringen>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
 <20201013171328.GA19284@fuller.cnet>
 <20201014083321.GA2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014083321.GA2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 10:33:21AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 02:13:28PM -0300, Marcelo Tosatti wrote:
> 
> > > Yes but if the task isn't running, run_posix_cpu_timers() doesn't have
> > > anything to elapse. So indeed we can spare the IPI if the task is not
> > > running. Provided ordering makes sure that the task sees the new dependency
> > > when it schedules in of course.
> > 
> > True.
> > 
> >  * p->on_cpu <- { 0, 1 }:
> >  *
> >  *   is set by prepare_task() and cleared by finish_task() such that it will be
> >  *   set before p is scheduled-in and cleared after p is scheduled-out, both
> >  *   under rq->lock. Non-zero indicates the task is running on its CPU.
> > 
> > 
> > CPU-0 (tick_set_dep)            CPU-1 (task switch)
> > 
> > STORE p->tick_dep_mask
> > smp_mb() (atomic_fetch_or())
> > LOAD p->on_cpu
> > 
> > 
> >                                 context_switch(prev, next)
> >                                 STORE next->on_cpu = 1
> >                                 ...                             [*]
> > 
> >                                 LOAD current->tick_dep_mask
> > 
> 
> That load is in tick_nohz_task_switch() right? (which BTW is placed
> completely wrong) You could easily do something like the below I
> suppose.
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 81632cd5e3b7..2a5fafe66bb0 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -410,6 +410,14 @@ void __tick_nohz_task_switch(void)
>  	ts = this_cpu_ptr(&tick_cpu_sched);
>  
>  	if (ts->tick_stopped) {
> +		/*
> +		 * tick_set_dep()		(this)
> +		 *
> +		 * STORE p->tick_dep_mask	STORE p->on_cpu
> +		 * smp_mb()			smp_mb()
> +		 * LOAD p->on_cpu		LOAD p->tick_dep_mask
> +		 */
> +		smp_mb();
>  		if (atomic_read(&current->tick_dep_mask) ||
>  		    atomic_read(&current->signal->tick_dep_mask))
>  			tick_nohz_full_kick();

It would then need to be unconditional (whatever value of ts->tick_stopped).
Assuming the tick isn't stopped, we may well have an interrupt firing right
after schedule() which doesn't see the new value of tick_dep_map.

Alternatively, we could rely on p->on_rq which is set to TASK_ON_RQ_QUEUED
at wake up time, prior to the schedule() full barrier. Of course that doesn't
mean that the task is actually the one running on the CPU but it's a good sign,
considering that we are running in nohz_full mode and it's usually optimized
for single task mode.

Also setting a remote task's tick dependency is only used by posix cpu timer
in case the user has the bad taste to enqueue on a task running in nohz_full
mode. It shouldn't deserve an unconditional full barrier in the schedule path.

If the target is current, as is used by RCU, I guess we can keep a special
treatment.

> re tick_nohz_task_switch() being placed wrong, it should probably be
> placed before finish_lock_switch(). Something like so.
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cf044580683c..5c92c959824f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4084,6 +4084,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	vtime_task_switch(prev);
>  	perf_event_task_sched_in(prev, current);
>  	finish_task(prev);
> +	tick_nohz_task_switch();
>  	finish_lock_switch(rq);
>  	finish_arch_post_lock_switch();
>  	kcov_finish_switch(current);
> @@ -4121,7 +4122,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		put_task_struct_rcu_user(prev);
>  	}
>  
> -	tick_nohz_task_switch();

IIRC, we wanted to keep it outside rq lock because it shouldn't it...
