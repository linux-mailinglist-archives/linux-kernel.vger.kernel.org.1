Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCBA2D950B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439936AbgLNJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439906AbgLNJTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:19:09 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:18:29 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so28331532lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O5jCLt7f4f43hcPTtq1+gNZOuVQyD0zxIUprlD1X4Iw=;
        b=FQz4dTdufbUXXQ9DWjJp+d9YwOEmhrFHLRzLZKUh7snpc/0U9ujY/Kf6xvhFZK8Iu7
         9uCZp6keGxrA8AbXMtJk2rG/u/jxYX2KH2Qm3PexWA2/ntinaz4jJM7F2Tnzlt5OXxSX
         sMZGAAGbOxEq5xkaUfF0krQ0SVxjKt0BHHpPcv6eCQRWB+Ap+Ub6gcSTasTnW1pskWeO
         jAQvzpMuna99LyO435x77/iwGwJshxeYQKimqB6Mk3sLAubNmVjCth5slz1CNVzpU09f
         9M8htO73efHryU4TaA1iiH7fi2JNuSkTub8LpOt1xdh1SQsehHN+9zq6BKZeOtWSBIHq
         UZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O5jCLt7f4f43hcPTtq1+gNZOuVQyD0zxIUprlD1X4Iw=;
        b=J63egLLrLapIys7JE4UfGbFRUsaWmeRENXEQwCLMz2z1QLLy6pLGbVjgCyfw+zSFnn
         QMxYix5oSaeqIh84DNNrjphj6AuNUKRych6ZwAXb41TiP3mwcYgoKjEEPLcYkARMIKID
         0lrkLSuPACbz5SuChAvCdQNSUhXhJPEmR3fxjNXJOLWcdqP1NZGHyjrB6VpcuytS5EnB
         Iz1S4YoaSry7IZnCa+sqEEtd+xcHyEOKKZUquYVfQuRaJhAts/m0VzrhXAJeIfMsbVtH
         HrPfakIH0BUfh7OvaARfu/FaPwJgJ8CDS31iW4A4ss5Og5Vc8J5PbHgO5ZOkPSNm6iFg
         Ul3g==
X-Gm-Message-State: AOAM533mgH4luUMtelsFONC3d9ChRnwO4mrTaYCSTeDzam3FfyKo5RQ0
        fN5R8qPJXgYo/WnHJR0Cx2Wtta7h+uy4oq6jLYAxuw==
X-Google-Smtp-Source: ABdhPJxsr33h3DPGImYgjbdVVD/1e7lRW+DARcL0x57IbDr7n4WZAz4wLdGdARnp+FmngvaptrzMOAjxZ6sHR8eNjho=
X-Received: by 2002:a19:657:: with SMTP id 84mr8213942lfg.470.1607937507553;
 Mon, 14 Dec 2020 01:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net> <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net> <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net> <20201211174442.GU3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201211174442.GU3040@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Dec 2020 10:18:16 +0100
Message-ID: <CAKfTPtB1sRmZAf5MEZOquHg3z7TTriAbqpwVup5xwu42DN2yCA@mail.gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 at 18:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 10, 2020 at 12:58:33PM +0000, Mel Gorman wrote:
> > The prequisite patch to make that approach work was rejected though
> > as on its own, it's not very helpful and Vincent didn't like that the
> > load_balance_mask was abused to make it effective.
>
> So last time I poked at all this, I found that using more masks was a
> performance issue as well due to added cache misses.
>
> Anyway, I finally found some time to look at all this, and while reading
> over the whole SiS crud to refresh the brain came up with the below...
>
> It's still naf, but at least it gets rid of a bunch of duplicate
> scanning and LoC decreases, so it should be awesome. Ofcourse, as
> always, benchmarks will totally ruin everything, we'll see, I started
> some.
>
> It goes on top of Mel's first two patches (which is about as far as I
> got)...

We have several different things that Aubrey and Mel patches are
trying to achieve:

Aubrey wants to avoid scanning busy cpus
- patch works well on busy system: I see a significant benefit with
hackbench on a lot of group on my 2 nodes * 28 cores * 4 smt
    hackbench -l 2000 -g 128
tip 3.334
w/ patch 2.978 (+12%)

- Aubey also tried to not scan the cpus which are idle for a short
duration (when a tick not stopped) but there are problems because not
stopping a tick doesn't mean a short idle. In fact , something similar
to find_idlest_group_cpu() should be done in this case but then it's
no more a fast path search

Mel wants to minimize looping over the cpus
-patch 4 is an obvious win on light loaded system because it avoids
looping twice the cpus mask when some cpus are idle but no core
-But patch 3 generates perf r=C3=A9gression
    hackbench -l 2000 -g 1
tip 12.293
/w all Mel's patches 15.163 -14%
/w Aubrey + Mel patches minus patch 3 : 12.788 +3.8% But I think that
Aubreay's patch doesn't help here. Test without aubrey's patch are
running

-he also tried to used load_balance_mask to do something similar to the bel=
ow


>
> ---
>  fair.c |  124 ++++++++++++++++++++++++----------------------------------=
-------
>  1 file changed, 47 insertions(+), 77 deletions(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6021,11 +6021,13 @@ static inline void set_idle_cores(int cp
>
>  static inline bool test_idle_cores(int cpu, bool def)
>  {
> -       struct sched_domain_shared *sds;
> +       if (static_branch_likely(&sched_smt_present)) {
> +               struct sched_domain_shared *sds;
>
> -       sds =3D rcu_dereference(per_cpu(sd_llc_shared, cpu));
> -       if (sds)
> -               return READ_ONCE(sds->has_idle_cores);
> +               sds =3D rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +               if (sds)
> +                       return READ_ONCE(sds->has_idle_cores);
> +       }
>
>         return def;
>  }
> @@ -6059,77 +6061,39 @@ void __update_idle_core(struct rq *rq)
>         rcu_read_unlock();
>  }
>
> -/*
> - * Scan the entire LLC domain for idle cores; this dynamically switches =
off if
> - * there are no idle cores left in the system; tracked through
> - * sd_llc->shared->has_idle_cores and enabled through update_idle_core()=
 above.
> - */
> -static int select_idle_core(struct task_struct *p, struct sched_domain *=
sd, int target)
> +static int __select_idle_core(int core, struct cpumask *cpus, int *idle_=
cpu)
>  {
> -       struct cpumask *cpus =3D this_cpu_cpumask_var_ptr(select_idle_mas=
k);
> -       int core, cpu;
> -
> -       if (!static_branch_likely(&sched_smt_present))
> -               return -1;
> -
> -       if (!test_idle_cores(target, false))
> -               return -1;
> -
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> -
> -       for_each_cpu_wrap(core, cpus, target) {
> -               bool idle =3D true;
> +       bool idle =3D true;
> +       int cpu;
>
> -               for_each_cpu(cpu, cpu_smt_mask(core)) {
> -                       if (!available_idle_cpu(cpu)) {
> -                               idle =3D false;
> -                               break;
> -                       }
> +       for_each_cpu(cpu, cpu_smt_mask(core)) {
> +               if (!available_idle_cpu(cpu)) {
> +                       idle =3D false;
> +                       continue;

By not breaking on the first not idle cpu of the core, you will
largely increase the number of loops. On my system, it increases 4
times from 28 up tu 112

>                 }
> -
> -               if (idle)
> -                       return core;
> -
> -               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> +               if (idle_cpu)
> +                       *idle_cpu =3D cpu;
>         }
>
> -       /*
> -        * Failed to find an idle core; stop looking for one.
> -        */
> -       set_idle_cores(target, 0);
> +       if (idle)
> +               return core;
>
> +       cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>         return -1;
>  }
>
> -/*
> - * Scan the local SMT mask for idle CPUs.
> - */
> -static int select_idle_smt(struct task_struct *p, struct sched_domain *s=
d, int target)
> -{
> -       int cpu;
> -
> -       if (!static_branch_likely(&sched_smt_present))
> -               return -1;
> -
> -       for_each_cpu(cpu, cpu_smt_mask(target)) {
> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> -                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> -                       continue;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       return cpu;
> -       }
> +#else /* CONFIG_SCHED_SMT */
>
> -       return -1;
> +static inline void set_idle_cores(int cpu, int val)
> +{
>  }
>
> -#else /* CONFIG_SCHED_SMT */
> -
> -static inline int select_idle_core(struct task_struct *p, struct sched_d=
omain *sd, int target)
> +static inline bool test_idle_cores(int cpu, bool def)
>  {
> -       return -1;
> +       return def;
>  }
>
> -static inline int select_idle_smt(struct task_struct *p, struct sched_do=
main *sd, int target)
> +static inline int __select_idle_core(int core, struct cpumask *cpus, int=
 *idle_cpu)
>  {
>         return -1;
>  }
> @@ -6144,10 +6108,11 @@ static inline int select_idle_smt(struct
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *s=
d, int target)
>  {
>         struct cpumask *cpus =3D this_cpu_cpumask_var_ptr(select_idle_mas=
k);
> +       int this =3D smp_processor_id();
> +       bool smt =3D test_idle_cores(this, false);
> +       int i, cpu, idle_cpu =3D -1, nr =3D INT_MAX;
>         struct sched_domain *this_sd;
>         u64 time;
> -       int this =3D smp_processor_id();
> -       int cpu, nr =3D INT_MAX;
>
>         this_sd =3D rcu_dereference(*this_cpu_ptr(&sd_llc));
>         if (!this_sd)
> @@ -6155,7 +6120,7 @@ static int select_idle_cpu(struct task_s
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> -       if (sched_feat(SIS_PROP)) {
> +       if (sched_feat(SIS_PROP) && !smt) {
>                 u64 avg_cost, avg_idle, span_avg;
>
>                 /*
> @@ -6175,18 +6140,31 @@ static int select_idle_cpu(struct task_s
>         }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
> -               if (!--nr)
> -                       return -1;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       break;
> +               if (smt) {

sds->has_idle_core being set doesn't means that there is one idle core
which means for the same real HW state (i.e. no idle cores)
if sds->has_idle_core is set, we will loop all cpus here and never get
a chance to return a sched_idle_cpu()
but if sds->has_idle_core is clear, we will loop on a limited number
of cpus and test sched_idle_cpu()

> +                       i =3D __select_idle_core(cpu, cpus, &idle_cpu);
> +                       if ((unsigned)i < nr_cpumask_bits)
> +                               return i;
> +
> +               } else {
> +                       if (!--nr)
> +                               return -1;
> +
> +                       if (available_idle_cpu(cpu) || sched_idle_cpu(cpu=
)) {
> +                               idle_cpu =3D cpu;
> +                               break;
> +                       }
> +               }
>         }
>
> -       if (sched_feat(SIS_PROP)) {
> +       if (smt)
> +               set_idle_cores(this, false);
> +
> +       if (sched_feat(SIS_PROP) && !smt) {
>                 time =3D cpu_clock(this) - time;
>                 update_avg(&this_sd->avg_scan_cost, time);
>         }
>
> -       return cpu;
> +       return idle_cpu;
>  }
>
>  /*
> @@ -6315,18 +6293,10 @@ static int select_idle_sibling(struct ta
>         if (!sd)
>                 return target;
>
> -       i =3D select_idle_core(p, sd, target);
> -       if ((unsigned)i < nr_cpumask_bits)
> -               return i;
> -
>         i =3D select_idle_cpu(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> -       i =3D select_idle_smt(p, sd, target);
> -       if ((unsigned)i < nr_cpumask_bits)
> -               return i;
> -
>         return target;
>  }
>
