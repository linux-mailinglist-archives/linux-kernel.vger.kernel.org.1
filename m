Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5F2D9814
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgLNMhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:37:55 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:49781 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgLNMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:37:30 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 52019BAAA3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:36:34 +0000 (GMT)
Received: (qmail 20736 invoked from network); 14 Dec 2020 12:36:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Dec 2020 12:36:33 -0000
Date:   Mon, 14 Dec 2020 12:36:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201214123632.GZ3371@techsingularity.net>
References: <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <20201211204337.GX3371@techsingularity.net>
 <20201211221905.GV3040@hirez.programming.kicks-ass.net>
 <20201211225002.GY3371@techsingularity.net>
 <CAKfTPtDBX+scBZiYtDSkXYn7SKDoGYWJiMpCiUvdW1XFz-Fb-Q@mail.gmail.com>
 <20201214093122.GX3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201214093122.GX3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:31:22AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 14, 2020 at 09:11:29AM +0100, Vincent Guittot wrote:
> > On Fri, 11 Dec 2020 at 23:50, Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > > I originally did something like that on purpose too but Vincent called
> > > it out so it is worth mentioning now to avoid surprises. That said, I'm
> > > at the point where anything SIS-related simply needs excessive exposure
> > > because no matter what it does, someone is unhappy with it.
> > 
> > Yeah, I don't like extending the idle core search loop for something
> > that is not related to the idle core search. This adds more work out
> > of  control of the sis_prop. So I'm still against hiding some idle cpu
> > search in idle core search.
> 
> The idea, of course, is to do less. The current code is pretty crap in
> that it will do a whole bunch of things multiple times.
> 

^^^ this

While there is some overhead when searching for an idle core to track
an idle sibling, it's better than double scanning when test_idle_cores()
returns a false positive (or it races with a parallel search that takes
the last idle core).

> Also, a possible follow up, would be something like the below (and
> remove all the sds->has_idle_cores crud), which brings core scanning
> under SIS_PROP.
> 

I'm less confident about this this but admit I have no data. test_idle_core
becomes critical for hackbench once it saturates the machine as it'll
generally return a true positive.

Where test_idle_cores causes problems is when domains are over 50%
busy and returns false positives due to races and the work to find an
idle core is wasted. The flip side is that updating the has_idle_core
information is also expensive in this case as it causes lots of dirty
cache line bouncing so maybe in practice it might be ok. It definitely
should be a separate patch that is tested on top of your first prototype
with the p->cpus_ptr check when picking an idle candidate.

The other side-effect is that with this patch that the scan cost is
*always* accounted for. While this makes intuitive sense as it was never
clear to me why it was only accounted with scan failures. When I had tested
something like this, it was a mix of wins and losses. At minimum, a patch
that always accounts for scan cost and one the removes the test_idle_core
should be separate patches for bisection purposes at the very least.

This is the current set of results I have for your prototype plus the
fixes I suggested on top

http://www.skynet.ie/~mel/postings/peterz-20201214/dashboard.html

It's not a universal win but appears to win more than it loses

The biggest loss is dbench on EPYC 2

http://www.skynet.ie/~mel/postings/peterz-20201214/io-dbench4-async-xfs/romulus/index.html#dbench4

It's not at clear why it was so badly affected but in general, EPYC can
be problematic as it has multiple small LLCs. The same machine for specjvm
showed large gains.

http://www.skynet.ie/~mel/postings/peterz-20201214/jvm-specjbb2005-multi/romulus/index.html#specjbb

There are a lot of results to trawl through but mostly it shows that
it's a mix of wins and losses and it's both workload and machine
dependant which is generally true for anything select_idle_sibling
related.

As the merge window is open, it's inevitable that this will need to be
evaluated against 5.11-rc1 when all the current batch of scheduler code
has been merged. Do you mind splitting your prototype into three patches
and slap some sort of changlog on them? I'll run them through the grid
with p->recent_used_cpu changes on top to use recent_use_cpu as a search
hint instead of an idle candidate so that it scans for a core. They'll
take a while to run but it's automated and some people are going to be
dropping off for holidays relatively soon anyway. I can test on arm too
but as it does not have SMT enabled, it'll be less useful.

-- 
Mel Gorman
SUSE Labs
