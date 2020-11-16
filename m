Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48452B43CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgKPMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgKPMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:34:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4165AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:34:20 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so6283385ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxucZvpG9btUckYFGWL/AsQ0L5cdfwReymsOazaJMmA=;
        b=quX94av7jd60S82nNXOpJIFRPTQtkJ1wV/BJ7qNtHQPhV5mLoge3w8mgXxFeW2nQoL
         2b79k91o7zFtzQGri1XjoA7EyPp/8Ryn9ReJZl9ZFpTyg16bkutWxHxgdsXWq/wk78dw
         HtCEc+LKzX3JXu2iXTS05XakPqg1i5ewnpXJim2QwdpXTHcLNT2ia7kaa+jgEppomP+N
         RgOfBhbJu36/tSgRyWqjOZ9kEbnlqkvWEPQxyRqBv/nZ+JEG+V5wgckhfxKQqKKHki/2
         tBn6t6fzmQl4kq1yJJkFgumMvLECVOJ6Ua8DALObcR6BuRPW/7D2sA+bn6YW9Vt0iZfO
         +ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxucZvpG9btUckYFGWL/AsQ0L5cdfwReymsOazaJMmA=;
        b=ArvvXhuw+SPW/9OF5TSnrCVBuI+sHiy6B45MdFs4MaopOfVRyd3UtCLr1gOXcAATZJ
         EylVTiMAqIkpYene7cJEsW0qWteg4O7FP+WxpveHo6EWxiUwfGg59W99MY/hP/0zdhlP
         o3/LQClBEbv8iapDRVqx3ymreaNBzLbcVlME4ccTF5zyFbe4VA2/353aqmEP99BNvxd6
         USl3e3hOBuuv+H9LwBEWi22f1eyIgl4YmHZ7KM7o6o09ncAjiPkrfIhklkcRc6q8NqEr
         GKDlsR8D1ZljjN/KAGnjOl3jGx4PcHKBJieCmLwc8DixOr0qHWFDGH5mj6tmv0bzTC0+
         7C1g==
X-Gm-Message-State: AOAM5316DbmEv4+UgVtKArZ4j/+ZLvLcW+NPOVCwli9w3YW8z7lGLlzZ
        G2iKq4yM0uEVu81LhqNGXUYOASXlEnXbtH7D02e6iw==
X-Google-Smtp-Source: ABdhPJy5xVjbd3IjFeY44S2F4ugt0vXgV/GsgWlZ/WDYiRcL6VGZaAM068fwmdwkM9Ls6aVV7q56TqetVZ+NO7oZ14Q=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr5530300lji.111.1605530058439;
 Mon, 16 Nov 2020 04:34:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605521731.git.mchehab+huawei@kernel.org> <7cf5d2691e70ab82c332a335d21f6f04c0f742ab.1605521731.git.mchehab+huawei@kernel.org>
In-Reply-To: <7cf5d2691e70ab82c332a335d21f6f04c0f742ab.1605521731.git.mchehab+huawei@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Nov 2020 13:34:07 +0100
Message-ID: <CAKfTPtCBK6M4mgbEP1rt+qqZ_FKzDg9yd9bMg+MdtUmEYWX6+g@mail.gmail.com>
Subject: Re: [PATCH v4 24/27] shed: fix kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 11:18, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>

s/shed/sched

> Kernel-doc requires that a kernel-doc markup to be immediatly

s/immediatly/immediately

> below the function prototype, as otherwise it will rename it.
> So, move sys_sched_yield() markup to the right place.
>
> Also fix the cpu_util() markup: Kernel-doc markups
> should use this format:
>         identifier - description
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 16 ++++++++--------
>  kernel/sched/fair.c |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02076e6d3792..9d41378ae8f3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6560,65 +6560,65 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
>         if (len & (sizeof(unsigned long)-1))
>                 return -EINVAL;
>
>         if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>                 return -ENOMEM;
>
>         ret = sched_getaffinity(pid, mask);
>         if (ret == 0) {
>                 unsigned int retlen = min(len, cpumask_size());
>
>                 if (copy_to_user(user_mask_ptr, mask, retlen))
>                         ret = -EFAULT;
>                 else
>                         ret = retlen;
>         }
>         free_cpumask_var(mask);
>
>         return ret;
>  }
>
> -/**
> - * sys_sched_yield - yield the current processor to other threads.
> - *
> - * This function yields the current CPU to other tasks. If there are no
> - * other threads running on this CPU then this function will return.
> - *
> - * Return: 0.
> - */
>  static void do_sched_yield(void)
>  {
>         struct rq_flags rf;
>         struct rq *rq;
>
>         rq = this_rq_lock_irq(&rf);
>
>         schedstat_inc(rq->yld_count);
>         current->sched_class->yield_task(rq);
>
>         preempt_disable();
>         rq_unlock_irq(rq, &rf);
>         sched_preempt_enable_no_resched();
>
>         schedule();
>  }
>
> +/**
> + * sys_sched_yield - yield the current processor to other threads.
> + *
> + * This function yields the current CPU to other tasks. If there are no
> + * other threads running on this CPU then this function will return.
> + *
> + * Return: 0.
> + */
>  SYSCALL_DEFINE0(sched_yield)
>  {
>         do_sched_yield();
>         return 0;
>  }
>
>  #ifndef CONFIG_PREEMPTION
>  int __sched _cond_resched(void)
>  {
>         if (should_resched(0)) {
>                 preempt_schedule_common();
>                 return 1;
>         }
>         rcu_all_qs();
>         return 0;
>  }
>  EXPORT_SYMBOL(_cond_resched);
>  #endif
>
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 27536f37ba1a..cb7cd7d8a28f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6310,41 +6310,41 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         sd = rcu_dereference(per_cpu(sd_llc, target));
>         if (!sd)
>                 return target;
>
>         i = select_idle_core(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
>         i = select_idle_cpu(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
>         i = select_idle_smt(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
>         return target;
>  }
>
>  /**
> - * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
> + * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
>   * @cpu: the CPU to get the utilization of
>   *
>   * The unit of the return value must be the one of capacity so we can compare
>   * the utilization with the capacity of the CPU that is available for CFS task
>   * (ie cpu_capacity).
>   *
>   * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
>   * recent utilization of currently non-runnable tasks on a CPU. It represents
>   * the amount of utilization of a CPU in the range [0..capacity_orig] where
>   * capacity_orig is the cpu_capacity available at the highest frequency
>   * (arch_scale_freq_capacity()).
>   * The utilization of a CPU converges towards a sum equal to or less than the
>   * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
>   * the running time on this CPU scaled by capacity_curr.
>   *
>   * The estimated utilization of a CPU is defined to be the maximum between its
>   * cfs_rq.avg.util_avg and the sum of the estimated utilization of the tasks
>   * currently RUNNABLE on that CPU.
>   * This allows to properly represent the expected utilization of a CPU which
>   * has just got a big task running since a long sleep period. At the same time
> --
> 2.28.0
>
