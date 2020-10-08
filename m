Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC5287B56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgJHSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgJHSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602180325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Xyy9ho6hKVYkDXBrRlCpvl18fOUfAGF1m07HoT38kk=;
        b=En0Rl1jyYInMvh45A3FdjR46tLviahTyfaJ8xukoRMuQXg3gJvFZk3dU7bYnL7xhkZcDD+
        GCJQdwwxadKo8laFBNAvMIGD9cQp6nL04a6iLKFAJo28OTAA1x3kCYSqX7xVS3taCaGe5l
        H5+/nM/t6slM+DtxS2yaFYAQHuVvgKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-SbtGd2njM--WGNkXVskEhQ-1; Thu, 08 Oct 2020 14:05:23 -0400
X-MC-Unique: SbtGd2njM--WGNkXVskEhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6130F425D7;
        Thu,  8 Oct 2020 18:05:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 955B75C1BD;
        Thu,  8 Oct 2020 18:05:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 280094168BA3; Thu,  8 Oct 2020 14:54:09 -0300 (-03)
Date:   Thu, 8 Oct 2020 14:54:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008175409.GB14207@fuller.cnet>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122256.GW2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 02:22:56PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> > When adding a tick dependency to a task, its necessary to
> > wakeup the CPU where the task resides to reevaluate tick
> > dependencies on that CPU.
> > 
> > However the current code wakes up all nohz_full CPUs, which 
> > is unnecessary.
> > 
> > Switch to waking up a single CPU, by using ordering of writes
> > to task->cpu and task->tick_dep_mask.
> > 
> > From: Frederic Weisbecker <frederic@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-2.6/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/time/tick-sched.c
> > +++ linux-2.6/kernel/time/tick-sched.c
> > @@ -274,6 +274,31 @@ void tick_nohz_full_kick_cpu(int cpu)
> >  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> >  }
> >  
> > +static void tick_nohz_kick_task(struct task_struct *tsk)
> > +{
> > +	int cpu = task_cpu(tsk);
> > +
> > +	/*
> > +	 * If the task concurrently migrates to another cpu,
> > +	 * we guarantee it sees the new tick dependency upon
> > +	 * schedule.
> > +	 *
> > +	 *
> > +	 * set_task_cpu(p, cpu);
> > +	 *   STORE p->cpu = @cpu
> > +	 * __schedule() (switch to task 'p')
> > +	 *   LOCK rq->lock
> > +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> > +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> > +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> > +	 */
> > +
> > +	preempt_disable();
> > +	if (cpu_online(cpu))
> > +		tick_nohz_full_kick_cpu(cpu);
> > +	preempt_enable();
> > +}
> 
> So we need to kick the CPU unconditionally, or only when the task is
> actually running? AFAICT we only care about current->tick_dep_mask.

tick is necessary to execute run_posix_cpu_timers, from tick interrupt, 
even if task is not running.

