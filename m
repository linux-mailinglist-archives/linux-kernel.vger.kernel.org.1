Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1843E2DE31F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgLRNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLRNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:13:43 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54736C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:13:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o17so5331568lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVSskhXaTH9jorKIwhUTBla/HmI/wv9IQeWGzoEsFnM=;
        b=yn+RxTNVJdU1uNUk9KTEH94GV6CraoCNG3bJJck0gryWTMLAgpjmSk7dlD3C0XdMYB
         R7T2EoeB2UXLHdoBRbl9CG+GhPcXUw83JXEMNh02mimndZBGvSCFUSxo8HvUqiGMeoAR
         Ue5hNxDTvlvAW/JqhHVI3OywybPE+yqw8fIKFkCwyUNrtVNJszPqMX305ebZbRXPpd0l
         Jr/YZNcfgDhE1RgemDUAktS3gnI5DGzCa/rj0tI5hqGvJjPCOZ7EGjKoPsP8euiaRhO2
         pt+ZBl4yPu0IL9DsA0UBcU5/3MzjCz7RqclAEdUF0VQPJfwcwcjhIfqqvy4z/dygCXbx
         l7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVSskhXaTH9jorKIwhUTBla/HmI/wv9IQeWGzoEsFnM=;
        b=pSnJrZ3BaHfkL7+eyMiM9kfTAR2+CNh4GkRr3qosKttkj6Ws1iKXcfKj0yCwtnUxGF
         hRJZe3iWbH5fksWSxA3W7OLSzYP7YClypAzGeZRuu4ptUzd6mWIHsaxcdhoCiv32K+Ve
         b7oScIPvE++phJ68AcDA3HDKzCm0Xb5aUrkZ7KxHSMVvs/NoooFFAR3XBzl2uThNgw9u
         fbGFyLfT+c1r/q00ylizjr0SAaXWVSvCYtFwIOcuTcg6o5SCF663NTjOm98QKiuaaOsc
         SwPvTfac29AKhk70zGtwX1JxivC0e0hhUuPsq59uUircqf36PwYXX9T796sCOdsW/ZKh
         vblA==
X-Gm-Message-State: AOAM530Eix/8BjfRFl0JnUHmSUo/Yi/tsciKYQIe1DVH8+0Y3rqj7jNn
        Nr02FIyMQq6FAsM2yABQbZVlWDjS7fjJE+IaUCh3TA==
X-Google-Smtp-Source: ABdhPJwivhaI1YMsiYo0fx9M4my/+mnjcSuJyuBwd4Hdw0AJTbsyEgTFNADcmbyZKwv1Q/VuKteIzCd5qZAMpqIbrsU=
X-Received: by 2002:a2e:9916:: with SMTP id v22mr1793686lji.221.1608297181777;
 Fri, 18 Dec 2020 05:13:01 -0800 (PST)
MIME-Version: 1.0
References: <1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com>
In-Reply-To: <1608283672-18240-1-git-send-email-xuewen.yan94@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Dec 2020 14:12:50 +0100
Message-ID: <CAKfTPtC9bfoMeYhhmjQoZyPRYvWLa=4L4qFC_B4vWUMRh8nz4g@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: Avoid stale CPU util_est value for
 schedutil in task dequeue
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Xuewen Yan <Xuewen.Yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 at 10:28, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> From: Xuewen Yan <xuewen.yan@unisoc.com>
>
> CPU (root cfs_rq) estimated utilization (util_est) is currently used in
> dequeue_task_fair() to drive frequency selection before it is updated.
>
> with:
>
> CPU_util        : rq->cfs.avg.util_avg
> CPU_util_est    : rq->cfs.avg.util_est
> CPU_utilization : max(CPU_util, CPU_util_est)
> task_util       : p->se.avg.util_avg
> task_util_est   : p->se.avg.util_est
>
> dequeue_task_fair():
>
>     /* (1) CPU_util and task_util update + inform schedutil about
>            CPU_utilization changes */
>     for_each_sched_entity() /* 2 loops */
>         (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
>          -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]
>          -> sugov_get_util() -> cpu_util_cfs()
>
>     /* (2) CPU_util_est and task_util_est update */
>     util_est_dequeue()
>
> cpu_util_cfs() uses CPU_utilization which could lead to a false (too
> high) utilization value for schedutil in task ramp-down or ramp-up
> scenarios during task dequeue.
>
> To mitigate the issue split the util_est update (2) into:
>
>  (A) CPU_util_est update in util_est_dequeue()
>  (B) task_util_est update in util_est_update()
>
> Place (A) before (1) and keep (B) where (2) is. The latter is necessary
> since (B) relies on task_util update in (1).
>

maybe add a
Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")

> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes since v2:
> -modify the comment
> -move util_est_dequeue above within_margin()
> -modify the tab and space
>
> Changes since v1:
> -change the util_est_dequeue/update to inline type
> -use unsigned int enqueued rather than util_est in util_est_dequeue
> -remove "cpu" var
>
> ---
>  kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae7ceba..f3a1b7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3932,6 +3932,22 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
>         trace_sched_util_est_cfs_tp(cfs_rq);
>  }
>
> +static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> +                                   struct task_struct *p)
> +{
> +       unsigned int enqueued;
> +
> +       if (!sched_feat(UTIL_EST))
> +               return;
> +
> +       /* Update root cfs_rq's estimated utilization */
> +       enqueued  = cfs_rq->avg.util_est.enqueued;
> +       enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
> +       WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +
> +       trace_sched_util_est_cfs_tp(cfs_rq);
> +}
> +
>  /*
>   * Check if a (signed) value is within a specified (unsigned) margin,
>   * based on the observation that:
> @@ -3945,23 +3961,16 @@ static inline bool within_margin(int value, int margin)
>         return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
>  }
>
> -static void
> -util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> +static inline void util_est_update(struct cfs_rq *cfs_rq,
> +                                  struct task_struct *p,
> +                                  bool task_sleep)
>  {
>         long last_ewma_diff;
>         struct util_est ue;
> -       int cpu;
>
>         if (!sched_feat(UTIL_EST))
>                 return;
>
> -       /* Update root cfs_rq's estimated utilization */
> -       ue.enqueued  = cfs_rq->avg.util_est.enqueued;
> -       ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
> -       WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
> -
> -       trace_sched_util_est_cfs_tp(cfs_rq);
> -
>         /*
>          * Skip update of task's estimated utilization when the task has not
>          * yet completed an activation, e.g. being migrated.
> @@ -4001,8 +4010,7 @@ static inline bool within_margin(int value, int margin)
>          * To avoid overestimation of actual task utilization, skip updates if
>          * we cannot grant there is idle time in this CPU.
>          */
> -       cpu = cpu_of(rq_of(cfs_rq));
> -       if (task_util(p) > capacity_orig_of(cpu))
> +       if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
>                 return;
>
>         /*
> @@ -4085,8 +4093,11 @@ static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
>  util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
>
>  static inline void
> -util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
> -                bool task_sleep) {}
> +util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
> +
> +static inline void
> +util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p,
> +               bool task_sleep) {}
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
>
>  #endif /* CONFIG_SMP */
> @@ -5589,6 +5600,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         int idle_h_nr_running = task_has_idle_policy(p);
>         bool was_sched_idle = sched_idle_rq(rq);
>
> +       util_est_dequeue(&rq->cfs, p);
> +
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>                 dequeue_entity(cfs_rq, se, flags);
> @@ -5639,7 +5652,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 rq->next_balance = jiffies;
>
>  dequeue_throttle:
> -       util_est_dequeue(&rq->cfs, p, task_sleep);
> +       util_est_update(&rq->cfs, p, task_sleep);
>         hrtick_update(rq);
>  }
>
> --
> 1.9.1
>
