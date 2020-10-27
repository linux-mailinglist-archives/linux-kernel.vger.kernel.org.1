Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD88629A4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506737AbgJ0Gcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:32:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:9330 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506728AbgJ0Gcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:32:55 -0400
IronPort-SDR: vPAboqC/BklHk2VaiGJE5G0MQIqSCk6mfKmYbpiRED9Oln0QUu4RT7WsDcwCHvw4lxM1yJokIX
 FkMcc9tnxeDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147317852"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="147317852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:32:54 -0700
IronPort-SDR: MLrRYf6MDx88wDb+Pjg+TRX7VD+hlJUOxZEBW2k6nc/lSpHKDNdqgfUHVjQDHflqRQg4Jk8Z4y
 13IWVo4m4QFw==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="535666676"
Received: from lzhengha-mobl.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.213.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:32:51 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V4 0/6] autonuma: Optimize memory placement for memory tiering system
Date:   Tue, 27 Oct 2020 14:32:11 +0800
Message-Id: <20201027063217.211096-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of various new memory types, some machines will have
multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
memory subsystem of these machines can be called memory tiering
system, because the performance of the different types of memory are
usually different.

After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
for use like normal RAM"), the PMEM could be used as the
cost-effective volatile memory in separate NUMA nodes.  In a typical
memory tiering system, there are CPUs, DRAM and PMEM in each physical
NUMA node.  The CPUs and the DRAM will be put in one logical node,
while the PMEM will be put in another (faked) logical node.

To optimize the system overall performance, the hot pages should be
placed in DRAM node.  To do that, we need to identify the hot pages in
the PMEM node and migrate them to DRAM node via NUMA migration.

In the original AutoNUMA, there are already a set of existing
mechanisms to identify the pages recently accessed by the CPUs in a
node and migrate the pages to the node.  So we can reuse these
mechanisms to build the mechanisms to optimize the page placement in
the memory tiering system.  This has been implemented in this
patchset.

At the other hand, the cold pages should be placed in PMEM node.  So,
we also need to identify the cold pages in the DRAM node and migrate
them to PMEM node.

In the following patchset,

[RFC][PATCH 0/9] [v4][RESEND] Migrate Pages in lieu of discard
https://lore.kernel.org/linux-mm/20201007161736.ACC6E387@viggo.jf.intel.com/

A mechanism to demote the cold DRAM pages to PMEM node under memory
pressure is implemented.  Based on that, the cold DRAM pages can be
demoted to PMEM node proactively to free some memory space on DRAM
node.  And this frees the space on DRAM node for the hot PMEM pages to
be promoted to.  This has been implemented in this patchset too.

The patchset is based on the following not-yet-merged patchset,

[RFC][PATCH 0/9] [v4][RESEND] Migrate Pages in lieu of discard
https://lore.kernel.org/linux-mm/20201007161736.ACC6E387@viggo.jf.intel.com/

This is part of a larger patch set.  If you want to apply these or
play with them, I'd suggest using the tree from below,

https://github.com/hying-caritas/linux/commits/autonuma-r4

We have tested the solution with the pmbench memory accessing
benchmark with the 80:20 read/write ratio and the normal access
address distribution on a 2 socket Intel server with Optane DC
Persistent Memory Model.  The test results of the base kernel and step
by step optimizations are as follows,

                Throughput	Promotion      DRAM bandwidth
		  access/s           MB/s                MB/s
               -----------     ----------      --------------
Base            74238178.0                             4291.7
Patch 1        146050652.3          359.4             11248.6
Patch 2        146300787.1          355.2             11237.2
Patch 3        162536383.0          211.7             11890.4
Patch 4        157187775.0          105.9             10412.3
Patch 5        164028415.2           73.3             10810.6
Patch 6        162666229.4           74.6             10715.1

The whole patchset improves the benchmark score up to 119.1%.  The
basic AutoNUMA based optimization solution (patch 1), the hot page
selection algorithm (patch 3), and the threshold automatic adjustment
algorithms (patch 5) improves the performance or reduce the overhead
(promotion MB/s) mostly.

Changelog:

v4:

- Rebased on the latest page demotion patchset. (which bases on v5.9-rc6)

- Add page promotion counter.

v3:

- Move the rate limit control as late as possible per Mel Gorman's
  comments.

- Revise the hot page selection implementation to store page scan time
  in struct page.

- Code cleanup.

- Rebased on the latest page demotion patchset.

v2:

- Addressed comments for V1.

- Rebased on v5.5.

Huang Ying (6):
  autonuma: Optimize page placement for memory tiering system
  autonuma, memory tiering: Skip to scan fast memory
  autonuma, memory tiering: Hot page selection with hint page fault latency
  autonuma, memory tiering: Rate limit NUMA migration throughput
  autonuma, memory tiering: Adjust hot threshold automatically
  autonuma, memory tiering: Add page promotion counter

 include/linux/mm.h           |  29 ++++++++
 include/linux/mmzone.h       |  11 ++++
 include/linux/node.h         |   5 ++
 include/linux/sched/sysctl.h |  12 ++++
 kernel/sched/core.c          |   9 +--
 kernel/sched/fair.c          | 124 +++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              |  22 ++++++-
 mm/huge_memory.c             |  41 ++++++++----
 mm/memory.c                  |  11 +++-
 mm/migrate.c                 |  52 +++++++++++++--
 mm/mmzone.c                  |  17 +++++
 mm/mprotect.c                |  19 +++++-
 mm/vmscan.c                  |  15 +++++
 mm/vmstat.c                  |   4 ++
 14 files changed, 345 insertions(+), 26 deletions(-)

-- 
2.28.0
