Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF75A26CA72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgIPT75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:59:57 -0400
Received: from foss.arm.com ([217.140.110.172]:34564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgIPRfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B21F1147A;
        Wed, 16 Sep 2020 04:40:59 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8D13F68F;
        Wed, 16 Sep 2020 04:40:57 -0700 (PDT)
References: <20200916043103.606132-1-aubrey.li@linux.intel.com> <20200916110039.GG3117@suse.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in sched domain
In-reply-to: <20200916110039.GG3117@suse.de>
Date:   Wed, 16 Sep 2020 12:40:55 +0100
Message-ID: <jhj7dsu54qg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/09/20 12:00, Mel Gorman wrote:
> On Wed, Sep 16, 2020 at 12:31:03PM +0800, Aubrey Li wrote:
>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>> enters idle, its corresponding bit in the idle cpumask will be set,
>> and when the CPU exits idle, its bit will be cleared.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has low cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
>> The following benchmarks were tested on a x86 4 socket system with
>> 24 cores per socket and 2 hyperthreads per core, total 192 CPUs:
>>
>
> This still appears to be tied to turning the tick off. An idle CPU
> available for computation does not necessarily have the tick turned off
> if it's for short periods of time. When nohz is disabled or a machine is
> active enough that CPUs are not disabling the tick, select_idle_cpu may
> fail to select an idle CPU and instead stack tasks on the old CPU.
>

Vincent was pointing out in v1 that we ratelimit nohz_balance_exit_idle()
by having it happen on a tick to prevent being hammered by a flurry of
idle enter / exit sub tick granularity. I'm afraid flipping bits of this
cpumask on idle enter / exit might be too brutal.

> The other subtlety is that select_idle_sibling() currently allows a
> SCHED_IDLE cpu to be used as a wakeup target. The CPU is not really
> idle as such, it's simply running a low priority task that is suitable
> for preemption. I suspect this patch breaks that.

I think you're spot on.

An alternative I see here would be to move this into its own
select_idle_foo() function. If that mask is empty or none of the tagged
CPUs actually pass available_idle_cpu(), we fall-through to the usual idle
searches.

That's far from perfect; you could wake a truly idle CPU instead of
preempting a SCHED_IDLE task on a warm and busy CPU. I'm not sure if a
proliferation of cpumask really is the answer to that...
