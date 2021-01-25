Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F56302405
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbhAYLAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbhAYK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:57:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA71C061797
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:56:40 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a12so8912290lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAa9D8GkV4F84xQyRv9PO2GSsEC1f+mWHcwd4pzJViw=;
        b=QznXVd7UDBUdKhZLgaxzZqvaA2tJ4B5xRSt8usX/fBUWs9OSWmM0vCMlufJ0fmrIF0
         sRxeJP9rIfxb2KFJqCUHvCxMldumf+MAoDSwwGGTFtarWDUbHcKDWIK3GDyOm9dDYMjQ
         it+axENj5w0sGU521VgJfdoNoKIT99rf6NJeNb/7hQEsqWMKAEpSil8KUEwQhByfui3R
         pLhQ9Gz5mDXcGLW68QVM3L/IRMjv+6qumMNdzGZYkXJWDxA61kHxCK7ud4ypOK5jDFB+
         LE9yNRoK7K8Yuputvt/TwIdFZ6IqUYEY29uxeeIv+DEKSpCrjGx7U5kI2sg9ad+MJwXl
         Yn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAa9D8GkV4F84xQyRv9PO2GSsEC1f+mWHcwd4pzJViw=;
        b=ZPMaELP1dOEm5eWt1wiMMsxNhH8pqHWVDqF+y2s4jYpUqecBcj7pNx4EkEHpLGlN9A
         Y+o279GVnymkzwsEbInvt9aphG5whjmA98/0/gkx4Wk5a3RRtN7KBZx5p9mqKy0gDrrS
         blnaYJJIB6OWVl+SVGVCWtBStx9cs6U8xCZyWGJEE2tQ8eyRRK4PuHc4owIasiaPi3KL
         uTP6l/5tbAqcVlXY/RkJKP8+7QxWwTwj9j949OizvIJ91LGnEHOEuO7iD5OH4j5eplbF
         ZTq96CUaqnP/bcW/hqPCdvA1PlSWef+ZGiy4qW00kpm/s3BwYqiJ5EA6qJUq75hcB/g+
         lLvw==
X-Gm-Message-State: AOAM530KBg/ihpSOJT/Fj/xRbiO42xm9QNviKI6KbfKydz6tDcAQWo+b
        8Dzwn9bsVWwXCwGl+W+stERCeaPJYBzX9DSMRZjWlw==
X-Google-Smtp-Source: ABdhPJx4IWnKhrvMfNNgwPe8Hp8KkOTATR8FLxHH3sIad4JgeSMONMNanrYXGB+8Cyh/5e9TB0wvsa1JZVoH6Bo0BZc=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr1514686lfd.233.1611572199471;
 Mon, 25 Jan 2021 02:56:39 -0800 (PST)
MIME-Version: 1.0
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Jan 2021 11:56:28 +0100
Message-ID: <CAKfTPtAxnsEDL436zUypLj2XyMQyhgPvJ8q_23835sQxWzGtxw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 06:50, Aubrey Li <aubrey.li@intel.com> wrote:
>
> A long-tail load balance cost is observed on the newly idle path,
> this is caused by a race window between the first nr_running check
> of the busiest runqueue and its nr_running recheck in detach_tasks.
>
> Before the busiest runqueue is locked, the tasks on the busiest
> runqueue could be pulled by other CPUs and nr_running of the busiest
> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED

We should better detect that when trying to detach task like below

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7688,6 +7688,16 @@ static int detach_tasks(struct lb_env *env)

        lockdep_assert_held(&env->src_rq->lock);

+       /*
+        * Another CPU has emptied this runqueue in the meantime.
+        * Just return and leave the load_balance properly.
+        */
+       if (env->src_rq->nr_running <= 1 && !env->loop) {
+               /* Clear the flag as we will not test any task */
+               env->flags &= ~LBF_ALL_PINNED;
+               return 0;
+       }
+
        if (env->imbalance <= 0)
                return 0;


> flag set, and triggers load_balance redo at the same sched_domain level.
>
> In order to find the new busiest sched_group and CPU, load balance will
> recompute and update the various load statistics, which eventually leads
> to the long-tail load balance cost.
>
> This patch introduces a variable(sched_nr_lb_redo) to limit load balance
> redo times, combined with sysctl_sched_nr_migrate, the max load balance
> cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
> 192 logical CPUs.
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae7ceba..b59f371 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7407,6 +7407,8 @@ struct lb_env {
>         unsigned int            loop;
>         unsigned int            loop_break;
>         unsigned int            loop_max;
> +       unsigned int            redo_cnt;
> +       unsigned int            redo_max;
>
>         enum fbq_type           fbq_type;
>         enum migration_type     migration_type;
> @@ -9525,6 +9527,7 @@ static int should_we_balance(struct lb_env *env)
>         return group_balance_cpu(sg) == env->dst_cpu;
>  }
>
> +static const unsigned int sched_nr_lb_redo = 1;
>  /*
>   * Check this_cpu to ensure it is balanced within domain. Attempt to move
>   * tasks if there is an imbalance.
> @@ -9547,6 +9550,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                 .dst_grpmask    = sched_group_span(sd->groups),
>                 .idle           = idle,
>                 .loop_break     = sched_nr_migrate_break,
> +               .redo_max       = sched_nr_lb_redo,
>                 .cpus           = cpus,
>                 .fbq_type       = all,
>                 .tasks          = LIST_HEAD_INIT(env.tasks),
> @@ -9682,7 +9686,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                          * destination group that is receiving any migrated
>                          * load.
>                          */
> -                       if (!cpumask_subset(cpus, env.dst_grpmask)) {
> +                       if (!cpumask_subset(cpus, env.dst_grpmask) &&
> +                                       ++env.redo_cnt < env.redo_max) {
>                                 env.loop = 0;
>                                 env.loop_break = sched_nr_migrate_break;
>                                 goto redo;
> --
> 2.7.4
>
