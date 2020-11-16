Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE62B45BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgKPOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgKPOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:20:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gDbYBHfLZqidfH2ybBwkm4expg5GASr5U6xmQYqVWYg=; b=Y23zg2ZwzO4F75zA/56dYO8VB/
        V0+gHK6t757y8EuaSZnFn/69fpoItsJJE2JEelK1TmQRZDpvniy9sptoP6ACk+mxwu5v01/vDRxxI
        Ym1pNcGFAS3Zo93HNcH0Wc/InOJdK0eYxknOzPpoE6p4R1LRPVjQ80kAnIhov7XQvX0IvxFdn1tAU
        fsvqJ3mw9tzyqKnImKxu4VOwSN78wIZhJu62KDKW2x9luGpf26Z0Cw8CJ5x0r2mz3Ztx9zfnMHA/1
        E3NrmTTmcC5sgB3FAWhGzPth6+XNmB/eoXIW91RZIfWGIph3FI3l8FZBogZd9XE8DxBld5sHb3pnl
        uVTFcPAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefMW-0001OX-IF; Mon, 16 Nov 2020 14:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ADEA305CC3;
        Mon, 16 Nov 2020 15:20:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86B10202B3762; Mon, 16 Nov 2020 15:20:05 +0100 (CET)
Date:   Mon, 16 Nov 2020 15:20:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116133721.GQ3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:37:21PM +0000, Mel Gorman wrote:
> On Mon, Nov 16, 2020 at 01:11:03PM +0000, Will Deacon wrote:

> > Anyway, setting all that aside, I do agree with you that the bitfield usage
> > in task_struct looks pretty suspicious. For example, in __schedule() we
> > have:
> > 
> > 	rq_lock(rq, &rf);
> > 	smp_mb__after_spinlock();
> > 	...
> > 	prev_state = prev->state;
> > 
> > 	if (!preempt && prev_state) {
> > 		if (signal_pending_state(prev_state, prev)) {
> > 			prev->state = TASK_RUNNING;
> > 		} else {
> > 			prev->sched_contributes_to_load =
> > 				(prev_state & TASK_UNINTERRUPTIBLE) &&
> > 				!(prev_state & TASK_NOLOAD) &&
> > 				!(prev->flags & PF_FROZEN);
> > 			...
> > 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> > 
> > where deactivate_task() updates p->on_rq directly:
> > 
> > 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
> > 
> 
> It used to be at least a WRITE_ONCE until 58877d347b58 ("sched: Better
> document ttwu()") which changed it. Not sure why that is and didn't
> think about it too deep as it didn't appear to be directly related to
> the problem and didn't have ordering consequences.

I'm confused; that commit didn't change deactivate_task(). Anyway,
->on_rq should be strictly under rq->lock. That said, since there is a
READ_ONCE() consumer of ->on_rq it makes sense to have the stores as
WRITE_ONCE().

> > __ttwu_queue_wakelist() we have:
> > 
> > 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> > 
> > which can be invoked on the try_to_wake_up() path if p->on_rq is first read
> > as zero and then p->on_cpu is read as 1. Perhaps these non-atomic bitfield
> > updates can race and cause the flags to be corrupted?
> > 
> 
> I think this is at least one possibility. I think at least that one
> should only be explicitly set on WF_MIGRATED and explicitly cleared in
> sched_ttwu_pending. While I haven't audited it fully, it might be enough
> to avoid a double write outside of the rq lock on the bitfield but I
> still need to think more about the ordering of sched_contributes_to_load
> and whether it's ordered by p->on_cpu or not.

The scenario you're worried about is something like:

	CPU0							CPU1

	schedule()
		prev->sched_contributes_to_load = X;
		deactivate_task(prev);

								try_to_wake_up()
									if (p->on_rq &&) // false
									if (smp_load_acquire(&p->on_cpu) && // true
									    ttwu_queue_wakelist())
										p->sched_remote_wakeup = Y;

		smp_store_release(prev->on_cpu, 0);



And then the stores of X and Y clobber one another.. Hummph, seems
reasonable. One quick thing to test would be something like this:


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7abbdd7f3884..9844e541c94c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -775,7 +775,9 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
+	unsigned			:0;
 	unsigned			sched_remote_wakeup:1;
+	unsigned			:0;
 #ifdef CONFIG_PSI
 	unsigned			sched_psi_wake_requeue:1;
 #endif
