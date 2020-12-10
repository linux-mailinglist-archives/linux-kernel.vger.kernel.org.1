Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A148F2D5958
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgLJLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:37:26 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:55941 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389235AbgLJLfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:35:41 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id A60941C379B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:34:43 +0000 (GMT)
Received: (qmail 11179 invoked from network); 10 Dec 2020 11:34:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Dec 2020 11:34:43 -0000
Date:   Thu, 10 Dec 2020 11:34:41 +0000
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
Message-ID: <20201210113441.GS3371@techsingularity.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 04:23:47PM +0800, Li, Aubrey wrote:
> > I ran this patch with tbench on top of of the schedstat patches that
> > track SIS efficiency. The tracking adds overhead so it's not a perfect
> > performance comparison but the expectation would be that the patch reduces
> > the number of runqueues that are scanned
> 
> Thanks for the measurement! I don't play with tbench so may need a while
> to digest the data.
> 

They key point is that it appears the idle mask was mostly equivalent to
the full domain mask, at least for this test.

> > 
> > tbench4
> >                           5.10.0-rc6             5.10.0-rc6
> >                       schedstat-v1r1          idlemask-v7r1
> > Hmean     1        504.76 (   0.00%)      500.14 *  -0.91%*
> > Hmean     2       1001.22 (   0.00%)      970.37 *  -3.08%*
> > Hmean     4       1930.56 (   0.00%)     1880.96 *  -2.57%*
> > Hmean     8       3688.05 (   0.00%)     3537.72 *  -4.08%*
> > Hmean     16      6352.71 (   0.00%)     6439.53 *   1.37%*
> > Hmean     32     10066.37 (   0.00%)    10124.65 *   0.58%*
> > Hmean     64     12846.32 (   0.00%)    11627.27 *  -9.49%*
> > Hmean     128    22278.41 (   0.00%)    22304.33 *   0.12%*
> > Hmean     256    21455.52 (   0.00%)    20900.13 *  -2.59%*
> > Hmean     320    21802.38 (   0.00%)    21928.81 *   0.58%*
> > 
> > Not very optimistic result. The schedstats indicate;
> 
> How many client threads was the following schedstats collected?
> 

That's the overall summary for all client counts. While proc-schedstat
was measured every few seconds over all client counts, presenting that
in text format is not easy to parse. However, looking at the graphs over
time, it did not appear that scan rates were consistently lower for any
client count for tbench.

> > 
> >                                 5.10.0-rc6     5.10.0-rc6
> >                             schedstat-v1r1  idlemask-v7r1
> > Ops TTWU Count               5599714302.00  5589495123.00
> > Ops TTWU Local               2687713250.00  2563662550.00
> > Ops SIS Search               5596677950.00  5586381168.00
> > Ops SIS Domain Search        3268344934.00  3229088045.00
> > Ops SIS Scanned             15909069113.00 16568899405.00
> > Ops SIS Domain Scanned      13580736097.00 14211606282.00
> > Ops SIS Failures             2944874939.00  2843113421.00
> > Ops SIS Core Search           262853975.00   311781774.00
> > Ops SIS Core Hit              185189656.00   216097102.00
> > Ops SIS Core Miss              77664319.00    95684672.00
> > Ops SIS Recent Used Hit       124265515.00   146021086.00
> > Ops SIS Recent Used Miss      338142547.00   403547579.00
> > Ops SIS Recent Attempts       462408062.00   549568665.00
> > Ops SIS Search Efficiency            35.18          33.72
> > Ops SIS Domain Search Eff            24.07          22.72
> > Ops SIS Fast Success Rate            41.60          42.20
> > Ops SIS Success Rate                 47.38          49.11
> > Ops SIS Recent Success Rate          26.87          26.57
> > 
> > The field I would expect to decrease is SIS Domain Scanned -- the number
> > of runqueues that were examined but it's actually worse and graphing over
> > time shows it's worse for the client thread counts.  select_idle_cpu()
> > is definitely being called because "Domain Search" is 10 times higher than
> > "Core Search" and there "Core Miss" is non-zero.
> 
> Why SIS Domain Scanned can be decreased?
> 

Because if idle CPUs are being targetted and its a subset of the entire
domain then it follows that fewer runqueues should be examined when
scanning the domain.

> I thought SIS Scanned was supposed to be decreased but it seems not on your side.
> 

It *should* have been decreased but it's indicating that more runqueues
were scanned with the patch. It should be noted that the scan count is
naturally variable because the depth of each individual search is variable.

> I printed some trace log on my side by uperf workload, and it looks properly.
> To make the log easy to read, I started a 4 VCPU VM to run 2-second uperf 8 threads.
> 
> stage 1: system idle, update_idle_cpumask is called from idle thread, set cpumask to 0-3
> ========================================================================================
>           <idle>-0       [002] d..1   137.408681: update_idle_cpumask: set_idle-1, cpumask: 2
>           <idle>-0       [000] d..1   137.408713: update_idle_cpumask: set_idle-1, cpumask: 0,2
>           <idle>-0       [003] d..1   137.408924: update_idle_cpumask: set_idle-1, cpumask: 0,2-3
>           <idle>-0       [001] d..1   137.409035: update_idle_cpumask: set_idle-1, cpumask: 0-3
> 

What's the size of the LLC domain on this machine? If it's 4 then this
is indicating that there is little difference between scanning the full
domain and targetting idle CPUs via the idle cpumask.

> stage 3: uperf running, select_idle_cpu scan all the CPUs in the scheduler domain at the beginning
> ===================================================================================================
>            uperf-560     [000] d..3   138.418494: select_task_rq_fair: scanning: 0-3
>            uperf-560     [000] d..3   138.418506: select_task_rq_fair: scanning: 0-3
>            uperf-560     [000] d..3   138.418514: select_task_rq_fair: scanning: 0-3
>            uperf-560     [000] dN.3   138.418534: select_task_rq_fair: scanning: 0-3
>            uperf-560     [000] dN.3   138.418543: select_task_rq_fair: scanning: 0-3
>            uperf-560     [000] dN.3   138.418551: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418577: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418600: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418617: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418640: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418652: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418662: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418672: select_task_rq_fair: scanning: 0-3
>            uperf-560     [000] d..5   138.418676: select_task_rq_fair: scanning: 0-3
>            uperf-561     [003] d..3   138.418693: select_task_rq_fair: scanning: 0-3
>     kworker/u8:3-110     [002] d..4   138.418746: select_task_rq_fair: scanning: 0-3
> 
> stage 4: scheduler tick comes, update idle cpumask to EMPTY
> ============================================================
>            uperf-572     [002] d.h.   139.420568: update_idle_cpumask: set_idle-0, cpumask: 1,3
>            uperf-574     [000] d.H2   139.420568: update_idle_cpumask: set_idle-0, cpumask: 1,3
>            uperf-565     [003] d.H6   139.420569: update_idle_cpumask: set_idle-0, cpumask: 1
>     tmux: server-528     [001] d.h2   139.420572: update_idle_cpumask: set_idle-0, cpumask: 
> 

It's the timing of the clear that may be problematic. For the
configurations I use, the tick is every 4 milliseconds which is a very
long time in the scheduler for communicating workloads. A simple
round-trip of perf pipe where tasks will be entering/exiting rapidly is
just 0.004 milliseconds on my desktop.

> > 
> > I suspect the issue is that the mask is only marked busy from the tick
> > context which is a very wide window. If select_idle_cpu() picks an idle
> > CPU from the mask, it's still marked as idle in the mask.
> > 
> That should be fine because we still check available_idle_cpu() and sched_idle_cpu for the selected
> CPU. And even if that CPU is marked as idle in the mask, that mask should not be worse(bigger) than
> the default sched_domain_span(sd).
> 

I agree that it should never be worse/bigger but if the idle cpu mask is
often the same bits as the sched_domain_span then it's not going to be
any better either.

-- 
Mel Gorman
SUSE Labs
