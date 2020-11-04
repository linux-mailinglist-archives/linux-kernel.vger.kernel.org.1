Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EB2A5E07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKDGKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:10:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:9224 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgKDGKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:10:14 -0500
IronPort-SDR: RU2vJsGukvnm2pAQ1GWwy1jp3CMbXwm/g9m64dV12uo78tvlJCC/cMEiw0AgSJ8i9gC8cWLcdj
 gNUhLUCaj3kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="187029556"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="187029556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 22:10:13 -0800
IronPort-SDR: CTlS8MEnIdbU1+0mOOm5HT8sn8pY6I3uLqexE2jIfLfZddLYwjNAfiLwZPkAQDPCmtXPihu2x+
 oynKxKbM+Mdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="325489767"
Received: from shbuild999.sh.intel.com ([10.239.147.98])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2020 22:10:10 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable zone only node 
Date:   Wed,  4 Nov 2020 14:10:08 +0800
Message-Id: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset tries to report a problem and get suggestion/review
for the RFC fix patches.

We recently got a OOM report, that when user try to bind a docker(container)
instance to a memory node which only has movable zones, and OOM killing
still can't solve the page allocation failure.

The callstack was:

	[ 1387.877565] runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
	[ 1387.877568] CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
	[ 1387.877569] Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
	[ 1387.877570] Call Trace:
	[ 1387.877579]  dump_stack+0x6b/0x88
	[ 1387.877584]  dump_header+0x4a/0x1e2
	[ 1387.877586]  oom_kill_process.cold+0xb/0x10
	[ 1387.877588]  out_of_memory.part.0+0xaf/0x230
	[ 1387.877591]  out_of_memory+0x3d/0x80
	[ 1387.877595]  __alloc_pages_slowpath.constprop.0+0x954/0xa20
	[ 1387.877599]  __alloc_pages_nodemask+0x2d3/0x300
	[ 1387.877602]  pipe_write+0x322/0x590
	[ 1387.877607]  new_sync_write+0x196/0x1b0
	[ 1387.877609]  vfs_write+0x1c3/0x1f0
	[ 1387.877611]  ksys_write+0xa7/0xe0
	[ 1387.877617]  do_syscall_64+0x52/0xd0
	[ 1387.877621]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The meminfo log only shows the movable only node, which has plenty
of free memory. And in our reproducing with 1/2 patch, the normal
node (has DMA/DMA32/Normal) also has lot of free memory when OOM
happens. 

If we hack to make this (GFP_HIGHUSER|__GFP_ACCOUNT) request get
a page, and following full docker run (like installing and running
'stress-ng' stress test) will see more allocation failures due to
different kinds of request(gfp_masks). And the 2/2 patch will detect
such cases that the allowed target nodes only have movable zones
and loose the binding check, otherwise it will trigger OOM while
the OOM won't do any help, as the problem is not lack of free memory.

Feng Tang (2):
  mm, oom: dump meminfo for all memory nodes
  mm, page_alloc: loose the node binding check to avoid helpless oom
    killing

 mm/oom_kill.c   |  2 +-
 mm/page_alloc.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.7.4

