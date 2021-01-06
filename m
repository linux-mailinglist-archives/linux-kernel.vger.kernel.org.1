Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1816D2EC0D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbhAFQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbhAFQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:05:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B1C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 08:04:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m25so7556617lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCdlVBa++bYNXr+oDndisTMl/hF7RFwtU0REDcOknW4=;
        b=SZAL7WUmho7NBLfysx83oawi0dlPNPx5WU0Jgyz+iLG9QKd7KWdog/zKr7C5+vTtt2
         jySoeHoHG5wtPwnZJZwWcyqGPwQwzl7uogOuXWbbWM2gugz73f6b0VfqRLl/8cTmmqLC
         nzbi0cOLT76JLKucXyyV32bDyhoegbZeSgkOpV7CghGIZ0Z2QnAz8/k2KGmQUk8tL8Or
         iUmng/vK6oI9mwiD4FYGmk/uCLGLrAzuZMcZrPORwJ2NwiEt6Tk95wmg9iW7KO0v8pKA
         t6eza/tuaAZk5NgOYH9Z+FkBRwtp/YBe+W77MU/M/TBR+zpxcPpjPN5o3B5mwmWg5+zb
         hU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCdlVBa++bYNXr+oDndisTMl/hF7RFwtU0REDcOknW4=;
        b=sJXifhksf5QMaYgqpdRHX2Eos2rK1iGQc/NggSbvVYfqWN17mA0GOF4cuK7hkLkWyb
         9pjbw4Mf0HhnluY/AEC3g9mNbYWZBJrhodF/xyVF3OxI+3x5t4lykeLvVXI/PGgI04SO
         m3b8ATEJN5uVCAJjkVm4Aw482bpGrUiPc6humvfdIsAdK8+OxFXORriFA0JF+6RZHyxn
         U1SWRTZYZt6RCrIK5ykaSUFK+s6voYtd6hJrFuaJM+k2dbuDXGZVoi22R3/nX1KFQsAh
         KUhDR4LsAQrahaNaAXtYql0A2CMP7gIumSn5USyumRSKNBZlBSR3gvORNQgrgvgzbUqT
         x4uA==
X-Gm-Message-State: AOAM531Oxe7Rx5JtEZ6Cjc8Gt1ZsG2ndRMpeFKUqSS9nF0PKpOp7pSYQ
        fvKf+kWZCX1DO2V2D8bGaz4BRX4apcOzXkLnZw4uDw==
X-Google-Smtp-Source: ABdhPJwsPj63zC5rRg2aihodo79JSoGvAjzhVxwkpU6TuHUOc03Db9s3UtboEmOvpBWSwYmVSfcVR0N9x6eVLXF4pqI=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr2161245ljn.176.1609949071704;
 Wed, 06 Jan 2021 08:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-3-vincent.guittot@linaro.org> <jhjzh1m2j4k.mognet@arm.com>
In-Reply-To: <jhjzh1m2j4k.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Jan 2021 17:04:20 +0100
Message-ID: <CAKfTPtDB6RrX+1jcKpvsWrHFoGU7dHaG6bQEULFVCFX2_ZLe5A@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 at 16:13, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 06/01/21 14:34, Vincent Guittot wrote:
> > Setting LBF_ALL_PINNED during active load balance is only valid when there
> > is only 1 running task on the rq otherwise this ends up increasing the
> > balance interval whereas other tasks could migrate after the next interval
> > once they become cache-cold as an example.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5428b8723e61..69a455113b10 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9759,7 +9759,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                       if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
> >                               raw_spin_unlock_irqrestore(&busiest->lock,
> >                                                           flags);
> > -                             env.flags |= LBF_ALL_PINNED;
> > +                             if (busiest->nr_running == 1)
> > +                                     env.flags |= LBF_ALL_PINNED;
>
> So LBF_ALL_PINNED *can* be set if busiest->nr_running > 1, because
> before we get there we have:
>
>   if (nr_running > 1) {
>       env.flags |= LBF_ALL_PINNED;
>       detach_tasks(&env); // Removes LBF_ALL_PINNED if > 0 tasks can be pulled
>       ...
>   }
>
> What about following the logic used by detach_tasks() and only clear the
> flag? Say something like the below. if nr_running > 1, then we'll have
> gone through detach_tasks() and will have cleared the flag (if
> possible).
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..211c86ba3f5b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9623,6 +9623,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>         env.src_rq = busiest;
>
>         ld_moved = 0;
> +       /* Clear this as soon as we find a single pullable task */
> +       env.flags |= LBF_ALL_PINNED;
>         if (busiest->nr_running > 1) {
>                 /*
>                  * Attempt to move tasks. If find_busiest_group has found
> @@ -9630,7 +9632,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                  * still unbalanced. ld_moved simply stays zero, so it is
>                  * correctly treated as an imbalance.
>                  */
> -               env.flags |= LBF_ALL_PINNED;
>                 env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
>
>  more_balance:
> @@ -9756,10 +9757,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                         if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
>                                 raw_spin_unlock_irqrestore(&busiest->lock,
>                                                             flags);
> -                               env.flags |= LBF_ALL_PINNED;
>                                 goto out_one_pinned;
>                         }
>
> +                       env.flags &= ~LBF_ALL_PINNED;

Yes, looks easier to read.
will do the change in the next version

> +
>                         /*
>                          * ->active_balance synchronizes accesses to
>                          * ->active_balance_work.  Once set, it's cleared
> ---
