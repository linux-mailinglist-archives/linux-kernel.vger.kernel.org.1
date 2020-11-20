Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46522BAB29
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgKTNdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgKTNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:33:13 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65317C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:33:13 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so13426522lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2T+MwhTnfOUJGpHzabKS99TwgxNb8yVa9ij6X6D/tX4=;
        b=EFuPOAjB+ZwugfsfvJp9vryEQbO5kl4j/d2eqJtVamwCgCwJalUKGJ34G+I4bEvuGj
         k1slKAw73KT3mxID4QMKVEzJpwPYKYpmjH2EnYjhRJSqzPrmt+hGKK9KlJZ7A9FxSbYO
         b5UK7B7IjmXqRUtpmUq8q1EMi/LBVF9tXtZAUulqS4GGfOFw+ucEAis3NirEWUtE4Okm
         ZJ/bya2iXlYrDuVLkz53R3Pl3Q00Hi/qgfGf5Sj78XKoZd++SaRDcnzmtpjoi5pjIIHf
         BLEGOd2qL9EIYnznML2+DxxtEbH2mNeKucinVRMYx2fLY4oE7BEq9UGh8IpdfxdReNN2
         a6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2T+MwhTnfOUJGpHzabKS99TwgxNb8yVa9ij6X6D/tX4=;
        b=ewfE7N/LrZPmV/gFGRCJU5UYA4QXaOHb5d2emFs5uYHFrqpb/K5IOVbfsVNKsM5wZL
         GUMiPJKqVLHOvkj90khh//7Sfh0UMuJ1CSOzuczpxoRSNrz0sQGOJ28qno9Vk7ClLnOh
         G76hp8N4VMUDk1c82TyWm6MsvTawMIoGtWpVHVOeyhokg0aVX2chEuTAdsp6N4rZhOPv
         DygVCly6bnvjxrd+jTBlB/hhjEP0OaXRIEteYzM3huHAAGhoxh6MBmO9zGipd5Y84DoN
         50XkSXfwCUd07cgT1thGlF6YwPFv82fTVG60EabgFVrBKYd2Mz0Q48aCGKLsMX/X2tx+
         WWcw==
X-Gm-Message-State: AOAM530318xxfSPg1cbKRY0Pn4YYPArlUSyD9aWQEckSj8ny6yK0PNDE
        R7KWHDUA4EXMT8RcNqzh8wgxetOgO2VXFEHkEUMjZu8pe/x6Iw==
X-Google-Smtp-Source: ABdhPJxTY95CBFz08Fur9iIn16xSB3EkMAo+RWAuefoTdkwezuX2bYbBKTYSq00dC7Gd9RIQB1RGbhzL0PtdyqDrPMA=
X-Received: by 2002:ac2:5f4b:: with SMTP id 11mr7517261lfz.385.1605879191854;
 Fri, 20 Nov 2020 05:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201120090630.3286-1-mgorman@techsingularity.net> <20201120090630.3286-4-mgorman@techsingularity.net>
In-Reply-To: <20201120090630.3286-4-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Nov 2020 14:33:00 +0100
Message-ID: <CAKfTPtC_RF=yJHfuGHgLjCJvGnUNhtEeOuzLywP=6HEWHMQd7g@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/numa: Allow a floating imbalance between NUMA nodes
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
> Currently, an imbalance is only allowed when a destination node
> is almost completely idle. This solved one basic class of problems
> and was the cautious approach.
>
> This patch revisits the possibility that NUMA nodes can be imbalanced
> until 25% of the CPUs are occupied. The reasoning behind 25% is somewhat
> superficial -- it's half the cores when HT is enabled.  At higher
> utilisations, balancing should continue as normal and keep things even
> until scheduler domains are fully busy or over utilised.
>
> Note that this is not expected to be a universal win. Any benchmark
> that prefers spreading as wide as possible with limited communication
> will favour the old behaviour as there is more memory bandwidth.
> Workloads that communicate heavily in pairs such as netperf or tbench
> benefit. For the tests I ran, the vast majority of workloads saw
> a benefit so it seems to be a worthwhile trade-off.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9aded12aaa90..e17e6c5da1d5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1550,7 +1550,8 @@ struct task_numa_env {
>  static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
>  static unsigned long cpu_util(int cpu);
> -static inline long adjust_numa_imbalance(int imbalance, int dst_running);
> +static inline long adjust_numa_imbalance(int imbalance,
> +                                       int dst_running, int dst_weight);
>
>  static inline enum
>  numa_type numa_classify(unsigned int imbalance_pct,
> @@ -1930,7 +1931,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>                 src_running = env->src_stats.nr_running - 1;
>                 dst_running = env->dst_stats.nr_running + 1;
>                 imbalance = max(0, dst_running - src_running);
> -               imbalance = adjust_numa_imbalance(imbalance, dst_running);
> +               imbalance = adjust_numa_imbalance(imbalance, dst_running,
> +                                                       env->dst_stats.weight);
>
>                 /* Use idle CPU if there is no imbalance */
>                 if (!imbalance) {
> @@ -8995,16 +8997,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>
>  #define NUMA_IMBALANCE_MIN 2
>
> -static inline long adjust_numa_imbalance(int imbalance, int dst_running)
> +static inline long adjust_numa_imbalance(int imbalance,
> +                               int dst_running, int dst_weight)
>  {
> -       unsigned int imbalance_min;
> -
>         /*
>          * Allow a small imbalance based on a simple pair of communicating
> -        * tasks that remain local when the source domain is almost idle.
> +        * tasks that remain local when the destination is lightly loaded.
>          */
> -       imbalance_min = NUMA_IMBALANCE_MIN;
> -       if (dst_running <= imbalance_min)
> +       if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
>                 return 0;
>
>         return imbalance;
> @@ -9107,9 +9107,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                 }
>
>                 /* Consider allowing a small imbalance between NUMA groups */
> -               if (env->sd->flags & SD_NUMA)
> +               if (env->sd->flags & SD_NUMA) {
>                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> -                                               busiest->sum_nr_running);
> +                               busiest->sum_nr_running, busiest->group_weight);
> +               }
>
>                 return;
>         }
> --
> 2.26.2
>
