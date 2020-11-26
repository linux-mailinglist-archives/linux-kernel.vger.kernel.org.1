Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01252C519B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbgKZJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbgKZJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:49:26 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9BEC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:49:24 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id j10so1653407lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AQGcQX8rrxnia0mK0RrLw5C9nHzxMgP6q05Y6tLBGEg=;
        b=DOk8MYNOmAGodV/P5eFASY2cXioJn0Nu/wjBISmAPhOSuqai2ZFAKuTgumrSF1LWwg
         D7K5Ke84i2q9BVVaI4YgVDt5Crm/anePRqwmPEqpsI9azT1sYxTkjxI96xUgyg3JQoUR
         ArdHeyQhcIMgDo4UDTRDsriCFkXsMrPeSEqub68f/3lsPJIkYw8TR51l9VH5FYkc1ff2
         isU9ziXyJsmiTdhaN2gVK8sup6J+Y+JOlQPNOu5FH9rO3+CoDrjb9eoXP+y6dYHQamz3
         x25YKA8vTAOccAM9qB4s3eKomf7UBZwbo/zJMdPj0bA8N2kPsAwHn9z0+tNg0qhOg/97
         kR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AQGcQX8rrxnia0mK0RrLw5C9nHzxMgP6q05Y6tLBGEg=;
        b=kaRrPPsRPios3P8LWCHRhtcYYVqJV7MzAVztdqYoAp0Y3Wdp1pivBaiyjr41tRpzv0
         f04SlgkmPJKAqClkamvT/JSAplc7q+AW94Z0v3Bwwgoj6D2zfHmUlFxE+ymiHH30OerR
         dFlQHFWbIiOZEnZnHjPMWMebWtIJOl3Ex6lTqrzeHV32ggpjmPLELF5XG+GLAqPEs4WR
         HbLeH+FSHJ1AGs8uUhvtFhMxE+Na6nta5Ieo9N/teedPbG/Loz3imxRIhvrqq08qvWC7
         ofxLuzhjaa5vGMcapONfGRj/zsgWJCtCyRhZhQ3Y+dK8qiQB3gZRK29BgbYU4k+S5pBn
         oo1A==
X-Gm-Message-State: AOAM533JwpxAVxheSm9H7O86EYydUIwSWpqvcCDDSWx7/fR+Cr+NLD0h
        sw5MsSTxm8ZmcfN3y0acuVt4UpA1ryUn63xJOPrziQ==
X-Google-Smtp-Source: ABdhPJz4W9gYeTcopHjTvBVE/mKQpnAMnkvcMrUZpmXgFoFcmaFh3OqlGN1C/86wwPM++Xqm6S2rRC4RJCPPzm7/V84=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr975382ljp.226.1606384159829;
 Thu, 26 Nov 2020 01:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
 <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com> <20201124170136.GA26613@vingu-book>
 <67a14568-4fa5-d9b4-d2fc-72a22c226189@linux.intel.com> <CAKfTPtB5=VSkE3YQf5igi6rBFPUSua=hM2FEnvBnRpF9n4VYwg@mail.gmail.com>
 <2a715c5d-c93f-0e5f-8b1a-83803cb6def6@linux.intel.com> <CAKfTPtB2FG64Csi0VBG-rZVr-KQ9x+WccFiWaXPVFremSHbcJw@mail.gmail.com>
 <f5a7d584-7235-d1f4-f7db-0081a59c3846@linux.intel.com>
In-Reply-To: <f5a7d584-7235-d1f4-f7db-0081a59c3846@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Nov 2020 10:49:08 +0100
Message-ID: <CAKfTPtDNHkR_34ZhQN+sB2wKU=UMSJvDpbFFYtTunB31082BzQ@mail.gmail.com>
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

On Thu, 26 Nov 2020 at 10:35, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2020/11/26 16:14, Vincent Guittot wrote:
> > On Wed, 25 Nov 2020 at 14:37, Li, Aubrey <aubrey.li@linux.intel.com> wr=
ote:
> >>
> >> On 2020/11/25 16:31, Vincent Guittot wrote:
> >>> On Wed, 25 Nov 2020 at 03:03, Li, Aubrey <aubrey.li@linux.intel.com> =
wrote:
> >>>>
> >>>> On 2020/11/25 1:01, Vincent Guittot wrote:
> >>>>> Hi Aubrey,
> >>>>>
> >>>>> Le mardi 24 nov. 2020 =C3=A0 15:01:38 (+0800), Li, Aubrey a =C3=A9c=
rit :
> >>>>>> Hi Vincent,
> >>>>>>
> >>>>>> On 2020/11/23 17:27, Vincent Guittot wrote:
> >>>>>>> Hi Aubrey,
> >>>>>>>
> >>>>>>> On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.co=
m> wrote:
> >>>>>>>>
> >>>>>>>> Add idle cpumask to track idle cpus in sched domain. When a CPU
> >>>>>>>> enters idle, if the idle driver indicates to stop tick, this CPU
> >>>>>>>> is set in the idle cpumask to be a wakeup target. And if the CPU
> >>>>>>>> is not in idle, the CPU is cleared in idle cpumask during schedu=
ler
> >>>>>>>> tick to ratelimit idle cpumask update.
> >>>>>>>>
> >>>>>>>> When a task wakes up to select an idle cpu, scanning idle cpumas=
k
> >>>>>>>> has low cost than scanning all the cpus in last level cache doma=
in,
> >>>>>>>> especially when the system is heavily loaded.
> >>>>>>>>
> >>>>>>>> Benchmarks were tested on a x86 4 socket system with 24 cores pe=
r
> >>>>>>>> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench an=
d
> >>>>>>>> schbench have no notable change, uperf has:
> >>>>>>>>
> >>>>>>>> uperf throughput: netperf workload, tcp_nodelay, r/w size =3D 90
> >>>>>>>>
> >>>>>>>>   threads       baseline-avg    %std    patch-avg       %std
> >>>>>>>>   96            1               0.83    1.23            3.27
> >>>>>>>>   144           1               1.03    1.67            2.67
> >>>>>>>>   192           1               0.69    1.81            3.59
> >>>>>>>>   240           1               2.84    1.51            2.67
> >>>>>>>>
> >>>>>>>> v4->v5:
> >>>>>>>> - add update_idle_cpumask for s2idle case
> >>>>>>>> - keep the same ordering of tick_nohz_idle_stop_tick() and updat=
e_
> >>>>>>>>   idle_cpumask() everywhere
> >>>>>>>>
> >>>>>>>> v3->v4:
> >>>>>>>> - change setting idle cpumask from every idle entry to tickless =
idle
> >>>>>>>>   if cpu driver is available.
> >>>>>>>
> >>>>>>> Could you remind me why you did this change ? Clearing the cpumas=
k is
> >>>>>>> done during the tick to rate limit the number of updates of the
> >>>>>>> cpumask but It's not clear for me why you have associated the set=
 with
> >>>>>>> the tick stop condition too.
> >>>>>>
> >>>>>> I found the current implementation has better performance at a mor=
e
> >>>>>> suitable load range.
> >>>>>>
> >>>>>> The two kinds of implementions(v4 and v5) have the same rate(sched=
uler
> >>>>>> tick) to shrink idle cpumask when the system is busy, but
> >>>>>
> >>>>> I'm ok with the part above
> >>>>>
> >>>>>>
> >>>>>> - Setting the idle mask everytime the cpu enters idle requires a m=
uch
> >>>>>> heavier load level to preserve the idle cpumask(not call into idle=
),
> >>>>>> otherwise the bits cleared in scheduler tick will be restored when=
 the
> >>>>>> cpu enters idle. That is, idle cpumask is almost equal to the doma=
in
> >>>>>> cpumask during task wakeup if the system load is not heavy enough.
> >>>>>
> >>>>> But setting the idle cpumask is useful because it helps to select a=
n idle
> >>>>> cpu at wake up instead of waiting ifor ILB to fill the empty CPU. I=
MO,
> >>>>> the idle cpu mask is useful in heavy cases because a system, which =
is
> >>>>> already fully busy with work, doesn't want to waste time looking fo=
r an
> >>>>> idle cpu that doesn't exist.
> >>>>
> >>>> Yes, this is what v3 does.
> >>>>
> >>>>> But if there is an idle cpu, we should still looks for it.
> >>>>
> >>>> IMHO, this is a potential opportunity can be improved. The idle cpu =
could be
> >>>> in different idle state, the idle duration could be long or could be=
 very short.
> >>>> For example, if there are two idle cpus:
> >>>>
> >>>> - CPU1 is very busy, the pattern is 50us idle and 950us work.
> >>>> - CPU2 is in idle for a tick length and wake up to do the regular wo=
rk
> >>>>
> >>>> If both added to the idle cpumask, we want the latter one, or we can=
 just add
> >>>> the later one into the idle cpumask. That's why I want to associate =
tick stop
> >>>> signal with it.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>> - Associating with tick stop tolerates idle to preserve the idle c=
pumask
> >>>>>> but only short idle, which causes tick retains. This is more fitab=
le for
> >>>>>> the real workload.
> >>>>>
> >>>>> I don't agree with this and real use cases with interaction will pr=
obably
> >>>>> not agree as well as they want to run on an idle cpu if any but not=
 wait
> >>>>> on an already busy one.
> >>>>
> >>>> The problem is scan overhead, scanning idle cpu need time. If an idl=
e cpu
> >>>> is in the short idle mode, it's very likely that when it's picked up=
 for a
> >>>> wakeup task, it goes back to work again, and the wakeup task has to =
wait too,
> >>>> maybe longer because the running task just starts.
> >>>>
> >>>> One benefit of waiting on the previous one is warm cache.
> >>>>
> >>>>> Also keep in mind that a tick can be up to 10ms long
> >>>>
> >>>> Right, but the point here is, if this 10ms tick retains, the CPU sho=
uld be
> >>>> in the short idle mode.
> >>>
> >>> But 10, 4 or even 1ms is quite long for a system and that's even more
> >>> true compared to scanning the idle cpu mask
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> This change means that a cpu will not be part of the idle mask if=
 the
> >>>>>>> tick is not stopped. On some arm/arm64 platforms, the tick stops =
only
> >>>>>>> if the idle duration is expected to be higher than 1-2ms which st=
arts
> >>>>>>> to be significantly long. Also, the cpuidle governor can easily
> >>>>>>> mis-predict a short idle duration whereas it will be finally a lo=
ng
> >>>>>>> idle duration; In this case, the next tick will correct the situa=
tion
> >>>>>>> and select a deeper state, but this can happen up to 4ms later on
> >>>>>>> arm/arm64.
> >>>>>>
> >>>>>> Yes this is intented. If the tick is not stopped, that indicates t=
he
> >>>>>> CPU is very busy, cpu idle governor selected the polling idle stat=
e, and/or
> >>>>>> the expected idle duration is shorter than the tick period length.=
 For
> >>>>>
> >>>>> As mentioned above a tick can be up to 10ms long which is not a sho=
rt idle
> >>>>> duration.
> >>>>
> >>>> Usually when the tick retains, the CPU is in the short idle mode or =
even polling
> >>>> instead of idle.
> >>>
> >>> Also keep in mind that cpuidle can select a shallow state and retains
> >>> tick because of the wake up latency constraint and not the idle
> >>> duration. So you can't really make the assumption that retaining tick
> >>> means short idle duration
> >>>
> >> idle governor has short idle information, probably can let idle govern=
or
> >> expose a short idle indicator?
> >>
> >>>>
> >>>>>
> >>>>> Then the governor also mispredicts the idle duration and this is on=
e
> >>>>> reason that the tick is not stopped because it will give the opport=
unity
> >>>>> to reevaluate the idle state in case of misprediction.
> >>>>>
> >>>> We always predict the next state based on the past states, so mispre=
diction
> >>>> does happen. This is not what this patch is trying to solve. I'm cer=
tainly
> >>>
> >>> My point here was to say that one original goal of cpuidle for
> >>> retaining the tick was to handle case where the governor mispredicts =
a
> >>> short idle time. Retaining the tick prevents the cpu to stay too long
> >>> in this shallow idle state and to waste power which seems to happen
> >>> often enough to be raised by people
> >>
> >> I see, thanks!
> >>
> >>>
> >>>> open if there is a better signal instead of stop_tick from idle gove=
rnor.
> >>>>
> >>>>
> >>>>>> example, uperf enters and exits 80 times between two ticks when ut=
ilizes
> >>>>>> 100% CPU, and the average idle residency < 50us.
> >>>>>
> >>>>> But scheduler looks for idle state of prev cpu before looping the i=
dle cpu
> >>>>> mask so i'm not sure that uperf is impacted in this case because sc=
heduler
> >>>>> will select prev cpu before loop idle cpu mask.
> >>>>>
> >>>>>>
> >>>>>> If this CPU is added to idle cpumask, the wakeup task likely needs=
 to
> >>>>>> wait in the runqueue as this CPU will run its current task very so=
on.
> >>>>>>
> >>>>>>>
> >>>>>>> So I would prefer to keep trying to set the idle mask everytime t=
he
> >>>>>>> cpu enters idle. If a tick has not happened between 2 idle phases=
, the
> >>>>>>> cpumask will not be updated and the overhead will be mostly testi=
ng if
> >>>>>>> (rq->last_idle_state =3D=3D idle_state).
> >>>>>>
> >>>>>> Not sure if I addressed your concern, did you see any workloads an=
y cases
> >>>>>> v4 performs better than v5?
> >>>>>
> >>>>> Yes, I see some perf regression on my octo arm64 system for hackben=
ch with
> >>>>> only 1 group (and for few ther ones but it's less obvious). There i=
s no
> >>>>> perf impact with more groups most probably because the cpus are no =
more idle.
> >>>>>
> >>>>> The regression happens even if the shallowest idle state is the onl=
y one to
> >>>>> be enabled.
> >>>>
> >>>> Thanks for the data.
> >>>>
> >>>>>
> >>>>> - 2 x 4 cores arm64 system
> >>>>>
> >>>>> 12 iterations of hackbench -l (256000/#grp) -g #grp
> >>>>>
> >>>>> Only the shallowest state enabled
> >>>>
> >>>>> (as a sidenote, we don't have polling mode on arm64)
> >>>> Okay, this might be the cause of the difference between yours and mi=
ne. So do you
> >>>> think if it makes sense to let idle governor to return a polling fla=
g and associate
> >>>> it with idle cpumask update instead of stop_tick? A CPU is idle but =
actually polling
> >>>> may not be suitable for the wake up target.
> >>>
> >>> I don't know much about polling but can't this mode be used up to a t=
ick too ?
> >>> I think so. So short idle need a definition. I'm not sure if it's a g=
ood idea to define
> >> the short idle as a tunable and default set it to tick >> 2?
> >
> > I have never been fond of heuristic like tick << 2 or sys tunable
> >
> > TBH, I'm not sure that using the tick is a good idea. And such kind of
> > parameter need more thought
> >
> >>
> >> Updating idle cpumask everytime cpu enters idle works for me, as we ha=
ve state change
> >> check, so we won't actually update idle cpumask everytime the cpu ente=
rs idle.
> >
> > Yes, In this case, the overhead stays reasonable and is limited to the
> > test of a rq->last_idle_state
> > This will benefit heavy use a case by reducing the scanning time  and
> > will not regress other use case.
> >
> >>
> >> But I'm still willing to exclude short idle case, what do you think?
> >
> > something similar to patch v3 or patch v5 + my changes seems to be a
> > good 1st step that will benefit heavy use cases with regressing other
> > ones.
> >
> > Trying to exclude short idle case will need more thoughts and changes
> > especially about to how to get this information and if it is reliable.
> >
>
> okay, I'll post a v6 with v5 + your change below after data measurement.
> May I add you a signed-off-by to the patch?

my signed-off is not needed.  My changes should be considered as
comments of your patch but sometimes a code example is easier than a
long comment

>
> Thanks,
> -Aubrey
>
> ---
>  kernel/sched/idle.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index a38d8822ce0d..ca32197778b0 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -156,6 +156,7 @@ static void cpuidle_idle_call(void)
>                 return;
>         }
>
> +       update_idle_cpumask(this_rq(), true);
>         /*
>          * The RCU framework needs to be told that we are entering an idl=
e
>          * section, so no more rcu read side critical sections and one mo=
re
> @@ -163,7 +164,6 @@ static void cpuidle_idle_call(void)
>          */
>
>         if (cpuidle_not_available(drv, dev)) {
> -               update_idle_cpumask(this_rq(), true);
>                 tick_nohz_idle_stop_tick();
>
>                 default_idle_call();
> @@ -194,7 +194,6 @@ static void cpuidle_idle_call(void)
>                         max_latency_ns =3D dev->forced_idle_latency_limit=
_ns;
>                 }
>
> -               update_idle_cpumask(this_rq(), true);
>                 tick_nohz_idle_stop_tick();
>
>                 next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
> @@ -208,7 +207,6 @@ static void cpuidle_idle_call(void)
>                 next_state =3D cpuidle_select(drv, dev, &stop_tick);
>
>                 if (stop_tick || tick_nohz_tick_stopped()) {
> -                       update_idle_cpumask(this_rq(), true);
>                         tick_nohz_idle_stop_tick();
>                 } else {
>                         tick_nohz_idle_retain_tick();
> --
> 2.17.1
>
