Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F822CD8A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbgLCOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:18 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:43643 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgLCOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id B85341C370E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:24 +0000 (GMT)
Received: (qmail 22633 invoked from network); 3 Dec 2020 14:11:24 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 3 Dec 2020 14:11:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 00/10] Reduce time complexity of select_idle_sibling
Date:   Thu,  3 Dec 2020 14:11:14 +0000
Message-Id: <20201203141124.7391-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an early prototype that has not been tested heavily. While parts
of it may stand on its own, the motivation to release early is Aubrey
Li's series on using an idle cpumask to optimise the search and Barry
Song's series on representing clusters on die. The series is based on
tip/sched/core rebased to 5.10-rc6.

Patches 1-2 add schedstats to track the search efficiency of
	select_idle_sibling. They can be dropped from the final version but
	are useful when looking at select_idle_sibling in general. MMTests
	can already parse the stats and generate useful data including
	graphs over time.

Patch 3 kills SIS_AVG_CPU but is partially reintroduced later in the
	context of SIS_PROP.

Patch 4 notes that select_idle_core() can find an idle CPU that is
	not a free core yet it is ignored and a second search is conducted
	in select_idle_cpu() which is wasteful. Note that this patch
	will definitely change in the final version.

Patch 5 adjusts p->recent_used_cpu so that it has a higher success rate
	and avoids searching the domain in some cases.

Patch 6 notes that select_idle_* always starts with a CPU that is
	definitely not idle and fixes that.

Patch 7 notes that SIS_PROP is only partially accounting for search
	costs. While this might be accidentally beneficial, it makes it
	much harder to reason about the effectiveness of SIS_PROP.

Patch 8 uses similar logic to SIS_AVG_CPU but in the context of
	SIS_PROP to throttle the search depth.

Patches 9 and 10 are stupid in the context of this series. They
	are included even though it makes no sense to use SIS_PROP logic in
	select_idle_core() as it already has throttling logic. The point
	is to illustrate that the select_idle_mask can be initialised
	at the start of a domain search used to mask out CPUs that have
	already been visited.

In the context of Aubrey's and Barry's work, select_idle_mask would
be initialised *after* select_idle_core as select_idle_core uses
select_idle_mask for its own purposes. In Aubrey's case, the next
step would be to scan idle_cpus_span as those CPUs may still be idle
and bias the search towards likely idle candidates. If that fails,
select_idle_mask clears all the bits set in idle_cpus_span and then
scans the remainder. Similar observations apply to Barry's work, scan the
local domain first, mask out those bits then scan the remaining CPUs in
the cluster.

The final version of this series will drop patches 1-2 unless there is
demand and definitely drop patches 9-10. However, all 4 patches may be
useful in the context of Aubrey's and Barry's work. Patches 1-2 would
give more precise results on exactly how much they are improving "SIS
Domain Search Efficiency" which may be more illustrative than just the
headline performance figures of a given workload. The final version of
this series will also adjust patch 4. If select_idle_core() runs at all
then it definitely should return a CPU -- either an idle CPU or the target
as it has already searched the entire domain and no further searching
should be conducted. Barry might change that back so that a cluster can
be scanned but it would be done in the context of the cluster series.

-- 
2.26.2

