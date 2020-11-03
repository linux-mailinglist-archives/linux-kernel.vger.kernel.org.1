Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC262A501B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgKCT2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:28:04 -0500
Received: from foss.arm.com ([217.140.110.172]:54722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCT2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:28:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87CE1139F;
        Tue,  3 Nov 2020 11:28:03 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0D123F66E;
        Tue,  3 Nov 2020 11:28:01 -0800 (PST)
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for task wakeup
In-reply-to: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
Date:   Tue, 03 Nov 2020 19:27:56 +0000
Message-ID: <jhjimamz1dv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 21/10/20 16:03, Aubrey Li wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6b3b59cc51d6..088d1995594f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6023,6 +6023,38 @@ void __update_idle_core(struct rq *rq)
>       rcu_read_unlock();
>  }
>
> +static DEFINE_PER_CPU(bool, cpu_idle_state);

I would've expected this to be far less compact than a cpumask, but that's
not the story readelf is telling me. Objdump tells me this is recouping
some of the padding in .data..percpu, at least with the arm64 defconfig.

In any case this ought to be better wrt cacheline bouncing, which I suppose
is what we ultimately want here.

Also, see rambling about init value below.

> @@ -10070,6 +10107,12 @@ static void nohz_balancer_kick(struct rq *rq)
>       if (unlikely(rq->idle_balance))
>               return;
>
> +	/* The CPU is not in idle, update idle cpumask */
> +	if (unlikely(sched_idle_cpu(cpu))) {
> +		/* Allow SCHED_IDLE cpu as a wakeup target */
> +		update_idle_cpumask(rq, true);
> +	} else
> +		update_idle_cpumask(rq, false);

This means that without CONFIG_NO_HZ_COMMON, a CPU going into idle will
never be accounted as going out of it, right? Eventually the cpumask
should end up full, which conceptually implements the previous behaviour of
select_idle_cpu() but in a fairly roundabout way...

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9079d865a935..f14a6ef4de57 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
>               sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>               atomic_inc(&sd->shared->ref);
>               atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> +		cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));

So at init you would have (single LLC for sake of simplicity):

  \all cpu : cpu_idle_state[cpu]  == false
  cpumask_full(sds_idle_cpus)     == true

IOW it'll require all CPUs to go idle at some point for these two states to
be properly aligned. Should cpu_idle_state not then be init'd to 1?

This then happens again for hotplug, except that cpu_idle_state[cpu] may be
either true or false when the sds_idle_cpus mask is reset to 1's.
