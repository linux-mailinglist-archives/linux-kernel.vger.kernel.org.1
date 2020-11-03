Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83F2A49FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgKCPgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:36:23 -0500
Received: from foss.arm.com ([217.140.110.172]:50738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgKCPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:36:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF4A7139F;
        Tue,  3 Nov 2020 07:36:22 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5313F66E;
        Tue,  3 Nov 2020 07:36:20 -0800 (PST)
Subject: Re: [PATCH v3] sched/fair: prefer prev cpu in asymmetric wakeup path
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        ouwen210@hotmail.com
References: <20201029161824.26389-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <67e245f8-eff3-98e2-68aa-04376f886385@arm.com>
Date:   Tue, 3 Nov 2020 16:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029161824.26389-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2020 17:18, Vincent Guittot wrote:

[...]

> - On hikey960 with performance governor (EAS disable)
> 
> ./perf bench sched pipe -T -l 50000
>              mainline           w/ patch
> # migrations   999364                  0
> ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%
> 
> - On hikey with performance governor
> 
> ./perf bench sched pipe -T -l 50000
>              mainline           w/ patch
> # migrations        0                  0
> ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%

Tested on hikey960 (big cluster 0xf0) with perf gov on tip sched/core +
patch) and defconfig plus:

# CONFIG_ARM_CPUIDLE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_HISI_THERMAL is not set

and for 'w/ uclamp' tests:

CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
CONFIG_UCLAMP_TASK_GROUP=y

(a) perf stat -n -r 20 taskset 0xf0 perf bench sched pipe -T -l 50000

(b) perf stat -n -r 20 -- cgexec -g cpu:A/B taskset 0xf0 perf bench
sched pipe -T -l 50000


(1) w/o uclamp

(a) w/o patch: 0.392850 +- 0.000289 seconds time elapsed  ( +-  0.07% )

    w/  patch: 0.330786 +- 0.000401 seconds time elapsed  ( +-  0.12% )

(b) w/o patch: 0.414644 +- 0.000375 seconds time elapsed  ( +-  0.09% )

    w/  patch: 0.353113 +- 0.000393 seconds time elapsed  ( +-  0.11% )

(2) w/ uclamp

(a) w/o patch: 0.393781 +- 0.000488 seconds time elapsed  ( +-  0.12% )

    w/  patch: 0.342726 +- 0.000661 seconds time elapsed  ( +-  0.19% )

(b) w/o patch: 0.416645 +- 0.000520 seconds time elapsed  ( +-  0.12% )

    w/  patch: 0.358098 +- 0.000577 seconds time elapsed  ( +-  0.16% )

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> According to test on hikey, the patch doesn't impact symmetric system
> compared to current implementation (only tested on arm64)
> 
> Also read the uclamped value of task's utilization at most twice instead
> instead each time we compare task's utilization with cpu's capacity.

task_util could be passed into select_idle_capacity() avoiding the
second call to uclamp_task_util()?

With this I see a small improvement for (a)

(3) w/ uclamp and passing task_util into sic()

(a) w/  patch: 0.337032 +- 0.000564 seconds time elapsed  ( +-  0.17% )

(b) w/  patch: 0.358467 +- 0.000381 seconds time elapsed  ( +-  0.11% )

[...]

> -symmetric:
> -	if (available_idle_cpu(target) || sched_idle_cpu(target))
> +	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +	    asym_fits_capacity(task_util, target))
>  		return target;

Braces because of multi-line condition ?

>  	/*
>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>  	 */
>  	if (prev != target && cpus_share_cache(prev, target) &&
> -	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
> +	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> +	    asym_fits_capacity(task_util, prev))
>  		return prev;

and here ...

[...]
