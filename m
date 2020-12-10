Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48232D58E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgLJLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:05:31 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:34539 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbgLJLFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:05:21 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id C90B317AD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:04:25 +0000 (GMT)
Received: (qmail 301 invoked from network); 10 Dec 2020 11:04:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Dec 2020 11:04:25 -0000
Date:   Thu, 10 Dec 2020 11:04:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] Reduce scanning of runqueues in select_idle_sibling
Message-ID: <20201210110424.GR3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201209143748.GP3371@techsingularity.net>
 <CAKfTPtCToad1ZwMRi28iC=MQ2D+vnTBLKBU+UOBanTWnuQQzRA@mail.gmail.com>
 <CAKfTPtBigdckTCpYyVD9R0U9Mm+ENX7BJ3gqrTkPW3m64iPCVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBigdckTCpYyVD9R0U9Mm+ENX7BJ3gqrTkPW3m64iPCVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:38:37AM +0100, Vincent Guittot wrote:
> > while testing your patchset and Aubrey one on top of tip, I'm facing
> > some perf regression on my arm64 numa system on hackbench and reaim.
> > The regression seems to comes from your patchset but i don't know
> > which patch in particular yet
> >
> > hackbench -l 256000 -g 1
> >
> > v5.10-rc7 + tip/sched/core 13,255(+/- 3.22%)
> > with your patchset         15.368(+/- 2.74)  -15.9%
> >
> > I'm also seeing perf regression on reaim but this one needs more
> > investigation before confirming
> >
> > TBH, I was not expecting regressions. I'm running more test to find
> > which patch is the culprit
> 
> The regression comes from patch 3: sched/fair: Do not replace
> recent_used_cpu with the new target
> 

That's not entirely surprising. The intent of the patch is to increase the
hit rate of p->recent_used_cpu but it's not a guaranteed win due to two
corner cases. If multiple tasks have the same p->recent_used_cpu, they can
race to use that CPU and stack as a result instead of searching the domain.
If SMT is enabled then p->recent_used_cpu can point to an idle CPU that has
a busy sibling which the search would have avoided in select_idle_core().

I think you are using processes and sockets for hackbench but as you'll
see later, hackbench can be used both to show losses and gains.

I originally tested with 6 machines covering Broadwell (2 socket), Haswell
(2 socket), Skylake (1 socket), Cascadelake (2 socket), EPYC (2 socket)
and EPYC 2 (2 socket) with a range of workloads including hackbench. Of
those, just one reported a major problem with 1 group -- the EPYC 1 machine

EPYC hackbench process-sockets
                          5.10.0-rc6             5.10.0-rc6
                       baseline-v2r2         altrecent-v2r5
Amean     1        1.0607 (   0.00%)      1.1480 (  -8.23%)
Amean     4        1.3277 (   0.00%)      1.3117 (   1.21%)
Amean     7        1.6940 (   0.00%)      1.6950 (  -0.06%)
Amean     12       2.1600 (   0.00%)      2.1367 (   1.08%)
Amean     21       3.2450 (   0.00%)      3.5883 ( -10.58%)
Amean     30       4.1673 (   0.00%)      3.9653 (   4.85%)
Amean     48       4.9257 (   0.00%)      5.0000 (  -1.51%)
Amean     79       7.4950 (   0.00%)      7.4563 (   0.52%)
Amean     110     10.4233 (   0.00%)     10.4727 (  -0.47%)
Amean     141     13.4690 (   0.00%)     13.4563 (   0.09%)
Amean     172     16.6450 (   0.00%)     16.6033 (   0.25%)
Amean     203     19.4873 (   0.00%)     19.7893 *  -1.55%*
Amean     234     22.5507 (   0.00%)     22.8033 (  -1.12%)
Amean     265     25.3380 (   0.00%)     25.6490 (  -1.23%)
Amean     296     28.0070 (   0.00%)     28.1270 (  -0.43%)

That's showing an 8% loss for 1 group and also a problem with 21 groups.
Otherwise, it was more or less flat. EPYC 2 also showed a 2% loss for 1
group and 9% loss for 21 groups (probably related to the size of the LLC
domain as there are many LLCs per socket on EPYC*).

For the *same* machine running hackbench using pipes instead of sockets
we get

EPYC hackbench process-pipes
Amean     1        0.9497 (   0.00%)      0.9517 (  -0.21%)
Amean     4        1.2253 (   0.00%)      1.1387 (   7.07%)
Amean     7        2.0677 (   0.00%)      1.7460 *  15.56%*
Amean     12       2.8717 (   0.00%)      2.4797 *  13.65%*
Amean     21       4.4053 (   0.00%)      3.7463 *  14.96%*
Amean     30       5.3983 (   0.00%)      4.1097 *  23.87%*
Amean     48       6.1050 (   0.00%)      4.6873 *  23.22%*
Amean     79       7.5640 (   0.00%)      6.8493 (   9.45%)
Amean     110     12.2627 (   0.00%)      9.4613 *  22.84%*
Amean     141     16.9980 (   0.00%)     13.8327 *  18.62%*
Amean     172     21.5280 (   0.00%)     17.3693 *  19.32%*
Amean     203     25.4480 (   0.00%)     20.9947 *  17.50%*
Amean     234     29.6570 (   0.00%)     24.9613 *  15.83%*
Amean     265     33.0713 (   0.00%)     28.1103 *  15.00%*
Amean     296     37.4443 (   0.00%)     31.8757 *  14.87%*

So even on the *same hardware*, hackbench can show very different results
depending on how it is run.

The rest of the machines were more or less neutral for this patch. Once
hackbench saturates the machine, the hit rate on recent_used_cpu is going
to be low

1-socket skylake
Amean     1       1.3183 (   0.00%)      1.2827 *   2.71%*
Amean     3       3.6750 (   0.00%)      3.6610 (   0.38%)
Amean     5       6.1003 (   0.00%)      6.0190 *   1.33%*
Amean     7       8.6063 (   0.00%)      8.6047 (   0.02%)
Amean     12     14.9480 (   0.00%)     15.0327 (  -0.57%)
Amean     18     22.3430 (   0.00%)     22.6680 (  -1.45%)
Amean     24     29.4970 (   0.00%)     29.6677 (  -0.58%)
Amean     30     36.7373 (   0.00%)     36.3687 (   1.00%)
Amean     32     39.0973 (   0.00%)     39.4417 (  -0.88%)

Shows a 2.71% gain for one group, otherwise more or less neutral

2-socket CascadeLake

Amean     1        0.3663 (   0.00%)      0.3657 (   0.18%)
Amean     4        0.7510 (   0.00%)      0.7793 (  -3.77%)
Amean     7        1.2650 (   0.00%)      1.2583 (   0.53%)
Amean     12       1.9510 (   0.00%)      1.9450 (   0.31%)
Amean     21       2.9677 (   0.00%)      3.0277 (  -2.02%)
Amean     30       4.2993 (   0.00%)      4.0237 *   6.41%*
Amean     48       6.5373 (   0.00%)      6.2987 *   3.65%*
Amean     79      10.5513 (   0.00%)     10.3280 (   2.12%)
Amean     110     15.8567 (   0.00%)     13.9817 (  11.82%)
Amean     141     17.4243 (   0.00%)     17.3177 (   0.61%)
Amean     172     21.0473 (   0.00%)     20.9760 (   0.34%)
Amean     203     25.1070 (   0.00%)     25.1150 (  -0.03%)
Amean     234     28.6753 (   0.00%)     28.9383 (  -0.92%)
Amean     265     32.7970 (   0.00%)     32.9663 (  -0.52%)
Amean     296     36.6510 (   0.00%)     36.6753 (  -0.07%)

Neutral for 1 group, small regression for 4 groups, few gains around the
middle, neutral when over-saturated.

select_idle_sibling is a curse because it's very rare that a change to
it is a universal win. On balance, I think it's better to avoid searching
the domain at all where possible even if there are cases where searching
can have a benefit such as finding an idle core instead of picking an
idle CPU with a busy sibling via p->recent_used_cpu.

-- 
Mel Gorman
SUSE Labs
