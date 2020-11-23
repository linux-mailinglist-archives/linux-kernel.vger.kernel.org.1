Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD02C0489
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgKWL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:27:41 -0500
Received: from foss.arm.com ([217.140.110.172]:43174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgKWL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:27:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A8DF30E;
        Mon, 23 Nov 2020 03:27:40 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808133F70D;
        Mon, 23 Nov 2020 03:27:38 -0800 (PST)
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201120085653.GA3092@hirez.programming.kicks-ass.net>
 <66650f6a-0a95-706f-58cc-3cd241e30dda@arm.com>
 <CAKfTPtBtiweSfErgQ3ZVw9HB2Q7b=V4uoGS2dbaqY1KNz6kUhA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4ea72740-e724-ce20-b6d8-b6cea7c8c370@arm.com>
Date:   Mon, 23 Nov 2020 12:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBtiweSfErgQ3ZVw9HB2Q7b=V4uoGS2dbaqY1KNz6kUhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2020 11:05, Vincent Guittot wrote:
> On Mon, 23 Nov 2020 at 10:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 20/11/2020 09:56, Peter Zijlstra wrote:
>>> On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
>>>>  - In saturated scenarios task movement will cause some transient dips,
>>>>    suppose we have a CPU saturated with 4 tasks, then when we migrate a task
>>>>    to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
>>>>    new CPU will gain 0.25. This is inevitable and time progression will
>>>>    correct this. XXX do we still guarantee f_max due to no idle-time?
>>>
>>> Do we want something like this? Is the 1.5 threshold sane? (it's been too
>>> long since I looked at actual numbers here)
>>
>> Did some tests on a big.little system:
>>
>>  (1) rt-app workload on big CPU:
>>
>>  - task0-3 (runtime/period=4000us/16000us, started with
>>    4000us delay to each other) run on CPU1
>>  - then task3 migrates to CPU2 and runs there for 64ms
>>  - then task2 migrates to CPU2 too and both tasks run there
>>    for another 64ms
>>
>> ...
>>     task3-3-1684  [001]  3982.798729: sched_pelt_cfs:       cpu=1 path=/ load=232890 runnable=3260 util=1011
>> migration/1-14    [001]  3982.798756: sched_migrate_task:   comm=task3-3 pid=1684 prio=101 orig_cpu=1 dest_cpu=2*
>> migration/1-14    [001]  3982.798767: sched_pelt_cfs:       cpu=1 path=/ load=161374 runnable=2263 util=*700* <-- util dip !!!
>>     task1-1-1682  [001]  3982.799802: sched_pelt_cfs:       cpu=1 path=/ load=160988 runnable=2257 util=706
>> ...
>>     task2-2-1683  [001]  3982.849123: sched_pelt_cfs:       cpu=1 path=/ load=161124 runnable=2284 util=904
>>     task2-2-1683  [001]  3982.851960: sched_pelt_cfs:       cpu=1 path=/ load=160130 runnable=2271 util=911
>> migration/1-14    [001]  3982.851984: sched_migrate_task:   comm=task2-2 pid=1683 prio=101 orig_cpu=1 dest_cpu=2**
>> migration/1-14    [001]  3982.851995: sched_pelt_cfs:       cpu=1 path=/ load=88672 runnable=*1257* util=512 <-- runnable below 1536
>>     task1-1-1682  [001]  3982.852983: sched_pelt_cfs:       cpu=1 path=/ load=88321 runnable=1252 util=521
>> ...
>>
>>
>> *  task1,2,3 remain on CPU1 and still have to catch up, no idle
>>    time on CPU1
>>
>> ** task 1,2 remain on CPU1, there is idle time on CPU1!
>>
>>
>> (2) rt-app workload on LITTLE CPU (orig cpu_capacity: 446)
>>
>>  - task0-3 (runtime/period=1742us/16000us, started with
>>    4000us delay to each other) run on CPU4
>>  - then task3 migrates to CPU5 and runs there for 64ms
>>  - then task2 migrates to CPU5 too and both tasks run there
>>    for another 64ms
>>
>> ...
>>     task1-1-1777  [004]   789.443015: sched_pelt_cfs:       cpu=4 path=/ load=234718 runnable=3018 util=976
>> migration/4-29    [004]   789.444718: sched_migrate_task:   comm=task3-3 pid=1779 prio=101 orig_cpu=4 dest_cpu=5*
>> migration/4-29    [004]   789.444739: sched_pelt_cfs:       cpu=4 path=/ load=163543 runnable=2114 util=*778* <--util dip !!!
>>     task2-2-1778  [004]   789.447013: sched_pelt_cfs:       cpu=4 path=/ load=163392 runnable=2120 util=777
>> ...
>>     task1-1-1777  [004]   789.507012: sched_pelt_cfs:       cpu=4 path=/ load=164482 runnable=2223 util=879
>> migration/4-29    [004]   789.508023: sched_migrate_task:   comm=task2-2 pid=1778 prio=101 orig_cpu=4 dest_cpu=5**
>> migration/4-29    [004]   789.508044: sched_pelt_cfs:       cpu=4 path=/ load=94099 runnable=*1264* util=611 <-- runnable below 1536
>>     task0-0-1776  [004]   789.511011: sched_pelt_cfs:       cpu=4 path=/ load=93898 runnable=1264 util=622
>> ...
>>
>> *  task1,2,3 remain on CPU1 and still have to catch up, no idle
>>    time on CPU1
>>
>> ** task 1,2 remain on CPU1, no idle time on CPU1 yet.
>>
>> So for the big CPU, there is idle time and for the LITTLE there
>> isn't with runnable below the threshold.
> 
> I'm not sure to catch what you want to highlight with your tests ?

I thought the question was whether 'runnable_avg = 1.5 x
SCHED_CAPACITY_SCALE' is a good threshold to decide to drive frequency
by runnable_avg or util_avg.

[...]
