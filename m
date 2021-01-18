Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF142F9C84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbhARJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:43:12 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:53337 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388312AbhARJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:28:44 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 634A3CB2B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:27:45 +0000 (GMT)
Received: (qmail 2689 invoked from network); 18 Jan 2021 09:27:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2021 09:27:45 -0000
Date:   Mon, 18 Jan 2021 09:27:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] sched/fair: Make select_idle_cpu() proportional to
 cores
Message-ID: <20210118092743.GP3592@techsingularity.net>
References: <20210115100855.23679-1-mgorman@techsingularity.net>
 <20210115100855.23679-4-mgorman@techsingularity.net>
 <f9036411-39d0-2c28-aec5-5e185d01d3f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <f9036411-39d0-2c28-aec5-5e185d01d3f0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 04:14:36PM +0800, Li, Aubrey wrote:
> > <SNIP>
> > @@ -6124,6 +6126,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
> >  
> >  #else /* CONFIG_SCHED_SMT */
> >  
> > +#define sched_smt_weight	1
> > +
> >  static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> >  	return -1;
> >
> > <SNIP>
> >
> > @@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >  		avg_cost = this_sd->avg_scan_cost + 1;
> >  
> >  		span_avg = sd->span_weight * avg_idle;
> > -		if (span_avg > 4*avg_cost)
> > +		if (span_avg > sis_min_cores*avg_cost)
> >  			nr = div_u64(span_avg, avg_cost);
> >  		else
> > -			nr = 4;
> > +			nr = sis_min_cores;
> > +
> > +		nr *= sched_smt_weight;
> 
> Is it better to put this into an inline wrapper to hide sched_smt_weight if !CONFIG_SCHED_SMT?
> 

There already is a #define sched_smt_weight for !CONFIG_SCHED_SMT and I
do not think an inline wrapper would make it more readable or maintainable.

-- 
Mel Gorman
SUSE Labs
