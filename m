Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DB42BFF03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKWEgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:36:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:45124 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKWEgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:36:21 -0500
IronPort-SDR: cO40+yhRMEI0SZVRH0K9+OL7btN80mCfAdhROeB/TfIEA7qG5SegFAdqzrpDfd4HCNYAXCjpRc
 JqVIKDZ56v3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="150962112"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="150962112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 20:36:20 -0800
IronPort-SDR: MKKN3PF0ejoQKgM2BIHoTrmrVKYIf6YWjuYazQBx/IFK+Ke773jxIYjQohR2csLCpfVh/6Tce3
 CgJClM+YSSTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="369902952"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2020 20:36:11 -0800
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
To:     Balbir Singh <bsingharora@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-15-joel@joelfernandes.org>
 <20201122235456.GF110669@balbir-desktop>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <0b2514ef-6cc3-c1a3-280b-5d9062c80a31@linux.intel.com>
Date:   Mon, 23 Nov 2020 12:36:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201122235456.GF110669@balbir-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/23 7:54, Balbir Singh wrote:
> On Tue, Nov 17, 2020 at 06:19:44PM -0500, Joel Fernandes (Google) wrote:
>> From: Aubrey Li <aubrey.li@intel.com>
>>
>>  - Don't migrate if there is a cookie mismatch
>>      Load balance tries to move task from busiest CPU to the
>>      destination CPU. When core scheduling is enabled, if the
>>      task's cookie does not match with the destination CPU's
>>      core cookie, this task will be skipped by this CPU. This
>>      mitigates the forced idle time on the destination CPU.
>>
>>  - Select cookie matched idle CPU
>>      In the fast path of task wakeup, select the first cookie matched
>>      idle CPU instead of the first idle CPU.
>>
>>  - Find cookie matched idlest CPU
>>      In the slow path of task wakeup, find the idlest CPU whose core
>>      cookie matches with task's cookie
>>
>>  - Don't migrate task if cookie not match
>>      For the NUMA load balance, don't migrate task to the CPU whose
>>      core cookie does not match with task's cookie
>>
>> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
>>  kernel/sched/sched.h | 29 ++++++++++++++++++++
>>  2 files changed, 88 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index de82f88ba98c..ceb3906c9a8a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1921,6 +1921,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>>  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>  			continue;
>>  
>> +#ifdef CONFIG_SCHED_CORE
>> +		/*
>> +		 * Skip this cpu if source task's cookie does not match
>> +		 * with CPU's core cookie.
>> +		 */
>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>> +			continue;
>> +#endif
>> +
> 
> Any reason this is under an #ifdef? In sched_core_cookie_match() won't
> the check for sched_core_enabled() do the right thing even when
> CONFIG_SCHED_CORE is not enabed?> 
Yes, sched_core_enabled works properly when CONFIG_SCHED_CORE is not
enabled. But when CONFIG_SCHED_CORE is not enabled, it does not make
sense to leave a core scheduler specific function here even at compile
time. Also, for the cases in hot path, this saves CPU cycles to avoid
a judgment.


>>  		env->dst_cpu = cpu;
>>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>>  			break;
>> @@ -5867,11 +5876,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>  
>>  	/* Traverse only the allowed CPUs */
>>  	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>> +		struct rq *rq = cpu_rq(i);
>> +
>> +#ifdef CONFIG_SCHED_CORE
>> +		if (!sched_core_cookie_match(rq, p))
>> +			continue;
>> +#endif
>> +
>>  		if (sched_idle_cpu(i))
>>  			return i;
>>  
>>  		if (available_idle_cpu(i)) {
>> -			struct rq *rq = cpu_rq(i);
>>  			struct cpuidle_state *idle = idle_get_state(rq);
>>  			if (idle && idle->exit_latency < min_exit_latency) {
>>  				/*
>> @@ -6129,8 +6144,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>  	for_each_cpu_wrap(cpu, cpus, target) {
>>  		if (!--nr)
>>  			return -1;
>> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>> -			break;
>> +
>> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
>> +#ifdef CONFIG_SCHED_CORE
>> +			/*
>> +			 * If Core Scheduling is enabled, select this cpu
>> +			 * only if the process cookie matches core cookie.
>> +			 */
>> +			if (sched_core_enabled(cpu_rq(cpu)) &&
>> +			    p->core_cookie == cpu_rq(cpu)->core->core_cookie)
>> +#endif
>> +				break;
>> +		}
>>  	}
>>  
>>  	time = cpu_clock(this) - time;
>> @@ -7530,8 +7555,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>  	 * We do not migrate tasks that are:
>>  	 * 1) throttled_lb_pair, or
>>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>> -	 * 3) running (obviously), or
>> -	 * 4) are cache-hot on their current CPU.
>> +	 * 3) task's cookie does not match with this CPU's core cookie
>> +	 * 4) running (obviously), or
>> +	 * 5) are cache-hot on their current CPU.
>>  	 */
>>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>>  		return 0;
>> @@ -7566,6 +7592,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>  		return 0;
>>  	}
>>  
>> +#ifdef CONFIG_SCHED_CORE
>> +	/*
>> +	 * Don't migrate task if the task's cookie does not match
>> +	 * with the destination CPU's core cookie.
>> +	 */
>> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>> +		return 0;
>> +#endif
>> +
>>  	/* Record that we found atleast one task that could run on dst_cpu */
>>  	env->flags &= ~LBF_ALL_PINNED;
>>  
>> @@ -8792,6 +8827,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>  					p->cpus_ptr))
>>  			continue;
>>  
>> +#ifdef CONFIG_SCHED_CORE
>> +		if (sched_core_enabled(cpu_rq(this_cpu))) {
>> +			int i = 0;
>> +			bool cookie_match = false;
>> +
>> +			for_each_cpu(i, sched_group_span(group)) {
>> +				struct rq *rq = cpu_rq(i);
>> +
>> +				if (sched_core_cookie_match(rq, p)) {
>> +					cookie_match = true;
>> +					break;
>> +				}
>> +			}
>> +			/* Skip over this group if no cookie matched */
>> +			if (!cookie_match)
>> +				continue;
>> +		}
>> +#endif
>> +
>>  		local_group = cpumask_test_cpu(this_cpu,
>>  					       sched_group_span(group));
>>  
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e72942a9ee11..de553d39aa40 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1135,6 +1135,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>>  
>>  bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
>>  
>> +/*
>> + * Helper to check if the CPU's core cookie matches with the task's cookie
>> + * when core scheduling is enabled.
>> + * A special case is that the task's cookie always matches with CPU's core
>> + * cookie if the CPU is in an idle core.
>> + */
>> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
>> +{
>> +	bool idle_core = true;
>> +	int cpu;
>> +
>> +	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
>> +	if (!sched_core_enabled(rq))
>> +		return true;
>> +
>> +	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
>> +		if (!available_idle_cpu(cpu)) {
> 
> I was looking at this snippet and comparing this to is_core_idle(), the
> major difference is the check for vcpu_is_preempted(). Do we want to
> call the core as non idle if any vcpu was preempted on this CPU?

Yes, if there is a VCPU was preempted on this CPU, better not place task
on this core as the VCPU may be holding a spinlock and wants to be executed
again ASAP.

Thanks,
-Aubrey
