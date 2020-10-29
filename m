Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98529EA53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgJ2LQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:16:54 -0400
Received: from foss.arm.com ([217.140.110.172]:32852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgJ2LQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:16:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71BFB13A1;
        Thu, 29 Oct 2020 04:16:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048BE3F66E;
        Thu, 29 Oct 2020 04:16:48 -0700 (PDT)
References: <20201028174412.680-1-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com, ouwen210@hotmail.com
Subject: Re: [PATCH v2] sched/fair: prefer prev cpu in asymmetric wakeup path
In-reply-to: <20201028174412.680-1-vincent.guittot@linaro.org>
Date:   Thu, 29 Oct 2020 11:16:43 +0000
Message-ID: <jhjk0v9p9ic.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

On 28/10/20 17:44, Vincent Guittot wrote:
> During fast wakeup path, scheduler always check whether local or prev cpus
> are good candidates for the task before looking for other cpus in the
> domain. With
>   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> the heterogenous system gains a dedicated path but doesn't try to reuse
> prev cpu whenever possible. If the previous cpu is idle and belong to the
> LLC domain, we should check it 1st before looking for another cpu because
> it stays one of the best candidate and this also stabilizes task placement
> on the system.
>
> This change aligns asymmetric path behavior with symmetric one and reduces
> cases where the task migrates across all cpus of the sd_asym_cpucapacity
> domains at wakeup.
>
> This change does not impact normal EAS mode but only the overloaded case or
> when EAS is not used.
>
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
>
> According to test on hikey, the patch doesn't impact symmetric system
> compared to current implementation (only tested on arm64)
>
> Also read the uclamped value of task's utilization at most twice instead
> instead each time we compare task's utilization with cpu's capacity.
>
> Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Other than the below, I quite like this!

> ---
> Changes in v2:
> - merge asymmetric and symmetric path instead of duplicating tests on target,
>   prev and other special cases.
>
> - factorize call to uclamp_task_util(p) and use fits_capacity(). This could
>   explain part of the additionnal improvement compared to v1 (+22% instead of
>   +17% on v1).
>
> - Keep using LLC instead of asym domain for early check of target, prev and
>   recent_used_cpu to ensure cache sharing between the task. This doesn't
>   change anything for dynamiQ but will ensure same cache for legacy big.LITTLE
>   and also simply the changes.
>

On legacy big.LITTLE systems, sd_asym_cpucapacity spans all CPUs, so we
would iterate over those in select_idle_capacity() anyway - the policy
we've been going for is that capacity fitness trumps cache use.

This does require the system to have a decent interconnect, cache snooping
& co, but that is IMO a requirement of any sane asymmetric system.

To put words into code, this is the kind of check I would see:

  if (static_branch_unlikely(&sched_asym_cpucapacity))
        return fits_capacity(task_util, capacity_of(cpu));
  else
        return cpus_share_cache(cpu, other);

> - don't check capacity for the per-cpu kthread UC because the assumption is
>   that the wakee queued work for the per-cpu kthread that is now complete and
>   the task was already on this cpu.
>
> - On an asymmetric system where an exclusive cpuset defines a symmetric island,
>   task's load is synced and tested although it's not needed. But taking care of
>   this special case by testing if sd_asym_cpucapacity is not null impacts by
>   more than 4% the performance of default sched_asym_cpucapacity path.
>
> - The huge increase of the number of migration for hikey960 mainline comes from
>   teh fact that the ftrace buffer was overloaded by events in the tests done
>   with v1.
