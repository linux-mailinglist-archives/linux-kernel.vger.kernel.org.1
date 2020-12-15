Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEFA2DAEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgLOO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgLOOZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:25:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0200B2250F;
        Tue, 15 Dec 2020 14:24:26 +0000 (UTC)
Date:   Tue, 15 Dec 2020 09:24:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is
 !active
Message-ID: <20201215092425.56d815f4@gandalf.local.home>
In-Reply-To: <20201215104400.9435-1-anna-maria@linutronix.de>
References: <20201215104400.9435-1-anna-maria@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 11:44:00 +0100
Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> SCHED_SOFTIRQ is raised to trigger periodic load balancing. When CPU is not
> active, CPU should not participate in load balancing.
> 
> The scheduler uses nohz.idle_cpus_mask to keep track of the CPUs which can
> do idle load balancing. When bringing a CPU up the CPU is added to the mask
> when it reaches the active state, but on teardown the CPU stays in the mask
> until it goes offline and invokes sched_cpu_dying().
> 
> When SCHED_SOFTIRQ is raised on a !active CPU, there might be a pending
> softirq when stopping the tick which triggers a warning in NOHZ code. The
> SCHED_SOFTIRQ can also be raised by the scheduler tick which has the same
> issue.
> 
> Therefore remove the CPU from nohz.idle_cpus_mask when it is marked
> inactive and also prevent the scheduler_tick() from raising SCHED_SOFTIRQ
> after this point.
> 

Makes sense.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/sched/core.c | 7 ++++++-
>  kernel/sched/fair.c | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 21b548b69455..69284dc121d3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7492,6 +7492,12 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	struct rq_flags rf;
>  	int ret;
>  
> +	/*
> +	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
> +	 * load balancing when not active
> +	 */
> +	nohz_balance_exit_idle(rq);
> +
>  	set_cpu_active(cpu, false);
>  	/*
>  	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU
> @@ -7598,7 +7604,6 @@ int sched_cpu_dying(unsigned int cpu)
>  
>  	calc_load_migrate(rq);
>  	update_max_interval();
> -	nohz_balance_exit_idle(rq);
>  	hrtick_clear(rq);
>  	return 0;
>  }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..fd422b8eb859 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10700,8 +10700,11 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>   */
>  void trigger_load_balance(struct rq *rq)
>  {
> -	/* Don't need to rebalance while attached to NULL domain */
> -	if (unlikely(on_null_domain(rq)))
> +	/*
> +	 * Don't need to rebalance while attached to NULL domain or
> +	 * runqueue CPU is not active
> +	 */
> +	if (unlikely(on_null_domain(rq) || !cpu_active(cpu_of(rq))))
>  		return;
>  
>  	if (time_after_eq(jiffies, rq->next_balance))

