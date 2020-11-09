Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA432ABCC8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgKINlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:41:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:11429 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbgKINk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:40:58 -0500
IronPort-SDR: YrSQtN7vrYkfRbZzwSu39zgosuX5Qn1gkBv+fAucw9lDrPvvYcGhXM8bwAHjcpi/L9YlqT+uji
 lGQvVjNyI6kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="157584247"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="157584247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 05:40:57 -0800
IronPort-SDR: D6YgWnXjOxShnY3DR102hLYVn2bpvcltymB2il0g1WBNOqEDDy020WZcC/SewaYReIHvYh5gEO
 YrnFF2GjxDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="365047005"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Nov 2020 05:40:54 -0800
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
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ac73a9e2-8cc0-b1fe-fc2b-14b9cb21c8bf@linux.intel.com>
Date:   Mon, 9 Nov 2020 21:40:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <jhj1rh6yygz.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/7 5:20, Valentin Schneider wrote:
> 
> On 21/10/20 16:03, Aubrey Li wrote:
>> From: Aubrey Li <aubrey.li@intel.com>
>>
>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>> enters idle, its corresponding bit in the idle cpumask will be set,
>> and when the CPU exits idle, its bit will be cleared.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has low cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
> 
> FWIW I gave this a spin on my arm64 desktop (Ampere eMAG, 32 core). I get
> some barely noticeable (AIUI not statistically significant for bench sched)
> changes for 100 iterations of:
> 
> | bench                              | metric   |   mean |     std |    q90 |    q99 |
> |------------------------------------+----------+--------+---------+--------+--------|
> | hackbench --loops 5000 --groups 1  | duration | -1.07% |  -2.23% | -0.88% | -0.25% |
> | hackbench --loops 5000 --groups 2  | duration | -0.79% | +30.60% | -0.49% | -0.74% |
> | hackbench --loops 5000 --groups 4  | duration | -0.54% |  +6.99% | -0.21% | -0.12% |
> | perf bench sched pipe -T -l 100000 | ops/sec  | +1.05% |  -2.80% | -0.17% | +0.39% |
> 
> q90 & q99 being the 90th and 99th percentile.
> 
> Base was tip/sched/core at:
> d8fcb81f1acf ("sched/fair: Check for idle core in wake_affine")

Thanks for the data, Valentin! So does the negative value mean improvement?

If so the data looks expected to me. As we set idle cpumask every time we
enter idle, but only clear it at the tick frequency, so if the workload
is not heavy enough, there could be a lot of idle during two ticks, so idle
cpumask is almost equal to sched_domain_span(sd), which makes no difference.

But if the system load is heavy enough, CPU has few/no chance to enter idle,
then idle cpumask can be cleared during tick, which makes the bit number in 
sds_idle_cpus(sd->shared) far less than the bit number in sched_domain_span(sd)
if llc domain has large count of CPUs.

For example, if I run 4 x overcommit uperf on a system with 192 CPUs, 
I observed:
- default, the average of this_sd->avg_scan_cost is 223.12ns
- patch, the average of this_sd->avg_scan_cost is 63.4ns

And select_idle_cpu is called 7670253 times per second, so for every CPU the
scan cost is saved (223.12 - 63.4) * 7670253 / 192 = 6.4ms. As a result, I
saw uperf thoughput improved by 60+%.

Thanks,
-Aubrey

 
 




