Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271AF2D5743
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgLJJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:33:35 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:53395 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727461AbgLJJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:33:34 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id AFF24C0B17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:32:41 +0000 (GMT)
Received: (qmail 30451 invoked from network); 10 Dec 2020 09:32:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Dec 2020 09:32:41 -0000
Date:   Thu, 10 Dec 2020 09:32:40 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under
 SIS_PROP
Message-ID: <20201210093240.GQ3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-3-mgorman@techsingularity.net>
 <1963d0ca-054c-19f9-94e0-d019a2e8e259@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1963d0ca-054c-19f9-94e0-d019a2e8e259@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:18:05PM +0800, Li, Aubrey wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ac7b34e7372b..5c41875aec23 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  	if (!this_sd)
> >  		return -1;
> >  
> > +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +
> >  	if (sched_feat(SIS_PROP)) {
> >  		u64 avg_cost, avg_idle, span_avg;
> >  
> > @@ -6168,11 +6170,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  			nr = div_u64(span_avg, avg_cost);
> >  		else
> >  			nr = 4;
> > -	}
> > -
> > -	time = cpu_clock(this);
> >  
> > -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +		time = cpu_clock(this);
> > +	}
> >  
> >  	for_each_cpu_wrap(cpu, cpus, target) {
> >  		if (!--nr)
> >			return -1;
> 
> I thought about this again and here seems not to be consistent:
> - even if nr reduces to 0, shouldn't avg_scan_cost be updated as well before return -1?

You're right, but it's outside the scope
of this patch. I noted that this was a problem in
lore.kernel.org/r/lore.kernel.org/r/20201203141124.7391-8-mgorman@techsingularity.net
It's neither a consistent win or loss to always account for it and so
was dropped for this series to keep the number of controversial patches
to a minimum.

> - if avg_scan_cost is not updated because nr is throttled, the first 
> 	time = cpu_clock(this);
>   can be optimized. As nr is calculated and we already know which of the weight of cpumask and nr is greater.
> 

That is also outside the scope of this patch. To do that, cpumask_weight()
would have to be calculated but it's likely to be a net loss. Even under
light load, nr will be smaller than the domain weight incurring both the
cost of cpumask_weight and the clock read in the common case.

-- 
Mel Gorman
SUSE Labs
