Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897A26A13E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIOIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:47:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:47:36 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so2509898otl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Yfa8IaRytirvlZdPRBnAFZNzJIo2nBRnzRDZx5BGS4=;
        b=TwA1XU4bV1+wP4rAOCGZrkptnqD41aw+j/rN4qv+d7zunxk7GHEsadfabKGPJX7xNg
         Bq9VGeMytYxBAYgCnHu1cMPlz5y/4mwb+QbKpyn/CTTWS/sCmy4LHeezzFmqCWmtmjpb
         NcxzCLHkOP7BaVKwrWVjE1ZMzXcfA3VKNwZecqgHLKgh9t7zxADMUJYxHlgmHPgf8JTd
         TW4PX+2PbgEomIMsXb/Wk/AySbAvwQ9j3ameNuJKvY0KtSMPuriXUcVNIPhQuywO3LN0
         ALQi2ihbXYgjXgbBtNm6HzzNwbGE8RkPhfZnBtI8nK0aO8bDa6oclJ7/PnEYpEFCuj5n
         fCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Yfa8IaRytirvlZdPRBnAFZNzJIo2nBRnzRDZx5BGS4=;
        b=fXd8Y9uM+rAh0qSX5JeEPKAAfKNtj5iAKcqjJeXa92lI6nw2QD11cnJEopc7aZL3cF
         oVMCVFUZ5a/WARWsrC/QIwZ/IVZ5lSFHKE5XVw9ictizuAi0fLJAe1BHyxNH5bpkaWyv
         nV/lqxQlyc7oSnXcm5+MMx6ICKvXKF6giko3Vz9Wbtv+N6zF3a8hfH5FtRpusOIfYc9s
         V9yWQ/9vYXXmjtoVvutZvMt29aSOrsTSxD8Ofdlz/WHg35UtCg8iLmgIQq9rGUgXWN0I
         v2YDxeYnvk+By2V91Q/vngc/N8oX+uTZ6p29R7OCE3CzkNGOkUSSdskiq3ati1lOUbjS
         vVJg==
X-Gm-Message-State: AOAM5320YB7NUV8CuoyHFlVQxYb9SiM9bfapCd0rZHj+sL5nziLKtYY9
        mVQfDzjNw/++rmyVVeMlZ7HlQKbd1EFJf3mvgclegPIrHkA=
X-Google-Smtp-Source: ABdhPJxVllvpF+GQ6K+vp8ubxonn2ftxW/eArkKLweXZFKcj0q8mDYYWZrUHrzb0WdBDGmrFMV1TZRlpPDxz5fj6w1g=
X-Received: by 2002:a9d:758c:: with SMTP id s12mr11474340otk.237.1600159655792;
 Tue, 15 Sep 2020 01:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com>
 <CAPJCdBm+eyvY3ZUU0sz8WxRhdKquCApTCb1rv8DBDCnG8kS0PA@mail.gmail.com> <CAKfTPtBXxFC_FJHbnRafN3-6Fs=kJxMvGaStiKtp8T06p5Xr4A@mail.gmail.com>
In-Reply-To: <CAKfTPtBXxFC_FJHbnRafN3-6Fs=kJxMvGaStiKtp8T06p5Xr4A@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 15 Sep 2020 16:47:24 +0800
Message-ID: <CAPJCdBn8GPM5ur6i90Lo1T95BPNAvCPASQdSTpOn_kjUxEi3LA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vincent

On Mon, 14 Sep 2020 at 20:26, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sun, 13 Sep 2020 at 05:59, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > Hi, Aubrey
> >
> > On Fri, 11 Sep 2020 at 23:48, Aubrey Li <aubrey.li@intel.com> wrote:
> > >
> > > Added idle cpumask to track idle cpus in sched domain. When a CPU
> > > enters idle, its corresponding bit in the idle cpumask will be set,
> > > and when the CPU exits idle, its bit will be cleared.
> > >
> > > When a task wakes up to select an idle cpu, scanning idle cpumask
> > > has low cost than scanning all the cpus in last level cache domain,
> > > especially when the system is heavily loaded.
> > >
> > > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > > ---
> > >  include/linux/sched/topology.h | 13 +++++++++++++
> > >  kernel/sched/fair.c            |  4 +++-
> > >  kernel/sched/topology.c        |  2 +-
> > >  3 files changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > index fb11091129b3..43a641d26154 100644
> > > --- a/include/linux/sched/topology.h
> > > +++ b/include/linux/sched/topology.h
> > > @@ -65,8 +65,21 @@ struct sched_domain_shared {
> > >         atomic_t        ref;
> > >         atomic_t        nr_busy_cpus;
> > >         int             has_idle_cores;
> > > +       /*
> > > +        * Span of all idle CPUs in this domain.
> > > +        *
> > > +        * NOTE: this field is variable length. (Allocated dynamically
> > > +        * by attaching extra space to the end of the structure,
> > > +        * depending on how many CPUs the kernel has booted up with)
> > > +        */
> > > +       unsigned long   idle_cpus_span[];
> > >  };
> > >
> > > +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> > > +{
> > > +       return to_cpumask(sds->idle_cpus_span);
> > > +}
> > > +
> > >  struct sched_domain {
> > >         /* These fields must be setup */
> > >         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6b3b59cc51d6..3b6f8a3589be 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6136,7 +6136,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > >
> > >         time = cpu_clock(this);
> > >
> > > -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
> > Is the sds_idle_cpus() always empty if nohz=off?
>
> Good point
>
> > Do we need to initialize the idle_cpus_span with sched_domain_span(sd)?
> >
> > >
> > >         for_each_cpu_wrap(cpu, cpus, target) {
> > >                 if (!--nr)
> > > @@ -10182,6 +10182,7 @@ static void set_cpu_sd_state_busy(int cpu)
> > >         sd->nohz_idle = 0;
> > >
> > >         atomic_inc(&sd->shared->nr_busy_cpus);
> > > +       cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> > >  unlock:
> > >         rcu_read_unlock();
> > >  }
> > > @@ -10212,6 +10213,7 @@ static void set_cpu_sd_state_idle(int cpu)
> > >         sd->nohz_idle = 1;
> > >
> > >         atomic_dec(&sd->shared->nr_busy_cpus);
> > > +       cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> > This only works when entering/exiting tickless mode? :)
> > Why not update idle_cpus_span during tick_nohz_idle_enter()/exit()?
>
> set_cpu_sd_state_busy is only called during a tick in order to limit
> the rate of the update to once per tick per cpu at most and prevents
> any kind of storm of update if short running tasks wake/sleep all the
> time. We don't want to update a cpumask at each and every enter/leave
> idle.
>
Agree. But set_cpu_sd_state_busy seems not being reached when
nohz=off, which means it will not work for that case? :)

Thx.
Regards,
Jiang
