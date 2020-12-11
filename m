Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6F2D7304
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393947AbgLKJqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:46:39 -0500
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:48731 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgLKJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:46:34 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 20D2F1A3D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:45:42 +0000 (GMT)
Received: (qmail 8265 invoked from network); 11 Dec 2020 09:45:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Dec 2020 09:45:41 -0000
Date:   Fri, 11 Dec 2020 09:45:40 +0000
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
Message-ID: <20201211094540.GV3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201211062542.3082-1-hdanton@sina.com>
 <20201211093443.3259-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201211093443.3259-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 05:34:43PM +0800, Hillf Danton wrote:
> On Fri, 11 Dec 2020 09:02:28 +0000 Mel Gorman wrote:
> >On Fri, Dec 11, 2020 at 02:25:42PM +0800, Hillf Danton wrote:
> >> On Tue,  8 Dec 2020 15:35:00 +0000 Mel Gorman wrote:
> >> > @@ -6277,17 +6277,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >> >  
> >> >  	/* Check a recently used CPU as a potential idle candidate: */
> >> >  	recent_used_cpu = p->recent_used_cpu;
> >> > +	p->recent_used_cpu = prev;
> >> >  	if (recent_used_cpu != prev &&
> >> >  	    recent_used_cpu != target &&
> >> >  	    cpus_share_cache(recent_used_cpu, target) &&
> >> >  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >> >  	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> >> 
> >> Typo? Fix it in spin if so.
> >> 
> >
> >What typo?
> 
> After your change it is prev that we check against p->cpus_ptr instead of
> the recent CPU. Wonder the point to do such a check for returning the
> recent one.

Ah... yes, this is indeed wrong. It wouldn't affect Vincent's case
that showed a problem with a hackbench configuration (which I'm still
disappointed about as it's a trade-off depending on machine and workload)
but it allows a task to run on the wrong cpu if sched_setscheduler()
was called between wakeup events.

-- 
Mel Gorman
SUSE Labs
