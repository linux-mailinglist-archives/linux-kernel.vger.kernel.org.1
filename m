Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540382CED16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgLDLbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:31:25 -0500
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:36317 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgLDLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:31:24 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 0596CFB9C2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 11:30:33 +0000 (GMT)
Received: (qmail 20093 invoked from network); 4 Dec 2020 11:30:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Dec 2020 11:30:32 -0000
Date:   Fri, 4 Dec 2020 11:30:30 +0000
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
Message-ID: <20201204113030.GZ3371@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net>
 <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net>
 <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
> > The intent was that the sibling might still be an idle candidate. In
> > the current draft of the series, I do not even clear this so that the
> > SMT sibling is considered as an idle candidate. The reasoning is that if
> > there are no idle cores then an SMT sibling of the target is as good an
> > idle CPU to select as any.
> 
> Isn't the purpose of select_idle_smt ?
> 

Only in part.

> select_idle_core() looks for an idle core and opportunistically saves
> an idle CPU candidate to skip select_idle_cpu. In this case this is
> useless loops for select_idle_core() because we are sure that the core
> is not idle
> 

If select_idle_core() finds an idle candidate other than the sibling,
it'll use it if there is no idle core -- it picks a busy sibling based
on a linear walk of the cpumask. Similarly, select_idle_cpu() is not
guaranteed to scan the sibling first (ordering) or even reach the sibling
(throttling). select_idle_smt() is a last-ditch effort.

-- 
Mel Gorman
SUSE Labs
