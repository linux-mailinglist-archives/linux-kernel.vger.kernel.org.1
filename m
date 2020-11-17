Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC742B5F43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKQMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:40:05 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:35171 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgKQMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:40:04 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id E7BAAC0EE8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:40:02 +0000 (GMT)
Received: (qmail 18795 invoked from network); 17 Nov 2020 12:40:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Nov 2020 12:40:02 -0000
Date:   Tue, 17 Nov 2020 12:40:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201117124000.GY3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:30:16AM +0100, Peter Zijlstra wrote:
> > sched_psi_wake_requeue can probably stay with the other three fields
> > given they are under the rq lock but sched_remote_wakeup needs to move
> > out.
> 
> I _think_ we can move the bit into the unserialized section below.
> 
> It's a bit cheecky, but it should work I think because the only time we
> actually use this bit, we're guaranteed the task isn't actually running,
> so current doesn't exist.
> 

Putting the bit there has the added advantage that if the bit existed
on its own that it would be very special in terms of how it should be
treated. Adding a bit adjacent to it would be potentially hazardous.

> ---
> Subject: sched: Fix data-race in wakeup
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Nov 17 09:08:41 CET 2020
>  
> <SNIP>
> 
> Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, testing completed successfully! With the suggested alternative
comment above sched_remote_wakeup;

Reviewed-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
