Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756792D73E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390870AbgLKKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:25:48 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:34059 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728893AbgLKKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:25:01 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 874AB19F6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:23:59 +0000 (GMT)
Received: (qmail 11456 invoked from network); 11 Dec 2020 10:23:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Dec 2020 10:23:59 -0000
Date:   Fri, 11 Dec 2020 10:23:57 +0000
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
Message-ID: <20201211102357.GW3371@techsingularity.net>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201209143748.GP3371@techsingularity.net>
 <CAKfTPtCToad1ZwMRi28iC=MQ2D+vnTBLKBU+UOBanTWnuQQzRA@mail.gmail.com>
 <CAKfTPtBigdckTCpYyVD9R0U9Mm+ENX7BJ3gqrTkPW3m64iPCVA@mail.gmail.com>
 <20201210110424.GR3371@techsingularity.net>
 <CAKfTPtCoTD84kWhj5S-2LokcTLanewX8BvjHCN1qucutDOTuzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCoTD84kWhj5S-2LokcTLanewX8BvjHCN1qucutDOTuzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:51:17AM +0100, Vincent Guittot wrote:
> On Thu, 10 Dec 2020 at 12:04, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Dec 10, 2020 at 10:38:37AM +0100, Vincent Guittot wrote:
> > > > while testing your patchset and Aubrey one on top of tip, I'm facing
> > > > some perf regression on my arm64 numa system on hackbench and reaim.
> > > > The regression seems to comes from your patchset but i don't know
> > > > which patch in particular yet
> > > >
> > > > hackbench -l 256000 -g 1
> > > >
> > > > v5.10-rc7 + tip/sched/core 13,255(+/- 3.22%)
> > > > with your patchset         15.368(+/- 2.74)  -15.9%
> > > >
> > > > I'm also seeing perf regression on reaim but this one needs more
> > > > investigation before confirming
> > > >
> > > > TBH, I was not expecting regressions. I'm running more test to find
> > > > which patch is the culprit
> > >
> > > The regression comes from patch 3: sched/fair: Do not replace
> > > recent_used_cpu with the new target
> > >
> >
> > That's not entirely surprising. The intent of the patch is to increase the
> > hit rate of p->recent_used_cpu but it's not a guaranteed win due to two
> > corner cases. If multiple tasks have the same p->recent_used_cpu, they can
> > race to use that CPU and stack as a result instead of searching the domain.
> > If SMT is enabled then p->recent_used_cpu can point to an idle CPU that has
> > a busy sibling which the search would have avoided in select_idle_core().
> >
> > I think you are using processes and sockets for hackbench but as you'll
> > see later, hackbench can be used both to show losses and gains.
> 
> I run more hackbench tests with pipe and socket and both show
> regression with patch 3 whereas this is significant improvement with
> other patches and Aubrey's one
> 

Is SMT enabled on your test machine? If not, then patch 4 should make no
difference but if SMT is enabled, I wonder how this untested version of
patch 3 behaves for you. The main difference is that the recent used cpu
is used as a search target so that it would still check if it's an idle
core and if not, fall through so it's used as an idle CPU after checking
it's allowed by p->cpus_ptr.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c41875aec23..63980bcf6e70 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6275,21 +6275,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return prev;
 	}
 
-	/* Check a recently used CPU as a potential idle candidate: */
+	/* Check a recently used CPU as a search target: */
 	recent_used_cpu = p->recent_used_cpu;
+	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
-		return recent_used_cpu;
-	}
+	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)))
+		target = recent_used_cpu;
 
 	/*
 	 * For asymmetric CPU capacity systems, our domain of interest is
@@ -6768,9 +6761,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-
-		if (want_affine)
-			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 

-- 
Mel Gorman
SUSE Labs
