Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59032A90D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKFH7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:59:10 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5577C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:59:08 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 126so630420lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrZOgsFaxrF0PdZIUVvbYywsp2kj8efijLRsc+ifETo=;
        b=R5UC45963zNRedjAXn+ceSEMK3mEkR6CB6/ltqiylnuT1YlmCkwNmXXLqGQSJwm95w
         L7cUqEZ47Kt5KJLqWVx++p7XWApyFHxyrsXnFfB9JSt6TwmlDUtabT1VnmuzaMKJboJu
         N4NRS6ASHBYeeiQnGXiadA/T0ePkVv+4sIqGT2+pr3agONpT0aaOWCwYWLZbE5S5/UDB
         UYBLaaLWVVJiVyXXdW9Odk+QBMDYbhHK7lAlikVFJEgBJ0b75M1Yc0WniCbi6FcFqMV1
         bN/NCDpxml5MQz/L28ZVtuu+4ZEMew3C0cbjyz9hRkFN+940rDQDmvQ2GkwjsV7HgJ7P
         YJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrZOgsFaxrF0PdZIUVvbYywsp2kj8efijLRsc+ifETo=;
        b=JcSvl3n5G2pdCW8SzM7W+Ry75gjZpcs4KfrUIuNC0OcCGPC6ikjM98SBnqvMMUu2Xv
         MFgFkSZv7y7G0jgsTx+Q7M6iw7f/NlPthBW5RxenVCsbRpdB/46e9mfWHLNI7XmpzldY
         VDieLv8cTEPJe2KNuj1x2rM8np2uHpvkWaJXe6e12AAGz3ZCPzy1U6ttXxNJ20puphZ1
         sdGGTgdyAiGpFh2j3Havu7j5tgNYld6Gal2tvG5DrgHf3UgPG/3r+9Lwyo0wTNPr7Oy/
         oSbvZ2kY1afW7HC0OVMy/QrDJiy/rdbdbf0pj9Oxy0qmVJfK6GS+zN16oYlqsmK6TLQm
         HngQ==
X-Gm-Message-State: AOAM533Yc9Dy9as4nlMdyMrQrNNs4IGIS1+schwNMsk7hAcCiZ4cBCkG
        yWAEpEeiXJpLHqwaa4kk71c4ozNxdbeweSh3ZNxBuUFhT/90DA==
X-Google-Smtp-Source: ABdhPJzkgy0qoW+O1uzkPZCwHJQf9wwhbrLanxD7oHgJJOjGbV4X6uHCbpZaXP77oLFyEO2FXVCUp2Fe3ewL2Q40U3g=
X-Received: by 2002:a19:760f:: with SMTP id c15mr56885lff.573.1604649547089;
 Thu, 05 Nov 2020 23:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
In-Reply-To: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Nov 2020 08:58:55 +0100
Message-ID: <CAKfTPtAPdagXddz9tHj_hfg_R1R+E6uYcWX+zdbBLgCd4QQE2w@mail.gmail.com>
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 at 17:05, Aubrey Li <aubrey.li@linux.intel.com> wrote:
>
> From: Aubrey Li <aubrey.li@intel.com>
>
> Added idle cpumask to track idle cpus in sched domain. When a CPU
> enters idle, its corresponding bit in the idle cpumask will be set,
> and when the CPU exits idle, its bit will be cleared.
>
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has low cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
>
> v2->v3:
> - change setting idle cpumask to every idle entry, otherwise schbench
>   has a regression of 99th percentile latency.
> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>   idle cpumask is ratelimited in the idle exiting path.
> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
>
> v1->v2:
> - idle cpumask is updated in the nohz routines, by initializing idle
>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>   behavior.
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jiang Biao <benbjiang@gmail.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  include/linux/sched/topology.h | 13 ++++++++++
>  kernel/sched/fair.c            | 45 +++++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c            |  1 +
>  kernel/sched/sched.h           |  1 +
>  kernel/sched/topology.c        |  3 ++-
>  5 files changed, 61 insertions(+), 2 deletions(-)
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
> index 6b3b59cc51d6..088d1995594f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6023,6 +6023,38 @@ void __update_idle_core(struct rq *rq)
>         rcu_read_unlock();
>  }
>
> +static DEFINE_PER_CPU(bool, cpu_idle_state);
> +/*
> + * Update cpu idle state and record this information
> + * in sd_llc_shared->idle_cpus_span.
> + */
> +void update_idle_cpumask(struct rq *rq, bool idle_state)
> +{
> +       struct sched_domain *sd;
> +       int cpu = cpu_of(rq);
> +
> +       /*
> +        * No need to update idle cpumask if the state
> +        * does not change.
> +        */
> +       if (per_cpu(cpu_idle_state, cpu) == idle_state)
> +               return;
> +
> +       per_cpu(cpu_idle_state, cpu) = idle_state;
> +
> +       rcu_read_lock();
> +
> +       sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +       if (!sd || !sd->shared)
> +               goto unlock;
> +       if (idle_state)
> +               cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> +       else
> +               cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> +unlock:
> +       rcu_read_unlock();
> +}
> +
>  /*
>   * Scan the entire LLC domain for idle cores; this dynamically switches off if
>   * there are no idle cores left in the system; tracked through
> @@ -6136,7 +6168,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         time = cpu_clock(this);
>
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       /*
> +        * sched_domain_shared is set only at shared cache level,
> +        * this works only because select_idle_cpu is called with
> +        * sd_llc.
> +        */
> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
>
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
> @@ -10070,6 +10107,12 @@ static void nohz_balancer_kick(struct rq *rq)
>         if (unlikely(rq->idle_balance))
>                 return;
>
> +       /* The CPU is not in idle, update idle cpumask */
> +       if (unlikely(sched_idle_cpu(cpu))) {
> +               /* Allow SCHED_IDLE cpu as a wakeup target */
> +               update_idle_cpumask(rq, true);
> +       } else
> +               update_idle_cpumask(rq, false);

update_idle_cpumask(rq, sched_idle_cpu(cpu)); ?


>         /*
>          * We may be recently in ticked or tickless idle mode. At the first
>          * busy tick after returning from idle, we will update the busy stats.
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 1ae95b9150d3..ce1f929d7fbb 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -405,6 +405,7 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
>  {
>         update_idle_core(rq);
> +       update_idle_cpumask(rq, true);
>         schedstat_inc(rq->sched_goidle);
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c82857e2e288..2d1655039ed5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1069,6 +1069,7 @@ static inline void update_idle_core(struct rq *rq)
>  #else
>  static inline void update_idle_core(struct rq *rq) { }
>  #endif
> +void update_idle_cpumask(struct rq *rq, bool idle_state);
>
>  DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9079d865a935..f14a6ef4de57 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>                 atomic_inc(&sd->shared->ref);
>                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> +               cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
>         }
>
>         sd->private = sdd;
> @@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
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
