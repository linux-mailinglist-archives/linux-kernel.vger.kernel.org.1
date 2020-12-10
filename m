Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665C52D5B17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgLJM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:59:40 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:37821 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732831AbgLJM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:59:40 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 53C27FAA1A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:58:35 +0000 (GMT)
Received: (qmail 13907 invoked from network); 10 Dec 2020 12:58:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Dec 2020 12:58:35 -0000
Date:   Thu, 10 Dec 2020 12:58:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201210125833.GT3371@techsingularity.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 08:21:14PM +0800, Li, Aubrey wrote:
> >>>
> >>> The field I would expect to decrease is SIS Domain Scanned -- the number
> >>> of runqueues that were examined but it's actually worse and graphing over
> >>> time shows it's worse for the client thread counts.  select_idle_cpu()
> >>> is definitely being called because "Domain Search" is 10 times higher than
> >>> "Core Search" and there "Core Miss" is non-zero.
> >>
> >> Why SIS Domain Scanned can be decreased?
> >>
> > 
> > Because if idle CPUs are being targetted and its a subset of the entire
> > domain then it follows that fewer runqueues should be examined when
> > scanning the domain.
> 
> Sorry, I probably messed up "SIS Domain Scanned" and "SIS Domain Search".
> How is "SIS Domain Scanned" calculated?
> 

        my $fast_search = $sis_search - $sis_domain_search;
        my $domain_scanned = $sis_scanned - $fast_search;

The difference is margainal. The "fast" search is the checking of
target, prev and recent as described in this hunk

@@ -6246,6 +6249,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
        unsigned long task_util;
        int i, recent_used_cpu;

+       schedstat_inc(this_rq()->sis_search);
+
+       /*
+        * Checking if prev, target and recent is treated as one scan. A
+        * perfect hit on one of those is considered 100% efficiency.
+        * Further scanning impairs efficiency.
+        */
+       schedstat_inc(this_rq()->sis_scanned);
+
        /*
         * On asymmetric system, update task utilization because we will check
         * that the task fits with cpu's capacity.

For your patch, the fast path is irrelevant. I cared at one point
because I was looking at the hit rate for recent_cpu_used so any
improvement there would reduce the number of runqueues scanned in
select_idle_[core|cpu|smt].


> >> I thought SIS Scanned was supposed to be decreased but it seems not on your side.
> >>
> > 
> > It *should* have been decreased but it's indicating that more runqueues
> > were scanned with the patch. It should be noted that the scan count is
> > naturally variable because the depth of each individual search is variable.
> 
> I'm confused here, I saw 4 places to increase sis_scanned, so what's the difference
> between "SIS Domain Scanned" and "SIS scanned"?
> 

Domain scanned is the scans within select_idle_[core|cpu|smt]. SIS scanned
accounts for the checking of prev, target and recent. Your patch does
not care about the fast path which is perfectly fine. The fast path is
only really relevant when modifying how p->recent_used_cpu is used.

However, there should be some evidence that the patch reduces the amount
of scanning even it's workload-specific.

> >> I printed some trace log on my side by uperf workload, and it looks properly.
> >> To make the log easy to read, I started a 4 VCPU VM to run 2-second uperf 8 threads.
> >>
> >> stage 1: system idle, update_idle_cpumask is called from idle thread, set cpumask to 0-3
> >> ========================================================================================
> >>           <idle>-0       [002] d..1   137.408681: update_idle_cpumask: set_idle-1, cpumask: 2
> >>           <idle>-0       [000] d..1   137.408713: update_idle_cpumask: set_idle-1, cpumask: 0,2
> >>           <idle>-0       [003] d..1   137.408924: update_idle_cpumask: set_idle-1, cpumask: 0,2-3
> >>           <idle>-0       [001] d..1   137.409035: update_idle_cpumask: set_idle-1, cpumask: 0-3
> >>
> > 
> > What's the size of the LLC domain on this machine? If it's 4 then this
> > is indicating that there is little difference between scanning the full
> > domain and targetting idle CPUs via the idle cpumask.
> 
> But idle cpumask saves 4 loops of scanning runqueue everytime select_idle_cpu().
> 

I don't follow. If sds_idle_cpus(sd->shared) == sched_domain_span(sd)
then there are no savings.

> > It's the timing of the clear that may be problematic. For the
> > configurations I use, the tick is every 4 milliseconds which is a very
> > long time in the scheduler for communicating workloads. A simple
> > round-trip of perf pipe where tasks will be entering/exiting rapidly is
> > just 0.004 milliseconds on my desktop.
> 
> Agreed, but that's not the case this patch targeted. The target of this
> patch is the system load is heavy enough so that idle thread has no chance
> to be scheduled.
> 

That's somewhat more marginal as a benefit but fair enough. I took a
closer look at the scan rates for 320 clients which loads the machine
fairly heavily. mpstat is reported 0% idle time but the domain scanned
with or without the patch is almost identical which hints that scans were
not avoided. As I write this, hackbench has not executed yet to see if
it makes a difference but it's in the queue.

> > I agree that it should never be worse/bigger but if the idle cpu mask is
> > often the same bits as the sched_domain_span then it's not going to be
> > any better either.
> > 
> 
> At least on my side, v5 is easier to see the benefit, as rapidly entering
> and exiting idle will make idle governor to retain the tick, v5 uses stop_tick
> signal from idle governor to decide if this CPU is added to idle cpumask.
> https://lore.kernel.org/lkml/20201118043113.53128-1-aubrey.li@linux.intel.com/
> 
> But as Vincent and Peter concerned, v5 may break the latency sensitive workload.
> Also the short idle definition need more work.
> 

Indeed, this is why I was advocating an approach that would use the idle
CPU mask as a hint to quickly find idle CPUs but still fall through
the scan the rest of the domain if necessary. That would cover the
"latency sensitive" workload situation because a deeper scan still
happens if necessary. While I'm not 100% certain, they were probably
thinking about schbench which favours deep searches for idle CPUs and is
latency sensitive.

The prequisite patch to make that approach work was rejected though
as on its own, it's not very helpful and Vincent didn't like that the
load_balance_mask was abused to make it effective.

-- 
Mel Gorman
SUSE Labs
