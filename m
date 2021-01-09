Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE42F0072
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 15:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbhAIOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 09:12:57 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:51697 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbhAIOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 09:12:57 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 4BEE61C3F74
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 14:12:05 +0000 (GMT)
Received: (qmail 22975 invoked from network); 9 Jan 2021 14:12:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2021 14:12:05 -0000
Date:   Sat, 9 Jan 2021 14:12:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20210109141203.GG3592@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
 <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net>
 <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
 <X/i2aIKmeyi5SZ7g@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <X/i2aIKmeyi5SZ7g@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 08:45:44PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 08, 2021 at 04:10:51PM +0100, Vincent Guittot wrote:
> > Also, there is another problem (that I'm investigating)  which is that
> > this_rq()->avg_idle is stalled when your cpu is busy. Which means that
> > this avg_idle can just be a very old and meaningless value. I think
> > that we should decay it periodically to reflect there is less and less
> 
> https://lkml.kernel.org/r/20180530143105.977759909@infradead.org
> 
> :-)

This needs to be revived. I'm of the opinion that your initial series
needs to be split somewhat into "single scan for core" parts followed by
the "Fix depth selection". I have tests in the queue and one of them is
just patch 2 on its own. Preliminary results for patch 2 on its own do not
look bad but that's based on one test (tbench). It'll be tomorrow before
it works through variants of patch 1 which I suspect will be inconclusive
and make me more convinced it should be split out separately.

The single scan for core would be patches 2-4 of the series this thread
is about which is an orthogonal problem to avoiding repeated scans of
the same runqueues during a single wakeup. I would prefer to drop patch
5 initially because the has_idle_cores throttling mechanism for idle core
searches is reasonably effective and the first round of tests indicated
that changing it was inconclusive and should be treated separately.

The depth scan stuff would go on top because right now the depth scan is
based on magic numbers and no amount of shuffling that around will make
it less magic without an avg_idle value that decays and potentially the
scan cost also aging.  It's much less straight-forward than the single
scan aspect.

Switching idle core searches to SIS_PROP should also be treated
separately.

Thoughts? I don't want to go too far in this direction on my own because
the testing requirements are severe in terms of time. Even then no matter
how much I test, stuff will be missed as it's sensitive to domain sizes,
CPU generation, cache topology, cache characteristics, domain utilisation,
architecture, kitchen sink etc.

-- 
Mel Gorman
SUSE Labs
