Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8072AC04A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgKIPys convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 10:54:48 -0500
Received: from foss.arm.com ([217.140.110.172]:42118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIPyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:54:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87BB1042;
        Mon,  9 Nov 2020 07:54:45 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A633F719;
        Mon,  9 Nov 2020 07:54:43 -0800 (PST)
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com> <jhj1rh6yygz.mognet@arm.com> <ac73a9e2-8cc0-b1fe-fc2b-14b9cb21c8bf@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Li\, Aubrey" <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for task wakeup
In-reply-to: <ac73a9e2-8cc0-b1fe-fc2b-14b9cb21c8bf@linux.intel.com>
Date:   Mon, 09 Nov 2020 15:54:36 +0000
Message-ID: <jhjsg9iy18j.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/11/20 13:40, Li, Aubrey wrote:
> On 2020/11/7 5:20, Valentin Schneider wrote:
>>
>> On 21/10/20 16:03, Aubrey Li wrote:
>>> From: Aubrey Li <aubrey.li@intel.com>
>>>
>>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>>> enters idle, its corresponding bit in the idle cpumask will be set,
>>> and when the CPU exits idle, its bit will be cleared.
>>>
>>> When a task wakes up to select an idle cpu, scanning idle cpumask
>>> has low cost than scanning all the cpus in last level cache domain,
>>> especially when the system is heavily loaded.
>>>
>>
>> FWIW I gave this a spin on my arm64 desktop (Ampere eMAG, 32 core). I get
>> some barely noticeable (AIUI not statistically significant for bench sched)
>> changes for 100 iterations of:
>>
>> | bench                              | metric   |   mean |     std |    q90 |    q99 |
>> |------------------------------------+----------+--------+---------+--------+--------|
>> | hackbench --loops 5000 --groups 1  | duration | -1.07% |  -2.23% | -0.88% | -0.25% |
>> | hackbench --loops 5000 --groups 2  | duration | -0.79% | +30.60% | -0.49% | -0.74% |
>> | hackbench --loops 5000 --groups 4  | duration | -0.54% |  +6.99% | -0.21% | -0.12% |
>> | perf bench sched pipe -T -l 100000 | ops/sec  | +1.05% |  -2.80% | -0.17% | +0.39% |
>>
>> q90 & q99 being the 90th and 99th percentile.
>>
>> Base was tip/sched/core at:
>> d8fcb81f1acf ("sched/fair: Check for idle core in wake_affine")
>
> Thanks for the data, Valentin! So does the negative value mean improvement?
>

For hackbench yes (shorter is better); for perf bench sched no, since the
metric here is ops/sec so higher is better.

That said, I (use a tool that) run a 2-sample Kolmogorov–Smirnov test
against the two sample sets (tip/sched/core vs tip/sched/core+patch), and
the p-value for perf sched bench is quite high (~0.9) which means we can't
reject that both sample sets come from the same distribution; long story
short we can't say whether the patch had a noticeable impact for that
benchmark.

> If so the data looks expected to me. As we set idle cpumask every time we
> enter idle, but only clear it at the tick frequency, so if the workload
> is not heavy enough, there could be a lot of idle during two ticks, so idle
> cpumask is almost equal to sched_domain_span(sd), which makes no difference.
>
> But if the system load is heavy enough, CPU has few/no chance to enter idle,
> then idle cpumask can be cleared during tick, which makes the bit number in
> sds_idle_cpus(sd->shared) far less than the bit number in sched_domain_span(sd)
> if llc domain has large count of CPUs.
>

With hackbench -g 4 that's 160 tasks (against 32 CPUs, all under same LLC),
although the work done by each task isn't much. I'll try bumping that a
notch, or increasing the size of the messages.

> For example, if I run 4 x overcommit uperf on a system with 192 CPUs,
> I observed:
> - default, the average of this_sd->avg_scan_cost is 223.12ns
> - patch, the average of this_sd->avg_scan_cost is 63.4ns
>
> And select_idle_cpu is called 7670253 times per second, so for every CPU the
> scan cost is saved (223.12 - 63.4) * 7670253 / 192 = 6.4ms. As a result, I
> saw uperf thoughput improved by 60+%.
>

That's ~1.2s of "extra" CPU time per second, which sounds pretty cool.

I don't think I've ever played with uperf. I'll give that a shot someday.

> Thanks,
> -Aubrey
>
>
>
