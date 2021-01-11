Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944532F1D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbhAKSJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389750AbhAKSJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:09:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44C8F223C8;
        Mon, 11 Jan 2021 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610388547;
        bh=IIhrxD+dCVr8eZ4VKDyDJS9h2Ifj8FSug4zcvfBIoYU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MeXbhZFcot/ZwthLtQ3LvLWV8iflMrXKZJIQNR6I0CmFky7ceRQRiAgn7vHsJStUj
         aSPESvEUeXl5m6ip08MaSoqZjtrZ2XFkUaPLSaDdgv+F5pgfakbq1vPE+9qsVi5bMV
         QI0WlX2giu8hZtmpPq6KX/pUzMWnZXeFXazPFJJoGYUdnUdETWl766vCbBYetqYVvu
         ZVLLEAiaSU1MTcbR/sSwiufx9k6oH6TRFCD4YdXKuQeuXBkePhBFOg5yTIlz0yu95n
         t7NEdPUIZaYUJUSv9aeFyOGuQU1j90UKLTDGvVmHzs2eUWDvd+9LmtuLvd9wnt8RuG
         0+qJumJIPtfbQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 152C93522A7B; Mon, 11 Jan 2021 10:09:07 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:09:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <20210111180907.GE2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:16:39PM +0100, Peter Zijlstra wrote:
> 
> While thinking more about this, I'm thinking a big part of the problem
> is that we're not dinstinguishing between geniuine per-cpu kthreads and
> kthreads that just happen to be per-cpu.
> 
> Geniuine per-cpu kthreads are kthread_bind() and have PF_NO_SETAFFINITY,
> but sadly a lot of non-per-cpu kthreads, that might happen to still be
> per-cpu also have that -- again workqueue does that even to it's unbound
> workers :-(
> 
> Now, anything created by smpboot, is created through
> kthread_create_on_cpu() and that additionally sets to_kthread(p)->flags
> KTHREAD_IS_PER_CPU.
> 
> And I'm thinking that might be sufficient, if we modify
> is_per_cpu_kthread() to check that, then we only match smpboot threads
> (which include the hotplug and stopper threads, but notably not the idle
> thread)
> 
> Sadly it appears like io_uring() uses kthread_create_on_cpu() without
> then having any hotplug crud on, so that needs additinoal frobbing.
> 
> Also, init_task is PF_KTHREAD but doesn't have a struct kthread on.. and
> I suppose bound workqueues don't go through this either.
> 
> Let me rummage around a bit...
> 
> This seems to not insta-explode... opinions?

It passes quick tests on -rcu both with and without the rcutorture fixes,
which is encouraging.  I will start a more vigorous test in about an hour.

							Thanx, Paul

> ---
>  include/linux/kthread.h |  3 +++
>  kernel/kthread.c        | 25 ++++++++++++++++++++++++-
>  kernel/sched/core.c     |  2 +-
>  kernel/sched/sched.h    |  4 ++--
>  kernel/smpboot.c        |  1 +
>  kernel/workqueue.c      | 12 +++++++++---
>  6 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 65b81e0c494d..fdd5a52e35d8 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -33,6 +33,9 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
>  					  unsigned int cpu,
>  					  const char *namefmt);
>  
> +void kthread_set_per_cpu(struct task_struct *k, bool set);
> +bool kthread_is_per_cpu(struct task_struct *k);
> +
>  /**
>   * kthread_run - create and wake a thread.
>   * @threadfn: the function to run until signal_pending(current).
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index a5eceecd4513..7f081530e459 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -493,11 +493,34 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
>  		return p;
>  	kthread_bind(p, cpu);
>  	/* CPU hotplug need to bind once again when unparking the thread. */
> -	set_bit(KTHREAD_IS_PER_CPU, &to_kthread(p)->flags);
>  	to_kthread(p)->cpu = cpu;
>  	return p;
>  }
>  
> +void kthread_set_per_cpu(struct task_struct *k, bool set)
> +{
> +	struct kthread *kthread = to_kthread(k);
> +	if (!kthread)
> +		return;
> +
> +	if (set) {
> +		WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> +		WARN_ON_ONCE(k->nr_cpus_allowed != 1);
> +		set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> +	} else {
> +		clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> +	}
> +}
> +
> +bool kthread_is_per_cpu(struct task_struct *k)
> +{
> +	struct kthread *kthread = to_kthread(k);
> +	if (!kthread)
> +		return false;
> +
> +	return test_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> +}
> +
>  /**
>   * kthread_unpark - unpark a thread created by kthread_create().
>   * @k:		thread created by kthread_create().
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 15d2562118d1..e71f9e44789e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7277,7 +7277,7 @@ static void balance_push(struct rq *rq)
>  	 * Both the cpu-hotplug and stop task are in this case and are
>  	 * required to complete the hotplug process.
>  	 */
> -	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> +	if (rq->idle == push_task || is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
>  		/*
>  		 * If this is the idle task on the outgoing CPU try to wake
>  		 * up the hotplug control thread which might wait for the
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 12ada79d40f3..3679f63e0aa2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2697,10 +2697,10 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
>  	if (!(p->flags & PF_KTHREAD))
>  		return false;
>  
> -	if (p->nr_cpus_allowed != 1)
> +	if (!(p->flags & PF_NO_SETAFFINITY))
>  		return false;
>  
> -	return true;
> +	return kthread_is_per_cpu(p);
>  }
>  #endif
>  
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index 2efe1e206167..b0abe575a524 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -188,6 +188,7 @@ __smpboot_create_thread(struct smp_hotplug_thread *ht, unsigned int cpu)
>  		kfree(td);
>  		return PTR_ERR(tsk);
>  	}
> +	kthread_set_per_cpu(tsk, true);
>  	/*
>  	 * Park the thread so that it could start right on the CPU
>  	 * when it is available.
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9880b6c0e272..824276e4fb2e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct worker *worker,
>  	 */
>  	if (pool->flags & POOL_DISASSOCIATED)
>  		worker->flags |= WORKER_UNBOUND;
> +	else
> +		kthread_set_per_cpu(worker->task, true);
>  
>  	list_add_tail(&worker->node, &pool->workers);
>  	worker->pool = pool;
> @@ -4919,8 +4921,10 @@ static void unbind_workers(int cpu)
>  
>  		raw_spin_unlock_irq(&pool->lock);
>  
> -		for_each_pool_worker(worker, pool)
> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
> +		for_each_pool_worker(worker, pool) {
> +			kthread_set_per_cpu(worker->task, false);
> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> +		}
>  
>  		mutex_unlock(&wq_pool_attach_mutex);
>  
> @@ -4972,9 +4976,11 @@ static void rebind_workers(struct worker_pool *pool)
>  	 * of all workers first and then clear UNBOUND.  As we're called
>  	 * from CPU_ONLINE, the following shouldn't fail.
>  	 */
> -	for_each_pool_worker(worker, pool)
> +	for_each_pool_worker(worker, pool) {
>  		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>  						  pool->attrs->cpumask) < 0);
> +		kthread_set_per_cpu(worker->task, true);
> +	}
>  
>  	raw_spin_lock_irq(&pool->lock);
>  
