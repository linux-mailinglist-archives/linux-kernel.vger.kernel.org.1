Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642F92C3B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKYIbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKYIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:31:46 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B71C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:31:45 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id z1so1394490ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZwCG4yhekGJzg4lLu9hGa+7NaSi539zu+QDigIV2yw=;
        b=HHp90d7EBFmbcuVXYjUjtEnBSo8A+zDfZJFb8DPDqSP03Dz9v1+acQ6zdgvzH35GfN
         ULwp1IZ0wZkGV63IHHLv508Fb+qyIsDAatnmeigatOhtxR+Qsp8ehz7KhT2hO6f7EkKn
         qXHC8JoIf3e2QlbMWFlN7ykTclzgK+lOp9FRZnl9Ro6VWLPHXhLJn13lT9rWOwCflXop
         raqBWtrjxY16urDd9X32rIaEANkptLposv6/QEpLL9JpgExiEH201srfnZtARUaQamGO
         ltzTD6V3MV1savXFLqTsNHi6xSMF+m48suW2u7tMZekK9Tti0aMRy7kIV1l14qoeYvvU
         dQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZwCG4yhekGJzg4lLu9hGa+7NaSi539zu+QDigIV2yw=;
        b=TtMDHJUfnWud5AhAVCYgLn6ZfSHjniPykezWwwOV+tXVbx1rBVTzCh0INvVZYAGCXG
         Cdw4wbqllEPPvMTByjOIDxEfCbs5TwkIysICPwZN+Dzp3zvZIfQddvsOOC4lKp/peShq
         8nBsZFEsXQdbpEQjAkD+OV1y38c9lf3dogdGDeTX8fPHGk5fOHma7P67lEZuRg8rh9Y4
         9TLPD1cYhfsmH8xQz4jirCv3VTfVf2wLovztIk81r2w3r5n33cAyqPvb6tMbeSgbwhPp
         Rku7fvie/GWMVLN0RGc05LxYkCMw04l6caA7uxVipUN/NkSJg16r7vpfX7kjIunYAr8q
         qaOw==
X-Gm-Message-State: AOAM532AmmDE9fWCtAKnXdTQRYUFLnlFqzow3hjhCDym5Pm+tf3D6u1h
        0LEXKas9vNdB/Rd/Jzy/mY2f0xs/dq6JzNGWzYxXUg==
X-Google-Smtp-Source: ABdhPJyQU7ignAe5D5UlrBdZAi9oKMhQBtOF2n/NgIP5vgq5zDDFQn1OT6zEgWdAV0RyoVTqTQS2sDPB/SGQr8a/R94=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr948523ljp.226.1606293103992;
 Wed, 25 Nov 2020 00:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
 <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com> <20201124170136.GA26613@vingu-book>
 <67a14568-4fa5-d9b4-d2fc-72a22c226189@linux.intel.com>
In-Reply-To: <67a14568-4fa5-d9b4-d2fc-72a22c226189@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 Nov 2020 09:31:32 +0100
Message-ID: <CAKfTPtB5=VSkE3YQf5igi6rBFPUSua=hM2FEnvBnRpF9n4VYwg@mail.gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
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

On Wed, 25 Nov 2020 at 03:03, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/11/25 1:01, Vincent Guittot wrote:
> > Hi Aubrey,
> >
> > Le mardi 24 nov. 2020 =C3=A0 15:01:38 (+0800), Li, Aubrey a =C3=A9crit =
:
> >> Hi Vincent,
> >>
> >> On 2020/11/23 17:27, Vincent Guittot wrote:
> >>> Hi Aubrey,
> >>>
> >>> On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.com> w=
rote:
> >>>>
> >>>> Add idle cpumask to track idle cpus in sched domain. When a CPU
> >>>> enters idle, if the idle driver indicates to stop tick, this CPU
> >>>> is set in the idle cpumask to be a wakeup target. And if the CPU
> >>>> is not in idle, the CPU is cleared in idle cpumask during scheduler
> >>>> tick to ratelimit idle cpumask update.
> >>>>
> >>>> When a task wakes up to select an idle cpu, scanning idle cpumask
> >>>> has low cost than scanning all the cpus in last level cache domain,
> >>>> especially when the system is heavily loaded.
> >>>>
> >>>> Benchmarks were tested on a x86 4 socket system with 24 cores per
> >>>> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
> >>>> schbench have no notable change, uperf has:
> >>>>
> >>>> uperf throughput: netperf workload, tcp_nodelay, r/w size =3D 90
> >>>>
> >>>>   threads       baseline-avg    %std    patch-avg       %std
> >>>>   96            1               0.83    1.23            3.27
> >>>>   144           1               1.03    1.67            2.67
> >>>>   192           1               0.69    1.81            3.59
> >>>>   240           1               2.84    1.51            2.67
> >>>>
> >>>> v4->v5:
> >>>> - add update_idle_cpumask for s2idle case
> >>>> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
> >>>>   idle_cpumask() everywhere
> >>>>
> >>>> v3->v4:
> >>>> - change setting idle cpumask from every idle entry to tickless idle
> >>>>   if cpu driver is available.
> >>>
> >>> Could you remind me why you did this change ? Clearing the cpumask is
> >>> done during the tick to rate limit the number of updates of the
> >>> cpumask but It's not clear for me why you have associated the set wit=
h
> >>> the tick stop condition too.
> >>
> >> I found the current implementation has better performance at a more
> >> suitable load range.
> >>
> >> The two kinds of implementions(v4 and v5) have the same rate(scheduler
> >> tick) to shrink idle cpumask when the system is busy, but
> >
> > I'm ok with the part above
> >
> >>
> >> - Setting the idle mask everytime the cpu enters idle requires a much
> >> heavier load level to preserve the idle cpumask(not call into idle),
> >> otherwise the bits cleared in scheduler tick will be restored when the
> >> cpu enters idle. That is, idle cpumask is almost equal to the domain
> >> cpumask during task wakeup if the system load is not heavy enough.
> >
> > But setting the idle cpumask is useful because it helps to select an id=
le
> > cpu at wake up instead of waiting ifor ILB to fill the empty CPU. IMO,
> > the idle cpu mask is useful in heavy cases because a system, which is
> > already fully busy with work, doesn't want to waste time looking for an
> > idle cpu that doesn't exist.
>
> Yes, this is what v3 does.
>
> > But if there is an idle cpu, we should still looks for it.
>
> IMHO, this is a potential opportunity can be improved. The idle cpu could=
 be
> in different idle state, the idle duration could be long or could be very=
 short.
> For example, if there are two idle cpus:
>
> - CPU1 is very busy, the pattern is 50us idle and 950us work.
> - CPU2 is in idle for a tick length and wake up to do the regular work
>
> If both added to the idle cpumask, we want the latter one, or we can just=
 add
> the later one into the idle cpumask. That's why I want to associate tick =
stop
> signal with it.
>
> >
> >>
> >>
> >> - Associating with tick stop tolerates idle to preserve the idle cpuma=
sk
> >> but only short idle, which causes tick retains. This is more fitable f=
or
> >> the real workload.
> >
> > I don't agree with this and real use cases with interaction will probab=
ly
> > not agree as well as they want to run on an idle cpu if any but not wai=
t
> > on an already busy one.
>
> The problem is scan overhead, scanning idle cpu need time. If an idle cpu
> is in the short idle mode, it's very likely that when it's picked up for =
a
> wakeup task, it goes back to work again, and the wakeup task has to wait =
too,
> maybe longer because the running task just starts.
>
> One benefit of waiting on the previous one is warm cache.
>
> > Also keep in mind that a tick can be up to 10ms long
>
> Right, but the point here is, if this 10ms tick retains, the CPU should b=
e
> in the short idle mode.

But 10, 4 or even 1ms is quite long for a system and that's even more
true compared to scanning the idle cpu mask

>
> >
> >>
> >>>
> >>> This change means that a cpu will not be part of the idle mask if the
> >>> tick is not stopped. On some arm/arm64 platforms, the tick stops only
> >>> if the idle duration is expected to be higher than 1-2ms which starts
> >>> to be significantly long. Also, the cpuidle governor can easily
> >>> mis-predict a short idle duration whereas it will be finally a long
> >>> idle duration; In this case, the next tick will correct the situation
> >>> and select a deeper state, but this can happen up to 4ms later on
> >>> arm/arm64.
> >>
> >> Yes this is intented. If the tick is not stopped, that indicates the
> >> CPU is very busy, cpu idle governor selected the polling idle state, a=
nd/or
> >> the expected idle duration is shorter than the tick period length. For
> >
> > As mentioned above a tick can be up to 10ms long which is not a short i=
dle
> > duration.
>
> Usually when the tick retains, the CPU is in the short idle mode or even =
polling
> instead of idle.

Also keep in mind that cpuidle can select a shallow state and retains
tick because of the wake up latency constraint and not the idle
duration. So you can't really make the assumption that retaining tick
means short idle duration

>
> >
> > Then the governor also mispredicts the idle duration and this is one
> > reason that the tick is not stopped because it will give the opportunit=
y
> > to reevaluate the idle state in case of misprediction.
> >
> We always predict the next state based on the past states, so mispredicti=
on
> does happen. This is not what this patch is trying to solve. I'm certainl=
y

My point here was to say that one original goal of cpuidle for
retaining the tick was to handle case where the governor mispredicts a
short idle time. Retaining the tick prevents the cpu to stay too long
in this shallow idle state and to waste power which seems to happen
often enough to be raised by people

> open if there is a better signal instead of stop_tick from idle governor.
>
>
> >> example, uperf enters and exits 80 times between two ticks when utiliz=
es
> >> 100% CPU, and the average idle residency < 50us.
> >
> > But scheduler looks for idle state of prev cpu before looping the idle =
cpu
> > mask so i'm not sure that uperf is impacted in this case because schedu=
ler
> > will select prev cpu before loop idle cpu mask.
> >
> >>
> >> If this CPU is added to idle cpumask, the wakeup task likely needs to
> >> wait in the runqueue as this CPU will run its current task very soon.
> >>
> >>>
> >>> So I would prefer to keep trying to set the idle mask everytime the
> >>> cpu enters idle. If a tick has not happened between 2 idle phases, th=
e
> >>> cpumask will not be updated and the overhead will be mostly testing i=
f
> >>> (rq->last_idle_state =3D=3D idle_state).
> >>
> >> Not sure if I addressed your concern, did you see any workloads any ca=
ses
> >> v4 performs better than v5?
> >
> > Yes, I see some perf regression on my octo arm64 system for hackbench w=
ith
> > only 1 group (and for few ther ones but it's less obvious). There is no
> > perf impact with more groups most probably because the cpus are no more=
 idle.
> >
> > The regression happens even if the shallowest idle state is the only on=
e to
> > be enabled.
>
> Thanks for the data.
>
> >
> > - 2 x 4 cores arm64 system
> >
> > 12 iterations of hackbench -l (256000/#grp) -g #grp
> >
> > Only the shallowest state enabled
>
> > (as a sidenote, we don't have polling mode on arm64)
> Okay, this might be the cause of the difference between yours and mine. S=
o do you
> think if it makes sense to let idle governor to return a polling flag and=
 associate
> it with idle cpumask update instead of stop_tick? A CPU is idle but actua=
lly polling
> may not be suitable for the wake up target.

I don't know much about polling but can't this mode be used up to a tick to=
o ?

>
> >
> > grp    tip/sched/core        + your patchset v5          + the change b=
elow
> > 1      1.296(+/- 2.06 %)     1.890(+/-35,10 %) -45%      1.311(+/- 2.63=
%) -1.19%
> > 4      1.249(+/- 2.67 %)     1.255(+/- 3.10 %) - 0.46 %  1.235(+/- 4.77=
%) -0.28%
> > 8      1.175(+/- 1.20 %)     1.180(+/- 2.33 %) - 0.47 %  1.179(+/- 1.60=
%) -0.38%
> > 16     1.213(+/- 1.10 %)     1.218(+/- 0.68 %) - 0.41 %  1.219(+/- 2.15=
%) -0.52%
> >
> > All idle states enabled (3 states)
> >
> > grp    tip/sched/core        + your patchset v5          + the change b=
elow
> > 1      1.429(+/-19.36 %)     1.678(+/-34.29 %) -17%      1.426(+/-17.18=
%) +0.21%
> > 4      1.244(+/- 3.04 %)     1.261(+/- 3.21 %) - 1.39 %  1.260(+/- 2.55=
%) -1.29%
> > 8      1.169(+/- 1.43 %)     1.183(+/- 2.09 %) - 1.23 %  1.198(+/- 2.49=
%) -2.51%
> > 16     1.219(+/- 1.23 %)     1.218(+/- 0.68 %) - 0.59 %  1.225(+/- 1.43=
%) -0.49%
> >
> > The change below is a bit different from your v3 because I wanted to ch=
eck if
> > the root cause was the set of cpuilde mask only when tick is stopped.
>
> Okay, I see your point.
>
> Thanks,
> -Aubrey
