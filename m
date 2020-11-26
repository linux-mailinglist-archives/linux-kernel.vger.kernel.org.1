Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624962C53BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbgKZMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:13:56 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:43377 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgKZMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:13:55 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 618E01C26
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:13:53 +0000 (GMT)
Received: (qmail 9453 invoked from network); 26 Nov 2020 12:13:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2020 12:13:52 -0000
Date:   Thu, 26 Nov 2020 12:13:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        0day robot <lkp@intel.com>, Mel Gorman <mgorman@suse.de>,
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
Message-ID: <20201126121351.GJ3371@techsingularity.net>
References: <20201125090923.GA3723@shao2-debian>
 <6fef3fc7-be18-92e5-c622-add6decb88c4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6fef3fc7-be18-92e5-c622-add6decb88c4@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:57:07PM +0800, Li, Aubrey wrote:
> Hi Robot,
> 
> On 2020/11/25 17:09, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -29.5% regression of netperf.Throughput_tps due to commit:
> > 
> > 
> > commit: 8d86968ac36ea5bff487f70b5ffc252a87d44c51 ("[RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for task wakeup")
> > url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20201118-115145
> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576
> 
> I tried to replicate this on my side on a 192 threads(with SMT) machine as well and didn't see the regression.
> 
> nr_threads		v5.9.8		+patch
> 96(50%)			1 (+/- 2.499%)	1.007672(+/- 3.0872%)
> 
> I also tested another 100% case and see similar improvement as what I saw on uperf benchmark
> 
> nr_threads		v5.9.8		+patch
> 192(100%)		1 (+/- 45.32%)	1.864917(+/- 23.29%)
> 
> My base is v5.9.8 BTW.
> 
> > 	ip: ipv4
> > 	runtime: 300s
> > 	nr_threads: 50%
> > 	cluster: cs-localhost
> > 	test: UDP_RR
> > 	cpufreq_governor: performance
> > 	ucode: 0x5003003
> > 

Note that I suspect that regressions with this will be tricky to reproduce
because it'll depend on the timing of when the idle mask gets updated. With
this configuration there are 50% "threads" which likely gets translates
into 1 client/server per thread or 100% of CPUs active but as it's a
ping-pong workload, the pairs are rapidly idling for very short periods.

If the idle mask is not getting cleared then select_idle_cpu() is
probably returning immediately. select_idle_core() is almost certainly
failing so that just leaves select_idle_smt() to find a potentially idle
CPU. That's a limited search space so tasks may be getting stacked and
missing CPUs that are idling for short periods.

On the flip side, I expect cases like hackbench to benefit because it
can saturate a machine to such a degree that select_idle_cpu() is a waste
of time.

That said, I haven't followed the different versions closely. I know v5
got a lot of feedback so will take a closer look at v6. Fundamentally
though I expect that using the idle mask will be a mixed bag. At low
utilisation or over-saturation, it'll be a benefit. At the point where
the machine is almost fully busy, some workloads will benefit (lightly
communicating workloads that occasionally migrate) and others will not
(ping-pong workloads looking for CPUs that are idle for very brief
periods).

It's tricky enough that it might benefit from a sched_feat() check that
is default true so it gets tested. For regressions that show up, it'll
be easy enough to ask for the feature to be disabled to see if it fixes
it. Over time, that might give an idea of exactly what sort of workloads
benefit and what suffers.

Note that the cost of select_idle_cpu() can also be reduced by enabling
SIS_AVG_CPU so it would be interesting to know if the idle mask is superior
or inferior to SIS_AVG_CPU for workloads that show regressions.

-- 
Mel Gorman
SUSE Labs
