Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608832FB7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbhASLeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:34:25 -0500
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:36659 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389830AbhASLXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:23:08 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 03FAB2DCD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:22:12 +0000 (GMT)
Received: (qmail 4565 invoked from network); 19 Jan 2021 11:22:11 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Jan 2021 11:22:11 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 0/5] Scan for an idle sibling in a single pass
Date:   Tue, 19 Jan 2021 11:22:06 +0000
Message-Id: <20210119112211.3196-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v2
o Remove unnecessary parameters
o Update nr during scan only when scanning for cpus

Changlog since v1
o Move extern declaration to header for coding style
o Remove unnecessary parameter from __select_idle_cpu

This series of 5 patches reposts three patches from Peter entitled
"select_idle_sibling() wreckage". It only scans the runqueues in a single
pass when searching for an idle sibling.

Two patches from Peter were dropped. The first patch altered how scan
depth was calculated. Scan depth deletion is a random number generator
with two major limitations. The avg_idle time is based on the time
between a CPU going idle and being woken up clamped approximately by
2*sysctl_sched_migration_cost.  This is difficult to compare in a sensible
fashion to avg_scan_cost. The second issue is that only the avg_scan_cost
of scan failures is recorded and it does not decay.  This requires deeper
surgery that would justify a patch on its own although Peter notes that
https://lkml.kernel.org/r/20180530143105.977759909@infradead.org is
potentially useful for an alternative avg_idle metric.

The second patch dropped converted the idle core scan throttling
mechanism to SIS_PROP. While this would unify the throttling of core
and CPU scanning, it was not free of regressions and has_idle_cores is
a fairly effective throttling mechanism with the caveat that it can have
a lot of false positives for workloads like hackbench.

Peter's series tried to solve three problems at once, this subset addresses
one problem. As with anything select_idle_sibling, it's a mix of wins and
losses but won more than it lost across a range of workloads and machines.

 kernel/sched/core.c     |  18 +++--
 kernel/sched/fair.c     | 161 ++++++++++++++++++++--------------------
 kernel/sched/features.h |   1 -
 kernel/sched/sched.h    |   2 +
 4 files changed, 95 insertions(+), 87 deletions(-)

-- 
2.26.2

