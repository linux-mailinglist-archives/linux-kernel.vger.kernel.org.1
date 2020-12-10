Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD67E2D556C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgLJIZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:25:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:3792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgLJIZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:25:37 -0500
IronPort-SDR: GStM8Y4SqUhjc3fsE65lUB3mMlRVlXGjn+SVVYK/3FSoIl1zI7uvvCCOGsj9sbJAyftpfOk3k7
 t5hGFZbhVjow==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="192529671"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="192529671"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 00:23:51 -0800
IronPort-SDR: zHMoffL7/FQFQmqCWWwLfZq6bPHnkx3E+Bu1Tyk0wSmCceOi5gJvnrlXWXuvaCPCDCunyDADbp
 aa60Ao7kDHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="368715609"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2020 00:23:48 -0800
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
Date:   Thu, 10 Dec 2020 16:23:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201209143510.GO3371@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On 2020/12/9 22:36, Mel Gorman wrote:
> On Wed, Dec 09, 2020 at 02:24:04PM +0800, Aubrey Li wrote:
>> Add idle cpumask to track idle cpus in sched domain. Every time
>> a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
>> target. And if the CPU is not in idle, the CPU is cleared in idle
>> cpumask during scheduler tick to ratelimit idle cpumask update.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has lower cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
>> Benchmarks including hackbench, schbench, uperf, sysbench mysql
>> and kbuild were tested on a x86 4 socket system with 24 cores per
>> socket and 2 hyperthreads per core, total 192 CPUs, no regression
>> found.
>>
> 
> I ran this patch with tbench on top of of the schedstat patches that
> track SIS efficiency. The tracking adds overhead so it's not a perfect
> performance comparison but the expectation would be that the patch reduces
> the number of runqueues that are scanned

Thanks for the measurement! I don't play with tbench so may need a while
to digest the data.

> 
> tbench4
>                           5.10.0-rc6             5.10.0-rc6
>                       schedstat-v1r1          idlemask-v7r1
> Hmean     1        504.76 (   0.00%)      500.14 *  -0.91%*
> Hmean     2       1001.22 (   0.00%)      970.37 *  -3.08%*
> Hmean     4       1930.56 (   0.00%)     1880.96 *  -2.57%*
> Hmean     8       3688.05 (   0.00%)     3537.72 *  -4.08%*
> Hmean     16      6352.71 (   0.00%)     6439.53 *   1.37%*
> Hmean     32     10066.37 (   0.00%)    10124.65 *   0.58%*
> Hmean     64     12846.32 (   0.00%)    11627.27 *  -9.49%*
> Hmean     128    22278.41 (   0.00%)    22304.33 *   0.12%*
> Hmean     256    21455.52 (   0.00%)    20900.13 *  -2.59%*
> Hmean     320    21802.38 (   0.00%)    21928.81 *   0.58%*
> 
> Not very optimistic result. The schedstats indicate;

How many client threads was the following schedstats collected?

> 
>                                 5.10.0-rc6     5.10.0-rc6
>                             schedstat-v1r1  idlemask-v7r1
> Ops TTWU Count               5599714302.00  5589495123.00
> Ops TTWU Local               2687713250.00  2563662550.00
> Ops SIS Search               5596677950.00  5586381168.00
> Ops SIS Domain Search        3268344934.00  3229088045.00
> Ops SIS Scanned             15909069113.00 16568899405.00
> Ops SIS Domain Scanned      13580736097.00 14211606282.00
> Ops SIS Failures             2944874939.00  2843113421.00
> Ops SIS Core Search           262853975.00   311781774.00
> Ops SIS Core Hit              185189656.00   216097102.00
> Ops SIS Core Miss              77664319.00    95684672.00
> Ops SIS Recent Used Hit       124265515.00   146021086.00
> Ops SIS Recent Used Miss      338142547.00   403547579.00
> Ops SIS Recent Attempts       462408062.00   549568665.00
> Ops SIS Search Efficiency            35.18          33.72
> Ops SIS Domain Search Eff            24.07          22.72
> Ops SIS Fast Success Rate            41.60          42.20
> Ops SIS Success Rate                 47.38          49.11
> Ops SIS Recent Success Rate          26.87          26.57
> 
> The field I would expect to decrease is SIS Domain Scanned -- the number
> of runqueues that were examined but it's actually worse and graphing over
> time shows it's worse for the client thread counts.  select_idle_cpu()
> is definitely being called because "Domain Search" is 10 times higher than
> "Core Search" and there "Core Miss" is non-zero.

Why SIS Domain Scanned can be decreased?

I thought SIS Scanned was supposed to be decreased but it seems not on your side.

I printed some trace log on my side by uperf workload, and it looks properly.
To make the log easy to read, I started a 4 VCPU VM to run 2-second uperf 8 threads.

stage 1: system idle, update_idle_cpumask is called from idle thread, set cpumask to 0-3
========================================================================================
          <idle>-0       [002] d..1   137.408681: update_idle_cpumask: set_idle-1, cpumask: 2
          <idle>-0       [000] d..1   137.408713: update_idle_cpumask: set_idle-1, cpumask: 0,2
          <idle>-0       [003] d..1   137.408924: update_idle_cpumask: set_idle-1, cpumask: 0,2-3
          <idle>-0       [001] d..1   137.409035: update_idle_cpumask: set_idle-1, cpumask: 0-3

stage 2: uperf ramp up, cpumask changes back and forth
========================================================
           uperf-561     [003] d..3   137.410620: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d..5   137.411384: select_task_rq_fair: scanning: 0-3
    kworker/u8:3-110     [000] d..4   137.411436: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d.h1   137.412562: update_idle_cpumask: set_idle-0, cpumask: 1-3
           uperf-570     [002] d.h2   137.412580: update_idle_cpumask: set_idle-0, cpumask: 1,3
          <idle>-0       [002] d..1   137.412917: update_idle_cpumask: set_idle-1, cpumask: 1-3
          <idle>-0       [000] d..1   137.413004: update_idle_cpumask: set_idle-1, cpumask: 0-3
           uperf-560     [000] d..5   137.415856: select_task_rq_fair: scanning: 0-3
    kworker/u8:3-110     [001] d..4   137.415956: select_task_rq_fair: scanning: 0-3
            sshd-504     [003] d.h1   137.416562: update_idle_cpumask: set_idle-0, cpumask: 0-2
           uperf-560     [000] d.h1   137.416598: update_idle_cpumask: set_idle-0, cpumask: 1-2
          <idle>-0       [003] d..1   137.416638: update_idle_cpumask: set_idle-1, cpumask: 1-3
          <idle>-0       [000] d..1   137.417076: update_idle_cpumask: set_idle-1, cpumask: 0-3
    tmux: server-528     [001] d.h.   137.448566: update_idle_cpumask: set_idle-0, cpumask: 0,2-3
          <idle>-0       [001] d..1   137.448980: update_idle_cpumask: set_idle-1, cpumask: 0-3

stage 3: uperf running, select_idle_cpu scan all the CPUs in the scheduler domain at the beginning
===================================================================================================
           uperf-560     [000] d..3   138.418494: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d..3   138.418506: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d..3   138.418514: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] dN.3   138.418534: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] dN.3   138.418543: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] dN.3   138.418551: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418577: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418600: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418617: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418640: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418652: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418662: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418672: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d..5   138.418676: select_task_rq_fair: scanning: 0-3
           uperf-561     [003] d..3   138.418693: select_task_rq_fair: scanning: 0-3
    kworker/u8:3-110     [002] d..4   138.418746: select_task_rq_fair: scanning: 0-3

stage 4: scheduler tick comes, update idle cpumask to EMPTY
============================================================
           uperf-572     [002] d.h.   139.420568: update_idle_cpumask: set_idle-0, cpumask: 1,3
           uperf-574     [000] d.H2   139.420568: update_idle_cpumask: set_idle-0, cpumask: 1,3
           uperf-565     [003] d.H6   139.420569: update_idle_cpumask: set_idle-0, cpumask: 1
    tmux: server-528     [001] d.h2   139.420572: update_idle_cpumask: set_idle-0, cpumask: 


stage 5: uperf continue running, select_idle_cpu does not scan idle cpu
========================================================================
<I only run 2 seconds uperf, during this two seconds, no idle cpu in cpumask to scan>

           uperf-565     [003] d.sa   139.420587: select_task_rq_fair: scanning: 
           uperf-572     [002] d.sa   139.420670: select_task_rq_fair: scanning: 
	   ............
           uperf-561     [003] d..5   141.421620: select_task_rq_fair: scanning: 
           uperf-571     [001] d.sa   141.421630: select_task_rq_fair: scanning: 

stage 6: uperf benchmark finished, idle thread switch on 
=========================================================

          <idle>-0       [002] d..1   141.421631: update_idle_cpumask: set_idle-1, cpumask: 2
          <idle>-0       [000] d..1   141.421654: update_idle_cpumask: set_idle-1, cpumask: 0,2
          <idle>-0       [001] d..1   141.421665: update_idle_cpumask: set_idle-1, cpumask: 0-2
           uperf-561     [003] d..5   141.421712: select_task_rq_fair: scanning: 0-2
          <idle>-0       [003] d..1   141.421807: update_idle_cpumask: set_idle-1, cpumask: 0-3


stage 7: uperf ramp down
==========================
           uperf-560     [000] d..5   141.423075: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d..5   141.423107: select_task_rq_fair: scanning: 0-3
           uperf-560     [000] d..5   141.423259: select_task_rq_fair: scanning: 0-3
    tmux: server-528     [002] d..5   141.730489: select_task_rq_fair: scanning: 1-3
    kworker/u8:1-96      [003] d..4   141.731924: select_task_rq_fair: scanning: 1-3
          <idle>-0       [000] d..1   141.734560: update_idle_cpumask: set_idle-1, cpumask: 0-3
    tmux: server-528     [002] d.h1   141.736568: update_idle_cpumask: set_idle-0, cpumask: 0-1
        uperf.sh-558     [003] d.h.   141.736570: update_idle_cpumask: set_idle-0, cpumask: 0-1
          <idle>-0       [002] d..1   141.736718: update_idle_cpumask: set_idle-1, cpumask: 0-2
          <idle>-0       [003] d..1   141.738179: update_idle_cpumask: set_idle-1, cpumask: 0-3
           pkill-578     [001] d.h1   141.740569: update_idle_cpumask: set_idle-0, cpumask: 0,2-3
          <idle>-0       [001] d..1   141.741875: update_idle_cpumask: set_idle-1, cpumask: 0-3
           pkill-578     [001] d.h.   141.744570: update_idle_cpumask: set_idle-0, cpumask: 0,2-3
           pkill-578     [001] d..6   141.770012: select_task_rq_fair: scanning: 0,2-3
          <idle>-0       [001] d..1   141.770938: update_idle_cpumask: set_idle-1, cpumask: 0-3

In this case, SIS Scanned should be decreased. I'll apply your schedstat patch to see if
the data matches.

> 
> I suspect the issue is that the mask is only marked busy from the tick
> context which is a very wide window. If select_idle_cpu() picks an idle
> CPU from the mask, it's still marked as idle in the mask.
> 
That should be fine because we still check available_idle_cpu() and sched_idle_cpu for the selected
CPU. And even if that CPU is marked as idle in the mask, that mask should not be worse(bigger) than
the default sched_domain_span(sd).

Thanks,
-Aubrey
