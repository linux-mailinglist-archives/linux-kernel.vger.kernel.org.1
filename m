Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A492BAB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgKTNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgKTNdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:33:38 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D18C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:33:38 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so13526736lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Osa5ndM8kW8cDb0/reM96pzOasGpIdGyuWI4Ns660ys=;
        b=qrzhJQOp93F0VIOrgET//qKahpsrCBG1Z1/woh0/H+nWqwejXQU+WhBf6E/QqikGYd
         dETHrLwwYwl1qtKaOahUz08+21ZPOIwG/BB8RRpMRtrHyD5JXS8P0/N9lomWr2bxGKZa
         mQnarqnPAJ1jpBsS59GEUWzN+cHlmtnNUm69/eJbfO9aw42If6YnQKj7Rt0XRCrNhB6x
         Nhkhx9mV0ujrzRF28h1ThbMnIuSe4uA0CAhnPvI9G3lyteFwutyUOqq2CG0JI3ylh0bM
         HbCkk7dokVjJih9ppazuzDrTtqx/c4BFGKhtGoSlfUco2tvc0wD4kJCyCmS4TbO3omqG
         QsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Osa5ndM8kW8cDb0/reM96pzOasGpIdGyuWI4Ns660ys=;
        b=TZcy932bHUflmIY1vBl+WkjlS+Z0/finZUzNcYGmI9nXsX423kVL2q+cUQhJ5h7Bbk
         3AvVMmxBO0XSEq697wdA9yMOKwYyGUZPWnpnc8oIMUNIr9YlnBSaTDtJCyL5R+EezAZP
         pRJHdfXYgfnS8vhLttI3Rdmsssr785EYLrxOCQK15rCf0ZoVBwtXYHwN70E2kDcqXpgM
         zj5YNqp9mETXSNm5PgGH+EkXBpQo52qoLrjTUlb1XApo8lXiFsMSdroLxJrJochpktX3
         Q954lq8W53J6byaX5H1m4brTtcs9i5yRqIy5BmvRx/CdI6dFHgP7LpWHAo9Dz1s9ujd1
         c+sQ==
X-Gm-Message-State: AOAM5332yYjUJaQgHSlsC+UASs3UC4LXPrxOfrWq4o+5NDRFWLNCMVNL
        j6TpZnp+4S9MU7bTIxxkVjk9EU50/WJP4cvoPrkf5A==
X-Google-Smtp-Source: ABdhPJxLWffNThUKDTFPIiIEdzxM7lD3j8Q8HzYMTrLNe/m6vCS/SyK9YhwEgwQHQ11yqB6QHfYpz5W7iCf8QScrxdU=
X-Received: by 2002:a19:a0c:: with SMTP id 12mr8618810lfk.568.1605879216481;
 Fri, 20 Nov 2020 05:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20201120090630.3286-1-mgorman@techsingularity.net> <20201120090630.3286-5-mgorman@techsingularity.net>
In-Reply-To: <20201120090630.3286-5-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Nov 2020 14:33:25 +0100
Message-ID: <CAKfTPtDGDEHpOFC29+o-K434CB4jBT6JON07DR5Hhar7wPyybw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched: Limit the amount of NUMA imbalance that can
 exist at fork time
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 10:06, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> At fork time currently, a local node can be allowed to fill completely
> and allow the periodic load balancer to fix the problem. This can be
> problematic in cases where a task creates lots of threads that idle until
> woken as part of a worker poll causing a memory bandwidth problem.
>
> However, a "real" workload suffers badly from this behaviour. The workload
> in question is mostly NUMA aware but spawns large numbers of threads
> that act as a worker pool that can be called from anywhere. These need
> to spread early to get reasonable behaviour.
>
> This patch limits how much a local node can fill before spilling over
> to another node and it will not be a universal win. Specifically,
> very short-lived workloads that fit within a NUMA node would prefer
> the memory bandwidth.
>
> As I cannot describe the "real" workload, the best proxy measure I found
> for illustration was a page fault microbenchmark. It's not representative
> of the workload but demonstrates the hazard of the current behaviour.
>
> pft timings
>                                  5.10.0-rc2             5.10.0-rc2
>                           imbalancefloat-v2          forkspread-v2
> Amean     elapsed-1        46.37 (   0.00%)       46.05 *   0.69%*
> Amean     elapsed-4        12.43 (   0.00%)       12.49 *  -0.47%*
> Amean     elapsed-7         7.61 (   0.00%)        7.55 *   0.81%*
> Amean     elapsed-12        4.79 (   0.00%)        4.80 (  -0.17%)
> Amean     elapsed-21        3.13 (   0.00%)        2.89 *   7.74%*
> Amean     elapsed-30        3.65 (   0.00%)        2.27 *  37.62%*
> Amean     elapsed-48        3.08 (   0.00%)        2.13 *  30.69%*
> Amean     elapsed-79        2.00 (   0.00%)        1.90 *   4.95%*
> Amean     elapsed-80        2.00 (   0.00%)        1.90 *   4.70%*
>
> This is showing the time to fault regions belonging to threads. The target
> machine has 80 logical CPUs and two nodes. Note the ~30% gain when the
> machine is approximately the point where one node becomes fully utilised.
> The slower results are borderline noise.
>
> Kernel building shows similar benefits around the same balance point.
> Generally performance was either neutral or better in the tests conducted.
> The main consideration with this patch is the point where fork stops
> spreading a task so some workloads may benefit from different balance
> points but it would be a risky tuning parameter.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e17e6c5da1d5..6d1c24708664 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8761,6 +8761,16 @@ static bool update_pick_idlest(struct sched_group *idlest,
>         return true;
>  }
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
>  /*
>   * find_idlest_group() finds and returns the least busy CPU group within the
>   * domain.
> @@ -8893,7 +8903,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                          * a real need of migration, periodic load balance will
>                          * take care of it.
>                          */
> -                       if (local_sgs.idle_cpus)
> +                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
>                                 return NULL;
>                 }
>
> @@ -9000,11 +9010,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  static inline long adjust_numa_imbalance(int imbalance,
>                                 int dst_running, int dst_weight)
>  {
> +       if (!allow_numa_imbalance(dst_running, dst_weight))
> +               return imbalance;
> +
>         /*
>          * Allow a small imbalance based on a simple pair of communicating
>          * tasks that remain local when the destination is lightly loaded.
>          */
> -       if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
> +       if (imbalance <= NUMA_IMBALANCE_MIN)
>                 return 0;
>
>         return imbalance;
> --
> 2.26.2
>
