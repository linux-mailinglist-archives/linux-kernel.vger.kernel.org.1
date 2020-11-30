Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914EF2C8428
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgK3Mbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:31:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:44422 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgK3Mbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:31:48 -0500
IronPort-SDR: 5BT/zd9NnKvbRfIYaSfxxQQi/fEgPwCa3AAUhvMQTVH8XSvPReIX366OWORsFzKWz2dGqc3l5/
 bKirzpCL+FBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="234230406"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="234230406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 04:29:56 -0800
IronPort-SDR: 49jcEDqhwGGICDfWhri68ndecygcYpOlLcyxMPa++cn36NuZYRNFTnMKEDxClL0vmgJq8NmxWQ
 6iDMJUQ+O2+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="372476984"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2020 04:29:45 -0800
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
 <0b2514ef-6cc3-c1a3-280b-5d9062c80a31@linux.intel.com>
 <20201124154237.GZ3021@hirez.programming.kicks-ass.net>
 <d541b70c-c65f-5bf6-5e71-0b9b35457fae@linux.intel.com>
 <20201125225731.GB163610@balbir-desktop>
 <d9f356dd-be58-b52c-504d-ff46d37c1479@linux.intel.com>
 <20201126083250.GI163610@balbir-desktop>
 <e885eebe-686c-70f7-95b9-17a065fb2764@linux.intel.com>
 <20201130093333.GD473773@balbir-desktop>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <6cf6c89d-8d33-c11b-1ea9-7d143b89fc2d@linux.intel.com>
Date:   Mon, 30 Nov 2020 20:29:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201130093333.GD473773@balbir-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/30 17:33, Balbir Singh wrote:
> On Thu, Nov 26, 2020 at 05:26:31PM +0800, Li, Aubrey wrote:
>> On 2020/11/26 16:32, Balbir Singh wrote:
>>> On Thu, Nov 26, 2020 at 11:20:41AM +0800, Li, Aubrey wrote:
>>>> On 2020/11/26 6:57, Balbir Singh wrote:
>>>>> On Wed, Nov 25, 2020 at 11:12:53AM +0800, Li, Aubrey wrote:
>>>>>> On 2020/11/24 23:42, Peter Zijlstra wrote:
>>>>>>> On Mon, Nov 23, 2020 at 12:36:10PM +0800, Li, Aubrey wrote:
>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
>>>>>>>>>> +		/*
>>>>>>>>>> +		 * Skip this cpu if source task's cookie does not match
>>>>>>>>>> +		 * with CPU's core cookie.
>>>>>>>>>> +		 */
>>>>>>>>>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>>>>>>>>>> +			continue;
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> Any reason this is under an #ifdef? In sched_core_cookie_match() won't
>>>>>>>>> the check for sched_core_enabled() do the right thing even when
>>>>>>>>> CONFIG_SCHED_CORE is not enabed?> 
>>>>>>>> Yes, sched_core_enabled works properly when CONFIG_SCHED_CORE is not
>>>>>>>> enabled. But when CONFIG_SCHED_CORE is not enabled, it does not make
>>>>>>>> sense to leave a core scheduler specific function here even at compile
>>>>>>>> time. Also, for the cases in hot path, this saves CPU cycles to avoid
>>>>>>>> a judgment.
>>>>>>>
>>>>>>> No, that's nonsense. If it works, remove the #ifdef. Less (#ifdef) is
>>>>>>> more.
>>>>>>>
>>>>>>
>>>>>> Okay, I pasted the refined patch here.
>>>>>> @Joel, please let me know if you want me to send it in a separated thread.
>>>>>>
>>>>>
>>>>> You still have a bunch of #ifdefs, can't we just do
>>>>>
>>>>> #ifndef CONFIG_SCHED_CORE
>>>>> static inline bool sched_core_enabled(struct rq *rq)
>>>>> {
>>>>>         return false;
>>>>> }
>>>>> #endif
>>>>>
>>>>> and frankly I think even that is not needed because there is a jump
>>>>> label __sched_core_enabled that tells us if sched_core is enabled or
>>>>> not.
>>>>
>>>> Hmm..., I need another wrapper for CONFIG_SCHED_CORE specific variables.
>>>> How about this one?
>>>>
>>>
>>> Much better :)
>>>  
>>>> Thanks,
>>>> -Aubrey
>>>>
>>>> From 61dac9067e66b5b9ea26c684c8c8235714bab38a Mon Sep 17 00:00:00 2001
>>>> From: Aubrey Li <aubrey.li@linux.intel.com>
>>>> Date: Thu, 26 Nov 2020 03:08:04 +0000
>>>> Subject: [PATCH] sched: migration changes for core scheduling
>>>>
>>>>  - Don't migrate if there is a cookie mismatch
>>>>      Load balance tries to move task from busiest CPU to the
>>>>      destination CPU. When core scheduling is enabled, if the
>>>>      task's cookie does not match with the destination CPU's
>>>>      core cookie, this task will be skipped by this CPU. This
>>>>      mitigates the forced idle time on the destination CPU.
>>>>
>>>>  - Select cookie matched idle CPU
>>>>      In the fast path of task wakeup, select the first cookie matched
>>>>      idle CPU instead of the first idle CPU.
>>>>
>>>>  - Find cookie matched idlest CPU
>>>>      In the slow path of task wakeup, find the idlest CPU whose core
>>>>      cookie matches with task's cookie
>>>>
>>>>  - Don't migrate task if cookie not match
>>>>      For the NUMA load balance, don't migrate task to the CPU whose
>>>>      core cookie does not match with task's cookie
>>>>
>>>> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>>> Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>>>  kernel/sched/fair.c  | 57 ++++++++++++++++++++++++++++++++++++++++----
>>>>  kernel/sched/sched.h | 43 +++++++++++++++++++++++++++++++++
>>>>  2 files changed, 95 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index de82f88ba98c..70dd013dff1d 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -1921,6 +1921,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>>>>  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>>>  			continue;
>>>>  
>>>> +		/*
>>>> +		 * Skip this cpu if source task's cookie does not match
>>>> +		 * with CPU's core cookie.
>>>> +		 */
>>>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>>>> +			continue;
>>>> +
>>>>  		env->dst_cpu = cpu;
>>>>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>>>>  			break;
>>>> @@ -5867,11 +5874,15 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>>>  
>>>>  	/* Traverse only the allowed CPUs */
>>>>  	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>>>> +		struct rq *rq = cpu_rq(i);
>>>> +
>>>> +		if (!sched_core_cookie_match(rq, p))
>>>> +			continue;
>>>> +
>>>>  		if (sched_idle_cpu(i))
>>>>  			return i;
>>>>  
>>>>  		if (available_idle_cpu(i)) {
>>>> -			struct rq *rq = cpu_rq(i);
>>>>  			struct cpuidle_state *idle = idle_get_state(rq);
>>>>  			if (idle && idle->exit_latency < min_exit_latency) {
>>>>  				/*
>>>> @@ -6129,8 +6140,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>>>  	for_each_cpu_wrap(cpu, cpus, target) {
>>>>  		if (!--nr)
>>>>  			return -1;
>>>> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>>>> -			break;
>>>> +
>>>> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
>>>> +			/*
>>>> +			 * If Core Scheduling is enabled, select this cpu
>>>> +			 * only if the process cookie matches core cookie.
>>>> +			 */
>>>> +			if (sched_core_enabled(cpu_rq(cpu))) {
>>>> +				if (__cookie_match(cpu_rq(cpu), p))
>>>> +					break;
>>>> +			} else {
>>>> +				break;
>>>> +			}
>>>> +		}
>>>
>>> Isn't this better and equivalent?
>>>
>>> 	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
>>> 		sched_core_cookie_match(cpu_rq(cpu), p))
>>> 		break;
>>>
>>
>>  
>> That's my previous implementation in the earlier version.
>> But since here is the hot code path, we want to remove the idle
>> core check in sched_core_cookie_match.
> 
> I see, so we basically need a jump label, if sched_core_cookie_match
> can be inlined with a check for sched_core_enabled() upfront, it might
> solve a lot of the concern, readability of this section of code is not
> the best.
> 
>>
>>>>  	}
>>>>  
>>>>  	time = cpu_clock(this) - time;
>>>> @@ -7530,8 +7552,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>  	 * We do not migrate tasks that are:
>>>>  	 * 1) throttled_lb_pair, or
>>>>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>>>> -	 * 3) running (obviously), or
>>>> -	 * 4) are cache-hot on their current CPU.
>>>> +	 * 3) task's cookie does not match with this CPU's core cookie
>>>> +	 * 4) running (obviously), or
>>>> +	 * 5) are cache-hot on their current CPU.
>>>>  	 */
>>>>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>>>>  		return 0;
>>>> @@ -7566,6 +7589,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> +	/*
>>>> +	 * Don't migrate task if the task's cookie does not match
>>>> +	 * with the destination CPU's core cookie.
>>>> +	 */
>>>> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>>>> +		return 0;
>>>> +
>>>>  	/* Record that we found atleast one task that could run on dst_cpu */
>>>>  	env->flags &= ~LBF_ALL_PINNED;
>>>>  
>>>> @@ -8792,6 +8822,23 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>>>  					p->cpus_ptr))
>>>>  			continue;
>>>>  
>>>> +		if (sched_core_enabled(cpu_rq(this_cpu))) {
>>>> +			int i = 0;
>>>> +			bool cookie_match = false;
>>>> +
>>>> +			for_each_cpu(i, sched_group_span(group)) {
>>>> +				struct rq *rq = cpu_rq(i);
>>>> +
>>>> +				if (sched_core_cookie_match(rq, p)) {
>>>> +					cookie_match = true;
>>>> +					break;
>>>> +				}
>>>> +			}
>>>> +			/* Skip over this group if no cookie matched */
>>>> +			if (!cookie_match)
>>>> +				continue;
>>>> +		}
>>>> +
>>>
>>> Again, I think this can be refactored because sched_core_cookie_match checks
>>> for sched_core_enabled()
>>>
>>> 	int i = 0;
>>> 	bool cookie_match = false;
>>> 	for_each_cpu(i, sched_group_span(group)) {
>>> 		if (sched_core_cookie_match(cpu_rq(i), p))
>>> 			break;
>>> 	}
>>> 	if (i >= nr_cpu_ids)
>>> 		continue;
>>
>> There is a loop here when CONFIG_SCHED_CORE=n, which is unwanted I guess.
>>
> 
> Yes, potentially, may be abstract the for_each_cpu into a function and then
> optimize out the case for SCHED_CORE=n, I feel all the extra checks in the
> various places make the code hard to read.

Okay, I see your point, let me try if I can make it better.

Thanks,
-Aubrey
