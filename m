Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFDF2C413B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgKYNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:37:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:16056 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgKYNhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:37:33 -0500
IronPort-SDR: bTNSbS4clprfdVyNEu33NNJ+FJJxCzdF7l7dFMspUqoUcDFvSrgE25rNGnRS966IBr0sqIBzGK
 9N+ux59xLEWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172230441"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="172230441"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 05:37:32 -0800
IronPort-SDR: QwF5jqOI+ydOG6AYmXr2xWzhmu1T5wdLNGd1fPlzyzDYzH8sQqW7bceX35P3P3RK9O3T87+D1u
 JP0BHxTqnykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="370858270"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2020 05:37:29 -0800
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
 <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com>
 <20201124170136.GA26613@vingu-book>
 <67a14568-4fa5-d9b4-d2fc-72a22c226189@linux.intel.com>
 <CAKfTPtB5=VSkE3YQf5igi6rBFPUSua=hM2FEnvBnRpF9n4VYwg@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <2a715c5d-c93f-0e5f-8b1a-83803cb6def6@linux.intel.com>
Date:   Wed, 25 Nov 2020 21:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB5=VSkE3YQf5igi6rBFPUSua=hM2FEnvBnRpF9n4VYwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/25 16:31, Vincent Guittot wrote:
> On Wed, 25 Nov 2020 at 03:03, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/11/25 1:01, Vincent Guittot wrote:
>>> Hi Aubrey,
>>>
>>> Le mardi 24 nov. 2020 à 15:01:38 (+0800), Li, Aubrey a écrit :
>>>> Hi Vincent,
>>>>
>>>> On 2020/11/23 17:27, Vincent Guittot wrote:
>>>>> Hi Aubrey,
>>>>>
>>>>> On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>>>>>
>>>>>> Add idle cpumask to track idle cpus in sched domain. When a CPU
>>>>>> enters idle, if the idle driver indicates to stop tick, this CPU
>>>>>> is set in the idle cpumask to be a wakeup target. And if the CPU
>>>>>> is not in idle, the CPU is cleared in idle cpumask during scheduler
>>>>>> tick to ratelimit idle cpumask update.
>>>>>>
>>>>>> When a task wakes up to select an idle cpu, scanning idle cpumask
>>>>>> has low cost than scanning all the cpus in last level cache domain,
>>>>>> especially when the system is heavily loaded.
>>>>>>
>>>>>> Benchmarks were tested on a x86 4 socket system with 24 cores per
>>>>>> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
>>>>>> schbench have no notable change, uperf has:
>>>>>>
>>>>>> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
>>>>>>
>>>>>>   threads       baseline-avg    %std    patch-avg       %std
>>>>>>   96            1               0.83    1.23            3.27
>>>>>>   144           1               1.03    1.67            2.67
>>>>>>   192           1               0.69    1.81            3.59
>>>>>>   240           1               2.84    1.51            2.67
>>>>>>
>>>>>> v4->v5:
>>>>>> - add update_idle_cpumask for s2idle case
>>>>>> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
>>>>>>   idle_cpumask() everywhere
>>>>>>
>>>>>> v3->v4:
>>>>>> - change setting idle cpumask from every idle entry to tickless idle
>>>>>>   if cpu driver is available.
>>>>>
>>>>> Could you remind me why you did this change ? Clearing the cpumask is
>>>>> done during the tick to rate limit the number of updates of the
>>>>> cpumask but It's not clear for me why you have associated the set with
>>>>> the tick stop condition too.
>>>>
>>>> I found the current implementation has better performance at a more
>>>> suitable load range.
>>>>
>>>> The two kinds of implementions(v4 and v5) have the same rate(scheduler
>>>> tick) to shrink idle cpumask when the system is busy, but
>>>
>>> I'm ok with the part above
>>>
>>>>
>>>> - Setting the idle mask everytime the cpu enters idle requires a much
>>>> heavier load level to preserve the idle cpumask(not call into idle),
>>>> otherwise the bits cleared in scheduler tick will be restored when the
>>>> cpu enters idle. That is, idle cpumask is almost equal to the domain
>>>> cpumask during task wakeup if the system load is not heavy enough.
>>>
>>> But setting the idle cpumask is useful because it helps to select an idle
>>> cpu at wake up instead of waiting ifor ILB to fill the empty CPU. IMO,
>>> the idle cpu mask is useful in heavy cases because a system, which is
>>> already fully busy with work, doesn't want to waste time looking for an
>>> idle cpu that doesn't exist.
>>
>> Yes, this is what v3 does.
>>
>>> But if there is an idle cpu, we should still looks for it.
>>
>> IMHO, this is a potential opportunity can be improved. The idle cpu could be
>> in different idle state, the idle duration could be long or could be very short.
>> For example, if there are two idle cpus:
>>
>> - CPU1 is very busy, the pattern is 50us idle and 950us work.
>> - CPU2 is in idle for a tick length and wake up to do the regular work
>>
>> If both added to the idle cpumask, we want the latter one, or we can just add
>> the later one into the idle cpumask. That's why I want to associate tick stop
>> signal with it.
>>
>>>
>>>>
>>>>
>>>> - Associating with tick stop tolerates idle to preserve the idle cpumask
>>>> but only short idle, which causes tick retains. This is more fitable for
>>>> the real workload.
>>>
>>> I don't agree with this and real use cases with interaction will probably
>>> not agree as well as they want to run on an idle cpu if any but not wait
>>> on an already busy one.
>>
>> The problem is scan overhead, scanning idle cpu need time. If an idle cpu
>> is in the short idle mode, it's very likely that when it's picked up for a
>> wakeup task, it goes back to work again, and the wakeup task has to wait too,
>> maybe longer because the running task just starts.
>>
>> One benefit of waiting on the previous one is warm cache.
>>
>>> Also keep in mind that a tick can be up to 10ms long
>>
>> Right, but the point here is, if this 10ms tick retains, the CPU should be
>> in the short idle mode.
> 
> But 10, 4 or even 1ms is quite long for a system and that's even more
> true compared to scanning the idle cpu mask
> 
>>
>>>
>>>>
>>>>>
>>>>> This change means that a cpu will not be part of the idle mask if the
>>>>> tick is not stopped. On some arm/arm64 platforms, the tick stops only
>>>>> if the idle duration is expected to be higher than 1-2ms which starts
>>>>> to be significantly long. Also, the cpuidle governor can easily
>>>>> mis-predict a short idle duration whereas it will be finally a long
>>>>> idle duration; In this case, the next tick will correct the situation
>>>>> and select a deeper state, but this can happen up to 4ms later on
>>>>> arm/arm64.
>>>>
>>>> Yes this is intented. If the tick is not stopped, that indicates the
>>>> CPU is very busy, cpu idle governor selected the polling idle state, and/or
>>>> the expected idle duration is shorter than the tick period length. For
>>>
>>> As mentioned above a tick can be up to 10ms long which is not a short idle
>>> duration.
>>
>> Usually when the tick retains, the CPU is in the short idle mode or even polling
>> instead of idle.
> 
> Also keep in mind that cpuidle can select a shallow state and retains
> tick because of the wake up latency constraint and not the idle
> duration. So you can't really make the assumption that retaining tick
> means short idle duration
> 
idle governor has short idle information, probably can let idle governor
expose a short idle indicator?

>>
>>>
>>> Then the governor also mispredicts the idle duration and this is one
>>> reason that the tick is not stopped because it will give the opportunity
>>> to reevaluate the idle state in case of misprediction.
>>>
>> We always predict the next state based on the past states, so misprediction
>> does happen. This is not what this patch is trying to solve. I'm certainly
> 
> My point here was to say that one original goal of cpuidle for
> retaining the tick was to handle case where the governor mispredicts a
> short idle time. Retaining the tick prevents the cpu to stay too long
> in this shallow idle state and to waste power which seems to happen
> often enough to be raised by people

I see, thanks!

> 
>> open if there is a better signal instead of stop_tick from idle governor.
>>
>>
>>>> example, uperf enters and exits 80 times between two ticks when utilizes
>>>> 100% CPU, and the average idle residency < 50us.
>>>
>>> But scheduler looks for idle state of prev cpu before looping the idle cpu
>>> mask so i'm not sure that uperf is impacted in this case because scheduler
>>> will select prev cpu before loop idle cpu mask.
>>>
>>>>
>>>> If this CPU is added to idle cpumask, the wakeup task likely needs to
>>>> wait in the runqueue as this CPU will run its current task very soon.
>>>>
>>>>>
>>>>> So I would prefer to keep trying to set the idle mask everytime the
>>>>> cpu enters idle. If a tick has not happened between 2 idle phases, the
>>>>> cpumask will not be updated and the overhead will be mostly testing if
>>>>> (rq->last_idle_state == idle_state).
>>>>
>>>> Not sure if I addressed your concern, did you see any workloads any cases
>>>> v4 performs better than v5?
>>>
>>> Yes, I see some perf regression on my octo arm64 system for hackbench with
>>> only 1 group (and for few ther ones but it's less obvious). There is no
>>> perf impact with more groups most probably because the cpus are no more idle.
>>>
>>> The regression happens even if the shallowest idle state is the only one to
>>> be enabled.
>>
>> Thanks for the data.
>>
>>>
>>> - 2 x 4 cores arm64 system
>>>
>>> 12 iterations of hackbench -l (256000/#grp) -g #grp
>>>
>>> Only the shallowest state enabled
>>
>>> (as a sidenote, we don't have polling mode on arm64)
>> Okay, this might be the cause of the difference between yours and mine. So do you
>> think if it makes sense to let idle governor to return a polling flag and associate
>> it with idle cpumask update instead of stop_tick? A CPU is idle but actually polling
>> may not be suitable for the wake up target.
> 
> I don't know much about polling but can't this mode be used up to a tick too ?
>I think so. So short idle need a definition. I'm not sure if it's a good idea to define
the short idle as a tunable and default set it to tick >> 2?

Updating idle cpumask everytime cpu enters idle works for me, as we have state change
check, so we won't actually update idle cpumask everytime the cpu enters idle.

But I'm still willing to exclude short idle case, what do you think?

Thanks,
-Aubrey


