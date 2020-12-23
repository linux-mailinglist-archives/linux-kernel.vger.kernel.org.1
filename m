Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55302E1C93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLWNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgLWNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:32:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FEAC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:31:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a12so40113906lfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqsbTtF4+K+oV6CvbZHpfKwy5Is4+AT1prQlhZ1cwIA=;
        b=CtlXesScrITWYI20rT7yyu24Hwjx5vjpw4fCbm7vbP5sl9syTAe9fKYfOv9/Mnwzuf
         Qblaz/ffcqbaxOXfpT+sU+svIvJuhXbps7E8f0oKNNE3PKnTZ8ghB5N4KOiYpl0Qwl29
         4Ky0z4TD4zuhooai6mmlAmcyaNZP6Atuu8LlX+09/7D7xPUS00sdcz8bnk/i2gpav5Vr
         0+IKf/A0Gm90yyvpqfYtFGudWY6q32DfV65Gaf3aM0jGj6MBZQVC7EiCJkRIjWXVqFUd
         g0Ilg9db50+XrPeDdwcDmXNvAeGmU/t3QyxNNFDe6rsvm2+31+a0rEfDZfd9xpRV+niy
         vIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqsbTtF4+K+oV6CvbZHpfKwy5Is4+AT1prQlhZ1cwIA=;
        b=MSr2JpuERI93qxLBdGDJoaWS9FEsKBn9pSe+E5IlaxPBTzCV1gHEwenPBluRYocah6
         kKf/BL7zo0kLBvNu1LsOvizauESQZx/lMhMBcpzcFmZ+AgFtMvgY4CrGwla3gmcDIDSO
         GJzYpIcaVcQjNbuZWg21V0EIS3rtV7H8YzKS9IaJuiQfP7fIq7sn6o7mfX40UrC8l+1k
         MALB/Voi206/s97U0Hy95cfqpPZMZGTHt3wbRIqoWviICz+yq7WKaAbdlYAq31US6wkv
         WFaVvt7pOrgBkBcGqqo5rOdO1jasKhxskx1+fIM1l+jjZFtH4GUN7SXRJKaSdN+VVHnV
         uXuw==
X-Gm-Message-State: AOAM53066aHbrKwu+rYBjuxV1am8j8WxVq9cjtOAe7IeMuOu2tIxtYKM
        6QaKv+QQSExnfxPQMT/6O5xXSvzD6PDu4HzMaMmBxw==
X-Google-Smtp-Source: ABdhPJwEShTULylrd20HfX7P3sl3Tn3vgs23HRkBMiRh0MEhHn/SLvPnpXYfA2ehm69NES/OOVI8zr6LrNRVPgt1ANo=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr12162991ljm.445.1608730279425;
 Wed, 23 Dec 2020 05:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <20201214170017.938791025@infradead.org>
In-Reply-To: <20201214170017.938791025@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Dec 2020 14:31:08 +0100
Message-ID: <CAKfTPtCkhpOuQ8Jaf6Mueqo65jH+d5UgauKN-w1-AQ_t-_LJcg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/5] sched/fair: Make select_idle_cpu() proportional
 to cores
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 at 18:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Instead of calculating how many (logical) CPUs to scan, compute how
> many cores to scan.
>
> This changes behaviour for anything !SMT2.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |   19 ++++++++++++++-----
>  kernel/sched/fair.c |   12 ++++++++++--
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7454,11 +7454,20 @@ int sched_cpu_activate(unsigned int cpu)
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
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6010,6 +6010,8 @@ static inline int find_idlest_cpu(struct
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
>
> +int sched_smt_weight = 1;
> +
>  static inline void set_idle_cores(int cpu, int val)
>  {
>         struct sched_domain_shared *sds;
> @@ -6124,6 +6126,8 @@ static int select_idle_smt(struct task_s
>
>  #else /* CONFIG_SCHED_SMT */
>
> +#define sched_smt_weight       1
> +
>  static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         return -1;
> @@ -6136,6 +6140,8 @@ static inline int select_idle_smt(struct
>
>  #endif /* CONFIG_SCHED_SMT */
>
> +#define sis_min_cores          2
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6166,10 +6172,12 @@ static int select_idle_cpu(struct task_s
>                 avg_cost = this_sd->avg_scan_cost + 1;
>
>                 span_avg = sd->span_weight * avg_idle;
> -               if (span_avg > 4*avg_cost)
> +               if (span_avg > sis_min_cores * avg_cost)
>                         nr = div_u64(span_avg, avg_cost);
>                 else
> -                       nr = 4;
> +                       nr = sis_min_cores;
> +
> +               nr *= sched_smt_weight;

My comment apply of the final result of the patchset where
select_idle_cpu/cpore are merged
IIUC, sched_smt_weight is the max number of CPUs per core but we
already loop all CPUs of a core in one loop so we don't need to loop
more than the number of core.

>
>                 time = cpu_clock(this);
>         }
>
>
