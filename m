Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3D303156
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbhAZBex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:34:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:61452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbhAZBaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:30:07 -0500
IronPort-SDR: Rww4iG1SFa21hnSe8BYlB/czxvygw8lp4eBXDe4B/jLN8yDh3y/wPhgI6Kzr0YRlKhIrKcidUj
 RIdHLQ7sZVAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179973463"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179973463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:37 -0800
IronPort-SDR: Ukmmbnc6CqfXFch4ltMxuPGJw/E8U/45bNuNGTcMcAPr5BRW+9xKntoI90jFmINg3J8IGQc83R
 bG64GajjAH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="429496797"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2021 16:41:37 -0800
Subject: [RFC][PATCH 03/13] mm/vmscan: replace implicit RECLAIM_ZONE checks with explicit checks
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        ben.widawsky@intel.com, cl@linux.com, alex.shi@linux.alibaba.com,
        tobin@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, dwagner@suse.de,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:17 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003417.72B4BCFB@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

RECLAIM_ZONE was assumed to be unused because it was never explicitly
used in the kernel.  However, there were a number of places where it
was checked implicitly by checking 'node_reclaim_mode' for a zero
value.

These zero checks are not great because it is not obvious what a zero
mode *means* in the code.  Replace them with a helper which makes it
more obvious: node_reclaim_enabled().

This helper also provides a handy place to explicitly check the
RECLAIM_ZONE bit itself.  Check it explicitly there to make it more
obvious where the bit can affect behavior.

This should have no functional impact.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: osalvador <osalvador@suse.de>

--

Note: This is not cc'd to stable.  It does not fix any bugs.
---

 b/include/linux/swap.h |    7 +++++++
 b/mm/khugepaged.c      |    2 +-
 b/mm/page_alloc.c      |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff -puN include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper include/linux/swap.h
--- a/include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper	2021-01-25 16:23:08.330866712 -0800
+++ b/include/linux/swap.h	2021-01-25 16:23:08.339866712 -0800
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <uapi/linux/mempolicy.h>
 #include <asm/page.h>
 
 struct notifier_block;
@@ -380,6 +381,12 @@ extern int sysctl_min_slab_ratio;
 #define node_reclaim_mode 0
 #endif
 
+static inline bool node_reclaim_enabled(void)
+{
+	/* Is any node_reclaim_mode bit set? */
+	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
+}
+
 extern void check_move_unevictable_pages(struct pagevec *pvec);
 
 extern int kswapd_run(int nid);
diff -puN mm/khugepaged.c~mm-vmscan-node_reclaim_mode_helper mm/khugepaged.c
--- a/mm/khugepaged.c~mm-vmscan-node_reclaim_mode_helper	2021-01-25 16:23:08.332866712 -0800
+++ b/mm/khugepaged.c	2021-01-25 16:23:08.340866712 -0800
@@ -797,7 +797,7 @@ static bool khugepaged_scan_abort(int ni
 	 * If node_reclaim_mode is disabled, then no extra effort is made to
 	 * allocate memory locally.
 	 */
-	if (!node_reclaim_mode)
+	if (!node_reclaim_enabled())
 		return false;
 
 	/* If there is a count for this node already, it must be acceptable */
diff -puN mm/page_alloc.c~mm-vmscan-node_reclaim_mode_helper mm/page_alloc.c
--- a/mm/page_alloc.c~mm-vmscan-node_reclaim_mode_helper	2021-01-25 16:23:08.335866712 -0800
+++ b/mm/page_alloc.c	2021-01-25 16:23:08.342866712 -0800
@@ -3875,7 +3875,7 @@ retry:
 			if (alloc_flags & ALLOC_NO_WATERMARKS)
 				goto try_this_zone;
 
-			if (node_reclaim_mode == 0 ||
+			if (!node_reclaim_enabled() ||
 			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
 				continue;
 
_
