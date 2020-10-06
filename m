Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E858285378
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgJFUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:51:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:60236 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbgJFUva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:51:30 -0400
IronPort-SDR: VRG59dp0jwcp9RtpK60UOvuf5Hmtndn7xE9Rdyu7Td6zGBfDcZ3TSzp7eFNnufZMJX0NVSHeio
 qVRuQY2kTZvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="151614533"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="151614533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:51:29 -0700
IronPort-SDR: lvdcswvs2Czh1++3a7CvSrCSxRFOIzjRnCjL0HXPZEjTJM+K1D+cEJLdLkrCWATp19npwWeQkT
 kmedaXo1Ch3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="517436751"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2020 13:51:29 -0700
Subject: [RFC][PATCH 11/12] mm/vmscan: never demote for memcg reclaim
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 06 Oct 2020 13:51:25 -0700
References: <20201006205103.268F74A9@viggo.jf.intel.com>
In-Reply-To: <20201006205103.268F74A9@viggo.jf.intel.com>
Message-Id: <20201006205125.A02E6726@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Global reclaim aims to reduce the amount of memory used on
a given node or set of nodes.  Migrating pages to another
node serves this purpose.

memcg reclaim is different.  Its goal is to reduce the
total memory consumption of the entire memcg, across all
nodes.  Migration does not assist memcg reclaim because
it just moves page contents between nodes rather than
actually reducing memory consumption.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/mm/vmscan.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff -puN mm/vmscan.c~never-demote-for-memcg-reclaim mm/vmscan.c
--- a/mm/vmscan.c~never-demote-for-memcg-reclaim	2020-10-06 13:39:32.577818413 -0700
+++ b/mm/vmscan.c	2020-10-06 13:39:32.582818413 -0700
@@ -291,8 +291,11 @@ static bool writeback_throttling_sane(st
 #endif
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-					  int node_id)
+					  int node_id,
+					  struct scan_control *sc)
 {
+	bool in_cgroup_reclaim = false;
+
 	/* Always age anon pages when we have swap */
 	if (memcg == NULL) {
 		if (get_nr_swap_pages() > 0)
@@ -302,8 +305,18 @@ static inline bool can_reclaim_anon_page
 			return true;
 	}
 
-	/* Also age anon pages if we can auto-migrate them */
-	if (next_demotion_node(node_id) >= 0)
+	/* Can only be in memcg reclaim in paths with valid 'sc': */
+	if (sc && cgroup_reclaim(sc))
+		in_cgroup_reclaim = true;
+
+	/*
+	 * Also age anon pages if we can auto-migrate them.
+	 *
+	 * Migrating a page does not reduce comsumption of a
+	 * memcg so should not be performed when in memcg
+	 * reclaim.
+	 */
+	if (!in_cgroup_reclaim && (next_demotion_node(node_id) >= 0))
 		return true;
 
 	/* No way to reclaim anon pages */
@@ -321,7 +334,7 @@ unsigned long zone_reclaimable_pages(str
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -1064,6 +1077,10 @@ bool migrate_demote_page_ok(struct page
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/* It is pointless to do demotion in memcg reclaim */
+	if (cgroup_reclaim(sc))
+		return false;
+
 	if (next_nid == NUMA_NO_NODE)
 		return false;
 	if (PageTransHuge(page) && !thp_migration_supported())
@@ -2368,7 +2385,7 @@ static void get_scan_count(struct lruvec
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2653,7 +2670,7 @@ static void shrink_lruvec(struct lruvec
 	 * rebalance the anon lru active/inactive ratio.
 	 */
 	if (can_reclaim_anon_pages(lruvec_memcg(lruvec),
-			       lruvec_pgdat(lruvec)->node_id) &&
+			       lruvec_pgdat(lruvec)->node_id, sc) &&
 	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
@@ -2724,7 +2741,7 @@ static inline bool should_continue_recla
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
@@ -3483,7 +3500,7 @@ static void age_active_anon(struct pglis
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (!can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		return;
 
 	lruvec = mem_cgroup_lruvec(NULL, pgdat);
_
