Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F1A2D2DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgLHPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:12:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:26639 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgLHPMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:12:34 -0500
IronPort-SDR: 6pVoTXdFm4skvka5dI4y5Tq+ieisrC4zMO6f5ZQ1tF7/9AqnL4UXGyjEVe2uSxw9clRFN048Gv
 4ASrAhlxDFbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="174018791"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="174018791"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 07:10:47 -0800
IronPort-SDR: jfUUQQ3AEXQYOYeIdpVIGrFb9UAW5A2vb76HfGQxWU9NnbFUNzugsI2XufvlaB4AE4KizGglEE
 as79HCYAgR6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="375983047"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2020 07:10:44 -0800
Subject: Re: [RFC PATCH v6] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
References: <20201208014957.170845-1-aubrey.li@linux.intel.com>
 <20201208141610.GA2414@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ee5a833c-19a6-d0b5-fbd3-2564012d21ec@linux.intel.com>
Date:   Tue, 8 Dec 2020 23:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201208141610.GA2414@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for the comments.

On 2020/12/8 22:16, Peter Zijlstra wrote:
> On Tue, Dec 08, 2020 at 09:49:57AM +0800, Aubrey Li wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c4da7e17b906..b8af602dea79 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3999,6 +3999,7 @@ void scheduler_tick(void)
>>  	rq_lock(rq, &rf);
>>  
>>  	update_rq_clock(rq);
>> +	update_idle_cpumask(rq, false);
> 
> Does that really need to be done with rq->lock held?> 
>>  	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
>>  	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> 
>> @@ -6808,6 +6813,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>  }
>>  #endif /* CONFIG_SMP */
>>  
>> +/*
>> + * Update cpu idle state and record this information
>> + * in sd_llc_shared->idle_cpus_span.
>> + */
>> +void update_idle_cpumask(struct rq *rq, bool set_idle)
>> +{
>> +	struct sched_domain *sd;
>> +	int cpu = cpu_of(rq);
>> +	int idle_state;
>> +
>> +	/*
>> +	 * If called from scheduler tick, only update
>> +	 * idle cpumask if the CPU is busy, as idle
>> +	 * cpumask is also updated on idle entry.
>> +	 *
>> +	 */
>> +	if (!set_idle && idle_cpu(cpu))
>> +		return;
> 
> scheduler_tick() already calls idle_cpu() when SMP.
> 
>> +	/*
>> +	 * Also set SCHED_IDLE cpu in idle cpumask to
>> +	 * allow SCHED_IDLE cpu as a wakeup target
>> +	 */
>> +	idle_state = set_idle || sched_idle_cpu(cpu);
>> +	/*
>> +	 * No need to update idle cpumask if the state
>> +	 * does not change.
>> +	 */
>> +	if (rq->last_idle_state == idle_state)
>> +		return;
>> +
>> +	rcu_read_lock();
> 
> This is called with IRQs disabled, surely we can forgo rcu_read_lock()
> here.
> 
>> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
>> +	if (!sd || !sd->shared)
>> +		goto unlock;
> 
> I don't think !sd->shared is possible here.
> 
>> +	if (idle_state)
>> +		cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
>> +	else
>> +		cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
>> +
>> +	rq->last_idle_state = idle_state;
>> +unlock:
>> +	rcu_read_unlock();
>> +}
>> +
>>  static unsigned long wakeup_gran(struct sched_entity *se)
>>  {
>>  	unsigned long gran = sysctl_sched_wakeup_granularity;
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index f324dc36fc43..f995660edf2b 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -156,6 +156,11 @@ static void cpuidle_idle_call(void)
>>  		return;
>>  	}
>>  
>> +	/*
>> +	 * The CPU is about to go idle, set it in idle cpumask
>> +	 * to be a wake up target.
>> +	 */
>> +	update_idle_cpumask(this_rq(), true);
> 
> This should be in do_idle(), right around arch_cpu_idle_enter().
> 
>>  	/*
>>  	 * The RCU framework needs to be told that we are entering an idle
>>  	 * section, so no more rcu read side critical sections and one more
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 8d1ca65db3b0..db460b20217a 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1004,6 +1004,7 @@ struct rq {
>>  	/* This is used to determine avg_idle's max value */
>>  	u64			max_idle_balance_cost;
>>  #endif /* CONFIG_SMP */
>> +	unsigned char		last_idle_state;
> 
> All of that is pointless for UP. Also, is this the best location?
> 
Good point, I should put all of these under SMP. I'll refine the patch soon.

Thanks,
-Aubrey
