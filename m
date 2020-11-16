Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F02B4C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgKPRQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:16:47 -0500
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:48283 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732627AbgKPRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:16:47 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id B87CAF856F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 17:16:44 +0000 (GMT)
Received: (qmail 14252 invoked from network); 16 Nov 2020 17:16:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 17:16:43 -0000
Date:   Mon, 16 Nov 2020 17:16:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116171641.GU3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116155232.GS3371@techsingularity.net>
 <20201116165415.GG3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116165415.GG3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:54:15PM +0100, Peter Zijlstra wrote:
> > > And then the stores of X and Y clobber one another.. Hummph, seems
> > > reasonable. One quick thing to test would be something like this:
> > > 
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 7abbdd7f3884..9844e541c94c 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -775,7 +775,9 @@ struct task_struct {
> > >  	unsigned			sched_reset_on_fork:1;
> > >  	unsigned			sched_contributes_to_load:1;
> > >  	unsigned			sched_migrated:1;
> > > +	unsigned			:0;
> > >  	unsigned			sched_remote_wakeup:1;
> > > +	unsigned			:0;
> > >  #ifdef CONFIG_PSI
> > >  	unsigned			sched_psi_wake_requeue:1;
> > >  #endif
> > 
> > I'll test this after the smp_wmb() test completes. While a clobbering may
> > be the issue, I also think the gap between the rq->nr_uninterruptible++
> > and smp_store_release(prev->on_cpu, 0) is relevant and a better candidate.
> 
> I really don't understand what you wrote in that email...

Sorry :(. I tried writing a changelog showing where I think the race
might be. I'll queue up your patch that is potentially sched_migrated
and sched_remote_wakeup being clobbered.

--8<--
sched: Fix loadavg accounting race on arm64

An internal bug report filed against a 5.8 and 5.9 kernel that loadavg
was "exploding" on arm64 on a machines acting as a build servers. It
happened on at least two different arm64 variants. That setup is complex to
replicate but can be reproduced by running hackbench-process-pipes while
heavily overcommitting a machine with 96 logical CPUs and then checking
if loadavg drops afterwards. With an MMTests clone, reproduce it as follows

./run-mmtests.sh --config configs/config-workload-hackbench-process-pipes --no-monitor testrun; \
for i in `seq 1 60`; do cat /proc/loadavg; sleep 60; done

The reproduction case simply hammers the case where a task can be
descheduling while also being woken by another task at the same time.
After the test completes, load avg should reach 0 within a few minutes.

Commit dbfb089d360b ("sched: Fix loadavg accounting race") fixed a loadavg
accounting race in the generic case. Later it was documented why the ordering
of when p->sched_contributes_to_load is read/updated relative to p->on_cpu.
This is critical when a task is descheduling at the same time it is being
activated on another CPU. While the load/stores happen under the RQ lock,
the RQ lock on its own does not give any guarantees on the task state.

The problem appears to be because the schedule and wakeup paths rely
on being ordered by ->on_cpu for some fields as documented in core.c
under "Notes on Program-Order guarantees on SMP systems". However,
this can happen

CPU 0					CPU 1			CPU 2

__schedule()
  prev->sched_contributes_to_load = 1
  rq->nr_uninterruptible++;
  rq_unlock_irq
					try_to_wake_up
					  smp_load_acquire(&p->on_cpu) && ttwu_queue_wakelist(p) == true
					    ttwu_queue_wakelist
					      ttwu_queue_cond (true)
					      __ttwu_queue_wakelist

								sched_ttwu_pending
								  ttwu_do_activate
								    if (p->sched_contributes_to_load) (wrong value observed, load drifts)
finish_task
  smp_store_release(X->on_cpu, 0)

There is a gap between when rq->nr_uninterruptible is written
to before p->on_cpu is updated with smp_store_release(). During
that window, a parallel waker may observe the incorrect value for
p->sched_contributes_to_load and fail to decrement rq->nr_uninterruptible
and the loadavg starts drifting.

This patch adds a write barrier after nr_uninterruptible is updated
with the matching read barrier done when reading p->on_cpu in the ttwu
path. With the patch applied, the load averages taken every minute after
the hackbench test case completes is

950.21 977.17 990.69 1/853 2117
349.00 799.32 928.69 1/859 2439
128.18 653.85 870.56 1/861 2736
47.08 534.84 816.08 1/860 3029
17.29 437.50 765.00 1/865 3357
6.35 357.87 717.13 1/865 3653
2.33 292.74 672.24 1/861 3709
0.85 239.46 630.17 1/859 3711
0.31 195.87 590.73 1/857 3713
0.11 160.22 553.76 1/853 3715

Without the patch, the load average stabilised at 244 on an otherwise
idle machine.

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Cc: stable@vger.kernel.org # v5.8+

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..877eaeba45ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4459,14 +4459,26 @@ static void __sched notrace __schedule(bool preempt)
 		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
-			prev->sched_contributes_to_load =
+			int acct_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
 				!(prev->flags & PF_FROZEN);
 
-			if (prev->sched_contributes_to_load)
+			prev->sched_contributes_to_load = acct_load;
+			if (acct_load) {
 				rq->nr_uninterruptible++;
 
+				/*
+				 * Pairs with p->on_cpu ordering, either a
+				 * smp_load_acquire or smp_cond_load_acquire
+				 * in the ttwu path before ttwu_do_activate
+				 * p->sched_contributes_to_load. It's only
+				 * after the nr_interruptible update happens
+				 * that the ordering is critical.
+				 */
+				smp_wmb();
+			}
+
 			/*
 			 * __schedule()			ttwu()
 			 *   prev_state = prev->state;    if (p->on_rq && ...)

-- 
Mel Gorman
SUSE Labs
