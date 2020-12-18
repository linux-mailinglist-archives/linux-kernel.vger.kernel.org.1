Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD92DE8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgLRSAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:00:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLRSAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:00:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C1830E;
        Fri, 18 Dec 2020 09:59:52 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23BFD3F66E;
        Fri, 18 Dec 2020 09:59:51 -0800 (PST)
References: <20201218170919.2950-1-jiangshanlai@gmail.com> <20201218170919.2950-11-jiangshanlai@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip V2 10/10] workqueue: Fix affinity of kworkers when attaching into pool
In-reply-to: <20201218170919.2950-11-jiangshanlai@gmail.com>
Date:   Fri, 18 Dec 2020 17:59:45 +0000
Message-ID: <jhjpn37ro4u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/12/20 17:09, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> When worker_attach_to_pool() is called, we should not put the workers
> to pool->attrs->cpumask when there is not CPU online in it.
>
> We have to use wq_online_cpumask in worker_attach_to_pool() to check
> if pool->attrs->cpumask is valid rather than cpu_online_mask or
> cpu_active_mask due to gaps between stages in cpu hot[un]plug.
>
> So for that late-spawned per-CPU kworker case: the outgoing CPU should have
> already been cleared from wq_online_cpumask, so it gets its affinity reset
> to the possible mask and the subsequent wakeup will ensure it's put on an
> active CPU.
>
> To use wq_online_cpumask in worker_attach_to_pool(), we need to protect
> wq_online_cpumask in wq_pool_attach_mutex and we modify workqueue_online_cpu()
> and workqueue_offline_cpu() to enlarge wq_pool_attach_mutex protected
> region. We also put updating wq_online_cpumask and [re|un]bind_workers()
> in the same wq_pool_attach_mutex protected region to make the update
> for percpu workqueue atomically.
>
> Cc: Qian Cai <cai@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> Link: https://lore.kernel.org/lkml/20201210163830.21514-3-valentin.schneider@arm.com/
> Acked-by: Valentin Schneider <valentin.schneider@arm.com>

So an etiquette thing: I never actually gave an Acked-by. I did say it
looked good to me, and that probably should've been bundled with a
Reviewed-by, but it wasn't (I figured I'd wait for v2). Forging is bad,
m'kay.

When in doubt (e.g. someone says they're ok with your patch but don't give
any Ack/Reviewed-by), just ask via mail or on IRC.

For now, please make this a:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/workqueue.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 65270729454c..eeb726598f80 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -310,7 +310,7 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
>  /* PL: allowable cpus for unbound wqs and work items */
>  static cpumask_var_t wq_unbound_cpumask;
>
> -/* PL: online cpus (cpu_online_mask with the going-down cpu cleared) */
> +/* PL&A: online cpus (cpu_online_mask with the going-down cpu cleared) */
>  static cpumask_var_t wq_online_cpumask;
>
>  /* CPU where unbound work was last round robin scheduled from this CPU */
> @@ -1848,11 +1848,11 @@ static void worker_attach_to_pool(struct worker *worker,
>  {
>       mutex_lock(&wq_pool_attach_mutex);
>
> -	/*
> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> -	 */
> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	/* Is there any cpu in pool->attrs->cpumask online? */
> +	if (cpumask_intersects(pool->attrs->cpumask, wq_online_cpumask))
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
> +	else
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>
>       /*
>        * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
> @@ -5081,13 +5081,12 @@ int workqueue_online_cpu(unsigned int cpu)
>       int pi;
>
>       mutex_lock(&wq_pool_mutex);
> -	cpumask_set_cpu(cpu, wq_online_cpumask);
>
> -	for_each_cpu_worker_pool(pool, cpu) {
> -		mutex_lock(&wq_pool_attach_mutex);
> +	mutex_lock(&wq_pool_attach_mutex);
> +	cpumask_set_cpu(cpu, wq_online_cpumask);
> +	for_each_cpu_worker_pool(pool, cpu)
>               rebind_workers(pool);
> -		mutex_unlock(&wq_pool_attach_mutex);
> -	}
> +	mutex_unlock(&wq_pool_attach_mutex);
>
>       /* update CPU affinity of workers of unbound pools */
>       for_each_pool(pool, pi) {
> @@ -5117,14 +5116,13 @@ int workqueue_offline_cpu(unsigned int cpu)
>       if (WARN_ON(cpu != smp_processor_id()))
>               return -1;
>
> -	for_each_cpu_worker_pool(pool, cpu) {
> -		mutex_lock(&wq_pool_attach_mutex);
> -		unbind_workers(pool);
> -		mutex_unlock(&wq_pool_attach_mutex);
> -	}
> -
>       mutex_lock(&wq_pool_mutex);
> +
> +	mutex_lock(&wq_pool_attach_mutex);
>       cpumask_clear_cpu(cpu, wq_online_cpumask);
> +	for_each_cpu_worker_pool(pool, cpu)
> +		unbind_workers(pool);
> +	mutex_unlock(&wq_pool_attach_mutex);
>
>       /* update CPU affinity of workers of unbound pools */
>       for_each_pool(pool, pi) {
