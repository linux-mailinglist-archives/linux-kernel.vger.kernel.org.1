Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497B226A215
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIOJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:23:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:23:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so2208840ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WguCNlLpelWafmwLTChApST+4Bv1AaYq8IwRwCvrSE=;
        b=nFt4vJvdjD/zCoYSTAQypSARFQJxbHU4TweR30z63obLu4UE9NImur/S7CsCDAOwBr
         MfZZ67Fh+RpdIR69GuevCxPAQOcQAqLeysBI1Tt4SwDEkZ9X0AqW74ZxtjWqLGZMRGD0
         +akBmDeJ2RNch37tHydfteq6EdQc/fn0iDtzWBuzHveLZgAD2VUQSb5c9wO7FOXwZ7rj
         bPVuF4lGBlzwBKpk3sZhEqCMas/kdkkqiUBgW+z2XmHF87/UExEmXHsBocB1UYc2qdck
         4XANvngGBmS5mYqRcbPq/uDuTeyiCKSBEvc+ErfHWIeMNSoLcZFLP3nVgJOIkZNp8M2s
         v1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WguCNlLpelWafmwLTChApST+4Bv1AaYq8IwRwCvrSE=;
        b=WifspNWUYCPaJfxiOxcmXGmbLfVBhMHOsc1j5zgEahYUT8Zz9UPyZTK7MRr5im+Kkf
         DsBpP7RSEjHKD8+m9NJfKLMzKFmcrV+585TDVbGXH6VqzSXcShEdKeMAResw4vJ4NjUK
         a2CjeeS9GKryqt8zwCgy80Xl+CyVFAhKr8R5MUI9jLsy2Fk4P2IKlFBmGACuMhmP2MAz
         MLp6+Yx93NMgwLVuX8ZASJ72IN4ZyfE3UJLMbRy6dDcy5fk113lvnK73eORg7SRG9nC/
         hroY5taKPNgtjRcf1bINk5M7KFh8TCQGRShDgWo6/14g9TY/CTjEHgCm7YJCXH30LunY
         laUw==
X-Gm-Message-State: AOAM531yfTw0ff3uGOlNIUpqDF8tZuzoV8a/VZK7u/sUFFmQD2uN1KIH
        QbUR1b9mKXMA0DlLtNNoCeIdiMZuGEDSHOuD+ffKYA==
X-Google-Smtp-Source: ABdhPJybGCiso9LQX8NIGS/0VphCmbX/DY4cNGC4O+62jepf6gGwVgEklspZ/tBq42NDlYN2aujwkx8nbj8KS5/o0ag=
X-Received: by 2002:a2e:989a:: with SMTP id b26mr5005518ljj.111.1600161828787;
 Tue, 15 Sep 2020 02:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com>
 <CAPJCdBm+eyvY3ZUU0sz8WxRhdKquCApTCb1rv8DBDCnG8kS0PA@mail.gmail.com>
 <CAKfTPtBXxFC_FJHbnRafN3-6Fs=kJxMvGaStiKtp8T06p5Xr4A@mail.gmail.com> <CAPJCdBn8GPM5ur6i90Lo1T95BPNAvCPASQdSTpOn_kjUxEi3LA@mail.gmail.com>
In-Reply-To: <CAPJCdBn8GPM5ur6i90Lo1T95BPNAvCPASQdSTpOn_kjUxEi3LA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Sep 2020 11:23:37 +0200
Message-ID: <CAKfTPtC1DQOCmQRJYPO4zH99Nw622zx__a-4TKAJNHJJfLpvKg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
To:     Jiang Biao <benbjiang@gmail.com>
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

On Tue, 15 Sep 2020 at 10:47, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Vincent
>
> On Mon, 14 Sep 2020 at 20:26, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Sun, 13 Sep 2020 at 05:59, Jiang Biao <benbjiang@gmail.com> wrote:
> > >
> > > Hi, Aubrey
> > >
> > > On Fri, 11 Sep 2020 at 23:48, Aubrey Li <aubrey.li@intel.com> wrote:
> > > >
> > > > Added idle cpumask to track idle cpus in sched domain. When a CPU
> > > > enters idle, its corresponding bit in the idle cpumask will be set,
> > > > and when the CPU exits idle, its bit will be cleared.
> > > >
> > > > When a task wakes up to select an idle cpu, scanning idle cpumask
> > > > has low cost than scanning all the cpus in last level cache domain,
> > > > especially when the system is heavily loaded.
> > > >
> > > > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > > > ---
> > > >  include/linux/sched/topology.h | 13 +++++++++++++
> > > >  kernel/sched/fair.c            |  4 +++-
> > > >  kernel/sched/topology.c        |  2 +-
> > > >  3 files changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > > index fb11091129b3..43a641d26154 100644
> > > > --- a/include/linux/sched/topology.h
> > > > +++ b/include/linux/sched/topology.h
> > > > @@ -65,8 +65,21 @@ struct sched_domain_shared {
> > > >         atomic_t        ref;
> > > >         atomic_t        nr_busy_cpus;
> > > >         int             has_idle_cores;
> > > > +       /*
> > > > +        * Span of all idle CPUs in this domain.
> > > > +        *
> > > > +        * NOTE: this field is variable length. (Allocated dynamically
> > > > +        * by attaching extra space to the end of the structure,
> > > > +        * depending on how many CPUs the kernel has booted up with)
> > > > +        */
> > > > +       unsigned long   idle_cpus_span[];
> > > >  };
> > > >
> > > > +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> > > > +{
> > > > +       return to_cpumask(sds->idle_cpus_span);
> > > > +}
> > > > +
> > > >  struct sched_domain {
> > > >         /* These fields must be setup */
> > > >         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 6b3b59cc51d6..3b6f8a3589be 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -6136,7 +6136,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > > >
> > > >         time = cpu_clock(this);
> > > >
> > > > -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > > > +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
> > > Is the sds_idle_cpus() always empty if nohz=off?
> >
> > Good point
> >
> > > Do we need to initialize the idle_cpus_span with sched_domain_span(sd)?
> > >
> > > >
> > > >         for_each_cpu_wrap(cpu, cpus, target) {
> > > >                 if (!--nr)
> > > > @@ -10182,6 +10182,7 @@ static void set_cpu_sd_state_busy(int cpu)
> > > >         sd->nohz_idle = 0;
> > > >
> > > >         atomic_inc(&sd->shared->nr_busy_cpus);
> > > > +       cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> > > >  unlock:
> > > >         rcu_read_unlock();
> > > >  }
> > > > @@ -10212,6 +10213,7 @@ static void set_cpu_sd_state_idle(int cpu)
> > > >         sd->nohz_idle = 1;
> > > >
> > > >         atomic_dec(&sd->shared->nr_busy_cpus);
> > > > +       cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> > > This only works when entering/exiting tickless mode? :)
> > > Why not update idle_cpus_span during tick_nohz_idle_enter()/exit()?
> >
> > set_cpu_sd_state_busy is only called during a tick in order to limit
> > the rate of the update to once per tick per cpu at most and prevents
> > any kind of storm of update if short running tasks wake/sleep all the
> > time. We don't want to update a cpumask at each and every enter/leave
> > idle.
> >
> Agree. But set_cpu_sd_state_busy seems not being reached when
> nohz=off, which means it will not work for that case? :)

Yes set_cpu_sd_state_idle/busy are nohz function
>
> Thx.
> Regards,
> Jiang
