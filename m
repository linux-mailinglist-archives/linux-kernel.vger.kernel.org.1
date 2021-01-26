Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02341303A33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391962AbhAZK12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:27:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:55727 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732098AbhAZBbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:31:14 -0500
IronPort-SDR: n9mD0KFHC5p0HMpt6gev/faNbwYzc8Gt1v3vEWVR8tCj6i0R6JcqK3HNqMQdd/gEx+3fE+jH1T
 XLoFzAm79JkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159603685"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159603685"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:50 -0800
IronPort-SDR: SqQbFya8pBJyjCISCrzIQsncIzU0SYhJtTH0YCI0M9R0reNoVgJoG4XNXagfqux3P5ECijZwyv
 F3190jrHZ2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="429496854"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2021 16:41:50 -0800
Subject: [RFC][PATCH 10/13] mm/vmscan: add helper for querying ability to age anonymous pages
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:31 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003431.19BDC239@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Anonymous pages are kept on their own LRU(s).  These lists could theoretically
always be scanned and maintained.  But, without swap, there is currently
nothing the kernel can *do* with the results of a scanned, sorted LRU for
anonymous pages.

A check for '!total_swap_pages' currently serves as a valid check as to
whether anonymous LRUs should be maintained.  However, another method will
be added shortly: page demotion.

Abstract out the 'total_swap_pages' checks into a helper, give it a
logically significant name, and check for the possibility of page
demotion.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/vmscan.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~mm-vmscan-anon-can-be-aged mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-anon-can-be-aged	2021-01-25 16:23:17.044866690 -0800
+++ b/mm/vmscan.c	2021-01-25 16:23:17.053866690 -0800
@@ -2508,6 +2508,26 @@ out:
 	}
 }
 
+/*
+ * Anonymous LRU management is a waste if there is
+ * ultimately no way to reclaim the memory.
+ */
+bool anon_should_be_aged(struct lruvec *lruvec)
+{
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
+	/* Aging the anon LRU is valuable if swap is present: */
+	if (total_swap_pages > 0)
+		return true;
+
+	/* Also valuable if anon pages can be demoted: */
+	if (next_demotion_node(pgdat->node_id) >= 0)
+		return true;
+
+	/* No way to reclaim anon pages.  Should not age anon LRUs: */
+	return false;
+}
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
@@ -2617,7 +2637,8 @@ static void shrink_lruvec(struct lruvec
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
+	if (anon_should_be_aged(lruvec) &&
+	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -3446,10 +3467,11 @@ static void age_active_anon(struct pglis
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!total_swap_pages)
+	lruvec = mem_cgroup_lruvec(NULL, pgdat);
+
+	if (!anon_should_be_aged(lruvec))
 		return;
 
-	lruvec = mem_cgroup_lruvec(NULL, pgdat);
 	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		return;
 
_
