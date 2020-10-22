Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD2295819
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508053AbgJVFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:48:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:27342 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502948AbgJVFsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:48:31 -0400
IronPort-SDR: sscgz1coVd+eQnMTV8T6HbSlmJAm2xlHM7gC2XeYXLDGMIMNoPVouK7b/l9AGlgWkzBmlSxzq+
 9ITj7YyUymzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="229100687"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="229100687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 22:48:30 -0700
IronPort-SDR: R2CJaVAWnlkKpCvLY/XOv3RtE16uUW8O8OUqbOpG2hy+fRAh/A8uDH0537/wt1IGTuVjblVzZZ
 peuiily166tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="359754605"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2020 22:48:13 -0700
Subject: Re: [PATCH v8 -tip 13/26] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
        chris.hyser@oracle.com, Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <5e6b425b-a158-67c0-872c-e55d3f747430@linux.intel.com>
Date:   Thu, 22 Oct 2020 13:48:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201020014336.2076526-14-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
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
>  .../admin-guide/kernel-parameters.txt         |   7 +
>  include/linux/entry-common.h                  |   2 +-
>  include/linux/sched.h                         |  12 +
>  kernel/entry/common.c                         |  25 +-
>  kernel/sched/core.c                           | 229 ++++++++++++++++++
>  kernel/sched/sched.h                          |   3 +
>  6 files changed, 275 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3236427e2215..48567110f709 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4678,6 +4678,13 @@
>  
>  	sbni=		[NET] Granch SBNI12 leased line adapter
>  
> +	sched_core_protect_kernel=
> +			[SCHED_CORE] Pause SMT siblings of a core running in
> +			user mode, if at least one of the siblings of the core
> +			is running in kernel mode. This is to guarantee that
> +			kernel data is not leaked to tasks which are not trusted
> +			by the kernel.
> +
>  	sched_debug	[KNL] Enables verbose scheduler debug messages.
>  
>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 474f29638d2c..260216de357b 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -69,7 +69,7 @@
>  
>  #define EXIT_TO_USER_MODE_WORK						\
>  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
> -	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
> +	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_UNSAFE_RET |	\
>  	 ARCH_EXIT_TO_USER_MODE_WORK)
>  
>  /**
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d38e904dd603..fe6f225bfbf9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2071,4 +2071,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
>  
>  const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
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
>  #endif
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 0a1e20f8d4e8..c8dc6b1b1f40 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -137,6 +137,26 @@ static __always_inline void exit_to_user_mode(void)
>  /* Workaround to allow gradual conversion of architecture code */
>  void __weak arch_do_signal(struct pt_regs *regs) { }
>  
> +unsigned long exit_to_user_get_work(void)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	if (IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
> +		return ti_work;
> +
> +#ifdef CONFIG_SCHED_CORE
> +	ti_work &= EXIT_TO_USER_MODE_WORK;
> +	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {

Though _TIF_UNSAFE_RET is not x86 specific, but I only saw the definition in x86.
I'm not sure if other SMT capable architectures are happy with this?


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
>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  					    unsigned long ti_work)
>  {
> @@ -175,7 +195,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  		 * enabled above.
>  		 */
>  		local_irq_disable_exit_to_user();
> -		ti_work = READ_ONCE(current_thread_info()->flags);
> +		ti_work = exit_to_user_get_work();
>  	}
>  
>  	/* Return the latest work state for arch_exit_to_user_mode() */
> @@ -184,9 +204,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  
>  static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
> -	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	unsigned long ti_work;
>  
>  	lockdep_assert_irqs_disabled();
> +	ti_work = exit_to_user_get_work();
>  
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02db5b024768..5a7aeaa914e3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -76,6 +76,27 @@ __read_mostly int scheduler_running;
>  
>  #ifdef CONFIG_SCHED_CORE
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
>  DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
>  
>  /* kernel prio, less is more */
> @@ -4596,6 +4617,214 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
>  	return a->core_cookie == b->core_cookie;
>  }
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
> +
> +	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
> +	rq->core_this_unsafe_nest++;
> +
> +	/* Should not nest: enter() should only pair with exit(). */
> +	if (WARN_ON_ONCE(rq->core_this_unsafe_nest != 1))
> +		goto ret;
> +
> +	raw_spin_lock(rq_lockp(rq));
> +	smt_mask = cpu_smt_mask(cpu);
> +
> +	/* Contribute this CPU's unsafe_enter() to core-wide unsafe_enter() count. */
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
> +	/* Pair with smp_load_acquire() in sched_core_wait_till_safe(). */
> +	smp_store_release(&rq->core->core_unsafe_nest, nest - 1);
> +	raw_spin_unlock(rq_lockp(rq));
> +ret:
> +	local_irq_restore(flags);
> +}
> +
>  // XXX fairness/fwd progress conditions
>  /*
>   * Returns
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f7e2d8a3be8e..4bcf3b1ddfb3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1059,12 +1059,15 @@ struct rq {
>  	unsigned int		core_enabled;
>  	unsigned int		core_sched_seq;
>  	struct rb_root		core_tree;
> +	struct irq_work		core_irq_work; /* To force HT into kernel */
> +	unsigned int		core_this_unsafe_nest;
>  
>  	/* shared state */
>  	unsigned int		core_task_seq;
>  	unsigned int		core_pick_seq;
>  	unsigned long		core_cookie;
>  	unsigned char		core_forceidle;
> +	unsigned int		core_unsafe_nest;
>  #endif
>  };
>  
> 

