Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA602D8264
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436916AbgLKWwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:52:17 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:51609 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436806AbgLKWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:51:00 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 03DD41C3F9A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 22:50:05 +0000 (GMT)
Received: (qmail 24108 invoked from network); 11 Dec 2020 22:50:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Dec 2020 22:50:04 -0000
Date:   Fri, 11 Dec 2020 22:50:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201211225002.GY3371@techsingularity.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <20201211204337.GX3371@techsingularity.net>
 <20201211221905.GV3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201211221905.GV3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:19:05PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 11, 2020 at 08:43:37PM +0000, Mel Gorman wrote:
> > One bug is in __select_idle_core() though. It's scanning the SMT mask,
> > not select_idle_mask so it can return an idle candidate that is not in
> > p->cpus_ptr.
> 
> D'0h.. luckily the benchmarks don't hit that :-)
> 

Yep, neither do mine for the most part which is why I ran it as-is but
eventually someone would complain that sched_setscheduler was being
ignored.

Trick is whether a failed check should continue searching for an idle core
or terminate early and just pick an allowed idle CPU. I tend to favour
the latter but it's hard to predict what sort of reasonable workloads
would be affected.

> > There are some other potential caveats.
> > 
> > This is a single pass so when test_idle_cores() is true, __select_idle_core
> > is used to to check all the siblings even if the core is not idle. That
> > could have been cut short if __select_idle_core checked *idle_cpu ==
> > 1 and terminated the SMT scan if an idle candidate had already been found.
> 
> So I did that on purpose, so as to track the last/most-recent idle cpu,
> with the thinking that that cpu has the higher chance of still being
> idle vs one we checked earlier/longer-ago.
> 
> I suppose we benchmark both and see which is liked best.
> 

I originally did something like that on purpose too but Vincent called
it out so it is worth mentioning now to avoid surprises. That said, I'm
at the point where anything SIS-related simply needs excessive exposure
because no matter what it does, someone is unhappy with it.

> > Second downside is related. If test_idle_cpus() was true but no idle
> > CPU is found then __select_idle_core has been called enough to scan
> > the entire domain. In this corner case, the new code does *more* work
> > because the old code would have failed select_idle_core() quickly and
> > then select_idle_cpu() would be throttled by SIS_PROP. I think this will
> > only be noticable in the heavily overloaded case but if the corner case
> > hits enough then the new code will be slower than the old code for the
> > over-saturated case (i.e. hackbench with lots of groups).
> 
> Right, due to scanning siblings, even if the first inspected thread is
> not idle, we scan more.
> 

Yep.

> > The third potential downside is that the SMT sibling is not guaranteed to
> > be checked due to SIS_PROP throttling but in the old code, that would have
> > been checked by select_idle_smt(). That might result in premature stacking
> > of runnable tasks on the same CPU. Similarly, as __select_idle_core may
> > find multiple idle candidates, it will not pick the targets SMT sibling
> > if it is idle like select_idle_smt would have.
> > 
> > That said, I am skeptical that select_idle_smt() matters all that often.
> 
> This, I didn't really believe in it either.
> 

Good because I think any benefit from select_idle_smt is so marginal
that it should be ignored if the full scan is simpler overall.

> The benchmarks I started are mostly noise, with a few wins for
> TCP_STREAM and UDP_RR around the 50% mark. Although I should run
> longer variants to make sure.

So far I have one benchmark from one machine. It's tbench again because
it's a reasonable communicating workload that is trivial to vary the
level of utilisation.

80-cpu CascadeLake, 2 sockets, HT enabled
tbench4
                          5.10.0-rc6             5.10.0-rc6             5.10.0-rc6
                       baseline-v1r1        singlescan-v1r1        singlescan-v1r3
Hmean     1        503.90 (   0.00%)      505.19 *   0.26%*      499.20 *  -0.93%*
Hmean     2        980.80 (   0.00%)      975.15 *  -0.58%*      983.79 *   0.31%*
Hmean     4       1912.37 (   0.00%)     1883.25 *  -1.52%*     1923.76 *   0.60%*
Hmean     8       3741.47 (   0.00%)     3568.66 *  -4.62%*     3690.60 *  -1.36%*
Hmean     16      6552.90 (   0.00%)     6549.97 *  -0.04%*     6478.37 *  -1.14%*
Hmean     32     10217.34 (   0.00%)    10266.66 *   0.48%*    10291.60 *   0.73%*
Hmean     64     13604.93 (   0.00%)    11240.88 * -17.38%*    12045.87 * -11.46%*
Hmean     128    21194.11 (   0.00%)    21316.08 *   0.58%*    21868.39 *   3.18%*
Hmean     256    21163.19 (   0.00%)    20989.14 *  -0.82%*    20831.20 *  -1.57%*
Hmean     320    20906.29 (   0.00%)    21024.11 *   0.56%*    20756.88 *  -0.71%*
Stddev    1          3.14 (   0.00%)        1.17 (  62.93%)        1.05 (  66.61%)
Stddev    2          4.44 (   0.00%)        3.72 (  16.35%)        2.20 (  50.56%)
Stddev    4          9.09 (   0.00%)       18.67 (-105.32%)        3.66 (  59.71%)
Stddev    8         12.87 (   0.00%)       18.96 ( -47.31%)       11.90 (   7.58%)
Stddev    16         8.34 (   0.00%)        8.77 (  -5.22%)       36.25 (-334.84%)
Stddev    32        27.05 (   0.00%)       20.90 (  22.74%)       28.57 (  -5.61%)
Stddev    64       720.66 (   0.00%)       20.12 (  97.21%)       32.10 (  95.55%)
Stddev    128       17.49 (   0.00%)       52.33 (-199.22%)      137.68 (-687.25%)
Stddev    256       57.17 (   0.00%)       18.87 (  67.00%)       38.98 (  31.81%)
Stddev    320       29.87 (   0.00%)       46.49 ( -55.64%)       31.48 (  -5.39%)

                  5.10.0-rc6  5.10.0-rc6  5.10.0-rc6
                baseline-v1r1singlescan-v1r1singlescan-v1r3
Duration User        9771.18     9435.64     9353.29
Duration System     34224.28    33829.01    33802.34
Duration Elapsed     2218.87     2218.87     2218.69

baseline is roughly what's in tip for 5.11-rc1 with patches 1-2 from my
series like you had.

singlescan-v1r1 is your patch

singlescan-v1r3 is your patch with my "untested" patch on top that
enforces p->cpus_ptr and short-cuts corner cases.

Few points of interest

1. 64 clients regresses. With 64 clients, this is roughly the point
   where test_idle_cores() returns false positives and we hit the worst
   corner cases. Your patch regresses 17%, mine is only a marginal
   improvement and still a regression slower.

2. Variations are all over the place. Your patch is great at low
   utilisation and stabilises overall. After that, your milage varies a lot

3. The system CPu usage summarised over the entire workload drops quite
   a bit. Whether it's your patch or minor changes on top, there is less
   work being done within the kernel overall

A wider battery of tests is still running and a second set is queued
that adds the debugging schedstats but they take ages to run.

I'm currently on "holidays" so response time will be variable :P

-- 
Mel Gorman
SUSE Labs
