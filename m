Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B0296A23
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375657AbgJWHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373950AbgJWHQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:16:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1316C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:16:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so449305ljn.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57USzFpsWiPQzNOzRw9qjMnByIV9pu7Vaq3e5wmlXPo=;
        b=P0rcIz02drFreoGEWHz0sOEvIS0h0AmfpjXPV6R2sOrg3Hhe6kQ2qDTkQbGWm6uVMr
         ORswWCMA63hSlbdxEtZaHh7XpQ3/D8rIOOl+M0ZBq9SgDTvgR/ivaNR++oW0H56JbQIy
         GvGWjALm7OwF7jVun1CXD0dcN+6l32d6jZOeMu2ivIUOi25UTPwc5mev05iVEMvkBbE9
         CyXcY9bSDaFEYVs7keCGjKoPCkJKlE/I8/ZzAeoMpcbNfg4M8XkwxKu1mi3w2zK918/g
         G3pyCs7v/wXpcJLSyjkEHnVk5iX5eAIFwdJnE8zrNruCy1GDD6Bp6jO85yOinM1e1OGf
         c00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57USzFpsWiPQzNOzRw9qjMnByIV9pu7Vaq3e5wmlXPo=;
        b=Sn1EeDoE3FX3NCgfyY4a1xHnm8ziwT7dMRK4tEyCxTltZKpohma0knYr925RqSvkGA
         GTugIDEhUHN3o5YUUS3vTr7Uwjob0hEsXUG+67Bpbs6NcHu0uS7p7u/4n8VTB2eX991m
         MWC1pALXgeovE0yVyod/JDAQ7mqumkWy2VcppQ0rR94xXCA2yoxk9YpmhHibabD5wnpR
         jiqnPD62GSThzKlsy+KC+OEM54b1VM6KNPGy35OtPmDwydu9ATvvRLRiH9k8wcyV1ZV8
         z+YTqd0u3XbMerc6zNkU0TtLQLJ2n0B1M2cgTLTvVwB7gYcbOsGN+suubXW9as1HdFax
         TNtQ==
X-Gm-Message-State: AOAM53196XU7U727C3ZdBf0RX9b3Dn7OdXrJgX5g7FGx0dL/i9dV3cle
        xBixDdqU9BpSC+7CevtLI7VQ2vIM6uRPYBQSIFMmbw==
X-Google-Smtp-Source: ABdhPJxUaI7yebnJAYY6+39XWQtUP9agIyKTPc7MCcBmt7DnonTTQtorFSbkWVeUnwY/ITDknsr/abkXyiZZEmmaUCw=
X-Received: by 2002:a2e:8787:: with SMTP id n7mr337039lji.111.1603437360069;
 Fri, 23 Oct 2020 00:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201022134354.3485-1-vincent.guittot@linaro.org>
 <jhj1rhqqplq.mognet@arm.com> <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
 <jhjzh4ep31l.mognet@arm.com>
In-Reply-To: <jhjzh4ep31l.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 23 Oct 2020 09:15:48 +0200
Message-ID: <CAKfTPtCysU8OikyOqYLsoYEiBjyQbuw_X9RjJWh3NFO89=5RFQ@mail.gmail.com>
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

On Thu, 22 Oct 2020 at 19:46, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 22/10/20 16:33, Vincent Guittot wrote:
> > On Thu, 22 Oct 2020 at 16:53, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >> > @@ -6170,7 +6170,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >> >   * maximize capacity.
> >> >   */
> >> >  static int
> >> > -select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >> > +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
> >> >  {
> >> >       unsigned long best_cap = 0;
> >> >       int cpu, best_cpu = -1;
> >> > @@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >> >
> >> >       sync_entity_load_avg(&p->se);
> >> >
> >> > +     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> >> > +         task_fits_capacity(p, capacity_of(target)))
> >> > +             return target;
> >> > +
> >>
> >> I think we still need to check for CPU affinity here.
> >
> > yes good point
> >
> >>
> >> >       cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >> >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >> >
> >> > +     /*
> >> > +      * If the previous CPU belongs to this asymmetric domain and is idle,
> >> > +      * check it 1st as it's the best candidate.
> >> > +      */
> >> > +     if (prev != target && cpumask_test_cpu(prev, cpus) &&
> >> > +         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> >> > +         task_fits_capacity(p, capacity_of(prev)))
> >> > +             return prev;
> >> > +
> >> >       for_each_cpu_wrap(cpu, cpus, target) {
> >>
> >> So we prioritize target over prev, like the rest of the
> >> select_idle_sibling() family. Here however we apply the same acceptability
> >> function to target, prev and the loop body, so perhaps we could simplify
> >> this to:
> >
> > My 1st implementation was similar to you proposal below but i finally
> > decided to strictly follow the same sequence as symmetric which:
> > - checks target
> > - then prev cpu
> > - and finally uses target as the starting point of the loop for
> > looking for another cpu
> >
> > Using prev as the starting point of the loop will change which cpu
> > will be selected but I don't have a strong opinion if this will make a
> > real difference at the end because bit position doesn't imply any
> > relation with others cpus.
> >
>
> Yep, also one difference with the symmetric path here is that the first
> checks against target & prev use exactly the same criteria as the loop
> body, so we shouldn't feel shy about doing this here.
>
> > So I'm fine to go with your proposal below
> >
> > Also I wonder if i should also add the test of p->recent_used_cpu and
> > the per cpu kthread optimization, which benefit XFS IIRC.
> >
>
> If we head down that route it would be nice to reuse the existing
> conditions (rather than copy and tweak them) and move the asymmetric loop
> further down. Maybe with something like (with a better name though):

Yes, That would ensure that asymmetric will stay align symmetric.

I 'm going to look at this for the next version

>
>   static inline bool asym_task_fits_capacity(struct task_struct *p, int cpu)
>   {
>           if (!static_branch_unlikely(&sched_asym_cpucapacity))
>                   return true;
>
>           return task_fits_capacity(p, capacity_of(cpu));
>   }
>
> and we could && that to the existing cases. Food for thought.
>
> >>
> >>   if (accept(target))
> >>       return target;
> >>
> >>   ...
> >>
> >>   for_each_cpu_wrap(cpu, cpus, prev) {
> >>       ...
> >>   }
> >>
> >> That way we evaluate target twice only if it isn't a direct candidate
> >> (but might be a fallback one).
> >>
> >> >               unsigned long cpu_cap = capacity_of(cpu);
> >> >
> >> > @@ -6223,7 +6236,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >> >               if (!sd)
> >> >                       goto symmetric;
> >> >
> >> > -             i = select_idle_capacity(p, sd, target);
> >> > +             i = select_idle_capacity(p, sd, prev, target);
> >> >               return ((unsigned)i < nr_cpumask_bits) ? i : target;
> >> >       }
