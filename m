Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732672AC006
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgKIPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:38:21 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:38901 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKIPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:38:21 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id F0F05FAC36
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:38:17 +0000 (GMT)
Received: (qmail 25473 invoked from network); 9 Nov 2020 15:38:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Nov 2020 15:38:17 -0000
Date:   Mon, 9 Nov 2020 15:38:15 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20201109153815.GH3371@techsingularity.net>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
 <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net>
 <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
 <20201106160010.GF3371@techsingularity.net>
 <20201109152411.GA610888@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201109152411.GA610888@lorien.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:24:11AM -0500, Phil Auld wrote:
> Hi,
> 
> On Fri, Nov 06, 2020 at 04:00:10PM +0000 Mel Gorman wrote:
> > On Fri, Nov 06, 2020 at 02:33:56PM +0100, Vincent Guittot wrote:
> > > On Fri, 6 Nov 2020 at 13:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > > On Wed, Nov 04, 2020 at 09:42:05AM +0000, Mel Gorman wrote:
> > > > > While it's possible that some other factor masked the impact of the patch,
> > > > > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > > > > indicates that if the patch was implemented against 5.10-rc2, it would
> > > > > likely not have been merged. I've queued the tests on the remaining
> > > > > machines to see if something more conclusive falls out.
> > > > >
> > > >
> > > > It's not as conclusive as I would like. fork_test generally benefits
> > > > across the board but I do not put much weight in that.
> > > >
> > > > Otherwise, it's workload and machine-specific.
> > > >
> > > > schbench: (wakeup latency sensitive), all machines benefitted from the
> > > >         revert at the low utilisation except one 2-socket haswell machine
> > > >         which showed higher variability when the machine was fully
> > > >         utilised.
> > > 
> > > There is a pending patch to should improve this bench:
> > > https://lore.kernel.org/patchwork/patch/1330614/
> > > 
> > 
> > Ok, I've slotted this one in with a bunch of other stuff I wanted to run
> > over the weekend. That particular patch was on my radar anyway. It just
> > got bumped up the schedule a little bit.
> >
> 
> 
> We've run some of our perf tests against various kernels in this thread.
> By default RHEL configs run with the performance governor.
> 

This aspect is somewhat critical because the patches affect CPU
selection. If a mostly idle CPU is used due to spreading load wider,
it can take longer to ramp up to the highest frequency. It can be a
dominating factor and may account for some of the differences.

Generally my tests are not based on the performance governor because a)
it's not a universal win and b) the powersave/ondemand govenors should
be able to function reasonably well. For short-lived workloads it may
not matter but ultimately schedutil should be good enough that it can
keep track of task utilisation after migrations and select appropriate
frequencies based on the tasks historical behaviour.

-- 
Mel Gorman
SUSE Labs
