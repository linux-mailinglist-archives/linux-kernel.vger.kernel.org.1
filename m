Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E856D2FA35C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbhAROnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:43:24 -0500
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:46319 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405039AbhAROmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:42:13 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 505A123B0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:41:21 +0000 (GMT)
Received: (qmail 15643 invoked from network); 18 Jan 2021 14:41:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2021 14:41:21 -0000
Date:   Mon, 18 Jan 2021 14:41:19 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210118144119.GR3592@techsingularity.net>
References: <20210115100855.23679-1-mgorman@techsingularity.net>
 <20210115100855.23679-6-mgorman@techsingularity.net>
 <05522d03-e86d-420e-4e88-f098d9a22908@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <05522d03-e86d-420e-4e88-f098d9a22908@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:55:03PM +0800, Li, Aubrey wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 12e08da90024..6c0f841e9e75 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6006,6 +6006,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> >  	return new_cpu;
> >  }
> >  
> > +static inline int __select_idle_cpu(struct task_struct *p, int core, struct cpumask *cpus)
> 
> Sorry if I missed anything, why p and cpus are needed here?
> 

They are not needed. The original code was matching the calling pattern
for select_idle_core() which needs p and cpus to check if sibling CPUs
are allowed.

> > @@ -6135,7 +6147,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  
> >  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >  
> > -	if (sched_feat(SIS_PROP)) {
> > +	if (sched_feat(SIS_PROP) && !smt) {
>
> Is it possible the system does have a idle core, but I still don't want to scan the entire llc domain?
> 

This version is matching historical behaviour. To limit the scan for cores,
select_idle_core() would need to obey SIS_PROP and that patch was dropped
as it introduced regressions. It would only be considered once SIS_PROP
had better metrics for limiting the depth of the search.

> >  		u64 avg_cost, avg_idle, span_avg;
> >  
> >  		/*
> > @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  	for_each_cpu_wrap(cpu, cpus, target) {
> >  		if (!--nr)
> >  			return -1;
> 
> It looks like nr only makes sense when smt = false now, can it be moved into else branch below?
> 

It can. I expect the saving to be marginal and it will need to move back
when/if select_idle_core() obeys SIS_PROP.

> > -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > -			break;
> > +		if (smt) {
> > +			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > +			if ((unsigned int)i < nr_cpumask_bits)
> > +				return i;
> 
> What if the last idle core is selected here, should we set_idle_cores false before return?
> 

We'd have to check what bits were still set in the cpus mask and
determine if they represent an idle core. I severely doubt it would be
worth the cost given that the availability of idle cores can change at
any instant.

-- 
Mel Gorman
SUSE Labs
