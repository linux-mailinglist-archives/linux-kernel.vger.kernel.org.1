Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66EC2A98F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKFQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:00:15 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:39781 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgKFQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:00:15 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id ADC921C356D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:00:12 +0000 (GMT)
Received: (qmail 13329 invoked from network); 6 Nov 2020 16:00:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Nov 2020 16:00:12 -0000
Date:   Fri, 6 Nov 2020 16:00:10 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
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
Message-ID: <20201106160010.GF3371@techsingularity.net>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
 <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net>
 <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 02:33:56PM +0100, Vincent Guittot wrote:
> On Fri, 6 Nov 2020 at 13:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Nov 04, 2020 at 09:42:05AM +0000, Mel Gorman wrote:
> > > While it's possible that some other factor masked the impact of the patch,
> > > the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> > > indicates that if the patch was implemented against 5.10-rc2, it would
> > > likely not have been merged. I've queued the tests on the remaining
> > > machines to see if something more conclusive falls out.
> > >
> >
> > It's not as conclusive as I would like. fork_test generally benefits
> > across the board but I do not put much weight in that.
> >
> > Otherwise, it's workload and machine-specific.
> >
> > schbench: (wakeup latency sensitive), all machines benefitted from the
> >         revert at the low utilisation except one 2-socket haswell machine
> >         which showed higher variability when the machine was fully
> >         utilised.
> 
> There is a pending patch to should improve this bench:
> https://lore.kernel.org/patchwork/patch/1330614/
> 

Ok, I've slotted this one in with a bunch of other stuff I wanted to run
over the weekend. That particular patch was on my radar anyway. It just
got bumped up the schedule a little bit.

> > hackbench: Neutral except for the same 2-socket Haswell machine which
> >         took an 8% performance penalty of 8% for smaller number of groups
> >         and 4% for higher number of groups.
> >
> > pipetest: Mostly neutral except for the *same* machine showing an 18%
> >         performance gain by reverting.
> >
> > kernbench: Shows small gains at low job counts across the board -- 0.84%
> >         lowest gain up to 5.93% depending on the machine
> >
> > gitsource: low utilisation execution of the git test suite. This was
> >         mostly a win for the revert. For the list of machines tested it was
> >
> >          14.48% gain (2 socket but SNC enabled to 4 NUMA nodes)
> >         neutral      (2 socket broadwell)
> >         36.37% gain  (1 socket skylake machine)
> >          3.18% gain  (2 socket broadwell)
> >          4.4%        (2 socket EPYC 2)
> >          1.85% gain  (2 socket EPYC 1)
> >
> > While it was clear-cut for 5.9, it's less clear-cut for 5.10-rc2 although
> > the gitsource shows some severe differences depending on the machine that
> > is worth being extremely cautious about. I would still prefer a revert
> > but I'm also extremely biased and I know there are other patches in the
> 
> This one from Julia can also impact
> 

Which one? I'm guessing "[PATCH v2] sched/fair: check for idle core"

-- 
Mel Gorman
SUSE Labs
