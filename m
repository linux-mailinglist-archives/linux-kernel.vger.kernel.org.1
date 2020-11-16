Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451A52B4079
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKPKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:08:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgKPKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:08:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGA0EEl122614;
        Mon, 16 Nov 2020 10:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=aWvO6eiomNYTdLhIqrF453q1h5yYzb7VMOTaMz4SB2c=;
 b=qcHkXkw4JyePq1ms2TitZy/8bcjbv49DA8ACOa5P9PJJ3a36GhlgFpA+PcaR32IthQoW
 3/dTYSNFMp8OTx9daeiADNlBoeoyIHCJIAo1bpYq9JdgzDpd3Lr07+7DrJiuaZ7/VcFR
 /alEsaJ+8NNzGJd34JB5Jh8e23Lkf2A5g+sbDmuV30YvGCorBF8gYryQDw2HqIyHADij
 1vXb/NXGyeAaPzLqwTLi75ElgHQi+3ZQtx7oFaSgIlrqQ12tpKZ51t2RdBL+/72e+d85
 gkttaQjTxtU+heelCETc4pk64HSn8/0iyszjalX+prk+5uLJk4N/IM96OQNLbTbgpL5/ yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76km8va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 10:06:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AG9t9Wc143218;
        Mon, 16 Nov 2020 10:06:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umcwn6gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 10:06:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGA69Mt009396;
        Mon, 16 Nov 2020 10:06:11 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 02:06:08 -0800
Subject: Re: [PATCH v8 -tip 13/26] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     Joel Fernandes <joel@joelfernandes.org>
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
        benbjiang@tencent.com, James.Bottomley@hansenpartnership.com,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
 <60cfc619-1521-814d-8894-df9fc61d615c@oracle.com>
 <20201103012002.GA673080@google.com>
 <e830757c-96ce-c927-9b94-f1af3b71e6ba@oracle.com>
 <20201110224236.GA696041@google.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <52d4b334-e399-1e61-5ef5-ec24be1b23ce@oracle.com>
Date:   Mon, 16 Nov 2020 11:08:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110224236.GA696041@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/20 11:42 PM, Joel Fernandes wrote:
> On Tue, Nov 10, 2020 at 10:35:17AM +0100, Alexandre Chartre wrote:
> [..]
>>> ---8<-----------------------
>>>
>>>   From b2835a587a28405ffdf8fc801e798129a014a8c8 Mon Sep 17 00:00:00 2001
>>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>> Date: Mon, 27 Jul 2020 17:56:14 -0400
>>> Subject: [PATCH] kernel/entry: Add support for core-wide protection of
>>>    kernel-mode
> [..]
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index d38e904dd603..fe6f225bfbf9 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -2071,4 +2071,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
>>>    const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
>>> +#ifdef CONFIG_SCHED_CORE
>>> +void sched_core_unsafe_enter(void);
>>> +void sched_core_unsafe_exit(void);
>>> +bool sched_core_wait_till_safe(unsigned long ti_check);
>>> +bool sched_core_kernel_protected(void);
>>> +#else
>>> +#define sched_core_unsafe_enter(ignore) do { } while (0)
>>> +#define sched_core_unsafe_exit(ignore) do { } while (0)
>>> +#define sched_core_wait_till_safe(ignore) do { } while (0)
>>> +#define sched_core_kernel_protected(ignore) do { } while (0)
>>> +#endif
>>> +
>>>    #endif
>>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>>> index 0a1e20f8d4e8..a18ed60cedea 100644
>>> --- a/kernel/entry/common.c
>>> +++ b/kernel/entry/common.c
>>> @@ -28,6 +28,8 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>>>    	instrumentation_begin();
>>>    	trace_hardirqs_off_finish();
>>> +	if (_TIF_UNSAFE_RET) /* Kernel protection depends on arch defining the flag. */
>>> +		sched_core_unsafe_enter();
>>>    	instrumentation_end();
>>>    }
>>> @@ -137,6 +139,27 @@ static __always_inline void exit_to_user_mode(void)
>>>    /* Workaround to allow gradual conversion of architecture code */
>>>    void __weak arch_do_signal(struct pt_regs *regs) { }
>>> +unsigned long exit_to_user_get_work(void)
>>
>> Function should be static.
> 
> Fixed.
> 
>>> +{
>>> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
>>> +
>>> +	if ((IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
>>> +	    || !_TIF_UNSAFE_RET)
>>> +		return ti_work;
>>> +
>>> +#ifdef CONFIG_SCHED_CORE
>>> +	ti_work &= EXIT_TO_USER_MODE_WORK;
>>> +	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {
>>> +		sched_core_unsafe_exit();
>>> +		if (sched_core_wait_till_safe(EXIT_TO_USER_MODE_WORK)) {
>>> +			sched_core_unsafe_enter(); /* not exiting to user yet. */
>>> +		}
>>> +	}
>>> +
>>> +	return READ_ONCE(current_thread_info()->flags);
>>> +#endif
>>> +}
>>> +
>>>    static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>>    					    unsigned long ti_work)
>>>    {
>>> @@ -175,7 +198,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>>    		 * enabled above.
>>>    		 */
>>>    		local_irq_disable_exit_to_user();
>>> -		ti_work = READ_ONCE(current_thread_info()->flags);
>>> +		ti_work = exit_to_user_get_work();
>>>    	}
>>
>> What happen if the task is scheduled out in exit_to_user_mode_loop? (e.g. if it has
>> _TIF_NEED_RESCHED set). It will have call sched_core_unsafe_enter() and force siblings
>> to wait for it. So shouldn't sched_core_unsafe_exit() be called when the task is
>> scheduled out? (because it won't run anymore) And sched_core_unsafe_enter() when
>> the task is scheduled back in?
> 
> No, when the task is scheduled out, it will in kernel mode on the task being
> scheduled in. That task (being scheduled-in) would have already done a
> sched_core_unsafe_enter(). When that task returns to user made, it will do a
> sched_core_unsafe_exit(). When all tasks goto sleep, the last task that
> enters the idle loop will do a sched_core_unsafe_exit(). Just to note: the
> "unsafe kernel context" is per-CPU and not per-task. Does that answer your
> question?

Ok, I think I get it: it works because when a task is scheduled out then the
scheduler will schedule in a new tagged task (because we have core scheduling).
So that new task should be accounted for core-wide protection the same way as
the previous one.


>>> +static inline void init_sched_core_irq_work(struct rq *rq)
>>> +{
>>> +	init_irq_work(&rq->core_irq_work, sched_core_irq_work);
>>> +}
>>> +
>>> +/*
>>> + * sched_core_wait_till_safe - Pause the caller's hyperthread until the core
>>> + * exits the core-wide unsafe state. Obviously the CPU calling this function
>>> + * should not be responsible for the core being in the core-wide unsafe state
>>> + * otherwise it will deadlock.
>>> + *
>>> + * @ti_check: We spin here with IRQ enabled and preempt disabled. Break out of
>>> + *            the loop if TIF flags are set and notify caller about it.
>>> + *
>>> + * IRQs should be disabled.
>>> + */
>>> +bool sched_core_wait_till_safe(unsigned long ti_check)
>>> +{
>>> +	bool restart = false;
>>> +	struct rq *rq;
>>> +	int cpu;
>>> +
>>> +	/* We clear the thread flag only at the end, so need to check for it. */
>>
>> Do you mean "no need to check for it" ?
> 
> Fixed.
> 
>>> +/*
>>> + * Enter the core-wide IRQ state. Sibling will be paused if it is running
>>> + * 'untrusted' code, until sched_core_unsafe_exit() is called. Every attempt to
>>> + * avoid sending useless IPIs is made. Must be called only from hard IRQ
>>> + * context.
>>> + */
>>> +void sched_core_unsafe_enter(void)
>>> +{
>>> +	const struct cpumask *smt_mask;
>>> +	unsigned long flags;
>>> +	struct rq *rq;
>>> +	int i, cpu;
>>> +
>>> +	if (!static_branch_likely(&sched_core_protect_kernel))
>>> +		return;
>>> +
>>> +	/* Ensure that on return to user/guest, we check whether to wait. */
>>> +	if (current->core_cookie)
>>> +		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
>>> +
>>> +	local_irq_save(flags);
>>> +	cpu = smp_processor_id();
>>> +	rq = cpu_rq(cpu);
>>> +	if (!sched_core_enabled(rq))
>>> +		goto ret;
>>
>> Should we clear TIF_UNSAFE_RET if (!sched_core_enabled(rq))? This would avoid calling
>> sched_core_wait_till_safe().
> 
> Ok, or what I'll do is move the set_tsk_thread_flag to after the check for
> sched_core_enabled().
> 
>>> +
>>> +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
>>> +	rq->core_this_unsafe_nest++;
>>> +
>>> +	/* Should not nest: enter() should only pair with exit(). */
>>> +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
>>> +		goto ret;
>>
>> I would be more precise about the nesting comment: we don't nest not only because each
>> enter() is paired with an exit() but because each enter()/exit() is for a user context.
>> We can have nested interrupts but they will be for a kernel context so they won't enter/exit.
>>
>> So I would say something like:
>>
>>          /*
>>           * Should not nest: each enter() is paired with an exit(), and enter()/exit()
>>           * are done when coming from userspace. We can have nested interrupts between
>>           * enter()/exit() but they will originate from the kernel so they won't enter()
>>           * nor exit().
>>           */
> 
> Changed it to following, hope its ok with you:
>          /*
>           * Should not nest: enter() should only pair with exit(). Both are done
>           * during the first entry into kernel and the last exit from kernel.
>           * Nested kernel entries (such as nested interrupts) will only trigger
>           * enter() and exit() on the outer most kernel entry and exit.
>           */
> 
>>> +
>>> +	raw_spin_lock(rq_lockp(rq));
>>> +	smt_mask = cpu_smt_mask(cpu);
>>> +
>>> +	/* Contribute this CPU's unsafe_enter() to core-wide unsafe_enter() count. */
>>> +	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
>>
>> We are protected by the rq_lockp(rq) spinlock, but we still need to use WRITE_ONCE()
>> because sched_core_wait_till_safe() checks core_unsafe_next without taking rq_lockp(rq),
>> right?
> 
> Yes.
> 
>> Shouldn't we be using smp_store_release() like sched_core_unsafe_exit() does?
>>
>> In any case, it is worth having a comment why WRITE_ONCE() or smp_store_release() is
>> used.
> 
> The smp_store_release() in exit() ensures that the write to the nesting
> counter happens *after* all prior reads and write accesses done by this CPU
> are seen by the spinning CPU doing the smp_load_acquire() before that
> spinning CPU returns. I did put a comment there.
> 
> But, I think I don't need smp_store_release() at all here. The spin_unlock
> that follows already has the required release semantics. I will demote it to
> a WRITE_ONCE() in enter() as well, and add appropriate comments.
> 

I think a WRITE_ONCE() is not even be useful here. The WRITE_ONCE() will only prevent
some possible compiler optimization in the function wrt rq->core->core_unsafe_nest, but
rq->core->core_unsafe_nest is just updated here, and concurrent changes are protected
by the rq_lockp(rq) spinlock, and the memory barrier is ensured by raw_spin_unlock().

So I thing you can just do:  rq->core->core_unsafe_nest++;

And in sched_core_unsafe_exit(), you can just do:  rq->core->core_unsafe_nest = nest - 1

Also comment in sched_core_wait_till_safe() wrt smp_load_acquire() should be updated,
it should say:

	/*
	 * Wait till the core of this HT is not in an unsafe state.
	 *
	 * Pair with raw_spin_unlock(rq_lockp(rq) in sched_core_unsafe_enter/exit()
	 */
	

>>> +
>>> +	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
>>> +		goto unlock;
>>
>> It might be better checking if (rq->core->core_unsafe_nest >= cpumask_weight(smt_mask))
>> because we shouldn't exceed the number of siblings.
> 
> I am a bit concerned with the time complexity of cpumask_weight(). It may be
> better not to add overhead. I am not fully sure how it works but there is a
> loop in bitmask weight that goes through the bits of the bitmap, what is your
> opinion on that?

Yes, it's looping through the bitmap so probably not worth adding this overhead it here.

> 
> Can I add your Reviewed-by tag to below updated patch? Thanks for review!

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>


alex.

> 
> ---8<---
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bd1a5b87a5e2..a36f08d74e09 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4678,6 +4678,15 @@
>   
>   	sbni=		[NET] Granch SBNI12 leased line adapter
>   
> +	sched_core_protect_kernel=
> +			[SCHED_CORE] Pause SMT siblings of a core running in
> +			user mode, if at least one of the siblings of the core
> +			is running in kernel mode. This is to guarantee that
> +			kernel data is not leaked to tasks which are not trusted
> +			by the kernel. A value of 0 disables protection, 1
> +			enables protection. The default is 1. Note that protection
> +			depends on the arch defining the _TIF_UNSAFE_RET flag.
> +
>   	sched_debug	[KNL] Enables verbose scheduler debug messages.
>   
>   	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 474f29638d2c..62278c5b3b5f 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -33,6 +33,10 @@
>   # define _TIF_PATCH_PENDING		(0)
>   #endif
>   
> +#ifndef _TIF_UNSAFE_RET
> +# define _TIF_UNSAFE_RET		(0)
> +#endif
> +
>   #ifndef _TIF_UPROBE
>   # define _TIF_UPROBE			(0)
>   #endif
> @@ -69,7 +73,7 @@
>   
>   #define EXIT_TO_USER_MODE_WORK						\
>   	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
> -	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
> +	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_UNSAFE_RET |	\
>   	 ARCH_EXIT_TO_USER_MODE_WORK)
>   
>   /**
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d38e904dd603..fe6f225bfbf9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2071,4 +2071,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
>   
>   const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
>   
> +#ifdef CONFIG_SCHED_CORE
> +void sched_core_unsafe_enter(void);
> +void sched_core_unsafe_exit(void);
> +bool sched_core_wait_till_safe(unsigned long ti_check);
> +bool sched_core_kernel_protected(void);
> +#else
> +#define sched_core_unsafe_enter(ignore) do { } while (0)
> +#define sched_core_unsafe_exit(ignore) do { } while (0)
> +#define sched_core_wait_till_safe(ignore) do { } while (0)
> +#define sched_core_kernel_protected(ignore) do { } while (0)
> +#endif
> +
>   #endif
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 2b8366693d5c..d5d88e735d55 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -28,6 +28,8 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>   
>   	instrumentation_begin();
>   	trace_hardirqs_off_finish();
> +	if (_TIF_UNSAFE_RET) /* Kernel protection depends on arch defining the flag. */
> +		sched_core_unsafe_enter();
>   	instrumentation_end();
>   }
>   
> @@ -137,6 +139,27 @@ static __always_inline void exit_to_user_mode(void)
>   /* Workaround to allow gradual conversion of architecture code */
>   void __weak arch_do_signal(struct pt_regs *regs) { }
>   
> +static unsigned long exit_to_user_get_work(void)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	if ((IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
> +	    || !_TIF_UNSAFE_RET)
> +		return ti_work;
> +
> +#ifdef CONFIG_SCHED_CORE
> +	ti_work &= EXIT_TO_USER_MODE_WORK;
> +	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {
> +		sched_core_unsafe_exit();
> +		if (sched_core_wait_till_safe(EXIT_TO_USER_MODE_WORK)) {
> +			sched_core_unsafe_enter(); /* not exiting to user yet. */
> +		}
> +	}
> +
> +	return READ_ONCE(current_thread_info()->flags);
> +#endif
> +}
> +
>   static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>   					    unsigned long ti_work)
>   {
> @@ -174,7 +197,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>   		 * enabled above.
>   		 */
>   		local_irq_disable_exit_to_user();
> -		ti_work = READ_ONCE(current_thread_info()->flags);
> +		ti_work = exit_to_user_get_work();
>   	}
>   
>   	/* Return the latest work state for arch_exit_to_user_mode() */
> @@ -183,9 +206,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>   
>   static void exit_to_user_mode_prepare(struct pt_regs *regs)
>   {
> -	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	unsigned long ti_work;
>   
>   	lockdep_assert_irqs_disabled();
> +	ti_work = exit_to_user_get_work();
>   
>   	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>   		ti_work = exit_to_user_mode_loop(regs, ti_work);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fa68941998e3..429f9b8ca38e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -76,6 +76,27 @@ __read_mostly int scheduler_running;
>   
>   #ifdef CONFIG_SCHED_CORE
>   
> +DEFINE_STATIC_KEY_TRUE(sched_core_protect_kernel);
> +static int __init set_sched_core_protect_kernel(char *str)
> +{
> +	unsigned long val = 0;
> +
> +	if (!str)
> +		return 0;
> +
> +	if (!kstrtoul(str, 0, &val) && !val)
> +		static_branch_disable(&sched_core_protect_kernel);
> +
> +	return 1;
> +}
> +__setup("sched_core_protect_kernel=", set_sched_core_protect_kernel);
> +
> +/* Is the kernel protected by core scheduling? */
> +bool sched_core_kernel_protected(void)
> +{
> +	return static_branch_likely(&sched_core_protect_kernel);
> +}
> +
>   DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
>   
>   /* kernel prio, less is more */
> @@ -4596,6 +4617,226 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
>   	return a->core_cookie == b->core_cookie;
>   }
>   
> +/*
> + * Handler to attempt to enter kernel. It does nothing because the exit to
> + * usermode or guest mode will do the actual work (of waiting if needed).
> + */
> +static void sched_core_irq_work(struct irq_work *work)
> +{
> +	return;
> +}
> +
> +static inline void init_sched_core_irq_work(struct rq *rq)
> +{
> +	init_irq_work(&rq->core_irq_work, sched_core_irq_work);
> +}
> +
> +/*
> + * sched_core_wait_till_safe - Pause the caller's hyperthread until the core
> + * exits the core-wide unsafe state. Obviously the CPU calling this function
> + * should not be responsible for the core being in the core-wide unsafe state
> + * otherwise it will deadlock.
> + *
> + * @ti_check: We spin here with IRQ enabled and preempt disabled. Break out of
> + *            the loop if TIF flags are set and notify caller about it.
> + *
> + * IRQs should be disabled.
> + */
> +bool sched_core_wait_till_safe(unsigned long ti_check)
> +{
> +	bool restart = false;
> +	struct rq *rq;
> +	int cpu;
> +
> +	/* We clear the thread flag only at the end, so no need to check for it. */
> +	ti_check &= ~_TIF_UNSAFE_RET;
> +
> +	cpu = smp_processor_id();
> +	rq = cpu_rq(cpu);
> +
> +	if (!sched_core_enabled(rq))
> +		goto ret;
> +
> +	/* Down grade to allow interrupts to prevent stop_machine lockups.. */
> +	preempt_disable();
> +	local_irq_enable();
> +
> +	/*
> +	 * Wait till the core of this HT is not in an unsafe state.
> +	 *
> +	 * Pair with smp_store_release() in sched_core_unsafe_exit().
> +	 */
> +	while (smp_load_acquire(&rq->core->core_unsafe_nest) > 0) {
> +		cpu_relax();
> +		if (READ_ONCE(current_thread_info()->flags) & ti_check) {
> +			restart = true;
> +			break;
> +		}
> +	}
> +
> +	/* Upgrade it back to the expectations of entry code. */
> +	local_irq_disable();
> +	preempt_enable();
> +
> +ret:
> +	if (!restart)
> +		clear_tsk_thread_flag(current, TIF_UNSAFE_RET);
> +
> +	return restart;
> +}
> +
> +/*
> + * Enter the core-wide IRQ state. Sibling will be paused if it is running
> + * 'untrusted' code, until sched_core_unsafe_exit() is called. Every attempt to
> + * avoid sending useless IPIs is made. Must be called only from hard IRQ
> + * context.
> + */
> +void sched_core_unsafe_enter(void)
> +{
> +	const struct cpumask *smt_mask;
> +	unsigned long flags;
> +	struct rq *rq;
> +	int i, cpu;
> +
> +	if (!static_branch_likely(&sched_core_protect_kernel))
> +		return;
> +
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	rq = cpu_rq(cpu);
> +	if (!sched_core_enabled(rq))
> +		goto ret;
> +
> +	/* Ensure that on return to user/guest, we check whether to wait. */
> +	if (current->core_cookie)
> +		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
> +
> +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
> +	rq->core_this_unsafe_nest++;
> +
> +	/*
> +	 * Should not nest: enter() should only pair with exit(). Both are done
> +	 * during the first entry into kernel and the last exit from kernel.
> +	 * Nested kernel entries (such as nested interrupts) will only trigger
> +	 * enter() and exit() on the outer most kernel entry and exit.
> +	 */
> +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
> +		goto ret;
> +
> +	raw_spin_lock(rq_lockp(rq));
> +	smt_mask = cpu_smt_mask(cpu);
> +
> +	/*
> +	 * Contribute this CPU's unsafe_enter() to the core-wide unsafe_enter()
> +	 * count.  The raw_spin_unlock() release semantics pairs with the nest
> +	 * counter's smp_load_acquire() in sched_core_wait_till_safe().
> +	 */
> +	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);
> +
> +	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
> +		goto unlock;
> +
> +	if (irq_work_is_busy(&rq->core_irq_work)) {
> +		/*
> +		 * Do nothing more since we are in an IPI sent from another
> +		 * sibling to enforce safety. That sibling would have sent IPIs
> +		 * to all of the HTs.
> +		 */
> +		goto unlock;
> +	}
> +
> +	/*
> +	 * If we are not the first ones on the core to enter core-wide unsafe
> +	 * state, do nothing.
> +	 */
> +	if (rq->core->core_unsafe_nest > 1)
> +		goto unlock;
> +
> +	/* Do nothing more if the core is not tagged. */
> +	if (!rq->core->core_cookie)
> +		goto unlock;
> +
> +	for_each_cpu(i, smt_mask) {
> +		struct rq *srq = cpu_rq(i);
> +
> +		if (i == cpu || cpu_is_offline(i))
> +			continue;
> +
> +		if (!srq->curr->mm || is_task_rq_idle(srq->curr))
> +			continue;
> +
> +		/* Skip if HT is not running a tagged task. */
> +		if (!srq->curr->core_cookie && !srq->core_pick)
> +			continue;
> +
> +		/*
> +		 * Force sibling into the kernel by IPI. If work was already
> +		 * pending, no new IPIs are sent. This is Ok since the receiver
> +		 * would already be in the kernel, or on its way to it.
> +		 */
> +		irq_work_queue_on(&srq->core_irq_work, i);
> +	}
> +unlock:
> +	raw_spin_unlock(rq_lockp(rq));
> +ret:
> +	local_irq_restore(flags);
> +}
> +
> +/*
> + * Process any work need for either exiting the core-wide unsafe state, or for
> + * waiting on this hyperthread if the core is still in this state.
> + *
> + * @idle: Are we called from the idle loop?
> + */
> +void sched_core_unsafe_exit(void)
> +{
> +	unsigned long flags;
> +	unsigned int nest;
> +	struct rq *rq;
> +	int cpu;
> +
> +	if (!static_branch_likely(&sched_core_protect_kernel))
> +		return;
> +
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	rq = cpu_rq(cpu);
> +
> +	/* Do nothing if core-sched disabled. */
> +	if (!sched_core_enabled(rq))
> +		goto ret;
> +
> +	/*
> +	 * Can happen when a process is forked and the first return to user
> +	 * mode is a syscall exit. Either way, there's nothing to do.
> +	 */
> +	if (rq->core_this_unsafe_nest == 0)
> +		goto ret;
> +
> +	rq->core_this_unsafe_nest--;
> +
> +	/* enter() should be paired with exit() only. */
> +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 0))
> +		goto ret;
> +
> +	raw_spin_lock(rq_lockp(rq));
> +	/*
> +	 * Core-wide nesting counter can never be 0 because we are
> +	 * still in it on this CPU.
> +	 */
> +	nest = rq->core->core_unsafe_nest;
> +	WARN_ON_ONCE(!nest);
> +
> +	WRITE_ONCE(rq->core->core_unsafe_nest, nest - 1);
> +	/*
> +	 * The raw_spin_unlock release semantics pairs with the nest counter's
> +	 * smp_load_acquire() in sched_core_wait_till_safe().
> +	 */
> +	raw_spin_unlock(rq_lockp(rq));
> +ret:
> +	local_irq_restore(flags);
> +}
> +
>   // XXX fairness/fwd progress conditions
>   /*
>    * Returns
> @@ -4991,6 +5232,7 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
>   			rq = cpu_rq(i);
>   			if (rq->core && rq->core == rq)
>   				core_rq = rq;
> +			init_sched_core_irq_work(rq);
>   		}
>   
>   		if (!core_rq)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 001382bc67f9..20937a5b6272 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1061,6 +1061,8 @@ struct rq {
>   	unsigned int		core_enabled;
>   	unsigned int		core_sched_seq;
>   	struct rb_root		core_tree;
> +	struct irq_work		core_irq_work; /* To force HT into kernel */
> +	unsigned int		core_this_unsafe_nest;
>   
>   	/* shared state */
>   	unsigned int		core_task_seq;
> @@ -1068,6 +1070,7 @@ struct rq {
>   	unsigned long		core_cookie;
>   	unsigned char		core_forceidle;
>   	unsigned int		core_forceidle_seq;
> +	unsigned int		core_unsafe_nest;
>   #endif
>   };
>   
> 
