Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756092D4083
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgLILAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:00:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:36037 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgLILAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:00:22 -0500
IronPort-SDR: RA3GdOa9d7Cgs2h4RzjE1HZkpitqMFxZpsyjlhTWxytBzlxTbah1GCuLJUap4V5lPvD1LVpJ09
 2eCzUuFP/a3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153867202"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="153867202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 02:58:36 -0800
IronPort-SDR: CPCxkLmChPoM5e4QFmYfcGOW5yUiFtnaK0ITNI0OTtEZeuCo84sss8H6Zj74JbXmGAUyZs+JTy
 xCsoi2mfqTvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="368142995"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 02:58:33 -0800
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        mgorman@techsingularity.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209081541.GA5071@vingu-book>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <1e68b6fe-2f22-2fbd-3f6b-645994854918@linux.intel.com>
Date:   Wed, 9 Dec 2020 18:58:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201209081541.GA5071@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 16:15, Vincent Guittot wrote:
> Le mercredi 09 déc. 2020 à 14:24:04 (+0800), Aubrey Li a écrit :
>> Add idle cpumask to track idle cpus in sched domain. Every time
>> a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
>> target. And if the CPU is not in idle, the CPU is cleared in idle
>> cpumask during scheduler tick to ratelimit idle cpumask update.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has lower cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
>> Benchmarks including hackbench, schbench, uperf, sysbench mysql
>> and kbuild were tested on a x86 4 socket system with 24 cores per
>> socket and 2 hyperthreads per core, total 192 CPUs, no regression
>> found.
>>
>> v6->v7:
>> - place the whole idle cpumask mechanism under CONFIG_SMP.
>>
>> v5->v6:
>> - decouple idle cpumask update from stop_tick signal, set idle CPU
>>   in idle cpumask every time the CPU enters idle
>>
>> v4->v5:
>> - add update_idle_cpumask for s2idle case
>> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
>>   idle_cpumask() everywhere
>>
>> v3->v4:
>> - change setting idle cpumask from every idle entry to tickless idle
>>   if cpu driver is available.
>> - move clearing idle cpumask to scheduler_tick to decouple nohz mode.
>>
>> v2->v3:
>> - change setting idle cpumask to every idle entry, otherwise schbench
>>   has a regression of 99th percentile latency.
>> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>>   idle cpumask is ratelimited in the idle exiting path.
>> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
>>
>> v1->v2:
>> - idle cpumask is updated in the nohz routines, by initializing idle
>>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>>   behavior.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Qais Yousef <qais.yousef@arm.com>
>> Cc: Valentin Schneider <valentin.schneider@arm.com>
>> Cc: Jiang Biao <benbjiang@gmail.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  include/linux/sched/topology.h | 13 +++++++++
>>  kernel/sched/core.c            |  2 ++
>>  kernel/sched/fair.c            | 51 +++++++++++++++++++++++++++++++++-
>>  kernel/sched/idle.c            |  5 ++++
>>  kernel/sched/sched.h           |  4 +++
>>  kernel/sched/topology.c        |  3 +-
>>  6 files changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 820511289857..b47b85163607 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>>  	atomic_t	ref;
>>  	atomic_t	nr_busy_cpus;
>>  	int		has_idle_cores;
>> +	/*
>> +	 * Span of all idle CPUs in this domain.
>> +	 *
>> +	 * NOTE: this field is variable length. (Allocated dynamically
>> +	 * by attaching extra space to the end of the structure,
>> +	 * depending on how many CPUs the kernel has booted up with)
>> +	 */
>> +	unsigned long	idle_cpus_span[];
>>  };
>>  
>> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
>> +{
>> +	return to_cpumask(sds->idle_cpus_span);
>> +}
>> +
>>  struct sched_domain {
>>  	/* These fields must be setup */
>>  	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c4da7e17b906..c4c51ff3402a 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4011,6 +4011,7 @@ void scheduler_tick(void)
>>  
>>  #ifdef CONFIG_SMP
>>  	rq->idle_balance = idle_cpu(cpu);
>> +	update_idle_cpumask(cpu, false);
> 
> Test rq->idle_balance here instead of adding the test in update_idle_cpumask which is only
> relevant for this situation.

If called from idle path, because !set_idle is false, rq->idle_balance won't be tested actually.

	if (!set_idle && rq->idle_balance)
		return;

So is it okay to leave it here to keep scheduler_tick a bit concise?

Thanks,
-Aubrey
