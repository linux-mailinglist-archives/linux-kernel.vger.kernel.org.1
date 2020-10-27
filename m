Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8A29BD16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811741AbgJ0QlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:41:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1811377AbgJ0Qj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:39:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603816766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJiJEDE7myKOzJJqcrQBhP723tRBZzPCt0xyjegCZyo=;
        b=oOZF8j5VcLBB2Biij0BPnfG/VVSqF2d3+xea/rKuifEOdHDT68ztD1z7gEH+zb9CiCA5Fm
        kucIxddP/TmoPdWgMiAhzkAk9Mj9P+QZEnLIHKUb+V3eJCc7ZaC1ZZrZbmk2ik6IxLr8L8
        pp9AGWkaMP+9+gsw2VfGcQRrM3FoRQo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54316B2B5;
        Tue, 27 Oct 2020 16:39:26 +0000 (UTC)
Date:   Tue, 27 Oct 2020 17:39:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kthread_worker: re-set CPU affinities if CPU come online
Message-ID: <20201027163925.GE31882@alley>
References: <20201026065213.30477-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026065213.30477-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-10-26 14:52:13, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> When someone CPU offlined, the 'kthread_worker' which bind this CPU,
> will run anywhere, if this CPU online, recovery of 'kthread_worker'
> affinity by cpuhp notifiers.

I am not familiar with CPU hotplug notifiers. I rather add Thomas and
Peter into Cc.

> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  include/linux/kthread.h |  2 ++
>  kernel/kthread.c        | 35 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 65b81e0c494d..5acbf2e731cb 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -93,6 +93,8 @@ struct kthread_worker {
>  	struct list_head	delayed_work_list;
>  	struct task_struct	*task;
>  	struct kthread_work	*current_work;
> +	struct hlist_node       cpuhp_node;
> +	int                     bind_cpu;
>  };
>  
>  struct kthread_work {
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index e29773c82b70..68968832777f 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -28,8 +28,10 @@
>  #include <linux/uaccess.h>
>  #include <linux/numa.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/cpu.h>
>  #include <trace/events/sched.h>
>  
> +static enum cpuhp_state kworker_online;

Please, use kthread_worker_online.

I know that it is too long but it is used everywhere. Consistency
is useful when searching and reading the code.

>  static DEFINE_SPINLOCK(kthread_create_lock);
>  static LIST_HEAD(kthread_create_list);
> @@ -649,6 +651,8 @@ void __kthread_init_worker(struct kthread_worker *worker,
>  	lockdep_set_class_and_name(&worker->lock, key, name);
>  	INIT_LIST_HEAD(&worker->work_list);
>  	INIT_LIST_HEAD(&worker->delayed_work_list);
> +	worker->bind_cpu = -1;
> +	INIT_HLIST_NODE(&worker->cpuhp_node);

Same has to be done also in KTHREAD_WORKER_INIT macro defined
in include/linux/kthread.h.

>  }
>  EXPORT_SYMBOL_GPL(__kthread_init_worker);
>  
> @@ -737,8 +741,11 @@ __kthread_create_worker(int cpu, unsigned int flags,
>  	if (IS_ERR(task))
>  		goto fail_task;
>  
> -	if (cpu >= 0)
> +	if (cpu >= 0) {
>  		kthread_bind(task, cpu);
> +		worker->bind_cpu = cpu;
> +		cpuhp_state_add_instance_nocalls(kworker_online, &worker->cpuhp_node);

There is a rather theoretical race that the CPU might get down and up
between kthread_bind() and adding the callback.

It actually won't be a problem because the kthread_worker is still not
running at this stage and will not get migrated.

But I would switch the order just to be on the safe side and avoid
doubts about this race.


> +	}
>  
>  	worker->flags = flags;
>  	worker->task = task;
> @@ -1220,6 +1227,9 @@ void kthread_destroy_worker(struct kthread_worker *worker)
>  	if (WARN_ON(!task))
>  		return;
>  
> +	if (worker->bind_cpu >= 0)
> +		cpuhp_state_remove_instance_nocalls(kworker_online, &worker->cpuhp_node);
> +
>  	kthread_flush_worker(worker);
>  	kthread_stop(task);
>  	WARN_ON(!list_empty(&worker->work_list));
> @@ -1227,6 +1237,29 @@ void kthread_destroy_worker(struct kthread_worker *worker)
>  }
>  EXPORT_SYMBOL(kthread_destroy_worker);
>  
> +static int kworker_cpu_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct kthread_worker *worker = hlist_entry(node, struct kthread_worker, cpuhp_node);

The code here looks correct.

JFYI, I was curious why many cpuhp callbacks used hlist_entry_safe().
But they did not check for NULL. Hence the _safe() variant did
not really prevented any crash.

I seems that it was a cargo-cult programming. cpuhp_invoke_callback() calls
simple hlist_for_each(). If I get it correctly, the operations are
synchronized by cpus_read_lock()/cpus_write_lock() and _safe variant
really is not needed.


> +	struct task_struct *task = worker->task;
> +

The WARN_ON_ONCE() below would trigger only where there is a bug in
the CPU hotplug code. Please, add a comment explaining that it is
a rather theoretical situation. Something like in the workqueue code:

	/* as we're called from CPU_ONLINE, the following shouldn't fail */

> +	if (cpu == worker->bind_cpu)
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpumask_of(cpu)) < 0);
>
> +	return 0;
> +}
> +
> +static __init int kthread_worker_hotplug_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "kthread-worker/online",
> +					kworker_cpu_online, NULL);
> +	if (ret < 0)
> +		return ret;
> +	kworker_online = ret;
> +	return 0;
> +}
> +subsys_initcall(kthread_worker_hotplug_init);

I would make it core_initcall(), It is built-in and should be usable
as early as possible.

Otherwise, the patch looks fine to me. Great catch!

Best Regards,
Petr

> +
>  /**
>   * kthread_use_mm - make the calling kthread operate on an address space
>   * @mm: address space to operate on
> -- 
> 2.17.1
