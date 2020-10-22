Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD92961B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901456AbgJVPd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441559AbgJVPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:33:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32053C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:33:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 184so2791945lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f6nu26MZaX4rWbR59C4IEijWIP+uSQ3OwshMCxJxsI=;
        b=z7qWpJzUyL2lRfMd8OtJxUVGNJd3VMG7VD7XgwVRYzPUabt+CSKbm+0ssFgjO/6Eou
         2/8SCsXFEpzm+YUR+lYRAyrT40HRVwSgpE0pX2MPQT0Rqx12P9SbdCdam66TR++A28QX
         +URl8FcHPqfgMJ6YjkQg7Re51cT+Ffb4ljeYlHn+ZEHgysvrnoxf9Jwtnoja0fki+/9g
         3z0Pg+arT1DWQ24/Aiwzl3a1i/oeauQ5h2I3Mr1lCcLLarAt2maKB4KmrluOwqrMwy4d
         9Px59J7hxSTl7a9nnjcL2lmeYKMHEPAbFmZTEdYyA6d4UjNu4uOwPWf08nVRa+O8vc/G
         t7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f6nu26MZaX4rWbR59C4IEijWIP+uSQ3OwshMCxJxsI=;
        b=S9UGyVOQl6QV6nTqn6Btyhq7PIwEFNVhxDvjxgJ44Pq5q36yQpD5PrYF0CG0nevLPC
         XBAE5vp42CHpbw6joS9pXqRAP12YXZbyZOTHQdM09pTB74ABdYUOgXjiLbYllm7TD3dI
         uNt1fxphD4ky6YZU2IgWyvs8nc51iIINpLvROysWqYTaIwVdEMIgBZEfHCkkG+Xs6Wdv
         Yad2dETilBWagieDimAp+7rMjA7ZFfZ6qyZUAAw75zgG5Zj7H7KXe/G1VNgDvDPmv4bk
         CKJwW/c/+ufCq6M+vsGAeiqJqeIMBgy8ZcE7qC6bVaSdrWNWfu2auf/MWkwGp0zjtzLV
         mdag==
X-Gm-Message-State: AOAM530fnPMuvRl7Z/GGmeQxgSCLsq7hH6FwhCc6qd0vApcbVorEsrXJ
        /cGwx6PmMcqC6B9/EHYMBg3TDXD1qKnSzksQjfIAeg==
X-Google-Smtp-Source: ABdhPJx5ITqd/2vbB6ZgzhnIqcFB1C044h5Up29owjkOiG1vNJmOUSDZ/IAKmgYCMm+YP8LLd8eJAoinUTrvyzQTNBI=
X-Received: by 2002:a19:d10:: with SMTP id 16mr985732lfn.385.1603380804454;
 Thu, 22 Oct 2020 08:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201022134354.3485-1-vincent.guittot@linaro.org> <jhj1rhqqplq.mognet@arm.com>
In-Reply-To: <jhj1rhqqplq.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Oct 2020 17:33:13 +0200
Message-ID: <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: prefer prev cpu in asymmetric wakeup path
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 16:53, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> Hi Vincent,
>
> On 22/10/20 14:43, Vincent Guittot wrote:
> > During fast wakeup path, scheduler always check whether local or prev cpus
> > are good candidates for the task before looking for other cpus in the
> > domain. With
> >   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > the heterogenous system gains a dedicated path but doesn't try to keep
> > reusing prev cpu whenever possible. If the previous cpu is idle and belong to the
> > asymmetric domain, we should check it 1st before looking for another cpu
> > because it stays one of the best candidate and it stabilizes task placement
> > on the system.
> >
> > This change aligns asymmetric path behavior with symmetric one and reduces
> > cases where the task migrates across all cpus of the sd_asym_cpucapacity
> > domains at wakeup.
> >
> > This change does not impact normal EAS mode but only the overloaded case or
> > when EAS is not used.
> >
> > On hikey960 with performance governor (EAS disable)
> >
> > ./perf bench sched pipe -T -l 150000
> >              mainline           w/ patch
> > # migrations   299811                  3
>
> Colour me impressed!
>
> Now AFAICT the only thing that makes new_cpu != prev_cpu in
> select_task_rq_fair() is the WAKE_AFFINE stuff, and the likelihood of that
> happening increases when WF_SYNC (which the Android binder uses, at least
> on a mainline tree). I had severely underestimated how often that thing
> picks this_cpu.
>
> > ops/sec        154535(+/-0.13%)   181754(+/- 0.29) +17%
> >
> > Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index aa4c6227cd6d..f39638fe6b94 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6170,7 +6170,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >   * maximize capacity.
> >   */
> >  static int
> > -select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
> >  {
> >       unsigned long best_cap = 0;
> >       int cpu, best_cpu = -1;
> > @@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >
> >       sync_entity_load_avg(&p->se);
> >
> > +     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> > +         task_fits_capacity(p, capacity_of(target)))
> > +             return target;
> > +
>
> I think we still need to check for CPU affinity here.

yes good point

>
> >       cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >
> > +     /*
> > +      * If the previous CPU belongs to this asymmetric domain and is idle,
> > +      * check it 1st as it's the best candidate.
> > +      */
> > +     if (prev != target && cpumask_test_cpu(prev, cpus) &&
> > +         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > +         task_fits_capacity(p, capacity_of(prev)))
> > +             return prev;
> > +
> >       for_each_cpu_wrap(cpu, cpus, target) {
>
> So we prioritize target over prev, like the rest of the
> select_idle_sibling() family. Here however we apply the same acceptability
> function to target, prev and the loop body, so perhaps we could simplify
> this to:

My 1st implementation was similar to you proposal below but i finally
decided to strictly follow the same sequence as symmetric which:
- checks target
- then prev cpu
- and finally uses target as the starting point of the loop for
looking for another cpu

Using prev as the starting point of the loop will change which cpu
will be selected but I don't have a strong opinion if this will make a
real difference at the end because bit position doesn't imply any
relation with others cpus.

So I'm fine to go with your proposal below

Also I wonder if i should also add the test of p->recent_used_cpu and
the per cpu kthread optimization, which benefit XFS IIRC.

>
>   if (accept(target))
>       return target;
>
>   ...
>
>   for_each_cpu_wrap(cpu, cpus, prev) {
>       ...
>   }
>
> That way we evaluate target twice only if it isn't a direct candidate
> (but might be a fallback one).
>
> >               unsigned long cpu_cap = capacity_of(cpu);
> >
> > @@ -6223,7 +6236,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >               if (!sd)
> >                       goto symmetric;
> >
> > -             i = select_idle_capacity(p, sd, target);
> > +             i = select_idle_capacity(p, sd, prev, target);
> >               return ((unsigned)i < nr_cpumask_bits) ? i : target;
> >       }
