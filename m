Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7457B2C508E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbgKZIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKZIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:32:55 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37696C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:32:55 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id l17so1134265pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ThVV3qfibPjNal6tYQdY3Whw9cRRAWHD6CSTXYOg89w=;
        b=UPokA16ofbDD8wdP2Z1jln8ku0H7icHQsJRivgyePaTUGul0I58rPZR8JpuESomyT6
         6ZQ2Splb0lQSAutNv62432VbrG+Ug4ftPh3IxWT+Qj11lqnGbBtLs1M/sgPQBv+wEV4A
         aNQA8Se3gCJwcjsRRNAYqpBje8dz8zFoTZZ75tvsuKnpbzSLfsUbt/wZgnf+ci/8iWsy
         gkQJlkM+xpvrj54ODeTqS3JDIcH/AVi5FM4LUUniAYbUGjm3nBID7eDk1suh+vJOy7gd
         NwCdjCCgKLpfUxEk6/AsStoPYjxls6HCMFRdzeGJ1P+qrmPo/ekbHadfr1GZCIi0rgOJ
         aYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ThVV3qfibPjNal6tYQdY3Whw9cRRAWHD6CSTXYOg89w=;
        b=siSD1otpIwp/e9r8d1RIQme8jASGwyJ6rpLPxpJUnwC1JnyRna/ZJNXa/i/1Mtj2r6
         r2dHV6la+qcI4hCIeHWljTxlcNEzGo95If4AgYeYprPZc6wjJQNdYhbNjvYnmFyO4oIG
         xTn75QyNVjApXG+s6yFx+blTImkVbQSoFBGRe7ByT/RztJBFxrNA7FP45PsPLZAG8Oc0
         Pn+lHNBW+iwfZe6PEBRHaqeq5ogUQQjodQKt3ErgSUhWmjZITzrsM5H2GBZlu0tRjnWh
         BTt17vM0ifTJqn1cOk/rbt4wX7ZL4i6bSqJ3OacedfjwIa7JByaMVRbINSvHkystZ9WP
         yWOA==
X-Gm-Message-State: AOAM532HXk8lC///byxiIX2vKjmYRnkVpDLIUcgEGjFrsSDB+cPrhzwT
        oX3TJPpA4Izbo1wy6qR2eqk=
X-Google-Smtp-Source: ABdhPJxK9jgyCuaCj/PocauKyj3ScU0G/8mv/raWtN5GLs+ouXgbWRD0jEveFAl164AvA72NPYBKzA==
X-Received: by 2002:a17:90a:a67:: with SMTP id o94mr2474094pjo.236.1606379574639;
        Thu, 26 Nov 2020 00:32:54 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id u6sm5274778pjn.56.2020.11.26.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:32:53 -0800 (PST)
Date:   Thu, 26 Nov 2020 19:32:50 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
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
Subject: Re: [PATCH -tip 14/32] sched: migration changes for core scheduling
Message-ID: <20201126083250.GI163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-15-joel@joelfernandes.org>
 <20201122235456.GF110669@balbir-desktop>
 <0b2514ef-6cc3-c1a3-280b-5d9062c80a31@linux.intel.com>
 <20201124154237.GZ3021@hirez.programming.kicks-ass.net>
 <d541b70c-c65f-5bf6-5e71-0b9b35457fae@linux.intel.com>
 <20201125225731.GB163610@balbir-desktop>
 <d9f356dd-be58-b52c-504d-ff46d37c1479@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f356dd-be58-b52c-504d-ff46d37c1479@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:20:41AM +0800, Li, Aubrey wrote:
> On 2020/11/26 6:57, Balbir Singh wrote:
> > On Wed, Nov 25, 2020 at 11:12:53AM +0800, Li, Aubrey wrote:
> >> On 2020/11/24 23:42, Peter Zijlstra wrote:
> >>> On Mon, Nov 23, 2020 at 12:36:10PM +0800, Li, Aubrey wrote:
> >>>>>> +#ifdef CONFIG_SCHED_CORE
> >>>>>> +		/*
> >>>>>> +		 * Skip this cpu if source task's cookie does not match
> >>>>>> +		 * with CPU's core cookie.
> >>>>>> +		 */
> >>>>>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> >>>>>> +			continue;
> >>>>>> +#endif
> >>>>>> +
> >>>>>
> >>>>> Any reason this is under an #ifdef? In sched_core_cookie_match() won't
> >>>>> the check for sched_core_enabled() do the right thing even when
> >>>>> CONFIG_SCHED_CORE is not enabed?> 
> >>>> Yes, sched_core_enabled works properly when CONFIG_SCHED_CORE is not
> >>>> enabled. But when CONFIG_SCHED_CORE is not enabled, it does not make
> >>>> sense to leave a core scheduler specific function here even at compile
> >>>> time. Also, for the cases in hot path, this saves CPU cycles to avoid
> >>>> a judgment.
> >>>
> >>> No, that's nonsense. If it works, remove the #ifdef. Less (#ifdef) is
> >>> more.
> >>>
> >>
> >> Okay, I pasted the refined patch here.
> >> @Joel, please let me know if you want me to send it in a separated thread.
> >>
> > 
> > You still have a bunch of #ifdefs, can't we just do
> > 
> > #ifndef CONFIG_SCHED_CORE
> > static inline bool sched_core_enabled(struct rq *rq)
> > {
> >         return false;
> > }
> > #endif
> > 
> > and frankly I think even that is not needed because there is a jump
> > label __sched_core_enabled that tells us if sched_core is enabled or
> > not.
> 
> Hmm..., I need another wrapper for CONFIG_SCHED_CORE specific variables.
> How about this one?
>

Much better :)
 
> Thanks,
> -Aubrey
> 
> From 61dac9067e66b5b9ea26c684c8c8235714bab38a Mon Sep 17 00:00:00 2001
> From: Aubrey Li <aubrey.li@linux.intel.com>
> Date: Thu, 26 Nov 2020 03:08:04 +0000
> Subject: [PATCH] sched: migration changes for core scheduling
> 
>  - Don't migrate if there is a cookie mismatch
>      Load balance tries to move task from busiest CPU to the
>      destination CPU. When core scheduling is enabled, if the
>      task's cookie does not match with the destination CPU's
>      core cookie, this task will be skipped by this CPU. This
>      mitigates the forced idle time on the destination CPU.
> 
>  - Select cookie matched idle CPU
>      In the fast path of task wakeup, select the first cookie matched
>      idle CPU instead of the first idle CPU.
> 
>  - Find cookie matched idlest CPU
>      In the slow path of task wakeup, find the idlest CPU whose core
>      cookie matches with task's cookie
> 
>  - Don't migrate task if cookie not match
>      For the NUMA load balance, don't migrate task to the CPU whose
>      core cookie does not match with task's cookie
> 
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c  | 57 ++++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h | 43 +++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index de82f88ba98c..70dd013dff1d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1921,6 +1921,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>  			continue;
>  
> +		/*
> +		 * Skip this cpu if source task's cookie does not match
> +		 * with CPU's core cookie.
> +		 */
> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> +			continue;
> +
>  		env->dst_cpu = cpu;
>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>  			break;
> @@ -5867,11 +5874,15 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  
>  	/* Traverse only the allowed CPUs */
>  	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> +		struct rq *rq = cpu_rq(i);
> +
> +		if (!sched_core_cookie_match(rq, p))
> +			continue;
> +
>  		if (sched_idle_cpu(i))
>  			return i;
>  
>  		if (available_idle_cpu(i)) {
> -			struct rq *rq = cpu_rq(i);
>  			struct cpuidle_state *idle = idle_get_state(rq);
>  			if (idle && idle->exit_latency < min_exit_latency) {
>  				/*
> @@ -6129,8 +6140,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
>  			return -1;
> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -			break;
> +
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
> +			/*
> +			 * If Core Scheduling is enabled, select this cpu
> +			 * only if the process cookie matches core cookie.
> +			 */
> +			if (sched_core_enabled(cpu_rq(cpu))) {
> +				if (__cookie_match(cpu_rq(cpu), p))
> +					break;
> +			} else {
> +				break;
> +			}
> +		}

Isn't this better and equivalent?

	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
		sched_core_cookie_match(cpu_rq(cpu), p))
		break;

>  	}
>  
>  	time = cpu_clock(this) - time;
> @@ -7530,8 +7552,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	 * We do not migrate tasks that are:
>  	 * 1) throttled_lb_pair, or
>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> -	 * 3) running (obviously), or
> -	 * 4) are cache-hot on their current CPU.
> +	 * 3) task's cookie does not match with this CPU's core cookie
> +	 * 4) running (obviously), or
> +	 * 5) are cache-hot on their current CPU.
>  	 */
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
> @@ -7566,6 +7589,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Don't migrate task if the task's cookie does not match
> +	 * with the destination CPU's core cookie.
> +	 */
> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> +		return 0;
> +
>  	/* Record that we found atleast one task that could run on dst_cpu */
>  	env->flags &= ~LBF_ALL_PINNED;
>  
> @@ -8792,6 +8822,23 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  					p->cpus_ptr))
>  			continue;
>  
> +		if (sched_core_enabled(cpu_rq(this_cpu))) {
> +			int i = 0;
> +			bool cookie_match = false;
> +
> +			for_each_cpu(i, sched_group_span(group)) {
> +				struct rq *rq = cpu_rq(i);
> +
> +				if (sched_core_cookie_match(rq, p)) {
> +					cookie_match = true;
> +					break;
> +				}
> +			}
> +			/* Skip over this group if no cookie matched */
> +			if (!cookie_match)
> +				continue;
> +		}
> +

Again, I think this can be refactored because sched_core_cookie_match checks
for sched_core_enabled()

	int i = 0;
	bool cookie_match = false;
	for_each_cpu(i, sched_group_span(group)) {
		if (sched_core_cookie_match(cpu_rq(i), p))
			break;
	}
	if (i >= nr_cpu_ids)
		continue;

> +			}
> +			/* Skip over this group if no cookie matched */
> +			if (!cookie_match)
> +				continue;

>  		local_group = cpumask_test_cpu(this_cpu,
>  					       sched_group_span(group));
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e72942a9ee11..8bb3b72d593c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1135,6 +1135,40 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>  
>  bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
>  
> +/*
> + * Helper to check if the CPU's core cookie matches with the task's cookie
> + * when core scheduling is enabled.
> + * A special case is that the task's cookie always matches with CPU's core
> + * cookie if the CPU is in an idle core.
> + */
> +static inline bool __cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +	return rq->core->core_cookie == p->core_cookie;
> +}
> +
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +	bool idle_core = true;
> +	int cpu;
> +
> +	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
> +	if (!sched_core_enabled(rq))
> +		return true;
> +
> +	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> +		if (!available_idle_cpu(cpu)) {
> +			idle_core = false;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * A CPU in an idle core is always the best choice for tasks with
> +	 * cookies.
> +	 */
> +	return idle_core || __cookie_match(rq, p);
> +}
> +
>  extern void queue_core_balance(struct rq *rq);
>  
>  #else /* !CONFIG_SCHED_CORE */
> @@ -1153,6 +1187,15 @@ static inline void queue_core_balance(struct rq *rq)
>  {
>  }
>  
> +static inline bool __cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +	return true;
> +}
> +
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_SCHED_CORE */
>  
>  #ifdef CONFIG_SCHED_SMT
> -- 
> 2.17.1
>

Balbir Singh. 
