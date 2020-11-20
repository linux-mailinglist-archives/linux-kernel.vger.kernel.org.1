Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385AA2BA965
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgKTLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:45:16 -0500
Received: from foss.arm.com ([217.140.110.172]:48184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:45:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFCC11D4;
        Fri, 20 Nov 2020 03:45:15 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74C9A3F718;
        Fri, 20 Nov 2020 03:45:13 -0800 (PST)
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
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
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
In-reply-to: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
Date:   Fri, 20 Nov 2020 11:45:05 +0000
Message-ID: <jhjzh3cuu9q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 20/11/20 07:55, Peter Zijlstra wrote:
> Frequency- / Heterogeneous Invariance
> -------------------------------------
>
> Because consuming the CPU for 50% at 1GHz is not the same as consuming the CPU
> for 50% at 2GHz, nor is running 50% on a LITTLE CPU the same as running 50% on
> a big CPU, we allow architectures to scale the time delta with two ratios, one
> DVFS ratio and one microarch ratio.
>
> For simple DVFS architectures (where software is in full control) we trivially
> compute the ratio as:
>
> 	    f_cur
>   r_dvfs := -----
>             f_max
>
> For more dynamic systems where the hardware is in control of DVFS (Intel,
> ARMv8.4-AMU) we use hardware counters to provide us this ratio. In specific,
> for Intel, we use:
>
> 	   APERF
>   f_cur := ----- * P0
> 	   MPERF
>
> 	     4C-turbo;	if available and turbo enabled
>   f_max := { 1C-turbo;	if turbo enabled
> 	     P0;	otherwise
>
>                     f_cur
>   r_dvfs := min( 1, ----- )
>                     f_max
>
> We pick 4C turbo over 1C turbo to make it slightly more sustainable.
>
> r_het is determined as the average performance difference between a big and
> LITTLE core when running at max frequency over 'relevant' benchmarks.

Welcome to our wonderful world where there can be more than just two types
of CPUs! A perhaps safer statement would be:

  r_het is determined as the ratio of highest performance level of the
  current CPU vs the highest performance level of any other CPU in the 
  system.


Also; do we want to further state the obvious?

  r_tot := r_het * r_dvfs

>
> The result is that the above 'running' and 'runnable' metrics become invariant
> of DVFS and Heterogenous state. IOW. we can transfer and compare them between
> CPUs.
>
> For more detail see:
>
>  - kernel/sched/pelt.h:update_rq_clock_pelt()
>  - arch/x86/kernel/smpboot.c:"APERF/MPERF frequency ratio computation."
>

Some of that is rephrased in

  Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"

(with added diagrams crafted with love by yours truly); I suppose a cross
reference can't hurt.

>
> UTIL_EST / UTIL_EST_FASTUP
> --------------------------
>
> Because periodic tasks have their averages decayed while they sleep, even
> though when running their expected utilization will be the same, they suffer a
> (DVFS) ramp-up after they become runnable again.
>
> To alleviate this (a default enabled option) UTIL_EST drives an (IIR) EWMA
> with the 'running' value on dequeue -- when it is highest. A further default
> enabled option UTIL_EST_FASTUP modifies the IIR filter to instantly increase
> and only decay on decrease.
>
> A further runqueue wide sum (of runnable tasks) is maintained of:
>
>   util_est := \Sum_t max( t_running, t_util_est_ewma )
>
> For more detail see: kernel/sched/fair.h:util_est_dequeue()
>
>
> UCLAMP
> ------
>
> It is possible to set effective u_min and u_max clamps on each task; the

Nit: effective clamps are the task clamps clamped by task group clamps
(yes, that is 4 times 'clamp' in a single line).

> runqueue keeps an max aggregate of these clamps for all running tasks.
>
> For more detail see: include/uapi/linux/sched/types.h
>
>
> Schedutil / DVFS
> ----------------
>
> Every time the scheduler load tracking is updated (task wakeup, task
> migration, time progression) we call out to schedutil to update the hardware
> DVFS state.
>
> The basis is the CPU runqueue's 'running' metric, which per the above it is
> the frequency invariant utilization estimate of the CPU. From this we compute
> a desired frequency like:
>
>              max( running, util_est );	if UTIL_EST
>   u_cfs := { running;			otherwise
>
>   u_clamp := clamp( u_cfs, u_min, u_max )
>
>   u := u_cfs + u_rt + u_irq + u_dl;	[approx. see source for more detail]
>
>   f_des := min( f_max, 1.25 u * f_max )
>
> XXX IO-wait; when the update is due to a task wakeup from IO-completion we
> boost 'u' above.
>

IIRC the boost is fiddled with during the above, but can be applied at
different subsequent updates (even if the task that triggered the boost is
no longer here).

> This frequency is then used to select a P-state/OPP or directly munged into a
> CPPC style request to the hardware.
>
> XXX: deadline tasks (Sporadic Task Model) allows us to calculate a hard f_min
> required to satisfy the workload.
>
> Because these callbacks are directly from the scheduler, the DVFS hardware
> interaction should be 'fast' and non-blocking. Schedutil supports
> rate-limiting DVFS requests for when hardware interaction is slow and
> expensive, this reduces effectiveness.
>
> For more information see: kernel/sched/cpufreq_schedutil.c
>
>
> NOTES
> -----
>
>  - On low-load scenarios, where DVFS is most relevant, the 'running' numbers
>    will closely reflect utilization.
>
>  - In saturated scenarios task movement will cause some transient dips,
>    suppose we have a CPU saturated with 4 tasks, then when we migrate a task
>    to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
>    new CPU will gain 0.25. This is inevitable and time progression will
>    correct this. XXX do we still guarantee f_max due to no idle-time?
>
>  - Much of the above is about avoiding DVFS dips, and independent DVFS domains
>    having to re-learn / ramp-up when load shifts.

