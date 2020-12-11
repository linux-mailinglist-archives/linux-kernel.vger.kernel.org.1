Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E852D7291
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437176AbgLKJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:03:29 -0500
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:45763 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437179AbgLKJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:03:22 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 0D8C3F842B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:02:30 +0000 (GMT)
Received: (qmail 24518 invoked from network); 11 Dec 2020 09:02:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Dec 2020 09:02:29 -0000
Date:   Fri, 11 Dec 2020 09:02:28 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] sched/fair: Do not replace recent_used_cpu with the
 new target
Message-ID: <20201211090228.GU3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201211062542.3082-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201211062542.3082-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 02:25:42PM +0800, Hillf Danton wrote:
> On Tue,  8 Dec 2020 15:35:00 +0000 Mel Gorman wrote:
> > @@ -6277,17 +6277,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  
> >  	/* Check a recently used CPU as a potential idle candidate: */
> >  	recent_used_cpu = p->recent_used_cpu;
> > +	p->recent_used_cpu = prev;
> >  	if (recent_used_cpu != prev &&
> >  	    recent_used_cpu != target &&
> >  	    cpus_share_cache(recent_used_cpu, target) &&
> >  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> 
> Typo? Fix it in spin if so.
> 

What typo?

> >  	    asym_fits_capacity(task_util, recent_used_cpu)) {
> > -		/*
> > -		 * Replace recent_used_cpu with prev as it is a potential
> > -		 * candidate for the next wake:
> > -		 */
> > -		p->recent_used_cpu = prev;
> >  		return recent_used_cpu;
> 
> I prefer to update the recent CPU after llc check.
> 

That would prevent recent_used_cpu leaving the LLC the task first
started on.

-- 
Mel Gorman
SUSE Labs
