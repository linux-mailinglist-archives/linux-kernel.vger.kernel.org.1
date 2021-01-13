Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F832F5064
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbhAMQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbhAMQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:50:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F579C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:50:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 23so3723881lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYsTKG7IwhtwJszd63uhBtmR2BVMB4WZnSeScVBu3e8=;
        b=AGU6RKekJteIlIsjK6Zea4tFfQYqfnTiYWdWjCT3/4h5w8Kj8D0uSZOrcweWBRuw42
         IhoJgvdsaqtBPe1TN/iemoxdLvz6lEue+7I09HUKsNec6M8kuwNU35G7ws3VYOfh4FvQ
         Oa5BPuoXghqFYuAEaykzujtDWVigUkXJxzbSBdlWlN8LtejCSKBKmftf8BtFnl+BBiCT
         cS/25QcpJLgafIwiK2whI6twywFfes64GqUmcja0vGzsX+u7eJ1LlLuaKbGfoIiXhSVP
         RNkRZDRR/4t+lgRdapHKXO3/FlZKnzFQMq9Z+7UqtCMdIJWImUJ+hU3beFZrwXdCHmZ5
         fxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYsTKG7IwhtwJszd63uhBtmR2BVMB4WZnSeScVBu3e8=;
        b=tSaTPubv7b15TQd9fZstLmtm91xxMj7/428btV18jfxv2VeiwYmmQH46hOO4NwoXx0
         ia+op2zGuM+byW24JPFzdvB9DxhTH+XArT1Q/y6OKoT43XxOF0VgJXABSUQrvAKg+KmK
         gX7/QuMhZtruqlsjuTfsYcRmKOW5hNk6pLMOx1TJhO8JgVlmpFqRE3ONtmQn4HmNO5gO
         9zBnKaQ+tMY/ru6O+rFNDkph0fSwZIBmAXnmzdB3SVMKBwGvQs6KKVtN8Dlkdfntz4f/
         vGnxWugILJPAdSrFRxbW96P5fNdRSJMqIz150nlqBUJC+0IDd5Mmnf4Il9QTlZiM4R68
         lIQg==
X-Gm-Message-State: AOAM5323bN18zrwfKZlbPZFlkd1u+mOAX83xj2Vje3t6HiQZRw6+rI8K
        od3WbwVOec7XLv8QzozJwVr2hhyLtkZf34Tm+gVHPg==
X-Google-Smtp-Source: ABdhPJwrOWhSqdyzngRIDaRDs3BdZ9TZzWZsEBgpLzva1cyfEzFaSGtdyQ+MUViVfai0QMrgQI2UfmGKn7+pbUp/Q6Y=
X-Received: by 2002:a19:2d0a:: with SMTP id k10mr1348928lfj.286.1610556609573;
 Wed, 13 Jan 2021 08:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20210111155047.10657-1-mgorman@techsingularity.net> <20210111155047.10657-4-mgorman@techsingularity.net>
In-Reply-To: <20210111155047.10657-4-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Jan 2021 17:49:58 +0100
Message-ID: <CAKfTPtDjTa24UzNm-_As_OR0dF5V4Tw-7j=doF3kHy3i=q7VCg@mail.gmail.com>
Subject: Re: [PATCH 3/5] sched/fair: Make select_idle_cpu() proportional to cores
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
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Instead of calculating how many (logical) CPUs to scan, compute how
> many cores to scan.
>
> This changes behaviour for anything !SMT2.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/core.c | 19 ++++++++++++++-----
>  kernel/sched/fair.c | 12 ++++++++++--
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 15d2562118d1..7bfa73de6a8d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7444,11 +7444,20 @@ int sched_cpu_activate(unsigned int cpu)
>         balance_push_set(cpu, false);
>
>  #ifdef CONFIG_SCHED_SMT
> -       /*
> -        * When going up, increment the number of cores with SMT present.
> -        */
> -       if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> -               static_branch_inc_cpuslocked(&sched_smt_present);
> +       do {
> +               int weight = cpumask_weight(cpu_smt_mask(cpu));
> +               extern int sched_smt_weight;

coding style problem

> +
> +               if (weight > sched_smt_weight)
> +                       sched_smt_weight = weight;
> +
> +               /*
> +                * When going up, increment the number of cores with SMT present.
> +                */
> +               if (weight == 2)
> +                       static_branch_inc_cpuslocked(&sched_smt_present);
> +
> +       } while (0);
>  #endif
>         set_cpu_active(cpu, true);
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8d8e185cf3b..0811e2fe4f19 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6010,6 +6010,8 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
>
> +int sched_smt_weight __read_mostly = 1;
> +
>  static inline void set_idle_cores(int cpu, int val)
>  {
>         struct sched_domain_shared *sds;
> @@ -6124,6 +6126,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>
>  #else /* CONFIG_SCHED_SMT */
>
> +#define sched_smt_weight       1
> +
>  static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         return -1;
> @@ -6136,6 +6140,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>
>  #endif /* CONFIG_SCHED_SMT */
>
> +#define sis_min_cores          2
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                 avg_cost = this_sd->avg_scan_cost + 1;
>
>                 span_avg = sd->span_weight * avg_idle;
> -               if (span_avg > 4*avg_cost)
> +               if (span_avg > sis_min_cores*avg_cost)
>                         nr = div_u64(span_avg, avg_cost);
>                 else
> -                       nr = 4;
> +                       nr = sis_min_cores;
> +
> +               nr *= sched_smt_weight;

Also,  patch 5 will look at all CPUs of a core in select_idle_core so
nr will decrement by 1 per core so i don't see the need to multiply by
sched_smt_weight one patch 5 is applied

>
>                 time = cpu_clock(this);
>         }
> --
> 2.26.2
>
