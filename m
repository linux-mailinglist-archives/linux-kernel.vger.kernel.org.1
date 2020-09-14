Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352BC268B10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgINMfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgINMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:32:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D012EC061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:32:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z17so13188817lfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3gSDysHiREa/zKp4vDGVu0wToI1phBpcNNvcqLKxNg=;
        b=YRzhSt1ahdIfuZJquWIDCfw2Ch4InYCY/b0ruJ2V63y58+v1IhnDb1XFp4CBQ/OSiV
         BjvYfBEJ7cCkNSZaXIQBjbpM9/K1K4OXo5WqiwuPSIf2xp8mr0NLELQxDBweWvCiagOE
         a/oM6gPE0lhZGoGjxZGj6oZMzrBLY3P//Yuocz7INwdThcTk+FEkvzQkuuoNYCZhysN5
         iUcGQJWEa5KnAPZi8FcIWoAqDRhsb0G42uMlH6G7rYHn1KaJjV6xcqTYXHfxNiJ/AsST
         /HndzHm4npOeUZJAgN19t/2OghTJM0qVtsVqMCsgTomubwz/NRDs+zrrs9D22hIg/W9u
         fc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3gSDysHiREa/zKp4vDGVu0wToI1phBpcNNvcqLKxNg=;
        b=uVjB1tp2TeDj0QZIRtEDHOeIT4BG27baMS4vFjiGt8/Y11e7sIwiiU5ZDOKKkyakgk
         K74h44UFSyZ5qOWpH7w9DkqQtlYXvSC7cuVmvGoZNd0yX8pemxLP9IerHysx/fnMUudj
         3l2yWxxBJLbSqhphmzMksXTZh53OV6tbihT7gQHLtMVMS4fQ2LBqiOFog7hqF9ag8IsS
         9y3X2CgK877RxhappD+qF27WrrYoLu4+o7Vwtfav67A/JNRiXQa+VKoflBmbbq9K6jtj
         5wkvYzH0QwRU6A6o5Zed+2umouhGrwSJWXhUeCW3X4udYylZMfXJD6EadS2DeA7+r1bO
         vkLQ==
X-Gm-Message-State: AOAM5328zdy4YMdZJWULmPPkfVq68IFKeyhnNIgHXS+B6vOd0Zb3x25Z
        mMgu5YrrpGUDWk18M/2vEy7FPclEbIn/UWduFf9A1A==
X-Google-Smtp-Source: ABdhPJygDMV4jp++CyYAerP/XW81V8B9tvoy8LcLSv3qcPxp3WOf4JCvBN2f1Bukt+tJRXy7syjmW99c3WUY7ZvecS0=
X-Received: by 2002:a19:7006:: with SMTP id h6mr4423774lfc.83.1600086759449;
 Mon, 14 Sep 2020 05:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com>
In-Reply-To: <20200910054203.525420-2-aubrey.li@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Sep 2020 14:32:28 +0200
Message-ID: <CAKfTPtAiyHVRLJCzy4aajCAOcdq-7ghCEM7mAhNq5Gfh7WCNug@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 at 15:28, Aubrey Li <aubrey.li@intel.com> wrote:
>
> Added idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, its corresponding bit in the idle cpumask will be set,
> and when the CPU exits idle, its bit will be cleared.
>
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  include/linux/sched/topology.h | 13 +++++++++++++
>  kernel/sched/fair.c            |  4 +++-
>  kernel/sched/topology.c        |  2 +-
>  3 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index fb11091129b3..43a641d26154 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>         atomic_t        ref;
>         atomic_t        nr_busy_cpus;
>         int             has_idle_cores;
> +       /*
> +        * Span of all idle CPUs in this domain.
> +        *
> +        * NOTE: this field is variable length. (Allocated dynamically
> +        * by attaching extra space to the end of the structure,
> +        * depending on how many CPUs the kernel has booted up with)
> +        */
> +       unsigned long   idle_cpus_span[];
>  };
>
> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> +{
> +       return to_cpumask(sds->idle_cpus_span);
> +}
> +
>  struct sched_domain {
>         /* These fields must be setup */
>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6b3b59cc51d6..3b6f8a3589be 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6136,7 +6136,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         time = cpu_clock(this);
>
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);

sched_domain_shared is set only at shared cache level so this works
only because select_idle_cpu is called with sd_llc. It's worth adding
a comment to describe this.

>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
> @@ -10182,6 +10182,7 @@ static void set_cpu_sd_state_busy(int cpu)
>         sd->nohz_idle = 0;
>
>         atomic_inc(&sd->shared->nr_busy_cpus);
> +       cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
>  unlock:
>         rcu_read_unlock();
>  }
> @@ -10212,6 +10213,7 @@ static void set_cpu_sd_state_idle(int cpu)
>         sd->nohz_idle = 1;
>
>         atomic_dec(&sd->shared->nr_busy_cpus);
> +       cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
>  unlock:
>         rcu_read_unlock();
>  }
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9079d865a935..92d0aeef86bf 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1769,7 +1769,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>
>                         *per_cpu_ptr(sdd->sd, j) = sd;
>
> -                       sds = kzalloc_node(sizeof(struct sched_domain_shared),
> +                       sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
>                                         GFP_KERNEL, cpu_to_node(j));
>                         if (!sds)
>                                 return -ENOMEM;
> --
> 2.25.1
>
