Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2258E22CCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 20:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXSBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 14:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgGXSBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:01:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4138206D8;
        Fri, 24 Jul 2020 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595613665;
        bh=TqSnL8SxL7jBAfjFnHCQUO7sdQI61//W9rS2XR35/oI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rtXHgyu/QE2oNc5m6N6PrhL6Go3jRxxkvQSa4GzUDG8Tx1+W46mCDjhb8NFtZGrER
         QSdCLv2W7JGAWh4lyR2UrimGoq1VcJt0i685DnMEg23L2XINNPZiaBOoHnFDrGjuHs
         zwa1+WtIVl8bfjThPLIJJ+M5r0iFbDFpbPBef0N0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C63D03520BD1; Fri, 24 Jul 2020 11:01:04 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:01:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 2/9] smp: Cleanup smp_call_function*()
Message-ID: <20200724180104.GB23103@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200722150149.525408253@infradead.org>
 <20200722153017.094205861@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722153017.094205861@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:01:51PM +0200, Peter Zijlstra wrote:
> Get rid of the __call_single_node union and cleanup the API a little
> to avoid external code relying on the structure layout as much.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/mips/kernel/process.c                      |    5 +--
>  arch/mips/kernel/smp.c                          |   25 +++------------
>  arch/s390/pci/pci_irq.c                         |    4 --
>  arch/x86/kernel/cpuid.c                         |    7 +---
>  arch/x86/lib/msr-smp.c                          |    7 +---
>  block/blk-mq.c                                  |    4 --
>  drivers/cpuidle/coupled.c                       |    3 -
>  drivers/net/ethernet/cavium/liquidio/lio_core.c |    9 +----
>  include/linux/smp.h                             |   16 +++++----
>  kernel/debug/debug_core.c                       |    6 +--
>  kernel/sched/core.c                             |   12 +------
>  kernel/smp.c                                    |   40 ++++++++++++------------
>  net/core/dev.c                                  |    3 -
>  13 files changed, 55 insertions(+), 86 deletions(-)
> 
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -687,7 +687,6 @@ unsigned long arch_align_stack(unsigned
>  	return sp & ALMASK;
>  }
>  
> -static DEFINE_PER_CPU(call_single_data_t, backtrace_csd);
>  static struct cpumask backtrace_csd_busy;
>  
>  static void handle_backtrace(void *info)
> @@ -696,6 +695,9 @@ static void handle_backtrace(void *info)
>  	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
>  }
>  
> +static DEFINE_PER_CPU(call_single_data_t, backtrace_csd) =
> +	CSD_INIT(handle_backtrace, NULL);
> +
>  static void raise_backtrace(cpumask_t *mask)
>  {
>  	call_single_data_t *csd;
> @@ -715,7 +717,6 @@ static void raise_backtrace(cpumask_t *m
>  		}
>  
>  		csd = &per_cpu(backtrace_csd, cpu);
> -		csd->func = handle_backtrace;
>  		smp_call_function_single_async(cpu, csd);
>  	}
>  }
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -687,36 +687,23 @@ EXPORT_SYMBOL(flush_tlb_one);
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  
> -static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd);
> -
> -void tick_broadcast(const struct cpumask *mask)
> -{
> -	call_single_data_t *csd;
> -	int cpu;
> -
> -	for_each_cpu(cpu, mask) {
> -		csd = &per_cpu(tick_broadcast_csd, cpu);
> -		smp_call_function_single_async(cpu, csd);
> -	}
> -}
> -
>  static void tick_broadcast_callee(void *info)
>  {
>  	tick_receive_broadcast();
>  }
>  
> -static int __init tick_broadcast_init(void)
> +static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd) =
> +	CSD_INIT(tick_broadcast_callee, NULL);
> +
> +void tick_broadcast(const struct cpumask *mask)
>  {
>  	call_single_data_t *csd;
>  	int cpu;
>  
> -	for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +	for_each_cpu(cpu, mask) {
>  		csd = &per_cpu(tick_broadcast_csd, cpu);
> -		csd->func = tick_broadcast_callee;
> +		smp_call_function_single_async(cpu, csd);
>  	}
> -
> -	return 0;
>  }
> -early_initcall(tick_broadcast_init);
>  
>  #endif /* CONFIG_GENERIC_CLOCKEVENTS_BROADCAST */
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(voi
>  		if (atomic_inc_return(&cpu_data->scheduled) > 1)
>  			continue;
>  
> -		cpu_data->csd.func = zpci_handle_remote_irq;
> -		cpu_data->csd.info = &cpu_data->scheduled;
> -		cpu_data->csd.flags = 0;
> +		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq, &cpu_data->scheduled);
>  		smp_call_function_single_async(cpu, &cpu_data->csd);
>  	}
>  }
> --- a/arch/x86/kernel/cpuid.c
> +++ b/arch/x86/kernel/cpuid.c
> @@ -74,10 +74,9 @@ static ssize_t cpuid_read(struct file *f
>  
>  	init_completion(&cmd.done);
>  	for (; count; count -= 16) {
> -		call_single_data_t csd = {
> -			.func = cpuid_smp_cpuid,
> -			.info = &cmd,
> -		};
> +		call_single_data_t csd;
> +
> +		INIT_CSD(&csd, cpuid_smp_cpuid, &cmd);
>  
>  		cmd.regs.eax = pos;
>  		cmd.regs.ecx = pos >> 32;
> --- a/arch/x86/lib/msr-smp.c
> +++ b/arch/x86/lib/msr-smp.c
> @@ -169,12 +169,11 @@ static void __wrmsr_safe_on_cpu(void *in
>  int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
>  {
>  	struct msr_info_completion rv;
> -	call_single_data_t csd = {
> -		.func	= __rdmsr_safe_on_cpu,
> -		.info	= &rv,
> -	};
> +	call_single_data_t csd;
>  	int err;
>  
> +	INIT_CSD(&csd, __rdmsr_safe_on_cpu, &rv);
> +
>  	memset(&rv, 0, sizeof(rv));
>  	init_completion(&rv.done);
>  	rv.msr.msr_no = msr_no;
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -672,9 +672,7 @@ bool blk_mq_complete_request_remote(stru
>  		return false;
>  
>  	if (blk_mq_complete_need_ipi(rq)) {
> -		rq->csd.func = __blk_mq_complete_request_remote;
> -		rq->csd.info = rq;
> -		rq->csd.flags = 0;
> +		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
>  		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
>  	} else {
>  		if (rq->q->nr_hw_queues > 1)
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -674,8 +674,7 @@ int cpuidle_coupled_register_device(stru
>  	coupled->refcnt++;
>  
>  	csd = &per_cpu(cpuidle_coupled_poke_cb, dev->cpu);
> -	csd->func = cpuidle_coupled_handle_poke;
> -	csd->info = (void *)(unsigned long)dev->cpu;
> +	INIT_CSD(csd, cpuidle_coupled_handle_poke, (void *)(unsigned long)dev->cpu);
>  
>  	return 0;
>  }
> --- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
> @@ -726,13 +726,8 @@ static void liquidio_napi_drv_callback(v
>  	    droq->cpu_id == this_cpu) {
>  		napi_schedule_irqoff(&droq->napi);
>  	} else {
> -		call_single_data_t *csd = &droq->csd;
> -
> -		csd->func = napi_schedule_wrapper;
> -		csd->info = &droq->napi;
> -		csd->flags = 0;
> -
> -		smp_call_function_single_async(droq->cpu_id, csd);
> +		INIT_CSD(&droq->csd, napi_schedule_wrapper, &droq->napi);
> +		smp_call_function_single_async(droq->cpu_id, &droq->csd);
>  	}
>  }
>  
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -21,21 +21,23 @@ typedef bool (*smp_cond_func_t)(int cpu,
>   * structure shares (partial) layout with struct irq_work
>   */
>  struct __call_single_data {
> -	union {
> -		struct __call_single_node node;
> -		struct {
> -			struct llist_node llist;
> -			unsigned int flags;
> -		};
> -	};
> +	struct __call_single_node node;
>  	smp_call_func_t func;
>  	void *info;
>  };
>  
> +#define CSD_INIT(_func, _info) \
> +	(struct __call_single_data){ .func = (_func), .info = (_info), }
> +
>  /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
>  typedef struct __call_single_data call_single_data_t
>  	__aligned(sizeof(struct __call_single_data));
>  
> +#define INIT_CSD(_csd, _func, _info)		\
> +do {						\
> +	*(_csd) = CSD_INIT((_func), (_info));	\
> +} while (0)
> +
>  /*
>   * Enqueue a llist_node on the call_single_queue; be very careful, read
>   * flush_smp_call_function_queue() in detail.
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -225,8 +225,6 @@ int __weak kgdb_skipexception(int except
>   * Default (weak) implementation for kgdb_roundup_cpus
>   */
>  
> -static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> -
>  void __weak kgdb_call_nmi_hook(void *ignored)
>  {
>  	/*
> @@ -240,6 +238,9 @@ void __weak kgdb_call_nmi_hook(void *ign
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
> +	CSD_INIT(kgdb_call_nmi_hook, NULL);
> +
>  void __weak kgdb_roundup_cpus(void)
>  {
>  	call_single_data_t *csd;
> @@ -266,7 +267,6 @@ void __weak kgdb_roundup_cpus(void)
>  			continue;
>  		kgdb_info[cpu].rounding_up = true;
>  
> -		csd->func = kgdb_call_nmi_hook;
>  		ret = smp_call_function_single_async(cpu, csd);
>  		if (ret)
>  			kgdb_info[cpu].rounding_up = false;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -223,14 +223,6 @@ void update_rq_clock(struct rq *rq)
>  	update_rq_clock_task(rq, delta);
>  }
>  
> -static inline void
> -rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
> -{
> -	csd->flags = 0;
> -	csd->func = func;
> -	csd->info = rq;
> -}
> -
>  #ifdef CONFIG_SCHED_HRTICK
>  /*
>   * Use HR-timers to deliver accurate preemption points.
> @@ -331,7 +323,7 @@ void hrtick_start(struct rq *rq, u64 del
>  static void hrtick_rq_init(struct rq *rq)
>  {
>  #ifdef CONFIG_SMP
> -	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
> +	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
>  #endif
>  	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>  	rq->hrtick_timer.function = hrtick;
> @@ -6835,7 +6827,7 @@ void __init sched_init(void)
>  		rq->last_blocked_load_update_tick = jiffies;
>  		atomic_set(&rq->nohz_flags, 0);
>  
> -		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
> +		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
>  #endif
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -24,7 +24,7 @@
>  #include "smpboot.h"
>  #include "sched/smp.h"
>  
> -#define CSD_TYPE(_csd)	((_csd)->flags & CSD_FLAG_TYPE_MASK)
> +#define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
>  
>  struct call_function_data {
>  	call_single_data_t	__percpu *csd;
> @@ -105,13 +105,13 @@ void __init call_function_init(void)
>   */
>  static __always_inline void csd_lock_wait(call_single_data_t *csd)
>  {
> -	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
> +	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
>  }
>  
>  static __always_inline void csd_lock(call_single_data_t *csd)
>  {
>  	csd_lock_wait(csd);
> -	csd->flags |= CSD_FLAG_LOCK;
> +	csd->node.u_flags |= CSD_FLAG_LOCK;
>  
>  	/*
>  	 * prevent CPU from reordering the above assignment
> @@ -123,12 +123,12 @@ static __always_inline void csd_lock(cal
>  
>  static __always_inline void csd_unlock(call_single_data_t *csd)
>  {
> -	WARN_ON(!(csd->flags & CSD_FLAG_LOCK));
> +	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
>  
>  	/*
>  	 * ensure we're all done before releasing data:
>  	 */
> -	smp_store_release(&csd->flags, 0);
> +	smp_store_release(&csd->node.u_flags, 0);
>  }
>  
>  static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
> @@ -178,7 +178,7 @@ static int generic_exec_single(int cpu,
>  		return -ENXIO;
>  	}
>  
> -	__smp_call_single_queue(cpu, &csd->llist);
> +	__smp_call_single_queue(cpu, &csd->node.llist);
>  
>  	return 0;
>  }
> @@ -231,7 +231,7 @@ static void flush_smp_call_function_queu
>  		 * We don't have to use the _safe() variant here
>  		 * because we are not invoking the IPI handlers yet.
>  		 */
> -		llist_for_each_entry(csd, entry, llist) {
> +		llist_for_each_entry(csd, entry, node.llist) {
>  			switch (CSD_TYPE(csd)) {
>  			case CSD_TYPE_ASYNC:
>  			case CSD_TYPE_SYNC:
> @@ -256,22 +256,22 @@ static void flush_smp_call_function_queu
>  	 * First; run all SYNC callbacks, people are waiting for us.
>  	 */
>  	prev = NULL;
> -	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
> +	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
>  		/* Do we wait until *after* callback? */
>  		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
>  			smp_call_func_t func = csd->func;
>  			void *info = csd->info;
>  
>  			if (prev) {
> -				prev->next = &csd_next->llist;
> +				prev->next = &csd_next->node.llist;
>  			} else {
> -				entry = &csd_next->llist;
> +				entry = &csd_next->node.llist;
>  			}
>  
>  			func(info);
>  			csd_unlock(csd);
>  		} else {
> -			prev = &csd->llist;
> +			prev = &csd->node.llist;
>  		}
>  	}
>  
> @@ -282,14 +282,14 @@ static void flush_smp_call_function_queu
>  	 * Second; run all !SYNC callbacks.
>  	 */
>  	prev = NULL;
> -	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
> +	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
>  		int type = CSD_TYPE(csd);
>  
>  		if (type != CSD_TYPE_TTWU) {
>  			if (prev) {
> -				prev->next = &csd_next->llist;
> +				prev->next = &csd_next->node.llist;
>  			} else {
> -				entry = &csd_next->llist;
> +				entry = &csd_next->node.llist;
>  			}
>  
>  			if (type == CSD_TYPE_ASYNC) {
> @@ -303,7 +303,7 @@ static void flush_smp_call_function_queu
>  			}
>  
>  		} else {
> -			prev = &csd->llist;
> +			prev = &csd->node.llist;
>  		}
>  	}
>  
> @@ -339,7 +339,7 @@ int smp_call_function_single(int cpu, sm
>  {
>  	call_single_data_t *csd;
>  	call_single_data_t csd_stack = {
> -		.flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC,
> +		.node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
>  	};
>  	int this_cpu;
>  	int err;
> @@ -414,12 +414,12 @@ int smp_call_function_single_async(int c
>  
>  	preempt_disable();
>  
> -	if (csd->flags & CSD_FLAG_LOCK) {
> +	if (csd->node.u_flags & CSD_FLAG_LOCK) {
>  		err = -EBUSY;
>  		goto out;
>  	}
>  
> -	csd->flags = CSD_FLAG_LOCK;
> +	csd->node.u_flags = CSD_FLAG_LOCK;
>  	smp_wmb();
>  
>  	err = generic_exec_single(cpu, csd);
> @@ -537,10 +537,10 @@ static void smp_call_function_many_cond(
>  
>  		csd_lock(csd);
>  		if (wait)
> -			csd->flags |= CSD_TYPE_SYNC;
> +			csd->node.u_flags |= CSD_TYPE_SYNC;
>  		csd->func = func;
>  		csd->info = info;
> -		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
> +		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
>  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
>  	}
>  
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10661,8 +10661,7 @@ static int __init net_dev_init(void)
>  		INIT_LIST_HEAD(&sd->poll_list);
>  		sd->output_queue_tailp = &sd->output_queue;
>  #ifdef CONFIG_RPS
> -		sd->csd.func = rps_trigger_softirq;
> -		sd->csd.info = sd;
> +		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
>  		sd->cpu = i;
>  #endif
>  
> 
> 
