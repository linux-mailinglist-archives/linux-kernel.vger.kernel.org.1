Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B711BD743
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD2I2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2I2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:28:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0AC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:28:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so1647783ljb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ot9UuqNfvfNki4DkNoeaGh3MgiComxbHhLIfX0drnUM=;
        b=VkwSvGPvqaBIFwQUjgrJDUr5n+l5svGxZliu7TlcVcbzcL04pASCev+YMX53MGmy0f
         TE4tZ5YwyidEGvEhWNScFRqBOYzmMNGXiG9D1QD17+phjAqsMwjNL2TQO0LVOe4U1pKn
         PQujOjq2+bAQfknl1B4p1tItyeat4UjXXpk9zeS7aIFtLVQ7rN4lk7GqcdVeBc0IMUgz
         7LPLTUNoq4OhoQ0yQx+tQGT/fh68f0d9qNGbmCf6r/RJZ3Dc14eSrgnd0ZwosXPL/Yfl
         Dbbzl3srqiS9o+dl9UMnPyXKQfDLNVUkg2bVs74ERu4/bEDgg159GOMqMFOk7dRsayFD
         38fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ot9UuqNfvfNki4DkNoeaGh3MgiComxbHhLIfX0drnUM=;
        b=NGlgtyWdq+i82Sg1cUccstxPEUqvorDdW+uavpuEEa3WiCn8U72cC90euTZKalDHHf
         nuqu3/WzDzUT43JnPPrRzHv+sMjKxJ0SKMqtxqIL8zCffPj5xqx/83Ktg6xHeUKF/33g
         A1qRt00j6niH6409xAu9iL8TaErXbx4QUb8/1FYlUYesf98jfs2fw//RjkDcPZiW03xm
         aPi2+Ydzz2wyGJ1BElbK6nY3ywWyH6LgAjEXTMYTfiMq6waaGdxq8A6xTIP5wtHnCYDi
         Z6Lq2pAk5fCjgKhOMDu4xDqvPCYdfWDA7BVk8ZXV7geugoN6JE/ub79TdopVvmFHAQ/m
         5JaA==
X-Gm-Message-State: AGi0PuYXPKI0FXaAP+Q4bxX0meoGVQkFPIZuqozkYm7H60LKroUtAnDu
        Sx2TywMnhMTg+sTuAvDXN3j0ZBELxT2Jm3J4U/sDUg==
X-Google-Smtp-Source: APiQypIkudRAEHt/PfUi4L0Ton+/e9wEhqoLDfpTAX6kxUXNWJyS0h+2TjEx3a7U8Jc7nJuq1EGxoH/7GtfI3HofQVk=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr19260587ljg.21.1588148882605;
 Wed, 29 Apr 2020 01:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200428050242.17717-1-swood@redhat.com> <20200428050242.17717-2-swood@redhat.com>
In-Reply-To: <20200428050242.17717-2-swood@redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 29 Apr 2020 10:27:51 +0200
Message-ID: <CAKfTPtBsfneVVdT5UhtysUGACqPp7YUGKzSTKu4D8UYKwDbykg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from finish_task_switch()
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 at 07:02, Scott Wood <swood@redhat.com> wrote:
>
> Thus, newidle_balance() is entered with interrupts enabled, which allows
> (in the next patch) enabling interrupts when the lock is dropped.

The comment fails to explain which changes have been done to
newidle_balance(),  for which reasons and what are the impact for CFS
scheduler

>
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/core.c  |  7 ++++---
>  kernel/sched/fair.c  | 45 ++++++++++++++++----------------------------
>  kernel/sched/sched.h |  6 ++----
>  3 files changed, 22 insertions(+), 36 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..0294beb8d16c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>         }
>
>         tick_nohz_task_switch();
> +
> +       if (is_idle_task(current))
> +               newidle_balance();
> +
>         return rq;
>  }
>
> @@ -3919,8 +3923,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                    rq->nr_running == rq->cfs.h_nr_running)) {
>
>                 p = pick_next_task_fair(rq, prev, rf);
> -               if (unlikely(p == RETRY_TASK))
> -                       goto restart;
>
>                 /* Assumes fair_sched_class->next == idle_sched_class */
>                 if (!p) {
> @@ -3931,7 +3933,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                 return p;
>         }
>
> -restart:
>  #ifdef CONFIG_SMP
>         /*
>          * We must do the balancing pass before put_next_task(), such
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..74c3c5280d6b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6758,8 +6758,6 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>         if (rq->nr_running)
>                 return 1;
> -
> -       return newidle_balance(rq, rf) != 0;

Missing return ?

>  }
>  #endif /* CONFIG_SMP */
>
> @@ -6934,9 +6932,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>         struct cfs_rq *cfs_rq = &rq->cfs;
>         struct sched_entity *se;
>         struct task_struct *p;
> -       int new_tasks;
>
> -again:
>         if (!sched_fair_runnable(rq))
>                 goto idle;
>
> @@ -7050,19 +7046,6 @@ done: __maybe_unused;
>         if (!rf)
>                 return NULL;
>
> -       new_tasks = newidle_balance(rq, rf);
> -
> -       /*
> -        * Because newidle_balance() releases (and re-acquires) rq->lock, it is
> -        * possible for any higher priority task to appear. In that case we
> -        * must re-start the pick_next_entity() loop.
> -        */
> -       if (new_tasks < 0)
> -               return RETRY_TASK;
> -
> -       if (new_tasks > 0)
> -               goto again;
> -
>         /*
>          * rq is about to be idle, check if we need to update the
>          * lost_idle_time of clock_pelt
> @@ -10425,14 +10408,23 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
>   *     0 - failed, no new tasks
>   *   > 0 - success, new (fair) tasks present
>   */
> -int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> +int newidle_balance(void)
>  {
>         unsigned long next_balance = jiffies + HZ;
> -       int this_cpu = this_rq->cpu;
> +       int this_cpu;
>         struct sched_domain *sd;
> +       struct rq *this_rq;
>         int pulled_task = 0;
>         u64 curr_cost = 0;
>
> +       preempt_disable();
> +       this_rq = this_rq();
> +       this_cpu = this_rq->cpu;
> +       local_bh_disable();
> +       raw_spin_lock_irq(&this_rq->lock);
> +
> +       update_rq_clock(this_rq);
> +
>         update_misfit_status(NULL, this_rq);
>         /*
>          * We must set idle_stamp _before_ calling idle_balance(), such that we
> @@ -10444,15 +10436,7 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>          * Do not pull tasks towards !active CPUs...
>          */
>         if (!cpu_active(this_cpu))
> -               return 0;
> -
> -       /*
> -        * This is OK, because current is on_cpu, which avoids it being picked
> -        * for load-balance and preemption/IRQs are still disabled avoiding
> -        * further scheduler activity on it and we're being very careful to
> -        * re-start the picking loop.
> -        */
> -       rq_unpin_lock(this_rq, rf);
> +               goto out_unlock;
>
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>             !READ_ONCE(this_rq->rd->overload)) {
> @@ -10534,7 +10518,10 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         if (pulled_task)
>                 this_rq->idle_stamp = 0;
>
> -       rq_repin_lock(this_rq, rf);
> +out_unlock:
> +       raw_spin_unlock_irq(&this_rq->lock);
> +       local_bh_enable();
> +       preempt_enable();
>
>         return pulled_task;
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..3d97c51544d7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1504,13 +1504,13 @@ static inline void unregister_sched_domain_sysctl(void)
>  }
>  #endif
>
> -extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
> +extern int newidle_balance(void);
>
>  #else
>
>  static inline void sched_ttwu_pending(void) { }
>
> -static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
> +static inline int newidle_balance(void) { return 0; }
>
>  #endif /* CONFIG_SMP */
>
> @@ -1742,8 +1742,6 @@ extern const u32          sched_prio_to_wmult[40];
>  #define ENQUEUE_MIGRATED       0x00
>  #endif
>
> -#define RETRY_TASK             ((void *)-1UL)
> -
>  struct sched_class {
>         const struct sched_class *next;
>
> --
> 2.18.2
>
