Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7D285374
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgJFUvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:51:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:27136 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgJFUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:51:15 -0400
IronPort-SDR: j5p73I4hSQrNQB/jcYmhdIv4insEGKsU87yFoWPWjBm5l0u2YEfgmm2gSIKckm32bApLRdqvsW
 hvNyRkmFSXZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="249395727"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="249395727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:51:14 -0700
IronPort-SDR: 07FE8k4bQQiGdvF6iwrVvb6rTSKDHf8z7w4/FPh2mCU63yE8rm68z1SZkwYipXs7aIWWo8cD1t
 WEen5JSIOKCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527582393"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 06 Oct 2020 13:51:14 -0700
Subject: [RFC][PATCH 03/12] mm/vmscan: replace implicit RECLAIM_ZONE checks with explicit checks
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, ben.widawsky@intel.com,
        alex.shi@linux.alibaba.com, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, dwagner@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 06 Oct 2020 13:51:10 -0700
References: <20201006205103.268F74A9@viggo.jf.intel.com>
In-Reply-To: <20201006205103.268F74A9@viggo.jf.intel.com>
Message-Id: <20201006205110.1E03E385@viggo.jf.intel.com>
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
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Daniel Wagner <dwagner@suse.de>

--

Note: This is not cc'd to stable.  It does not fix any bugs.
---

 b/include/linux/swap.h |    7 +++++++
 b/mm/khugepaged.c      |    2 +-
 b/mm/page_alloc.c      |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff -puN include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper include/linux/swap.h
--- a/include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper	2020-10-06 13:39:22.850818437 -0700
+++ b/include/linux/swap.h	2020-10-06 13:39:22.859818437 -0700
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <uapi/linux/mempolicy.h>
 #include <asm/page.h>
 
 struct notifier_block;
@@ -381,6 +382,12 @@ extern int sysctl_min_slab_ratio;
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
--- a/mm/khugepaged.c~mm-vmscan-node_reclaim_mode_helper	2020-10-06 13:39:22.852818437 -0700
+++ b/mm/khugepaged.c	2020-10-06 13:39:22.859818437 -0700
@@ -794,7 +794,7 @@ static bool khugepaged_scan_abort(int ni
 	 * If node_reclaim_mode is disabled, then no extra effort is made to
 	 * allocate memory locally.
 	 */
-	if (!node_reclaim_mode)
+	if (!node_reclaim_enabled())
 		return false;
 
 	/* If there is a count for this node already, it must be acceptable */
diff -puN mm/page_alloc.c~mm-vmscan-node_reclaim_mode_helper mm/page_alloc.c
--- a/mm/page_alloc.c~mm-vmscan-node_reclaim_mode_helper	2020-10-06 13:39:22.855818437 -0700
+++ b/mm/page_alloc.c	2020-10-06 13:39:22.862818437 -0700
@@ -3802,7 +3802,7 @@ retry:
 			if (alloc_flags & ALLOC_NO_WATERMARKS)
 				goto try_this_zone;
 
-			if (node_reclaim_mode == 0 ||
+			if (!node_reclaim_enabled() ||
 			    !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
 				continue;
 
_
