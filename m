Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104FE278A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgIYOMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:12:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:12:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so2970099lfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQZZYWQRQU3R4/AyBBkgo3cp3R4MrVpJDEagQnv/2cQ=;
        b=C/1AWdG5g9HyESCijA/XPpkqoR/KX+cCOqqWQPPLf7NLZgdVdDUdU7zQXYTnktnoeG
         pLsHWcsHts8RpxIx7ZVroJDGECp4uDN+NOulzoyXqPiCQwLfcDoY1kdfukVBC15qiiL1
         pueZMuY3j1kTU6IJFbvYgDtOUe8lodYXlrZXR03nTbfNutWQRzGwJLWOAZex+XKfpDO/
         T6n8b1twyb3jqCc91XVnx0orS7qBEmYGNUjNhVf5MsiM6Saq9t6vd7nHtoNjFff+YBYl
         dqxpZn0tLxFcCdrWHNLzaNbgkVnX1EjiT87HO8+UgT43EUhTpp4Q3qjOAdQDeHPheqQR
         FKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQZZYWQRQU3R4/AyBBkgo3cp3R4MrVpJDEagQnv/2cQ=;
        b=TeFMsdiKg6nEuQIHJcLFyyH92fqEjmyi2xi2E5WK+BNRvi36Vor/Sz+K4e1RES1o1h
         hP1s1i4CJHh7C/qveosVEIiOpgEo3YOmVF5ErbctLnTuvtPFs90zT3wnBGxnW/6DRSLC
         QOdgf/M2a5AcxUyCufecTaC9Ed+4WcvGLfd3KzEcKRhvZ9CD7uTHy+Z1rcoR/d5aA+PZ
         nownvEiOWUbmO8tOwXoNCm51+EjPkskW2JPMlrgqJYVh6JoAy5WfMDjUZkd+JNjqTnUK
         eoI/uWfmkiEECTNxxsjS3Z5W1wfTJk4G+PpmndltN/RyF6nm7aTBw6+qnTaFYT9qr00+
         Z5UQ==
X-Gm-Message-State: AOAM5318jSKvnFS8Z8oremwLO/oM28f6i1D98PCrxZVgLbzeSZC0xzFV
        jkHlLWJIVXqkedbLUaGWpObBzIUIcWxYVLLzUfcVCFxfYU0jAQ==
X-Google-Smtp-Source: ABdhPJxH4qojgMvKjWSSTj1eAHOotps9jQ2tzrL8M34iYX/4IGuZjnFVuy0jc3NosWkmv6umdJuEvCNZc/98IyZ1ZW4=
X-Received: by 2002:a19:2214:: with SMTP id i20mr1554289lfi.252.1601043125937;
 Fri, 25 Sep 2020 07:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200924014755.36253-1-tian.xianting@h3c.com>
In-Reply-To: <20200924014755.36253-1-tian.xianting@h3c.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Sep 2020 16:11:53 +0200
Message-ID: <CAKfTPtBx7F_TMSMy2OKDPZNyHwJfVvsDbNo45sM_kAHQTK8zEw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove the force parameter of update_tg_load_avg()
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 03:55, Xianting Tian <tian.xianting@h3c.com> wrote:
>
> In the file fair.c, sometims update_tg_load_avg(cfs_rq, 0) is used,
> sometimes update_tg_load_avg(cfs_rq, false) is used.
> update_tg_load_avg() has the parameter force, but in current code,
> it never set 1 or true to it, so remove the force parameter.
>
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536..7056fa97f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -831,7 +831,7 @@ void init_entity_runnable_average(struct sched_entity *se)
>  void post_init_entity_util_avg(struct task_struct *p)
>  {
>  }
> -static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
> +static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>  }
>  #endif /* CONFIG_SMP */
> @@ -3288,7 +3288,6 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>  /**
>   * update_tg_load_avg - update the tg's load avg
>   * @cfs_rq: the cfs_rq whose avg changed
> - * @force: update regardless of how small the difference
>   *
>   * This function 'ensures': tg->load_avg := \Sum tg->cfs_rq[]->avg.load.
>   * However, because tg->load_avg is a global value there are performance
> @@ -3300,7 +3299,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>   *
>   * Updating tg's load_avg is necessary before update_cfs_share().
>   */
> -static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
> +static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>         long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
>
> @@ -3310,7 +3309,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
>         if (cfs_rq->tg == &root_task_group)
>                 return;
>
> -       if (force || abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
>                 cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
>         }
> @@ -3612,7 +3611,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
>
>  #else /* CONFIG_FAIR_GROUP_SCHED */
>
> -static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
> +static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
>
>  static inline int propagate_entity_load_avg(struct sched_entity *se)
>  {
> @@ -3800,13 +3799,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>                  * IOW we're enqueueing a task on a new CPU.
>                  */
>                 attach_entity_load_avg(cfs_rq, se);
> -               update_tg_load_avg(cfs_rq, 0);
> +               update_tg_load_avg(cfs_rq);
>
>         } else if (decayed) {
>                 cfs_rq_util_change(cfs_rq, 0);
>
>                 if (flags & UPDATE_TG)
> -                       update_tg_load_avg(cfs_rq, 0);
> +                       update_tg_load_avg(cfs_rq);
>         }
>  }
>
> @@ -7887,7 +7886,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
>                 struct sched_entity *se;
>
>                 if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> -                       update_tg_load_avg(cfs_rq, 0);
> +                       update_tg_load_avg(cfs_rq);
>
>                         if (cfs_rq == &rq->cfs)
>                                 decayed = true;
> @@ -10786,7 +10785,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>         /* Catch up with the cfs_rq and remove our load when we leave */
>         update_load_avg(cfs_rq, se, 0);
>         detach_entity_load_avg(cfs_rq, se);
> -       update_tg_load_avg(cfs_rq, false);
> +       update_tg_load_avg(cfs_rq);
>         propagate_entity_cfs_rq(se);
>  }
>
> @@ -10805,7 +10804,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>         /* Synchronize entity with its cfs_rq */
>         update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
>         attach_entity_load_avg(cfs_rq, se);
> -       update_tg_load_avg(cfs_rq, false);
> +       update_tg_load_avg(cfs_rq);
>         propagate_entity_cfs_rq(se);
>  }
>
> --
> 2.17.1
>
