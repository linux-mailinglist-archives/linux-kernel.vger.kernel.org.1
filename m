Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC32BAB95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgKTOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:02:40 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:60759 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbgKTOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:02:40 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 61128FA99C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:02:37 +0000 (GMT)
Received: (qmail 7783 invoked from network); 20 Nov 2020 14:02:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Nov 2020 14:02:37 -0000
Date:   Fri, 20 Nov 2020 14:02:35 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Revisit NUMA imbalance tolerance and fork
 balancing
Message-ID: <20201120140235.GE3371@techsingularity.net>
References: <20201120090630.3286-1-mgorman@techsingularity.net>
 <20201120125811.GJ3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201120125811.GJ3021@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:58:11PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 09:06:26AM +0000, Mel Gorman wrote:
> 
> > Mel Gorman (4):
> >   sched/numa: Rename nr_running and break out the magic number
> >   sched: Avoid unnecessary calculation of load imbalance at clone time
> >   sched/numa: Allow a floating imbalance between NUMA nodes
> >   sched: Limit the amount of NUMA imbalance that can exist at fork time
> > 
> >  kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> OK, lets give this another go :-)
> 

Weeeeeeeee!

My expectations are that NAS will show some glitches depending on the
subtest, core usage and whether the subtest prefers packing closely or
spreading wide for both patch 3 and 4. I'm not *too* concerned about
that as HPC workloads are more likely to specify "places" be it OMP or
MPI. Ordinarily I would disagree with myself as NAS has been used as one
standard for scheduler behaviour and NUMA balancing in particular but
it favours allowing communicating tasks to remain local while spreading
for memory bandwidth when the busy CPUs is higher. I think that's a
reasonable balance.

In this case the main motive for patch 4 is the "real workload" that
is both memory and CPU intensive, runs on large machines and is latency
sensitive. I'm favouring the real workload over being able to pick a NAS
configuration that would show a regression.

The main negative corner case I'm anticipating is parallel loads (like
NAS), that are not memory bound, and the degree of parrallelisation is
between 25% and 100% of one node's compute capacity. Once it passes the
25% threshold, it'll start geting spread and may manifest as a regression
with patch 3 contributing slightly and patch 4 contributing a lot to
a regression.

Communicating tasks like tbench with varying thread counts will show
minor gains and losses depending on thread count.

Single communciators like netperf or perfpipe should show be ok or at
least within noise.

Hackbench should be fine because it typically saturates the machine so
any glitches there will likely be due to timing artifacts on initial
placement during clone.

Putting the predictions in writing should summon the regression demons
faster to prove me wrong due to Murphy's Law :P

Thanks.

-- 
Mel Gorman
SUSE Labs
