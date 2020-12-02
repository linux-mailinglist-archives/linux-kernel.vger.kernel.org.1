Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632722CC00D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgLBOtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:49:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:57408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgLBOtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:49:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37470AC6A;
        Wed,  2 Dec 2020 14:48:21 +0000 (UTC)
Date:   Wed, 2 Dec 2020 14:48:18 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <rong.a.chen@intel.com>,
        0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jiang Biao <benbjiang@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        Aubrey Li <aubrey.li@intel.com>, yu.c.chen@intel.com
Subject: Re: [sched/fair] 8d86968ac3: netperf.Throughput_tps -29.5% regression
Message-ID: <20201202144818.GZ3306@suse.de>
References: <20201125090923.GA3723@shao2-debian>
 <6fef3fc7-be18-92e5-c622-add6decb88c4@linux.intel.com>
 <20201126121351.GJ3371@techsingularity.net>
 <b45171de-cb74-bf35-91bf-967dbd5567d1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b45171de-cb74-bf35-91bf-967dbd5567d1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:29:59PM +0800, Li, Aubrey wrote:
> > If the idle mask is not getting cleared then select_idle_cpu() is
> > probably returning immediately. select_idle_core() is almost certainly
> > failing so that just leaves select_idle_smt() to find a potentially idle
> > CPU. That's a limited search space so tasks may be getting stacked and
> > missing CPUs that are idling for short periods.
> 
> Vincent suggested we decouple idle cpumask from short idle(stop tick) and
> set it every time the CPU enters idle, I'll make this change in V6.
> 

As a heads-up, I'm trying to prepare a series that alters the time
complexity in general of select_idle_sibling(). It would tie into what
you are doing with the idle cpumask tracking but would use it as a hint
for CPUs to search first. It's still a WIP but I'm hoping to post
something tomorrow. It would not replace your patch, just alter it a bit
in terms of what happens just before select_idle_cpu().

> > 
> > On the flip side, I expect cases like hackbench to benefit because it
> > can saturate a machine to such a degree that select_idle_cpu() is a waste
> > of time.
> 
> Yes, I believe that's also why I saw uperf/netperf improvement at high
> load levels.
> 

Yeah, hackbench is a case where SIS_AVG_CPU shines even though it does
not help other cases. It throttles the search. In the series I'm working
on right now, I simply kill SIS_AVG_CPU but might incorporate something
like it into SIS_PROP as the last patch of the series as an RFC.

> > 
> > That said, I haven't followed the different versions closely. I know v5
> > got a lot of feedback so will take a closer look at v6. Fundamentally
> > though I expect that using the idle mask will be a mixed bag. At low
> > utilisation or over-saturation, it'll be a benefit. At the point where
> > the machine is almost fully busy, some workloads will benefit (lightly
> > communicating workloads that occasionally migrate) and others will not
> > (ping-pong workloads looking for CPUs that are idle for very brief
> > periods).
> 
> Do you have any interested workload [matrix] I can do the measurement?
> 

Usually I go with a battery of tests from mmtests instead of one or two
specifically to have a mix of wakeup timing, communication patterns and
degrees of utilisation. The downside is that they take ages to run.

> > It's tricky enough that it might benefit from a sched_feat() check that
> > is default true so it gets tested. For regressions that show up, it'll
> > be easy enough to ask for the feature to be disabled to see if it fixes
> > it. Over time, that might give an idea of exactly what sort of workloads
> > benefit and what suffers.
> 
> Okay, I'll add a sched_feat() for this feature.
> 

If the series I'm preparing works out ok and your patch can be integrated,
the sched_feat() may not be necessary because your patch would further
reduce time complexity without worrying about when the information
gets reset.

-- 
Mel Gorman
SUSE Labs
