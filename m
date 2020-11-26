Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4C2C4E75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 06:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbgKZFhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 00:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbgKZFhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 00:37:09 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49968C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 21:37:09 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 81so778063pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 21:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5o+Dumat2NlX82AXLmHlAmg0PvmMNFSgS5Yk8DSpU+A=;
        b=ftytV0K4U+kvjnFVmUm/XZGxpTRVqhvTXTlaHaa+CFlCzeaOfVY1Il6UrUErNKDKWn
         IVzqRfuvbmHoJQKtbksLRcrzLQggrE0DoTbGRHhf3/NZuw3YIJq7wawAV4G7p6KzvsqC
         hM0fpYSaPFejGgc1HNJgMVNiRU0POrj8+BblCCOSpR5FhX0HYmW3mhsNIq1RZoWB6Qmx
         bv7FXaCWv9jqW9EmWBHbFjYLwPe4+hvaQFcje+znyKI+HXwY6p/lRRsVkx0qTrH8Nkf0
         VWc8H/r/J/qL9cgox+Cv7Jy5by51sdk4zdwE+Fm2V+JdFBiArWigyEAk9EpMkHKL92TP
         /t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5o+Dumat2NlX82AXLmHlAmg0PvmMNFSgS5Yk8DSpU+A=;
        b=kvY6pAqWJmoiJZDKxBYO2Ek8snYwgZQjaOX5KxpMTx0dW5OiEjeNZjlYZ4dtufc54N
         vojKZtwHhnZt7HghI8J4FzO60ToUfJMTf0RGITxDN6+ke/KBA55AiAxCORPyAaW+6QAW
         RisLUiRzJw8u6Rjn2clK4UKy65fwU0T8yDziijGiTgkxs6KD5Acbnegf4WQeax/rSj5u
         EKnAaTtTMzmeEeuBmBHC6vvxHRgpxesGNQTD0NERl9tWqZkNTRmUsF9xTJYKRuiOI31x
         0u3xK53TkLulzqCvOAwRU/BsGJvRoLepDrsUK3Gw45yJBK6ZPMKGdT1EsO/uvG3zJA/9
         F3Gg==
X-Gm-Message-State: AOAM530aT1/VP42UGMZtiOCpveUGq/pkX9FW5yC2/ibHHRR87BSICXWk
        VQ3qk7EXaTTu2YNyhXmeVVY=
X-Google-Smtp-Source: ABdhPJzHx8tz65SYaOntzzohZCYF4Rz+mRugBTocKzpuJJOoFcnK5HaUIiVcHxOzXfR/B/qACe35FQ==
X-Received: by 2002:a17:90a:154a:: with SMTP id y10mr1755240pja.6.1606369028708;
        Wed, 25 Nov 2020 21:37:08 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id h32sm3470828pgl.36.2020.11.25.21.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 21:37:07 -0800 (PST)
Date:   Thu, 26 Nov 2020 16:37:04 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH -tip 18/32] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20201126053704.GH163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-19-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-19-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:48PM -0500, Joel Fernandes (Google) wrote:
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
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Aaron Lu <aaron.lwe@gmail.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  11 +
>  include/linux/entry-common.h                  |  12 +-
>  include/linux/sched.h                         |  12 +
>  kernel/entry/common.c                         |  28 +-
>  kernel/sched/core.c                           | 241 ++++++++++++++++++
>  kernel/sched/sched.h                          |   3 +
>  6 files changed, 304 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bd1a5b87a5e2..b185c6ed4aba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4678,6 +4678,17 @@
>  
>  	sbni=		[NET] Granch SBNI12 leased line adapter
>  
> +	sched_core_protect_kernel=
> +			[SCHED_CORE] Pause SMT siblings of a core running in
> +			user mode, if at least one of the siblings of the core
> +			is running in kernel mode. This is to guarantee that
> +			kernel data is not leaked to tasks which are not trusted
> +			by the kernel. A value of 0 disables protection, 1
> +			enables protection. The default is 1. Note that protection
> +			depends on the arch defining the _TIF_UNSAFE_RET flag.
> +			Further, for protecting VMEXIT, arch needs to call
> +			KVM entry/exit hooks.
> +
>  	sched_debug	[KNL] Enables verbose scheduler debug messages.
>  
>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1a128baf3628..022e1f114157 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -33,6 +33,10 @@
>  # define _TIF_PATCH_PENDING		(0)
>  #endif
>  
> +#ifndef _TIF_UNSAFE_RET
> +# define _TIF_UNSAFE_RET		(0)
> +#endif
> +
>  #ifndef _TIF_UPROBE
>  # define _TIF_UPROBE			(0)
>  #endif
> @@ -74,7 +78,7 @@
>  #define EXIT_TO_USER_MODE_WORK						\
>  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
>  	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
> -	 ARCH_EXIT_TO_USER_MODE_WORK)
> +	 _TIF_UNSAFE_RET | ARCH_EXIT_TO_USER_MODE_WORK)
>  
>  /**
>   * arch_check_user_regs - Architecture specific sanity check for user mode regs
> @@ -444,4 +448,10 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>   */
>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
>  
> +/* entry_kernel_protected - Is kernel protection on entry/exit into kernel supported? */
> +static inline bool entry_kernel_protected(void)
> +{
> +	return IS_ENABLED(CONFIG_SCHED_CORE) && sched_core_kernel_protected()
> +		&& _TIF_UNSAFE_RET != 0;
> +}
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7efce9c9d9cf..a60868165590 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2076,4 +2076,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
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
> index bc75c114c1b3..9d9d926f2a1c 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -28,6 +28,9 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>  
>  	instrumentation_begin();
>  	trace_hardirqs_off_finish();
> +
> +	if (entry_kernel_protected())
> +		sched_core_unsafe_enter();
>  	instrumentation_end();
>  }
>  
> @@ -145,6 +148,26 @@ static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
>  	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
>  }
>  
> +static unsigned long exit_to_user_get_work(void)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	if (!entry_kernel_protected())
> +		return ti_work;
> +
> +#ifdef CONFIG_SCHED_CORE

This #ifdef is not necessary, entry_kernel_protected() does this check
no? The code should also compile anyway from what I can see so far.

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
>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  					    unsigned long ti_work)
>  {
> @@ -182,7 +205,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  		 * enabled above.
>  		 */
>  		local_irq_disable_exit_to_user();
> -		ti_work = READ_ONCE(current_thread_info()->flags);
> +		ti_work = exit_to_user_get_work();
>  	}
>  
>  	/* Return the latest work state for arch_exit_to_user_mode() */
> @@ -191,9 +214,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
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
> index 20125431af87..7f807a84cc30 100644
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
> @@ -5092,6 +5113,225 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
>  	return a->core_cookie == b->core_cookie;
>  }
>  
> +/*
> + * Handler to attempt to enter kernel. It does nothing because the exit to
> + * usermode or guest mode will do the actual work (of waiting if needed).
> + */
> +static void sched_core_irq_work(struct irq_work *work)
> +{
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

Why do we need to deal with ti_check if sched_core_enabled() is false (two statements
above)

> +
> +	/* Down grade to allow interrupts to prevent stop_machine lockups.. */
> +	preempt_disable();
> +	local_irq_enable();
> +
> +	/*
> +	 * Wait till the core of this HT is not in an unsafe state.
> +	 *
> +	 * Pair with raw_spin_lock/unlock() in sched_core_unsafe_enter/exit().
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

I am not sure about the rules of this check, do we have to do this with
irq's disabled? Given that sched_core_enabled() can only change under
stop_machine, can't we optimize this check?

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

I am sure this is quite unlikely unless your concerned about overflows,
will this all eventually move to under SCHED_DEBUG?

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

Same as above

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
>  // XXX fairness/fwd progress conditions
>  /*
>   * Returns
> @@ -5497,6 +5737,7 @@ static inline void sched_core_cpu_starting(unsigned int cpu)
>  			rq = cpu_rq(i);
>  			if (rq->core && rq->core == rq)
>  				core_rq = rq;
> +			init_sched_core_irq_work(rq);
>  		}
>  
>  		if (!core_rq)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 615092cb693c..be6691337bbb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1074,6 +1074,8 @@ struct rq {
>  	unsigned int		core_enabled;
>  	unsigned int		core_sched_seq;
>  	struct rb_root		core_tree;
> +	struct irq_work		core_irq_work; /* To force HT into kernel */
> +	unsigned int		core_this_unsafe_nest;
>  
>  	/* shared state */
>  	unsigned int		core_task_seq;
> @@ -1081,6 +1083,7 @@ struct rq {
>  	unsigned long		core_cookie;
>  	unsigned char		core_forceidle;
>  	unsigned int		core_forceidle_seq;
> +	unsigned int		core_unsafe_nest;
>  #endif
>  };
>

Balbir Singh.
