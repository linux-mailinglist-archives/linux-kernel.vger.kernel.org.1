Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0582C0C13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgKWNnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbgKWNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:43:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFD9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:43:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u18so23755611lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YngaC6Acfr1/jVJAmkXMgpT3gJKsA91CdQDO/MaDIIM=;
        b=t4cX9IvKWPhk9A5rKy2AV+rcu+LGRH0eQ8QvWfghZQ0nrdnLH/VQH24gzXUV3Qe8nu
         5Arx9oHd9XtoRreu3IZGA2PdMygosFwNXqh5VmbR6+1cZoeZ3hfw4ET+GEW11rnZ6sjg
         2dj/F/dqMQbnW6JB5goeJrdZ+erRnAnSUGZnRIAgQ9Zp6XyqHnoEfuCaTVG/hxkIp319
         JoRwGRTzmmy+ydZct/67MhFCr5H7w1IqiFxYa5EZw/3oOvispMP8HE593bc/iTV06utr
         7CwM0ZG0nkFTzkvU4jEmn+RQMIH/j74PCSqUDOwf9uNx4leatgNaOXyc/4g1p8yD6gBk
         PjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YngaC6Acfr1/jVJAmkXMgpT3gJKsA91CdQDO/MaDIIM=;
        b=n5hnYXtOzu+X0EosB9wpIJmanJGxESEKoZUUTnJf6rdhLa7WCA/U1FuIC11YgkKhX+
         6gaxzp/LmPgkACSf9XH8CrLVARLkD8tWqz1CnJLMzJvV1e0vTOUAqseT+NKCsdGCBFw1
         ZqBFzFkuqjFp03+dbHumbX16IDpG5y39HlpeFpN8OkEazkCxWh3PNWGSsLg8bPw1AeHH
         5rnfY8P/eUrorhNeSj/cBmcL7QTN1a12Dl/VSWaOKZbUAyq92H6DG3g30qrpG2uL7T8X
         zUrm8UuHrTKkWkzQH9RMhBAJRsop34kNNx3tDKDme7LD+7u8Adigb2RgC6E8AFuCf9lk
         S/Bw==
X-Gm-Message-State: AOAM530CwMyO8MVPo3fWYa4n46iNeqVbsYMlcn3QZJx7PYCaSl2gaNgE
        agxdyAXECisqLayrB08s6rYv3Kq99wRhi/CzShbpGA==
X-Google-Smtp-Source: ABdhPJxw+7r33BsIhQ5K6AomfeGzV6BA/bQotP1JYiVDiDAQX5szRbwm2aoMVpWktKJ4dxtFObPH5DZswr08GPvWvNA=
X-Received: by 2002:a19:cc91:: with SMTP id c139mr12772897lfg.31.1606138986661;
 Mon, 23 Nov 2020 05:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201120085653.GA3092@hirez.programming.kicks-ass.net> <66650f6a-0a95-706f-58cc-3cd241e30dda@arm.com>
 <CAKfTPtBtiweSfErgQ3ZVw9HB2Q7b=V4uoGS2dbaqY1KNz6kUhA@mail.gmail.com> <4ea72740-e724-ce20-b6d8-b6cea7c8c370@arm.com>
In-Reply-To: <4ea72740-e724-ce20-b6d8-b6cea7c8c370@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 Nov 2020 14:42:55 +0100
Message-ID: <CAKfTPtCS6rVawFLQ=XGqtySRZuqO-WnbGJQnMvAFVsqFQ7xmAg@mail.gmail.com>
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 at 12:27, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 23/11/2020 11:05, Vincent Guittot wrote:
> > On Mon, 23 Nov 2020 at 10:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 20/11/2020 09:56, Peter Zijlstra wrote:
> >>> On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
> >>>>  - In saturated scenarios task movement will cause some transient dips,
> >>>>    suppose we have a CPU saturated with 4 tasks, then when we migrate a task
> >>>>    to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
> >>>>    new CPU will gain 0.25. This is inevitable and time progression will
> >>>>    correct this. XXX do we still guarantee f_max due to no idle-time?
> >>>
> >>> Do we want something like this? Is the 1.5 threshold sane? (it's been too
> >>> long since I looked at actual numbers here)
> >>
> >> Did some tests on a big.little system:
> >>
> >>  (1) rt-app workload on big CPU:
> >>
> >>  - task0-3 (runtime/period=4000us/16000us, started with
> >>    4000us delay to each other) run on CPU1
> >>  - then task3 migrates to CPU2 and runs there for 64ms
> >>  - then task2 migrates to CPU2 too and both tasks run there
> >>    for another 64ms
> >>
> >> ...
> >>     task3-3-1684  [001]  3982.798729: sched_pelt_cfs:       cpu=1 path=/ load=232890 runnable=3260 util=1011
> >> migration/1-14    [001]  3982.798756: sched_migrate_task:   comm=task3-3 pid=1684 prio=101 orig_cpu=1 dest_cpu=2*
> >> migration/1-14    [001]  3982.798767: sched_pelt_cfs:       cpu=1 path=/ load=161374 runnable=2263 util=*700* <-- util dip !!!
> >>     task1-1-1682  [001]  3982.799802: sched_pelt_cfs:       cpu=1 path=/ load=160988 runnable=2257 util=706
> >> ...
> >>     task2-2-1683  [001]  3982.849123: sched_pelt_cfs:       cpu=1 path=/ load=161124 runnable=2284 util=904
> >>     task2-2-1683  [001]  3982.851960: sched_pelt_cfs:       cpu=1 path=/ load=160130 runnable=2271 util=911
> >> migration/1-14    [001]  3982.851984: sched_migrate_task:   comm=task2-2 pid=1683 prio=101 orig_cpu=1 dest_cpu=2**
> >> migration/1-14    [001]  3982.851995: sched_pelt_cfs:       cpu=1 path=/ load=88672 runnable=*1257* util=512 <-- runnable below 1536
> >>     task1-1-1682  [001]  3982.852983: sched_pelt_cfs:       cpu=1 path=/ load=88321 runnable=1252 util=521
> >> ...
> >>
> >>
> >> *  task1,2,3 remain on CPU1 and still have to catch up, no idle
> >>    time on CPU1
> >>
> >> ** task 1,2 remain on CPU1, there is idle time on CPU1!
> >>
> >>
> >> (2) rt-app workload on LITTLE CPU (orig cpu_capacity: 446)
> >>
> >>  - task0-3 (runtime/period=1742us/16000us, started with
> >>    4000us delay to each other) run on CPU4
> >>  - then task3 migrates to CPU5 and runs there for 64ms
> >>  - then task2 migrates to CPU5 too and both tasks run there
> >>    for another 64ms
> >>
> >> ...
> >>     task1-1-1777  [004]   789.443015: sched_pelt_cfs:       cpu=4 path=/ load=234718 runnable=3018 util=976
> >> migration/4-29    [004]   789.444718: sched_migrate_task:   comm=task3-3 pid=1779 prio=101 orig_cpu=4 dest_cpu=5*
> >> migration/4-29    [004]   789.444739: sched_pelt_cfs:       cpu=4 path=/ load=163543 runnable=2114 util=*778* <--util dip !!!
> >>     task2-2-1778  [004]   789.447013: sched_pelt_cfs:       cpu=4 path=/ load=163392 runnable=2120 util=777
> >> ...
> >>     task1-1-1777  [004]   789.507012: sched_pelt_cfs:       cpu=4 path=/ load=164482 runnable=2223 util=879
> >> migration/4-29    [004]   789.508023: sched_migrate_task:   comm=task2-2 pid=1778 prio=101 orig_cpu=4 dest_cpu=5**
> >> migration/4-29    [004]   789.508044: sched_pelt_cfs:       cpu=4 path=/ load=94099 runnable=*1264* util=611 <-- runnable below 1536
> >>     task0-0-1776  [004]   789.511011: sched_pelt_cfs:       cpu=4 path=/ load=93898 runnable=1264 util=622
> >> ...
> >>
> >> *  task1,2,3 remain on CPU1 and still have to catch up, no idle
> >>    time on CPU1
> >>
> >> ** task 1,2 remain on CPU1, no idle time on CPU1 yet.
> >>
> >> So for the big CPU, there is idle time and for the LITTLE there
> >> isn't with runnable below the threshold.
> >
> > I'm not sure to catch what you want to highlight with your tests ?
>
> I thought the question was whether 'runnable_avg = 1.5 x
> SCHED_CAPACITY_SCALE' is a good threshold to decide to drive frequency
> by runnable_avg or util_avg.

we can't use SCHED_CAPACITY_SCALE and must use cpu's capacity

>
> [...]
