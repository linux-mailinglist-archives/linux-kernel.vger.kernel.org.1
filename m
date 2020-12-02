Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E62C2CBF6D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgLBOTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:19:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbgLBOTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:19:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FEA2AB7F;
        Wed,  2 Dec 2020 14:18:38 +0000 (UTC)
Date:   Wed, 2 Dec 2020 14:18:35 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com,
        qperret@google.com, viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201202141835.GY3306@suse.de>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For whatever reason, this only arrived in my inbox today.

On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
> PELT (Per Entity Load Tracking)
> -------------------------------
> 
> With PELT we track some metrics across the various entities, from individual

s/entities/scheduler entities/ so that someone will recognise
sched_entity in the code.

> tasks to task-group slices to CPU runqueues. As the basis for this we use an
> EWMA, each period (1024us) is decayed such that y^32 = 0.5. That is, the

Expand -- Exponentially Weighted Moving Average (EWMA). The cc list
should recognise it automatically, but maybe not a first entrant to
kernel/sched. kernel/sched is littered with institutional knowledge.

> most recent 32ms contribute half, while the rest of history contribute the
> other half.
> 

IIRC, this 32ms is tied to the value of LOAD_AVG_PERIOD and the length
of the ewma_sum series below. Might be worth expanding a little further.

> Specifically:
> 
>   ewma_sum(u) := u_0 + u_1*y + u_2*y^2 + ...
> 
>   ewma(u) = ewma_sum(u) / ewma_sum(1)
> 
> Since this is essentially a progression of an infinite geometric series, the
> results are composable, that is ewma(A) + ewma(B) = ewma(A+B). This property
> is key, since it gives the ability to recompose the averages when tasks move
> around.
> 
> Note that blocked tasks still contribute to the aggregates (task-group slices
> and CPU runqueues), which reflects their expected contribution when they
> resume running.
> 
> Using this we track 2 key metrics: 'running' and 'runnable'. 'Running'
> reflects the time an entity spends on the CPU, while 'runnable' reflects the
> time an entity spends on the runqueue. When there is only a single task these
> two metrics are the same, but once there is contention for the CPU 'running'
> will decrease to reflect the fraction of time each task spends on the CPU
> while 'runnable' will increase to reflect the amount of contention.
> 
> For more detail see: kernel/sched/pelt.c
> 
> 
> Frequency- / Heterogeneous Invariance
> -------------------------------------
> 
> Because consuming the CPU for 50% at 1GHz is not the same as consuming the CPU
> for 50% at 2GHz, nor is running 50% on a LITTLE CPU the same as running 50% on
> a big CPU, we allow architectures to scale the time delta with two ratios, one
> DVFS ratio and one microarch ratio.
> 

Expand -- Dynamic Voltage and Frequency Scaling (DVFS) and assume that
the reader will think of cpufreq.

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

s/In specific, for Intel/For Intel specifically,/

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
> 

r_het is never mentioned again so it's not immediately obvious what it
ties into. I assume het is short for heterogeneous and is simply another
way of looking at current CPU compute power vs potential CPU compute power
(be that due to DVFS or big.LITTLE).

> The result is that the above 'running' and 'runnable' metrics become invariant
> of DVFS and Heterogenous state. IOW. we can transfer and compare them between
> CPUs.
> 
> For more detail see:
> 
>  - kernel/sched/pelt.h:update_rq_clock_pelt()
>  - arch/x86/kernel/smpboot.c:"APERF/MPERF frequency ratio computation."
> 

The role and importance of frequency invariance is mentioned but it
could be more explicit. However, looking at update_rq_clock_pelt may be
enough of a clue. 

Either way, decoding this document fully will require someone to spend a
lot of time on the source and then rereading this document. That's
probably a good thing.

> 
> UTIL_EST / UTIL_EST_FASTUP
> --------------------------
> 
> Because periodic tasks have their averages decayed while they sleep, even
> though when running their expected utilization will be the same, they suffer a
> (DVFS) ramp-up after they become runnable again.
> 

s/they become runnable again/they are running again/ ? Maybe refer as
"running" because it's only once they are on the CPU and running that
DVFS comes into play?



> To alleviate this (a default enabled option) UTIL_EST drives an (IIR) EWMA

Expand IIR -- Immediate Impulse Reponse?

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

It's less obvious what the consequence is unless the reader manages to
tie the IO-wait comment in "Schedutil / DVFS" to this section.

> UCLAMP
> ------
> 
> It is possible to set effective u_min and u_max clamps on each task; the
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

Is it worth explicitly mentioning that a key advantage over
hardware-based approaches is that schedutil carries utilisation state on
CPU migration? You say that it is tracked but it's less obvious why that
matters as a pure hardware based approach loses utilisation information
about a task once it migrates.

Even moving note 3 below into this section and expanding it with an
example based on HWP would be helpful.

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
> 

-- 
Mel Gorman
SUSE Labs
