Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30F2B691C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKQPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKQPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:53:25 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC1C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:53:23 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id w142so30737655lff.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wrbxy0MZbhrpOaPG1/4psjQwixG+teUQ/GK/suwoP/8=;
        b=yRuwbwjVjZFUz+DlpAdwpiqrtorJh3UEIh9dc9GnB3kVjn+eewa5XaU05O5Jyu1uXT
         VnmKIQBBT1eZ4O/j4PMuGhIBlW+59zR/H2tq4tDz5rooCjDQFxOwRNZ8w7S2zMYW+Pv0
         zghBO+IhPQQk3pkDz+FrUA5fXETCIReiXwfXK8rFRcXSWUp33CGGzg4wPPKG9vJa8MGB
         bv5fdaYPaV831g562hFV5PSquJATRU9bobX17kduK3MczuSLidYGngfJyL3Dj+JIbOL9
         XM62djJv2VgagyDtTxLsXISjXDuY5W4x4VuZvtJGjk6pJuv8TOvPPl/OgiFqWJ6Ttl8i
         RsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wrbxy0MZbhrpOaPG1/4psjQwixG+teUQ/GK/suwoP/8=;
        b=Hh+nOb9UyyRuKubyLgRYdN6f8E93RDVDYKmeX3WfTfS1AhWs7VX7nCYnKkQnk83xMA
         oNAMzyRcmxepPTNoXtKLMEjMn4bbtjpctq2tx6mkno5dsUqJaIR4yeJ/fgblmXajEpcN
         tacGRloX8BxtAhj2OsZVHBvSBZz2sNOSkXv0zGD1+x0XKxUmtsSpBldHhfhKS80uVTei
         qh1h54oDl35fje28I4h9YVAJUECMvmdILkcsy2DfOMXc6xI25Yp34z6b8ko1PA/RRl04
         O+5L0AwUL9zDNncLQWpE8JyYbUlkVR7Zb86GwIuGiLNJFQZGJ6EG77DmQ2yavoVLl3Ll
         XfrA==
X-Gm-Message-State: AOAM532GFj1EzBGOGmJwbLQbA/KgaNOHHN7O+ovt/urQhure9jbgw1JH
        IFqs4TgV7KYK6oDK1olJEZp8qnD4Peqa56g7qCRrTdnPh3mPEA==
X-Google-Smtp-Source: ABdhPJy/V0/KpToMYO+dMPADvlNAhDw2bd5bpQCN7rrvxz4L2wXj/3B4gzWRa/iXU11g2Od6sKGuEPJ+lE/MI28Yjzc=
X-Received: by 2002:a05:6512:200e:: with SMTP id a14mr1851590lfb.573.1605628401788;
 Tue, 17 Nov 2020 07:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net> <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
 <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com> <20201117151740.GB3371@techsingularity.net>
In-Reply-To: <20201117151740.GB3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 17 Nov 2020 16:53:10 +0100
Message-ID: <CAKfTPtD27L0Epg7wPzw7G2zDL8XgdVbB45dZEZEsLmuwRp5gcg@mail.gmail.com>
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

On Tue, 17 Nov 2020 at 16:17, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Nov 17, 2020 at 03:31:19PM +0100, Vincent Guittot wrote:
> > On Tue, 17 Nov 2020 at 15:18, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 17, 2020 at 01:42:22PM +0000, Mel Gorman wrote:
> > > > -                     if (local_sgs.idle_cpus)
> > > > +                     if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> > > >                               return NULL;
> > >
> > > Is that the same 25% ?
> >
> > same question for me
>
> It's the same 25%. It's in the comment as -- utilisation is not too high

utilization is misleading, it usually refers to pelt utilization
whereas whet you check is the number of busy cpus

> where "high" is related to adjust_numa_imbalance.
>
> > could we encapsulate this 25% allowed imbalance like for adjust_numa_imbalance
>
> Using adjust_numa_imbalance() directly in this context would be awkward

Would be good to use the same function to say if we allow or not the imbalance

something like numa_allow_imbalance(sg_lb_stats * group_stats)

which would return how much margin remains available before not
allowing the imbalance

and use the same metrics in all cases


> but the threshold could be shared with something like the additional
> diff below. Is that what you had in mind or something different?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index adfab218a498..49ef3484c56c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5878,6 +5878,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  static struct sched_group *
>  find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
>
> +static inline int numa_imbalance_threshold(int weight);
> +
>  /*
>   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
>   */
> @@ -8894,7 +8896,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                          * If there is a real need of migration, periodic load
>                          * balance will take care of it.
>                          */
> -                       if (local_sgs.idle_cpus >= (sd->span_weight >> 2))

also here you use idle_cpus and on the other part you use nr_running.
Can't we use the same metrics on both sides?

> +                       if (local_sgs.idle_cpus >= numa_imbalance_threshold(sd->span_weight))
>                                 return NULL;
>                 }
>
> @@ -8998,6 +9000,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>  #define NUMA_IMBALANCE_MIN 2
>
> +/* Allows imbalances until active CPUs hits 25% of a domain */
> +#define IMBALANCE_THRESHOLD_SHIFT 2
> +
> +static inline int numa_imbalance_threshold(int weight)
> +{
> +       return weight >> IMBALANCE_THRESHOLD_SHIFT;
> +}
> +
>  static inline long adjust_numa_imbalance(int imbalance,
>                                 int dst_running, int dst_weight)
>  {
> @@ -9006,8 +9016,10 @@ static inline long adjust_numa_imbalance(int imbalance,
>          * when the destination is lightly loaded so that pairs of
>          * communicating tasks may remain local.
>          */
> -       if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
> +       if (dst_running < numa_imbalance_threshold(dst_weight) &&
> +           imbalance <= NUMA_IMBALANCE_MIN) {
>                 return 0;
> +       }
>
>         return imbalance;
>  }
>
> --
> Mel Gorman
> SUSE Labs
