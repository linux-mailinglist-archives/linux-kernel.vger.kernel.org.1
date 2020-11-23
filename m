Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB02C13C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgKWSjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:39:21 -0500
Received: from foss.arm.com ([217.140.110.172]:36202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgKWSjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:39:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 504E8101E;
        Mon, 23 Nov 2020 10:39:19 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73CF73F70D;
        Mon, 23 Nov 2020 10:39:17 -0800 (PST)
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
 <4ea72740-e724-ce20-b6d8-b6cea7c8c370@arm.com>
 <CAKfTPtCS6rVawFLQ=XGqtySRZuqO-WnbGJQnMvAFVsqFQ7xmAg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a704c408-652c-9d05-f67d-d21e83d9213e@arm.com>
Date:   Mon, 23 Nov 2020 19:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCS6rVawFLQ=XGqtySRZuqO-WnbGJQnMvAFVsqFQ7xmAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2020 14:42, Vincent Guittot wrote:
> On Mon, 23 Nov 2020 at 12:27, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 23/11/2020 11:05, Vincent Guittot wrote:
>>> On Mon, 23 Nov 2020 at 10:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 20/11/2020 09:56, Peter Zijlstra wrote:
>>>>> On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:

[...]

>> I thought the question was whether 'runnable_avg = 1.5 x
>> SCHED_CAPACITY_SCALE' is a good threshold to decide to drive frequency
>> by runnable_avg or util_avg.
> 
> we can't use SCHED_CAPACITY_SCALE and must use cpu's capacity

To get some idle time on the LITTLE CPU I extended the time in which
task3 and then task2-3 run on CPU5 to 128ms.

The moment CPU4 has some idle time for the first time after the first
migration (~207ms), the runnable_avg drops from 1323 (task0: 316,
task1: 1020) to 1.
I can't see the dependency to the CPU capacity here.
Util_avg is also larger than the CPU capacity.

The steep fall from runnable=1323 to 1 is due to lost_idle_time update.

...
migration/4-29 [004] 60.000034: sched_migrate_task: comm=task3-3 pid=1690 prio=101 orig_cpu=4 dest_cpu=5
migration/4-29 [004] 60.000046: sched_pelt_cfs:     cpu=4 path=/ load=163618 runnable=2296 util=748
...
migration/4-29 [004] 60.142088: sched_migrate_task: comm=task2-2 pid=1689 prio=101 orig_cpu=4 dest_cpu=5
migration/4-29 [004] 60.142100: sched_pelt_cfs:     cpu=4 path=/ load=93358 runnable=1325 util=628
...
task0-0-1687   [004] 60.201385: sched_pelt_se:      cpu=4 path=(null) comm=task0-0 pid=1687 load=22317 runnable=316 util=316
task0-0-1687   [004] 60.201387: sched_pelt_cfs:     cpu=4 path=/ load=93978 runnable=1336 util=788
...
task1-1-1688   [004] 60.207225: sched_pelt_se:      cpu=4 path=(null) comm=task1-1 pid=1688 load=71610 runnable=1020 util=497
task1-1-1688   [004] 60.207227: sched_pelt_cfs:     cpu=4 path=/ load=93017 runnable=1323 util=800
 <idle>-0      [004] 60.207254: cpu_idle:           state=0 cpu_id=4
...
 <idle>-0      [004] 60.209397: sched_pelt_cfs:     cpu=4 path=/ load=80 runnable=1 util=0
...
