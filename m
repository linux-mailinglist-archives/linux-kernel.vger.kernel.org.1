Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF1303A28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbhAZKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:24:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:43142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732001AbhAZB2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:28:04 -0500
IronPort-SDR: D/L+8cbkkC8zK9KfaBNPV5gk7j8XDlaFCZQ3XaWNvIbsiAEGsZDxVE28R7xE5rKoZd71Sv4VOr
 eXScGKYA0Wdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198609634"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="198609634"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:54 -0800
IronPort-SDR: yjZzL65jbf8kL4CjrDWZSh8ZXuZY8FWi/yazcxGLjzSlYBgqp5wBe4v2QEJ/yuGBbMmwgrs0PI
 HgI3BhCipgXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="361754925"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2021 16:41:54 -0800
Subject: [RFC][PATCH 12/13] mm/vmscan: never demote for memcg reclaim
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:34 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003434.BD7626A8@viggo.jf.intel.com>
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
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/vmscan.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff -puN mm/vmscan.c~never-demote-for-memcg-reclaim mm/vmscan.c
--- a/mm/vmscan.c~never-demote-for-memcg-reclaim	2021-01-25 16:23:19.180866685 -0800
+++ b/mm/vmscan.c	2021-01-25 16:23:19.185866685 -0800
@@ -290,7 +290,8 @@ static bool writeback_throttling_sane(st
 #endif
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-					  int node_id)
+					  int node_id,
+					  struct scan_control *sc)
 {
 	if (memcg == NULL) {
 		/*
@@ -328,7 +329,7 @@ unsigned long zone_reclaimable_pages(str
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -1065,7 +1066,8 @@ static enum page_references page_check_r
 	return PAGEREF_RECLAIM;
 }
 
-static bool migrate_demote_page_ok(struct page *page)
+static bool migrate_demote_page_ok(struct page *page,
+				   struct scan_control *sc)
 {
 	int next_nid = next_demotion_node(page_to_nid(page));
 
@@ -1073,6 +1075,10 @@ static bool migrate_demote_page_ok(struc
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/* It is pointless to do demotion in memcg reclaim */
+	if (cgroup_reclaim(sc))
+		return false;
+
 	if (next_nid == NUMA_NO_NODE)
 		return false;
 	if (PageTransHuge(page) && !thp_migration_supported())
@@ -1329,7 +1335,7 @@ retry:
 		 * Before reclaiming the page, try to relocate
 		 * its contents to another node.
 		 */
-		if (do_demote_pass && migrate_demote_page_ok(page)) {
+		if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
 			list_add(&page->lru, &demote_pages);
 			unlock_page(page);
 			continue;
@@ -2362,7 +2368,7 @@ static void get_scan_count(struct lruvec
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2737,7 +2743,7 @@ static inline bool should_continue_recla
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
_
