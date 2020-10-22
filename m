Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E5B2961A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901430AbgJVPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901409AbgJVPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:25:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDFC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:25:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z17so1320365iog.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70THU4TZRmoYFB0ibR9HttXlB7FpxbWRg+B+M1aOdYs=;
        b=JR8NfS1utERJUS9kI7s9ryaDM+CalEXLGoXPcgl6Qhvf+XY16/rekWYFBTZjaiAqSC
         OTFNL7kkGfvcjiRyQ5+Stg72WLZMep9Zrm+F/FoG5lmjnvaqekSEanpHvnwy9qEwwhE4
         vVE3Fc87goaJ5B5drJlYbPKKOgRJM8fpu+OW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70THU4TZRmoYFB0ibR9HttXlB7FpxbWRg+B+M1aOdYs=;
        b=U2Hcoqce5X9B3OKUzzcGbsc9RToxwwnpLtSO47RPFviz3k+P9jDb5E21gzPtI+TX9g
         OAxG5YFucDPHIpoCCL9bHS15zFnsAU5hHV+o/bLP+sb6pVbv9uVsENsaGl1HcQ0pbPAc
         jsMcIQ6qArzqSQ0BeOw65E3oxnNypi1f/lPvG+Airs1gdC+9cxPkeYNmN4AwD9Ac0GIM
         iZG0h83NJJZ3QYbBSd6wsEycvDlUH0espXjPsQzZw4okg4/4T7Y2nBEWMOYdLDaf+GjD
         X0Rv/4Yj9PQD2JKcWofE/8YvFgnpV9UaMTtP5T7BwSC8J9EWIViRzm/q+BkVAKtaK0GR
         0l9g==
X-Gm-Message-State: AOAM530KLp6n37kPwcXihKK5tTohbkgLRkeicX1QwxD443IrB6b2vHUM
        /1v/db+P5RTVnLItW7UeH8DxYuGi2cJrAfwYaHWCYQ==
X-Google-Smtp-Source: ABdhPJw86C22X8AGAMZIwYGTKDGxLvMETPEAJQ0HTvTR2MZnakBZ+mkrPRLW25K7exVVHUYVWW6qPBF3wxn4P0xqVZ4=
X-Received: by 2002:a5e:9e02:: with SMTP id i2mr2239961ioq.154.1603380325321;
 Thu, 22 Oct 2020 08:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org> <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
In-Reply-To: <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 22 Oct 2020 08:25:14 -0700
Message-ID: <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:59 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Because sched_class::pick_next_task() also implies
> > sched_class::set_next_task() (and possibly put_prev_task() and
> > newidle_balance) it is not state invariant. This makes it unsuitable
> > for remote task selection.
> >
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> > Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/sched/deadline.c  | 16 ++++++++++++++--
> >  kernel/sched/fair.c      | 32 +++++++++++++++++++++++++++++++-
> >  kernel/sched/idle.c      |  8 ++++++++
> >  kernel/sched/rt.c        | 14 ++++++++++++--
> >  kernel/sched/sched.h     |  3 +++
> >  kernel/sched/stop_task.c | 13 +++++++++++--
> >  6 files changed, 79 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 814ec49502b1..0271a7848ab3 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1848,7 +1848,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
> >       return rb_entry(left, struct sched_dl_entity, rb_node);
> >  }
> >
> > -static struct task_struct *pick_next_task_dl(struct rq *rq)
> > +static struct task_struct *pick_task_dl(struct rq *rq)
> >  {
> >       struct sched_dl_entity *dl_se;
> >       struct dl_rq *dl_rq = &rq->dl;
> > @@ -1860,7 +1860,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
> >       dl_se = pick_next_dl_entity(rq, dl_rq);
> >       BUG_ON(!dl_se);
> >       p = dl_task_of(dl_se);
> > -     set_next_task_dl(rq, p, true);
> > +
> > +     return p;
> > +}
> > +
> > +static struct task_struct *pick_next_task_dl(struct rq *rq)
> > +{
> > +     struct task_struct *p;
> > +
> > +     p = pick_task_dl(rq);
> > +     if (p)
> > +             set_next_task_dl(rq, p, true);
> > +
> >       return p;
> >  }
> >
> > @@ -2517,6 +2528,7 @@ const struct sched_class dl_sched_class
> >
> >  #ifdef CONFIG_SMP
> >       .balance                = balance_dl,
> > +     .pick_task              = pick_task_dl,
> >       .select_task_rq         = select_task_rq_dl,
> >       .migrate_task_rq        = migrate_task_rq_dl,
> >       .set_cpus_allowed       = set_cpus_allowed_dl,
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index dbd9368a959d..bd6aed63f5e3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4450,7 +4450,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >        * Avoid running the skip buddy, if running something else can
> >        * be done without getting too unfair.
> >        */
> > -     if (cfs_rq->skip == se) {
> > +     if (cfs_rq->skip && cfs_rq->skip == se) {
> >               struct sched_entity *second;
> >
> >               if (se == curr) {
> > @@ -6976,6 +6976,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> >               set_last_buddy(se);
> >  }
> >
> > +#ifdef CONFIG_SMP
> > +static struct task_struct *pick_task_fair(struct rq *rq)
> > +{
> > +     struct cfs_rq *cfs_rq = &rq->cfs;
> > +     struct sched_entity *se;
> > +
> > +     if (!cfs_rq->nr_running)
> > +             return NULL;
> > +
> > +     do {
> > +             struct sched_entity *curr = cfs_rq->curr;
> > +
> > +             se = pick_next_entity(cfs_rq, NULL);
> > +
> > +             if (curr) {
> > +                     if (se && curr->on_rq)
> > +                             update_curr(cfs_rq);
> > +
> > +                     if (!se || entity_before(curr, se))
> > +                             se = curr;
> > +             }
> > +
> > +             cfs_rq = group_cfs_rq(se);
> > +     } while (cfs_rq);
> > ++
> > +     return task_of(se);
> > +}
> > +#endif
>
> One of my machines hangs when I run uperf with only one message:
> [  719.034962] BUG: kernel NULL pointer dereference, address: 0000000000000050
>
> Then I replicated the problem on my another machine(no serial console),
> here is the stack by manual copy.
>
> Call Trace:
>  pick_next_entity+0xb0/0x160
>  pick_task_fair+0x4b/0x90
>  __schedule+0x59b/0x12f0
>  schedule_idle+0x1e/0x40
>  do_idle+0x193/0x2d0
>  cpu_startup_entry+0x19/0x20
>  start_secondary+0x110/0x150
>  secondary_startup_64_no_verify+0xa6/0xab

Interesting. Wondering if we screwed something up in the rebase.

Questions:
1. Does the issue happen if you just apply only up until this patch,
or the entire series?
2. Do you see the issue in v7? Not much if at all has changed in this
part of the code from v7 -> v8 but could be something in the newer
kernel.

We tested this series after rebase heavily so it is indeed strange to
see this so late.

 - Joel


>
> > +
> >  struct task_struct *
> >  pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  {
> > @@ -11173,6 +11202,7 @@ const struct sched_class fair_sched_class
> >
> >  #ifdef CONFIG_SMP
> >       .balance                = balance_fair,
> > +     .pick_task              = pick_task_fair,
> >       .select_task_rq         = select_task_rq_fair,
> >       .migrate_task_rq        = migrate_task_rq_fair,
> >
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 8ce6e80352cf..ce7552c6bc65 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -405,6 +405,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
> >       schedstat_inc(rq->sched_goidle);
> >  }
> >
> > +#ifdef CONFIG_SMP
> > +static struct task_struct *pick_task_idle(struct rq *rq)
> > +{
> > +     return rq->idle;
> > +}
> > +#endif
> > +
> >  struct task_struct *pick_next_task_idle(struct rq *rq)
> >  {
> >       struct task_struct *next = rq->idle;
> > @@ -472,6 +479,7 @@ const struct sched_class idle_sched_class
> >
> >  #ifdef CONFIG_SMP
> >       .balance                = balance_idle,
> > +     .pick_task              = pick_task_idle,
> >       .select_task_rq         = select_task_rq_idle,
> >       .set_cpus_allowed       = set_cpus_allowed_common,
> >  #endif
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index e57fca05b660..a5851c775270 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1624,7 +1624,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
> >       return rt_task_of(rt_se);
> >  }
> >
> > -static struct task_struct *pick_next_task_rt(struct rq *rq)
> > +static struct task_struct *pick_task_rt(struct rq *rq)
> >  {
> >       struct task_struct *p;
> >
> > @@ -1632,7 +1632,16 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
> >               return NULL;
> >
> >       p = _pick_next_task_rt(rq);
> > -     set_next_task_rt(rq, p, true);
> > +
> > +     return p;
> > +}
> > +
> > +static struct task_struct *pick_next_task_rt(struct rq *rq)
> > +{
> > +     struct task_struct *p = pick_task_rt(rq);
> > +     if (p)
> > +             set_next_task_rt(rq, p, true);
> > +
> >       return p;
> >  }
> >
> > @@ -2443,6 +2452,7 @@ const struct sched_class rt_sched_class
> >
> >  #ifdef CONFIG_SMP
> >       .balance                = balance_rt,
> > +     .pick_task              = pick_task_rt,
> >       .select_task_rq         = select_task_rq_rt,
> >       .set_cpus_allowed       = set_cpus_allowed_common,
> >       .rq_online              = rq_online_rt,
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 587ebabebaff..54bfac702805 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1800,6 +1800,9 @@ struct sched_class {
> >
> >  #ifdef CONFIG_SMP
> >       int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
> > +
> > +     struct task_struct * (*pick_task)(struct rq *rq);
> > +
> >       int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
> >       void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
> >
> > diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> > index 394bc8126a1e..8f92915dd95e 100644
> > --- a/kernel/sched/stop_task.c
> > +++ b/kernel/sched/stop_task.c
> > @@ -34,15 +34,23 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
> >       stop->se.exec_start = rq_clock_task(rq);
> >  }
> >
> > -static struct task_struct *pick_next_task_stop(struct rq *rq)
> > +static struct task_struct *pick_task_stop(struct rq *rq)
> >  {
> >       if (!sched_stop_runnable(rq))
> >               return NULL;
> >
> > -     set_next_task_stop(rq, rq->stop, true);
> >       return rq->stop;
> >  }
> >
> > +static struct task_struct *pick_next_task_stop(struct rq *rq)
> > +{
> > +     struct task_struct *p = pick_task_stop(rq);
> > +     if (p)
> > +             set_next_task_stop(rq, p, true);
> > +
> > +     return p;
> > +}
> > +
> >  static void
> >  enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
> >  {
> > @@ -124,6 +132,7 @@ const struct sched_class stop_sched_class
> >
> >  #ifdef CONFIG_SMP
> >       .balance                = balance_stop,
> > +     .pick_task              = pick_task_stop,
> >       .select_task_rq         = select_task_rq_stop,
> >       .set_cpus_allowed       = set_cpus_allowed_common,
> >  #endif
> >
>
