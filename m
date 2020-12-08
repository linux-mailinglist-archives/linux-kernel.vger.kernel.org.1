Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA02D2969
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgLHK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:59:54 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:56139 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbgLHK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:59:53 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id ED9B41C3AA5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:59:01 +0000 (GMT)
Received: (qmail 22711 invoked from network); 8 Dec 2020 10:59:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Dec 2020 10:59:01 -0000
Date:   Tue, 8 Dec 2020 10:59:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
Message-ID: <20201208105900.GG3371@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net>
 <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:07:19AM +0100, Dietmar Eggemann wrote:
> On 07/12/2020 10:15, Mel Gorman wrote:
> > SIS_AVG_CPU was introduced as a means of avoiding a search when the
> > average search cost indicated that the search would likely fail. It
> > was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
> > select_idle_cpu() more aggressive") and later replaced with a proportional
> > search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
> > scale select_idle_cpu()").
> > 
> > While there are corner cases where SIS_AVG_CPU is better, it has now been
> > disabled for almost three years. As the intent of SIS_PROP is to reduce
> > the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
> > on SIS_PROP as a throttling mechanism.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  kernel/sched/fair.c     | 3 ---
> >  kernel/sched/features.h | 1 -
> >  2 files changed, 4 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 98075f9ea9a8..23934dbac635 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6161,9 +6161,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  	avg_idle = this_rq()->avg_idle / 512;
> >  	avg_cost = this_sd->avg_scan_cost + 1;
> >  
> > -	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
> > -		return -1;
> > -
> >  	if (sched_feat(SIS_PROP)) {
> >  		u64 span_avg = sd->span_weight * avg_idle;
> >  		if (span_avg > 4*avg_cost)
> 
> Nitpick:
> 
> Since now avg_cost and avg_idle are only used w/ SIS_PROP, they could go
> completely into the SIS_PROP if condition.
> 

Yeah, I can do that. In the initial prototype, that happened in a
separate patch that split out SIS_PROP into a helper function and I
never merged it back. It's a trivial change.

Thanks.

-- 
Mel Gorman
SUSE Labs
