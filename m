Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452828D2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgJMROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbgJMROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602609256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvTfEYSbcf6EPPV715VidKpzYX3skN7h2Jtnr/oCjJs=;
        b=HmhokQrxkVDpypen/rRGEsaIkg/4YLg2Tf/kR3v16ehXARJB+IzLMZ1wto1niboqoFJtNg
        ZhcYBPPo1uW6jt1UzMibj2kG6wGe44r4QqjDdJUoRkNvAZNc3Elo26inD3mdrvbcbiU43b
        ekwY7XyTfxfGjjPIxO2eG5L7f0qkQz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-XtNFrBbTN-KpeVY9VJ1JqA-1; Tue, 13 Oct 2020 13:14:14 -0400
X-MC-Unique: XtNFrBbTN-KpeVY9VJ1JqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0264802B6F;
        Tue, 13 Oct 2020 17:14:13 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 935C5610F3;
        Tue, 13 Oct 2020 17:14:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B18F5416948A; Tue, 13 Oct 2020 14:13:28 -0300 (-03)
Date:   Tue, 13 Oct 2020 14:13:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201013171328.GA19284@fuller.cnet>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008195444.GB86389@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 09:54:44PM +0200, Frederic Weisbecker wrote:
> On Thu, Oct 08, 2020 at 02:54:09PM -0300, Marcelo Tosatti wrote:
> > On Thu, Oct 08, 2020 at 02:22:56PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > > > When adding a tick dependency to a task, its necessary to
> > > > wakeup the CPU where the task resides to reevaluate tick
> > > > dependencies on that CPU.
> > > > 
> > > > However the current code wakes up all nohz_full CPUs, which 
> > > > is unnecessary.
> > > > 
> > > > Switch to waking up a single CPU, by using ordering of writes
> > > > to task->cpu and task->tick_dep_mask.
> > > > 
> > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > > 
> > > > Index: linux-2.6/kernel/time/tick-sched.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/kernel/time/tick-sched.c
> > > > +++ linux-2.6/kernel/time/tick-sched.c
> > > > @@ -274,6 +274,31 @@ void tick_nohz_full_kick_cpu(int cpu)
> > > >  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> > > >  }
> > > >  
> > > > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > > > +{
> > > > +	int cpu = task_cpu(tsk);
> > > > +
> > > > +	/*
> > > > +	 * If the task concurrently migrates to another cpu,
> > > > +	 * we guarantee it sees the new tick dependency upon
> > > > +	 * schedule.
> > > > +	 *
> > > > +	 *
> > > > +	 * set_task_cpu(p, cpu);
> > > > +	 *   STORE p->cpu = @cpu
> > > > +	 * __schedule() (switch to task 'p')
> > > > +	 *   LOCK rq->lock
> > > > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > > > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > > > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > > > +	 */
> > > > +
> > > > +	preempt_disable();
> > > > +	if (cpu_online(cpu))
> > > > +		tick_nohz_full_kick_cpu(cpu);
> > > > +	preempt_enable();
> > > > +}
> > > 
> > > So we need to kick the CPU unconditionally, or only when the task is
> > > actually running? AFAICT we only care about current->tick_dep_mask.
> > 
> > tick is necessary to execute run_posix_cpu_timers, from tick interrupt, 
> > even if task is not running.
> 
> Yes but if the task isn't running, run_posix_cpu_timers() doesn't have
> anything to elapse. So indeed we can spare the IPI if the task is not
> running. Provided ordering makes sure that the task sees the new dependency
> when it schedules in of course.

True.

 * p->on_cpu <- { 0, 1 }:
 *
 *   is set by prepare_task() and cleared by finish_task() such that it will be
 *   set before p is scheduled-in and cleared after p is scheduled-out, both
 *   under rq->lock. Non-zero indicates the task is running on its CPU.


CPU-0 (tick_set_dep)            CPU-1 (task switch)

STORE p->tick_dep_mask
smp_mb() (atomic_fetch_or())
LOAD p->on_cpu


                                context_switch(prev, next)
                                STORE next->on_cpu = 1
                                ...                             [*]

                                LOAD current->tick_dep_mask


Don't see any explicit memory barrier in the [*] section?

