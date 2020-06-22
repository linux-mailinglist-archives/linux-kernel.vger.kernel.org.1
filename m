Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06659203691
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgFVMRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 08:17:52 -0400
Received: from foss.arm.com ([217.140.110.172]:49294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgFVMRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:17:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C5A91F1;
        Mon, 22 Jun 2020 05:17:51 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02FD73F71E;
        Mon, 22 Jun 2020 05:17:49 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:17:47 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200622121746.b43ziyjq2eqsseym@e107158-lin.cambridge.arm.com>
References: <20200619141120.1476-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619141120.1476-1-pauld@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 10:11, Phil Auld wrote:
> Add a bare tracepoint trace_sched_update_nr_running_tp which tracks
> ->nr_running CPU's rq. This is used to accurately trace this data and
> provide a visualization of scheduler imbalances in, for example, the
> form of a heat map.  The tracepoint is accessed by loading an external
> kernel module. An example module (forked from Qais' module and including
> the pelt related tracepoints) can be found at:
> 
>   https://github.com/auldp/tracepoints-helpers.git
> 
> A script to turn the trace-cmd report output into a heatmap plot can be
> found at:
> 
>   https://github.com/jirvoz/plot-nr-running
> 
> The tracepoints are added to add_nr_running() and sub_nr_running() which
> are in kernel/sched/sched.h. Since sched.h includes trace/events/tlb.h
> via mmu_context.h we had to limit when CREATE_TRACE_POINTS is defined.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> CC: Qais Yousef <qais.yousef@arm.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: linux-kernel@vger.kernel.org
> ---
>  include/trace/events/sched.h |  4 ++++
>  kernel/sched/core.c          |  9 ++++-----
>  kernel/sched/fair.c          |  2 --
>  kernel/sched/pelt.c          |  2 --
>  kernel/sched/sched.h         | 12 ++++++++++++
>  5 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index ed168b0e2c53..a6d9fe5a68cf 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -634,6 +634,10 @@ DECLARE_TRACE(sched_overutilized_tp,
>  	TP_PROTO(struct root_domain *rd, bool overutilized),
>  	TP_ARGS(rd, overutilized));
>  
> +DECLARE_TRACE(sched_update_nr_running_tp,
> +	TP_PROTO(int cpu, int change, unsigned int nr_running),
> +	TP_ARGS(cpu, change, nr_running));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..6f28fdff1d48 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6,7 +6,10 @@
>   *
>   *  Copyright (C) 1991-2002  Linus Torvalds
>   */
> +
> +#define SCHED_CREATE_TRACE_POINTS
>  #include "sched.h"
> +#undef SCHED_CREATE_TRACE_POINTS
>  
>  #include <linux/nospec.h>
>  
> @@ -21,9 +24,6 @@
>  
>  #include "pelt.h"
>  
> -#define CREATE_TRACE_POINTS
> -#include <trace/events/sched.h>
> -
>  /*
>   * Export tracepoints that act as a bare tracehook (ie: have no trace event
>   * associated with them) to allow external modules to probe them.
> @@ -34,6 +34,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> @@ -7969,5 +7970,3 @@ const u32 sched_prio_to_wmult[40] = {
>   /*  10 */  39045157,  49367440,  61356676,  76695844,  95443717,
>   /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
>  };
> -
> -#undef CREATE_TRACE_POINTS
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da3e5b54715b..fe5d9b6db8f7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -22,8 +22,6 @@
>   */
>  #include "sched.h"
>  
> -#include <trace/events/sched.h>
> -
>  /*
>   * Targeted preemption latency for CPU-bound tasks:
>   *
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index b647d04d9c8b..bb69a0ae8d6c 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -28,8 +28,6 @@
>  #include "sched.h"
>  #include "pelt.h"
>  
> -#include <trace/events/sched.h>
> -
>  /*
>   * Approximate:
>   *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..6ae96679c169 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -75,6 +75,15 @@
>  #include "cpupri.h"
>  #include "cpudeadline.h"
>  
> +#ifdef SCHED_CREATE_TRACE_POINTS
> +#define CREATE_TRACE_POINTS
> +#endif
> +#include <trace/events/sched.h>
> +
> +#ifdef SCHED_CREATE_TRACE_POINTS
> +#undef CREATE_TRACE_POINTS
> +#endif
> +
>  #ifdef CONFIG_SCHED_DEBUG
>  # define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
>  #else
> @@ -1959,6 +1968,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>  	unsigned prev_nr = rq->nr_running;
>  
>  	rq->nr_running = prev_nr + count;
> +	trace_sched_update_nr_running_tp(cpu_of(rq), count, rq->nr_running);

This is a very specific call site, so I guess it looks fine to pass very
specific info too.

But I think we can do better by just passing struct rq and add a new helper
sched_trace_rq_nr_running() (see the bottom of fair.c for a similar helper
functions for tracepoints).

This will allow the user to extract, cpu, nr_running and potentially other info
while only pass a single argument to the tracepoint. Potentially extending its
future usefulness.

The count can be inferred by storing the last nr_running and taking the diff
when a new call happens.

	...

	cpu = sched_trace_rq_cpu(rq);
	nr_running = sched_trace_rq_nr_running(rq);
	count = last_nr_running[cpu] - nr_running;
	last_nr_running[cpu] = nr_running;

	...

I haven't looked at BTF, but it could potentially allow us to access members of
unexported structs reliably without having to export all these helper
functions. It's been something I wanted to look into but no time yet.

Thanks

--
Qais Yousef

>  
>  #ifdef CONFIG_SMP
>  	if (prev_nr < 2 && rq->nr_running >= 2) {
> @@ -1973,6 +1983,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>  static inline void sub_nr_running(struct rq *rq, unsigned count)
>  {
>  	rq->nr_running -= count;
> +	trace_sched_update_nr_running_tp(cpu_of(rq), -count, rq->nr_running);
> +
>  	/* Check if we still need preemption */
>  	sched_update_tick_dependency(rq);
>  }
> -- 
> 2.18.0
> 
