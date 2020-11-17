Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B32B6754
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKQOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgKQOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:25:09 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:25:09 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so24476408ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWI3LLwloLUflMf7A3rivV83Ohj1YpOmVJiOHPhQIAo=;
        b=ObP8tcAornYjCLuIysW8XvPs935n7nZMF1iePDnPqCGV27/OlV5TB6kYOC6pR9MslG
         kwoKcM7COsCuMtbn4P4C4Ibxq5cc88DoTIi88ncR/ePgwaMQ/eKZQ5Oskrf3vXEJfgV3
         6/AOFvbWDcfIg/dzyx+qXVeiT8903u8LnJ/k5/DSdf/YDKVXJUvXUe+/SiJh8oAZJMi+
         E30HcCeuxs45aHDVeeAfpylDC9r4QSxWtMyjjIb7VGREfvSRCPCMJtcxm1t5EKladPj6
         6YGcxJsQZtd60pfAMNhFw/gHmvArYoS+5h3YDPGCOQ5PUaDjpB2g8G38lhXwlJrBA9T3
         N9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWI3LLwloLUflMf7A3rivV83Ohj1YpOmVJiOHPhQIAo=;
        b=fIVwdRXMZn1tGf3oKDTly4z6iS/wZt7zvASWuHQjS1JIVTim624MKuATqqeTWSFJY6
         4LuXEKnF5Q7SCPTyNWSn1OiiDXNSCUW37GKrhm8N93C3hqQEG7skVvUB1VuHwGEPkFjo
         DIqZKWrmAHbR5GSzR5TgFzgyY2rFMd6SAGfDjvYVghXZBbEBhU2yXC+cR2cHJaKIo6Q+
         8SBtThOrBsZrt/cqGk7gmFqW/dVufpyqs6hfeKSDNJc6dz4Tv9bKLpQhbspqpxeb690i
         O/c2I68KluyHWww5hImgj69iqReGVPd7Eooh5IWzOv3miqZhZCqJFclcwZOokG2v9SLH
         Jung==
X-Gm-Message-State: AOAM530mXInoCh2haPV77kcCe+4a5gTby7P5c2dsGqzzonNbCitYsCaF
        iPopsq/dr9LXgm4+X+VoX5kqmNtghokGqaHBOB6boA==
X-Google-Smtp-Source: ABdhPJw4//KAMoyS7tV+iwzF5w/c0dJvEzNjm/uLm87l42C9vpoAmLenDSzrSaKp4vz+1haIdlViehOpvfbGZAlKASY=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr2088392ljp.226.1605623107534;
 Tue, 17 Nov 2020 06:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20201117134222.31482-1-mgorman@techsingularity.net> <20201117134222.31482-3-mgorman@techsingularity.net>
In-Reply-To: <20201117134222.31482-3-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 17 Nov 2020 15:24:56 +0100
Message-ID: <CAKfTPtBj1nJhQrsAoH0mBrc9Md+_icNJuWx7P=yQbqM2fYCAwg@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/numa: Allow a floating imbalance between NUMA nodes
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 at 14:42, Mel Gorman <mgorman@techsingularity.net> wrote:
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

This reminds me previous discussions on the same topic: how much
imbalance is allowed that will not screw up the bandwidth of the node
I'm worried that there is no topology insight in the decision like
hyperthreading, or number of cpus in the LLC

>
> Note that this is not expected to be a universal win. Any benchmark
> that prefers spreading as wide as possible with limited communication
> will favour the old behaviour as there is more memory bandwidth.
> Workloads that communicate heavily in pairs such as netperf or tbench
> benefit. For the tests I ran, the vast majority of workloads saw
> a benefit so it seems to be a worthwhile tradeoff.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5fbed29e4001..33709dfac24d 100644
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
> @@ -8993,16 +8995,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
> +        * when the destination is lightly loaded so that pairs of
> +        * communicating tasks may remain local.
>          */
> -       imbalance_min = NUMA_IMBALANCE_MIN;
> -       if (dst_running <= imbalance_min)
> +       if (dst_running < (dst_weight >> 2) && imbalance <= NUMA_IMBALANCE_MIN)
>                 return 0;
>
>         return imbalance;
> @@ -9105,9 +9106,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
