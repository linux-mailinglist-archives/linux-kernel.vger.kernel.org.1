Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4D2B4B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgKPQmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:42:38 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:47783 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731041AbgKPQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:42:38 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 58CA2FAF48
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:42:36 +0000 (GMT)
Received: (qmail 3516 invoked from network); 16 Nov 2020 16:42:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 16:42:35 -0000
Date:   Mon, 16 Nov 2020 16:42:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116164232.GT3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
 <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
 <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
 <20201116152946.GR3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116152946.GR3371@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:29:46PM +0000, Mel Gorman wrote:
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
> +
>  			/*
>  			 * __schedule()			ttwu()
>  			 *   prev_state = prev->state;    if (p->on_rq && ...)
> 

This passed the test. Load averages taken once a minute after the test
completed showed

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

With 5.10-rc3, it got stuck with a load average of 244 after the test
completed even though the machine was idle.

-- 
Mel Gorman
SUSE Labs
