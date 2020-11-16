Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770C22B4950
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgKPP3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:29:52 -0500
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:49401 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbgKPP3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:29:52 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id C4784FB14B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:29:49 +0000 (GMT)
Received: (qmail 21534 invoked from network); 16 Nov 2020 15:29:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 15:29:48 -0000
Date:   Mon, 16 Nov 2020 15:29:46 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116152946.GR3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
 <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
 <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:58:03PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 01:53:55PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 16, 2020 at 11:49:38AM +0000, Mel Gorman wrote:
> > > On Mon, Nov 16, 2020 at 09:10:54AM +0000, Mel Gorman wrote:
> > > > I'll be looking again today to see can I find a mistake in the ordering for
> > > > how sched_contributes_to_load is handled but again, the lack of knowledge
> > > > on the arm64 memory model means I'm a bit stuck and a second set of eyes
> > > > would be nice :(
> > > > 
> > > 
> > > This morning, it's not particularly clear what orders the visibility of
> > > sched_contributes_to_load exactly like other task fields in the schedule
> > > vs try_to_wake_up paths. I thought the rq lock would have ordered them but
> > > something is clearly off or loadavg would not be getting screwed. It could
> > > be done with an rmb and wmb (testing and hasn't blown up so far) but that's
> > > far too heavy.  smp_load_acquire/smp_store_release might be sufficient
> > > on it although less clear if the arm64 gives the necessary guarantees.
> > > 
> > > (This is still at the chucking out ideas as I haven't context switched
> > > back in all the memory barrier rules).
> > 
> > IIRC it should be so ordered by ->on_cpu.
> > 
> > We have:
> > 
> > 	schedule()
> > 		prev->sched_contributes_to_load = X;
> > 		smp_store_release(prev->on_cpu, 0);
> > 
> > 
> > on the one hand, and:
> 
> Ah, my bad, ttwu() itself will of course wait for !p->on_cpu before we
> even get here.
> 

Sortof, it will either have called smp_load_acquire(&p->on_cpu) or
smp_cond_load_acquire(&p->on_cpu, !VAL) before hitting one of the paths
leading to ttwu_do_activate. Either way, it's covered.

> > 	sched_ttwu_pending()
> > 		if (WARN_ON_ONCE(p->on_cpu))
> > 			smp_cond_load_acquire(&p->on_cpu)
> > 
> > 		ttwu_do_activate()
> > 			if (p->sched_contributes_to_load)
> > 				...
> > 
> > on the other (for the remote case, which is the only 'interesting' one).
> 

But this side is interesting because I'm having trouble convincing
myself it's 100% correct for sched_contributes_to_load. The write of
prev->sched_contributes_to_load in the schedule() path has a big gap
before it hits the smp_store_release(prev->on_cpu).

On the ttwu path, we have

        if (smp_load_acquire(&p->on_cpu) &&
            ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
                goto unlock;

	ttwu_queue_wakelist queues task on the wakelist, sends IPI
	and on the receiver side it calls ttwu_do_activate and reads
	sched_contributes_to_load

sched_ttwu_pending() is not necessarily using the same rq lock so no
protection there. The smp_load_acquire() has just been hit but it still
leaves a gap between when sched_contributes_to_load is written and a
parallel read of sched_contributes_to_load.

So while we might be able to avoid a smp_rmb() before the read of
sched_contributes_to_load and rely on p->on_cpu ordering there,
we may still need a smp_wmb() after nr_interruptible() increments
instead of waiting until the smp_store_release() is hit while a task
is scheduling. That would be a real memory barrier on arm64 and a plain
compiler barrier on x86-64.

> Also see the "Notes on Program-Order guarantees on SMP systems."
> comment.

I did, it was the on_cpu ordering for the blocking case that had me
looking at the smp_store_release and smp_cond_load_acquire in arm64 in
the first place thinking that something in there must be breaking the
on_cpu ordering. I'm re-reading it every so often while trying to figure
out where the gap is or whether I'm imagining things.

Not fully tested but did not instantly break either

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
