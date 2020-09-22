Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5EF273B86
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgIVHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgIVHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:15:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:15:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so16881578lff.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXslmgBel6dbSP4nCnZW17o117FCuHt4umungsqetNM=;
        b=n4zjNj4yIBwuFZu9W/H7uqNyuv2z3J5WbadGFHWilYbdKYPFDoAk9ZE/phbNvsZwl5
         VKOJusMUjTe6H7dk4QoX4Rmc7X2BHtKImCsRM8fp87g0LrlCbkCsIBb2MX539fyJN9C5
         znZU449K5KenF19WH7lMIOD5o7wciz5FhgfpIxtnGzXb5T454dXbxraAfztcg+FloqlV
         7NtJT0FvdbRdNoR14zM5njtiLNAFvy9/XhK+WG4ACmIahqB3tblmmy0BjNa7Iru7DM0b
         GY+AuQKzZtRj+OHYhQLdRQwY5TAUCEPwKcACnWS0K0rWiC06qAla+ZLiofH2BKb0g5UE
         LzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXslmgBel6dbSP4nCnZW17o117FCuHt4umungsqetNM=;
        b=GaGQJuHBpxmexXniWXi9j+G4wDGgiK9jcUu1WYJaOGjKod+VedMx4nxW4O9SpyJAp4
         lzpxxm95rA7Z2qmh0cdWYYlWzGbAeaHKVbXjJRkPRwcfS+vvQ81mtL+OqsyCBowebuqL
         egFjkJGdTqd3N21ieXTSR2fB/aMa8xwrCGQCNH0wJzcO/6yPsolO8i7bDdaKFCyQfTE8
         LH+aRD/rRT3UHxWbsK61A4yzCw3+SD1os1eDJ1C18CFRL5VQKCiUbboiLp7pK5HlAKBm
         fwNlm9/4tZAI8sWP/zVlmZvhAB7dNV2nuLSKncIRGpG1nxFygbQrjMEIES73abixD7Xy
         I83Q==
X-Gm-Message-State: AOAM533kttzLpsbnLlrHruNK9N0BOHMfx5cuFMkS+bDwunVxQIhCvFnm
        cOqYRWLOF8jB7QYK2JLsNT2jasbmUHB/OL8tLUpvQQ==
X-Google-Smtp-Source: ABdhPJysT6MTwA7MygZEoHGPXupJtCmQdzRfsDWyphDv2uGb+uwjltWVj/j1Zq9pRf1u5Nvqsv9yS/G9n38Qh0o8nHc=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr1103714lfl.573.1600758900983;
 Tue, 22 Sep 2020 00:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200916043103.606132-1-aubrey.li@linux.intel.com>
 <20200916110039.GG3117@suse.de> <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com> <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
In-Reply-To: <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 22 Sep 2020 09:14:49 +0200
Message-ID: <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 at 05:33, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/9/21 23:21, Vincent Guittot wrote:
> > On Mon, 21 Sep 2020 at 17:14, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Thu, 17 Sep 2020 at 11:21, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >>>
> >>> On 2020/9/16 19:00, Mel Gorman wrote:
> >>>> On Wed, Sep 16, 2020 at 12:31:03PM +0800, Aubrey Li wrote:
> >>>>> Added idle cpumask to track idle cpus in sched domain. When a CPU
> >>>>> enters idle, its corresponding bit in the idle cpumask will be set,
> >>>>> and when the CPU exits idle, its bit will be cleared.
> >>>>>
> >>>>> When a task wakes up to select an idle cpu, scanning idle cpumask
> >>>>> has low cost than scanning all the cpus in last level cache domain,
> >>>>> especially when the system is heavily loaded.
> >>>>>
> >>>>> The following benchmarks were tested on a x86 4 socket system with
> >>>>> 24 cores per socket and 2 hyperthreads per core, total 192 CPUs:
> >>>>>
> >>>>
> >>>> This still appears to be tied to turning the tick off. An idle CPU
> >>>> available for computation does not necessarily have the tick turned off
> >>>> if it's for short periods of time. When nohz is disabled or a machine is
> >>>> active enough that CPUs are not disabling the tick, select_idle_cpu may
> >>>> fail to select an idle CPU and instead stack tasks on the old CPU.
> >>>>
> >>>> The other subtlety is that select_idle_sibling() currently allows a
> >>>> SCHED_IDLE cpu to be used as a wakeup target. The CPU is not really
> >>>> idle as such, it's simply running a low priority task that is suitable
> >>>> for preemption. I suspect this patch breaks that.
> >>>>
> >>> Thanks!
> >>>
> >>> I shall post a v3 with performance data, I made a quick uperf testing and
> >>> found the benefit is still there. So I posted the patch here and looking
> >>> forward to your comments before I start the benchmarks.
> >>>
> >>> Thanks,
> >>> -Aubrey
> >>>
> >>> -----------------------------------------------------------------------
> >>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> >>> index fb11091129b3..43a641d26154 100644
> >>> --- a/include/linux/sched/topology.h
> >>> +++ b/include/linux/sched/topology.h
> >>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
> >>>         atomic_t        ref;
> >>>         atomic_t        nr_busy_cpus;
> >>>         int             has_idle_cores;
> >>> +       /*
> >>> +        * Span of all idle CPUs in this domain.
> >>> +        *
> >>> +        * NOTE: this field is variable length. (Allocated dynamically
> >>> +        * by attaching extra space to the end of the structure,
> >>> +        * depending on how many CPUs the kernel has booted up with)
> >>> +        */
> >>> +       unsigned long   idle_cpus_span[];
> >>>  };
> >>>
> >>> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> >>> +{
> >>> +       return to_cpumask(sds->idle_cpus_span);
> >>> +}
> >>> +
> >>>  struct sched_domain {
> >>>         /* These fields must be setup */
> >>>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 6b3b59cc51d6..9a3c82645472 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -6023,6 +6023,26 @@ void __update_idle_core(struct rq *rq)
> >>>         rcu_read_unlock();
> >>>  }
> >>>
> >>> +/*
> >>> + * Update cpu idle state and record this information
> >>> + * in sd_llc_shared->idle_cpus_span.
> >>> + */
> >>> +void update_idle_cpumask(struct rq *rq)
> >>> +{
> >>> +       struct sched_domain *sd;
> >>> +       int cpu = cpu_of(rq);
> >>> +
> >>> +       rcu_read_lock();
> >>> +       sd = rcu_dereference(per_cpu(sd_llc, cpu));
> >>> +       if (!sd || !sd->shared)
> >>> +               goto unlock;
> >>> +       if (!available_idle_cpu(cpu) || !sched_idle_cpu(cpu))
> >>> +               goto unlock;
> >>> +       cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> >>> +unlock:
> >>> +       rcu_read_unlock();
> >>> +}
> >>> +
> >>>  /*
> >>>   * Scan the entire LLC domain for idle cores; this dynamically switches off if
> >>>   * there are no idle cores left in the system; tracked through
> >>> @@ -6136,7 +6156,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >>>
> >>>         time = cpu_clock(this);
> >>>
> >>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >>> +       /*
> >>> +        * sched_domain_shared is set only at shared cache level,
> >>> +        * this works only because select_idle_cpu is called with
> >>> +        * sd_llc.
> >>> +        */
> >>> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
> >>>
> >>>         for_each_cpu_wrap(cpu, cpus, target) {
> >>>                 if (!--nr)
> >>> @@ -6712,6 +6737,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >>>
> >>>                 if (want_affine)
> >>>                         current->recent_used_cpu = cpu;
> >>> +
> >>> +               sd = rcu_dereference(per_cpu(sd_llc, new_cpu));
> >>> +               if (sd && sd->shared)
> >>> +                       cpumask_clear_cpu(new_cpu, sds_idle_cpus(sd->shared));
> >>
> >> Why are you clearing the bit only for the fast path ? the slow path
> >> can also select an idle CPU
>
> Right, I saw idle core searching is turned off in the fast path only too,
> because next wakeup we'll check if the CPU is idle, this only affects the
> idle cpu searching span.
>
> >>
> >> Then, I'm afraid that updating a cpumask at each and every task wakeup
> >> will be far too expensive. That's why we are ot updating
> >
> > That's why we are not updating
>
> AFAIK, uperf/netperf is the workload with bunches of short idles, do you
> have any other workloads in your mind? I can measure to verify this.
> >
> >> nohz.idle_cpus_mask at each and every enter/exit idle but only once
> >> per tick.
> Yes, agreed, need more think about this, especially if the data is really
> bad.
>
> >>
> >> And a quick test with hackbench on my octo cores arm64 gives for 12
> >> iterations of: hackbench -l 2560 -g 1
> >> tip/sched/core :  1.324(+/- 1.26%)
> >> with this patch :  2.419(+/- 12.31%) -82% regression
>
> Can you please clarify this, is this running 2560 loops and 1 group?

yes it's 2560 loops and 1 group and I run 12 times the bench:
$ hackbench -l 2560 -g 1
Running in process mode with 1 groups using 40 file descriptors each
(== 40 tasks)
Each sender will pass 2560 messages of 100 bytes
Time: 2.953

you can also have a look at perf sched pipe
tip/sched/core
$ perf bench sched pipe -T -l 50000
# Running 'sched/pipe' benchmark:
# Executed 50000 pipe operations between two threads

     Total time: 0.980 [sec]

      19.609160 usecs/op
          50996 ops/sec

With your patch :
$ perf bench sched pipe -T -l 50000
# Running 'sched/pipe' benchmark:
# Executed 50000 pipe operations between two threads

     Total time: 1.283 [sec]

      25.674200 usecs/op
          38949 ops/sec

which is a 23% regression

> 10 iterations "./hackbench 1 process 2560" on my side are:
>
> 5.8.10: 0.14(+/- 12.01%)
> =========================
> [0.089, 0.148, 0.147, 0.141, 0.143, 0.143, 0.143, 0.146, 0.143, 0.142]
> Score:   avg - 0.1385, std - 12.01%
>
> With this patch
> ================
> [0.095, 0.142, 0.143, 0.142, 0.15, 0.146, 0.144, 0.145, 0.143, 0.145]
> Score:   avg - 0.1395, std - 10.88%
>
> I didn't see such big regression.
>
> >>
> >>>         }
> >>>         rcu_read_unlock();
> >>>
> >>> @@ -10871,6 +10900,9 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> >>>                 /* ensure bandwidth has been allocated on our new cfs_rq */
> >>>                 account_cfs_rq_runtime(cfs_rq, 0);
> >>>         }
> >>> +       /* Update idle cpumask if task has idle policy */
> >>> +       if (unlikely(task_has_idle_policy(p)))
> >>> +               update_idle_cpumask(rq);
> >>
> >> it's wrong because a sched_idle task will run for time to time even
> >> when some cfs tasks are runnable
> >>
> Sorry I didn't get your point. The intention here is to add a SCHED_IDLE cpu to the idle cpumask,
> so that this cpu can be used as a target for wakeup preemption.

a cpu with sched_idle tasks can be considered idle iff there is only
sched_idle tasks runnable. Look at sched_idle_cpu()

>
> >>>  }
> >>>
> >>>  void init_cfs_rq(struct cfs_rq *cfs_rq)
> >>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >>> index 1ae95b9150d3..876dfdfe35bb 100644
> >>> --- a/kernel/sched/idle.c
> >>> +++ b/kernel/sched/idle.c
> >>> @@ -405,6 +405,7 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
> >>>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> >>>  {
> >>>         update_idle_core(rq);
> >>> +       update_idle_cpumask(rq);
> >>>         schedstat_inc(rq->sched_goidle);
> >>>  }
> >>>
> >>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >>> index c82857e2e288..7a3355f61bcf 100644
> >>> --- a/kernel/sched/sched.h
> >>> +++ b/kernel/sched/sched.h
> >>> @@ -1069,6 +1069,7 @@ static inline void update_idle_core(struct rq *rq)
> >>>  #else
> >>>  static inline void update_idle_core(struct rq *rq) { }
> >>>  #endif
> >>> +void update_idle_cpumask(struct rq *rq);
> >>>
> >>>  DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> >>>
> >>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>> index 9079d865a935..f14a6ef4de57 100644
> >>> --- a/kernel/sched/topology.c
> >>> +++ b/kernel/sched/topology.c
> >>> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
> >>>                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> >>>                 atomic_inc(&sd->shared->ref);
> >>>                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> >>> +               cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
> >>>         }
> >>>
> >>>         sd->private = sdd;
> >>> @@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
> >>>
> >>>                         *per_cpu_ptr(sdd->sd, j) = sd;
> >>>
> >>> -                       sds = kzalloc_node(sizeof(struct sched_domain_shared),
> >>> +                       sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
> >>>                                         GFP_KERNEL, cpu_to_node(j));
> >>>                         if (!sds)
> >>>                                 return -ENOMEM;
> >>>
>
