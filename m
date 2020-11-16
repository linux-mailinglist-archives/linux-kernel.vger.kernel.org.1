Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D492B2B4BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgKPQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKPQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:49:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t0yos457T5wRwKhkGOjffUVqgtsuUVWs8V/BkO8galU=; b=Hqt3072JNhTrHB71Gb+ZzdlIeU
        W5H4QG1vpbv04ueqEHjVYA9KSKJVZKhdDf23f2xxX/niFASFgWqG5xALBo5HjLxAP/R+90TOMAdm2
        egMYwxZ1e9DzDaWfxZMzNtZmSDBOsPt2YY4yJq7+aCG2YZyJc0cI0wquu66cqDbOfyU62tL8cF+DY
        Q7Km+TRbn0CLdOEhBR84X3Jr2NgrbcNE46D3IxuGTVK2hx4Sny4ZM1p/AnYKQ8Gwsw8E8+lDmGoSG
        kMY60cWGk3MT5+pbCmHQ+5IDpZklKkOOfs9d6mOPuceJaFlv9nT/zF1f8zFHXO7VPKCfcVAsNYvW+
        I+a3wNgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehh4-0002Hc-H6; Mon, 16 Nov 2020 16:49:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27A493012C3;
        Mon, 16 Nov 2020 17:49:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BA9A20282DFC; Mon, 16 Nov 2020 17:49:28 +0100 (CET)
Date:   Mon, 16 Nov 2020 17:49:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116164928.GF3121392@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
 <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
 <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
 <20201116152946.GR3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116152946.GR3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:29:46PM +0000, Mel Gorman wrote:
> On Mon, Nov 16, 2020 at 01:58:03PM +0100, Peter Zijlstra wrote:

> > > 	sched_ttwu_pending()
> > > 		if (WARN_ON_ONCE(p->on_cpu))
> > > 			smp_cond_load_acquire(&p->on_cpu)
> > > 
> > > 		ttwu_do_activate()
> > > 			if (p->sched_contributes_to_load)
> > > 				...
> > > 
> > > on the other (for the remote case, which is the only 'interesting' one).
> > 
> 
> But this side is interesting because I'm having trouble convincing
> myself it's 100% correct for sched_contributes_to_load. The write of
> prev->sched_contributes_to_load in the schedule() path has a big gap
> before it hits the smp_store_release(prev->on_cpu).
> 
> On the ttwu path, we have
> 
>         if (smp_load_acquire(&p->on_cpu) &&
>             ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
>                 goto unlock;
> 
> 	ttwu_queue_wakelist queues task on the wakelist, sends IPI
> 	and on the receiver side it calls ttwu_do_activate and reads
> 	sched_contributes_to_load
> 
> sched_ttwu_pending() is not necessarily using the same rq lock so no
> protection there. The smp_load_acquire() has just been hit but it still
> leaves a gap between when sched_contributes_to_load is written and a
> parallel read of sched_contributes_to_load.
> 
> So while we might be able to avoid a smp_rmb() before the read of
> sched_contributes_to_load and rely on p->on_cpu ordering there,
> we may still need a smp_wmb() after nr_interruptible() increments
> instead of waiting until the smp_store_release() is hit while a task
> is scheduling. That would be a real memory barrier on arm64 and a plain
> compiler barrier on x86-64.

I'm mighty confused by your words here; and the patch below. What actual
scenario are you worried about?

If we take the WF_ON_CPU path, we IPI the CPU the task is ->on_cpu on.
So the IPI lands after the schedule() that clears ->on_cpu on the very
same CPU.

> 
> > Also see the "Notes on Program-Order guarantees on SMP systems."
> > comment.
> 
> I did, it was the on_cpu ordering for the blocking case that had me
> looking at the smp_store_release and smp_cond_load_acquire in arm64 in
> the first place thinking that something in there must be breaking the
> on_cpu ordering. I'm re-reading it every so often while trying to figure
> out where the gap is or whether I'm imagining things.
> 
> Not fully tested but did not instantly break either
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..877eaeba45ac 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4459,14 +4459,26 @@ static void __sched notrace __schedule(bool preempt)
>  		if (signal_pending_state(prev_state, prev)) {
>  			prev->state = TASK_RUNNING;
>  		} else {
> -			prev->sched_contributes_to_load =
> +			int acct_load =
>  				(prev_state & TASK_UNINTERRUPTIBLE) &&
>  				!(prev_state & TASK_NOLOAD) &&
>  				!(prev->flags & PF_FROZEN);
>  
> -			if (prev->sched_contributes_to_load)
> +			prev->sched_contributes_to_load = acct_load;
> +			if (acct_load) {
>  				rq->nr_uninterruptible++;
>  
> +				/*
> +				 * Pairs with p->on_cpu ordering, either a
> +				 * smp_load_acquire or smp_cond_load_acquire
> +				 * in the ttwu path before ttwu_do_activate
> +				 * p->sched_contributes_to_load. It's only
> +				 * after the nr_interruptible update happens
> +				 * that the ordering is critical.
> +				 */
> +				smp_wmb();
> +			}

Sorry, I can't follow, at all.
