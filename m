Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37EF2F005B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 15:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbhAIOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 09:00:48 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:35281 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbhAIOAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 09:00:47 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 43E7AFABA5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 13:59:55 +0000 (GMT)
Received: (qmail 23259 invoked from network); 9 Jan 2021 13:59:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2021 13:59:55 -0000
Date:   Sat, 9 Jan 2021 13:59:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20210109135953.GF3592@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
 <X/i+3G53+AH4FfM2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <X/i+3G53+AH4FfM2@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:21:48PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 08, 2021 at 10:27:38AM +0000, Mel Gorman wrote:
> 
> > 1. avg_scan_cost is now based on the average scan cost of a rq but
> >    avg_idle is still scaled to the domain size. This is a bit problematic
> >    because it's comparing scan cost of a single rq with the estimated
> >    average idle time of a domain. As a result, the scan depth can be much
> >    larger than it was before the patch and led to some regressions.
> 
> > @@ -6164,25 +6164,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  		 */
> >  		avg_idle = this_rq()->avg_idle / 512;
> >  		avg_cost = this_sd->avg_scan_cost + 1;
> > -
> > -		span_avg = sd->span_weight * avg_idle;
> > -		if (span_avg > 4*avg_cost)
> > -			nr = div_u64(span_avg, avg_cost);
> > -		else
> > +		nr = div_u64(avg_idle, avg_cost);
> > +		if (nr < 4)
> >  			nr = 4;
> 
> Oooh, could it be I simply didn't remember how that code was supposed to
> work and should kick my (much) younger self for not writing a comment?
> 
> Consider:
> 
>        span_weight * avg_idle               avg_cost
>   nr = ---------------------- = avg_idle / ----------
>                avg_cost                    span_weigt
> 
> Where: avg_cost / span_weight ~= cost-per-rq
> 

This would definitely make sense and I even evaluated it but the nature
of avg_idle and the scale it works at (up to 2*sched_migration_cost)
just ended up generating lunatic values far outside the size of the domain
size. Fitting that to the domain size just ended up looking silly too and
avg_cost does not decay. Still, in principle, it's the right direction,
it's just not what the code does right now.

-- 
Mel Gorman
SUSE Labs
