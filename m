Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409D62F1A50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbhAKP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:58:57 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:56371 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731804AbhAKP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:58:56 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 6F8D61C34C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:58:05 +0000 (GMT)
Received: (qmail 15571 invoked from network); 11 Jan 2021 15:58:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Jan 2021 15:58:04 -0000
Date:   Mon, 11 Jan 2021 15:58:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20210111155802.GI3592@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
 <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net>
 <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
 <20210108161405.GE3592@techsingularity.net>
 <CAKfTPtAQuX5ZbzOH_LnFbBRWErP9pcnAVMvVE9qQw1LXouwzog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAQuX5ZbzOH_LnFbBRWErP9pcnAVMvVE9qQw1LXouwzog@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 03:36:57PM +0100, Vincent Guittot wrote:
> > > <SNIP>
> > >
> > > I think
> > > that we should decay it periodically to reflect there is less and less
> > > idle time (in fact no more)  on this busy CPU that never goes to idle.
> > > If a cpu was idle for a long period but then a long running task
> > > starts, the avg_idle will stay stalled to the large value which is
> > > becoming less and less relevant.
> >
> > While I get what you're saying, it does not help extrapolate what the
> > idleness of a domain is.
> 
> not but it gives a more up to date view of the idleness of the local
> cpu which is better than a stalled value
> 

Fair enough.

> >
> > > At the opposite, a cpu with a short running/idle period task will have
> > > a lower avg_idle whereas it is more often idle.
> > >
> > > Another thing that worries me, is that we use the avg_idle of the
> > > local cpu, which is obviously not idle otherwise it would have been
> > > selected, to decide how much time we should spend on looking for
> > > another idle CPU. I'm not sure that's the right metrics to use
> > > especially with a possibly stalled value.
> > >
> >
> > A better estimate requires heavy writes to sd_llc. The cost of that will
> > likely offset any benefit gained by a superior selection of a scan
> > depth.
> >
> > Treating a successful scan cost and a failed scan cost as being equal has
> > too many corner cases. If we do not want to weight the successful scan
> > cost, then the compromise is to keep the old behaviour that accounts for
> 
> I think that keeping the current way to scane_cost id the best option for now
> 

I sent a series that drops this patch for the moment as well as the
SIS_PROP for selecting a core.

-- 
Mel Gorman
SUSE Labs
