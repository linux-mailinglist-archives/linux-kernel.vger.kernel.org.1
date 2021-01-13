Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C145D2F509A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbhAMRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbhAMRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:03:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868EC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:03:13 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m25so3777803lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uABUKzRBrkvQPh3HDm57mscCiO0O9AshHCQNbV8Z/9M=;
        b=V0gG3s47KwuyhPSVx4Y1ZodZsDuJVA0HeZBwWJWG+Xg27HbhT85SPr3fHYuUkz+1Oh
         tfFYV/Z/TEFt/sKQq7oVKvDrwKA6zTHxkfwOUOoquDAotIgvYsy9KsTaUt8E4zPzVl86
         LIFPBHDMCUp0kvLE+5r6BVx6wqeylVrGcJS+uOVFZzxM1jz8UllFGEn79zcgN9uqDYHv
         xEBdGGOXegywe95NMJBcFm2FydD68WRN04b+n8blqc5vb+MU+OUR8qMP0iuCs3cJIBnx
         uq+5OAzbD9hsWEwzP9+dCBIKUITa0pvWXK+txl23IE19AerzUUx7Q2sH+DapRl4jcmkY
         vZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uABUKzRBrkvQPh3HDm57mscCiO0O9AshHCQNbV8Z/9M=;
        b=nwPR9u6cmy0mNHktoFH0qwNTDWSHtPs0iLL8qg4uUxFZ1LzRwhbaM45ZJ2EFRJ4g6C
         7o9OPoqjq4nUWHomrsyB3KGg4bXfMVf4uXAh69yBsgDJMyDDXrrjclBSxFmec5eWm0rd
         /jsAs+o1JTHFaruOE0QKKu9/TyGB7sw98Ktaquw7ktEY4h19QAM3t3RVPTPdJ+FLT/py
         /zXdMkIkZRZ+B1eGEkjO1W/vjZ1ty0sRnku7Y9uUT2cFmgaKuR9vXh2t6Ez2XS6WYemH
         OEZJwxPvHl+JOxj3mEVdzq3o0Ec9GkZghTjF/PSqjuNY8Uhk+OvEgKUBOTMGCSDOwYg9
         aL8Q==
X-Gm-Message-State: AOAM5336/gofUYxXfBlLLLbWC9B4NDi2AODo9yrkTGHTVZdUWyxijaSd
        2tlPQTK4mV6vCX3BCkoeK/ni38ILNB1/D2FgC/7EVw==
X-Google-Smtp-Source: ABdhPJzN7rtndShfkdVoaEPcHP/WSvSLmtTmi7vIT4ejS9KABNbaaSrwbLHXSnNzjLC2MGHW02X0lqnqfK1wsGSfZhA=
X-Received: by 2002:a19:ac45:: with SMTP id r5mr1386793lfc.305.1610557391585;
 Wed, 13 Jan 2021 09:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20210111155047.10657-1-mgorman@techsingularity.net> <20210111155047.10657-6-mgorman@techsingularity.net>
In-Reply-To: <20210111155047.10657-6-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Jan 2021 18:03:00 +0100
Message-ID: <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 at 16:50, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Both select_idle_core() and select_idle_cpu() do a loop over the same
> cpumask. Observe that by clearing the already visited CPUs, we can
> fold the iteration and iterate a core at a time.
>
> All we need to do is remember any non-idle CPU we encountered while
> scanning for an idle core. This way we'll only iterate every CPU once.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 97 +++++++++++++++++++++++++++------------------
>  1 file changed, 59 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 12e08da90024..84f02abb29e3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6006,6 +6006,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>         return new_cpu;
>  }
>
> +static inline int __select_idle_cpu(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> +{
> +       if (available_idle_cpu(core) || sched_idle_cpu(core))
> +               return core;
> +
> +       return -1;
> +}
> +
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
> @@ -6066,40 +6074,34 @@ void __update_idle_core(struct rq *rq)
>   * there are no idle cores left in the system; tracked through
>   * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
>   */
> -static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
> -       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       int core, cpu;
> +       bool idle = true;
> +       int cpu;
>
>         if (!static_branch_likely(&sched_smt_present))
> -               return -1;
> -
> -       if (!test_idle_cores(target, false))
> -               return -1;
> -
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +               return __select_idle_cpu(p, core, cpus, idle_cpu);
>
> -       for_each_cpu_wrap(core, cpus, target) {
> -               bool idle = true;
> -
> -               for_each_cpu(cpu, cpu_smt_mask(core)) {
> -                       if (!available_idle_cpu(cpu)) {
> -                               idle = false;
> -                               break;
> +       for_each_cpu(cpu, cpu_smt_mask(core)) {
> +               if (!available_idle_cpu(cpu)) {
> +                       idle = false;
> +                       if (*idle_cpu == -1) {
> +                               if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                                       *idle_cpu = cpu;
> +                                       break;
> +                               }
> +                               continue;
>                         }
> +                       break;
>                 }
> -
> -               if (idle)
> -                       return core;
> -
> -               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> +               if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> +                       *idle_cpu = cpu;
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
> @@ -6107,9 +6109,18 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>
>  #define sched_smt_weight       1
>
> -static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> +static inline void set_idle_cores(int cpu, int val)
>  {
> -       return -1;
> +}
> +
> +static inline bool test_idle_cores(int cpu, bool def)
> +{
> +       return def;
> +}
> +
> +static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> +{
> +       return __select_idle_cpu(p, core, cpus, idle_cpu);
>  }
>
>  #endif /* CONFIG_SCHED_SMT */
> @@ -6124,10 +6135,11 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       bool smt = test_idle_cores(target, false);
> +       int this = smp_processor_id();
>         struct sched_domain *this_sd;
>         u64 time;
> -       int this = smp_processor_id();
> -       int cpu, nr = INT_MAX;
>
>         this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>         if (!this_sd)
> @@ -6135,7 +6147,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> -       if (sched_feat(SIS_PROP)) {
> +       if (sched_feat(SIS_PROP) && !smt) {
>                 u64 avg_cost, avg_idle, span_avg;
>
>                 /*
> @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
>                         return -1;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       break;
> +               if (smt) {

If we want to stay on something similar to the previous behavior, we
want to check on all cores if test_idle_cores is true so nr should be
set to number of cores

and if there is no idle core, nr should be divided by sched_smt_weight
so we will only scan a limited number of core

and you can always call select_idle_core()

> +                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +                       if ((unsigned int)i < nr_cpumask_bits)
> +                               return i;
> +
> +               } else {
> +                       i = __select_idle_cpu(p, cpu, cpus, &idle_cpu);
> +                       if ((unsigned int)i < nr_cpumask_bits) {
> +                               idle_cpu = i;
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
>                 time = cpu_clock(this) - time;
>                 update_avg(&this_sd->avg_scan_cost, time);
>         }
>
> -       return cpu;
> +       return idle_cpu;
>  }
>
>  /*
> @@ -6297,10 +6322,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if (!sd)
>                 return target;
>
> -       i = select_idle_core(p, sd, target);
> -       if ((unsigned)i < nr_cpumask_bits)
> -               return i;
> -
>         i = select_idle_cpu(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
> --
> 2.26.2
>
