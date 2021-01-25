Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6F3026C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbhAYPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbhAYOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:52:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4047C061788
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:52:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id q12so18103593lfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBq/cXkQq96ZdadHbeLIVkrbnkXQgb5R2ac1/WrI8S0=;
        b=xeSjJ/j2VagBpsJUmcj0AoFSUSfr08S3P2dDyN1xGmgVr3hH2zAjfDwd/Ay5uUTjxh
         tZABy2l2Hp6yb6ycGIA5AQKvQ6SzIde9rnA4spenZrE2x0vuHNWmhObkfzket4Zg1cPa
         aSLvkHgk5Oa6m+zae0CQnZFe/b9v9htxNA29gZqVKwA+zXThWM+iDNdjP4a96oJoV6Hs
         VTx1abgaDazQg1YTgYV0tlewVciVtFj3xURxGuolMEQftrZlfnJFoc+uNZuQYCRBqrY5
         ubjgiHwrsRjoOVDfqn/ywHR+Rs2qUBYdC2LDLjQ8K0xE/KLm7lxnf0VPc7liBL/gONFj
         edEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBq/cXkQq96ZdadHbeLIVkrbnkXQgb5R2ac1/WrI8S0=;
        b=fFmhEkHWp78tS4yUUnNKqj3BaejbMiYhIzWgGrhVWcfpKI1LE8SH0SDp9mkEq63hgB
         DjN02fFSoIvlFPf6JPOL4P4ncOTzUuBAs4m0ayiAhEC70w31US+lB5aqptlGVNhtWcGo
         GxBVsQFgiU5VvAacznkZzneGKEfbhmWLXwWHayXJzZlRtgdWR3xrPlVZr47Wbb6PoVQ8
         PqAaORGbiJhWQi/sr7XTYR6/HDz+OKtflxQfb5g2iVDC87La8W/XlriPdIand2mU0ns9
         0KVoR/o9mcAS6cAt7q4OJF3jdn1ScFq391lPLw47HRu/dLmNIczD4z87j7TwOke4C9E+
         XRNQ==
X-Gm-Message-State: AOAM5309FNJ9yYlOB6KF1MUDGX97cRujJZZ1vZuvHlnqBoL2bv28jpkS
        aw7YVzbqNnqNn6DufnUGHlyKhv8uO5a94k8mZq/owg==
X-Google-Smtp-Source: ABdhPJxeoujHAkYOOuevm8Q3fDYD3fT7mkeu+KzPGbhRydDmT5BQEcOa1gaTFdjFkUqfksG1AbIz400OJ5G9vW+Ucgc=
X-Received: by 2002:a19:ac45:: with SMTP id r5mr460858lfc.305.1611586322291;
 Mon, 25 Jan 2021 06:52:02 -0800 (PST)
MIME-Version: 1.0
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
 <CAKfTPtAxnsEDL436zUypLj2XyMQyhgPvJ8q_23835sQxWzGtxw@mail.gmail.com> <a99d59c3-2023-1e8f-83cd-d964e156ffd6@linux.intel.com>
In-Reply-To: <a99d59c3-2023-1e8f-83cd-d964e156ffd6@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Jan 2021 15:51:51 +0100
Message-ID: <CAKfTPtCCzy5keKcEOUX6D1+wty0dtYEfA5=oezWRgKY_beO5NQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
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
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 15:00, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2021/1/25 18:56, Vincent Guittot wrote:
> > On Mon, 25 Jan 2021 at 06:50, Aubrey Li <aubrey.li@intel.com> wrote:
> >>
> >> A long-tail load balance cost is observed on the newly idle path,
> >> this is caused by a race window between the first nr_running check
> >> of the busiest runqueue and its nr_running recheck in detach_tasks.
> >>
> >> Before the busiest runqueue is locked, the tasks on the busiest
> >> runqueue could be pulled by other CPUs and nr_running of the busiest
> >> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
> >
> > We should better detect that when trying to detach task like below
>
> This should be a compromise from my understanding. If we give up load balance
> this time due to the race condition, we do reduce the load balance cost on the
> newly idle path, but if there is an imbalance indeed at the same sched_domain

Redo path is there in case, LB has found an imbalance but it can't
move some loads from this busiest rq to dest rq because of some cpu
affinity. So it tries to fix the imbalance by moving load onto another
rq of the group. In your case, the imbalance has disappeared because
it has already been pulled by another rq so you don't have to try to
find another imbalance. And I would even say you should not in order
to let other level to take a chance to spread the load

> level, we have to wait the next softirq entry to handle that imbalance. This
> means the tasks on the second busiest runqueue have to stay longer, which could
> introduce tail latency as well. That's why I introduced a variable to control
> the redo loops. I'll send this to the benchmark queue to see if it makes any

TBH, I don't like multiplying the number of knobs

> difference.
>
> Thanks,
> -Aubrey
>
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7688,6 +7688,16 @@ static int detach_tasks(struct lb_env *env)
> >
> >         lockdep_assert_held(&env->src_rq->lock);
> >
> > +       /*
> > +        * Another CPU has emptied this runqueue in the meantime.
> > +        * Just return and leave the load_balance properly.
> > +        */
> > +       if (env->src_rq->nr_running <= 1 && !env->loop) {
> > +               /* Clear the flag as we will not test any task */
> > +               env->flags &= ~LBF_ALL_PINNED;
> > +               return 0;
> > +       }
> > +
> >         if (env->imbalance <= 0)
> >                 return 0;
> >
> >
> >> flag set, and triggers load_balance redo at the same sched_domain level.
> >>
> >> In order to find the new busiest sched_group and CPU, load balance will
> >> recompute and update the various load statistics, which eventually leads
> >> to the long-tail load balance cost.
> >>
> >> This patch introduces a variable(sched_nr_lb_redo) to limit load balance
> >> redo times, combined with sysctl_sched_nr_migrate, the max load balance
> >> cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
> >> 192 logical CPUs.
> >>
> >> Cc: Andi Kleen <ak@linux.intel.com>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >> ---
> >>  kernel/sched/fair.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ae7ceba..b59f371 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7407,6 +7407,8 @@ struct lb_env {
> >>         unsigned int            loop;
> >>         unsigned int            loop_break;
> >>         unsigned int            loop_max;
> >> +       unsigned int            redo_cnt;
> >> +       unsigned int            redo_max;
> >>
> >>         enum fbq_type           fbq_type;
> >>         enum migration_type     migration_type;
> >> @@ -9525,6 +9527,7 @@ static int should_we_balance(struct lb_env *env)
> >>         return group_balance_cpu(sg) == env->dst_cpu;
> >>  }
> >>
> >> +static const unsigned int sched_nr_lb_redo = 1;
> >>  /*
> >>   * Check this_cpu to ensure it is balanced within domain. Attempt to move
> >>   * tasks if there is an imbalance.
> >> @@ -9547,6 +9550,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >>                 .dst_grpmask    = sched_group_span(sd->groups),
> >>                 .idle           = idle,
> >>                 .loop_break     = sched_nr_migrate_break,
> >> +               .redo_max       = sched_nr_lb_redo,
> >>                 .cpus           = cpus,
> >>                 .fbq_type       = all,
> >>                 .tasks          = LIST_HEAD_INIT(env.tasks),
> >> @@ -9682,7 +9686,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >>                          * destination group that is receiving any migrated
> >>                          * load.
> >>                          */
> >> -                       if (!cpumask_subset(cpus, env.dst_grpmask)) {
> >> +                       if (!cpumask_subset(cpus, env.dst_grpmask) &&
> >> +                                       ++env.redo_cnt < env.redo_max) {
> >>                                 env.loop = 0;
> >>                                 env.loop_break = sched_nr_migrate_break;
> >>                                 goto redo;
> >> --
> >> 2.7.4
> >>
>
