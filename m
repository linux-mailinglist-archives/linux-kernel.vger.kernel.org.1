Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C62A6277
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKDKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:48:01 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:42421 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbgKDKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:48:01 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id A8E901C33CD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:47:58 +0000 (GMT)
Received: (qmail 4390 invoked from network); 4 Nov 2020 10:47:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Nov 2020 10:47:58 -0000
Date:   Wed, 4 Nov 2020 10:47:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Message-ID: <20201104104755.GC3371@techsingularity.net>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
 <20201104094205.GI3306@suse.de>
 <CAKfTPtAjhv8JafvZFR8_UUfDM2MUzVGMPXVBx1zynhPXJ_oh3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAjhv8JafvZFR8_UUfDM2MUzVGMPXVBx1zynhPXJ_oh3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 11:06:06AM +0100, Vincent Guittot wrote:
> >
> > Hackbench failed to run because I typo'd the configuration. Kernel build
> > benchmark and git test suite both were inconclusive for 5.10-rc2
> > (neutral results) although the showed 10-20% gain for kernbench and 24%
> > gain in git test suite by reverting in 5.9.
> >
> > The gitsource test was interesting for a few reasons. First, the big
> > difference between 5.9 and 5.10 is that the workload is mostly concentrated
> > on one NUMA node. mpstat shows that 5.10-rc2 uses all of the CPUs on one
> > node lightly. Reverting the patch shows that far fewer CPUs are used at
> > a higher utilisation -- not particularly high utilisation because of the
> > nature of the workload but noticable. i.e.  gitsource with the revert
> > packs the workload onto fewer CPUs. The same holds for fork_test --
> > reverting packs the workload onto fewer CPUs with higher utilisation on
> > each of them. Generally this plays well with cpufreq without schedutil
> > using fewer CPUs means the CPU is likely to reach higher frequencies.
> 
> Which cpufreq governor are you using ?
> 

Uhh, intel_pstate with ondemand .... which is surprising, I would have
expected powersave. I'd have to look closer at what happened there. It
might be a variation of the Kconfig mess selecting the wrong governors when
"yes '' | make oldconfig" is used.

> >
> > While it's possible that some other factor masked the impact of the patch,
> > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > indicates that if the patch was implemented against 5.10-rc2, it would
> > likely not have been merged. I've queued the tests on the remaining
> > machines to see if something more conclusive falls out.
> 
> I don't think that the goal of the patch is stressed by those benchmarks.
> I typically try to optimize the sequence:
> 1-fork a lot of threads that immediately wait
> 2-wake up all threads simultaneously to run in parallel
> 3-wait the end of all threads
> 

Out of curiousity, have you a stock benchmark that does this with some
associated metric?  sysbench-threads wouldn't do it. While I know of at
least one benchmark that *does* exhibit this pattern, it's a Real Workload
that cannot be shared (so I can't discuss it) and it's *complex* with a
minimal kernel footprint so analysing it is non-trivial.

I could develop one on my own but if you had one already, I'd wire it into
mmtests and add it to the stock collection of scheduler loads. schbench
*might* match what you're talking about but I'd rather not guess.
schbench is also more of a latency wakeup benchmark than it is a throughput
one. Latency ones tend to be more important but optimising purely for
wakeup-latency also tends to kick other workloads into a hole.

> Without the patch all newly forked threads were packed on few CPUs
> which were already idle when the next fork happened. Then the spreads
> were spread on CPUs at wakeup in the LLC but they have to wait for a
> LB to fill other sched domain
> 

Which is fair enough but it's a tradeoff because there are plenty of
workloads that fork/exec and do something immediately and this is not
the first time we've had to tradeoff between workloads.

The other aspect I find interesting is that we get slightly burned by
the initial fork path because of this thing;

                        /*
                         * Otherwise, keep the task on this node to stay close
                         * its wakeup source and improve locality. If there is
                         * a real need of migration, periodic load balance will
                         * take care of it.
                         */
                        if (local_sgs.idle_cpus)
                                return NULL;

For a workload that creates a lot of new threads that go idle and then
wakeup (think worker pool threads that receive requests at unpredictable
times), it packs one node too tightly when the threads wakeup -- it's
also visible from page fault microbenchmarks that scale the number of
threads. It's a vaguely similar class of problem but the patches are
taking very different approaches.

It'd been in my mind to consider reconciling that chunk with the
adjust_numa_imbalance but had not gotten around to seeing how it should
be reconciled without introducing another regression.

The longer I work on the scheduler, the more I feel it's like juggling
while someone is firing arrows at you :D .

-- 
Mel Gorman
SUSE Labs
