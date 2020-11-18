Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09452B817E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgKRQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKRQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:06:47 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD47C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:06:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so3688473lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6f4dav7ATAax7XPW13cjbLpbLpT7AAuV8964tjQIwfw=;
        b=wIAAl58dH5TmeearBT/Svzeo2aUmROCnzDOgEUu9xSsKtcBd1/v1IDBGtMB8ayPHor
         WxC1RwlxQAE0njmfKAJLPc9Q08r1pfAPPD/5BEMjDo1zo7BzCU8J7b14LXuNpvFUfTbj
         T/4muZmidJvWHFc9m6TrGFv7gsqH0Wlr6ybuzZB0Xoq0vk1EtGq3JHOlP8+72Em+OS2J
         l4eu8d6uk7PlPbCDOlGs3bKk5KSYXXvUe4efKMtXPpnmhI7RJo+BTpn8SHzfMULINuhc
         N8Weba2jQjZ28kWzMKPtSgBQ3W90cmrQW54VCNnCSEpXbKb5p3JLGLwhBMcUmMulvW2+
         mOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6f4dav7ATAax7XPW13cjbLpbLpT7AAuV8964tjQIwfw=;
        b=iZlUHiNXQpFvEa3JexKe669TO4+f9MtydV4w/fqoKX516fiVPDV35nTG5rjq407Wc0
         r9GM87qv9uQ5agD9vFa+4mg2DNA/bq4pvcx6VCNyVr/ESO6HkM+ufZrqu2AF+hBuHyJ8
         o/dQhdUBVr+W8yOBaNH0QooKgAJKmAIOa1QzUQY0aRBbcsrK/0nY27T3Qdqlre7+dN68
         iPPqmFBoz1myELKy6GHrdk8q8Q2hCSmOT624BgLjzgooaHx6qXALGurHKMTwlRiQwzi1
         aB+H4vn4oD3fHLTkcorroT47Bh4YGbFRHE9VIBPbep0ZXIjSMrBFS0/R4tX4JbpDcaAa
         rbeQ==
X-Gm-Message-State: AOAM533oOMCxJvgYTeTv5tLU1ENubXdR7MO3ktChGF5n1NOupvHwob19
        q6Xr+4f90LQ111StnprWiBvJ+//o4swp15ZNyQha8Q==
X-Google-Smtp-Source: ABdhPJxEpn9PbcliTCYN82vYm/xnn8J4M634iKPpsLFOuETDZ97sq7/BC7Ir8l7AOphhOvGSbELZ/JMyQqgOAOy3ImU=
X-Received: by 2002:a05:6512:200e:: with SMTP id a14mr3703228lfb.573.1605715604575;
 Wed, 18 Nov 2020 08:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net> <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
 <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com>
 <20201117151740.GB3371@techsingularity.net> <CAKfTPtD27L0Epg7wPzw7G2zDL8XgdVbB45dZEZEsLmuwRp5gcg@mail.gmail.com>
 <20201117172847.GC3371@techsingularity.net>
In-Reply-To: <20201117172847.GC3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 Nov 2020 17:06:32 +0100
Message-ID: <CAKfTPtBdLJzbv0PFbYeveKeF2_+CgRzwexP5g7E5cgirfc6big@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can
 exist at fork time
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 at 18:28, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Nov 17, 2020 at 04:53:10PM +0100, Vincent Guittot wrote:
> > On Tue, 17 Nov 2020 at 16:17, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Tue, Nov 17, 2020 at 03:31:19PM +0100, Vincent Guittot wrote:
> > > > On Tue, 17 Nov 2020 at 15:18, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Tue, Nov 17, 2020 at 01:42:22PM +0000, Mel Gorman wrote:
> > > > > > -                     if (local_sgs.idle_cpus)
> > > > > > +                     if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> > > > > >                               return NULL;
> > > > >
> > > > > Is that the same 25% ?
> > > >
> > > > same question for me
> > >
> > > It's the same 25%. It's in the comment as -- utilisation is not too high
> >
> > utilization is misleading, it usually refers to pelt utilization
> > whereas whet you check is the number of busy cpus
> >
>
> Will fix.
>
> > > where "high" is related to adjust_numa_imbalance.
> > >
> > > > could we encapsulate this 25% allowed imbalance like for adjust_numa_imbalance
> > >
> > > Using adjust_numa_imbalance() directly in this context would be awkward
> >
> > Would be good to use the same function to say if we allow or not the imbalance
> >
> > something like numa_allow_imbalance(sg_lb_stats * group_stats)
> >
>
> Also can be done.
>
> > which would return how much margin remains available before not
> > allowing the imbalance
> >
>
> Easier to just make it a bool as the available margin is not relevant
> (yet).

That's my point, preparing future evolution by providing directly the
stats struct which have all this information and even more for further
enhancement and return how much imbalance is still acceptable.

But this probably means to align numa stats with lb stats to share the
same struct

>
> >
> > > but the threshold could be shared with something like the additional
> > > diff below. Is that what you had in mind or something different?
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index adfab218a498..49ef3484c56c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5878,6 +5878,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> > >  static struct sched_group *
> > >  find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
> > >
> > > +static inline int numa_imbalance_threshold(int weight);
> > > +
> > >  /*
> > >   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> > >   */
> > > @@ -8894,7 +8896,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> > >                          * If there is a real need of migration, periodic load
> > >                          * balance will take care of it.
> > >                          */
> > > -                       if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> >
> > also here you use idle_cpus and on the other part you use nr_running.
> > Can't we use the same metrics on both sides?
> >
>
> We can. Basing it on sum_nr_running is only an approximation of the number
> of busy CPUs if tasks are bound to a subset of CPUs but it would mean that
> the fork spreading decision is in line with adjust_numa_imbalance(). That
> is a sensible starting point and we could pass in
> (sd->span_weight - local_sgs.idle_cpus into numa_allow_imbalance()) if
> there was strong justification for it.
>
> Untested patch currently looks like
>
> ---
>  kernel/sched/fair.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 33709dfac24d..4c8a3b570b0a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1550,6 +1550,7 @@ struct task_numa_env {
>  static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
>  static unsigned long cpu_util(int cpu);
> +static inline bool allow_numa_imbalance(int dst_running, int dst_weight);
>  static inline long adjust_numa_imbalance(int imbalance,
>                                         int dst_running, int dst_weight);
>
> @@ -8779,9 +8780,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                         .group_type = group_overloaded,
>         };
>
> -       imbalance = scale_load_down(NICE_0_LOAD) *
> -                               (sd->imbalance_pct-100) / 100;
> -
>         do {
>                 int local_group;
>
> @@ -8835,6 +8833,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>         switch (local_sgs.group_type) {
>         case group_overloaded:
>         case group_fully_busy:
> +
> +               /* Calculate allowed imbalance based on load */
> +               imbalance = scale_load_down(NICE_0_LOAD) *
> +                               (sd->imbalance_pct-100) / 100;

forgot to mention this previously, but this change seems unrelated to
rest of this patch and could deserve a dedicated patch

> +
>                 /*
>                  * When comparing groups across NUMA domains, it's possible for
>                  * the local domain to be very lightly loaded relative to the
> @@ -8891,7 +8894,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                          * a real need of migration, periodic load balance will
>                          * take care of it.
>                          */
> -                       if (local_sgs.idle_cpus)
> +                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
>                                 return NULL;
>                 }
>
> @@ -8995,9 +8998,22 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>  #define NUMA_IMBALANCE_MIN 2
>
> +/*
> + * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
> + * This is an approximation as the number of running tasks may not be
> + * related to the number of busy CPUs due to sched_setaffinity.
> + */
> +static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> +{
> +       return (dst_running < (dst_weight >> 2));
> +}
> +
>  static inline long adjust_numa_imbalance(int imbalance,
>                                 int dst_running, int dst_weight)
>  {
> +       if (!allow_numa_imbalance(dst_running, dst_weight))
> +               return imbalance;
> +
>         /*
>          * Allow a small imbalance based on a simple pair of communicating
>          * when the destination is lightly loaded so that pairs of
