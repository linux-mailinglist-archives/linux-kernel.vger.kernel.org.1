Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAF294292
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437901AbgJTS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437892AbgJTS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603220179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YdO7VVKSSR3KqLBqFdeONpl2/d1Zi5UPOH4yHHzJxiw=;
        b=GdLAkHcvQh5k8GjxthDeOv7KIufyvqA+G1L20HV9M1pudfpn38vPxm7Z3T9GdBGdd9oz88
        q/DR0EndEkL8MVT/TXhKulDbOrONZI0lQM71M8da6vWU5uEoi6KIkUHEaythy+88TEZ1Il
        uEJM8149Di2iGEbAaM12D2fdpzwBHLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-IDcqqmmoPQKA7EDGwu_iRw-1; Tue, 20 Oct 2020 14:56:17 -0400
X-MC-Unique: IDcqqmmoPQKA7EDGwu_iRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921E86408B;
        Tue, 20 Oct 2020 18:56:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F82228545;
        Tue, 20 Oct 2020 18:56:10 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5093D405D8D2; Tue, 20 Oct 2020 15:52:45 -0300 (-03)
Date:   Tue, 20 Oct 2020 15:52:45 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201020185245.GA3577@fuller.cnet>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
 <20201013171328.GA19284@fuller.cnet>
 <20201014083321.GA2628@hirez.programming.kicks-ass.net>
 <20201014234053.GA86158@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014234053.GA86158@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 01:40:53AM +0200, Frederic Weisbecker wrote:
> On Wed, Oct 14, 2020 at 10:33:21AM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 13, 2020 at 02:13:28PM -0300, Marcelo Tosatti wrote:
> > 
> > > > Yes but if the task isn't running, run_posix_cpu_timers() doesn't have
> > > > anything to elapse. So indeed we can spare the IPI if the task is not
> > > > running. Provided ordering makes sure that the task sees the new dependency
> > > > when it schedules in of course.
> > > 
> > > True.
> > > 
> > >  * p->on_cpu <- { 0, 1 }:
> > >  *
> > >  *   is set by prepare_task() and cleared by finish_task() such that it will be
> > >  *   set before p is scheduled-in and cleared after p is scheduled-out, both
> > >  *   under rq->lock. Non-zero indicates the task is running on its CPU.
> > > 
> > > 
> > > CPU-0 (tick_set_dep)            CPU-1 (task switch)
> > > 
> > > STORE p->tick_dep_mask
> > > smp_mb() (atomic_fetch_or())
> > > LOAD p->on_cpu
> > > 
> > > 
> > >                                 context_switch(prev, next)
> > >                                 STORE next->on_cpu = 1
> > >                                 ...                             [*]
> > > 
> > >                                 LOAD current->tick_dep_mask
> > > 
> > 
> > That load is in tick_nohz_task_switch() right? (which BTW is placed
> > completely wrong) You could easily do something like the below I
> > suppose.
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 81632cd5e3b7..2a5fafe66bb0 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -410,6 +410,14 @@ void __tick_nohz_task_switch(void)
> >  	ts = this_cpu_ptr(&tick_cpu_sched);
> >  
> >  	if (ts->tick_stopped) {
> > +		/*
> > +		 * tick_set_dep()		(this)
> > +		 *
> > +		 * STORE p->tick_dep_mask	STORE p->on_cpu
> > +		 * smp_mb()			smp_mb()
> > +		 * LOAD p->on_cpu		LOAD p->tick_dep_mask
> > +		 */
> > +		smp_mb();
> >  		if (atomic_read(&current->tick_dep_mask) ||
> >  		    atomic_read(&current->signal->tick_dep_mask))
> >  			tick_nohz_full_kick();
> 
> It would then need to be unconditional (whatever value of ts->tick_stopped).
> Assuming the tick isn't stopped, we may well have an interrupt firing right
> after schedule() which doesn't see the new value of tick_dep_map.
> 
> Alternatively, we could rely on p->on_rq which is set to TASK_ON_RQ_QUEUED
> at wake up time, prior to the schedule() full barrier. Of course that doesn't
> mean that the task is actually the one running on the CPU but it's a good sign,
> considering that we are running in nohz_full mode and it's usually optimized
> for single task mode.

Unfortunately that would require exporting p->on_rq which is internal to
the scheduler, locklessly.

(can surely do that if you prefer!)

> 
> Also setting a remote task's tick dependency is only used by posix cpu timer
> in case the user has the bad taste to enqueue on a task running in nohz_full
> mode. It shouldn't deserve an unconditional full barrier in the schedule path.
> 
> If the target is current, as is used by RCU, I guess we can keep a special
> treatment.

To answer PeterZ's original question:

"So we need to kick the CPU unconditionally, or only when the task is
actually running? AFAICT we only care about current->tick_dep_mask."

If there is a task sharing signals, executing on a remote CPU, yes that remote CPU 
should be awakened.

Could skip the IPI if the remote process is not running, however for 
the purposes of low latency isolated processes, this optimization is
not necessary.

So the last posted patchset is good enough for isolated low latency processes.

Do you guys want me to do something or can you take the series as it is?

> > re tick_nohz_task_switch() being placed wrong, it should probably be
> > placed before finish_lock_switch(). Something like so.
> > 
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index cf044580683c..5c92c959824f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4084,6 +4084,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  	vtime_task_switch(prev);
> >  	perf_event_task_sched_in(prev, current);
> >  	finish_task(prev);
> > +	tick_nohz_task_switch();
> >  	finish_lock_switch(rq);
> >  	finish_arch_post_lock_switch();
> >  	kcov_finish_switch(current);
> > @@ -4121,7 +4122,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  		put_task_struct_rcu_user(prev);
> >  	}
> >  
> > -	tick_nohz_task_switch();
> 
> IIRC, we wanted to keep it outside rq lock because it shouldn't it...

