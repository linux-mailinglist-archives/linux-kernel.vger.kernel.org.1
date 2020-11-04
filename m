Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD69F2A6363
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgKDLeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:34:36 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A279CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:34:35 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id v19so17656398lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4FOfajYMsRk1v9as8BTCnNhas0TMxi9fMhgzXg4kzo=;
        b=pBAMaq5V70XTb1Jor7a4/tLKfxBgrjCvCo5gZOoa9E8pLI/lp6KoPfSgf/OEjGL7HT
         5AdmAZv90FN1bnkUQJ4caeyxK8VfnXJYNcK9SVUxHk59fMSJ2Cu4GKDwH4wIXd9JsZLB
         UCt092k6sg74xmCzDEDAWQPzGOTrnnU1v6ZoS50yjawwBhiw3fP20iFWKv7xdrKq1eqi
         pYeX/V8vuxh5fEhDw6lNlo49qm2m/iJJ5x01r8IUUxUdX80SGqLi6WpsETz6lppOiwDB
         y6C1r4Wm9fsvzoCJ95Ddeslfk5C689WHBeZMWYhHqhWZCeOn4dIAtsJZ6VgmPHZAJYsK
         WCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4FOfajYMsRk1v9as8BTCnNhas0TMxi9fMhgzXg4kzo=;
        b=cFEqq9oNkbzM386gsay1jkKNpeE9xqeXlqB1yiyiEgmFSV5O2j1zeei+t3bEOyZqNM
         tEYq9PxJylrRXOQt4HyecGSEqokrp/uPyAZ0qheuIWaAYINenYkup5YHIQf8DQtRfyMz
         Stl6PNc3/xwypq2PrrwHc0Vb7CI5ALF2u3nJF3jgN3wSi3T0VN8N7yH0rz8k1mM46VIB
         SkIY+39Xozo3N04/0Hv4vePHjA60GKfDuOSFWhZbzrr6yismVAjZ1Z5y+mSTrRBJF6w3
         n4mDkFBcqc/WfFtMkcavuYY+Yudy2TQ7uyjbdVomIcxjWf504K4nwPstGw7vOHk8KPZ4
         U2yw==
X-Gm-Message-State: AOAM531cOEpjpam6taduVBy+vimHd1qFNjEnDC27zqjhboqDjPzVKkJA
        2DfWN1KSN9qdTMEGkXPZK4CmhCnnsvlXJ4KXhWZV2Q==
X-Google-Smtp-Source: ABdhPJyQWpcxa0yHNH/MVtzFsmy4p1Ir5YiW7OE+4QzJRUi/zbE29iBCzLWiB/dLWqAXtrrYQHWqKshNd23vg+BLo/M=
X-Received: by 2002:a2e:9a43:: with SMTP id k3mr11315383ljj.69.1604489674090;
 Wed, 04 Nov 2020 03:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20200714125941.4174-1-peter.puhov@linaro.org> <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com> <20201104094205.GI3306@suse.de>
 <CAKfTPtAjhv8JafvZFR8_UUfDM2MUzVGMPXVBx1zynhPXJ_oh3w@mail.gmail.com> <20201104104755.GC3371@techsingularity.net>
In-Reply-To: <20201104104755.GC3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Nov 2020 12:34:22 +0100
Message-ID: <CAKfTPtCR3NS2JWvyVUuGE9OP=_+3gfjOTrBxmN_tT_dr96aouQ@mail.gmail.com>
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mel Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 11:47, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Nov 04, 2020 at 11:06:06AM +0100, Vincent Guittot wrote:
> > >
> > > Hackbench failed to run because I typo'd the configuration. Kernel build
> > > benchmark and git test suite both were inconclusive for 5.10-rc2
> > > (neutral results) although the showed 10-20% gain for kernbench and 24%
> > > gain in git test suite by reverting in 5.9.
> > >
> > > The gitsource test was interesting for a few reasons. First, the big
> > > difference between 5.9 and 5.10 is that the workload is mostly concentrated
> > > on one NUMA node. mpstat shows that 5.10-rc2 uses all of the CPUs on one
> > > node lightly. Reverting the patch shows that far fewer CPUs are used at
> > > a higher utilisation -- not particularly high utilisation because of the
> > > nature of the workload but noticable. i.e.  gitsource with the revert
> > > packs the workload onto fewer CPUs. The same holds for fork_test --
> > > reverting packs the workload onto fewer CPUs with higher utilisation on
> > > each of them. Generally this plays well with cpufreq without schedutil
> > > using fewer CPUs means the CPU is likely to reach higher frequencies.
> >
> > Which cpufreq governor are you using ?
> >
>
> Uhh, intel_pstate with ondemand .... which is surprising, I would have
> expected powersave. I'd have to look closer at what happened there. It
> might be a variation of the Kconfig mess selecting the wrong governors when
> "yes '' | make oldconfig" is used.
>
> > >
> > > While it's possible that some other factor masked the impact of the patch,
> > > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > > indicates that if the patch was implemented against 5.10-rc2, it would
> > > likely not have been merged. I've queued the tests on the remaining
> > > machines to see if something more conclusive falls out.
> >
> > I don't think that the goal of the patch is stressed by those benchmarks.
> > I typically try to optimize the sequence:
> > 1-fork a lot of threads that immediately wait
> > 2-wake up all threads simultaneously to run in parallel
> > 3-wait the end of all threads
> >
>
> Out of curiousity, have you a stock benchmark that does this with some
> associated metric?  sysbench-threads wouldn't do it. While I know of at
> least one benchmark that *does* exhibit this pattern, it's a Real Workload
> that cannot be shared (so I can't discuss it) and it's *complex* with a
> minimal kernel footprint so analysing it is non-trivial.

Same for me, a real workload highlighted the behavior but i don't have
a stock benchmark

>
> I could develop one on my own but if you had one already, I'd wire it into
> mmtests and add it to the stock collection of scheduler loads. schbench
> *might* match what you're talking about but I'd rather not guess.
> schbench is also more of a latency wakeup benchmark than it is a throughput

we are interested by the latency at fork but not for the next wakeup
which is what schbench really monitors IIUC. I don't know if we can
make schbench running only for the 1st loop

> one. Latency ones tend to be more important but optimising purely for
> wakeup-latency also tends to kick other workloads into a hole.
>
> > Without the patch all newly forked threads were packed on few CPUs
> > which were already idle when the next fork happened. Then the spreads
> > were spread on CPUs at wakeup in the LLC but they have to wait for a
> > LB to fill other sched domain
> >
>
> Which is fair enough but it's a tradeoff because there are plenty of
> workloads that fork/exec and do something immediately and this is not
> the first time we've had to tradeoff between workloads.

Those cases are catched by the previous test which compares idle_cpus

>
> The other aspect I find interesting is that we get slightly burned by
> the initial fork path because of this thing;
>
>                         /*
>                          * Otherwise, keep the task on this node to stay close
>                          * its wakeup source and improve locality. If there is
>                          * a real need of migration, periodic load balance will
>                          * take care of it.
>                          */
>                         if (local_sgs.idle_cpus)
>                                 return NULL;
>
> For a workload that creates a lot of new threads that go idle and then
> wakeup (think worker pool threads that receive requests at unpredictable
> times), it packs one node too tightly when the threads wakeup -- it's
> also visible from page fault microbenchmarks that scale the number of
> threads. It's a vaguely similar class of problem but the patches are
> taking very different approaches.

The patch ensures a spread in the current node at least. But I agree
that we can't go across nodes with the condition above.

It's all about how aggressive we want to be in the spreading. IIRC
spreading across node at fork was too aggressive because of data
locality.

>
> It'd been in my mind to consider reconciling that chunk with the
> adjust_numa_imbalance but had not gotten around to seeing how it should
> be reconciled without introducing another regression.
>
> The longer I work on the scheduler, the more I feel it's like juggling
> while someone is firing arrows at you :D .

;-D

>
> --
> Mel Gorman
> SUSE Labs
