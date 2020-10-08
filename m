Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BE287CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgJHTys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgJHTys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:54:48 -0400
Received: from localhost (i15-lef02-th2-89-83-218-254.ft.lns.abo.bbox.fr [89.83.218.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C33322226;
        Thu,  8 Oct 2020 19:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602186887;
        bh=SwggV8rN+QzZjU3ytrDhmKYiPli3J312uSlDZDcL9JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDCRFELFKJUqTa8aiZki0psqhlPpRftadQRINQgb9kQ7qkSsexOHxU/gFO4JrYTC0
         LVGfIEW1TUQZZjbHo3Vb4Sfk5A4AAQsTLzzmDCeNU/yADuYQ7VEXBK2cZqGGxSzxP6
         fcxvrzy5gVa2c6+FZqX8WpKRPLYdJuCPCkz5VBHY=
Date:   Thu, 8 Oct 2020 21:54:44 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008195444.GB86389@lothringen>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008175409.GB14207@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 02:54:09PM -0300, Marcelo Tosatti wrote:
> On Thu, Oct 08, 2020 at 02:22:56PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > > When adding a tick dependency to a task, its necessary to
> > > wakeup the CPU where the task resides to reevaluate tick
> > > dependencies on that CPU.
> > > 
> > > However the current code wakes up all nohz_full CPUs, which 
> > > is unnecessary.
> > > 
> > > Switch to waking up a single CPU, by using ordering of writes
> > > to task->cpu and task->tick_dep_mask.
> > > 
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > Index: linux-2.6/kernel/time/tick-sched.c
> > > ===================================================================
> > > --- linux-2.6.orig/kernel/time/tick-sched.c
> > > +++ linux-2.6/kernel/time/tick-sched.c
> > > @@ -274,6 +274,31 @@ void tick_nohz_full_kick_cpu(int cpu)
> > >  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> > >  }
> > >  
> > > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > > +{
> > > +	int cpu = task_cpu(tsk);
> > > +
> > > +	/*
> > > +	 * If the task concurrently migrates to another cpu,
> > > +	 * we guarantee it sees the new tick dependency upon
> > > +	 * schedule.
> > > +	 *
> > > +	 *
> > > +	 * set_task_cpu(p, cpu);
> > > +	 *   STORE p->cpu = @cpu
> > > +	 * __schedule() (switch to task 'p')
> > > +	 *   LOCK rq->lock
> > > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > > +	 */
> > > +
> > > +	preempt_disable();
> > > +	if (cpu_online(cpu))
> > > +		tick_nohz_full_kick_cpu(cpu);
> > > +	preempt_enable();
> > > +}
> > 
> > So we need to kick the CPU unconditionally, or only when the task is
> > actually running? AFAICT we only care about current->tick_dep_mask.
> 
> tick is necessary to execute run_posix_cpu_timers, from tick interrupt, 
> even if task is not running.

Yes but if the task isn't running, run_posix_cpu_timers() doesn't have
anything to elapse. So indeed we can spare the IPI if the task is not
running. Provided ordering makes sure that the task sees the new dependency
when it schedules in of course.
