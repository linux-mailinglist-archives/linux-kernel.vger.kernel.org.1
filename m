Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B122DAC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgLOLqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:46:20 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:46201 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728737AbgLOLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:46:03 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 23877FA92D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 11:45:09 +0000 (GMT)
Received: (qmail 25090 invoked from network); 15 Dec 2020 11:45:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Dec 2020 11:45:08 -0000
Date:   Tue, 15 Dec 2020 11:45:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20201215114506.GB3371@techsingularity.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201215075911.GA3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:59:11AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 15, 2020 at 11:36:35AM +0800, Li, Aubrey wrote:
> > On 2020/12/15 0:48, Peter Zijlstra wrote:
> > > We compute the average cost of the total scan, but then use it as a
> > > per-cpu scan cost when computing the scan proportion. Fix this by
> > > properly computing a per-cpu scan cost.
> > > 
> > > This also fixes a bug where we would terminate early (!--nr, case) and
> > > not account that cost at all.
> > 
> > I'm a bit worried this may introduce a regression under heavy load.
> > The overhead of adding another cpu_clock() and calculation becomes 
> > significant when sis_scan is throttled by nr.
> 
> The thing is, the code as it exists today makes no sense what so ever.

Which makes it very hard to reason about or change in a "safe" manner as
all sorts of counter-intuitive effects occur.

The series is queued and running and takes 1-2 days. I haven't reviewed
the patches properly (holiday) but it'll be interesting to get some
provisional data at least.

-- 
Mel Gorman
SUSE Labs
