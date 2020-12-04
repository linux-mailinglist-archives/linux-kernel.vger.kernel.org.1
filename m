Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DFE2CF43C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLDSly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:41:54 -0500
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:57405 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:41:54 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 80CF61EF4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 18:41:02 +0000 (GMT)
Received: (qmail 32155 invoked from network); 4 Dec 2020 18:41:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Dec 2020 18:41:02 -0000
Date:   Fri, 4 Dec 2020 18:41:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
Message-ID: <20201204184100.GD3371@techsingularity.net>
References: <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net>
 <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
 <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com>
 <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
 <20201204143115.GB3371@techsingularity.net>
 <CAKfTPtBXUK7NnhN1Rxeq-o5t-G+csN6Tj0yP=BSV_sdD1uZS0g@mail.gmail.com>
 <20201204154029.GC3371@techsingularity.net>
 <CAKfTPtDX1wGWD3bEC=YZ74uvKGmkHPf3rLobr_wGy7MSFwtcdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDX1wGWD3bEC=YZ74uvKGmkHPf3rLobr_wGy7MSFwtcdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 04:43:05PM +0100, Vincent Guittot wrote:
> On Fri, 4 Dec 2020 at 16:40, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Dec 04, 2020 at 04:23:48PM +0100, Vincent Guittot wrote:
> > > On Fri, 4 Dec 2020 at 15:31, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > > On Fri, Dec 04, 2020 at 02:47:48PM +0100, Vincent Guittot wrote:
> > > > > > IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
> > > > > > If the target's sibling is removed from select_idle_mask from select_idle_core(),
> > > > > > select_idle_cpu() will lose the chance to pick it up?
> > > > >
> > > > > This is only relevant for patch 10 which is not to be included IIUC
> > > > > what mel said in cover letter : "Patches 9 and 10 are stupid in the
> > > > > context of this series."
> > > > >
> > > >
> > > > Patch 10 was stupid in the context of the prototype because
> > > > select_idle_core always returned a CPU. A variation ended up being
> > > > reintroduced at the end of the Series Yet To Be Posted so that SMT siblings
> > > > are cleared during select_idle_core() but select_idle_cpu() still has a
> > > > mask with unvisited CPUs to consider if no idle cores are found.
> > > >
> > > > As far as I know, this would still be compatible with Aubrey's idle
> > > > cpu mask as long as it's visited and cleared between select_idle_core
> > > > and select_idle_cpu. It relaxes the contraints on Aubrey to some extent
> > > > because the idle cpu mask would be a hint so if the information is out
> > > > of date, an idle cpu may still be found the normal way.
> > >
> > > But even without patch 10, just replacing sched_domain_span(sd) by
> > > sds_idle_cpus(sd->shared) will ensure that sis loops only on cpus that
> > > get a chance to be idle so select_idle_core is likely to return an
> > > idle_candidate
> > >
> >
> > Yes but if the idle mask is out of date for any reason then idle CPUs might
> 
> In fact it's the opposite, a cpu in idle mask might not be idle but
> all cpus that enter idle will be set
> 

When I first checked, the information was based on the tick or a CPU
stopping the tick. That was not guaranteed to be up to date so I considered
the best option would be to treat idle cpu mask as advisory. It would
not necessarily cover a CPU that was entering idle and polling before
entering an idle state for example or a rq that would pass sched_idle_cpu()
depending on the timing of the update_idle_cpumask call.

I know you reviewed that patch and v6 may be very different but the more
up to date that information is, the greater the cache conflicts will be
on sched_domain_shared so maintaining the up-to-date information may cost
enough to offset any benefit from reduced searching at wakeup.

If this turns out to be wrong, then great, the idle cpu mask can be used
as both the basis for an idle core search and a fast find of an individual
CPU. If the cost of keeping up to date information is too high then the
idle_cpu_mask can be treated as advisory to start the search and track
CPUs visited.

The series are not either/or, chunks of the series I posted are orthogonal
(e.g. changes to p->recent_cpu_used), the latter parts could either work
with idle cpu mask or be replaced by idle cpu mask depending on which
performs better.

-- 
Mel Gorman
SUSE Labs
