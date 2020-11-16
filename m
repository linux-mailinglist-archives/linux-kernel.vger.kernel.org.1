Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C125F2B5132
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgKPTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:31:55 -0500
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:43975 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727805AbgKPTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:31:54 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id A476FFB10C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:31:52 +0000 (GMT)
Received: (qmail 30325 invoked from network); 16 Nov 2020 19:31:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 19:31:51 -0000
Date:   Mon, 16 Nov 2020 19:31:49 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116193149.GW3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 03:20:05PM +0100, Peter Zijlstra wrote:
> > I think this is at least one possibility. I think at least that one
> > should only be explicitly set on WF_MIGRATED and explicitly cleared in
> > sched_ttwu_pending. While I haven't audited it fully, it might be enough
> > to avoid a double write outside of the rq lock on the bitfield but I
> > still need to think more about the ordering of sched_contributes_to_load
> > and whether it's ordered by p->on_cpu or not.
> 
> The scenario you're worried about is something like:
> 
> 	CPU0							CPU1
> 
> 	schedule()
> 		prev->sched_contributes_to_load = X;
> 		deactivate_task(prev);
> 
> 								try_to_wake_up()
> 									if (p->on_rq &&) // false
> 									if (smp_load_acquire(&p->on_cpu) && // true
> 									    ttwu_queue_wakelist())
> 										p->sched_remote_wakeup = Y;
> 
> 		smp_store_release(prev->on_cpu, 0);
> 

Yes.

> And then the stores of X and Y clobber one another.. Hummph, seems
> reasonable. One quick thing to test would be something like this:
> 
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7abbdd7f3884..9844e541c94c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -775,7 +775,9 @@ struct task_struct {
>  	unsigned			sched_reset_on_fork:1;
>  	unsigned			sched_contributes_to_load:1;
>  	unsigned			sched_migrated:1;
> +	unsigned			:0;
>  	unsigned			sched_remote_wakeup:1;
> +	unsigned			:0;
>  #ifdef CONFIG_PSI
>  	unsigned			sched_psi_wake_requeue:1;
>  #endif

And this works.

986.01 1008.17 1013.15 2/855 1212
362.19 824.70 949.75 1/856 1564
133.19 674.65 890.32 1/864 1958
49.04 551.89 834.61 2/871 2339
18.33 451.54 782.41 1/867 2686
6.77 369.37 733.45 1/866 2929
2.55 302.16 687.55 1/864 2931
0.97 247.18 644.52 1/860 2933
0.48 202.23 604.20 1/849 2935

I should have gone with this after rereading the warning about bit fields
having to be protected by the same lock in the "anti-guarantees" section
of memory-barriers.txt :(

sched_psi_wake_requeue can probably stay with the other three fields
given they are under the rq lock but sched_remote_wakeup needs to move
out.

-- 
Mel Gorman
SUSE Labs
