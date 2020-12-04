Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9F2CF0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgLDPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:41:23 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:44885 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbgLDPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:41:23 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 05DF8C0DFA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 15:40:31 +0000 (GMT)
Received: (qmail 5873 invoked from network); 4 Dec 2020 15:40:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Dec 2020 15:40:30 -0000
Date:   Fri, 4 Dec 2020 15:40:29 +0000
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
Message-ID: <20201204154029.GC3371@techsingularity.net>
References: <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net>
 <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net>
 <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
 <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com>
 <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
 <20201204143115.GB3371@techsingularity.net>
 <CAKfTPtBXUK7NnhN1Rxeq-o5t-G+csN6Tj0yP=BSV_sdD1uZS0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBXUK7NnhN1Rxeq-o5t-G+csN6Tj0yP=BSV_sdD1uZS0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 04:23:48PM +0100, Vincent Guittot wrote:
> On Fri, 4 Dec 2020 at 15:31, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Dec 04, 2020 at 02:47:48PM +0100, Vincent Guittot wrote:
> > > > IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
> > > > If the target's sibling is removed from select_idle_mask from select_idle_core(),
> > > > select_idle_cpu() will lose the chance to pick it up?
> > >
> > > This is only relevant for patch 10 which is not to be included IIUC
> > > what mel said in cover letter : "Patches 9 and 10 are stupid in the
> > > context of this series."
> > >
> >
> > Patch 10 was stupid in the context of the prototype because
> > select_idle_core always returned a CPU. A variation ended up being
> > reintroduced at the end of the Series Yet To Be Posted so that SMT siblings
> > are cleared during select_idle_core() but select_idle_cpu() still has a
> > mask with unvisited CPUs to consider if no idle cores are found.
> >
> > As far as I know, this would still be compatible with Aubrey's idle
> > cpu mask as long as it's visited and cleared between select_idle_core
> > and select_idle_cpu. It relaxes the contraints on Aubrey to some extent
> > because the idle cpu mask would be a hint so if the information is out
> > of date, an idle cpu may still be found the normal way.
> 
> But even without patch 10, just replacing sched_domain_span(sd) by
> sds_idle_cpus(sd->shared) will ensure that sis loops only on cpus that
> get a chance to be idle so select_idle_core is likely to return an
> idle_candidate
> 

Yes but if the idle mask is out of date for any reason then idle CPUs might
be missed -- hence the intent to maintain a mask of CPUs visited and use
the idle cpu mask as a hint to prioritise CPUs that are likely idle but
fall back to a normal scan if none of the "idle cpu mask" CPUs are
actually idle.

-- 
Mel Gorman
SUSE Labs
