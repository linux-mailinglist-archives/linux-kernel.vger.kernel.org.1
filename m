Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3631284A15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJFKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:03:39 -0400
Received: from outbound-smtp36.blacknight.com ([46.22.139.219]:58051 "EHLO
        outbound-smtp36.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgJFKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:03:39 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 6B98116D0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 11:03:37 +0100 (IST)
Received: (qmail 29118 invoked from network); 6 Oct 2020 10:03:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Oct 2020 10:03:36 -0000
Date:   Tue, 6 Oct 2020 11:03:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201006100334.GK3227@techsingularity.net>
References: <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090729.GU2628@hirez.programming.kicks-ass.net>
 <20201002094502.GD3227@techsingularity.net>
 <20201002095858.GN2611@hirez.programming.kicks-ass.net>
 <20201002101952.GE3227@techsingularity.net>
 <20201002144120.GI29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201002144120.GI29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 07:41:20AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 02, 2020 at 11:19:52AM +0100, Mel Gorman wrote:
> > On Fri, Oct 02, 2020 at 11:58:58AM +0200, Peter Zijlstra wrote:
> > > > It's enabled by default by enough distros that adding too many checks
> > > > is potentially painful. Granted it would be missed by most benchmarking
> > > > which tend to control allocations from userspace but a lot of performance
> > > > problems I see are the "death by a thousand cuts" variety.
> > > 
> > > Oh quite agreed, aka death by accounting. But if people are enabling
> > > DEBUG options in production kernels, there's something wrong, no?
> > > 
> > 
> > You'd think but historically I believe DEBUG_VM was enabled for some
> > distributions because it made certain classes of problems easier to debug
> > early. There is also a recent trend for enabling various DEBUG options for
> > "hardening" even when they protect very specific corner cases or are for
> > intended for kernel development. I've pushed back where I have an opinion
> > that matters but it's generally corrosive.
> > 
> > > Should we now go add CONFIG_REALLY_DEBUG_STAY_AWAY_ALREADY options?
> > 
> > It's heading in that direction :(
> 
> Given that you guys have just reiterated yet again that you are very
> unhappy with either a GFP_ flag or a special function like the one that
> Peter Zijlstra put together, it would be very helpful if you were to at
> least voice some level of support for Thomas Gleixner's patchset, which,
> if accepted, will allow me to solve at least 50% of the problem.
> 

I read through the series and didn't find anything problematic that
had not been covered already. Minimally, avoiding surprises about what
preemptible() means in different contexts is nice. While I have not
run it through a test grid to check, I'd be very surprised if this was
problematic from a performance perspective on a preempt-disabled kernels.
Last I checked, the difference between PREEMPT_NONE and PREEMPT_VOLUNTARY
was less than 2% *at worst* and I don't think that was due to the preempt
accounting.

-- 
Mel Gorman
SUSE Labs
