Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E032C500C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbgKZIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgKZIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:15:05 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:15:03 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so1207976lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iXEX2HSeD8DyGMXzHCSB2Gx3hV/XABz2dWOLT9VbyQo=;
        b=u2eH1cDjBN4Hwr5hFQ6uA4xRQJjs0eAWIdWEAoMZHlrpffAMnUjQ7aEPLpV1v8hSAd
         SRYKJeN6KuTJqbPqCYgwfPmnUV2/IQNHBorT4L4ekt8k8m37/GODuH4vmHsQsoIZUXmb
         c+iI6MOzrQE4dsPDm6cdDAoDZ8SKlmiPLX90rAzeJ4LcjQbLfU/sx0FSdwo8XUVX8n+g
         uMPHh5V51r2pqtGdediOjvsZjyKGuWC4vwHTcSCXyGr2J8czFspqVFiOe/g+IQCi8uC4
         3rC1jET85VtiNTcdTPqsPNxAWEFDH6rm7LZ3LHw6QYX2htBB5hvqnVGB+UGKoUfPHUSW
         LOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iXEX2HSeD8DyGMXzHCSB2Gx3hV/XABz2dWOLT9VbyQo=;
        b=CPF0vyr/4uxIDeDRFyqYEeg9MFBguweUFbSsI3MV3lsoZOtVWLFMGywIE6+FR4ixU7
         BOgz7VC2uYQh0AsN8EKKWeCi5XT42VCWeSTIiL39lXw+v6c5IfYkOxZ675oml1Q9jxil
         2gsBIVWjbF8e0jKhD4EyWRC/56Af49B1IgPGqQWa6nmi+U6I9yaMPtYfIjJHITQnb0p1
         o98EEZSMHPR6wwnmjOxcKtGwcElC1k6NvhC1s0A4+CBcOg/rVfm5h4YrTtyk7WSbeu/+
         wUCrkBY6Dp0NgZdYCeJHYvJaNTrQeDsbKQibQvi16kjH7PqL1qRV0RgOaxRftl+0JOUT
         Ul2g==
X-Gm-Message-State: AOAM530uKze3Rd5Gv5wZAy2Z/Yo9us8fs5NnCl3h1Tuqw0siXNTxVNE2
        KzYAoYPhFK1cIXnpYlKv2/abXqYOGp5DVLgvAKBnZA==
X-Google-Smtp-Source: ABdhPJwSCngBgcIq6nYbivLvSAp9hDHqh9CdEb5vyXauTRcamQgHI+odGDFv4BrcjY1KG9T9Hb9kZ2ix6oQ+pMWfwGg=
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr859710lfl.385.1606378501894;
 Thu, 26 Nov 2020 00:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
 <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com> <20201124170136.GA26613@vingu-book>
 <67a14568-4fa5-d9b4-d2fc-72a22c226189@linux.intel.com> <CAKfTPtB5=VSkE3YQf5igi6rBFPUSua=hM2FEnvBnRpF9n4VYwg@mail.gmail.com>
 <2a715c5d-c93f-0e5f-8b1a-83803cb6def6@linux.intel.com>
In-Reply-To: <2a715c5d-c93f-0e5f-8b1a-83803cb6def6@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Nov 2020 09:14:50 +0100
Message-ID: <CAKfTPtB2FG64Csi0VBG-rZVr-KQ9x+WccFiWaXPVFremSHbcJw@mail.gmail.com>
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

On Wed, 25 Nov 2020 at 14:37, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/11/25 16:31, Vincent Guittot wrote:
> > On Wed, 25 Nov 2020 at 03:03, Li, Aubrey <aubrey.li@linux.intel.com> wr=
ote:
> >>
> >> On 2020/11/25 1:01, Vincent Guittot wrote:
> >>> Hi Aubrey,
> >>>
> >>> Le mardi 24 nov. 2020 =C3=A0 15:01:38 (+0800), Li, Aubrey a =C3=A9cri=
t :
> >>>> Hi Vincent,
> >>>>
> >>>> On 2020/11/23 17:27, Vincent Guittot wrote:
> >>>>> Hi Aubrey,
> >>>>>
> >>>>> On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.com>=
 wrote:
> >>>>>>
> >>>>>> Add idle cpumask to track idle cpus in sched domain. When a CPU
> >>>>>> enters idle, if the idle driver indicates to stop tick, this CPU
> >>>>>> is set in the idle cpumask to be a wakeup target. And if the CPU
> >>>>>> is not in idle, the CPU is cleared in idle cpumask during schedule=
r
> >>>>>> tick to ratelimit idle cpumask update.
> >>>>>>
> >>>>>> When a task wakes up to select an idle cpu, scanning idle cpumask
> >>>>>> has low cost than scanning all the cpus in last level cache domain=
,
> >>>>>> especially when the system is heavily loaded.
> >>>>>>
> >>>>>> Benchmarks were tested on a x86 4 socket system with 24 cores per
> >>>>>> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
> >>>>>> schbench have no notable change, uperf has:
> >>>>>>
> >>>>>> uperf throughput: netperf workload, tcp_nodelay, r/w size =3D 90
> >>>>>>
> >>>>>>   threads       baseline-avg    %std    patch-avg       %std
> >>>>>>   96            1               0.83    1.23            3.27
> >>>>>>   144           1               1.03    1.67            2.67
> >>>>>>   192           1               0.69    1.81            3.59
> >>>>>>   240           1               2.84    1.51            2.67
> >>>>>>
> >>>>>> v4->v5:
> >>>>>> - add update_idle_cpumask for s2idle case
> >>>>>> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
> >>>>>>   idle_cpumask() everywhere
> >>>>>>
> >>>>>> v3->v4:
> >>>>>> - change setting idle cpumask from every idle entry to tickless id=
le
> >>>>>>   if cpu driver is available.
> >>>>>
> >>>>> Could you remind me why you did this change ? Clearing the cpumask =
is
> >>>>> done during the tick to rate limit the number of updates of the
> >>>>> cpumask but It's not clear for me why you have associated the set w=
ith
> >>>>> the tick stop condition too.
> >>>>
> >>>> I found the current implementation has better performance at a more
> >>>> suitable load range.
> >>>>
> >>>> The two kinds of implementions(v4 and v5) have the same rate(schedul=
er
> >>>> tick) to shrink idle cpumask when the system is busy, but
> >>>
> >>> I'm ok with the part above
> >>>
> >>>>
> >>>> - Setting the idle mask everytime the cpu enters idle requires a muc=
h
> >>>> heavier load level to preserve the idle cpumask(not call into idle),
> >>>> otherwise the bits cleared in scheduler tick will be restored when t=
he
> >>>> cpu enters idle. That is, idle cpumask is almost equal to the domain
> >>>> cpumask during task wakeup if the system load is not heavy enough.
> >>>
> >>> But setting the idle cpumask is useful because it helps to select an =
idle
> >>> cpu at wake up instead of waiting ifor ILB to fill the empty CPU. IMO=
,
> >>> the idle cpu mask is useful in heavy cases because a system, which is
> >>> already fully busy with work, doesn't want to waste time looking for =
an
> >>> idle cpu that doesn't exist.
> >>
> >> Yes, this is what v3 does.
> >>
> >>> But if there is an idle cpu, we should still looks for it.
> >>
> >> IMHO, this is a potential opportunity can be improved. The idle cpu co=
uld be
> >> in different idle state, the idle duration could be long or could be v=
ery short.
> >> For example, if there are two idle cpus:
> >>
> >> - CPU1 is very busy, the pattern is 50us idle and 950us work.
> >> - CPU2 is in idle for a tick length and wake up to do the regular work
> >>
> >> If both added to the idle cpumask, we want the latter one, or we can j=
ust add
> >> the later one into the idle cpumask. That's why I want to associate ti=
ck stop
> >> signal with it.
> >>
> >>>
> >>>>
> >>>>
> >>>> - Associating with tick stop tolerates idle to preserve the idle cpu=
mask
> >>>> but only short idle, which causes tick retains. This is more fitable=
 for
> >>>> the real workload.
> >>>
> >>> I don't agree with this and real use cases with interaction will prob=
ably
> >>> not agree as well as they want to run on an idle cpu if any but not w=
ait
> >>> on an already busy one.
> >>
> >> The problem is scan overhead, scanning idle cpu need time. If an idle =
cpu
> >> is in the short idle mode, it's very likely that when it's picked up f=
or a
> >> wakeup task, it goes back to work again, and the wakeup task has to wa=
it too,
> >> maybe longer because the running task just starts.
> >>
> >> One benefit of waiting on the previous one is warm cache.
> >>
> >>> Also keep in mind that a tick can be up to 10ms long
> >>
> >> Right, but the point here is, if this 10ms tick retains, the CPU shoul=
d be
> >> in the short idle mode.
> >
> > But 10, 4 or even 1ms is quite long for a system and that's even more
> > true compared to scanning the idle cpu mask
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> This change means that a cpu will not be part of the idle mask if t=
he
> >>>>> tick is not stopped. On some arm/arm64 platforms, the tick stops on=
ly
> >>>>> if the idle duration is expected to be higher than 1-2ms which star=
ts
> >>>>> to be significantly long. Also, the cpuidle governor can easily
> >>>>> mis-predict a short idle duration whereas it will be finally a long
> >>>>> idle duration; In this case, the next tick will correct the situati=
on
> >>>>> and select a deeper state, but this can happen up to 4ms later on
> >>>>> arm/arm64.
> >>>>
> >>>> Yes this is intented. If the tick is not stopped, that indicates the
> >>>> CPU is very busy, cpu idle governor selected the polling idle state,=
 and/or
> >>>> the expected idle duration is shorter than the tick period length. F=
or
> >>>
> >>> As mentioned above a tick can be up to 10ms long which is not a short=
 idle
> >>> duration.
> >>
> >> Usually when the tick retains, the CPU is in the short idle mode or ev=
en polling
> >> instead of idle.
> >
> > Also keep in mind that cpuidle can select a shallow state and retains
> > tick because of the wake up latency constraint and not the idle
> > duration. So you can't really make the assumption that retaining tick
> > means short idle duration
> >
> idle governor has short idle information, probably can let idle governor
> expose a short idle indicator?
>
> >>
> >>>
> >>> Then the governor also mispredicts the idle duration and this is one
> >>> reason that the tick is not stopped because it will give the opportun=
ity
> >>> to reevaluate the idle state in case of misprediction.
> >>>
> >> We always predict the next state based on the past states, so mispredi=
ction
> >> does happen. This is not what this patch is trying to solve. I'm certa=
inly
> >
> > My point here was to say that one original goal of cpuidle for
> > retaining the tick was to handle case where the governor mispredicts a
> > short idle time. Retaining the tick prevents the cpu to stay too long
> > in this shallow idle state and to waste power which seems to happen
> > often enough to be raised by people
>
> I see, thanks!
>
> >
> >> open if there is a better signal instead of stop_tick from idle govern=
or.
> >>
> >>
> >>>> example, uperf enters and exits 80 times between two ticks when util=
izes
> >>>> 100% CPU, and the average idle residency < 50us.
> >>>
> >>> But scheduler looks for idle state of prev cpu before looping the idl=
e cpu
> >>> mask so i'm not sure that uperf is impacted in this case because sche=
duler
> >>> will select prev cpu before loop idle cpu mask.
> >>>
> >>>>
> >>>> If this CPU is added to idle cpumask, the wakeup task likely needs t=
o
> >>>> wait in the runqueue as this CPU will run its current task very soon=
.
> >>>>
> >>>>>
> >>>>> So I would prefer to keep trying to set the idle mask everytime the
> >>>>> cpu enters idle. If a tick has not happened between 2 idle phases, =
the
> >>>>> cpumask will not be updated and the overhead will be mostly testing=
 if
> >>>>> (rq->last_idle_state =3D=3D idle_state).
> >>>>
> >>>> Not sure if I addressed your concern, did you see any workloads any =
cases
> >>>> v4 performs better than v5?
> >>>
> >>> Yes, I see some perf regression on my octo arm64 system for hackbench=
 with
> >>> only 1 group (and for few ther ones but it's less obvious). There is =
no
> >>> perf impact with more groups most probably because the cpus are no mo=
re idle.
> >>>
> >>> The regression happens even if the shallowest idle state is the only =
one to
> >>> be enabled.
> >>
> >> Thanks for the data.
> >>
> >>>
> >>> - 2 x 4 cores arm64 system
> >>>
> >>> 12 iterations of hackbench -l (256000/#grp) -g #grp
> >>>
> >>> Only the shallowest state enabled
> >>
> >>> (as a sidenote, we don't have polling mode on arm64)
> >> Okay, this might be the cause of the difference between yours and mine=
. So do you
> >> think if it makes sense to let idle governor to return a polling flag =
and associate
> >> it with idle cpumask update instead of stop_tick? A CPU is idle but ac=
tually polling
> >> may not be suitable for the wake up target.
> >
> > I don't know much about polling but can't this mode be used up to a tic=
k too ?
> >I think so. So short idle need a definition. I'm not sure if it's a good=
 idea to define
> the short idle as a tunable and default set it to tick >> 2?

I have never been fond of heuristic like tick << 2 or sys tunable

TBH, I'm not sure that using the tick is a good idea. And such kind of
parameter need more thought

>
> Updating idle cpumask everytime cpu enters idle works for me, as we have =
state change
> check, so we won't actually update idle cpumask everytime the cpu enters =
idle.

Yes, In this case, the overhead stays reasonable and is limited to the
test of a rq->last_idle_state
This will benefit heavy use a case by reducing the scanning time  and
will not regress other use case.

>
> But I'm still willing to exclude short idle case, what do you think?

something similar to patch v3 or patch v5 + my changes seems to be a
good 1st step that will benefit heavy use cases with regressing other
ones.

Trying to exclude short idle case will need more thoughts and changes
especially about to how to get this information and if it is reliable.

>
> Thanks,
> -Aubrey
>
>
