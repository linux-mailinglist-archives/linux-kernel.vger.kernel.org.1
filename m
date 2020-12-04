Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB942CEFB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgLDO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:27:56 -0500
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:46030 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgLDO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:27:56 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 02272BEEA6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 14:27:04 +0000 (GMT)
Received: (qmail 3026 invoked from network); 4 Dec 2020 14:27:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Dec 2020 14:27:03 -0000
Date:   Fri, 4 Dec 2020 14:27:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
Message-ID: <20201204142701.GA3371@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net>
 <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net>
 <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net>
 <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 02:17:20PM +0100, Vincent Guittot wrote:
> On Fri, 4 Dec 2020 at 14:13, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 4 Dec 2020 at 12:30, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
> > > > > The intent was that the sibling might still be an idle candidate. In
> > > > > the current draft of the series, I do not even clear this so that the
> > > > > SMT sibling is considered as an idle candidate. The reasoning is that if
> > > > > there are no idle cores then an SMT sibling of the target is as good an
> > > > > idle CPU to select as any.
> > > >
> > > > Isn't the purpose of select_idle_smt ?
> > > >
> > >
> > > Only in part.
> > >
> > > > select_idle_core() looks for an idle core and opportunistically saves
> > > > an idle CPU candidate to skip select_idle_cpu. In this case this is
> > > > useless loops for select_idle_core() because we are sure that the core
> > > > is not idle
> > > >
> > >
> > > If select_idle_core() finds an idle candidate other than the sibling,
> > > it'll use it if there is no idle core -- it picks a busy sibling based
> > > on a linear walk of the cpumask. Similarly, select_idle_cpu() is not
> >
> > My point is that it's a waste of time to loop the sibling cpus of
> > target in select_idle_core because it will not help to find an idle
> > core. The sibling  cpus will then be check either by select_idle_cpu
> > of select_idle_smt
> 

I understand and you're right, the full loop was in the context of a series
that unified select_idle_* where it made sense. The version I'm currently
testing aborts the SMT search if a !idle sibling is encountered. That
means that select_idle_core() will no longer scan the entire domain if
there are no idle cores.

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/commit/?h=sched-sissearch-v2r6&id=eb04a344cf7d7ca64c0c8fc0bcade261fa08c19e

With the patch on its own, it does mean that select_idle_sibling
starts over because SMT siblings might have been cleared. As an aside,
select_idle_core() has it's own problems even then.  It can start a scan
for an idle sibling when cpu_rq(target)->nr_running is very large --
over 100+ running tasks which is almost certainly a useless scan for
cores. However, I haven't done anything with that in this series as it
seemed like it would be follow-up work.

> also, while looping the cpumask, the sibling cpus of not idle cpu are
> removed and will not be check
> 

True and I spotted this. I think the load_balance_mask can be abused to
clear siblings during select_idle_core() while using select_idle_mask to
track CPUs that have not been scanned yet so select_idle_cpu only scans
CPUs that have not already been visited.

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/commit/?h=sched-sissearch-v2r6&id=a6e986dae38855e3be26dfde86bbef1617431dd1

As both the idle candidate and the load_balance_mask abuse are likely to
be controversial, I shuffled the series so that it's ordered from least
least controversial to most controversial.

This
https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/log/?h=sched-sissearch-v2r6
is what is currently being tested. It'll take most of the weekend and I'll
post them properly if they pass tests and do not throw up nasty surprises.

-- 
Mel Gorman
SUSE Labs
