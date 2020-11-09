Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E12AB114
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 07:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgKIGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 01:05:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:50830 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgKIGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:05:22 -0500
IronPort-SDR: bTp+YyRqYxYjoK5IpKjwzmDHTnBGagLRPxA7QUAk+U+5eBpxKDxIVnbw6n73x8NLH3f+LYl1aZ
 JaezMS2u3l2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="169907283"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="169907283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 22:05:22 -0800
IronPort-SDR: yqh3Xy3eA+4+wmSOlO20YB3mvb6hwPl4wiFRmAP2d69jg01070JRlGdfkBMBpRARtYFYsyIqiO
 Pq2/Qt0KKteg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="364922628"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2020 22:05:18 -0800
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
 <CAKfTPtAPdagXddz9tHj_hfg_R1R+E6uYcWX+zdbBLgCd4QQE2w@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <0f64fde7-51f1-b9e8-31ec-35f0de473fdc@linux.intel.com>
Date:   Mon, 9 Nov 2020 14:05:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAPdagXddz9tHj_hfg_R1R+E6uYcWX+zdbBLgCd4QQE2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/6 15:58, Vincent Guittot wrote:
> On Wed, 21 Oct 2020 at 17:05, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>>
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
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Qais Yousef <qais.yousef@arm.com>
>> Cc: Valentin Schneider <valentin.schneider@arm.com>
>> Cc: Jiang Biao <benbjiang@gmail.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  include/linux/sched/topology.h | 13 ++++++++++
>>  kernel/sched/fair.c            | 45 +++++++++++++++++++++++++++++++++-
>>  kernel/sched/idle.c            |  1 +
>>  kernel/sched/sched.h           |  1 +
>>  kernel/sched/topology.c        |  3 ++-
>>  5 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index fb11091129b3..43a641d26154 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>>         atomic_t        ref;
>>         atomic_t        nr_busy_cpus;
>>         int             has_idle_cores;
>> +       /*
>> +        * Span of all idle CPUs in this domain.
>> +        *
>> +        * NOTE: this field is variable length. (Allocated dynamically
>> +        * by attaching extra space to the end of the structure,
>> +        * depending on how many CPUs the kernel has booted up with)
>> +        */
>> +       unsigned long   idle_cpus_span[];
>>  };
>>
>> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
>> +{
>> +       return to_cpumask(sds->idle_cpus_span);
>> +}
>> +
>>  struct sched_domain {
>>         /* These fields must be setup */
>>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6b3b59cc51d6..088d1995594f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6023,6 +6023,38 @@ void __update_idle_core(struct rq *rq)
>>         rcu_read_unlock();
>>  }
>>
>> +static DEFINE_PER_CPU(bool, cpu_idle_state);
>> +/*
>> + * Update cpu idle state and record this information
>> + * in sd_llc_shared->idle_cpus_span.
>> + */
>> +void update_idle_cpumask(struct rq *rq, bool idle_state)
>> +{
>> +       struct sched_domain *sd;
>> +       int cpu = cpu_of(rq);
>> +
>> +       /*
>> +        * No need to update idle cpumask if the state
>> +        * does not change.
>> +        */
>> +       if (per_cpu(cpu_idle_state, cpu) == idle_state)
>> +               return;
>> +
>> +       per_cpu(cpu_idle_state, cpu) = idle_state;
>> +
>> +       rcu_read_lock();
>> +
>> +       sd = rcu_dereference(per_cpu(sd_llc, cpu));
>> +       if (!sd || !sd->shared)
>> +               goto unlock;
>> +       if (idle_state)
>> +               cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
>> +       else
>> +               cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
>> +unlock:
>> +       rcu_read_unlock();
>> +}
>> +
>>  /*
>>   * Scan the entire LLC domain for idle cores; this dynamically switches off if
>>   * there are no idle cores left in the system; tracked through
>> @@ -6136,7 +6168,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>
>>         time = cpu_clock(this);
>>
>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +       /*
>> +        * sched_domain_shared is set only at shared cache level,
>> +        * this works only because select_idle_cpu is called with
>> +        * sd_llc.
>> +        */
>> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
>>
>>         for_each_cpu_wrap(cpu, cpus, target) {
>>                 if (!--nr)
>> @@ -10070,6 +10107,12 @@ static void nohz_balancer_kick(struct rq *rq)
>>         if (unlikely(rq->idle_balance))
>>                 return;
>>
>> +       /* The CPU is not in idle, update idle cpumask */
>> +       if (unlikely(sched_idle_cpu(cpu))) {
>> +               /* Allow SCHED_IDLE cpu as a wakeup target */
>> +               update_idle_cpumask(rq, true);
>> +       } else
>> +               update_idle_cpumask(rq, false);
> 
> update_idle_cpumask(rq, sched_idle_cpu(cpu)); ?

This looks much better, thanks! :)
