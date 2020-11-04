Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653D32A60C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgKDJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:42:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:36466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKDJmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:42:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7126AB0E;
        Wed,  4 Nov 2020 09:42:07 +0000 (UTC)
Date:   Wed, 4 Nov 2020 09:42:05 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Message-ID: <20201104094205.GI3306@suse.de>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201102144418.GB154641@lorien.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:44:18AM -0500, Phil Auld wrote:
> > > I have not investigated why because I do not have the bandwidth
> > > to do a detailed study (I was off for a few days and my backlog is
> > > severe). However, I recommend in before v5.10 this be reverted and retried.
> > > If I'm cc'd on v2, I'll run the same tests through the grid and see what
> > > falls out.
> > 
> > I'm going to have a look at the regressions and see if  patches that
> > have been queued for v5.10 or even more recent patch can help or if
> > the patch should be adjusted
> >
> 
> Fwiw, we have pulled this in, along with some of the 5.10-rc1 fixes in this
> area and in the load balancing code.
> 
> We found some load balancing improvements and some minor overall perf
> gains in a few places, but generally did not see any difference from before
> the commit mentioned here.
> 
> I'm wondering, Mel, if you have compared 5.10-rc1? 
> 

The results indicate that reverting on 5.9 would have been the right
decision. It's less clear for 5.10-rc2 so I'm only showing the 5.10-rc2
comparison. Bear in mind that this is one machine only so I'll be
rerunning against all the affected machines according to the bisections
run against 5.9.

aim9
                                5.10.0-rc2             5.10.0-rc2
                                   vanilla        5.10-rc2-revert
Hmean     page_test   510863.13 (   0.00%)   517673.91 *   1.33%*
Hmean     brk_test   1807400.76 (   0.00%)  1814815.29 *   0.41%*
Hmean     exec_test      821.41 (   0.00%)      841.05 *   2.39%*
Hmean     fork_test     4399.71 (   0.00%)     5124.86 *  16.48%*

Reverting shows a 16.48% gain for fork_test and minor gains for others.
To be fair, I don't generally consider the fork_test to be particularly
important because fork microbenchmarks that do no real work are rarely
representative of anything useful. It tends to go up and down a lot and
it's rare a regression in fork_test correlates to anything else.

Hackbench failed to run because I typo'd the configuration. Kernel build
benchmark and git test suite both were inconclusive for 5.10-rc2
(neutral results) although the showed 10-20% gain for kernbench and 24%
gain in git test suite by reverting in 5.9.

The gitsource test was interesting for a few reasons. First, the big
difference between 5.9 and 5.10 is that the workload is mostly concentrated
on one NUMA node. mpstat shows that 5.10-rc2 uses all of the CPUs on one
node lightly. Reverting the patch shows that far fewer CPUs are used at
a higher utilisation -- not particularly high utilisation because of the
nature of the workload but noticable. i.e.  gitsource with the revert
packs the workload onto fewer CPUs. The same holds for fork_test --
reverting packs the workload onto fewer CPUs with higher utilisation on
each of them. Generally this plays well with cpufreq without schedutil
using fewer CPUs means the CPU is likely to reach higher frequencies.

While it's possible that some other factor masked the impact of the patch,
the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
indicates that if the patch was implemented against 5.10-rc2, it would
likely not have been merged. I've queued the tests on the remaining
machines to see if something more conclusive falls out.

-- 
Mel Gorman
SUSE Labs
