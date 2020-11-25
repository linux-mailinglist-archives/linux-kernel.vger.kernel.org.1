Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFB2C4530
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbgKYQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbgKYQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:28:50 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBCC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:28:49 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id t6so3917657lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiIm2++k4yJTPpq0vS1fRmjFouc1n6m3jwDZpiRBAcU=;
        b=SuVAt59V5r00dKaU5H77rHFssLynrIK6vj4BgTxA4ukbtr8f/UJbs2BnjrYTGr5W0G
         88kBKcg83zQQURb1trIFaDtVgP5vFd5OGWUS9DNnT8ub5gb+NuThViaVZUHc6fM5lD1H
         8X9buRJ4yt+WYYStMvnZtCn6thN0vFQ2ojhKu0XgzkvdW5ZEeiLoykVdA3mP1Hcb8Cz6
         DQb27rauXm6xHXMFLZ4ebmXeKNLbrpoaXeHH3W1pKeS5eSB+jFYzZ+oe7gKFDPYemZmX
         +20fh+d2uVVSqmZCbYZvDV6MFyJLiJSP5TFsG3VdlJ21xSbqhItLEtRq+H3fnFvniEcM
         iNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiIm2++k4yJTPpq0vS1fRmjFouc1n6m3jwDZpiRBAcU=;
        b=ojLjsBMdYaEFWel6svFEr9F4CdwVEl0bqFnHz9MKGy2HtCdn/fRA4x1jMAoNkAdpLJ
         C6efGOqab4FNfoOXVROuFuV0gdENGwW+RaO8OQ2LUzcGQeVdp/spodWXp2xI5f1HjdUZ
         zcUjGnMdCOVw7tNBIRx6kwp9FkFpdYDiBPqmactAi4cpMQNufQhZcUUdLX+DE2HKQHbm
         dmRO1Jj80cSxhCFInexu0GwOKUwnY2NfCUKVDLdsRuemR+MYF6q2q8J0ho8p5qg6fU3f
         ZfweyYKXlt1YuSU6Ii9iFToDZ0xxY8mJIiZVVjWD7quxi/PHGOoSzmvl5W93QToqN/dk
         WOTw==
X-Gm-Message-State: AOAM532103+hz46aux1UkPZHt2Y4ayXZboogmV7gQ+dPppHy2tgHnLqt
        sy2aJZBlRMW9idvaqQtGPqdZwzjesugVppBUHyjGNw==
X-Google-Smtp-Source: ABdhPJwtK7IrRMUh3gpJgFc+KkYkZLDsh/U9Bt+AWsFWTg32MzvP+KUZVCSXbb/a72ARUvE/HnXpZ2Cty9HVcc6NWME=
X-Received: by 2002:a19:cc91:: with SMTP id c139mr1863605lfg.31.1606321728034;
 Wed, 25 Nov 2020 08:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org> <20201117232003.3580179-3-joel@joelfernandes.org>
In-Reply-To: <20201117232003.3580179-3-joel@joelfernandes.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 Nov 2020 17:28:36 +0100
Message-ID: <CAKfTPtDSnr85X90gpPvgOf94Adh_mvH2CGhkXXx4FHn6EkCErg@mail.gmail.com>
Subject: Re: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 00:20, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Because sched_class::pick_next_task() also implies
> sched_class::set_next_task() (and possibly put_prev_task() and
> newidle_balance) it is not state invariant. This makes it unsuitable
> for remote task selection.
>
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/deadline.c  | 16 ++++++++++++++--
>  kernel/sched/fair.c      | 32 +++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c      |  8 ++++++++
>  kernel/sched/rt.c        | 15 +++++++++++++--
>  kernel/sched/sched.h     |  3 +++
>  kernel/sched/stop_task.c | 14 ++++++++++++--
>  6 files changed, 81 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0f2ea0a3664c..abfc8b505d0d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1867,7 +1867,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
>         return rb_entry(left, struct sched_dl_entity, rb_node);
>  }
>
> -static struct task_struct *pick_next_task_dl(struct rq *rq)
> +static struct task_struct *pick_task_dl(struct rq *rq)
>  {
>         struct sched_dl_entity *dl_se;
>         struct dl_rq *dl_rq = &rq->dl;
> @@ -1879,7 +1879,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>         dl_se = pick_next_dl_entity(rq, dl_rq);
>         BUG_ON(!dl_se);
>         p = dl_task_of(dl_se);
> -       set_next_task_dl(rq, p, true);
> +
> +       return p;
> +}
> +
> +static struct task_struct *pick_next_task_dl(struct rq *rq)
> +{
> +       struct task_struct *p;
> +
> +       p = pick_task_dl(rq);
> +       if (p)
> +               set_next_task_dl(rq, p, true);
> +
>         return p;
>  }
>
> @@ -2551,6 +2562,7 @@ DEFINE_SCHED_CLASS(dl) = {
>
>  #ifdef CONFIG_SMP
>         .balance                = balance_dl,
> +       .pick_task              = pick_task_dl,
>         .select_task_rq         = select_task_rq_dl,
>         .migrate_task_rq        = migrate_task_rq_dl,
>         .set_cpus_allowed       = set_cpus_allowed_dl,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 52ddfec7cea6..12cf068eeec8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4459,7 +4459,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>          * Avoid running the skip buddy, if running something else can
>          * be done without getting too unfair.
>          */
> -       if (cfs_rq->skip == se) {
> +       if (cfs_rq->skip && cfs_rq->skip == se) {
>                 struct sched_entity *second;
>
>                 if (se == curr) {
> @@ -7017,6 +7017,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>                 set_last_buddy(se);
>  }
>
> +#ifdef CONFIG_SMP
> +static struct task_struct *pick_task_fair(struct rq *rq)
> +{
> +       struct cfs_rq *cfs_rq = &rq->cfs;
> +       struct sched_entity *se;
> +
> +       if (!cfs_rq->nr_running)
> +               return NULL;
> +
> +       do {
> +               struct sched_entity *curr = cfs_rq->curr;
> +
> +               se = pick_next_entity(cfs_rq, NULL);

Calling pick_next_entity clears buddies. This is fine without
coresched because the se will be the next one. But calling
pick_task_fair doesn't mean that the se will be used

> +
> +               if (curr) {
> +                       if (se && curr->on_rq)
> +                               update_curr(cfs_rq);
> +

Shouldn't you check if cfs_rq is throttled ?

> +                       if (!se || entity_before(curr, se))
> +                               se = curr;
> +               }
> +
> +               cfs_rq = group_cfs_rq(se);
> +       } while (cfs_rq);
> +
> +       return task_of(se);
> +}
> +#endif
> +
>  struct task_struct *
>  pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> @@ -11219,6 +11248,7 @@ DEFINE_SCHED_CLASS(fair) = {
>
>  #ifdef CONFIG_SMP
>         .balance                = balance_fair,
> +       .pick_task              = pick_task_fair,
>         .select_task_rq         = select_task_rq_fair,
>         .migrate_task_rq        = migrate_task_rq_fair,
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 50e128b899c4..33864193a2f9 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -406,6 +406,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
>         schedstat_inc(rq->sched_goidle);
>  }
>
> +#ifdef CONFIG_SMP
> +static struct task_struct *pick_task_idle(struct rq *rq)
> +{
> +       return rq->idle;
> +}
> +#endif
> +
>  struct task_struct *pick_next_task_idle(struct rq *rq)
>  {
>         struct task_struct *next = rq->idle;
> @@ -473,6 +480,7 @@ DEFINE_SCHED_CLASS(idle) = {
>
>  #ifdef CONFIG_SMP
>         .balance                = balance_idle,
> +       .pick_task              = pick_task_idle,
>         .select_task_rq         = select_task_rq_idle,
>         .set_cpus_allowed       = set_cpus_allowed_common,
>  #endif
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a6f9d132c24f..a0e245b0c4bd 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1626,7 +1626,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
>         return rt_task_of(rt_se);
>  }
>
> -static struct task_struct *pick_next_task_rt(struct rq *rq)
> +static struct task_struct *pick_task_rt(struct rq *rq)
>  {
>         struct task_struct *p;
>
> @@ -1634,7 +1634,17 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
>                 return NULL;
>
>         p = _pick_next_task_rt(rq);
> -       set_next_task_rt(rq, p, true);
> +
> +       return p;
> +}
> +
> +static struct task_struct *pick_next_task_rt(struct rq *rq)
> +{
> +       struct task_struct *p = pick_task_rt(rq);
> +
> +       if (p)
> +               set_next_task_rt(rq, p, true);
> +
>         return p;
>  }
>
> @@ -2483,6 +2493,7 @@ DEFINE_SCHED_CLASS(rt) = {
>
>  #ifdef CONFIG_SMP
>         .balance                = balance_rt,
> +       .pick_task              = pick_task_rt,
>         .select_task_rq         = select_task_rq_rt,
>         .set_cpus_allowed       = set_cpus_allowed_common,
>         .rq_online              = rq_online_rt,
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f794c9337047..5a0dd2b312aa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1839,6 +1839,9 @@ struct sched_class {
>  #ifdef CONFIG_SMP
>         int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
>         int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
> +
> +       struct task_struct * (*pick_task)(struct rq *rq);
> +
>         void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
>
>         void (*task_woken)(struct rq *this_rq, struct task_struct *task);
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 55f39125c0e1..f988ebe3febb 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -34,15 +34,24 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
>         stop->se.exec_start = rq_clock_task(rq);
>  }
>
> -static struct task_struct *pick_next_task_stop(struct rq *rq)
> +static struct task_struct *pick_task_stop(struct rq *rq)
>  {
>         if (!sched_stop_runnable(rq))
>                 return NULL;
>
> -       set_next_task_stop(rq, rq->stop, true);
>         return rq->stop;
>  }
>
> +static struct task_struct *pick_next_task_stop(struct rq *rq)
> +{
> +       struct task_struct *p = pick_task_stop(rq);
> +
> +       if (p)
> +               set_next_task_stop(rq, p, true);
> +
> +       return p;
> +}
> +
>  static void
>  enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
>  {
> @@ -123,6 +132,7 @@ DEFINE_SCHED_CLASS(stop) = {
>
>  #ifdef CONFIG_SMP
>         .balance                = balance_stop,
> +       .pick_task              = pick_task_stop,
>         .select_task_rq         = select_task_rq_stop,
>         .set_cpus_allowed       = set_cpus_allowed_common,
>  #endif
> --
> 2.29.2.299.gdc1121823c-goog
>
