Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66B43033F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAZFJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:09:53 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:51375 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhAYJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:32:31 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 8236037A967
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:59:10 +0000 (GMT)
Received: (qmail 12078 invoked from network); 25 Jan 2021 08:59:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 25 Jan 2021 08:59:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 0/4] Scan for an idle sibling in a single pass
Date:   Mon, 25 Jan 2021 08:59:05 +0000
Message-Id: <20210125085909.4600-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v3
o Drop scanning based on cores, SMT4 results showed problems

Changelog since v2
o Remove unnecessary parameters
o Update nr during scan only when scanning for cpus

Changlog since v1
o Move extern declaration to header for coding style
o Remove unnecessary parameter from __select_idle_cpu

This series of 4 patches reposts three patches from Peter entitled
"select_idle_sibling() wreckage". It only scans the runqueues in a single
pass when searching for an idle sibling.

Three patches from Peter were dropped. The first patch altered how scan
depth was calculated. Scan depth deletion is a random number generator
with two major limitations. The avg_idle time is based on the time
between a CPU going idle and being woken up clamped approximately by
2*sysctl_sched_migration_cost.  This is difficult to compare in a sensible
fashion to avg_scan_cost. The second issue is that only the avg_scan_cost
of scan failures is recorded and it does not decay.  This requires deeper
surgery that would justify a patch on its own although Peter notes that
https://lkml.kernel.org/r/20180530143105.977759909@infradead.org is
potentially useful for an alternative avg_idle metric.

The second patch dropped scanned based on cores instead of CPUs as it
rationalised the difference between core scanning and CPU scanning.
Unfortunately, Vincent reported problems with SMT4 so it's dropped
for now until depth searching can be fixed.

The third patch dropped converted the idle core scan throttling mechanism
to SIS_PROP. While this would unify the throttling of core and CPU
scanning, it was not free of regressions and has_idle_cores is a fairly
effective throttling mechanism with the caveat that it can have a lot of
false positives for workloads like hackbench.

Peter's series tried to solve three problems at once, this subset addresses
one problem.
losses but won more than it lost across a range of workloads and machines.

 kernel/sched/fair.c     | 153 +++++++++++++++++++---------------------
 kernel/sched/features.h |   1 -
 2 files changed, 72 insertions(+), 82 deletions(-)

-- 
2.26.2

