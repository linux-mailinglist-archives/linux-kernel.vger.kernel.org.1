Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B02E2C1E97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgKXHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:01:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:16136 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgKXHBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:01:42 -0500
IronPort-SDR: caO22spLb6M8GFMuL8NLkJ2zD02jfHaMriKIyvL133/mdUhlKICKqkNVNV+PbluN84U5+DtdYu
 Jp9jp7DGil8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="169337023"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="169337023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 23:01:41 -0800
IronPort-SDR: b2bLmAdGqOhrtGX3dWji5SHFnsh/xjrxC73RYBUHJYKGNFGFpPZxVGKbTTiofquoPqaIpX9gAc
 a5pRPwKFHcag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="370317854"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2020 23:01:38 -0800
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com>
Date:   Tue, 24 Nov 2020 15:01:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 2020/11/23 17:27, Vincent Guittot wrote:
> Hi Aubrey,
> 
> On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>
>> Add idle cpumask to track idle cpus in sched domain. When a CPU
>> enters idle, if the idle driver indicates to stop tick, this CPU
>> is set in the idle cpumask to be a wakeup target. And if the CPU
>> is not in idle, the CPU is cleared in idle cpumask during scheduler
>> tick to ratelimit idle cpumask update.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has low cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
>> Benchmarks were tested on a x86 4 socket system with 24 cores per
>> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
>> schbench have no notable change, uperf has:
>>
>> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
>>
>>   threads       baseline-avg    %std    patch-avg       %std
>>   96            1               0.83    1.23            3.27
>>   144           1               1.03    1.67            2.67
>>   192           1               0.69    1.81            3.59
>>   240           1               2.84    1.51            2.67
>>
>> v4->v5:
>> - add update_idle_cpumask for s2idle case
>> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
>>   idle_cpumask() everywhere
>>
>> v3->v4:
>> - change setting idle cpumask from every idle entry to tickless idle
>>   if cpu driver is available.
> 
> Could you remind me why you did this change ? Clearing the cpumask is
> done during the tick to rate limit the number of updates of the
> cpumask but It's not clear for me why you have associated the set with
> the tick stop condition too.

I found the current implementation has better performance at a more 
suitable load range.

The two kinds of implementions(v4 and v5) have the same rate(scheduler
tick) to shrink idle cpumask when the system is busy, but

- Setting the idle mask everytime the cpu enters idle requires a much
heavier load level to preserve the idle cpumask(not call into idle),
otherwise the bits cleared in scheduler tick will be restored when the
cpu enters idle. That is, idle cpumask is almost equal to the domain
cpumask during task wakeup if the system load is not heavy enough.

- Associating with tick stop tolerates idle to preserve the idle cpumask
but only short idle, which causes tick retains. This is more fitable for
the real workload.

> 
> This change means that a cpu will not be part of the idle mask if the
> tick is not stopped. On some arm/arm64 platforms, the tick stops only
> if the idle duration is expected to be higher than 1-2ms which starts
> to be significantly long. Also, the cpuidle governor can easily
> mis-predict a short idle duration whereas it will be finally a long
> idle duration; In this case, the next tick will correct the situation
> and select a deeper state, but this can happen up to 4ms later on
> arm/arm64.

Yes this is intented. If the tick is not stopped, that indicates the
CPU is very busy, cpu idle governor selected the polling idle state, and/or 
the expected idle duration is shorter than the tick period length. For
example, uperf enters and exits 80 times between two ticks when utilizes
100% CPU, and the average idle residency < 50us.

If this CPU is added to idle cpumask, the wakeup task likely needs to 
wait in the runqueue as this CPU will run its current task very soon.

> 
> So I would prefer to keep trying to set the idle mask everytime the
> cpu enters idle. If a tick has not happened between 2 idle phases, the
> cpumask will not be updated and the overhead will be mostly testing if
> (rq->last_idle_state == idle_state).

Not sure if I addressed your concern, did you see any workloads any cases
v4 performs better than v5?

Thanks,
-Aubrey

> 
> 
>> - move clearing idle cpumask to scheduler_tick to decouple nohz mode.
>>
>> v2->v3:
>> - change setting idle cpumask to every idle entry, otherwise schbench
>>   has a regression of 99th percentile latency.
>> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>>   idle cpumask is ratelimited in the idle exiting path.
>> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
>>
>> v1->v2:
>> - idle cpumask is updated in the nohz routines, by initializing idle
>>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>>   behavior.
>>
