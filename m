Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654D92F8DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbhAPRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbhAPRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:49 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481ECC0617BB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:39:15 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e22so275955iog.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otY6ciKN+gysGenPbqEDdYdlSugmyG9nw1sy+M0CT3s=;
        b=fnCtj0N9L8RJbQQlQj/Y3kHGgp7Qmw9bkK05C71ZXiE3UA+59Vc4LNoUJdb60wW8Je
         KPK67d20uQlXv/kskQjlSJJ1QExtIHHeFSwkquCrEOG4lbRJJornRQ3f33mcv0uIPolY
         gUORzUthOzadEXn8cELiJwAQCusC1ULuVs90Pjm3AW6tOG/kC1h+kNNIOKCY9O7uchM+
         CHZOBDr4itKDRgbddLn12itAfr2iAuQ2hsnyj8VcRrRP8DNG9fSY8GVtlQLMcCBQ5UGL
         Ga2CLTgPL3Zbwm0Mjxhpb+pzLK9r3o4uD1JbGM+mnifH3J1r1KEUDzoyG1hWrgyJQxCY
         Tx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otY6ciKN+gysGenPbqEDdYdlSugmyG9nw1sy+M0CT3s=;
        b=DPb9j/lEy0Ar4z+T+f8IC1Rfwb3d2nPoarIlgv5xi1mMdRRlTPF5aQ3Y39TxqD4Atx
         v0FQPPSAocloRvOm23BqnZMukGfztCepg74W/BygzTyXvXPT+K/CRS/wkt0WHoZrd0e/
         d24k3IGkFBHfxNF5UiNKGahVbBHaM0whR09RzQuwt8HRcfXujFLnnHRM6fq0sYmrOCN1
         xhrcoPd3ZVpTXjoswKEmmPUGN5M/wvNt4X9l6uJiVsph+d89g+cqRbmfA7b46ywIiZ3e
         HPvExQWfrwEKXMTOUgDf9Aj40Dm+lXMpXA4VDPWgHNrgPsLDGJYrbvITJIob0QJ1TrA3
         wedQ==
X-Gm-Message-State: AOAM530fPGXJIDe1qjYTYp7LpSLCHtRBeAScgowiTqxWXMsQixV0vPuq
        n2dJ97xHehLZpokDZ3NBQK4fpIavLcDfuNrlCy8=
X-Google-Smtp-Source: ABdhPJzSIZKrZxPuA/oHoh7gvYudnZwisnG/DcieQJoXNj50vBVgy7T49h7RknfJ6TZSPYgMYIBG/J1KKXQ9rm2Q1jI=
X-Received: by 2002:a05:6e02:5c4:: with SMTP id l4mr15157168ils.94.1610807954546;
 Sat, 16 Jan 2021 06:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20210116113033.608340773@infradead.org> <20210116113920.187137770@infradead.org>
In-Reply-To: <20210116113920.187137770@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 16 Jan 2021 22:39:03 +0800
Message-ID: <CAJhGHyB7fNvxyKwnMgWicvZN7oTnGYLBNH8cUjLg2EcKQ4YMMg@mail.gmail.com>
Subject: Re: [PATCH 8/8] sched: Relax the set_cpus_allowed_ptr() semantics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 7:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Now that we have KTHREAD_IS_PER_CPU to denote the critical per-cpu
> tasks to retain during CPU offline, we can relax the warning in
> set_cpus_allowed_ptr(). Any spurious kthread that wants to get on at
> the last minute will get pushed off before it can run.
>
> While during CPU online there is no harm, and actual benefit, to
> allowing kthreads back on early, it simplifies hotplug code.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

Relaxing set_cpus_allowed_ptr() was also one of the choices I listed,
which can really simplify hotplug code in the workqueue and may be
other hotplug code.

Reviewed-by: Lai jiangshan <jiangshanlai@gmail.com>

> ---
>  kernel/sched/core.c |   20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2342,7 +2342,9 @@ static int __set_cpus_allowed_ptr(struct
>
>         if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
>                 /*
> -                * Kernel threads are allowed on online && !active CPUs.
> +                * Kernel threads are allowed on online && !active CPUs,
> +                * however, during cpu-hot-unplug, even these might get pushed
> +                * away if not KTHREAD_IS_PER_CPU.
>                  *
>                  * Specifically, migration_disabled() tasks must not fail the
>                  * cpumask_any_and_distribute() pick below, esp. so on
> @@ -2386,16 +2388,6 @@ static int __set_cpus_allowed_ptr(struct
>
>         __do_set_cpus_allowed(p, new_mask, flags);
>
> -       if (p->flags & PF_KTHREAD) {
> -               /*
> -                * For kernel threads that do indeed end up on online &&
> -                * !active we want to ensure they are strict per-CPU threads.
> -                */
> -               WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
> -                       !cpumask_intersects(new_mask, cpu_active_mask) &&
> -                       p->nr_cpus_allowed != 1);
> -       }
> -
>         return affine_move_task(rq, p, &rf, dest_cpu, flags);
>
>  out:
> @@ -7519,6 +7511,12 @@ int sched_cpu_deactivate(unsigned int cp
>          */
>         synchronize_rcu();
>
> +       /*
> +        * From this point forward, this CPU will refuse to run any task that
> +        * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> +        * push those tasks away until this gets cleared, see
> +        * sched_cpu_dying().
> +        */
>         balance_push_set(cpu, true);
>
>         rq_lock_irqsave(rq, &rf);
>
>
