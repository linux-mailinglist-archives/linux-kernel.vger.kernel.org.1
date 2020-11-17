Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10662B5E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgKQLnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:43:22 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:42406 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:43:22 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 87A53CAFE3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:43:20 +0000 (GMT)
Received: (qmail 27865 invoked from network); 17 Nov 2020 11:43:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Nov 2020 11:43:19 -0000
Date:   Tue, 17 Nov 2020 11:43:18 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sched: Fix rq->nr_iowait ordering
Message-ID: <20201117114318.GX3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117093829.GD3121429@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201117093829.GD3121429@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:38:29AM +0100, Peter Zijlstra wrote:
> Subject: sched: Fix rq->nr_iowait ordering
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 24 Sep 2020 13:50:42 +0200
> 
>   schedule()				ttwu()
>     deactivate_task();			  if (p->on_rq && ...) // false
> 					    atomic_dec(&task_rq(p)->nr_iowait);
>     if (prev->in_iowait)
>       atomic_inc(&rq->nr_iowait);
> 
> Allows nr_iowait to be decremented before it gets incremented,
> resulting in more dodgy IO-wait numbers than usual.
> 
> Note that because we can now do ttwu_queue_wakelist() before
> p->on_cpu==0, we lose the natural ordering and have to further delay
> the decrement.
> 
> Fixes: Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

s/Fixes: Fixes:/Fixes:/

Ok, very minor hazard that the same logic gets duplicated that someone
might try "fix" but git blame should help. Otherwise, it makes sense as
I've received more than one "bug" that complained that a number was larger
than they expected even if no other problem was present so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
