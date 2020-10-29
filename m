Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1833429ED8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgJ2Ntc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgJ2Ntb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:49:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC1C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:49:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so3431695lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZUfcMSQ+thfNe5UaO4M/7SlxetTxYeHgw6aaHYum/I=;
        b=Vr+Tch+6nXFlVbhjn9k8yy4wHYI6MHhO8UmQCgXh2vFFj5NeM13r0nkq1DdRYK5jjh
         HbQzjUFokwjkGe9vw0smA6Xt6zGN7CzdXRtXJJzntfIM6TR0lvSpThjuhsl0PlK4CKVO
         0BDAT4RRSS6PO1kvGSI4hWqaLLpZJDhrifqdWcDdRkSpkvU0KOdiT8aQRcEWB7hwnqLB
         LUHkaRTmDRVLDKE4QZIoxalyrHLvJgpOJsGLCvZJUewQxeG2AjPNhk52qg6UwBHmoPdy
         tWvTXGgnGxiMGckR09cwlCovA9y5M/IHHyx3qAM5zV6mFvEMOdZySNBnsD0HjzBLSnkb
         NZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZUfcMSQ+thfNe5UaO4M/7SlxetTxYeHgw6aaHYum/I=;
        b=QCLPBTUGBg+K3vlgdduMvrJi4UhPIgldZLrkTMltFg/qzNsVL6OWimq7GbZwWdIeC3
         eArqtlvxXJePwIotEP7GDKSNTslzytScmGElqPBR7gPtYSfF/Z3BvKRmgIW8FqtF01n3
         EwPF6XDm4KWMa/ugVgd6Wkejolk+obiuRA5R6BScWpFLrdGZ1rfGAmgEftywsFe1OkNW
         XD7y2CG5N+coVN3RDlaP3newYe2AqpTvXQ94hsXeNcbDVECNwykCneDGbVCfglE6Qq6B
         +WWAxMYo+aale0FMbpvuSziJhby1AjoaHwMTl0doynSv2Wjji8hoKZNF7QEay3Ab4SIf
         FKmQ==
X-Gm-Message-State: AOAM533SzLrw/zR55lxDnRXCJmbQDDMUAd/y+9lyxsTs/sBvNCjRXCS2
        g4qijfu1V8dql5EOt4ZItKmjGfN8tiFWCwYH5QO+jSNJzhg=
X-Google-Smtp-Source: ABdhPJwbJd7oxMGCqg8aCbcrKKM35TwPqrmCS4S8Ce1LQYdH+JH0GXEzzoxUVV7w/khoQ8X6dzb85RVAzzNiuT63ZzE=
X-Received: by 2002:a19:2355:: with SMTP id j82mr1523661lfj.385.1603979368047;
 Thu, 29 Oct 2020 06:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201028174412.680-1-vincent.guittot@linaro.org> <BN8PR12MB2978D627EE0D6456DC2EEA6B9A140@BN8PR12MB2978.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB2978D627EE0D6456DC2EEA6B9A140@BN8PR12MB2978.namprd12.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Oct 2020 14:49:16 +0100
Message-ID: <CAKfTPtCwm_KH1Qnh+45wzu1ZnkohQmhDs-25M4cZ7eW1FH=oww@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: prefer prev cpu in asymmetric wakeup path
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 at 13:17, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> Hi Vincent,
>
> On Wed, Oct 28, 2020 at 06:44:12PM +0100, Vincent Guittot wrote:
> > During fast wakeup path, scheduler always check whether local or prev cpus
> > are good candidates for the task before looking for other cpus in the
> > domain. With
> >   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > the heterogenous system gains a dedicated path but doesn't try to reuse
> > prev cpu whenever possible. If the previous cpu is idle and belong to the
> > LLC domain, we should check it 1st before looking for another cpu because
> > it stays one of the best candidate and this also stabilizes task placement
> > on the system.
> >
> > This change aligns asymmetric path behavior with symmetric one and reduces
> > cases where the task migrates across all cpus of the sd_asym_cpucapacity
> > domains at wakeup.
> >
> > This change does not impact normal EAS mode but only the overloaded case or
> > when EAS is not used.
> >
> > - On hikey960 with performance governor (EAS disable)
> >
> > ./perf bench sched pipe -T -l 50000
> >              mainline           w/ patch
> > # migrations   999364                  0
> > ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%
> >
> > - On hikey with performance governor
> >
> > ./perf bench sched pipe -T -l 50000
> >              mainline           w/ patch
> > # migrations        0                  0
> > ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%
> >
> > According to test on hikey, the patch doesn't impact symmetric system
> > compared to current implementation (only tested on arm64)
> >
> > Also read the uclamped value of task's utilization at most twice instead
> > instead each time we compare task's utilization with cpu's capacity.
> >
> > Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > Changes in v2:
> > - merge asymmetric and symmetric path instead of duplicating tests on target,
> >   prev and other special cases.
> >
> > - factorize call to uclamp_task_util(p) and use fits_capacity(). This could
> >   explain part of the additionnal improvement compared to v1 (+22% instead of
> >   +17% on v1).
> >
> > - Keep using LLC instead of asym domain for early check of target, prev and
> >   recent_used_cpu to ensure cache sharing between the task. This doesn't
> >   change anything for dynamiQ but will ensure same cache for legacy big.LITTLE
> >   and also simply the changes.
> >
> > - don't check capacity for the per-cpu kthread UC because the assumption is
> >   that the wakee queued work for the per-cpu kthread that is now complete and
> >   the task was already on this cpu.
> >
> > - On an asymmetric system where an exclusive cpuset defines a symmetric island,
> >   task's load is synced and tested although it's not needed. But taking care of
> >   this special case by testing if sd_asym_cpucapacity is not null impacts by
> >   more than 4% the performance of default sched_asym_cpucapacity path.
> >
> > - The huge increase of the number of migration for hikey960 mainline comes from
> >   teh fact that the ftrace buffer was overloaded by events in the tests done
> >   with v1.
> >
> >  kernel/sched/fair.c | 68 ++++++++++++++++++++++++++++-----------------
> >  1 file changed, 43 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index aa4c6227cd6d..131b917b70f8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6173,20 +6173,20 @@ static int
> >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> >       unsigned long best_cap = 0;
> > -     int cpu, best_cpu = -1;
> > +     int task_util, cpu, best_cpu = -1;
> >       struct cpumask *cpus;
> >
> > -     sync_entity_load_avg(&p->se);
> > -
> >       cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >
> > +     task_util = uclamp_task_util(p);
>
> The return type of uclamp_task_util() is *unsigned long*.
> But, task_util is *int*.

argh, yes I have been fooled by the return type of task_fits_capacity

Form a functional pov, we were safe because task's util_avg can't go above 1024

>
> @Valentin: I checked that the return type of uclamp_task_util()
> is changed from unsigned int to unsigned long by you
>
>
> >       for_each_cpu_wrap(cpu, cpus, target) {
> >               unsigned long cpu_cap = capacity_of(cpu);
> >
> >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >                       continue;
> > -             if (task_fits_capacity(p, cpu_cap))
> > +             if (fits_capacity(task_util, cpu_cap))
> >                       return cpu;
> >
> >               if (cpu_cap > best_cap) {
> > @@ -6198,44 +6198,41 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >       return best_cpu;
> >  }
> >
> > +static inline int asym_fits_capacity(int task_util, int cpu)
> > +{
> > +     if (static_branch_unlikely(&sched_asym_cpucapacity))
> > +             return fits_capacity(task_util, capacity_of(cpu));
> > +
> > +     return 1;
> > +}
>
> The return type of asym_fits_capacity() could be *bool*.
>
>   'return fits_capacity(task_util, capacity_of(cpu));'
>
> is equivalent to:
>
>   'return ((cap) * 1280 < (max) * 1024);'
>
> I do not know anything far enough, just notice may stack more bytes.
>
> >  /*
> >   * Try and locate an idle core/thread in the LLC cache domain.
> >   */
> >  static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  {
> >       struct sched_domain *sd;
> > -     int i, recent_used_cpu;
> > +     int i, recent_used_cpu, task_util;
> >
> >       /*
> > -      * For asymmetric CPU capacity systems, our domain of interest is
> > -      * sd_asym_cpucapacity rather than sd_llc.
> > +      * On asymmetric system, update task utilization because we will check
> > +      * that the task fits with cpu's capacity.
> >        */
> >       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > -             sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> > -             /*
> > -              * On an asymmetric CPU capacity system where an exclusive
> > -              * cpuset defines a symmetric island (i.e. one unique
> > -              * capacity_orig value through the cpuset), the key will be set
> > -              * but the CPUs within that cpuset will not have a domain with
> > -              * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
> > -              * capacity path.
> > -              */
> > -             if (!sd)
> > -                     goto symmetric;
> > -
> > -             i = select_idle_capacity(p, sd, target);
> > -             return ((unsigned)i < nr_cpumask_bits) ? i : target;
> > +             sync_entity_load_avg(&p->se);
> > +             task_util = uclamp_task_util(p);
> >       }
> >
> > -symmetric:
> > -     if (available_idle_cpu(target) || sched_idle_cpu(target))
> > +     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> > +         asym_fits_capacity(task_util, target))
> >               return target;
> >
> >       /*
> >        * If the previous CPU is cache affine and idle, don't be stupid:
> >        */
> >       if (prev != target && cpus_share_cache(prev, target) &&
> > -         (available_idle_cpu(prev) || sched_idle_cpu(prev)))
> > +         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > +         asym_fits_capacity(task_util, prev))
> >               return prev;
> >
> >       /*
> > @@ -6258,7 +6255,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >           recent_used_cpu != target &&
> >           cpus_share_cache(recent_used_cpu, target) &&
> >           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> > -         cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
> > +         cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> > +         asym_fits_capacity(task_util, recent_used_cpu)) {
> >               /*
> >                * Replace recent_used_cpu with prev as it is a potential
> >                * candidate for the next wake:
> > @@ -6267,6 +6265,26 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >               return recent_used_cpu;
> >       }
> >
> > +     /*
> > +      * For asymmetric CPU capacity systems, our domain of interest is
> > +      * sd_asym_cpucapacity rather than sd_llc.
> > +      */
> > +     if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > +             sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> > +             /*
> > +              * On an asymmetric CPU capacity system where an exclusive
> > +              * cpuset defines a symmetric island (i.e. one unique
> > +              * capacity_orig value through the cpuset), the key will be set
> > +              * but the CPUs within that cpuset will not have a domain with
> > +              * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
> > +              * capacity path.
> > +              */
> > +             if (sd) {
> > +                     i = select_idle_capacity(p, sd, target);
> > +                     return ((unsigned)i < nr_cpumask_bits) ? i : target;
> > +             }
> > +     }
> > +
> >       sd = rcu_dereference(per_cpu(sd_llc, target));
> >       if (!sd)
> >               return target;
> > --
> > 2.17.1
