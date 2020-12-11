Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625A72D74D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405095AbgLKLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:40:50 -0500
Received: from foss.arm.com ([217.140.110.172]:51768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbgLKLkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:40:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B97031B;
        Fri, 11 Dec 2020 03:39:29 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09F9D3F68F;
        Fri, 11 Dec 2020 03:39:26 -0800 (PST)
Date:   Fri, 11 Dec 2020 11:39:21 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during
 late hotplug
Message-ID: <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
 <20201210163830.21514-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210163830.21514-3-valentin.schneider@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Thu, Dec 10, 2020 at 04:38:30PM +0000, Valentin Schneider wrote:
> Per-CPU kworkers forcefully migrated away by hotplug via
> workqueue_offline_cpu() can end up spawning more kworkers via
> 
>   manage_workers() -> maybe_create_worker()
> 
> Workers created at this point will be bound using
> 
>   pool->attrs->cpumask
> 
> which in this case is wrong, as the hotplug state machine already migrated
> all pinned kworkers away from this CPU. This ends up triggering the BUG_ON
> condition is sched_cpu_dying() (i.e. there's a kworker enqueued on the
> dying rq).
> 
> Special-case workers being attached to DISASSOCIATED pools and bind them to
> cpu_active_mask, mimicking them being present when workqueue_offline_cpu()
> was invoked.
> 
> Link: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
> Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")

Isn't the problem introduced by 1cf12e0 ("sched/hotplug: Consolidate
task migration on CPU unplug") ?

Previously we had:

 AP_WORKQUEUE_ONLINE -> set POOL_DISASSOCIATED
   ...
 TEARDOWN_CPU -> clear CPU in cpu_online_mask
   |
   |-AP_SCHED_STARTING -> migrate_tasks()
   |
  AP_OFFLINE

worker_attach_to_pool(), is "protected" by the cpu_online_mask in
set_cpus_allowed_ptr(). IIUC, now, the tasks being migrated before the
cpu_online_mask is actually flipped, there's a window, between
CPUHP_AP_SCHED_WAIT_EMPTY and CPUHP_TEARDOWN_CPU where a kworker can wake-up
a new one, for the hotunplugged pool that wouldn't be caught by the
hotunplug migration.

> Reported-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/workqueue.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9880b6c0e272..fb1418edf85c 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1848,19 +1848,29 @@ static void worker_attach_to_pool(struct worker *worker,
>  {
>  	mutex_lock(&wq_pool_attach_mutex);
>  
> -	/*
> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> -	 */
> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> -
>  	/*
>  	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>  	 * stable across this function.  See the comments above the flag
>  	 * definition for details.
> +	 *
> +	 * Worker might get attached to a pool *after* workqueue_offline_cpu()
> +	 * was run - e.g. created by manage_workers() from a kworker which was
> +	 * forcefully moved away by hotplug. Kworkers created from this point on
> +	 * need to have their affinity changed as if they were present during
> +	 * workqueue_offline_cpu().
> +	 *
> +	 * This will be resolved in rebind_workers().
>  	 */
> -	if (pool->flags & POOL_DISASSOCIATED)
> +	if (pool->flags & POOL_DISASSOCIATED) {
>  		worker->flags |= WORKER_UNBOUND;
> +		set_cpus_allowed_ptr(worker->task, cpu_active_mask);
> +	} else {
> +		/*
> +		 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> +		 * online CPUs. It'll be re-applied when any of the CPUs come up.
> +		 */

Does this comment still stand ? IIUC, we should always be in the
POOL_DISASSOCIATED case if the CPU from cpumask is offline. Unless a
pool->attrs->cpumask can have several CPUs. In that case maybe we should check
for the cpu_active_mask here too ?

-- 
Vincent

> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	}
>  
>  	list_add_tail(&worker->node, &pool->workers);
>  	worker->pool = pool;
> -- 
> 2.27.0
> 
