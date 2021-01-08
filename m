Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97952EF36E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhAHNsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:48:30 -0500
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:59557 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727228AbhAHNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:48:29 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id CE72DFB4D5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:47:37 +0000 (GMT)
Received: (qmail 2071 invoked from network); 8 Jan 2021 13:47:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jan 2021 13:47:37 -0000
Date:   Fri, 8 Jan 2021 13:47:36 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20210108134736.GC3592@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
 <20210108130110.cj3zqsnjdt5mg3uz@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210108130110.cj3zqsnjdt5mg3uz@e107158-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 01:01:10PM +0000, Qais Yousef wrote:
> On 01/08/21 10:27, Mel Gorman wrote:
> >  	for_each_cpu_wrap(cpu, cpus, target) {
> > -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
> > +			/* Adjust cost of a successful scan */
> > +			loops <<= 2;
> > +
> >  			break;
> > +		}
> >  
> > -		if (loops >= nr) {
> > +		if (++loops >= nr) {
> >  			cpu = -1;
> >  			break;
> >  		}
> > -		loops++;
> 
> Random (out of the blue) comment.
> 
> Now this will increment loops before the comparison/break. ie: we're
> effectively doing one iteration less IIRC. Should loops be initialized to
> 0 instead of 1?
> 

Yep, although in practice it'll make little difference except after a
rapid phase change when avg_idle still appears high on a per-rq basis
yet the domain is fully busy with no idle CPUs.

-- 
Mel Gorman
SUSE Labs
