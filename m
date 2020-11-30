Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED52C8431
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgK3Meo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:34:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:36122 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgK3Meo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:34:44 -0500
IronPort-SDR: pAlejKfalyYeDPaB4oUsdRaEI/C/IKpiMomw8J7xZOSu08HeTxIc0JAEDuwfpFLaMHvigQnEC3
 qCAlOpj69h3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="160398080"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="160398080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 04:33:02 -0800
IronPort-SDR: IbPsYnqSwtnb1o4+GLCJeXVnmngfyHvQ2KmVNDszlWuHSAuiPXk8XAjdpopgvWKAs5e943hhml
 M24DgKd9V3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="372478051"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2020 04:32:51 -0800
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-15-joel@joelfernandes.org>
 <CAKfTPtC1VvON-Q6RrEXUkkURbY14b=nEAzGdXwCbWdqNiOz5yg@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <412d1b62-d2ef-ce01-7739-0e8f2a98e233@linux.intel.com>
Date:   Mon, 30 Nov 2020 20:32:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC1VvON-Q6RrEXUkkURbY14b=nEAzGdXwCbWdqNiOz5yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/30 18:35, Vincent Guittot wrote:
> On Wed, 18 Nov 2020 at 00:20, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
>>
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
>>                 if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>                         continue;
>>
>> +#ifdef CONFIG_SCHED_CORE
>> +               /*
>> +                * Skip this cpu if source task's cookie does not match
>> +                * with CPU's core cookie.
>> +                */
>> +               if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>> +                       continue;
>> +#endif
>> +
>>                 env->dst_cpu = cpu;
>>                 if (task_numa_compare(env, taskimp, groupimp, maymove))
>>                         break;
>> @@ -5867,11 +5876,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>
>>         /* Traverse only the allowed CPUs */
>>         for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>> +               struct rq *rq = cpu_rq(i);
>> +
>> +#ifdef CONFIG_SCHED_CORE
>> +               if (!sched_core_cookie_match(rq, p))
>> +                       continue;
>> +#endif
>> +
>>                 if (sched_idle_cpu(i))
>>                         return i;
>>
>>                 if (available_idle_cpu(i)) {
>> -                       struct rq *rq = cpu_rq(i);
>>                         struct cpuidle_state *idle = idle_get_state(rq);
>>                         if (idle && idle->exit_latency < min_exit_latency) {
>>                                 /*
>> @@ -6129,8 +6144,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>         for_each_cpu_wrap(cpu, cpus, target) {
>>                 if (!--nr)
>>                         return -1;
>> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>> -                       break;
>> +
>> +               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
>> +#ifdef CONFIG_SCHED_CORE
>> +                       /*
>> +                        * If Core Scheduling is enabled, select this cpu
>> +                        * only if the process cookie matches core cookie.
>> +                        */
>> +                       if (sched_core_enabled(cpu_rq(cpu)) &&
>> +                           p->core_cookie == cpu_rq(cpu)->core->core_cookie)
>> +#endif
>> +                               break;
>> +               }
> 
> This makes code unreadable.
> Put this coresched specific stuff in an inline function; You can have
> a look at what is done with asym_fits_capacity()
> 
This is done in a refined version. Sorry I pasted the version embedded in this thread,
this is not the latest version.

>>         }
>>
>>         time = cpu_clock(this) - time;
>> @@ -7530,8 +7555,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>          * We do not migrate tasks that are:
>>          * 1) throttled_lb_pair, or
>>          * 2) cannot be migrated to this CPU due to cpus_ptr, or
>> -        * 3) running (obviously), or
>> -        * 4) are cache-hot on their current CPU.
>> +        * 3) task's cookie does not match with this CPU's core cookie
>> +        * 4) running (obviously), or
>> +        * 5) are cache-hot on their current CPU.
>>          */
>>         if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>>                 return 0;
>> @@ -7566,6 +7592,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>                 return 0;
>>         }
>>
>> +#ifdef CONFIG_SCHED_CORE
>> +       /*
>> +        * Don't migrate task if the task's cookie does not match
>> +        * with the destination CPU's core cookie.
>> +        */
>> +       if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>> +               return 0;
>> +#endif
>> +
>>         /* Record that we found atleast one task that could run on dst_cpu */
>>         env->flags &= ~LBF_ALL_PINNED;
>>
>> @@ -8792,6 +8827,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>                                         p->cpus_ptr))
>>                         continue;
>>
>> +#ifdef CONFIG_SCHED_CORE
>> +               if (sched_core_enabled(cpu_rq(this_cpu))) {
>> +                       int i = 0;
>> +                       bool cookie_match = false;
>> +
>> +                       for_each_cpu(i, sched_group_span(group)) {
>> +                               struct rq *rq = cpu_rq(i);
>> +
>> +                               if (sched_core_cookie_match(rq, p)) {
>> +                                       cookie_match = true;
>> +                                       break;
>> +                               }
>> +                       }
>> +                       /* Skip over this group if no cookie matched */
>> +                       if (!cookie_match)
>> +                               continue;
>> +               }
>> +#endif
> 
> same here, encapsulate this to keep find_idlest_group readable
> 
Okay, I'll try to refine this.

Thanks,
-Aubrey
