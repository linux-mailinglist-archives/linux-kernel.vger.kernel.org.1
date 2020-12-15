Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4432DAEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgLOOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:24:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60150 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgLOOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:24:21 -0500
Date:   Tue, 15 Dec 2020 15:23:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608042219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73SDa5ZqZDS3/s/9JXLAnXy+Sn7Tzs1/CqwdLDxnyLI=;
        b=XlAL0eJrC+WtYVOunzt/UV3fZiNs3eUEzEwbronKsJVabta3LCXMkfKYaBOuVfugob3Tk/
        T/A3E3OiwUan+tpXbeqbwQOSfsuVElGnJf5uT5vp9giTIGfdA1d3j3pmAV1fWgrOjxJDBm
        W50f6rCNq1jffaFWwugon0b2JRHMBQXLoPKWpey8cyPkK3HCsZ4hLaZOFc28Yw/hLAJZUu
        SzKbfqA8snFmG/rjJJA6oHqR/N7m1mSTrrWtwj9KW3KRsrcI7Wqsv3/l1q0FhMf5h5unjX
        ka2KuSQcMtmN6TS1cVNIeiCrEJV4R6JiJjFySj7xFFl63lsjBM06Oe8NbUATkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608042219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73SDa5ZqZDS3/s/9JXLAnXy+Sn7Tzs1/CqwdLDxnyLI=;
        b=j51a577PWjQ2hVJcjVXEox96ZClrO5b1lbgrHlrXP+ESxw2j1nPlfjtfjAruk36pMGxI8q
        lihpgzmxJzAUPxDA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is
 !active
In-Reply-To: <20201215111806.GF3040@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2012151449260.1448@somnus>
References: <20201215104400.9435-1-anna-maria@linutronix.de> <20201215111806.GF3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020, Peter Zijlstra wrote:

> On Tue, Dec 15, 2020 at 11:44:00AM +0100, Anna-Maria Behnsen wrote:
> > SCHED_SOFTIRQ is raised to trigger periodic load balancing. When CPU is not
> > active, CPU should not participate in load balancing.
> > 
> > The scheduler uses nohz.idle_cpus_mask to keep track of the CPUs which can
> > do idle load balancing. When bringing a CPU up the CPU is added to the mask
> > when it reaches the active state, but on teardown the CPU stays in the mask
> > until it goes offline and invokes sched_cpu_dying().
> > 
> > When SCHED_SOFTIRQ is raised on a !active CPU, there might be a pending
> > softirq when stopping the tick which triggers a warning in NOHZ code. The
> > SCHED_SOFTIRQ can also be raised by the scheduler tick which has the same
> > issue.
> > 
> > Therefore remove the CPU from nohz.idle_cpus_mask when it is marked
> > inactive and also prevent the scheduler_tick() from raising SCHED_SOFTIRQ
> > after this point.
> > 
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > ---
> >  kernel/sched/core.c | 7 ++++++-
> >  kernel/sched/fair.c | 7 +++++--
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 21b548b69455..69284dc121d3 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7492,6 +7492,12 @@ int sched_cpu_deactivate(unsigned int cpu)
> >  	struct rq_flags rf;
> >  	int ret;
> >  
> > +	/*
> > +	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
> > +	 * load balancing when not active
> > +	 */
> > +	nohz_balance_exit_idle(rq);
> > +
> >  	set_cpu_active(cpu, false);
> >  	/*
> >  	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU
> 
> OK, so we must clear the state before !active, because getting an
> interrupt/softirq after would trigger the badness. And we're guaranteed
> nothing blocks between them to re-set it.

As far as I understood, it is not a problem whether the delete is before or
after !active. When it is deleted after, the remote CPU will return in
kick_ilb() because cpu is not idle, because it is running the hotplug
thread.

Thanks,

	Anna-Maria
