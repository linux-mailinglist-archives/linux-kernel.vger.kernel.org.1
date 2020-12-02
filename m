Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C622CBFCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgLBOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:32:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:32669 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgLBOcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:32:12 -0500
IronPort-SDR: vkgq9b3AyGQLFVUFeENJ3vV8o6JJnP5+fGlOU+2axtV0LGRx6uGb0nhI1Yk3ddA7KKahTGEl3N
 baAZe83Hb3gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="173120250"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="173120250"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 06:30:08 -0800
IronPort-SDR: T5wWgpB6WpXmWrwJRVL0w/sI1U1rgD/Pjqzx2vxCcxgKtgZYk2sTHM9Tu8J87AINCCmNV6cGsi
 i3WPCOWcwgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="373518407"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2020 06:30:00 -0800
Subject: Re: [sched/fair] 8d86968ac3: netperf.Throughput_tps -29.5% regression
To:     Mel Gorman <mgorman@techsingularity.net>
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
References: <20201125090923.GA3723@shao2-debian>
 <6fef3fc7-be18-92e5-c622-add6decb88c4@linux.intel.com>
 <20201126121351.GJ3371@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <b45171de-cb74-bf35-91bf-967dbd5567d1@linux.intel.com>
Date:   Wed, 2 Dec 2020 22:29:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201126121351.GJ3371@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On 2020/11/26 20:13, Mel Gorman wrote:
> On Thu, Nov 26, 2020 at 02:57:07PM +0800, Li, Aubrey wrote:
>> Hi Robot,
>>
>> On 2020/11/25 17:09, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -29.5% regression of netperf.Throughput_tps due to commit:
>>>
>>>
>>> commit: 8d86968ac36ea5bff487f70b5ffc252a87d44c51 ("[RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for task wakeup")
>>> url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20201118-115145
>>> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576
>>
>> I tried to replicate this on my side on a 192 threads(with SMT) machine as well and didn't see the regression.
>>
>> nr_threads		v5.9.8		+patch
>> 96(50%)			1 (+/- 2.499%)	1.007672(+/- 3.0872%)
>>
>> I also tested another 100% case and see similar improvement as what I saw on uperf benchmark
>>
>> nr_threads		v5.9.8		+patch
>> 192(100%)		1 (+/- 45.32%)	1.864917(+/- 23.29%)
>>
>> My base is v5.9.8 BTW.
>>
>>> 	ip: ipv4
>>> 	runtime: 300s
>>> 	nr_threads: 50%
>>> 	cluster: cs-localhost
>>> 	test: UDP_RR
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x5003003
>>>
> 
> Note that I suspect that regressions with this will be tricky to reproduce
> because it'll depend on the timing of when the idle mask gets updated. With
> this configuration there are 50% "threads" which likely gets translates
> into 1 client/server per thread or 100% of CPUs active but as it's a
> ping-pong workload, the pairs are rapidly idling for very short periods.

I tried to replicate this regression but no solid fruit found. I tried 30 times
300s 50%.netperf running, all the data are better than the default data. The only
interesting thing I found is an option CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y,
but it performs different on different machines. In case anything I missed,
do you have any suggestions to replicate this regression?

> 
> If the idle mask is not getting cleared then select_idle_cpu() is
> probably returning immediately. select_idle_core() is almost certainly
> failing so that just leaves select_idle_smt() to find a potentially idle
> CPU. That's a limited search space so tasks may be getting stacked and
> missing CPUs that are idling for short periods.

Vincent suggested we decouple idle cpumask from short idle(stop tick) and
set it every time the CPU enters idle, I'll make this change in V6.

> 
> On the flip side, I expect cases like hackbench to benefit because it
> can saturate a machine to such a degree that select_idle_cpu() is a waste
> of time.

Yes, I believe that's also why I saw uperf/netperf improvement at high
load levels.

> 
> That said, I haven't followed the different versions closely. I know v5
> got a lot of feedback so will take a closer look at v6. Fundamentally
> though I expect that using the idle mask will be a mixed bag. At low
> utilisation or over-saturation, it'll be a benefit. At the point where
> the machine is almost fully busy, some workloads will benefit (lightly
> communicating workloads that occasionally migrate) and others will not
> (ping-pong workloads looking for CPUs that are idle for very brief
> periods).

Do you have any interested workload [matrix] I can do the measurement?

> 
> It's tricky enough that it might benefit from a sched_feat() check that
> is default true so it gets tested. For regressions that show up, it'll
> be easy enough to ask for the feature to be disabled to see if it fixes
> it. Over time, that might give an idea of exactly what sort of workloads
> benefit and what suffers.

Okay, I'll add a sched_feat() for this feature.

> 
> Note that the cost of select_idle_cpu() can also be reduced by enabling
> SIS_AVG_CPU so it would be interesting to know if the idle mask is superior
> or inferior to SIS_AVG_CPU for workloads that show regressions.
> 

Thanks,
-Aubrey
