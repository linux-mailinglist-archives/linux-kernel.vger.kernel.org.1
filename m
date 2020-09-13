Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B5267D88
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 06:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgIMD75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 23:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgIMD7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 23:59:52 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9CC061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 20:59:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c13so13930130oiy.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 20:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Axj7dqz+5SFuOgGcn5J7uk7r49/6rAWVqjS9AY/4xjo=;
        b=PUsN0kvyna8jAT51+xAbJn+ImY6unubCDQJ13WW3fvrZzoWH8FTPOB4Q72d46Rv5+h
         fZSkchlIEGLg/yn43axTQ23k344+xpXvubbUCVLfxjysdnHaUrbMgMU6Pbn1LQdppOlo
         3DTqfyD2la17+RyZDLErU8xi3fQH9Sgl5H2M4kYQaDr6yzodkbb48wAX8UP6Vjnzkyu6
         rbXjaV/Gm5/P4RxbFEiOYkWqSiVF4RMFCUvNomgdqVk8kjcsov33AMWTOCwYuBYmcBao
         emK0I7e8Ex+laiuvCOKU0sqTgRuPibFMc6IiVYuCyuOSvnmJpOU+Co8DLkdvAR40JSp1
         UFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Axj7dqz+5SFuOgGcn5J7uk7r49/6rAWVqjS9AY/4xjo=;
        b=jpbJj+pEzFtf5njZ0iwllrVl0KSqM3tHOo2ZSz2ge09Gn03+ODi/YwFhVi30gf4CgD
         IIqvIRajMUxvdZJbuBJjpykTR3i5qQPbjRpLW+OGyxZSSwU2ExY3pi6gwafi7lCbirk9
         W4xuI2gRVQzQ+fdk36Ubi2CqzgLO5ZqogS/X6rmCnMQm+cLfD/SsWvYe4auJ9Q/gsbDR
         r+VoNYRD2WbDY4LjZLba05tw+sLvyrGOVbDNSmZdWD59MueG6qAjbcDi8LqHptthOFw6
         TJVg2d/fiS4akvjSKsw93N46aEI1L/VnjHZRXwKYLegTSWD2P97uqUi9et1WiB2vJvlH
         JYhg==
X-Gm-Message-State: AOAM5335aqULxJoEJ94x2oV2N/w3L9oPLVt0jErfm9O1I+LSaVmwHsSL
        oaLBdhHbL8YAtEO5lt7uKLy8T9gCcWNlbV2BbRQ6Z1K2dNs=
X-Google-Smtp-Source: ABdhPJwOlCK8A+ESmonarr54/S5G+8vXhxDLWx2CeMiOMYvJLN4Gam/Qqgp6IrYCAsEHsm/FVo5+Jtr4JVQJANhr2vU=
X-Received: by 2002:aca:aa84:: with SMTP id t126mr5462951oie.5.1599969591226;
 Sat, 12 Sep 2020 20:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com>
In-Reply-To: <20200910054203.525420-2-aubrey.li@intel.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Sun, 13 Sep 2020 11:59:40 +0800
Message-ID: <CAPJCdBm+eyvY3ZUU0sz8WxRhdKquCApTCb1rv8DBDCnG8kS0PA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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

Hi, Aubrey

On Fri, 11 Sep 2020 at 23:48, Aubrey Li <aubrey.li@intel.com> wrote:
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
Is the sds_idle_cpus() always empty if nohz=off?
Do we need to initialize the idle_cpus_span with sched_domain_span(sd)?

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
This only works when entering/exiting tickless mode? :)
Why not update idle_cpus_span during tick_nohz_idle_enter()/exit()?

Thx.
Regards,
Jiang

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
