Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B12C2DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbgKXRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKXRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:01:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1CBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:01:41 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so7244411wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=87Kd1Jcd7tJEmpCIl+hFSrqbwtJEJ3ZyDk4caLbdci8=;
        b=u4tdTBYC2SL36MN8FS3SEz8Z6QjthROtd/KQ7cc8sbleWwhyoc+KFMLU21jVzyAKQk
         DH1+Tfx8YolgEn1JzswtXYfYjc14RFO52HtETuY8xgb2COdkzvjEKGO7tx6Sd+8CLRra
         OhzuUh60pd1I71xaPfUyollLiTjxIGoMkwXwtYfXDPP7EpmBWKPAhRslwhlVhCUc1Zyu
         dGQTIH4pnSU91sIm4mT4yE18i0XC0X7rtrCdVqvFG7foTcjd6ISsEjfYr6c8qSel+Svr
         eZP2HybISn/vIUfVl0TRfKViPY9fZA4tqGmw18MaegiIRbBkJjVBRgvTpkWFXrqGJ1BV
         O7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=87Kd1Jcd7tJEmpCIl+hFSrqbwtJEJ3ZyDk4caLbdci8=;
        b=BielA0T5bDnk/SzMUm/S4icHqlumbNATH18pfMaOkzsdJ/u1Ot63g83Vt8NU5GySUY
         jFAdHzZHWQkX8n33gChSt8S/t8YWMXrCfawIRFan0rNAF7oXT6+xc7MrRcAHjeS0ePqC
         BD46YCYiTTdEuv0xHtdPjY5hDzReEMKMM3KPr6fIoimPaSO5DrDPg2Bi0jDPC2qFbKbx
         c5EJkbOueCaLp6cirgR3/p3IoIAc35CP41HC4T4tTiJQFN5ksZZdjp0bsrbsTLdPIU2/
         X/+jLfpXOgcHqNxZnT2ssF2QK1LGmjNW9jY5ZTh25hMtwLFO8umXvta5XFIcqrpfdCQc
         AWWQ==
X-Gm-Message-State: AOAM532YkR8AJNfmc8a+x+OGQ9zcuciUO2PKiVn3Q8RWH8pt/vRUvQ6B
        SokXHn85fI5avNFy8g96JlF1EQ==
X-Google-Smtp-Source: ABdhPJwvvVArFG1BAwXWcyKegf0xana7Rg4zfYjxMbGPgjrH/as6HvX2nNbEDxBelVf0h049UrgB/w==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr6008868wrt.99.1606237299768;
        Tue, 24 Nov 2020 09:01:39 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:cd59:a402:8959:615e])
        by smtp.gmail.com with ESMTPSA id x5sm1707396wrm.96.2020.11.24.09.01.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Nov 2020 09:01:38 -0800 (PST)
Date:   Tue, 24 Nov 2020 18:01:36 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201124170136.GA26613@vingu-book>
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <CAKfTPtBZU-QKqzsTL9Y0+wuUdGayyfuC8hKu2wcHZAAAmNJyfw@mail.gmail.com>
 <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <262397dc-b783-2040-6214-b8de5abf5617@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

Le mardi 24 nov. 2020 à 15:01:38 (+0800), Li, Aubrey a écrit :
> Hi Vincent,
> 
> On 2020/11/23 17:27, Vincent Guittot wrote:
> > Hi Aubrey,
> > 
> > On Thu, 19 Nov 2020 at 13:15, Aubrey Li <aubrey.li@linux.intel.com> wrote:
> >>
> >> Add idle cpumask to track idle cpus in sched domain. When a CPU
> >> enters idle, if the idle driver indicates to stop tick, this CPU
> >> is set in the idle cpumask to be a wakeup target. And if the CPU
> >> is not in idle, the CPU is cleared in idle cpumask during scheduler
> >> tick to ratelimit idle cpumask update.
> >>
> >> When a task wakes up to select an idle cpu, scanning idle cpumask
> >> has low cost than scanning all the cpus in last level cache domain,
> >> especially when the system is heavily loaded.
> >>
> >> Benchmarks were tested on a x86 4 socket system with 24 cores per
> >> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
> >> schbench have no notable change, uperf has:
> >>
> >> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
> >>
> >>   threads       baseline-avg    %std    patch-avg       %std
> >>   96            1               0.83    1.23            3.27
> >>   144           1               1.03    1.67            2.67
> >>   192           1               0.69    1.81            3.59
> >>   240           1               2.84    1.51            2.67
> >>
> >> v4->v5:
> >> - add update_idle_cpumask for s2idle case
> >> - keep the same ordering of tick_nohz_idle_stop_tick() and update_
> >>   idle_cpumask() everywhere
> >>
> >> v3->v4:
> >> - change setting idle cpumask from every idle entry to tickless idle
> >>   if cpu driver is available.
> > 
> > Could you remind me why you did this change ? Clearing the cpumask is
> > done during the tick to rate limit the number of updates of the
> > cpumask but It's not clear for me why you have associated the set with
> > the tick stop condition too.
> 
> I found the current implementation has better performance at a more 
> suitable load range.
> 
> The two kinds of implementions(v4 and v5) have the same rate(scheduler
> tick) to shrink idle cpumask when the system is busy, but

I'm ok with the part above

> 
> - Setting the idle mask everytime the cpu enters idle requires a much
> heavier load level to preserve the idle cpumask(not call into idle),
> otherwise the bits cleared in scheduler tick will be restored when the
> cpu enters idle. That is, idle cpumask is almost equal to the domain
> cpumask during task wakeup if the system load is not heavy enough.

But setting the idle cpumask is useful because it helps to select an idle
cpu at wake up instead of waiting ifor ILB to fill the empty CPU. IMO,
the idle cpu mask is useful in heavy cases because a system, which is
already fully busy with work, doesn't want to waste time looking for an
idle cpu that doesn't exist. But if there is an idle cpu, we should still
looks for it.

>
> 
> - Associating with tick stop tolerates idle to preserve the idle cpumask
> but only short idle, which causes tick retains. This is more fitable for
> the real workload.

I don't agree with this and real use cases with interaction will probably
not agree as well as they want to run on an idle cpu if any but not wait
on an already busy one.
Also keep in mind that a tick can be up to 10ms long

> 
> > 
> > This change means that a cpu will not be part of the idle mask if the
> > tick is not stopped. On some arm/arm64 platforms, the tick stops only
> > if the idle duration is expected to be higher than 1-2ms which starts
> > to be significantly long. Also, the cpuidle governor can easily
> > mis-predict a short idle duration whereas it will be finally a long
> > idle duration; In this case, the next tick will correct the situation
> > and select a deeper state, but this can happen up to 4ms later on
> > arm/arm64.
> 
> Yes this is intented. If the tick is not stopped, that indicates the
> CPU is very busy, cpu idle governor selected the polling idle state, and/or 
> the expected idle duration is shorter than the tick period length. For

As mentioned above a tick can be up to 10ms long which is not a short idle
duration.

Then the governor also mispredicts the idle duration and this is one
reason that the tick is not stopped because it will give the opportunity
to reevaluate the idle state in case of misprediction.

> example, uperf enters and exits 80 times between two ticks when utilizes
> 100% CPU, and the average idle residency < 50us.

But scheduler looks for idle state of prev cpu before looping the idle cpu
mask so i'm not sure that uperf is impacted in this case because scheduler
will select prev cpu before loop idle cpu mask.

> 
> If this CPU is added to idle cpumask, the wakeup task likely needs to 
> wait in the runqueue as this CPU will run its current task very soon.
> 
> > 
> > So I would prefer to keep trying to set the idle mask everytime the
> > cpu enters idle. If a tick has not happened between 2 idle phases, the
> > cpumask will not be updated and the overhead will be mostly testing if
> > (rq->last_idle_state == idle_state).
> 
> Not sure if I addressed your concern, did you see any workloads any cases
> v4 performs better than v5?

Yes, I see some perf regression on my octo arm64 system for hackbench with
only 1 group (and for few ther ones but it's less obvious). There is no 
perf impact with more groups most probably because the cpus are no more idle.

The regression happens even if the shallowest idle state is the only one to
be enabled.

- 2 x 4 cores arm64 system

12 iterations of hackbench -l (256000/#grp) -g #grp

Only the shallowest state enabled
(as a sidenote, we don't have polling mode on arm64)

grp    tip/sched/core        + your patchset v5          + the change below
1      1.296(+/- 2.06 %)     1.890(+/-35,10 %) -45%      1.311(+/- 2.63%) -1.19%
4      1.249(+/- 2.67 %)     1.255(+/- 3.10 %) - 0.46 %  1.235(+/- 4.77%) -0.28%
8      1.175(+/- 1.20 %)     1.180(+/- 2.33 %) - 0.47 %  1.179(+/- 1.60%) -0.38%
16     1.213(+/- 1.10 %)     1.218(+/- 0.68 %) - 0.41 %  1.219(+/- 2.15%) -0.52%

All idle states enabled (3 states)

grp    tip/sched/core        + your patchset v5          + the change below
1      1.429(+/-19.36 %)     1.678(+/-34.29 %) -17%      1.426(+/-17.18%) +0.21%
4      1.244(+/- 3.04 %)     1.261(+/- 3.21 %) - 1.39 %  1.260(+/- 2.55%) -1.29%
8      1.169(+/- 1.43 %)     1.183(+/- 2.09 %) - 1.23 %  1.198(+/- 2.49%) -2.51%
16     1.219(+/- 1.23 %)     1.218(+/- 0.68 %) - 0.59 %  1.225(+/- 1.43%) -0.49%

The change below is a bit different from your v3 because I wanted to check if
the root cause was the set of cpuilde mask only when tick is stopped.

---
 kernel/sched/idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index a38d8822ce0d..ca32197778b0 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -156,6 +156,7 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
+	update_idle_cpumask(this_rq(), true);
 	/*
 	 * The RCU framework needs to be told that we are entering an idle
 	 * section, so no more rcu read side critical sections and one more
@@ -163,7 +164,6 @@ static void cpuidle_idle_call(void)
 	 */
 
 	if (cpuidle_not_available(drv, dev)) {
-		update_idle_cpumask(this_rq(), true);
 		tick_nohz_idle_stop_tick();
 
 		default_idle_call();
@@ -194,7 +194,6 @@ static void cpuidle_idle_call(void)
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
 
-		update_idle_cpumask(this_rq(), true);
 		tick_nohz_idle_stop_tick();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
@@ -208,7 +207,6 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
 		if (stop_tick || tick_nohz_tick_stopped()) {
-			update_idle_cpumask(this_rq(), true);
 			tick_nohz_idle_stop_tick();
 		} else {
 			tick_nohz_idle_retain_tick();
-- 
2.17.1


> 
> Thanks,
> -Aubrey
> 
> > 
> > 
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
> >>   cpumask with sched_domain_span(sd), nohz=off case remains the original
> >>   behavior.
> >>
