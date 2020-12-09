Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259692D42D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgLINKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbgLINKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:10:48 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:10:08 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f11so2242836ljm.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lnH6oING/Ma9wS8BgqOXAERcHOFMqzH4fkv/3OtKHlY=;
        b=AEfggzFfv9l9DTG0IEUIQOZaiaGBBhQwXqLWAu2Mqu8VXBTb7cuRggCVB/FqJK5ceo
         yItiOYMDv2UHikoJs1usQPYuemynqQ5UJjDndh1Xik8k2nowjYmx1GaIIFUbXfJwIxQI
         X7F3wuWf/bMIOcGM5PKUGJxCCpk9ks5dXJ2Xj5w50ZGJyHm2Zq+VH9IoJm5ZG/YT3zut
         3uweUQgISop9E3huld8Wf4Rp1tDcrejJvK6dEQgT3eR6yrSYW8y9B6nlT2243zk4+kAY
         A1+NDfWw9HUuKTxEir0/XAc3Y7pn6HVnjuI7MLiFO8Z9nrv2W8/4nR2hj28HdW6/W7Tt
         wTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnH6oING/Ma9wS8BgqOXAERcHOFMqzH4fkv/3OtKHlY=;
        b=Nk9IWt+shTr2NLFunnIkpWfJZUs4h6ReeEbMlXEihc+HIQrz/5d0DbGBiQGfEhDt/P
         wVOhBy+XFdMWXdwapWrhXe5ojm0JIdyJhrw2kr11T+a4j+WQSz4lIu5Xb+mD66nypQCv
         a8lVB5RlHwn/kAmVx43IPdsePhA4rYtdAICVkcPJX4VOg2HZgnirN28QF6xlrz2TF0g7
         fsqaiD3R7cww3J9Y69GdMR5M05P4jz+iNnJ9CYF5oUIl2eFVtfZ/rTDNrGYEWASBpx1U
         wxNUGoPRfnHIOQu/5Uu1JAMG+SmnXAnPXOQpdCTZXCw94wBoduIlshr+SFQuH+Q8/AvB
         3hOw==
X-Gm-Message-State: AOAM531TcEtrgd5XvsBbl4++HVXq77gfMdl1ifyq8uGxatnX4iX10zyD
        tSyVIDtL/Pg7bBKrrpite8kFL0rl0rvioiXBIH5psg==
X-Google-Smtp-Source: ABdhPJzvtt7WR0Tg+BlKmA5uO4bdSVGOSWU2Mg8DE7QFs4h7sTYimTnDQnlHkaaYZ20K6RroDScAcM+136kxJTlUmBI=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr992143ljk.299.1607519406846;
 Wed, 09 Dec 2020 05:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209081541.GA5071@vingu-book> <1e68b6fe-2f22-2fbd-3f6b-645994854918@linux.intel.com>
In-Reply-To: <1e68b6fe-2f22-2fbd-3f6b-645994854918@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Dec 2020 14:09:55 +0100
Message-ID: <CAKfTPtBTeRtqV-xTt2MtVj5mogx7Gz81dmmGvBD3CnAhg2kzQA@mail.gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 at 11:58, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/12/9 16:15, Vincent Guittot wrote:
> > Le mercredi 09 d=C3=A9c. 2020 =C3=A0 14:24:04 (+0800), Aubrey Li a =C3=
=A9crit :
> >> Add idle cpumask to track idle cpus in sched domain. Every time
> >> a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
> >> target. And if the CPU is not in idle, the CPU is cleared in idle
> >> cpumask during scheduler tick to ratelimit idle cpumask update.
> >>
> >> When a task wakes up to select an idle cpu, scanning idle cpumask
> >> has lower cost than scanning all the cpus in last level cache domain,
> >> especially when the system is heavily loaded.
> >>
> >> Benchmarks including hackbench, schbench, uperf, sysbench mysql
> >> and kbuild were tested on a x86 4 socket system with 24 cores per
> >> socket and 2 hyperthreads per core, total 192 CPUs, no regression
> >> found.
> >>
> >> v6->v7:
> >> - place the whole idle cpumask mechanism under CONFIG_SMP.
> >>
> >> v5->v6:
> >> - decouple idle cpumask update from stop_tick signal, set idle CPU
> >>   in idle cpumask every time the CPU enters idle
> >>
> >> v4->v5:
> >> - add update_idle_cpumask for s2idle case
> >> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
> >>   idle_cpumask() everywhere
> >>
> >> v3->v4:
> >> - change setting idle cpumask from every idle entry to tickless idle
> >>   if cpu driver is available.
> >> - move clearing idle cpumask to scheduler_tick to decouple nohz mode.
> >>
> >> v2->v3:
> >> - change setting idle cpumask to every idle entry, otherwise schbench
> >>   has a regression of 99th percentile latency.
> >> - change clearing idle cpumask to nohz_balancer_kick(), so updating
> >>   idle cpumask is ratelimited in the idle exiting path.
> >> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
> >>
> >> v1->v2:
> >> - idle cpumask is updated in the nohz routines, by initializing idle
> >>   cpumask with sched_domain_span(sd), nohz=3Doff case remains the orig=
inal
> >>   behavior.
> >>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Mel Gorman <mgorman@suse.de>
> >> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> Cc: Qais Yousef <qais.yousef@arm.com>
> >> Cc: Valentin Schneider <valentin.schneider@arm.com>
> >> Cc: Jiang Biao <benbjiang@gmail.com>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >> ---
> >>  include/linux/sched/topology.h | 13 +++++++++
> >>  kernel/sched/core.c            |  2 ++
> >>  kernel/sched/fair.c            | 51 +++++++++++++++++++++++++++++++++=
-
> >>  kernel/sched/idle.c            |  5 ++++
> >>  kernel/sched/sched.h           |  4 +++
> >>  kernel/sched/topology.c        |  3 +-
> >>  6 files changed, 76 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topo=
logy.h
> >> index 820511289857..b47b85163607 100644
> >> --- a/include/linux/sched/topology.h
> >> +++ b/include/linux/sched/topology.h
> >> @@ -65,8 +65,21 @@ struct sched_domain_shared {
> >>      atomic_t        ref;
> >>      atomic_t        nr_busy_cpus;
> >>      int             has_idle_cores;
> >> +    /*
> >> +     * Span of all idle CPUs in this domain.
> >> +     *
> >> +     * NOTE: this field is variable length. (Allocated dynamically
> >> +     * by attaching extra space to the end of the structure,
> >> +     * depending on how many CPUs the kernel has booted up with)
> >> +     */
> >> +    unsigned long   idle_cpus_span[];
> >>  };
> >>
> >> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_share=
d *sds)
> >> +{
> >> +    return to_cpumask(sds->idle_cpus_span);
> >> +}
> >> +
> >>  struct sched_domain {
> >>      /* These fields must be setup */
> >>      struct sched_domain __rcu *parent;      /* top domain must be nul=
l terminated */
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index c4da7e17b906..c4c51ff3402a 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -4011,6 +4011,7 @@ void scheduler_tick(void)
> >>
> >>  #ifdef CONFIG_SMP
> >>      rq->idle_balance =3D idle_cpu(cpu);
> >> +    update_idle_cpumask(cpu, false);
> >
> > Test rq->idle_balance here instead of adding the test in update_idle_cp=
umask which is only
> > relevant for this situation.
>
> If called from idle path, because !set_idle is false, rq->idle_balance wo=
n't be tested actually.
>
>         if (!set_idle && rq->idle_balance)
>                 return;
>
> So is it okay to leave it here to keep scheduler_tick a bit concise?

I don't like having a tick specific condition in a generic function.
rq->idle_balance is only relevant in this case

calling update_idle_cpumask(rq->idle_balance) in scheduler_tick()
should do the job and we can remove the check of rq->idle_balance in
update_idle_cpumask()

In case of scheduler_tick() called when idle , we will only test if
(rq->last_idle_state =3D=3D idle_state) and return

>
> Thanks,
> -Aubrey
