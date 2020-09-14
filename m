Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B428926938B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgINR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgINM1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:27:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2884C061223
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:26:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y11so13210614lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAQrm5WJ2a3VMZBwhDL5oCbVPyFCBtJJYc3y7efawdM=;
        b=Qc9UIf5PuWxJre4k0QjlrxldJYrjBvJtj5GHe3b0axTFTGIXDW9CZwK06qsCJ6c4RN
         fJTCqzOsidn3eN8WZV8Wl7kK9zIzjJ+RJdGQ/aBZvB5osAVcTfpH20Y6RhASro25TKn1
         UpuykK9qp8RTA31TRF4MySWmBXWbPsMYX82Knoi+TDn2w6NG48W4lcDuB27HoyUre3VF
         sWuC8/4kjUszYEqmcXWwm0IafP0dmdRA1WVHnOZkq9EikdYsYkqAMW+PUQ3Acs4mhSII
         KQCla86xXURB4A4Whpe/rL9Q399QAF8V/PZPIEuuZQVWm/l+1hH9wsjljPAErHTjZpAS
         TVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAQrm5WJ2a3VMZBwhDL5oCbVPyFCBtJJYc3y7efawdM=;
        b=hKL3ducd04rS7XIPHasGAPbZGIsFC8NZJ5V/sLut7VN/lsDnz+Y4W9M+vVX2+YoDGH
         JcwKbJTe23y87cZkzRlPrr64Jygt+IO4yd5oSVI/keyp/lAjnIpHj3F4ReTN0x9wwKE9
         /GmPwAe+5m5fI/hFcMsv6hTzJ+5HP86fGFlLCDEStMi0QxsBVPwt843wE4caAF9cDVSX
         RFieYYxAFR9Vlk+/mDPLhH52k+FdgMw9cl/nsqvZJPmxzYFm7v+BD6JWZXJ4MeewrKw9
         76qmKLv116bHWfYidGlMX3A/yIt9PAIu7CnnU6AwMqEaUXs6CPpukFp945O5dyIxH9ob
         0QvQ==
X-Gm-Message-State: AOAM532hVBEPeP7U3d0IUpI9CgVpqzeSPrc9iEXUGjy5fDDUzybA84un
        oXzhPM0XwmC4p22S8tddF9PX+CsWaDSmrV5ITdqJzg==
X-Google-Smtp-Source: ABdhPJwn+pYaNfT/vcj1Fu74dgLLzSOH84xpl+hKWdoETIQkNHe4cUyVUU/8W6zhHF+T4g3tG3dy/IGcqIegEkxm//I=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr4179527lfl.573.1600086389160;
 Mon, 14 Sep 2020 05:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054203.525420-1-aubrey.li@intel.com> <20200910054203.525420-2-aubrey.li@intel.com>
 <CAPJCdBm+eyvY3ZUU0sz8WxRhdKquCApTCb1rv8DBDCnG8kS0PA@mail.gmail.com>
In-Reply-To: <CAPJCdBm+eyvY3ZUU0sz8WxRhdKquCApTCb1rv8DBDCnG8kS0PA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Sep 2020 14:26:18 +0200
Message-ID: <CAKfTPtBXxFC_FJHbnRafN3-6Fs=kJxMvGaStiKtp8T06p5Xr4A@mail.gmail.com>
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

On Sun, 13 Sep 2020 at 05:59, Jiang Biao <benbjiang@gmail.com> wrote:
>
> Hi, Aubrey
>
> On Fri, 11 Sep 2020 at 23:48, Aubrey Li <aubrey.li@intel.com> wrote:
> >
> > Added idle cpumask to track idle cpus in sched domain. When a CPU
> > enters idle, its corresponding bit in the idle cpumask will be set,
> > and when the CPU exits idle, its bit will be cleared.
> >
> > When a task wakes up to select an idle cpu, scanning idle cpumask
> > has low cost than scanning all the cpus in last level cache domain,
> > especially when the system is heavily loaded.
> >
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > ---
> >  include/linux/sched/topology.h | 13 +++++++++++++
> >  kernel/sched/fair.c            |  4 +++-
> >  kernel/sched/topology.c        |  2 +-
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index fb11091129b3..43a641d26154 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -65,8 +65,21 @@ struct sched_domain_shared {
> >         atomic_t        ref;
> >         atomic_t        nr_busy_cpus;
> >         int             has_idle_cores;
> > +       /*
> > +        * Span of all idle CPUs in this domain.
> > +        *
> > +        * NOTE: this field is variable length. (Allocated dynamically
> > +        * by attaching extra space to the end of the structure,
> > +        * depending on how many CPUs the kernel has booted up with)
> > +        */
> > +       unsigned long   idle_cpus_span[];
> >  };
> >
> > +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
> > +{
> > +       return to_cpumask(sds->idle_cpus_span);
> > +}
> > +
> >  struct sched_domain {
> >         /* These fields must be setup */
> >         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6b3b59cc51d6..3b6f8a3589be 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6136,7 +6136,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >
> >         time = cpu_clock(this);
> >
> > -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
> Is the sds_idle_cpus() always empty if nohz=off?

Good point

> Do we need to initialize the idle_cpus_span with sched_domain_span(sd)?
>
> >
> >         for_each_cpu_wrap(cpu, cpus, target) {
> >                 if (!--nr)
> > @@ -10182,6 +10182,7 @@ static void set_cpu_sd_state_busy(int cpu)
> >         sd->nohz_idle = 0;
> >
> >         atomic_inc(&sd->shared->nr_busy_cpus);
> > +       cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
> >  unlock:
> >         rcu_read_unlock();
> >  }
> > @@ -10212,6 +10213,7 @@ static void set_cpu_sd_state_idle(int cpu)
> >         sd->nohz_idle = 1;
> >
> >         atomic_dec(&sd->shared->nr_busy_cpus);
> > +       cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
> This only works when entering/exiting tickless mode? :)
> Why not update idle_cpus_span during tick_nohz_idle_enter()/exit()?

set_cpu_sd_state_busy is only called during a tick in order to limit
the rate of the update to once per tick per cpu at most and prevents
any kind of storm of update if short running tasks wake/sleep all the
time. We don't want to update a cpumask at each and every enter/leave
idle.

>
> Thx.
> Regards,
> Jiang
>
> >  unlock:
> >         rcu_read_unlock();
> >  }
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9079d865a935..92d0aeef86bf 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1769,7 +1769,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
> >
> >                         *per_cpu_ptr(sdd->sd, j) = sd;
> >
> > -                       sds = kzalloc_node(sizeof(struct sched_domain_shared),
> > +                       sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
> >                                         GFP_KERNEL, cpu_to_node(j));
> >                         if (!sds)
> >                                 return -ENOMEM;
> > --
> > 2.25.1
> >
