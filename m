Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6409F2AD290
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgKJJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:35:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:35:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9TFax184620;
        Tue, 10 Nov 2020 09:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zCfpRX4YxVao4tjW037svE8d5DIPgdkP37IyuQ2p4eY=;
 b=WHnQwo6kZj5+AQe1355NNicATC21MIUzsrQJCJ/+syPxKHyg0i3zUCgpKAI36w8N3ig8
 tAh6kqbLYLlhkwKdtPCG8lebu4XSAY1S+tcjmIiDMhbUHpSfBRGCKHwDgkE73Pzco4Ua
 kUHUspNqX69KumAVzCmi0hL4qPC34uik4G+foc2UGa3u+JTQIzA96HfMaER401KqJqIE
 hEPFYeKuti8nweKWZmJmVEspeKj62+He+oGCkmOBDPq6GUBf5xyJFzj6JelgjIm4PT8h
 RAZwDeHW8W7K4HQ6CBBeCjPJzQryIgG9/u79QBPEoITqsGnR4GZHzRv1IjfOMI4LMyMG Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72egkb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 09:33:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9VB0B144729;
        Tue, 10 Nov 2020 09:33:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34p55n80fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 09:33:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AA9X61Y002723;
        Tue, 10 Nov 2020 09:33:08 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 01:33:06 -0800
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
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <e830757c-96ce-c927-9b94-f1af3b71e6ba@oracle.com>
Date:   Tue, 10 Nov 2020 10:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103012002.GA673080@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/20 2:20 AM, Joel Fernandes wrote:
> Hi Alexandre,
> 
> Sorry for late reply as I was working on the snapshotting patch...
> 
> On Fri, Oct 30, 2020 at 11:29:26AM +0100, Alexandre Chartre wrote:
>>
>> On 10/20/20 3:43 AM, Joel Fernandes (Google) wrote:
>>> Core-scheduling prevents hyperthreads in usermode from attacking each
>>> other, but it does not do anything about one of the hyperthreads
>>> entering the kernel for any reason. This leaves the door open for MDS
>>> and L1TF attacks with concurrent execution sequences between
>>> hyperthreads.
>>>
>>> This patch therefore adds support for protecting all syscall and IRQ
>>> kernel mode entries. Care is taken to track the outermost usermode exit
>>> and entry using per-cpu counters. In cases where one of the hyperthreads
>>> enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
>>> when not needed - example: idle and non-cookie HTs do not need to be
>>> forced into kernel mode.
>>
>> Hi Joel,
>>
>> In order to protect syscall/IRQ kernel mode entries, shouldn't we have a
>> call to sched_core_unsafe_enter() in the syscall/IRQ entry code? I don't
>> see such a call. Am I missing something?
> 
> Yes, this is known bug and fixed in v9 which I'll post soon. Meanwhile
> updated patch is appended below:
>   

See comments below about the updated patch.

> ---8<-----------------------
> 
>  From b2835a587a28405ffdf8fc801e798129a014a8c8 Mon Sep 17 00:00:00 2001
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Mon, 27 Jul 2020 17:56:14 -0400
> Subject: [PATCH] kernel/entry: Add support for core-wide protection of
>   kernel-mode
> 
> Core-scheduling prevents hyperthreads in usermode from attacking each
> other, but it does not do anything about one of the hyperthreads
> entering the kernel for any reason. This leaves the door open for MDS
> and L1TF attacks with concurrent execution sequences between
> hyperthreads.
> 
> This patch therefore adds support for protecting all syscall and IRQ
> kernel mode entries. Care is taken to track the outermost usermode exit
> and entry using per-cpu counters. In cases where one of the hyperthreads
> enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
> when not needed - example: idle and non-cookie HTs do not need to be
> forced into kernel mode.
> 
> More information about attacks:
> For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
> data to either host or guest attackers. For L1TF, it is possible to leak
> to guest attackers. There is no possible mitigation involving flushing
> of buffers to avoid this since the execution of attacker and victims
> happen concurrently on 2 or more HTs.
> 
> Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Aaron Lu <aaron.lwe@gmail.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   .../admin-guide/kernel-parameters.txt         |   9 +
>   include/linux/entry-common.h                  |   6 +-
>   include/linux/sched.h                         |  12 +
>   kernel/entry/common.c                         |  28 ++-
>   kernel/sched/core.c                           | 230 ++++++++++++++++++
>   kernel/sched/sched.h                          |   3 +
>   6 files changed, 285 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3236427e2215..a338d5d64c3d 100644
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
> index 0a1e20f8d4e8..a18ed60cedea 100644
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
> +unsigned long exit_to_user_get_work(void)

Function should be static.


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
> @@ -175,7 +198,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>   		 * enabled above.
>   		 */
>   		local_irq_disable_exit_to_user();
> -		ti_work = READ_ONCE(current_thread_info()->flags);
> +		ti_work = exit_to_user_get_work();
>   	}

What happen if the task is scheduled out in exit_to_user_mode_loop? (e.g. if it has
_TIF_NEED_RESCHED set). It will have call sched_core_unsafe_enter() and force siblings
to wait for it. So shouldn't sched_core_unsafe_exit() be called when the task is
scheduled out? (because it won't run anymore) And sched_core_unsafe_enter() when
the task is scheduled back in?


>   	/* Return the latest work state for arch_exit_to_user_mode() */
> @@ -184,9 +207,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
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
> index e05728bdb18c..bd206708fac2 100644
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
> @@ -4596,6 +4617,214 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
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
> +	/* We clear the thread flag only at the end, so need to check for it. */

Do you mean "no need to check for it" ?


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
> +	/* Ensure that on return to user/guest, we check whether to wait. */
> +	if (current->core_cookie)
> +		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
> +
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	rq = cpu_rq(cpu);
> +	if (!sched_core_enabled(rq))
> +		goto ret;

Should we clear TIF_UNSAFE_RET if (!sched_core_enabled(rq))? This would avoid calling
sched_core_wait_till_safe().


> +
> +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
> +	rq->core_this_unsafe_nest++;
> +
> +	/* Should not nest: enter() should only pair with exit(). */
> +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
> +		goto ret;

I would be more precise about the nesting comment: we don't nest not only because each
enter() is paired with an exit() but because each enter()/exit() is for a user context.
We can have nested interrupts but they will be for a kernel context so they won't enter/exit.

So I would say something like:

         /*
          * Should not nest: each enter() is paired with an exit(), and enter()/exit()
          * are done when coming from userspace. We can have nested interrupts between
          * enter()/exit() but they will originate from the kernel so they won't enter()
          * nor exit().
          */


> +
> +	raw_spin_lock(rq_lockp(rq));
> +	smt_mask = cpu_smt_mask(cpu);
> +
> +	/* Contribute this CPU's unsafe_enter() to core-wide unsafe_enter() count. */
> +	WRITE_ONCE(rq->core->core_unsafe_nest, rq->core->core_unsafe_nest + 1);

We are protected by the rq_lockp(rq) spinlock, but we still need to use WRITE_ONCE()
because sched_core_wait_till_safe() checks core_unsafe_next without taking rq_lockp(rq),
right? Shouldn't we be using smp_store_release() like sched_core_unsafe_exit() does?

In any case, it is worth having a comment why WRITE_ONCE() or smp_store_release() is
used.


> +
> +	if (WARN_ON_ONCE(rq->core->core_unsafe_nest == UINT_MAX))
> +		goto unlock;

It might be better checking if (rq->core->core_unsafe_nest >= cpumask_weight(smt_mask))
because we shouldn't exceed the number of siblings.

alex.


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
> +	/* Pair with smp_load_acquire() in sched_core_wait_till_safe(). */
> +	smp_store_release(&rq->core->core_unsafe_nest, nest - 1);
> +	raw_spin_unlock(rq_lockp(rq));
> +ret:
> +	local_irq_restore(flags);
> +}
> +
>   // XXX fairness/fwd progress conditions
>   /*
>    * Returns
> @@ -5019,6 +5248,7 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
>   			rq = cpu_rq(i);
>   			if (rq->core && rq->core == rq)
>   				core_rq = rq;
> +			init_sched_core_irq_work(rq);
>   		}
>   
>   		if (!core_rq)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f7e2d8a3be8e..4bcf3b1ddfb3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1059,12 +1059,15 @@ struct rq {
>   	unsigned int		core_enabled;
>   	unsigned int		core_sched_seq;
>   	struct rb_root		core_tree;
> +	struct irq_work		core_irq_work; /* To force HT into kernel */
> +	unsigned int		core_this_unsafe_nest;
>   
>   	/* shared state */
>   	unsigned int		core_task_seq;
>   	unsigned int		core_pick_seq;
>   	unsigned long		core_cookie;
>   	unsigned char		core_forceidle;
> +	unsigned int		core_unsafe_nest;
>   #endif
>   };
>   
> 
