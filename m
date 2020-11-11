Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC02AEC22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgKKIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:38:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:18321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgKKIib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:38:31 -0500
IronPort-SDR: 2zOlFRLopzGhWZgnDcAziytsLbgqyoS2O6kXarqsicFE10rbyXJgGuVJ1f4PBLyCaAk/Z5ld5p
 c3mOEde7ua9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170224919"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="170224919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 00:38:27 -0800
IronPort-SDR: w0pS36efy4F3sOdG4Z8LixG5Wme63Q2ypKqeEJgq9rXQfIBTZZ/3RCv/7snMhbqi5nCjXDvNRN
 IhWBHPYX1skw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="365860938"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2020 00:38:23 -0800
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
 <jhj1rh6yygz.mognet@arm.com>
 <ac73a9e2-8cc0-b1fe-fc2b-14b9cb21c8bf@linux.intel.com>
 <jhjsg9iy18j.mognet@arm.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <dc4e1ab6-b1fa-1a51-b40c-a70bd87a48df@linux.intel.com>
Date:   Wed, 11 Nov 2020 16:38:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <jhjsg9iy18j.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/9 23:54, Valentin Schneider wrote:
> 
> On 09/11/20 13:40, Li, Aubrey wrote:
>> On 2020/11/7 5:20, Valentin Schneider wrote:
>>>
>>> On 21/10/20 16:03, Aubrey Li wrote:
>>>> From: Aubrey Li <aubrey.li@intel.com>
>>>>
>>>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>>>> enters idle, its corresponding bit in the idle cpumask will be set,
>>>> and when the CPU exits idle, its bit will be cleared.
>>>>
>>>> When a task wakes up to select an idle cpu, scanning idle cpumask
>>>> has low cost than scanning all the cpus in last level cache domain,
>>>> especially when the system is heavily loaded.
>>>>
>>>
>>> FWIW I gave this a spin on my arm64 desktop (Ampere eMAG, 32 core). I get
>>> some barely noticeable (AIUI not statistically significant for bench sched)
>>> changes for 100 iterations of:
>>>
>>> | bench                              | metric   |   mean |     std |    q90 |    q99 |
>>> |------------------------------------+----------+--------+---------+--------+--------|
>>> | hackbench --loops 5000 --groups 1  | duration | -1.07% |  -2.23% | -0.88% | -0.25% |
>>> | hackbench --loops 5000 --groups 2  | duration | -0.79% | +30.60% | -0.49% | -0.74% |
>>> | hackbench --loops 5000 --groups 4  | duration | -0.54% |  +6.99% | -0.21% | -0.12% |
>>> | perf bench sched pipe -T -l 100000 | ops/sec  | +1.05% |  -2.80% | -0.17% | +0.39% |
>>>
>>> q90 & q99 being the 90th and 99th percentile.
>>>
>>> Base was tip/sched/core at:
>>> d8fcb81f1acf ("sched/fair: Check for idle core in wake_affine")
>>
>> Thanks for the data, Valentin! So does the negative value mean improvement?
>>
> 
> For hackbench yes (shorter is better); for perf bench sched no, since the
> metric here is ops/sec so higher is better.
> 
> That said, I (use a tool that) run a 2-sample Kolmogorov–Smirnov test
> against the two sample sets (tip/sched/core vs tip/sched/core+patch), and
> the p-value for perf sched bench is quite high (~0.9) which means we can't
> reject that both sample sets come from the same distribution; long story
> short we can't say whether the patch had a noticeable impact for that
> benchmark.
> 
>> If so the data looks expected to me. As we set idle cpumask every time we
>> enter idle, but only clear it at the tick frequency, so if the workload
>> is not heavy enough, there could be a lot of idle during two ticks, so idle
>> cpumask is almost equal to sched_domain_span(sd), which makes no difference.
>>
>> But if the system load is heavy enough, CPU has few/no chance to enter idle,
>> then idle cpumask can be cleared during tick, which makes the bit number in
>> sds_idle_cpus(sd->shared) far less than the bit number in sched_domain_span(sd)
>> if llc domain has large count of CPUs.
>>
> 
> With hackbench -g 4 that's 160 tasks (against 32 CPUs, all under same LLC),
> although the work done by each task isn't much. I'll try bumping that a
> notch, or increasing the size of the messages.

As long as the system is busy enough and not schedule on idle thread, then
idle cpu mask will shrink tick by tick, and we'll see lower sd->avg_scan_cost.

This version of patch sets idle cpu bit every time it enters idle, so need
heavy load for scheduler to not switch idle thread in.

I personally like the logic in the previous version, because in those versions,
- when cpu enters idle, cpuidle governor returns a flag "stop_tick"
- if tick is stopped, which indicates the CPU is not busy, and can be set
  idle in idle cpumask
- otherwise, the CPU is likely going to work very soon, so not set it in
  idle cpumask.

But apparently I missed "nohz=off" case in the previous implementation. For
"nohz=off" case I selected to keep original behavior, which didn't content Mel.
Probably I can refine it in the next version.

Do you have any suggestions?

Thanks,
-Aubrey
