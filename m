Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8B12A63A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKDLx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:53:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:2014 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDLw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:52:27 -0500
IronPort-SDR: eqx+g7s30Wc/9Nau371tKlz/Ud92KiV/aJtZSyG3BkTYwyCzc18ZOFzQ0aZ5Y6+ViLayXKbDTE
 hsPkNRTFkNvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="166613756"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="166613756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 03:52:27 -0800
IronPort-SDR: 7ncpuVVDPmthK2Ha1LadJKAMOHcImbcuboUuE4AURtqTe9gQE2BM4dhers92R1uWpSlza7/xg0
 RuI9MaIW+xtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="363957787"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2020 03:52:23 -0800
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
 <jhjimamz1dv.mognet@arm.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <27f88d6a-302e-2c28-c936-22ac233fe175@linux.intel.com>
Date:   Wed, 4 Nov 2020 19:52:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <jhjimamz1dv.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

Thanks for your reply.

On 2020/11/4 3:27, Valentin Schneider wrote:
> 
> Hi,
> 
> On 21/10/20 16:03, Aubrey Li wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6b3b59cc51d6..088d1995594f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6023,6 +6023,38 @@ void __update_idle_core(struct rq *rq)
>>       rcu_read_unlock();
>>  }
>>
>> +static DEFINE_PER_CPU(bool, cpu_idle_state);
> 
> I would've expected this to be far less compact than a cpumask, but that's
> not the story readelf is telling me. Objdump tells me this is recouping
> some of the padding in .data..percpu, at least with the arm64 defconfig.
> 
> In any case this ought to be better wrt cacheline bouncing, which I suppose
> is what we ultimately want here.

Yes, every CPU has a byte, so it may not be less than a cpumask. Probably I can
put it into struct rq, do you have any better suggestions?

> 
> Also, see rambling about init value below.
> 
>> @@ -10070,6 +10107,12 @@ static void nohz_balancer_kick(struct rq *rq)
>>       if (unlikely(rq->idle_balance))
>>               return;
>>
>> +	/* The CPU is not in idle, update idle cpumask */
>> +	if (unlikely(sched_idle_cpu(cpu))) {
>> +		/* Allow SCHED_IDLE cpu as a wakeup target */
>> +		update_idle_cpumask(rq, true);
>> +	} else
>> +		update_idle_cpumask(rq, false);
> 
> This means that without CONFIG_NO_HZ_COMMON, a CPU going into idle will
> never be accounted as going out of it, right? Eventually the cpumask
> should end up full, which conceptually implements the previous behaviour of
> select_idle_cpu() but in a fairly roundabout way...

Maybe I can move it to scheduler_tick().

> 
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 9079d865a935..f14a6ef4de57 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
>>               sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>>               atomic_inc(&sd->shared->ref);
>>               atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
>> +		cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
> 
> So at init you would have (single LLC for sake of simplicity):
> 
>   \all cpu : cpu_idle_state[cpu]  == false
>   cpumask_full(sds_idle_cpus)     == true
> 
> IOW it'll require all CPUs to go idle at some point for these two states to
> be properly aligned. Should cpu_idle_state not then be init'd to 1?
> 
> This then happens again for hotplug, except that cpu_idle_state[cpu] may be
> either true or false when the sds_idle_cpus mask is reset to 1's.
> 

okay, will refine this in the next version.

Thanks,
-Aubrey
