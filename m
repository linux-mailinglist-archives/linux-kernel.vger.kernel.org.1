Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6D284F49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgJFPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:55:33 -0400
Received: from foss.arm.com ([217.140.110.172]:50822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFPzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:55:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4393411B3;
        Tue,  6 Oct 2020 08:55:32 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43F3F3F66B;
        Tue,  6 Oct 2020 08:55:30 -0700 (PDT)
Date:   Tue, 6 Oct 2020 16:55:27 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 12/17] sched,rt: Use cpumask_any*_distribute()
Message-ID: <20201006155527.w6jck2rgk64t45wm@e107158-lin.cambridge.arm.com>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.156231026@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005150922.156231026@infradead.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/20 16:57, Peter Zijlstra wrote:
> Replace a bunch of cpumask_any*() instances with
> cpumask_any*_distribute(), by injecting this little bit of random in
> cpu selection, we reduce the chance two competing balance operations
> working off the same lowest_mask pick the same CPU.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/cpumask.h |    6 ++++++
>  kernel/sched/cpupri.c   |    4 ++--
>  kernel/sched/deadline.c |    2 +-
>  kernel/sched/rt.c       |    6 +++---
>  lib/cpumask.c           |   18 ++++++++++++++++++
>  5 files changed, 30 insertions(+), 6 deletions(-)
> 

[...]

> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1752,8 +1752,8 @@ static int find_lowest_rq(struct task_st
>  				return this_cpu;
>  			}
>  
> -			best_cpu = cpumask_first_and(lowest_mask,
> -						     sched_domain_span(sd));
> +			best_cpu = cpumask_any_and_distribute(lowest_mask,
> +							      sched_domain_span(sd));

I guess I should have done this 6 months ago and just got done with it :)

	20200414150556.10920-1-qais.yousef@arm.com

>  			if (best_cpu < nr_cpu_ids) {
>  				rcu_read_unlock();
>  				return best_cpu;
> @@ -1770,7 +1770,7 @@ static int find_lowest_rq(struct task_st
>  	if (this_cpu != -1)
>  		return this_cpu;
>  
> -	cpu = cpumask_any(lowest_mask);
> +	cpu = cpumask_any_distribute(lowest_mask);
>  	if (cpu < nr_cpu_ids)
>  		return cpu;
>  
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -267,3 +267,21 @@ int cpumask_any_and_distribute(const str
>  	return next;
>  }
>  EXPORT_SYMBOL(cpumask_any_and_distribute);
> +
> +int cpumask_any_distribute(const struct cpumask *srcp)
> +{
> +	int next, prev;
> +
> +	/* NOTE: our first selection will skip 0. */
> +	prev = __this_cpu_read(distribute_cpu_mask_prev);

We had a discussion then that __this_cpu*() variant assumes preemption being
disabled and it's safer to use this_cpu*() variant instead. Still holds true
here?

Thanks

--
Qais Yousef

> +
> +	next = cpumask_next(prev, srcp);
> +	if (next >= nr_cpu_ids)
> +		next = cpumask_first(srcp);
> +
> +	if (next < nr_cpu_ids)
> +		__this_cpu_write(distribute_cpu_mask_prev, next);
> +
> +	return next;
> +}
> +EXPORT_SYMBOL(cpumask_any_distribute);
> 
> 
