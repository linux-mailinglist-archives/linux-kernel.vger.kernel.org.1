Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE672CF8A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgLEBeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLEBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607131965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jTvUFrxQWiUqEfxknBb6PlyyYdhO6u0npV1PbbB3Ds=;
        b=gfXBR9Xq4N1IrWS0QHGxURHVGy2OiFm6lLZHyEypO3HvR3FUUE+ZwZdgic8AugjIifXZxp
        88pzAS0aY9JCuOimwMSjQN83DD0i5WUoTkpkbZDonzcbm2a2Sj+GStY4zLDBolto5c7ze8
        W+IB469I9PT4pbAXATfK5MunFbb6jl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-U2eZw9SqNVqdS8MJp723pA-1; Fri, 04 Dec 2020 20:32:44 -0500
X-MC-Unique: U2eZw9SqNVqdS8MJp723pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52E4B809DC9;
        Sat,  5 Dec 2020 01:32:42 +0000 (UTC)
Received: from mail (ovpn-112-148.rdu2.redhat.com [10.10.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A743F5B4A0;
        Sat,  5 Dec 2020 01:32:38 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport Baoquan He <"rppt@kernel.orgbhe"@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mm: initialize struct pages in reserved regions outside of the zone ranges
Date:   Fri,  4 Dec 2020 20:32:38 -0500
Message-Id: <20201205013238.21663-2-aarcange@redhat.com>
In-Reply-To: <20201205013238.21663-1-aarcange@redhat.com>
References: <20201201181502.2340-1-rppt@kernel.org>
 <20201205013238.21663-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change, the pfn 0 isn't in any zone spanned range, and
it's also not in any memory.memblock range, so the struct page of pfn
0 wasn't initialized and the PagePoison remained set when
reserve_bootmem_region called __SetPageReserved, inducing a silent
boot failure with DEBUG_VM (and correctly so, because the crash
signaled the nodeid/nid of pfn 0 would be again wrong).

There's no enforcement that all memblock.reserved ranges must overlap
memblock.memory ranges, so the memblock.reserved ranges also require
an explicit initialization and the zones ranges need to be extended to
include all memblock.reserved ranges with struct pages too or they'll
be left uninitialized with PagePoison as it happened to pfn 0.

Fixes: 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 include/linux/memblock.h | 17 +++++++++---
 mm/debug.c               |  3 ++-
 mm/memblock.c            |  4 +--
 mm/page_alloc.c          | 57 ++++++++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ef131255cedc..c8e30cd69564 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -251,7 +251,8 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
-			  unsigned long *out_end_pfn, int *out_nid);
+			  unsigned long *out_end_pfn, int *out_nid,
+			  struct memblock_type *type);
 
 /**
  * for_each_mem_pfn_range - early memory pfn range iterator
@@ -263,9 +264,17 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
  *
  * Walks over configured memory ranges.
  */
-#define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		\
-	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
-	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
+#define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		  \
+	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.memory);		  \
+	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.memory))
+
+#define for_each_res_pfn_range(i, nid, p_start, p_end, p_nid)		  \
+	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.reserved);		  \
+	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.reserved))
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
diff --git a/mm/debug.c b/mm/debug.c
index ccca576b2899..6a1d534f5ffc 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -64,7 +64,8 @@ void __dump_page(struct page *page, const char *reason)
 	 * dump_page() when detected.
 	 */
 	if (page_poisoned) {
-		pr_warn("page:%px is uninitialized and poisoned", page);
+		pr_warn("page:%px pfn:%ld is uninitialized and poisoned",
+			page, page_to_pfn(page));
 		goto hex_only;
 	}
 
diff --git a/mm/memblock.c b/mm/memblock.c
index b68ee86788af..3964a5e8914f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1198,9 +1198,9 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
  */
 void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 				unsigned long *out_start_pfn,
-				unsigned long *out_end_pfn, int *out_nid)
+				unsigned long *out_end_pfn, int *out_nid,
+				struct memblock_type *type)
 {
-	struct memblock_type *type = &memblock.memory;
 	struct memblock_region *r;
 	int r_nid;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce2bdaabdf96..3eed49598d66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1458,6 +1458,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 {
 	pg_data_t *pgdat;
 	int nid, zid;
+	bool found = false;
 
 	if (!early_page_uninitialised(pfn))
 		return;
@@ -1468,10 +1469,15 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
-		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
+		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone)) {
+			found = true;
 			break;
+		}
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	if (likely(found))
+		__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	else
+		WARN_ON_ONCE(1);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -6227,7 +6233,7 @@ void __init __weak memmap_init(unsigned long size, int nid,
 			       unsigned long zone,
 			       unsigned long range_start_pfn)
 {
-	unsigned long start_pfn, end_pfn, next_pfn = 0;
+	unsigned long start_pfn, end_pfn, prev_pfn = 0;
 	unsigned long range_end_pfn = range_start_pfn + size;
 	u64 pgcnt = 0;
 	int i;
@@ -6235,7 +6241,7 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
 		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
-		next_pfn = clamp(next_pfn, range_start_pfn, range_end_pfn);
+		prev_pfn = clamp(prev_pfn, range_start_pfn, range_end_pfn);
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
@@ -6243,10 +6249,10 @@ void __init __weak memmap_init(unsigned long size, int nid,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 
-		if (next_pfn < start_pfn)
-			pgcnt += init_unavailable_range(next_pfn, start_pfn,
+		if (prev_pfn < start_pfn)
+			pgcnt += init_unavailable_range(prev_pfn, start_pfn,
 							zone, nid);
-		next_pfn = end_pfn;
+		prev_pfn = end_pfn;
 	}
 
 	/*
@@ -6256,12 +6262,31 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	 * considered initialized. Make sure that memmap has a well defined
 	 * state.
 	 */
-	if (next_pfn < range_end_pfn)
-		pgcnt += init_unavailable_range(next_pfn, range_end_pfn,
+	if (prev_pfn < range_end_pfn)
+		pgcnt += init_unavailable_range(prev_pfn, range_end_pfn,
 						zone, nid);
 
+	/*
+	 * memblock.reserved isn't enforced to overlap with
+	 * memblock.memory so initialize the struct pages for
+	 * memblock.reserved too in case it wasn't overlapping.
+	 *
+	 * If any struct page associated with a memblock.reserved
+	 * range isn't overlapping with a zone range, it'll be left
+	 * uninitialized, ideally with PagePoison, and it'll be a more
+	 * easily detectable error.
+	 */
+	for_each_res_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
+		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+
+		if (end_pfn > start_pfn)
+			pgcnt += init_unavailable_range(start_pfn, end_pfn,
+							zone, nid);
+	}
+
 	if (pgcnt)
-		pr_info("%s: Zeroed struct page in unavailable ranges: %lld\n",
+		pr_info("%s: pages in unavailable ranges: %lld\n",
 			zone_names[zone], pgcnt);
 }
 
@@ -6499,6 +6524,10 @@ void __init get_pfn_range_for_nid(unsigned int nid,
 		*start_pfn = min(*start_pfn, this_start_pfn);
 		*end_pfn = max(*end_pfn, this_end_pfn);
 	}
+	for_each_res_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
+		*start_pfn = min(*start_pfn, this_start_pfn);
+		*end_pfn = max(*end_pfn, this_end_pfn);
+	}
 
 	if (*start_pfn == -1UL)
 		*start_pfn = 0;
@@ -7126,7 +7155,13 @@ unsigned long __init node_map_pfn_alignment(void)
  */
 unsigned long __init find_min_pfn_with_active_regions(void)
 {
-	return PHYS_PFN(memblock_start_of_DRAM());
+	/*
+	 * reserved regions must be included so that their page
+	 * structure can be part of a zone and obtain a valid zoneid
+	 * before __SetPageReserved().
+	 */
+	return min(PHYS_PFN(memblock_start_of_DRAM()),
+		   PHYS_PFN(memblock.reserved.regions[0].base));
 }
 
 /*

