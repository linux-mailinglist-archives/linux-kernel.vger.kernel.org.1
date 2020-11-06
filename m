Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5133C2A9EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgKFVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:20:19 -0500
Received: from foss.arm.com ([217.140.110.172]:44882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFVUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:20:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85D61474;
        Fri,  6 Nov 2020 13:20:17 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09AA73F718;
        Fri,  6 Nov 2020 13:20:15 -0800 (PST)
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for task wakeup
Message-ID: <jhj1rh6yygz.mognet@arm.com>
In-reply-to: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
Date:   Fri, 06 Nov 2020 21:20:05 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/10/20 16:03, Aubrey Li wrote:
> From: Aubrey Li <aubrey.li@intel.com>
>
> Added idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, its corresponding bit in the idle cpumask will be set,
> and when the CPU exits idle, its bit will be cleared.
>
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
>

FWIW I gave this a spin on my arm64 desktop (Ampere eMAG, 32 core). I get
some barely noticeable (AIUI not statistically significant for bench sched)
changes for 100 iterations of:

| bench                              | metric   |   mean |     std |    q90 |    q99 |
|------------------------------------+----------+--------+---------+--------+--------|
| hackbench --loops 5000 --groups 1  | duration | -1.07% |  -2.23% | -0.88% | -0.25% |
| hackbench --loops 5000 --groups 2  | duration | -0.79% | +30.60% | -0.49% | -0.74% |
| hackbench --loops 5000 --groups 4  | duration | -0.54% |  +6.99% | -0.21% | -0.12% |
| perf bench sched pipe -T -l 100000 | ops/sec  | +1.05% |  -2.80% | -0.17% | +0.39% |

q90 & q99 being the 90th and 99th percentile.

Base was tip/sched/core at:
d8fcb81f1acf ("sched/fair: Check for idle core in wake_affine")

> v2->v3:
> - change setting idle cpumask to every idle entry, otherwise schbench
>   has a regression of 99th percentile latency.
> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>   idle cpumask is ratelimited in the idle exiting path.
> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
>
> v1->v2:
> - idle cpumask is updated in the nohz routines, by initializing idle
>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>   behavior.
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jiang Biao <benbjiang@gmail.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
