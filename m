Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC52D2CED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgLHORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgLHORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:17:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FAC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ijEhG8gGEWiXJLW+imhAKg7QjYa3RJ5hrd4zDBUdUg=; b=e+uAl4/KdJgbbqKvi7aFKetu1a
        k6Skiclz4+Wej1KAIcTA4Y8ZFr+kZ35c0EsE5ujyreFOcN9ktg3MXwi0qUnhTo635gwPH5vLzbOtM
        3PPXoKWFJsrkNfvpa9uJqtoE/yPsqsFA86yhtiNS6gO3ru5YxoBaotVJ2Ng5s8ohBU6geAovcNmM2
        v4eYWv72A/fR5AJ3mzvNlt2KOyvUjwp6ETknxgxaQYLlEnpW+HsMfJM9IjT93OUaLcxO23+JozKDi
        kfCblF/gxlmEOlNj5KF2XQeUartcHlT5X/04ymxQWufVn/mUoTDKcQw5gU1LULROjgO28rPNy0t8N
        4Ip/dnJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmdmo-0001PK-4V; Tue, 08 Dec 2020 14:16:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 093F7304B92;
        Tue,  8 Dec 2020 15:16:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C78A8200AABBA; Tue,  8 Dec 2020 15:16:10 +0100 (CET)
Date:   Tue, 8 Dec 2020 15:16:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v6] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201208141610.GA2414@hirez.programming.kicks-ass.net>
References: <20201208014957.170845-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208014957.170845-1-aubrey.li@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:49:57AM +0800, Aubrey Li wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c4da7e17b906..b8af602dea79 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3999,6 +3999,7 @@ void scheduler_tick(void)
>  	rq_lock(rq, &rf);
>  
>  	update_rq_clock(rq);
> +	update_idle_cpumask(rq, false);

Does that really need to be done with rq->lock held?

>  	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
>  	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);

> @@ -6808,6 +6813,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>  
> +/*
> + * Update cpu idle state and record this information
> + * in sd_llc_shared->idle_cpus_span.
> + */
> +void update_idle_cpumask(struct rq *rq, bool set_idle)
> +{
> +	struct sched_domain *sd;
> +	int cpu = cpu_of(rq);
> +	int idle_state;
> +
> +	/*
> +	 * If called from scheduler tick, only update
> +	 * idle cpumask if the CPU is busy, as idle
> +	 * cpumask is also updated on idle entry.
> +	 *
> +	 */
> +	if (!set_idle && idle_cpu(cpu))
> +		return;

scheduler_tick() already calls idle_cpu() when SMP.

> +	/*
> +	 * Also set SCHED_IDLE cpu in idle cpumask to
> +	 * allow SCHED_IDLE cpu as a wakeup target
> +	 */
> +	idle_state = set_idle || sched_idle_cpu(cpu);
> +	/*
> +	 * No need to update idle cpumask if the state
> +	 * does not change.
> +	 */
> +	if (rq->last_idle_state == idle_state)
> +		return;
> +
> +	rcu_read_lock();

This is called with IRQs disabled, surely we can forgo rcu_read_lock()
here.

> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +	if (!sd || !sd->shared)
> +		goto unlock;

I don't think !sd->shared is possible here.

> +	if (idle_state)
> +		cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> +	else
> +		cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> +
> +	rq->last_idle_state = idle_state;
> +unlock:
> +	rcu_read_unlock();
> +}
> +
>  static unsigned long wakeup_gran(struct sched_entity *se)
>  {
>  	unsigned long gran = sysctl_sched_wakeup_granularity;
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f324dc36fc43..f995660edf2b 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -156,6 +156,11 @@ static void cpuidle_idle_call(void)
>  		return;
>  	}
>  
> +	/*
> +	 * The CPU is about to go idle, set it in idle cpumask
> +	 * to be a wake up target.
> +	 */
> +	update_idle_cpumask(this_rq(), true);

This should be in do_idle(), right around arch_cpu_idle_enter().

>  	/*
>  	 * The RCU framework needs to be told that we are entering an idle
>  	 * section, so no more rcu read side critical sections and one more
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8d1ca65db3b0..db460b20217a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1004,6 +1004,7 @@ struct rq {
>  	/* This is used to determine avg_idle's max value */
>  	u64			max_idle_balance_cost;
>  #endif /* CONFIG_SMP */
> +	unsigned char		last_idle_state;

All of that is pointless for UP. Also, is this the best location?
