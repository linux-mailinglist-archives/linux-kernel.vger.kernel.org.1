Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCC2DE20D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 12:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLRLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 06:34:03 -0500
Received: from foss.arm.com ([217.140.110.172]:33638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgLRLeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:34:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB8D1FB;
        Fri, 18 Dec 2020 03:33:16 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EA633F66E;
        Fri, 18 Dec 2020 03:33:14 -0800 (PST)
References: <20201218103258.GA3040@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, qperret@google.com,
        viresh.kumar@linaro.org
Subject: Re: [PATCH] sched: Add schedutil overview
In-reply-to: <20201218103258.GA3040@hirez.programming.kicks-ass.net>
Date:   Fri, 18 Dec 2020 11:33:09 +0000
Message-ID: <jhjsg83s616.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Have some more nits below

On 18/12/20 10:32, Peter Zijlstra wrote:
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/scheduler/schedutil.txt |  168 ++++++++++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
>
> --- /dev/null
> +++ b/Documentation/scheduler/schedutil.txt
[...]
> +Frequency- / CPU Invariance
> +---------------------------
> +
> +Because consuming the CPU for 50% at 1GHz is not the same as consuming the CPU
> +for 50% at 2GHz, nor is running 50% on a LITTLE CPU the same as running 50% on
> +a big CPU, we allow architectures to scale the time delta with two ratios, one
> +Dynamic Voltage and Frequency Scaling (DVFS) ratio and one microarch ratio.
> +
> +For simple DVFS architectures (where software is in full control) we trivially
> +compute the ratio as:
> +
> +	    f_cur
> +  r_dvfs := -----
> +            f_max
> +
> +For more dynamic systems where the hardware is in control of DVFS (Intel,
> +ARMv8.4-AMU) we use hardware counters to provide us this ratio. For Intel

Nit: To me this reads as if the presence of AMUs entail 'hardware is in
control of DVFS', which doesn't seem right. How about:

  For more dynamic systems where the hardware is in control of DVFS we use
  hardware counters (Intel APERF/MPERF, ARMv8.4-AMU) to provide us this
  ratio.

> +Schedutil / DVFS
> +----------------
> +
> +Every time the scheduler load tracking is updated (task wakeup, task
> +migration, time progression) we call out to schedutil to update the hardware
> +DVFS state.
> +
> +The basis is the CPU runqueue's 'running' metric, which per the above it is
> +the frequency invariant utilization estimate of the CPU. From this we compute
> +a desired frequency like:
> +
> +             max( running, util_est );	if UTIL_EST
> +  u_cfs := { running;			otherwise
> +
> +  u_clamp := clamp( u_cfs, u_min, u_max )
> +
> +  u := u_cfs + u_rt + u_irq + u_dl;	[approx. see source for more detail]
> +
> +  f_des := min( f_max, 1.25 u * f_max )
> +

In schedutil_cpu_util(), uclamp clamps both u_cfs and u_rt. I'm afraid the
below might just bring more confusion; what do you think?

               clamp( u_cfs + u_rt, u_min, u_max );      if UCLAMP_TASK
  u_clamp := { u_cfs + u_rt;                             otherwise

  u := u_clamp + u_irq + u_dl;	    [approx. see source for more detail]

(also, does this need a word about runnable rt tasks => goto max?)

> +XXX IO-wait; when the update is due to a task wakeup from IO-completion we
> +boost 'u' above.
> +
> +This frequency is then used to select a P-state/OPP or directly munged into a
> +CPPC style request to the hardware.
> +
> +XXX: deadline tasks (Sporadic Task Model) allows us to calculate a hard f_min
> +required to satisfy the workload.
> +
> +Because these callbacks are directly from the scheduler, the DVFS hardware
> +interaction should be 'fast' and non-blocking. Schedutil supports
> +rate-limiting DVFS requests for when hardware interaction is slow and
> +expensive, this reduces effectiveness.
> +
> +For more information see: kernel/sched/cpufreq_schedutil.c
> +
