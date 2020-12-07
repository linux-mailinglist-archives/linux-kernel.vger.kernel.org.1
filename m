Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E872D1501
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgLGPnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:43:12 -0500
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:56139 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgLGPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:43:12 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 1ECE2FA88F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:42:19 +0000 (GMT)
Received: (qmail 27896 invoked from network); 7 Dec 2020 15:42:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Dec 2020 15:42:18 -0000
Date:   Mon, 7 Dec 2020 15:42:16 +0000
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
Subject: Re: [RFC PATCH 0/4] Reduce worst-case scanning of runqueues in
 select_idle_sibling
Message-ID: <20201207154216.GE3371@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <CAKfTPtC9At0Oej+u6-mtBdV6_vhFiNJGPQ-BFQc7RpUtDDixVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtC9At0Oej+u6-mtBdV6_vhFiNJGPQ-BFQc7RpUtDDixVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:04:41PM +0100, Vincent Guittot wrote:
> On Mon, 7 Dec 2020 at 10:15, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > This is a minimal series to reduce the amount of runqueue scanning in
> > select_idle_sibling in the worst case.
> >
> > Patch 1 removes SIS_AVG_CPU because it's unused.
> >
> > Patch 2 improves the hit rate of p->recent_used_cpu to reduce the amount
> >         of scanning. It should be relatively uncontroversial
> >
> > Patch 3-4 scans the runqueues in a single pass for select_idle_core()
> >         and select_idle_cpu() so runqueues are not scanned twice. It's
> >         a tradeoff because it benefits deep scans but introduces overhead
> >         for shallow scans.
> >
> > Even if patch 3-4 is rejected to allow more time for Aubrey's idle cpu mask
> 
> patch 3 looks fine and doesn't collide with Aubrey's work. But I don't
> like patch 4  which manipulates different cpumask including
> load_balance_mask out of LB and I prefer to wait for v6 of Aubrey's
> patchset which should fix the problem of possibly  scanning twice busy
> cpus in select_idle_core and select_idle_cpu
> 

Seems fair, we can see where we stand after V6 of Aubrey's work.  A lot
of the motivation for patch 4 would go away if we managed to avoid calling
select_idle_core() unnecessarily. As it stands, we can call it a lot from
hackbench even though the chance of getting an idle core are minimal.

Assuming I revisit it, I'll update the schedstat debug patches to include
the times select_idle_core() starts versus how many times it fails and
see can I think of a useful heuristic.

I'll wait for more review on patches 1-3 and if I hear nothing, I'll
resend just those.

Thanks Vincent.

-- 
Mel Gorman
SUSE Labs
